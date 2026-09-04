Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB85221CB
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548612; cv=none; b=O/SzfVwqx1FvtBt1oQdqp+u1aWBbARLhyYCqA3+k1/4LGzI6uJzKRNnNYStGKx8VA3pLYKzQbXVbSVUHbc9dpmx7dW49UXAKFs/03uXDyTNRNAaoKs2AGop0Po9RonTQP2ElfhXYXRPPSbnjLGTEQPpj7ikCmy7VXKsqu9RJoOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548612; c=relaxed/simple;
	bh=yfXfFA1c3vQG1+Ye7UxWHbvarQ+1G95ouDiPWPxXcDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClVIWoJFz2j0vg6VQW0nCg6FnZJV5UrwAOlJnLekbjXmuh463vU2KquPVxdPPqu/BJzWNsSG6ASh4qDPAe5a1NvG8sHZHzPb5f34OXIAOQri0chZ8hyF2CHy8g+FRSB7YKFPnZQgq+s7560MDcjBVlX6boMrVUAWpn5htjLOpRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=ImrIV0QB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="ImrIV0QB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49b965570d7so15621265e9.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 12:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788548602; x=1789153402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CMh5lYeH3aGg59+QPJC3P1Oz0qgidcMVPi+b3gENV5I=;
        b=ImrIV0QBDWDa+c0k+n6kxLTZHjzwJHDk2j8ufKEhKQDtEuoRIO0wqcRun0gEAmgzZf
         IuqmFY/Me8AHvL6tynrV1tAF+YzVOPSmc40UPjS4nSxc8Pn9HWcMkPj5q98iL8vTyOq2
         EzHLx8k/j58sXebjBSR+WPYaylDhEgC5SkiqFOENyDoCYohR3iUUZ7pVBZcHL0/WbC7N
         Kj5G8bkt09IM5uQwLKGX0ZZUPG/uS1rBQ+hrjFzUBqLdQGNc9pTAAqadjqzolhCgF+5p
         sgiN25OuQHt1WcieE1fQjdZrd3UkFIGtWt1CeEkqhYFh9JsF+ktA2iaTJBcoQM8LzpeF
         6Ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788548602; x=1789153402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CMh5lYeH3aGg59+QPJC3P1Oz0qgidcMVPi+b3gENV5I=;
        b=CUw8SLWvrLLvzwe59p9jP/oJ5c7+fpBj7abfJ9qYYnVpiwuGOprOAsMUnI+G0EIMDo
         iH1gHypsDYA44NGgNx7jtSmusIaXDq9+CzQKfMvcWOnvmEWxIb7Zt7ZbRE+LU9u1V4qi
         +It2kFtH0EoxFKVXYb/0mO1yZfIvM6yZglxYxd//E8C2ljNIEB+84spA+jOj/fetwQQz
         TRbaYydzrsOrBCmfRL0edtkBaGXXv0dEquqFnY1+xY96rvOspN1v5qdCD7ZKZpiSlh2D
         Lr2X7TMeif432MLZ/yKBX3LlbpC5jGa0Xxw4knwZsLd5S0kDVk9IbGr4gf/kOzGJAenz
         kGFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxCnFhyFqP1SjkEndA9Qo4KK5c6XSS1+0ynxFLyLlrnXhoya9pdKgkWoVmg5hSPttKCzWC0+qM=@vger.kernel.org
X-Gm-Message-State: AFuF++mFOF1EeW0M5CW4SCjeoOaivkRIHx3oisDhQ3kOPzjtl+y+Qwk3
	yn6zkX9edIOBXlUUxkkc3Mmer1lDx1PokhzsULZ/9apYy1WWOlGdyiqDSwx3qnobQso=
X-Gm-Gg: AYBFou0rKoGPxGLXe9aaOy7s589UiU/QJzStxV+tvVO29oSQ9P1kLoJCKZHfB8wLkNx
	Du4/MZbmHTUzCax3ZP8iqVMB4EfcxVTbi/vH7nuUq4YQ645+aiGWCG8NwnitQlgvAmMzegTZtoX
	JuixWaayhZ4HF62ZtmmDgMNt77ve14d5zW/pP9vuCIY+YnyzyIUIGcjFHpDVCXErgFESX65mLRo
	G7wLgcZqwdqbPP5udYWZb2ND6yTnQF/Fan/c0fXs72LYhgaZLTUf/m1bY2+jmaN2Zm4BtYyzI3F
	uIOZO+grbhgj6sMy81oUhRmxb9JW24rDth3XaHrpyK2CuTax920mYc6lWk3kGWgJUN3jDqBCJwg
	wyj0sRk5RqEKUQVcxZlBYCktf6KxS3R14zabcLxepDnJNRoFfdOKPVnSEw/79UUeqR2zaZmsL/h
	quG+9MWt1vVmFWZ6MYQgBfLC8MZBSdvTlKE5imQbI=
X-Received: by 2002:a05:600c:4e11:b0:49c:f2f4:eddd with SMTP id 5b1f17b1804b1-49cf8268795mr95772385e9.16.1788548600659;
        Fri, 04 Sep 2026 12:03:20 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d8a6sm172195485e9.10.2026.09.04.12.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:03:20 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next v2 10/10] net: phylink: report no link modes while a late PHY is missing
Date: Fri,  4 Sep 2026 19:03:04 +0000
Message-ID: <dd73c57289fb07fef0da931709ae4a957b5fdf69.1788548229.git.f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788548229.git.f@lex.la>
References: <cover.1788548229.git.f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A port waiting for its PHY reported the MAC's full set of link modes and
accepted settings for them, which describes a link that cannot come up.
Report an empty set and refuse to configure until the PHY arrives. Every
path through net/ethtool/ zeroes the reply before the get op, so the
pending path only stamps the unknown speed and duplex.

Setting pause parameters needs the same guard, because it is gated on
the same MAC-derived mask; reading them does not, since it reports the
configured request rather than a capability. The EEE calls need no guard
either: they already return -EOPNOTSUPP when no PHY is attached.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/phy/phylink.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index bceeac954779..942d5fe943a1 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2290,6 +2290,11 @@ EXPORT_SYMBOL_GPL(phylink_connect_phy);
 #define PHYLINK_SLOW_PHY_WARN_MS	60000
 #define PHYLINK_SLOW_PHY_POLL_MAX_MS	30000
 
+static bool phylink_slow_phy_pending(struct phylink *pl)
+{
+	return pl->slow_phy_fwnode && !pl->phydev;
+}
+
 /* Bound, not drv: drv is published before the driver's probe runs. The
  * device lock cannot be taken under rtnl, and losing this race costs a
  * generic-driver attach, not memory safety.
@@ -3087,6 +3092,14 @@ int phylink_ethtool_ksettings_get(struct phylink *pl,
 
 	ASSERT_RTNL();
 
+	/* No PHY yet: the port supports nothing, not what the MAC alone can. */
+	if (phylink_slow_phy_pending(pl)) {
+		kset->base.port = pl->link_port;
+		kset->base.speed = SPEED_UNKNOWN;
+		kset->base.duplex = DUPLEX_UNKNOWN;
+		return 0;
+	}
+
 	if (pl->phydev)
 		phy_ethtool_ksettings_get(pl->phydev, kset);
 	else
@@ -3159,6 +3172,10 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 
 	ASSERT_RTNL();
 
+	/* Would configure the MAC alone, for a link that cannot come up. */
+	if (phylink_slow_phy_pending(pl))
+		return -EOPNOTSUPP;
+
 	if (pl->phydev) {
 		struct ethtool_link_ksettings phy_kset = *kset;
 
@@ -3373,6 +3390,10 @@ int phylink_ethtool_set_pauseparam(struct phylink *pl,
 	if (pl->req_link_an_mode == MLO_AN_FIXED)
 		return -EOPNOTSUPP;
 
+	/* pl->supported still describes the MAC, so the test below passes. */
+	if (phylink_slow_phy_pending(pl))
+		return -EOPNOTSUPP;
+
 	if (!phylink_test(pl->supported, Pause) &&
 	    !phylink_test(pl->supported, Asym_Pause))
 		return -EOPNOTSUPP;
-- 
2.53.0

