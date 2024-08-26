<?php

namespace App\Http\Controllers;

use App\Models\Roles;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class UserController extends Controller
{

    /**
     * Display the specified resource.
     */
    public function show(string $id): JsonResponse
    {
        $user = User::find($id);

        if($user == Null){
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve records. Could not find user with id ' . $id,
                'data' => []
            ], status: 404);
        }

        return response()->json([
            'success' => true,
            'message' => 'User records ready',
            'data' => $user
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id): JsonResponse
    {
        $validated = $request->validate([
            'name' => 'required|max:255',
            'email' => 'required|email',
            'role_id' => 'required|in:1,2,3|integer',
            'subscription_plan' => 'required|string|in:free,premium'
        ]);

        $user = User::find($id);
        if($user == Null){
            return response()->json([
                'success' => false,
                'message' => 'Failed to update records. Could not find user with id ' . $id,
                'data' => [
                    'user_data' => []
                ]
            ], status: 404);
        }

        $user->update($validated);
        return response()->json([
            'success' => true,
            'message' => 'User records successfully updated',
            'data' => [
                'user_data' => $user
            ]
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $user = User::find($id);

//        if ($user == Null){
//            return response()->json([
//                'success' => false,
//                'message' => 'Could not find user with id ' . $id,
//                'data' => []
//            ]);
//        }
//        $user->delete();

        return response()->json([
            'success' => false,
            'message' => 'Resource not yet available',
            'data' => []
        ]);
    }
}
