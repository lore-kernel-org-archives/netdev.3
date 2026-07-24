Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61762F8EBE;
	Fri, 24 Jul 2026 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878619; cv=none; b=cwqVguSHC3qUW6CSJaDkF7ouRNyyznmeQU946dgfAcZsbuhs99iUXuQxPQJW0Hpra8dQlye7lkLamczgWv8MCFITRsPc0PMbFkM/dLDbyX+GZAXPYGGCqEKC3/w6FYntgxthBekTtnhmDZnyvPvABooLbhbNFzQeoVycKVI84fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878619; c=relaxed/simple;
	bh=AtidLZUpoFKxJxk2VVd2ucqs05PUi9WU9odzh3+TvEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HEtmUdgIzL/PFC214DT725k7YiR+AvbyJzLtr53BinNI+K5dNFz7JT+YG3LbxRSWQvs0kqoEkzS97ICUDrwSpUGwb/wm6TF5lkHv5X3ltJMShCx8j2GTCa7SWDgZnZC1MfP68w1bdvoiO7uy0InPk6SPTK/7xfaKhaoLMxxIrDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=bXzLUYuC; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=0uGsrmGD; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="bXzLUYuC";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="0uGsrmGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878616;
	bh=AtidLZUpoFKxJxk2VVd2ucqs05PUi9WU9odzh3+TvEs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bXzLUYuCTUd2orLtgLQY5juf+zSomRWlSnAWLFVm7oGkGbMFkPb9CDWbSizJYR5AG
	 x2HtQokN9uO/nWbkqqdpMegrFdy1biamZr5lTd7hX53IbgK2Ql7TP9Ng0KAMBk6GVJ
	 7rQSAW60bg5EdA9WU+D190ebkwMiWsYeqKfTIBo/iz2SJNE99NlOR8BI1nYoiy2E6R
	 C6xlZBR6s2stVfHWWHqMojFsIMRhc9tmh4YjzJwsoFQVDTQWd+ru4xE7txM72oRMG6
	 V92DvrHMEfrzK25THF/u1hY9hmejqQ+367MRlZN7aIz63T2BpqcbEPIruilbZ6Zcd0
	 uVfGuJ22pV0EA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 29F7A49441; Fri, 24 Jul 2026 07:36:56 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878607;
	bh=AtidLZUpoFKxJxk2VVd2ucqs05PUi9WU9odzh3+TvEs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=0uGsrmGDxg3HO7Iqpi3fZZuIMbBs5ZmD4/sDXOoUNNAZTS3U7mJq/V4Yph2SOT/e1
	 ZbxBQpQDmbPgkg2MZpL9Zir8FSiqepGyZomm5CPHdrzYquT/e+x0aSpv3vFCGXj0Ng
	 Eg3TOI3QZMsiGvlpXXMQawJQSt6Rz2i3ksv0uHgJZTEzrOlFFCxI4QT3s7kL9yA8kG
	 vY1TTuJvAKIlhCF1aIKGSCawExvu/8AeZ+/ZWvJdpbg/t5Db5+0/SF2//Yj3OOlDv1
	 NEMnTvvwb1Mqx8MOFx9USnFpfqWBMnKgBNtZ6tDc/mxHDz8T5v2gL8p7PiKDQCQy2n
	 G+N0+KVM7wS2w==
Received: from DebianDesktop.lan (p200300c69f1c3c00ecd187824fbc6faf.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:ecd1:8782:4fbc:6faf])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 68D9F492AD;
	Fri, 24 Jul 2026 07:36:47 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 24 Jul 2026 09:36:46 +0200
Subject: [PATCH net-next v3 03/13] ax88179_178a: Use MMD accessor functions
 for AX88179A
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ax88179a-v3-3-bdde4f905883@birger-koblitz.de>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
In-Reply-To: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2

The AX88179A uses a much simpler Clause-45 MMD access interface,
which are made available through ax_read_mmd() and ax_write_mmd(),
which in turn call the chips' respective implementation.

Make use of these functions for stract MMD read/write operations.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index b90a75a11024c58192bdb4a9436636bc9312148c..b7837c7a89f9b5ee520ef1ae91bbc7619d1a12bd 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -985,22 +985,19 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
 	int val;
 
 	/* Get Supported EEE */
-	val = ax88179_phy_read_mmd_indirect(dev, MDIO_PCS_EEE_ABLE,
-					    MDIO_MMD_PCS);
+	val = ax_read_mmd(dev, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
 	if (val < 0)
 		return val;
 	mii_eee_cap1_mod_linkmode_t(data->supported, val);
 
 	/* Get advertisement EEE */
-	val = ax88179_phy_read_mmd_indirect(dev, MDIO_AN_EEE_ADV,
-					    MDIO_MMD_AN);
+	val = ax_read_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_ADV);
 	if (val < 0)
 		return val;
 	mii_eee_cap1_mod_linkmode_t(data->advertised, val);
 
 	/* Get LP advertisement EEE */
-	val = ax88179_phy_read_mmd_indirect(dev, MDIO_AN_EEE_LPABLE,
-					    MDIO_MMD_AN);
+	val = ax_read_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_LPABLE);
 	if (val < 0)
 		return val;
 	mii_eee_cap1_mod_linkmode_t(data->lp_advertised, val);
@@ -1013,8 +1010,7 @@ ax88179_ethtool_set_eee(struct usbnet *dev, struct ethtool_keee *data)
 {
 	u16 tmp16 = linkmode_to_mii_eee_cap1_t(data->advertised);
 
-	return ax88179_phy_write_mmd_indirect(dev, MDIO_AN_EEE_ADV,
-					      MDIO_MMD_AN, tmp16);
+	return ax_write_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, tmp16);
 }
 
 static int ax88179_chk_eee(struct usbnet *dev)
@@ -1028,32 +1024,19 @@ static int ax88179_chk_eee(struct usbnet *dev)
 		int eee_lp, eee_cap, eee_adv;
 		u32 lp, cap, adv, supported = 0;
 
-		eee_cap = ax88179_phy_read_mmd_indirect(dev,
-							MDIO_PCS_EEE_ABLE,
-							MDIO_MMD_PCS);
-		if (eee_cap < 0) {
-			priv->eee_active = 0;
+		eee_cap = ax_read_mmd(dev, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
+		if (eee_cap < 0)
 			return false;
-		}
 
 		cap = mmd_eee_cap_to_ethtool_sup_t(eee_cap);
-		if (!cap) {
-			priv->eee_active = 0;
-			return false;
-		}
-
-		eee_lp = ax88179_phy_read_mmd_indirect(dev,
-						       MDIO_AN_EEE_LPABLE,
-						       MDIO_MMD_AN);
-		if (eee_lp < 0) {
-			priv->eee_active = 0;
+		if (!cap)
 			return false;
-		}
 
-		eee_adv = ax88179_phy_read_mmd_indirect(dev,
-							MDIO_AN_EEE_ADV,
-							MDIO_MMD_AN);
+		eee_lp = ax_read_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_LPABLE);
+		if (eee_lp < 0)
+			return true;
 
+		eee_adv = ax_read_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_ADV);
 		if (eee_adv < 0) {
 			priv->eee_active = 0;
 			return false;

-- 
2.47.3

