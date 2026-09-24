Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B848146A5E4
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290959; cv=none; b=cvIVeAmD4Rs8y9rT4zxK0xpFUh0bUyvXZm2jJw4dP4VGlce2f53QHK+gmpaXUqEyyKI8zgKgI4d6NhDOJm6RtDYgkWqGfy5Mt1RWq8KeQ/F/xJbmgp0Yltg3bEWIYxyPbDsFDFb03U1orvX/ytCvHHkaCblOI/T8vyCx6TbGlzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290959; c=relaxed/simple;
	bh=m5HqqAwvf714jhn9AtFujlH/Cfft9cIXbM/MO6suoWc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVb6CcL5NZlDdSpvLPxApsKV89Y27tQSgptddwFEQ8RLZr/Itns6oJsViN646dHRV6MEBe26MXVHu7ZriMuCbtSqgGKn+8kbiCk973AFdew3G2F5trO7PMtKTc5AoQaILCkqimv5kJNO+xdcPBw5JOCk3JbrBveH1xB0vu8j0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqFFapcj; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqFFapcj"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so1932105e9.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 16:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790290956; x=1790895756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VDqbFLObsehCe0sJ0clGiEdbuZFFJjsJjNFUc+Lf4xc=;
        b=aqFFapcj6lWKZujhQlZfnhJKwQcmMWoshA0sNpAjFRspPHqIpyj2tW+ZCnEUs7tvGq
         eSNTkkmXspGkm3qSba9KIGthzRLhX7+LSwDJZ0j5ANgdeny2+IO7CfgaPkJrncWj6pWi
         q9vtngwonrM8G7klVeQQ9j2rOXeZfjj4Mrvu+QB29IiRYTzMfY/ulah5SBGXK1TZtJvk
         3Ghfd/Q/JCluMjeQpScL63ADHzXCmLUOTqHnnbU0Plt3LnlwIQvp8h9CCQxoLpemcQfN
         PX+KLuDzaym7ZakDxYzVZSvkNWhnKQDfmcjIFDwrU8Avc+Yc3kkwVHiQnatEoZ1XNIIz
         AYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790290956; x=1790895756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VDqbFLObsehCe0sJ0clGiEdbuZFFJjsJjNFUc+Lf4xc=;
        b=G6JBS0x+1XtZd2LpZDf2sn5zyRXwTJltO7bMm7UOKiCLW3y5brAOtppKhjKf3BU6yi
         yXeXJuzjX87mI4FDX7YQiYEHimBToCcRFMWlW1oA5ybarR3lTUVR1jjZqjUz7KW/Tg7O
         jg7yXM/aUblPHEH9ks7KQAwciaR2wawMLlh9RFetJNJ/5GnyTmcUUMvwDBRgsYg9ZJ0h
         SexJAVqdZB8WBQEhvEf3o5RSlLFxkHTrk9iQomyguUvV9zDQt61B24g8St6/Z/lbVmrK
         coHemNfAdPomXSg897jHC7/1jVUPRLBl5FyddCq4YhrHkcMQ/2qrDGlo5l3o0tz3iKQQ
         Tp2g==
X-Forwarded-Encrypted: i=1; AKwUvBwwm9drXFQXDIbsb2b5WFjqyaerUPL5d4ArR5pRt8dJfFCgPO6g0XMBoIiQxsI7ddNfUuBGj+E=@vger.kernel.org
X-Gm-Message-State: AFuF++k5VnNtzcpcWwH2gfNil0NQPo4ifowCBy9rS+EqO8YspwDWxDIi
	9sBZAli94abGIbDXS1LXzOomQAW+2nvR4kavhKxZIvC9+X+X9XYOABmv
X-Gm-Gg: AYBFou3C+yUHnge6GcsReSt3hXQwEzR7sQJqEU+HI6wiZSSU3wzTP6/OAaz8M51pJWm
	VDO8mfw0ka1MzQWtx5JUxAZ9NFl1q2nmvFAiL/Ytxg4jAdZ1z4ljk+vBjaS9bYdb6tjlxiPopE6
	q1nwqHSLxC5f8ThtZihREp3HWKm7pomjtOedzY9PzMCb2qzEzAFm9IsmYDtcTAiknArcXNKy3TI
	yJLhl8k0gLuxFrjtLN0m4WBtWGELN2YVhOIr4COmNdACdzpJKUJPyM44bhX1ZoEBS/HuwHjkqQv
	Qb48iSpIaMVbkshsP3Di6v3PcPt0gzWlhkjK4PAUP6PEwo9msU5kyum4GPGvhq+X++ToP+buUdO
	pAedHjatvYEIjqZdFpV1DXlk1R/ajZ2mRDNzWVirdzaDieeSKegvfP5BP+BF0XtltHArY8tWydN
	rvS3mKMSf79m2bJrmO1QLr0ijejf0V0AjerXDZ2evTkyLdTW29uDyOACgPrpaS+ty7si7r6TyD1
	wkMLiLOao8SjodRJgFBtnJo5ovDSikczmvnU/P0qhgjgz4Z8bDqIGbhBFpMG1Ru
X-Received: by 2002:a05:600d:486:20b0:49f:e8bf:221a with SMTP id 5b1f17b1804b1-49fe8bf24fbmr42002985e9.22.1790290955933;
        Thu, 24 Sep 2026 16:02:35 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-29-83-136.business.telecomitalia.it. [79.29.83.136])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49ff06cbe57sm12288175e9.13.2026.09.24.16.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 16:02:35 -0700 (PDT)
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
Subject: [PATCH net-next v17 04/12] net: phylink: save phylink instance fwnode on phylink_create
Date: Fri, 25 Sep 2026 01:01:45 +0200
Message-ID: <20260924230211.11519-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924230211.11519-1-ansuelsmth@gmail.com>
References: <20260924230211.11519-1-ansuelsmth@gmail.com>
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
index 1156e6c61a08..9441afe372c3 100644
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

