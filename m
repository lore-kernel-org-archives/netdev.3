Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794529965;
	b=dxTMkzNGmDQr5oQVA2PJQeq/nFjFthbU0SK2y2BIyTNNp4ssTkMkxiu5vsdR6f1T0ec/
	 OTZI7Ei5K+UlFg1mdcTUooZLe6ViXauzDTVLNdftM9FlinbyG/IaOoDhyGWHeKh4kqQHp
	 BHzWcEQIybHjDn5m71U3+2vz4CaWhCRNaiQSrbM9SmG9YkZczV5q++7s52zP2ZW1QNNUy
	 DYn1PqlK2d6EBYgFy4B7pumZvMrQ/Xc/lAw/xImVZJhYY0y0XbyYzeLHNGScjtVnFKJKM
	 dbBbvhZScK6p59qalhPxWPCfO3gg+Ny8w8mSS0aW2UHYsU8tzofum8kbEShh5rrKijw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i5OFynf0yQ74EmgbLuwy7WCyI+wmTmFQ0TT8iw9nuIc=;
	b=tJbp6qmr7SLcQoai8a7zgs7juuLmSza9F2K7py/6S7iFqcS9pW0wesPyKZ4GG461U3yj
	 lAt7Ie+Z54JyzyFgfdnB5HMOTa2zqHGHx81TviiBHw13NJIUQMBCuHJqH4+cKOzcKRqje
	 fEh3lyDssNX1s+gzzfDXa6h/J87bP2PhQdR1uIXQ1csdWmYbor9hnqBVogqg6jteY12hH
	 /v4kVxv8OZcvZruDaYlxWyS8kxFwQxILzQy23PcLn+38e0TkQHOYChC8JdnpEyLwVoJCK
	 FEjRFH9qTUyEP4QOgbQZcmnA30VMsFn5/ElPeeUQ1CBffzc6T2BGQza8QUvm81YxjLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s6Zqrcms;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0411B60A3822
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0411B60A3822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s6Zqrcms
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-492f563d1c6so206751f8f.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794529963; x=1795134763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i5OFynf0yQ74EmgbLuwy7WCyI+wmTmFQ0TT8iw9nuIc=;
        b=s6ZqrcmsfrZxKw51u0kIJBbXbxP1aIplLOFEAF2AEon8PK9evOz3a/LxZRmDm4Eq7Z
         qau2gRwBQYkzBLsf9GIFaawrSn1G1wf2s0YdQNKby5/MPCOea0zFNbFeRW+rN/A3RQz9
         vBpUi37Pd0jjyCSCRZsUdK7DZ+RtcvxJCfgKAHXAoWqH4+PSe1gCBD+eLvDSpInxTLAh
         2De8XWBr0RojPqk6BzkkHFu0PanZB5Vb+cvZWZbVAWwqJ03ibU2JXEAXfMaYaBuBmmS4
         YWTwYC7FwQwHSa9Q+CFHBwRsVuyCOHIGKkc8Bxhwrsjd8c5B8pkUWYOGT/dmI7Rj+2xE
         +QnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794529963; x=1795134763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=i5OFynf0yQ74EmgbLuwy7WCyI+wmTmFQ0TT8iw9nuIc=;
        b=SIqBUvwspTS8lwnPvF+CNtuWoBITm7g1+wWq6EY51FNc7L1DTBqLJ4JYbmqSIsHX/g
         AazTJV7ggeQghZw7H+hbJqcUv4699iy6N+zx2fOkUasjtTVTqwfSBnx4RBufD94dbmZi
         DUk0g4MLUFi4gqh+UCcV4NavZPfjVXryeBQVr7Iq+cxALrL1VlZAn9b/mLIQNcT4ac6X
         IGgYTs1QnzRjuS8hAapjaK286x2RSgoe7mVB73JtW9EcB3DZoMcr6u/B4SIg5PVJKYHN
         P0GjRx4DVc1gOOHquCVOfaX11Eg7364lQbcfbxCYmm1KpzZ/fuZDi9FafBfsQMK21nqC
         kukA==
X-Forwarded-Encrypted: i=1; AL+hErEccBS9HgChbvmouB6q6jfYPRkdPDyLxfk2Qz0raHZaJa/HYL8iO+kZSXMfyexdLnxHNLFFqH8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UfEvT2wjQVhG5IUzN0sU6tB1UJBiIL9dnLfskWgde8lVTaTsV
	JTOK0uIQCe670YTYkkEzoBwx2oRHpMkfv3q1TSXYvHTyo2bauMBgD9u2
X-Gm-Gg: AYBFou1D3YHnoQca+h0uTWHn1fbFxZ17GRDXIFKuLFPzUNTKSNE74FYNJKaydf90Tk3
	F40x89ftwzaWr/nAWtgHOuMlluJPeKgEzzpPP24S9XSZN/WYjhGTNWa/J/dU89NopitBCWsv8Vt
	BIbtaKWY8hbERZftFBKdSDSUnAK/OxUtGsZDHNEejH1tA4j7SMWC7HFqCWyafUKKg2pE7o5hIoR
	0w3iHdTzAFaDtpRWOAn/FfuBnzb1lj9RDvogCdyyVNz8mJGuUY+q7pma8PeFFZRiGLX8iCb8WzR
	FgF4NpAkVC9t1eIu5MIu4ahp3P7Y+yLPtho5faCcYPfTeZNJ+2/HOlXmxp22AL++NqSmawuPTpK
	UZg4z5i0Q34bosYwb+e4/aJaXg8Q67q3giYql3C9cCH1IJssivqFdxjQQS0+Be2IPfqRZdxV7bb
	tz2CAv67wkGEM3C77tHk0O0Km6nv2EAUilEgR9svqA9I+lveLtZXA3yEW9FiOSsfZ7fZqZFAzgM
	Ela8ciytNy3a6aIwUZjVLVYODQRU+zotOkX7/4GQkDfBzGloNmKcDJjO4Sn1V1F0gvQ6N6aSLxS
	g9+WBCtut51rC0IuHVJktdRmMTjAoOhIr7GtdtbM8q2NjLk9ijaWh1QRaU1IJ2rNxWzwTVzIHTi
	mohg+puv8WgePtC+fQB1OoLaGtNiW4QEpmo5M/Nc7FtjsB6+fsnfo0atIAzyFzz8wB4jmSa4nzr
	I=
X-Received: by 2002:a05:6000:2085:b0:48e:4e00:b737 with SMTP id ffacd0b85a97d-49c73a050e5mr2244067f8f.54.1794529963290;
        Thu, 12 Nov 2026 16:32:43 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (host-212-171-11-167.retail.telecomitalia.it. [212.171.11.167])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5f7828a4sm2029768f8f.23.2026.11.12.16.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:32:42 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
	llvm@lists.linux.dev
Subject: [PATCH net-next v19 06/15] net: phylink: make phylink_validate state locked
Date: Fri, 13 Nov 2026 01:31:56 +0100
Message-ID: <20261113003217.197757-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113003217.197757-1-ansuelsmth@gmail.com>
References: <20261113003217.197757-1-ansuelsmth@gmail.com>
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

In preparation for support for PCS release/late attach, rework the
phylink_validate functions to be locked under the state mutex.

With the introduction of a notifier that can be called concurrently while a
phylink_create is called or an interface mode validation is being run, on
recalculating the supported interface and capabilities, an inconsistency
can be introduced with 2 validation run at the same time.

To handle this, make the phylink_validate lock under the phylink state
mutex, add lockless variant for phylink_validate_mask and phylink_validate
and add lockdep check to make sure the mutex is held in the inner
validate functions.

Function that already run phylink_validate under state mutex, are updated
to use the lockless variant.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 47 +++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index e2e0b313fd61..918aa95e5a64 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -9,6 +9,7 @@
 #include <linux/ethtool.h>
 #include <linux/export.h>
 #include <linux/gpio/consumer.h>
+#include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
 #include <linux/of_mdio.h>
@@ -550,6 +551,8 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
 	unsigned long capabilities;
 	int ret;
 
+	lockdep_assert_held(&pl->state_mutex);
+
 	/* Get the PCS for this interface mode */
 	if (pl->mac_ops->mac_select_pcs) {
 		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
@@ -628,6 +631,8 @@ static void phylink_validate_one(struct phylink *pl, struct phy_device *phy,
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp_supported);
 	struct phylink_link_state tmp_state;
 
+	lockdep_assert_held(&pl->state_mutex);
+
 	linkmode_copy(tmp_supported, supported);
 
 	tmp_state = *state;
@@ -648,15 +653,17 @@ static void phylink_validate_one(struct phylink *pl, struct phy_device *phy,
 	}
 }
 
-static int phylink_validate_mask(struct phylink *pl, struct phy_device *phy,
-				 unsigned long *supported,
-				 struct phylink_link_state *state,
-				 const unsigned long *interfaces)
+static int __phylink_validate_mask(struct phylink *pl, struct phy_device *phy,
+				   unsigned long *supported,
+				   struct phylink_link_state *state,
+				   const unsigned long *interfaces)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(all_adv) = { 0, };
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(all_s) = { 0, };
 	int interface;
 
+	lockdep_assert_held(&pl->state_mutex);
+
 	for_each_set_bit(interface, interfaces, PHY_INTERFACE_MODE_MAX)
 		phylink_validate_one(pl, phy, supported, state, interface,
 				     all_s, all_adv);
@@ -667,8 +674,22 @@ static int phylink_validate_mask(struct phylink *pl, struct phy_device *phy,
 	return phylink_is_empty_linkmode(supported) ? -EINVAL : 0;
 }
 
-static int phylink_validate(struct phylink *pl, unsigned long *supported,
-			    struct phylink_link_state *state)
+static int phylink_validate_mask(struct phylink *pl, struct phy_device *phy,
+				 unsigned long *supported,
+				 struct phylink_link_state *state,
+				 const unsigned long *interfaces)
+{
+	int ret;
+
+	mutex_lock(&pl->state_mutex);
+	ret = __phylink_validate_mask(pl, phy, supported, state, interfaces);
+	mutex_unlock(&pl->state_mutex);
+
+	return ret;
+}
+
+static int __phylink_validate(struct phylink *pl, unsigned long *supported,
+			      struct phylink_link_state *state)
 {
 	const unsigned long *interfaces = pl->supported_interfaces;
 
@@ -682,6 +703,18 @@ static int phylink_validate(struct phylink *pl, unsigned long *supported,
 	return phylink_validate_mac_and_pcs(pl, supported, state);
 }
 
+static int phylink_validate(struct phylink *pl, unsigned long *supported,
+			    struct phylink_link_state *state)
+{
+	int ret;
+
+	mutex_lock(&pl->state_mutex);
+	ret = __phylink_validate(pl, supported, state);
+	mutex_unlock(&pl->state_mutex);
+
+	return ret;
+}
+
 static void phylink_fill_fixedlink_supported(unsigned long *supported)
 {
 	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
@@ -2117,7 +2150,7 @@ void phylink_update_mac_pause_capabilities(struct phylink *pl, unsigned long mac
 	else if (pl->sfp_bus)
 		linkmode_and(pl->supported, pl->supported, pl->sfp_support);
 
-	phylink_validate(pl, pl->supported, config);
+	__phylink_validate(pl, pl->supported, config);
 
 	pause_state = config->pause;
 
-- 
2.55.0

