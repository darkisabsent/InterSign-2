<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class UserChangePassword extends Controller
{
    public function __invoke(Request $request): JsonResponse
    {
        $request->validate([
            'confirm_old_password' => 'required|min:8',
            'password' => 'required|min:8',
        ]);

        $user = Auth::user();

        if(!Hash::check($request->confirm_old_password, $user->password)){
            return response()->json([
                'success' => false,
                'message' => 'Your passwords do not match.'
            ],401);
        }
        $password = [
            'password' => Hash::make($request->password)
        ];
        $user->update($password);

        return response()->json([
            'success' => true,
            'message' => 'Password reset successful',
            'data' => [
                'user_data' => []
            ]
        ]);
    }
}
