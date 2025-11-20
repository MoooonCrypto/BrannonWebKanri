export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      profiles: {
        Row: {
          id: string
          full_name: string | null
          avatar_url: string | null
          updated_at: string
        }
        Insert: {
          id: string
          full_name?: string | null
          avatar_url?: string | null
          updated_at?: string
        }
        Update: {
          id?: string
          full_name?: string | null
          avatar_url?: string | null
          updated_at?: string
        }
      }
      landing_pages: {
        Row: {
          id: string
          user_id: string
          title: string
          slug: string
          settings: Json
          is_published: boolean
          published_at: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id: string
          title: string
          slug: string
          settings?: Json
          is_published?: boolean
          published_at?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          title?: string
          slug?: string
          settings?: Json
          is_published?: boolean
          published_at?: string | null
          created_at?: string
          updated_at?: string
        }
      }
      lp_sections: {
        Row: {
          id: string
          landing_page_id: string
          section_type: string
          order_index: number
          content: Json
          styles: Json
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          landing_page_id: string
          section_type: string
          order_index: number
          content?: Json
          styles?: Json
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          landing_page_id?: string
          section_type?: string
          order_index?: number
          content?: Json
          styles?: Json
          created_at?: string
          updated_at?: string
        }
      }
      social_accounts: {
        Row: {
          id: string
          user_id: string
          platform: string
          account_id: string
          account_name: string
          account_username: string | null
          access_token: string
          refresh_token: string | null
          token_expires_at: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id: string
          platform: string
          account_id: string
          account_name: string
          account_username?: string | null
          access_token: string
          refresh_token?: string | null
          token_expires_at?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          platform?: string
          account_id?: string
          account_name?: string
          account_username?: string | null
          access_token?: string
          refresh_token?: string | null
          token_expires_at?: string | null
          created_at?: string
          updated_at?: string
        }
      }
      social_posts: {
        Row: {
          id: string
          user_id: string
          social_account_id: string
          status: string
          content: string
          media_urls: Json
          scheduled_at: string | null
          published_at: string | null
          external_id: string | null
          metrics: Json | null
          error_message: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id: string
          social_account_id: string
          status?: string
          content: string
          media_urls?: Json
          scheduled_at?: string | null
          published_at?: string | null
          external_id?: string | null
          metrics?: Json | null
          error_message?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          social_account_id?: string
          status?: string
          content?: string
          media_urls?: Json
          scheduled_at?: string | null
          published_at?: string | null
          external_id?: string | null
          metrics?: Json | null
          error_message?: string | null
          created_at?: string
          updated_at?: string
        }
      }
      media: {
        Row: {
          id: string
          user_id: string
          file_name: string
          file_path: string
          file_type: string
          file_size: number
          width: number | null
          height: number | null
          metadata: Json
          created_at: string
        }
        Insert: {
          id?: string
          user_id: string
          file_name: string
          file_path: string
          file_type: string
          file_size: number
          width?: number | null
          height?: number | null
          metadata?: Json
          created_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          file_name?: string
          file_path?: string
          file_type?: string
          file_size?: number
          width?: number | null
          height?: number | null
          metadata?: Json
          created_at?: string
        }
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
  }
}
