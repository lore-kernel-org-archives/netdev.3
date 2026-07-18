Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957BC38E8A7
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784393622; cv=none; b=cxn2DfKP0H5ycP+CSf8lzI/I4ETZbA6WMDPhh0NWI2Jvl/uotR0QCC847KDEYjpBQ7iO1FrynazpGxbMn3qOKmIbgds5ShfsXb9jRfKX2uk1aOCHfIgedmk4rInJeYUoOS2m2noZuJVQJvIQJKKg5FWsdkMYdxPL/3bR0fN3PFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784393622; c=relaxed/simple;
	bh=TY6XXNluMvPZeiK1GBdfLiSNwAHUxfTBKa7Hd1Mq8KE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+P2B040SEelpFtY/OF3WhlP0Rodw77BwwVRzljT5dflb/fOwyaOKMVXHyUMt97Nq1wYqJpDDTPy+eKKADPY5i1U832HN9WtLsdCgLtOQv5KsAS6wImjfpG3ULK4d+UlM34xA3tMpPa32RJELzU9mSe0JMuCCARdTF8GtuAq/ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Og5kWHBq; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og5kWHBq"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69c20ba892eso3248988a12.1
        for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 09:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784393619; x=1784998419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XIwRmPJyHTglY/geaE+jR8d2MvoV2i3YMT3lvluIPbw=;
        b=Og5kWHBqUkaEKzK0zQnbzbU3r6mG+xIz9qUJEauE3HOSFLVqSd7KNNhEioxUhsCPgI
         lLCYF2B4QXkExvR4OekdAvZ5WO1CVPr4rolH6RJkLZideeS+po6Xh+G808RNEld2UQco
         4iHr1k0I9Bp4V97cI2miWQrdULZH6/EZYS21dzOnZqbZW+qbKLdwtOpRDhGyVtIqOeoe
         P9XFNDt49g7P9hUSP1WwcdmenPtR2W2SMtUBIM0k27HmvMfDRa6zNqxBZPm36L2ZAV+N
         eGrQDsstNszdjOO9qRToNbfOwz6KEBtzy226woaCWmBwLzzZO7oxJSywN++jPWG/LGsG
         tlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784393619; x=1784998419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XIwRmPJyHTglY/geaE+jR8d2MvoV2i3YMT3lvluIPbw=;
        b=JurhQn7TWTDQ4HBCzoqvDMPS+04dKOwc/G94Q8q3QDZHdFs3nDWsFXreWmHQLv7V3x
         UOQYehTQT+HcqxGkhBW2Hjej3wOP1KBBnb+UwgBy36BEdEHDD5ABywaVqY7KAmF5l2Ax
         6eND9bbkk/eieHnsV/mIhwhumhXTagWvgbUuO8dzKYrUxHNT2ZI0vNHY3vTbqG5i3R8x
         Jdj8oktWFCw1FarBs5H+t9WFcjQK5FmWYJnzRmhf03CIzgoA4P8+39q/CpKmlJp1EuD7
         nqih/Zrbe3h7hgyqSQ4UpBvfHzsLBbRZaxUE8wI4eTWoyh9GBN5vuapn320kZRo/SZCZ
         OATg==
X-Gm-Message-State: AOJu0Yy9AMyvtI2d9ySo3WQBjDt2m+VSafY3AhVCRtJDI+QFHQAybItg
	i4Ym7w1z+O0vEUbIIbPb4KtY/TiKgTlCYVa6VzILWvJ44VzKjLW/yfLwIF2uOj0E
X-Gm-Gg: AfdE7clEqqMjbSAa9G1y6Ygxm9sdoWhqVSh4IrkdbnRAhpRCuiYaT91SU0hsozberft
	SejN7/NYfsB4sBOCACrlSEF1hiI/+hMwqMFX4+xqgx455p6jNmox/Phg1jJONkjOs2bforMGNL3
	8U5Ahmjncuscmj0ULjC9/sOBHF7vk6lA8OlZbjQ7TahltGvnA4xl5DvGy5FK9cLUgWVC+tDB1YL
	7kLqKY/rJyE0/R3vZ5G8cAp+ssvXeEWryOa0Ppm+ttS/rheFZ4cKUZ+LNh7B9IvPJRIlNufnjRw
	Y/TBYH8nbcTuS8dDVW+o8sJDhExlPH7MFnYnx5I0JSEk0N/Lql0e8SrVlkm4+AclIV8Py2Adglf
	2sm1MdmJCM1rC5kTEz9GAgGk+INAq87gjJR/cJ9E+Y5ut/ik14hyUq/EaYgIHOBJoJS///cB/OU
	6HomlmhmEG+gJmxOIH6bZu9RSSAcM=
X-Received: by 2002:a17:907:6d0e:b0:c16:89e0:dce0 with SMTP id a640c23a62f3a-c16920d90f1mr566250066b.11.1784393618513;
        Sat, 18 Jul 2026 09:53:38 -0700 (PDT)
Received: from tempest2.110.lan (xt27d7.stansat.pl. [83.243.39.215])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c19457d6f0fsm192197766b.36.2026.07.18.09.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 09:53:38 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] igb: detect M88E1112 100BASE-FX SGMII mode
Date: Sat, 18 Jul 2026 18:52:04 +0200
Message-ID: <20260718165213.3620511-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The M88E1112 can be strapped or EEPROM-configured to bridge SGMII
to 100BASE-FX. In this mode the driver still needs the SGMII PHY
register access path to identify the external PHY, but the MAC link
setup must follow the SERDES media path rather than copper setup.

Decode the M88E1112 MAC Control 1 mode field and switch the I210
media type and physical interface setup callback when the PHY reports
100BASE-FX mode.

The driver only observes the Marvell mode. It does not program the
88E1112 registers or its EEPROM. The board must configure it
through firmware or straps before probe.

Assisted-by: Codex:GPT-5
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c   | 12 +++++++++++-
 drivers/net/ethernet/intel/igb/e1000_defines.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index 44a85ad749a4..72c42d9d6f47 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -264,9 +264,19 @@ static s32 igb_init_phy_params_82575(struct e1000_hw *hw)
 			data = FIELD_GET(E1000_M88E1112_MAC_CTRL_1_MODE_MASK,
 					 data);
 			if (data == E1000_M88E1112_AUTO_COPPER_SGMII ||
-			    data == E1000_M88E1112_AUTO_COPPER_BASEX)
+			    data == E1000_M88E1112_AUTO_COPPER_BASEX) {
 				hw->mac.ops.check_for_link =
 						igb_check_for_link_media_swap;
+			} else if (data == E1000_M88E1112_100BASE_FX) {
+				/* The driver only detects this strap/EEPROM
+				 * mode. 88E1112 register and EEPROM setup must
+				 * be done outside igb before probe/reset.
+				 */
+				hw->phy.media_type =
+					e1000_media_type_internal_serdes;
+				hw->mac.ops.setup_physical_interface =
+					igb_setup_serdes_link_82575;
+			}
 		}
 		if (phy->id == M88E1512_E_PHY_ID) {
 			ret_val = igb_initialize_M88E1512_phy(hw);
diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index 7e6f9aa2d57b..25104328eae6 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -615,6 +615,7 @@
 
 #define E1000_MEDIA_PORT_COPPER			1
 #define E1000_MEDIA_PORT_OTHER			2
+#define E1000_M88E1112_100BASE_FX		0x0
 #define E1000_M88E1112_AUTO_COPPER_SGMII	0x2
 #define E1000_M88E1112_AUTO_COPPER_BASEX	0x3
 #define E1000_M88E1112_STATUS_LINK		0x0004 /* Interface Link Bit */
-- 
2.43.0

