Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3695B4FECC6
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570551; cv=none; b=oRW6U2734LdO6HP67rkCKZ0Z2KvPpptJFvUBOMC46hhD5T622aQHJJdy7rCeiAwZGelA/40/8WMxQ/nfA+nFqsD6UNAMjvaJ1rP7zBHx6sLsArAda9yKCyy5rfJS0b/No3ThiySeaTdmtCW2FreAMe7Lt98P6TMFzVK1zmLfzRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570551; c=relaxed/simple;
	bh=m5HqqAwvf714jhn9AtFujlH/Cfft9cIXbM/MO6suoWc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUti43gT2rIxC2Z0Oa3aDWsgdSJRD1ouGr7NaY8yLs+D4zVU/d3fqSsoY2/I/+EQLIAe/46J3NyXgsDdh2QE/jK5uwdZbIuxQdvujEicM/mE9V5/2kZrR5s4lFCdcdkmeC3DJbFnTXarrbpcvWyuao86p3tFfrSWbmnu/3h847k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmTrLDb1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmTrLDb1"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4d870d54so58116f8f.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791570543; x=1792175343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VDqbFLObsehCe0sJ0clGiEdbuZFFJjsJjNFUc+Lf4xc=;
        b=GmTrLDb1MWwldnZ3d2c5G45p4fXiG+jIr8tqArrqf64NbatwXybyHqRyyu+RWOuvf5
         ootpzgbp/S2vMiBIiV4pIgYS/KiReRONIYhtQ+n8vkKO+wqkjcMnCVSmUnP8x/fz6lAx
         23jb9FyUmeGr4XCrIrnm0LHwFH7uluWyl06L/TSsP6wzeQopWCHkTHV9VXI9sHsrhjTy
         WYoDXIpa23jNALo169N3EtG8MkzwfNxxbFGNXDG7GyLCqk6k0sovJwvAYASDYkN1Ncnx
         86MCfWVMkUoyQTjpeszKZLfZ1vZ7qznDJuZrE488FAPK+8QFdDBRkUlvOmdIL9SD6vIR
         RxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791570543; x=1792175343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VDqbFLObsehCe0sJ0clGiEdbuZFFJjsJjNFUc+Lf4xc=;
        b=kjyIvI170LMxvtXlvaXNG1EzjDmlzI5F0INwlJD0FRSaq4eKpWak5cAbLt9x+25meK
         GRiGcbAiJvBkztRR0t7ZFSNte1Kpf0oitryAgdTWiEjZsyMyEJ9wqlJ5jcuEMQnO9HZk
         hVqQlz8Q7+zemUIv0A8bKZpP6wNS5LZpJUh7AEc2ZA9n6y6Ml+q20xexYlWC0wCF2zC3
         0ySfBZlME4WzOeeW8cXHtLHcN2sTlfLlXifbSuC4KP3XX1h0m2q1pYe1f29Snj5/ZNE6
         Kr42XZFyQ3u+UFnZxUDfd44anW0XY1HxmaEKnsrZq1hdOVmzR+ICbjh13azkOKO3rp5+
         oGAg==
X-Forwarded-Encrypted: i=1; AKwUvBzTQq/HuZwQQwpw47VjXA2jQIiAkznlAhbksuPBey9Ix0WcUVWM2B/AVE5x9WrIyNAXGnY8otc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAbsSWk3DZ34N76wG7jML6tnlnV9RUq7ZzUaWEUcF4XZqUEEGi
	UHYyw6HOGRPdzJTSm4bA546SJycU56TleiY4FB1ogHJOSmZQx4UuVkkb
X-Gm-Gg: AYBFou21c6dHVtYNVSZqa7Ih6XeqjRGRuXc8OqxrRJOGzC3pHSoxhI2SmrqfmOFdXXE
	UDpIs78t+r0pluxAJcIypRg6B46WshRVeg9KQZvQC03/BkOe8DZec15Ql3KA8uGfy05Ls+WEeMe
	KeuW5Ljh/Q9CKwg+5aY0WNKsaxMVZnw/NaxYHaUhdgujVHH+Lw+zHraudfvbYtniydDDAJ/xWUR
	xqgbdwkW5ErxmRa55Te0jX6r7LbKdiiFy574EnjfDKxe/B3yubT7+mNh8n643kM/m6uUrZ9s8n6
	J+R3NRXXXsVtNMX8I2rBLsWKbYUYbVpZMi7ooI7AMXFiLuL5s16lJ7GvyeXD29uxpK8Z2oZV5NU
	Bo1LcMOKVtMh2gVHiIZ9CLnYi2JcZpyAOLSZgjsF0RtJZbgfnRXRI3ufbSe8p4EKoPfSHmZMYBI
	Ifsy6E3D1tK3exiEu3z8uoW5czofF76R4U5Px7/ybZeGN3LgYsFS2bbmW71toBdV/8qyzR3R/K/
	XKUD1fawwBI2/ip9XLU7YnFzVtCL7gHPYhWBCuXOibH4b2rVRAFE0oJjHLhn5FCHE1ocgBIz2WJ
	WpNq9ZLs3Rw/27ktug==
X-Received: by 2002:a05:6000:25ee:b0:48b:e50:715a with SMTP id ffacd0b85a97d-48dbace01abmr5330100f8f.34.1791570543097;
        Fri, 09 Oct 2026 11:29:03 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-213-45-9-252.retail.telecomitalia.it. [213.45.9.252])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48db9adf5e6sm5037794f8f.56.2026.10.09.11.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:29:01 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
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
	llvm@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v18 04/12] net: phylink: save phylink instance fwnode on phylink_create
Date: Fri,  9 Oct 2026 20:28:00 +0200
Message-ID: <20261009182836.50631-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009182836.50631-1-ansuelsmth@gmail.com>
References: <20261009182836.50631-1-ansuelsmth@gmail.com>
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

