Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794174323;
	b=i+ZNtdBqjqo2JITiCajKv4r7ilSAand97uk7NSfqEJoSHeD3YBJ2yNsUs5MQpDu/CFDf
	 ci+KEUi7qFM/0bWlUdN4C40fZKY/+SAZ74ORGfK7ozKIXIk9oyCACmCJmCz3NTHYSZSdo
	 nW8VU2zAZq/FUW9SqLxig9RTTn7ZaNPjtrHTxdrgpQ/Zo55c7d5X5z/qaAZCgRRZvNsXj
	 ESnABzfOUvge01nrDXnXM7BDcf3CW9BXvlx0gxQLjAeIvb2NBjNka9gOUqJve6EHfiz7l
	 d3SEsrH5KJtSDf0g7NZ0JuKPeOa9PJr0Yx39dYrzVmrScVQ38deLyXqFg/IMPsXNJaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174323;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9l6NWEWMJ9uUn8jbFCIYRZKatM0u3CjixN3oolZ9eG4=;
	b=BlWxZK+guwSK0HWipfEqYgO5NuFz+zzcnAbtzIfDHxJucxPblMQXyehGCZ0E+uPWCd15
	 8kqkAgqYxIv3AnJm7zMPmsETTHgcBltpnc91+b43RLp3B6CHbVqNOSuzGG767StBFcBAs
	 Rdmq59h9Ppd7I5PnxnWDkYhWt/u4L77dAObfbFm1Wrn1BHVYpc5lSmTjXLsF9Nhn0nT8G
	 tkIKujB82p5buagv5+6/Ur+OCsIlWsiP/hc2iY4y/8xMsXoQmX4QlVyOg4exp0ZKN9QOk
	 BnWj/OiTLkhti0DW9CRjg0xxy3qP/jcueXfy3ECR3jHXnm92pQBfgCfDihXTUUfhMqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=THV0xTKZ;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FFC606D830
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 21:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94FFC606D830
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=THV0xTKZ
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ed0b03ce3eso761335ad.3
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794174323; x=1794779123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9l6NWEWMJ9uUn8jbFCIYRZKatM0u3CjixN3oolZ9eG4=;
        b=THV0xTKZgIs8+l/ENmpvDdI17Z5IpqRUFt2ohzy+3h57IpWtEPQ9YCm3OcP1x9/HCa
         7HU3/HxBEHVffWEIArrNNLnHFrIn1DZD71D407U3eTMQ08YhNGmjK5OUYAq4nwf9ARHj
         /3od4ypNvNyMlkFOzzJptI3/01034pItCunu9IpezgqUcnplTTwc9SNuG4zvI8+RVO7n
         QRsHehjIOpfLqKTq0dOD340ga1pFvL62nuCn7KGZ3NnTv+h8THb6uUkRQNVYgWboWKVz
         EygvO/J3V5yR407ESloHTEc4d9fw29qlhZJAgxLTZ+gV6vNAbN1sZWruD/W5FgOEUxt2
         nohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794174323; x=1794779123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9l6NWEWMJ9uUn8jbFCIYRZKatM0u3CjixN3oolZ9eG4=;
        b=Fu2fqw9DQaFZ878TyaH8ci40ZDE+8GNp+l4Ld3dflqGODEHOAbYWmnBrU2KRjBAtJ/
         Yjh3menp7RQfwotHulkhBI/OnEm3NoPLLMp1badFlb//bqCwBu6I8YZxmkiIzwGKIhxj
         9wJmh/4mdW/oztzsgFHbTvMYBicROotnIedA2PgUrUV92kT6ahlf3+Xwt0KQ9o3OtoK2
         Hs2PxPUzUKRnEodUVzJh3Ry1zeOZxEPOfcTnTCgtNEqYVY1aft6EJZgQIlld150KHp4C
         rpv92sxOF/7n2TFNyV8FyjGBnBIqZ7Wx29xD3VL/vqShP+Tf/m4DknPZ01UC1sYk16mR
         F70g==
X-Gm-Message-State: APuU4Z8YMci7o3zj00S1FfIkiLVgAg2ELNFR9ftiPm71xNH91ITuYdpi
	HhKbbAmQYBeehKr9QobBxurA49ZtAtcNbfFaHH1lCK/89UvJSyF1bh9JsI86NA==
X-Gm-Gg: AYBFou1tqiHrlbXMjioAQht4Un70Ou8VNkYQGxHvoxlIyvQ61cQ7/YRt/J8FhkjSV9x
	bZcIszNN7+aI9m4FFQr7Ze3fMIr2FTBzLoW6lsWNJ6TS0F9upqnWoW5hkjaMYCXnc7+2+QMidNV
	A5zVVc9vp+TkPpHO8MeI6RBdYYwy7pPO9ePUKGv1CCY2EiDlbajYk+Qrlec1IaiMdzCI5AldjkE
	Ols8DADaO29XBIihMmdrUzZEYoCN5FKTXEX15AUS+DCXXgDo8/6FfOszhf9oAZF4R1M6SWVauF7
	QUBwVvyFDWqFBke1s9z0vhYW4cDhlchlGxDpE2DRNUSLoVSN3UMIDBpYNde20/drW20+fraf7Qj
	Ivi3ldLhmA2YRoJW9ph/7mBfJ1StuojWCpZtLg4z1HNo0z2M7jVyUT49kTZE52o4454AKaJMxo0
	2p8HnLd7f2S/3W+qssT+B3XbCx7X3MLcrz3lRx9CrgvZ9YHBNIXD46ttwXP1xji81kZzvqm3mWd
	SERz5iZmHiJdhiGst5UbDd7lMqK5j8t2YG2MUwBMRaTLaN8MsyFNZ+tFJqipk72lR0itCM9By6u
	DQ/8smxgz+bwyrzZuZ9olB2blMpxcDhlfkJyX7dYHOlaoNFoCyfWlY4=
X-Received: by 2002:a17:90b:2e48:b0:3ad:8a14:bc73 with SMTP id 98e67ed59e1d1-3b12d5ba8d1mr2092245a91.50.1794174322647;
        Sun, 08 Nov 2026 13:45:22 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1034718f8sm4619463a91.4.2026.11.08.13.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:45:22 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 5/7] net: dsa: motorcomm: Translate FDB VID for VLAN-unaware bridges
Date: Mon,  9 Nov 2026 05:44:45 +0800
Message-ID: <20261108214450.1662362-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108214450.1662362-1-mmyangfl@gmail.com>
References: <20261108214450.1662362-1-mmyangfl@gmail.com>
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

A VLAN-unaware bridge reports VID 0 for its FDB entries, but lookups run
with the unaware FID (VID 4095). Entries added through switchdev were
installed under FID 0 and could never be hit by the hardware lookups.

Translate the unaware FID and VID 0 back and forth, so the software
mapping stays symmetric with the hardware lookups.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index fbf3a0cba49b..46534127d070 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -590,7 +590,10 @@ yt921x_fdb_dump(struct yt921x_priv *priv, u16 ports_mask,
 	res = yt921x_fdb_read(priv, addr, &vid, &pmask, &index, &status);
 	if (res)
 		return res;
+
 	if ((pmask & ports_mask) && !is_multicast_ether_addr(addr)) {
+		if (vid == YT921X_VID_UNWARE)
+			vid = 0;
 		res = cb(addr, vid,
 			 status == YT921X_FDB_ENTRY_STATUS_STATIC, data);
 		if (res)
@@ -618,6 +621,8 @@ yt921x_fdb_dump(struct yt921x_priv *priv, u16 ports_mask,
 		if (!pmask)
 			break;
 
+		if (vid == YT921X_VID_UNWARE)
+			vid = 0;
 		if ((pmask & ports_mask) && !is_multicast_ether_addr(addr)) {
 			res = cb(addr, vid,
 				 status == YT921X_FDB_ENTRY_STATUS_STATIC,
@@ -740,6 +745,10 @@ yt921x_fdb_leave(struct yt921x_priv *priv, const unsigned char *addr,
 	u32 val;
 	int res;
 
+	/* See yt921x_fdb_join() */
+	if (!vid)
+		vid = YT921X_VID_UNWARE;
+
 	/* Check for presence */
 	res = yt921x_fdb_has(priv, addr, vid, &index);
 	if (res)
@@ -782,6 +791,13 @@ yt921x_fdb_join(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
 	u32 val2;
 	int res;
 
+	/* A vlan-unaware bridge reports vid 0, but untagged lookups on its
+	 * ports run with the unaware FID; map so that static entries match the
+	 * hardware lookups.
+	 */
+	if (!vid)
+		vid = YT921X_VID_UNWARE;
+
 	/* Check for presence */
 	res = yt921x_fdb_has(priv, addr, vid, &index);
 	if (res)
-- 
2.53.0

