Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792715889;
	b=3SW8Dl+c7JPpGjfelrwiVBcdpeN/qlpOgMrFc3IzhhVAu7lckWHKqfzUqM7qWP9XHTBv
	 P+ub0ESr+zCS4ANMxYZmkjWXt6mDuqV73yjLGybrb/dFRJCuvTxqTbfdQTiPK9Cs0H4yu
	 KWTr4qIxDD+YQSR9yjA83+dzxlEiegO5ZEVh9TeGh218jORFqKiNnwSy++rP2uCNZV8IE
	 rwJ5rnp0msRRQctCNut/xWfNmsTNapTiB6XZj22Rcqy2XXfm0ewbd6o8V3eySSGjfZv7U
	 NxBE850hjzKDXSnuJpAE6jf1dDqHeM6gsF+ewNKQqSeqOT7hI//bXAX2iE5E+1MuItA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792715889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=l0aNMUBAxnuhYZ7xObvgrWURvAm+XNeo6dvH8GTH4Hg=;
	b=1vsIuPK1oCCh3xVVeGCdJimWzFO6tMrtULwgxXR7dQa6Uqo0Ta91+mY6w/cdDxilIJti
	 zdqywKdasqSj92HkAwNlUUraY6SC3F4Uv7C1i3FA0fqvPPWCePg7NC4yBbvO40EKlZGAX
	 mVuBphfLd9b/EVyj95yRqJuJzW61jClzhg8VT/dtGOqvEyqpln0f2JoZjFzaEVj1lr1FQ
	 wnQ1uj3ZwlBvuVz3g0Q7itVeeBiiFR2Rv4Fc1WwglQHvPPrC2N7nzCTZFAi49pdnrkRYE
	 UbdUnwvfW2wtDrCiggwGzmTfr/lmPZSGfbBr4qH6XBNt3QDJRjG7QUboYjG7rC4y7Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N39aVhdl;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92143606A319
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 00:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92143606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N39aVhdl
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b3dc272dcfso376629a12.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792715887; x=1793320687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l0aNMUBAxnuhYZ7xObvgrWURvAm+XNeo6dvH8GTH4Hg=;
        b=N39aVhdl6IMd1M3+qfnOig0hSPZ8DfQ4o3cZzy4IfaAaA58Zkumr/8RhACNraKvlZq
         4kSQ7L+0lz/ih6rAGcHcTVoOnUf6JFopsdRgfJnP+rPay+j+nl4NA+8GDuAGSH5aQ8hX
         l8wtF2nb5to4RA1Ce9A4QXiL26sE08Ee+tKdVo95umJJ3S0i2v6nEmX5S2ClpeU9rs74
         N8w2ETQSFQ2P4f2Vpc7PyD1yXRZ4+ThW3OoBuStEsGvykPgdDRU7CmuQWirvxhviJGdj
         0gejf1+7/R4xr/uZas4WO1g+rcT0SauHvN9nNmzDJmS/Rrms1MB3EqiZP5H6An7qfx/S
         BcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792715887; x=1793320687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l0aNMUBAxnuhYZ7xObvgrWURvAm+XNeo6dvH8GTH4Hg=;
        b=e7T8rLWEd3b5vb2LpwDaWPwKNodrkKSMoHdgD255MznhovvyuuhFcSdV8hnZ1gTDZv
         mQ+TIVl4oK8tFGKEgGwFLXTEzCaWqpN6NQF732tCGDfhZGKfwyAtwORTJsAIh+8Do/KJ
         KpSZkD4hV/MGV3lOEjmdR+cwG2Zs8MlRMBcZ8a5AoXgbgRfVXOJE7aaayvuRZLAo23ZZ
         FpZVjFyAnPuSV3E0Wrje4H2fCH9q6XNa2rnl5VmDanq/l7STpkeOFWB9QugmStvMhryB
         3tVOMcVmrJGLQiI2PhLH2QVA2DZFS2r/ge/BS3kg0NcRB/qxbSUxpHsxFwlh3zvOEboc
         LxYw==
X-Gm-Message-State: AFq9FYLuPKPqLMesAmzjYMjn0oBByiJJ8G3g6bbC0xXNEZdqvA5Wej5T
	ktVXqctfK9jpNLwjHSrrF1UlEiOTye2E1YrL+ujAXCimBm0067gzyfNQs6bThg==
X-Gm-Gg: AYBFou0N6eIh212RDCjNnarABiK6Izwj7I+g+7YNCjE9MMcxoMPuG9W6J99TAMhOlB3
	TvoO9I0fyZxuJHgznEczeesIHUVwo/ciRq/e3fQZXbFOnMeth4AEBV2vWGY9WoWC/k4jF3TbvOR
	vizBiy3WLp5hyPgTHXGkz3NWeyxOVSBD2IvJgurAlzUMCSSp/4vo2yqAhOO+c5dHhVAeyhiWhp+
	py6U5H+Yh5hBmbO+vS5wh+gNW3o2hPyAekoMOFAK8LMdVeLw5h3MQgav/B70g5hZnPAh/Nmzdn1
	yC3JRhHfDqJ6ollvU36OVvkUh514BfFT4xB0RZ9A+05cI3XZIPrSYyyWlrw+OBKEjjiijXyo2Tm
	1kJEoIqNE9we/eIDu/CEO/E4YqNd23+Q+q+bCsnMBWfiOtVuNuZEKSsusln9wWbMRUrCOD4mAS2
	Kc2p+8aMvcozGGzszTggyWY9i9kSFOguLieAqmCpmcFZNvOqBv1MhkneVW4drnSxGqECl4VGqlb
	9TwltRpx/3O01f41K895OZJN5D51Xonh1zUIBOAGwqFs2OATGCzW/c77YQZDAbiGpLG/i0YHtjH
	alDmJRXDLshpHVn6jZldsiLVeF2NCNo3BE0ZGw==
X-Received: by 2002:a05:6402:2421:b0:6b2:e2:d965 with SMTP id 4fb4d7f45d1cf-6b432c5c21emr1409169a12.32.1792715886836;
        Thu, 22 Oct 2026 17:38:06 -0700 (PDT)
Received: from kali (83.8.59.162.ipv4.supernova.orange.pl. [83.8.59.162])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b432c77780sm435691a12.13.2026.10.22.17.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:38:05 -0700 (PDT)
From: Kamil Sawicki <user148783812897@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [PATCH net] net: limit priority VLAN untag depth
Date: Thu, 22 Oct 2026 20:37:50 -0400
Message-ID: <20261023003750.1133904-1-user148783812897@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The priority VLAN receive path can repeatedly remove VID 0 tags and retry
packet processing. Unlike the read-only VLAN protocol parser, this path has
no limit on the number of nested tags it consumes.

Each skb_vlan_untag() advances skb->data and resets header offsets. The
offsets are stored in 16-bit fields. With enough nested tags, the network
or transport offset can wrap. A later protocol handler can then derive a
large pull length from the wrapped offsets and access memory outside the
skb allocation.

Apply the existing VLAN_MAX_DEPTH limit to the exceptional VID 0 retry.
Count the tag already stored in skb VLAN metadata as the first level, then
stop before untagging a ninth level. Keep the accounting inside this
uncommon branch so the regular VLAN receive path is unaffected.

Fixes: 36b2f61a42c2 ("net: handle 802.1P vlan 0 packets properly")
Cc: stable@vger.kernel.org
Assisted-by: openai:gpt-5.6-sol
Signed-off-by: Kamil Sawicki <user148783812897@gmail.com>
---
Tested on net/main f4377bf85887 (7.3-rc7) with KASAN. The patched kernel
blocked the nested vhost/TAP trigger after eight untag calls on five fresh
boots, with no tcp_v4_rcv call. The eight/nine-tag boundary, nonlinear
GSO, 32 MiB BIG TCP and fragmented-head tests passed.

An unpatched protocol-253 control executed 31 calls to
skb_copy_and_csum_bits() with offset 65516 and length 548. A direct shadow
probe recorded a 20-byte wrapped linear source outside the skb allocation;
all four Generic-KASAN shadow bytes were zero. The patched control completed
the same workload with zero matching sink calls and zero shadow-probe hits.

Allyesconfig and allmodconfig W=1 builds completed with CONFIG_WERROR=
because unrelated existing warnings stopped the default full builds. Both
produced vmlinux and bzImage, and net/core/dev.c emitted no warnings.

 net/core/dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index e76762e29360ea..b40efea27dc292 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6198,6 +6198,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	}
 
 	if (unlikely(skb_vlan_tag_present(skb)) && !netdev_uses_dsa(skb->dev)) {
+		unsigned int vlan_depth = 1;
+
 check_vlan_id:
 		if (skb_vlan_tag_get_id(skb)) {
 			/* Vlan id is non 0 and vlan_do_receive() above couldn't
@@ -6209,6 +6211,10 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 			 * 802.1Q or 802.1AD and vlan_do_receive() above could
 			 * not find vlan dev for vlan id 0.
 			 */
+			if (unlikely(vlan_depth >= VLAN_MAX_DEPTH))
+				goto drop;
+
+			vlan_depth++;
 			__vlan_hwaccel_clear_tag(skb);
 			skb = skb_vlan_untag(skb);
 			if (unlikely(!skb))

base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
-- 
2.53.0

