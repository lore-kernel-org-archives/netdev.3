Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654720;
	b=kSmdehP1aGSC6C03yzAaXun96m45m6n68veUcFx0/xpvU8zuB1vAFr0/lMyR+g217ciF
	 5ZrENH/LWKwory2hlZgjYgmOEWvelk8j9MWWSA1gFz2PwDMTEsGyGrgDkQJ+etd3qp1V+
	 fQ7meoJzQ3VAV3jDZR9ulz2QGSwCb4oRplL6hzFmWXj/NuEAyc0vMKvZ+g85+V+uXQblp
	 E2U7PH2g01UJieHepVifHVohC9/IX/g+hhOlG0bWm/hbCZKqpc2esNIjBP1QJ2c59FlAV
	 I52+K+FamSVA675+wJGU+fF8AhdCHcXKXSMgWdxJ/1uwEZE6FCrqdvyr7XXl1T+OV8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h4Pf0yuMbG7VmbL6qh5TPaycUsxMKNE4IhWYVqEHmlg=;
	b=ck6V23ieakmUsTGYhtexqmdwTYJ2byYwQ0rgNNh7LNDaULMXoVhPNyU29vebqQMnq5jb
	 tcP/AnP2lljK6s7Mbm8K1FhQ6tPaOwov+PbqbzK/eDHdg3yhgExjg40l2fHJv6P8OAQFu
	 A2vW5R8v+zunRNxSoIhx0yUk4RaK/ikyqV/Q57xeB6Gwunr/4Mpvuxe5LsjQrRPCMpSpL
	 qhMv8SfXwRTCMhg++HoGcuJW/EaIfWjIaROVe9+ePh3nqtW59QCFad1iIZUKGbJxuU3L7
	 8M+7Mx8AIQX/YbL8lrAGEq96wWUFIVLK5QRV8nvVnMITFeQKvxytihOIogj2EptFzFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TfsHWPJ1;
	arc=none smtp.remote-ip=74.125.229.136
Received: from mail-dl2-f8.google.com (mail-dl2-f8.google.com [74.125.229.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED51606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 21:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AED51606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TfsHWPJ1
Received: by mail-dl2-f8.google.com with SMTP id a92af1059eb24-1379d236149so1383813c88.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 13:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793654719; x=1794259519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h4Pf0yuMbG7VmbL6qh5TPaycUsxMKNE4IhWYVqEHmlg=;
        b=TfsHWPJ1n68z8xUUlj2uRPFXLeIhHK13XYNQ1S2qUKwSsUQ4aSJYSFehqgo+FwK1kV
         qf+0VLvKWBqNqbM0feaXatX/jVAM0C/YicvoOlJ6UqRHkB2uLjinMaiJK2GMzJm1LWu1
         iuCNRt/8AdAJFf+vDRDysHLhEMGfZKMyJJ83y8CXlJzCvgEs6AXuhWXb4JF7Eemj7GTA
         WotZucqDedMBpThanrOi8haFUlbUlWyUnvwrXNg9GykDngCmwm7IG9D2X+0X4JJQz1me
         aGqAUrb2V2WGP0lk4M1SDxsnZTTqE/hhXXIZktMHiEowexUBqG6xJxRQHDgINMlgUmYP
         BEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793654719; x=1794259519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h4Pf0yuMbG7VmbL6qh5TPaycUsxMKNE4IhWYVqEHmlg=;
        b=KtYEZ8joGUKMnnqzwTdFoDo0/bymGgJizaeVBv6co9K3Umt5hxp8wN7ddwXYLkDFbR
         smKkSJGI37hgJxNAcYcZEPba1ps0weIqI8bH09O48KshfipgtVwtxYrZAnBVAD88pvgj
         kBXhmZR+DF5V5PooKNQ9tzIaXFcRpwo2uBYVmdCdBlB//pYxrFjhSm179f8AAABMDfrl
         rq51ThPNWHpqVaO5tbdIxJpU3Gtn/VfPOZTYW6QNE2c4HqpDHgZB7XhbKhyDBioGDy6H
         ND8WXzjNW7xYZ09YKu4tYVjSI1KsEMU8rnCz7LBhGFI+0IyT3voipiWuayUizNYYUkn6
         mhxw==
X-Forwarded-Encrypted: i=1; AKwUvBxhxSGtc49gvIVsZSgBQF1Nh9iuJ+cUtZhPiqqFvOqpcjgpY0ghIe4RUJYsqxUJKOKLvXUlLYQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaXrnBl+a7fvRoAfqpIS5geB8QdckXUvo+b2ed1XyGWfaWSqlj
	gHFVHSJ/UAi/7qpuvTq5XPM68sHv0OyUwu3kd92sU78a25Xnl4mLDPdG
X-Gm-Gg: AYBFou2NJcHD2JHp0nXg2RcglvPNmwZo+5drr+7Rn9bevsQ8wWQfCXtcd5gpqlzQFWL
	tm4pJVYqYtk/amMbM9g4Xk7D73am662qgzWvQuZkZ2xZfgVU7JEQWH6oIJ8ZjaIHRvwd9+XStjx
	ViQ+BrIbU2BQ+SSUaoLBVTfuM6WGnwC4mPCUa+iSGr3nSccenkvLgZI82/gu965O3d+97iXUVZN
	aPcBJD71RBkVXGUqqIYu3xmcBkT8313+hvLubLbZjr5yGUVOaEUBrxhdLsltHepvA2qTwRyoEt4
	MluNM9a7WMA/StjeWfNbVdBOHBmg4cEoe/nXGBFqtgXCvTv3141rMuw8VJ5oErpLjRtdvoVgMd9
	ZqenBn3qlUsJNJoTT6IpMsegUM2j4AmB74n4S2mQfWNXBmg4o0sp3/2hdNy45m+IDjrvbr+oGVq
	pf8aQ4aMniJTsX26rQ6GY+6dt3eyGlWnHpm6vIYj4k6S9fm6i4LZnrmiocKiAkZsT0aYc143TXP
	L9Fmol+vp8U3GGfXPuACyoSANG2e2JyfhgXqHcJltn9jW3FTSd2kcEagyTE/zgigzPn7q9L7bCG
	eruI1ZYLT0uWn+7hcclGY2jnfk0=
X-Received: by 2002:a05:7022:3f04:b0:19f:527d:96da with SMTP id a92af1059eb24-1ac5da7b145mr16079436c88.33.1793654718619;
        Mon, 02 Nov 2026 13:25:18 -0800 (PST)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm37195851eec.12.2026.11.02.13.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:25:17 -0800 (PST)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiko Stuebner <heiko@sntech.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH net v3 0/2] net: phy: fix PHY interface mask initialization and XPCS usage
Date: Tue,  3 Nov 2026 05:25:04 +0800
Message-ID: <20261102212506.3348537-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2:
- Patch 1 (new): move DECLARE_PHY_INTERFACE_MASK_ZERO to core and fix
  the array size calculation.
- Patch 2: advertise 1000BASE-X, SGMII and QSGMII instead of only SGMII.
  Intersect the platform mask with the core mask using
  phy_interface_and().
- Add Fixes tag for the XPCS patch.

===

This series fixes issues related to the handling of the PHY interface mask
(supported_interfaces) at the core level and in the XPCS driver.

Patch 1 fixes a hack in the txgbe driver. The local
DECLARE_PHY_INTERFACE_MASK_ZERO() macro incorrectly used
PHY_INTERFACE_MODE_MAX as the array length. Move it to
include/linux/phy.h and base it on DECLARE_PHY_INTERFACE_MASK() so the
bitmap is correctly sized while still being initialized to zero.

Patch 2 makes the XPCS supported_interfaces mask authoritative. The
generic compat table advertises modes that a specific integration may
not support. The Rockchip glue now builds a platform mask (1000BASE-X,
SGMII, QSGMII) and intersects it with the inherited core mask. In
addition, xpcs_find_compat() now checks supported_interfaces before
looking up the compat table, ensuring the core respects the narrowed
mask.

Note: checkpatch.pl reports "Macros with complex values should be
enclosed in parentheses" for the new macro in Patch 1. This is a known
false positive for declarative macros that expand to variable
declarations; wrapping it would break compilation.
---
Coia Prant (2):
  net: phy: move DECLARE_PHY_INTERFACE_MASK_ZERO to core
  net: pcs: xpcs: make supported_interfaces authoritative

 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h |  3 ---
 drivers/net/pcs/pcs-xpcs-rk.c                   | 10 ++++++++++
 drivers/net/pcs/pcs-xpcs.c                      |  3 +++
 include/linux/phy.h                             |  3 +++
 4 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.47.3

