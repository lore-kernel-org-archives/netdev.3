Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2AE43F4AF
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818100; cv=none; b=ipROtNaGB1mFGGYjCEWBxtl9dmw7p3Jy3MNGXFU+k26tZ2MfjDKg65g+7WrkVWjBrNcE9ua41OEmB0uXiHFXYPGwHcgXTgWJL40dUr5Ae8ylWU28jEOdI3r7TQvk/emN443FstOJNp7NDvl0giLs9ug+weEN0yUyG83bRmld0cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818100; c=relaxed/simple;
	bh=cOuGuXTRwRbieXZHpEpUkyizPgeu40kkjKbILhrTpr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRkCs98oQVoDWhihlFNKv4ZQge0m+lOPHgxTNpqTLgQwiFPCz43kjLnCht5Zi7oW09O9NJDFRT5usCwbEF2baPu22utR0X4sJddzQX3bwQtiSJ9ymSgU3hYKBkJoIDB/uwZOp6ycMKTvgb6p+Gcpr7BUpKc0rz8S7kmabE/Z9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmWZmFn2; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmWZmFn2"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-86e7f44b773so41516757b3.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 14:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788818087; x=1789422887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EPMvbjF7fIzIRVphdYEwqQYdJVOJV5Z2qbhmmd1p55E=;
        b=YmWZmFn28/CK0tr6SSuPRYdhyC/35acZMQr1WQTNnZ84JBn7jLqG1+yGOAikoLkcLj
         EPnGlTkXXEMLh9/2cPX5BDS9YKntyu24/NvBxKqbjnHT+6Qwb4SjRkSXAKv9yiUzzUe0
         YDXRJZzpS4btQvyfVZbuJr/pwxkXwVIePWgTbLFgZ8mH+dlWf9LUQOagjba2+d0liVvO
         WyW00ba4NGGl/1iNfSnFhoX50mSty659UMQGRFo9Aq2daz1BklMY7qfmmJUWpcMNBgcn
         5OIgdnrH4HPKaKKpXUpvWmIgbRXaj4g92N1eoY20CTLX0Nib9sWqLZX8a80d7r0RfuIA
         6OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788818087; x=1789422887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EPMvbjF7fIzIRVphdYEwqQYdJVOJV5Z2qbhmmd1p55E=;
        b=C+OMqT629B7t38JEl8SV4SXnvNGZMe80lhTmt9tEyEZuDz07lB9BmQLLPN/ULgdmBV
         bz7scbBGGDbgui5iPKaoEn3xiyBxAQ33FFKX5+JcikYcWMVeJSYscodpjt92kobsN2EN
         z8gurGn2PSvrmzwsEhtwbu7orlNPS6rkHKT8ahMfdsD5Q2vqCfRFsWfgZpRbxPoj9aeH
         lfDSXwtbazVCkryefvpXKJWXoKQRx+cAzUZ/SL4bd143u8QrB9p1u90wlME5WeovcUCP
         BYBNRVleZGuWtDe6zgifYOvN6CEzdGpvOWnz2pXy3cxdgnFewdCleV6Fk0iweHMhi9s2
         /NeA==
X-Forwarded-Encrypted: i=1; AKwUvBwrG8K7zgo7Qg/goj56s/Aqw7/fqsbARCwqbmU+c/O5SMjgRWPEYZ3TBgHMSTggNHHTdtOk+lU=@vger.kernel.org
X-Gm-Message-State: AFuF++klwZi6sy5pOTIlD3/S+D+CI1/qoq2rppGoPH6wzVcwgv+qY4sG
	1qSTevFFykQ6pf3Aoyvdd3K1G049lnTUtfcLcUmRrUBnGL0hPcBCiAiQ
X-Gm-Gg: AYBFou1V8WzmUFgiBrRsIJvrlp2Zbrc1qymcaRhx8+d5L/WHMwmMiOtieCVvP+TwAlw
	NyNKv3QvTUK7DcmtMPALOODsQKprI3cDkeplz56IyV+7MZ7UuNSyGXyrdiP5FSJ4tK5hBinoMqF
	w8A4TcQ4INyI0okxSIPaqrLaZvbA2uUL6c41JGA8jMaGs+8lq2ZjE+7nmBYkfruEpD/L/0UPOsH
	+pB2EVYA9fkQeFNH1sxCPaTNXVYjxDOyECcxOOqSgkz+oeIuxHdDOJBiTad4kvMBmxkAPDK8kpD
	w9VRUouhl4neqfIIbqAhpIpOhI+ZO3gwaDKq4/I3CsNaSLgbg+DwFHioUKlU+WvCWmv/awGU/si
	v0eeswhKLVprG+kXh/PXBFCNNqsGBDqfOWJe/qZy3izjx7TyHT+E3B4eetTLLGgzHjKxIVZD0tS
	LwfPoEGl6C6s9MEzhu7uJKtiTWvjGTQRGyve7ymYtayY3WvEZJm05ULPatwtuypXwJ99HlGqUTb
	7xKuGsitxYcwAc1dQ==
X-Received: by 2002:a05:690c:e29b:10b0:873:5ddf:d864 with SMTP id 00721157ae682-8735ddfdab5mr46438527b3.47.1788818086989;
        Mon, 07 Sep 2026 14:54:46 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b62bc77sm78551997b3.39.2026.09.07.14.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:54:46 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-usb@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6/9] net: avoid copies before linkmode_and()
Date: Mon,  7 Sep 2026 17:54:35 -0400
Message-ID: <20260907215439.409858-7-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907215439.409858-1-ynorov@nvidia.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid separate linkmode_copy() calls by passing the original source
bitmap directly to linkmode_and().

In phy_ethtool_ksettings_set(), also use the return value of
linkmode_and() when validating that the requested advertisement
contains a supported link mode.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c | 5 ++---
 drivers/net/phy/phy.c                                   | 7 +++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index cf881108fa57..5801da6100b8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -205,7 +205,6 @@ int hclge_mac_connect_phy(struct hnae3_handle *handle)
 	struct hclge_dev *hdev = vport->back;
 	struct net_device *netdev = hdev->vport[0].nic.netdev;
 	struct phy_device *phydev = hdev->hw.mac.phydev;
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
 	int ret;
 
 	if (!phydev)
@@ -223,8 +222,8 @@ int hclge_mac_connect_phy(struct hnae3_handle *handle)
 		return ret;
 	}
 
-	linkmode_copy(mask, hdev->hw.mac.supported);
-	linkmode_and(phydev->supported, phydev->supported, mask);
+	linkmode_and(phydev->supported, phydev->supported,
+		     hdev->hw.mac.supported);
 	linkmode_copy(phydev->advertising, phydev->supported);
 
 	/* supported flag is Pause and Asym Pause, but default advertising
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index fce9bc7be330..cd71186cd842 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1160,6 +1160,7 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
 			      const struct ethtool_link_ksettings *cmd)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
+	bool has_advertising;
 	u8 autoneg = cmd->base.autoneg;
 	u8 duplex = cmd->base.duplex;
 	u32 speed = cmd->base.speed;
@@ -1167,17 +1168,15 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
 	if (cmd->base.phy_address != phydev->mdio.addr)
 		return -EINVAL;
 
-	linkmode_copy(advertising, cmd->link_modes.advertising);
-
 	/* We make sure that we don't pass unsupported values in to the PHY */
-	linkmode_and(advertising, advertising, phydev->supported);
+	has_advertising = linkmode_and(advertising, cmd->link_modes.advertising, phydev->supported);
 
 	/* Verify the settings we care about. */
 	if (autoneg != AUTONEG_ENABLE && autoneg != AUTONEG_DISABLE)
 		return -EINVAL;
 
 	if (autoneg == AUTONEG_ENABLE &&
-	    (linkmode_empty(advertising) ||
+	    (!has_advertising ||
 	     !linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 				phydev->supported)))
 		return -EINVAL;
-- 
2.53.0

