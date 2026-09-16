Received: from mail-wr2-f32.google.com (mail-wr2-f32.google.com [74.125.225.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A053359F
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602747; cv=none; b=Mh8sqxmY19UMdr6sdv50XG7bh1eBPFOfxjzrAubDVDO0Rn8dmbbh4Rh+Foql1vgSZtW/4T73Bu4Nsv2Scmh/TWDPq7n1gx0CIze+92nPZXLeJKj72Hi/lMcUJZyGqsGEtIDnRKWZoBqdQUXpCvU4LnhBJFsdIP1y6vrwoiyU50o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602747; c=relaxed/simple;
	bh=uJSONuBio8SeU9obl5bPfkUbfCcjYoh7VZVrNIcWqkg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OR6Tt0VCAGBhOqornfhtRymbFk1Itx1uJBS478QzB8O8K3W+35ksU2d6WHiLmhY+yvO84cpNsBl0MNuD48AW2hNceopPxGfL0wimA/oMqMqaS7LFxOrdM26nGTjzyZ7kOvGJloNS0stqNcQsIOg/trg8m2JnhRi3mCzgpPIT0jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qwjy0q9o; arc=none smtp.client-ip=74.125.225.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qwjy0q9o"
Received: by mail-wr2-f32.google.com with SMTP id ffacd0b85a97d-482f6350f91so135712f8f.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789602743; x=1790207543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4Co9+GXWgL7GOlvIeLE0GKxOjauA5YSOFLNwGRGVNoM=;
        b=Qwjy0q9oJ5j5Otk0rKhUnpvAKPiU+dMJE3BBTcA/xsjhhwckl2ElwZbj9pT5phKsO4
         W73L0LAoP+gjM8eyi4HI4CO5/8RRlVEuI3RcBk+P/PacTzi0rur6gobszlXIvl6L1zrH
         vumx6lhQgVkYHjrJ0x7zmnOyzdjHry5U49SwZBD1HV9pkLBZKZ0FF4Pl3iZOwMQ7lT7J
         DBO2vdSYY1ptfYr04PTp+UI9X3ngV+cXDJPo+X9BysQlvN3Tbo7EOU3F0ANH140A7/rt
         7Z41nWqojPgqt7BwgUpYD2rinze4YTrdu5/syPdm2cI4+tUvAAmcJyxOpE5xlvHsNcJ7
         eO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602743; x=1790207543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4Co9+GXWgL7GOlvIeLE0GKxOjauA5YSOFLNwGRGVNoM=;
        b=nn5LS/pQzjzc5ok6jhpoQHjchyEQRRznJSPm3lAl0Hw2Dx9yr6dI8irT5iPxPFcspI
         q02yQcDbhJA3XwWwgTBd0zri1lLt0DjdPVXaDIF4gvnPLTlxvOeCPPxHimRJuaEDYjdq
         qz9S6U8AkI+nhpWYiUyPdNGqDMWxPHGiNbKczob20chi3kRyR9j2NcxGReVHNpbSB7Zn
         fIx2IJqEH1xgfBHukSFAOBXJe71yGPThYMHr83KQO+jZ7Fg+0I0rRtUlvhcP186OipmS
         i18toTtl3SJSI1sBeBJ2D7ytqvpxjTxt5Zbg8XUBTme3lNjOEzAqxBx9tlbNq+HqpYQQ
         Q2Sw==
X-Forwarded-Encrypted: i=1; AKwUvBwcc5g5V+GZgds3baYAkED2IwLfJKIij2qV2cWCkRUpEd0dZXRQMWhRzmsQmY4axNmLftWoPHw=@vger.kernel.org
X-Gm-Message-State: AFuF++nrpzbAV3gI2jUaJ32NZa4Cf9JTDHi9FhFrpoGOBHqF9fOr7rXg
	xPi/mOEsbRUtFFE2QXLCSZE8+mdJffn1zXDy3q2v2XjB4Iw6rHulEQhM
X-Gm-Gg: AYBFou32LYXXes5NKd8flwIES/djcyo/bPe4BNxFA2PwmxfPieDpyV469yy1AM0nU1Q
	TY/hKia82uP9qv6eJahEYMQXjpIEDaIMF9mYS0d4NHks9r7tuyhoonuyIlyIn9EOXgbcTbUdUJx
	yCQXceiN7Juh38JcDqI0GuhxnmZPXrvXU4nRLhi+eGtrBy0meMf/SwVEdFZ9CkvVST4hlturwjd
	N0jIdBbKshFW5fgutpGF8vOW14XswZvRn5vChkyDiumzIBW57E33m3g2rJFClV79X25twl25tMg
	RbOnGYv18LLciA+oc2DMOtiLCVgY14b00DZOruONHy4aIEcQSqXivgOEGQtiqelykebMaY0WvY9
	SAmxnEsPPYwuo5bvBGzw7Lk1EYRUewKAbXWCj1jdZ8S9o606esWLIL84PPZosdsLZBhH0IzZW63
	WQwY42eaT336CbdJN3mPTPCv6W8vD/zgAe91U1FUHplrA+sLT0KmhhF4JLeBC7Hyy5lDGfxc/eC
	1KMXS/jm8021xmPtPGoP3Qj4iH1G9Q4fClc+s793b9vUdXhIvdEfZa7O8JXSA0=
X-Received: by 2002:a05:6000:2304:b0:487:84:96d7 with SMTP id ffacd0b85a97d-4870d2718ecmr5744113f8f.53.1789602742429;
        Wed, 16 Sep 2026 16:52:22 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-26-252-140.retail.telecomitalia.it. [79.26.252.140])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4870bef7687sm11861104f8f.1.2026.09.16.16.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 16:52:22 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next v16 04/12] net: phylink: save phylink instance fwnode on phylink_create
Date: Thu, 17 Sep 2026 01:51:30 +0200
Message-ID: <20260916235200.20712-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916235200.20712-1-ansuelsmth@gmail.com>
References: <20260916235200.20712-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware node associated with the phylink instance might differ from
the device firmware node passed in phylink_config as such device can
reference the parent switch or other platform peripherals.

Some function might need to reference this firmware node after
phylink_create so add a dedicated fwnode entry in phylink internal struct
and save it on phylink_create().

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 417d2f1e54b7..473d15789128 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -44,6 +44,7 @@ struct phylink {
 	const struct phylink_mac_ops *mac_ops;
 	struct phylink_config *config;
 	struct phylink_pcs *pcs;
+	struct fwnode_handle *fwnode;
 	struct device *dev;
 	unsigned int old_link_state:1;
 
@@ -2115,6 +2116,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 	INIT_LIST_HEAD(&pl->pcs_list);
 
 	pl->config = config;
+	pl->fwnode = fwnode_handle_get((struct fwnode_handle *)fwnode);
 	if (config->type == PHYLINK_NETDEV) {
 		pl->netdev = to_net_dev(config->dev);
 		netif_carrier_off(pl->netdev);
@@ -2199,6 +2201,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 		pcs->phylink = NULL;
 	}
 free_pl:
+	fwnode_handle_put(pl->fwnode);
 	kfree(pl);
 	return ERR_PTR(ret);
 }
@@ -2229,6 +2232,8 @@ void phylink_destroy(struct phylink *pl)
 		list_del(&pcs->list);
 	}
 
+	fwnode_handle_put(pl->fwnode);
+
 	kfree(pl);
 }
 EXPORT_SYMBOL_GPL(phylink_destroy);
-- 
2.55.0

