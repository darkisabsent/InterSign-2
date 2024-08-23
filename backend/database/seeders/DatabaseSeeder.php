<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use App\Models\Roles;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
         User::factory(50)->create();

        User::factory()->create([
            'name' => 'John Doe',
            'email' => 'dev@example.com',
            'password' => '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', # password = password
            'role_id' => 1, # developer
        ]);

        User::factory()->create([
            'name' => 'Maxwell Jackson',
            'email' => 'max@example.com',
            'password' => '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', # password = password
            'role_id' => 2, # administrator
        ]);

        DB::table('roles')->insert([
            ['role' => 'developer'],
            ['role'=> 'administrator'],
            ['role' => 'customer']
        ]);
    }
}
