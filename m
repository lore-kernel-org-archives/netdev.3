Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CAD3E9F8D;
	Thu,  3 Sep 2026 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426050; cv=none; b=NfFZy/wcFYHA1jsjgn2PpoykdgPmLnI6IwmJfOtoZBI2SnoRPKZLFwY+0G+H7KJ5SMA6k3aaUqfsp8ifh9EiX5C+rRkuj2zGSwXdTC3DtQZBGxj0dPpfEJp/VMR96PmQyDR8bWxSzB/D2oSK/+oyHTrpoyLQN+k+QNbchCkXBXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426050; c=relaxed/simple;
	bh=T0oDyeZSdcMQzM7wfHkz/mM1T00zumoKLZed55VmyjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sNvNn4+UWltGnyuN6JeT+t/IvDFjzBWWPGRyFrBlB1ly0DRHlS0FcqjrSlH/yWf4pY8v7MVXanstAYGsJV/x7wDOUmUwHW8hT1lRLJ/wv/cL+jy55GqJgLv2qbhzgITy9DiruVHgTbCJ7pj7JEi3t4MzI7AjRlZsIMVl5vtcgmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0788C1F000E9;
	Thu,  3 Sep 2026 09:00:44 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH net-next v2 0/3] net: Make sure clk_init_data is fully initialized
Date: Thu,  3 Sep 2026 11:00:38 +0200
Message-ID: <cover.1788425654.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

	Hi all,

The clk_init_data structure contains several mutually-exclusive members
for different methods to specify the possible parents of a clock,
prompting drivers to initialize only the members they need.  However,
not initializing all members may cause subtle issues, which are only
exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
enabled.

Hence this series aims to make sure all members are fully initialized,
to avoid such bugs, and to prevent future breakage when converting
drivers to a different method for specifying the parents.

Part One[1] fixed all cases that I identified to be real bugs, in
response to a crash I saw on BeagleBone Black.

This series is the networking subpart of Part Two, which fixes remaining
cases that are currently harmless.  These are still fragile, and may
cause future breakage when converting drivers to a different method for
specifying the parents.

Changes compared to v1[2]:
  - Add Reviewed-by.

Thanks for your comments!

[1] "[PATCH treewide 0/5] clk: Make sure clk_init_data is fully
     initialized (part 1)"
    https://lore.kernel.org/cover.1787165329.git.geert+renesas@glider.be
[2] "[PATCH net-next 0/3] net: Make sure clk_init_data is fully
     initialized"
    https://lore.kernel.org/cover.1787240118.git.geert+renesas@glider.be

Geert Uytterhoeven (3):
  net: macb: Make sure clk_init_data is fully initialized
  net: mdio: mux-meson-g12a: Make sure clk_init_data is fully
    initialized
  net: phy: air_en8811h: Make sure clk_init_data is fully initialized

 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 drivers/net/mdio/mdio-mux-meson-g12a.c   | 2 +-
 drivers/net/phy/air_en8811h.c            | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
