import 'package:flutter/material.dart';

class MoneyHeistDetailsScreen extends StatelessWidget {
  const MoneyHeistDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      body: Stack(
        children: [
          // 1. Background Image/Video Placeholder
          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/money_heist_bg.jpg', // Ensure you have this image in your assets folder
          //     fit: BoxFit.cover,
          //     alignment: Alignment.topCenter,
          //   ),
          // ),
          // Gradient overlay for better text readability
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.2), // Slight gradient for image
                    Colors.black.withOpacity(0.8), // Stronger gradient at bottom
                    Colors.black, // Full black at the very bottom
                  ],
                  stops: const [0.0, 0.4, 0.8, 1.0], // Control where gradient changes
                ),
              ),
            ),
          ),
          // Content Scroll View
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Padding for AppBar area
                const SizedBox(height: kToolbarHeight + 40), // Adjust based on actual app bar height

                // Show Title "MONEY HEIST"
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 150.0, right: 20.0), // Pushed down by image
                  child: Image.asset(
                    'assets/money_heist_title.png', // Image for "MONEY HEIST" title
                    width: MediaQuery.of(context).size.width * 0.7, // Adjust size as needed
                  ),
                ),
                const SizedBox(height: 10),

                // Metadata Row (16+, 0 Seasons, HD, 4.7)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Wrap( // Using Wrap for flexible layout if items don't fit
                    spacing: 8.0,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _buildMetadataTag('2017', textColor: Colors.grey[400]),
                      const Icon(Icons.circle, size: 5, color: Colors.grey),
                      _buildMetadataTag('Action', textColor: Colors.grey[400]),
                      const Icon(Icons.circle, size: 5, color: Colors.grey),
                      _buildMetadataTag('Classic', textColor: Colors.grey[400]),
                      const Icon(Icons.circle, size: 5, color: Colors.grey),
                      _buildMetadataTag('Crime', textColor: Colors.grey[400]),
                      const Icon(Icons.circle, size: 5, color: Colors.grey),
                      _buildMetadataTag('Dramas', textColor: Colors.grey[400]),
                      const Icon(Icons.circle, size: 5, color: Colors.grey),
                      // The tags from the screenshot
                      _buildMetadataTag('16+', backgroundColor: Colors.grey[700]),
                      _buildMetadataTag('0 Seasons', backgroundColor: Colors.transparent, borderColor: Colors.grey),
                      _buildMetadataTag('HD', backgroundColor: Colors.transparent, borderColor: Colors.grey),
                      _buildMetadataTag('4.7', backgroundColor: Colors.transparent, borderColor: Colors.grey),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Play Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle play button press
                      },
                      icon: const Icon(Icons.play_arrow, color: Colors.black),
                      label: const Text(
                        'Play',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Watchlist, Trailer, Share Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildActionButton(Icons.add, 'Watchlist'),
                      _buildActionButton(Icons.download, 'Trailer'), // Using download for trailer icon, adjust if needed
                      _buildActionButton(Icons.share, 'Share'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Description Text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "To carry out the biggest heist in history, a mysterious man called The Professor recruits a band of eight robbers who have a single characteristic: none of them has anything to lose. Five months of seclusion memorizing every step, every detail, every probability culminate in eleven days locked up in the National Coinage and Stamp Factory of Spain, surrounded by police forces and with dozens of hostages in their power. Can find a way to make their crime a success?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 50), // Padding at the bottom
              ],
            ),
          ),
          // Custom AppBar for back arrow and debug banner
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context); // Go back
                },
              ),
              // You can add other AppBar elements here if needed
              // The '11:24' and battery/wifi icons are typically part of the device's system overlay,
              // but you can simulate them with a Row of Text and Icon widgets if strict replication is needed.
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '11:24',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  SizedBox(width: 8),
                  // Placeholder for battery and wifi icons
                  Icon(Icons.wifi, color: Colors.white, size: 16),
                  SizedBox(width: 4),
                  Icon(Icons.battery_full, color: Colors.white, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for metadata tags (16+, HD, etc.)
  Widget _buildMetadataTag(String text, {Color? backgroundColor, Color? textColor, Color? borderColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        border: borderColor != null ? Border.all(color: borderColor, width: 1) : null,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Helper widget for Watchlist, Trailer, Share buttons
  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}