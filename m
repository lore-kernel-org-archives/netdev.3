Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E483EFD04
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404796; cv=none; b=VBiMAG8tqzWyi3liXWaKQnN8QIl2lvmgCyy++H+31+9MboPmRDCGBbd0oG+URzyS/Jjl+ylnwqltGXTOxLYibHRypGVW7V5cn+YnGrYKI6Z3vSvN8wxDZ5URKFmRay01rJD8NddzUsgzMpbng0Lxjf+f9jvRjFMz2uPAQwU0pEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404796; c=relaxed/simple;
	bh=lC1SrqJQblKrqItVDcvl0MUO77hDHYgoTD8kArcSXCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+DiYlMq2de7HR4WQ8411bmRCVj+TGexxne1tJRG6EsduuKZzpQjRn4ongetMq3osz1AhnDmU9GwUtd6OUyGw+d3Kl4v5pfsqnL3yNLPWrQLjru1CP7B5wy5lxWBb4W+qC+9QeYEl4Q9I0VA94SlkOBB/7/LhePKONblrBDT/qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=K1MPh04y; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="K1MPh04y"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1141765f8f.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 02:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1785404793; x=1786009593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=15oQURTncK+pFxmxR0CvsVgg+tM2vtL7pK7rnpoPYX0=;
        b=K1MPh04yLYDe4R8G/RU8sWoie4omFjjb16sUOfRzRDdpXG72JUr8D2F4AHEBGuaSQu
         7Lal5dg++0A5mR1OAmqxYg0USzWWaIZajBsD/+fPe78IicZT97jB4Sa7vhjUt3YBnwZd
         67pPmvgXMoy4gSP1bhkTdYh1WzpjbGKngrZtDpumzgfWvwPTG6l3bMmvgd80xpT3oFPR
         EzbkI131Zmx3RRgyw4Eyc5kQnRvXQePqvSkpE/ezZAD1r+K7SigDemgWfFjaR1b4NgnV
         JJtUe6h2rV7XXtUBownutD04utIvaefVqKBvVNEU37TJu3E9U6DVcQzhtodlKmZqIo85
         bv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404793; x=1786009593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=15oQURTncK+pFxmxR0CvsVgg+tM2vtL7pK7rnpoPYX0=;
        b=bqSztsxkAJCPpZCT6adzrF9QTeFVWxdNzOn8OcY2ToDIW9VE0rlS16SnkvjmHITiAr
         Suvrxib8ABsiiXq9AVJkb6tiPzJ8O+2FItci9dpftuyM2Q7ixt/J/p/s38pGy5bk5/uo
         zDJxo7v2Y57UZEZPY94tDznSTxcpMpV9HXEISEtUUoUbgEeiNhBnpOHcSrHzFxttrDhi
         HjnfVOo16rv9OzNVH4TVG0yKPoHCH7i4fYx3bt3hJBJuIZId3ndDpg02yLQDQ96QDnLj
         2YcMAse1oHYc8x68PnOhQG+AHC54teROzzX74BPR4Eo6yWzFFvxV7YF8eQH6gItUFWMJ
         o6Qw==
X-Gm-Message-State: AOJu0YxT+cugvbqf2ru+isKP3wpQb9n0xKauhkIc0XJ4MjIk3pOKZ+FB
	QrciYHKo9y2v6Qx6NGCizYx8qop6uCDC/cPj8qk8cweMQNkjsZOs3TTKrky+TUxYxCIcE0vwYCI
	NzgP+FllTWSzSawUJ+55Jsbi1Ws1BWm+AkMV2BVPufLpp8uhqQDd2qP/tanSORtGW
X-Gm-Gg: AR+sD11WqvL/Kr92d5/Sd5pvqlTI4sKDuzFy4nbRqBX75/Ffj4Yc91zbEoXcNXR8dN9
	pPjQIfYXkD1hgxLyt27S0d7Obnpe0Ap7+2LkNsWnpLPWdAIzVxqsDOMHs1lZ0lXQcmfkHUgT1U4
	GEK02+lbYZz93lLUTxfXVoGoHyt6f6W+Kfc5SGxnYq/5CDsg6cgKM+75Sr0m3+04w5EAZUlI9CI
	RUlOZEKZ+a0U+P9mVuKuuhE8Lah/B3RhXsTGqWnz2+yTU3S1mxG5Mo55Blt+jbGEPYEQj2CSC98
	QXJ4++8iH+S22H84yZ4RZzGGyqeIGc2zA6p9YoC6qr3KvY9s0iluud4pZajBzziRi+TwuMJ1dYU
	b197V195P3QR8Z6jLXCMAZZdrQep9Tsqjt8BjhzcNt3wCYtUu0tPph/jOz46oRUOm4r9WPFqzah
	NtXGAXyRyscwEXZZh8G1eHGzrhxnS3rW6HNRxIi/ae8gLmqdx3dDBrLg0k2HwieYfvgPm+CTZQ3
	A==
X-Received: by 2002:a5d:64e3:0:b0:47f:97f6:d39a with SMTP id ffacd0b85a97d-47fc81c5cf5mr2617454f8f.17.1785404792969;
        Thu, 30 Jul 2026 02:46:32 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:97f0:8a89:3637:d698])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e424fsm6971410f8f.14.2026.07.30.02.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:46:32 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 01/10] ovpn: add missing rtnl_link_ops->get_size callback
Date: Thu, 30 Jul 2026 11:46:12 +0200
Message-ID: <20260730094624.4102963-2-antonio@openvpn.net>
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

From: Ralf Lici <ralf@mandelbit.com>

ovpn_fill_info emits IFLA_OVPN_MODE inside IFLA_INFO_DATA, but
ovpn_link_ops does not provide a get_size callback. Consequently,
rtnetlink's size estimate for ovpn link messages does not include the
nested mode attribute.

Available skb tailroom may hide this mismatch. When the remaining space
is insufficient, however, ovpn_fill_info returns -EMSGSIZE and message
construction fails.

Add the callback and account for IFLA_OVPN_MODE.

Fixes: c2d950c4672a ("ovpn: add basic interface creation/destruction/management routines")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 9993c1dfe471..9d9a0ff690d6 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -210,6 +210,12 @@ static int ovpn_newlink(struct net_device *dev,
 	return register_netdevice(dev);
 }
 
+static size_t ovpn_get_size(const struct net_device *dev)
+{
+	/* IFLA_OVPN_MODE */
+	return nla_total_size(sizeof(u8));
+}
+
 static int ovpn_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
@@ -228,6 +234,7 @@ static struct rtnl_link_ops ovpn_link_ops = {
 	.policy = ovpn_policy,
 	.maxtype = IFLA_OVPN_MAX,
 	.newlink = ovpn_newlink,
+	.get_size = ovpn_get_size,
 	.fill_info = ovpn_fill_info,
 };
 
-- 
2.54.0

