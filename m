Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66B3CFF49
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271317; cv=none; b=ZUG9Oa6l0CEGrrTQhESGQPs7mBaEHDDcv1wzT+pEqRyqtR562ZS8xDjx0SOgYdq0eXwFjjCtYI282npGvrTJkj3sTsK3eVmBzFteRjoH+G4OdbKkF20i+u3vveG+I6E9xNCKeQhaao2dNct29p7d6C51u8W4z3dys0UhJgADcuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271317; c=relaxed/simple;
	bh=t6rY86OMbolsiiPK/GOuF3k7hVJufXxgtcjDITLWnKE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwmT8u082K6fclH4hfPpeuxdWoU2AUJIwGoA9+YCFyUoNpkHJhQZ3Q8DqxZSsS6I5PLSghU/K4WF3xqOhc6bCCUwQQPUgN6M0UMXK6xxW/fPJgCIEK03QefZQfyCokKKkmq3WXGUDz1Ivtn/NrN5HkjGZmx/PSpb7b7c0gLArK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkatuaPH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkatuaPH"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954c0833b4so202685e9.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 23:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784271314; x=1784876114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G19VSnYnZsX2bhJ6fGMWN3T5ZdGh6Kgv7ZnCXAAQInk=;
        b=EkatuaPH4Ly4HPZhwCjywiSVHXYhXF6Z56LU4mONXr8vBPQBsqIZV4wsDM5x/Tsf48
         aARKotsNamTXlVk1L2tlBR9HM3HCCfSgu5QwZa1bL+/PrzwxuTWavj3k/+UYNFbk0LXG
         p5/2DI/M4AnOGfcupDIQdStNQZ57e2aNHJW4omyGiUMnHJocAmyEVCeDc/lK1R2MPaeH
         hzXBEGuZKCZ6EHZpi0eCxBHlbNcpB8Bzg9WGqZWmZcKl7Ylq6kxT2aPCA06xhGk4VQs0
         QdAnZTe2+sJNZbS+FZlQLU+UQSpPVAl49+Pajhn/Ig36Qa9SBw+/TgINvHoYlA4wH9ZL
         tl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784271314; x=1784876114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G19VSnYnZsX2bhJ6fGMWN3T5ZdGh6Kgv7ZnCXAAQInk=;
        b=suprPWnNgpwL0FjMCjlTK6RxM2SdjydIDWYmxQrtGix8bqKTgkkX/DW14pApXYskLi
         USY6r1kq64PuWAPftV+mvUkFInH7IDdJdA4WEJzG6JxVEcE7c9mUhMV3SMwU09Wbqm44
         +GUWIdehDgFAHsKLyLtZbcK1I/yJU6ymA10qIXv/CTNgKl8MO2tGGE+EsJT6hmJQYnAD
         v06yeaUlMy5gcow3Cg+Kh/hvuW0dLhgY8+w77R9vzN/H1sc1MDod6sirpOqPmrTVjlQQ
         LGyyT4HnIps4SrHLNb34TRtbaNxGgj6pTxIKsxNiRV1HuMCgOXtTSmLm2xBvDW4dfqO/
         QNHg==
X-Forwarded-Encrypted: i=1; AHgh+RpFKtULkJttRkYj9Rq3rwPiVo0dblCUbOPnmnCFtguzod74VqmpxAfsO5uEaOlbIManseaD6QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNKvQpsW11Z/NJ6aFXwOrLYLWPKjZ3VEyOsOjasidyipSHS95s
	fP8X7zkwveet8CjL8k3ZTGSKyAdzG7JLpKT9SpbPXt7tbmQdg10xoutj
X-Gm-Gg: AfdE7cnG1+FeKS2Zw1A0lx2vrFcry7+rlHbjrQ2vYpeL7p9mqxYF6FEZms0x0gLv7nR
	VA3NxDJc/Uj9FmASK2wJyHRgnpXQPWy6ry6pavSqTdW+TfFtA4cjfB12zks3gX19vpbiNLrUdnp
	ECeCTvaoH+6tgvJMoypjQgRcANTnB+QsxWQDe+xl4PoTgTnC2e/d17If51MaaoNjScpKJMwYO1I
	giUtBlO/0m0LTs7fCKKYNDMYS7G0Kn9m7lRoEs7+07ApHgMpI+Zax5mXavya40jAVUo+dNRAy8M
	iZAZumJeIwDVe8zslz3gWQwRhLaRF1vjx3y3o8KVnzRUIrnd6Yhjmr3HCHuunUEikdvPp/tjP8i
	h0m21kUF3AlGIWh+B7H7rV7H0s05II6+HSKd8n9WG4dGuDdBeOEgTksBWTnpT+ffUAdM6u9Ak0R
	BQn0BQHZBm7QEYnJKtQeWKu8f276wmY2L3/yVuHrxfKQHNBvMOS6GnbKDO8+lcXP4VOyFOIwfDR
	ZU2L4s3
X-Received: by 2002:a05:600c:5253:b0:495:473b:f439 with SMTP id 5b1f17b1804b1-4954a3ec6b6mr11503595e9.3.1784271313573;
        Thu, 16 Jul 2026 23:55:13 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-495499f3f99sm24260835e9.0.2026.07.16.23.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 23:55:13 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v9 03/12] net: phylink: add phylink_release_pcs() to externally release a PCS
Date: Fri, 17 Jul 2026 08:54:03 +0200
Message-ID: <20260717065448.1498335-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717065448.1498335-1-ansuelsmth@gmail.com>
References: <20260717065448.1498335-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add phylink_release_pcs() to externally release a PCS from a phylink
instance. This can be used to handle case when a single PCS needs to be
removed and the phylink instance needs to be refreshed.

On calling phylink_release_pcs(), the PCS will be removed from the
phylink internal PCS list and the phylink supported_interfaces value is
reparsed with the remaining PCS interfaces.

Also a phylink resolve is triggered to handle the PCS removal.

The flag force_major_config is set to make phylink resolve reconfigure
the interface (even if it didn't change).
This is needed to handle the special case when the current PCS used
by phylink is removed and a major_config is needed to propagae the
configuration change. With this option enabled we also force mac_config
even if the PHY link is not up for the in-band case.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 56 +++++++++++++++++++++++++++++++++++++++
 include/linux/phylink.h   |  2 ++
 2 files changed, 58 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index d96941d4c523..986e0c1e3d67 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -158,6 +158,8 @@ static const phy_interface_t phylink_sfp_interface_preference[] = {
 static DECLARE_PHY_INTERFACE_MASK(phylink_sfp_interfaces);
 
 static void phylink_run_resolve(struct phylink *pl);
+static void phylink_link_down(struct phylink *pl);
+static void phylink_pcs_disable(struct phylink_pcs *pcs);
 
 /**
  * phylink_set_port_modes() - set the port type modes in the ethtool mask
@@ -917,6 +919,60 @@ static void phylink_resolve_an_pause(struct phylink_link_state *state)
 	}
 }
 
+/**
+ * phylink_release_pcs - Removes a PCS from the phylink PCS available list
+ * @pcs: a pointer to the phylink_pcs struct to be released
+ *
+ * This function release a PCS from the phylink PCS available list if
+ * actually in use. It also refreshes the supported interfaces of the
+ * phylink instance by copying the supported interfaces from the phylink
+ * conf and merging the supported interfaces of the remaining available PCS
+ * in the list and trigger a resolve.
+ */
+void phylink_release_pcs(struct phylink_pcs *pcs)
+{
+	struct phylink *pl;
+
+	ASSERT_RTNL();
+
+	pl = pcs->phylink;
+	if (!pl)
+		return;
+
+	mutex_lock(&pl->state_mutex);
+
+	list_del(&pcs->list);
+	pcs->phylink = NULL;
+
+	/*
+	 * Check if we are removing the PCS currently
+	 * in use by phylink. If this is the case, tear down
+	 * the link, force phylink resolve to reconfigure the
+	 * interface mode, disable the current PCS and set the
+	 * phylink PCS to NULL.
+	 */
+	if (pl->pcs == pcs) {
+		phylink_link_down(pl);
+		phylink_pcs_disable(pl->pcs);
+
+		pl->force_major_config = true;
+		pl->pcs = NULL;
+	}
+
+	mutex_unlock(&pl->state_mutex);
+
+	/* Refresh supported interfaces */
+	phy_interface_copy(pl->supported_interfaces,
+			   pl->config->supported_interfaces);
+	list_for_each_entry(pcs, &pl->pcs_list, list)
+		phy_interface_or(pl->supported_interfaces,
+				 pl->supported_interfaces,
+				 pcs->supported_interfaces);
+
+	phylink_run_resolve(pl);
+}
+EXPORT_SYMBOL_GPL(phylink_release_pcs);
+
 static unsigned int phylink_pcs_inband_caps(struct phylink_pcs *pcs,
 				    phy_interface_t interface)
 {
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index ca9dfc142388..15e6b1a39dfe 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -751,6 +751,8 @@ void phylink_disconnect_phy(struct phylink *);
 int phylink_set_fixed_link(struct phylink *,
 			   const struct phylink_link_state *);
 
+void phylink_release_pcs(struct phylink_pcs *pcs);
+
 void phylink_mac_change(struct phylink *, bool up);
 void phylink_pcs_change(struct phylink_pcs *, bool up);
 
-- 
2.53.0

