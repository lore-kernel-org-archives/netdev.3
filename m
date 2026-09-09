Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE57283FE5
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788921628; cv=none; b=UJYmoUlnbkwjHZEdGK84X+7aUOz5WbF6L2iW68IPfmQmjoJpaOqqZMztmqSGNBgrcJwpMCHzwJLlCUQoYq9Lgu8qqtoxME8BgkUxHwx2f1IJGXOyNeALu5HNSy8TOfZkLuW4hxPH4ju3GD+Iax3EjSJYe6bU2yeh1nAxBe2XJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788921628; c=relaxed/simple;
	bh=X1Xh75puVEIf2AgK7qiR8Iu8yQ2Qw0GXyTIhKX5ee8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H59e9mtN3JD8nuom6oo09+Hl/8UnyHfSNKdGfMwAXLOJeT9boqXhWoPMopOvb5Jc61XYzcSLVDp2gU8MiOLzbiEiac8eqljt77j6aZIV5iIRsl1dNN6otJKX30akTsMQqQSEYC7dtzZzuvHCqHBYRAyzE96cZnY+uMZe4m4XSSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlGPVekw; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlGPVekw"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8541875f596so2585307b3a.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 19:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788921626; x=1789526426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/fZqpQBGjzjI/DxAL3lk605xnvz1wTJmXUd/sLpFD+Q=;
        b=HlGPVekw2RyG3wytO5zN/19Es33hbLKy0WSnXvb1Q841eId/oLFiGJPDTt+RZzssg+
         YOzXaI2NVXX+kGMo2yyL7i8SpFHfD87TYNEfV+wlalWYmn3I682+KqJXaLK+gCBGrvn0
         zM5OwWEtjYNyRu2WgFO7wuMjqnwPZAdVEDI56k4C8JiJfCMjVxb07qzjQ1a0AlaodsKk
         7J8tUnu9CIdi0P6bd0c4p5AssSA9+OkTxOmRqi5cAOqt2IiVLQ1358AxqzM9usZVaCLE
         ohSFyh3LRXqnHqLWAYnz0CkuuyXEdSTDh858WaPgf3UPeS49bysVo7zk9PAa08/MFDi2
         ZYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788921626; x=1789526426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/fZqpQBGjzjI/DxAL3lk605xnvz1wTJmXUd/sLpFD+Q=;
        b=SvTLZhlsKn02tK24JztZ+WjrgGfI9ViNqO5CGAmWgTyfUd5VHjm/7svaA4EkbOGnS8
         L72FrN+51Au/0Rc6RUCo2ekg1sZfD322qopZSkqS+oieFth4aL9F5xPMTTyR7qFGkqF8
         jAyXePUN9EKiIfHD12o6AHPvNwTEwlqL72Z79fZIG4aZq1zGBXEsVNOJW9iYV5a7Jwl7
         Qfu2aaWDm8RuJSVcWb1xWvXm7fGBG4xT2zgOVSfOS7ppm/gi89pCHKdbIhsngXGiPx2x
         tX0vtUZF5VZYc9YAs30YTOduvFG+Wyw/4GVpJ2MeG9/AYhRpHmuH3BpKxDmwbitwW1pr
         X33Q==
X-Forwarded-Encrypted: i=1; AKwUvByMEUXEKAfPmddOGwz1TjyBHVyGyvyxSdxrMAAFqBooKzbEza7/OJEj2/G8t2rsVgdC73DSN3c=@vger.kernel.org
X-Gm-Message-State: AFuF++nS0aAI19as1MBGdGV0DpRqn0a6AbdUdq2D8fs3eVsV44in+zqN
	70HsXBQ+p+fcEi59idRwJFgG8NzfoxosOMLvKWFAd5WYbDyHKv+CAQCA
X-Gm-Gg: AYBFou2GpdYvkapq/TSeZ4W0px6lZD5JOwZHnP5tAWHtJ65ISONU3syhNzex4OUD1/r
	WszH0Vl73czE//lNv00fADz05MQ9tbQ214kTLIGf/7NogAtkDS1V1mfKZRVYzYYyHP6MvXKY2xi
	ZR3ctteEABXnpJZooD23f9KP+A8t41SlSlZlf0QEkBWHZ9ynqWwGJar4/PjroXQVVIUi3bowPD4
	gW0iMdJIsSEHwBv6GNXyu7zp9lNGnry+WKaMYd/gAXE8aTUn/a9hGyoUOxaajMfZl2hTotmoKn/
	0f6FeW2wXvE2ctjZg92ZZkw6Di/Cn6O9onR6ZWcLPcQGEJgNe9gJv1O7Oo8calwWXRxtkdKM06N
	ToZUIc4Ad0sL2jE/aHvUdFfIts9ViQrI7nFBtPSA2U8L3ja4DiYuaFNXq10DSolfjjQkCy2intj
	LJr1TPWq9bmBf+gN5TnifQPeuAc9YMq64tsDZaPsos2EgHzU8PKfN52yguvBE1FCCi5xBXIHilj
	hkkKRf/IvbnjZxgCOZ0Q2FXeBlzahJG5HVGXsqG+jlbka8QwwbUQPrbX0qh/4tMQFeW6dfxgZIr
	HH2600ItulT2c+lh7iNaG/wUJp3iQbS6yC5CMgnBmA4uPHo6+xjQoIevKuUS8WmUzrT6wNWdAON
	0L5AcvLoZzBu6
X-Received: by 2002:a05:6a00:f0e:b0:847:770f:da4c with SMTP id d2e1a72fcca58-8616b17644bmr44258694b3a.16.1788921625629;
        Tue, 08 Sep 2026 19:40:25 -0700 (PDT)
Received: from bad.. ([43.227.225.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152045f74sm6270814b3a.10.2026.09.08.19.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 19:40:25 -0700 (PDT)
From: Nikhil <nikhilljatt@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	horms@kernel.org,
	dsahern@gmail.com,
	hawk@kernel.org,
	razor@blackwall.org,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: fix reading neigh ha in bpf_fib_lookup()
Date: Wed,  9 Sep 2026 08:10:11 +0530
Message-ID: <20260909024011.1252694-1-nikhilljatt@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_ipv4_fib_lookup() and bpf_ipv6_fib_lookup() copy the neighbour's
link layer address into params->dmac without any synchronisation, but
neigh_update() writes neigh->ha under write_seqlock(&neigh->ha_lock)
exactly because there are lockless readers.  A BPF program calling
bpf_fib_lookup() while the neighbour is being updated can therefore be
handed a torn address, and XDP/tc then forwards the packet to a bogus
L2 destination.

neigh_ha_snapshot() cannot be used here because it copies dev->addr_len
bytes while params->dmac is only ETH_ALEN long (an IPoIB egress device
has addr_len 20 and would overflow into params->smac), so open-code the
seqlock loop around the ETH_ALEN copy.

Same problem and same fix as commit 57549ab90791 ("net: bridge: arp/nd
proxy: fix reading neigh ha") and commit b824059a673b ("vxlan: fix
reading neigh ha").

Reproduced on x86_64 under qemu: a dummy device holds a permanent
neighbour whose lladdr is flipped between aa:aa:aa:aa:aa:aa and
bb:bb:bb:bb:bb:bb with RTM_NEWNEIGH, while an XDP program driven by
BPF_PROG_TEST_RUN calls bpf_fib_lookup() in a loop and checks that all
six bytes of the returned dmac are equal.  Before this patch: 211 torn
addresses out of 16300000 lookups (last one aa:aa:aa:aa:bb:bb).  After
this patch: 0 out of 38060000 lookups.

Fixes: 87f5fc7e48dd ("bpf: Provide helper to do forwarding lookups in kernel FIB table")
Cc: stable@vger.kernel.org
Signed-off-by: Nikhil <nikhilljatt@gmail.com>
---
 net/core/filter.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e753552..6fdb85c9af44 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6298,6 +6298,20 @@ static const struct bpf_func_proto bpf_skb_get_xfrm_state_proto = {
 #endif
 
 #if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
+/* Take a stable snapshot of the neighbour's link layer address.
+ * neigh_ha_snapshot() can not be used here because it copies dev->addr_len
+ * bytes while params->dmac is only ETH_ALEN long.
+ */
+static void bpf_fib_dmac_snapshot(u8 *dmac, const struct neighbour *neigh)
+{
+	unsigned int seq;
+
+	do {
+		seq = read_seqbegin(&neigh->ha_lock);
+		memcpy(dmac, neigh->ha, ETH_ALEN);
+	} while (read_seqretry(&neigh->ha_lock, seq));
+}
+
 static int bpf_fib_set_fwd_params(struct net_device *dev,
 				  struct bpf_fib_lookup *params,
 				  u32 flags, u32 mtu, u32 in_ifindex)
@@ -6491,7 +6505,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 
 	if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
 		return BPF_FIB_LKUP_RET_NO_NEIGH;
-	memcpy(params->dmac, neigh->ha, ETH_ALEN);
+	bpf_fib_dmac_snapshot(params->dmac, neigh);
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
 set_fwd_params:
@@ -6644,7 +6658,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	neigh = __ipv6_neigh_lookup_noref(dev, dst);
 	if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
 		return BPF_FIB_LKUP_RET_NO_NEIGH;
-	memcpy(params->dmac, neigh->ha, ETH_ALEN);
+	bpf_fib_dmac_snapshot(params->dmac, neigh);
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
 set_fwd_params:
-- 
2.43.0

