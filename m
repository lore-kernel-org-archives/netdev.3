Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55B23FF886
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404804; cv=none; b=LjBiG+sQfnUWNdG+Y1cSkIJu/XrgxNmIFqtBbc8Hwn6Jc56Bv9yuYY2EqXNv4JrNtZG/MVu6Qq18eEirztsFLFJ78pRC5erCT4mNvJh4q0xsr2PxJFoEc7TxnffUSbt+XY9FY43xtLIP+Jsf0pEVsPSQW6fVP89N+7r17eJkb9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404804; c=relaxed/simple;
	bh=7YIoUK055QbwnxgdrRqy8vu378q7cq6ZCi0WNaHV5Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwVdf54bHqI8eLV00GA9jw4Ye+eex9K9Cu8wkaKvRt8FlePrR100sHYRGZ7bSoQCoYVkGWBYY73mpq1N9f9eLGXOilpdTYGVTKR+whUgpTbTvwjyH2nieuW35WINYxE3/nDl3jgWpl7QSH6rv7CkDfksj19/TRp489VGWKPVz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ViRxdtbe; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ViRxdtbe"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f7872abb6so1162943f8f.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 02:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1785404801; x=1786009601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=baJybUyIPA419BzDBxRSYysp0Hl6gSO+y/JjLv8m6Gw=;
        b=ViRxdtbe5yByM/SWekiO28rTXlCSF5y5TBEWi7iZZLIqD9ctqcbXRutRAtLIM1C3pD
         DVSNhLyAsRzV/Xka+EBYkwOtekFTwYAsugWgWlpdd/pFIfFfXK/fo+0QxjrKCDKA78QV
         bg3tRR3q7PB/3p/6spFgPuFSEuLhw6BRpFJ8WJ0SZIGx/doIRCCEsxV/a5Rdz/VAWtZ2
         3l6w4KO+mtQYEhmpiwu2/xizCFb6mCqu/uwttqq6WyLtu42joUbeJpJlwGpVJKDCMxAX
         5OX1qtoCZLSQNdUiD+Rs4C99rm8NPetzCRJOoIJ20tntzjsOcEabU2JkzEuOdnS5votx
         FfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404801; x=1786009601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=baJybUyIPA419BzDBxRSYysp0Hl6gSO+y/JjLv8m6Gw=;
        b=oALm9wLPFebiRHWTZoygMGFN0r3rde4jX2CO84DtY1cgBNCfTsik59JQygTOAjxYeI
         xwN8IvW3sRp5lx/G7y6H4OXW/6L9/9sGsxFoe+ps97yGcyhFUtUHTRzT5OQ/JMx3RuNp
         QECE2L/CVIGiMzNuHXHZpBKmXwskeu53/WLW41j7EEvMu2+z8v20gNpDqsEEYn3SnCbt
         2vft9SXQzIVC6Gdp0xbKZTxc2Wom/cTlXPibc59Wo2/Vn6biL8Qo9vEKnTSdPPlFiVI5
         O1v/jKYdNXd6RkLQggA/nDhYg551WF8itmWylhP9w9vkgj+bDXPgTJ12GXUgAPtZ8Fxo
         sD2Q==
X-Gm-Message-State: AOJu0Yzj5ftSJ3+4BzQ75inTo6EIMp1lKmEGT7zwxhrZ0KAcZPr0zwUe
	fUruMlt1fDPxvk+qM67QYY65fkwv1KdZgSwLWyZPn/84cNeQZc62lNjI8EG0oKs7MMdAt3Prn3L
	l4U1k/8GgLqpB43wodZY4xiSpa+gY3PRgfcld7POb3voB8VvlO6tC5q4Vh2I0ro4Z
X-Gm-Gg: AR+sD11eAoVLfT1i9Cr91YkyYM4WxHZ0q3EAYi+eIZqmUVSb2wocecjOATfkJejTHCy
	9IaOO5ZRDH85j9eG+AaBfGbGDP5XEKMnm2B07ASSfPwvchJ/zGw0IfTvJUxD5+KNOTi2lzYn3HN
	BhdASPr/U5kxoS8WyukenWQbKSQupxFxsLmPjlO2z0uq910wE5W8QGi7v6qzmpIC2jcLbFUDFpO
	ccSH49/nzG/nWO7uk3uBkHzbqVK4KEyFKESoGvk+a2hX63/ew1P/PU71r1CKxXLUAFZK1LU3TLL
	cb5Fi9hxq9kTtAFX66IhojIsVhW0poZWjQdL7l6jBVefcX/RjDXU9i9eKgXrhioxqHcOAaZsdl/
	vyqyAzS9k5xLQACHDS/ocoLB7PKEJz38sJ0UlKKVgee2z8ZeMnh3OM8UOqIzsnxxfO852W6HXJB
	NjBDKyKi2daxLz40TATHiR8RWr70Mpu7DhR2geRYG/YshFScqs+tEd60AN/DxEuYgV9akr6MGf+
	w==
X-Received: by 2002:a05:6000:400b:b0:47f:81a9:3f36 with SMTP id ffacd0b85a97d-47fc81c5eeemr2663776f8f.18.1785404800897;
        Thu, 30 Jul 2026 02:46:40 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:97f0:8a89:3637:d698])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e424fsm6971410f8f.14.2026.07.30.02.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:46:40 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net 08/10] ovpn: disable IPv4 redirects on MP interfaces
Date: Thu, 30 Jul 2026 11:46:19 +0200
Message-ID: <20260730094624.4102963-9-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730094624.4102963-1-antonio@openvpn.net>
References: <20260730094624.4102963-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovpn_mp_alloc() tried to disable SEND_REDIRECTS on a multipeer
interface, but it runs from ovpn_net_init() (->ndo_init), which
register_netdevice() invokes before the NETDEV_REGISTER notifier
chain. The IPv4 in_device is only created when that notifier reaches
inetdev_event() -> inetdev_init(), so __in_dev_get_rtnl() always
returned NULL at ndo_init time and the whole redirect-disabling block
(both the per-device and the per-netns IPV4_DEVCONF_ALL write) was
dead. MP interfaces therefore kept emitting ICMP redirects.

Disabling redirects only once is not enough either: the IPv4
in_device is destroyed and recreated when the interface is moved to a
different network namespace (NETDEV_UNREGISTER/NETDEV_REGISTER), and
the newly created in_device inherits the destination namespace
defaults, silently re-enabling SEND_REDIRECTS.

Disable redirects from ovpn_net_open() (->ndo_open) instead: it runs
every time the interface is brought up, including after the in_device
has been recreated, so the setting is always re-applied. This mirrors
what wireguard does in wg_open(). RTNL is held on the ndo_open() path,
so __in_dev_get_rtnl() is safe.

Fixes: 05003b408c20 ("ovpn: implement multi-peer support")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 50 ++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 9d9a0ff690d6..3a04757d5c31 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -35,25 +35,11 @@ static void ovpn_priv_free(struct net_device *net)
 
 static int ovpn_mp_alloc(struct ovpn_priv *ovpn)
 {
-	struct in_device *dev_v4;
 	int i;
 
 	if (ovpn->mode != OVPN_MODE_MP)
 		return 0;
 
-	dev_v4 = __in_dev_get_rtnl(ovpn->dev);
-	if (dev_v4) {
-		/* disable redirects as Linux gets confused by ovpn
-		 * handling same-LAN routing.
-		 * This happens because a multipeer interface is used as
-		 * relay point between hosts in the same subnet, while
-		 * in a classic LAN this would not be needed because the
-		 * two hosts would be able to talk directly.
-		 */
-		IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
-		IPV4_DEVCONF_ALL(dev_net(ovpn->dev), SEND_REDIRECTS) = false;
-	}
-
 	/* the peer container is fairly large, therefore we allocate it only in
 	 * MP mode
 	 */
@@ -97,9 +83,38 @@ static void ovpn_net_uninit(struct net_device *dev)
 	gro_cells_destroy(&ovpn->gro_cells);
 }
 
+static int ovpn_net_open(struct net_device *dev)
+{
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+	struct in_device *dev_v4;
+
+	/* the IPv4 in_device (and thus its config) is recreated whenever the
+	 * interface is moved to a new netns, so redirects must be disabled on
+	 * every bring-up rather than once at creation time, otherwise the
+	 * setting is silently lost after such a move
+	 */
+	if (ovpn->mode == OVPN_MODE_MP) {
+		dev_v4 = __in_dev_get_rtnl(dev);
+		if (dev_v4) {
+			/* disable redirects as Linux gets confused by ovpn
+			 * handling same-LAN routing.
+			 * This happens because a multipeer interface is used as
+			 * relay point between hosts in the same subnet, while
+			 * in a classic LAN this would not be needed because the
+			 * two hosts would be able to talk directly.
+			 */
+			IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
+			IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) = false;
+		}
+	}
+
+	return 0;
+}
+
 static const struct net_device_ops ovpn_netdev_ops = {
 	.ndo_init		= ovpn_net_init,
 	.ndo_uninit		= ovpn_net_uninit,
+	.ndo_open		= ovpn_net_open,
 	.ndo_start_xmit		= ovpn_net_xmit,
 };
 
@@ -183,6 +198,7 @@ static int ovpn_newlink(struct net_device *dev,
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 	struct nlattr **data = params->data;
 	enum ovpn_mode mode = OVPN_MODE_P2P;
+	int ret;
 
 	if (data && data[IFLA_OVPN_MODE]) {
 		mode = nla_get_u8(data[IFLA_OVPN_MODE]);
@@ -207,7 +223,11 @@ static int ovpn_newlink(struct net_device *dev,
 	else
 		netif_carrier_off(dev);
 
-	return register_netdevice(dev);
+	ret = register_netdevice(dev);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static size_t ovpn_get_size(const struct net_device *dev)
-- 
2.54.0

