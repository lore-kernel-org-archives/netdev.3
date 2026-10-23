Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785159;
	b=b79zKN27L9ppFPBYnrP+45jfDmQWs0xjMIWSdxICbPNHOdd6r1ElR/Pucl5RRydnceC7
	 ty/bJ8vjWgJf1gieXX2crLo6tL3Hh1c+YIrI4VgMjRMSpGMYTYW6Qhur4WrWrv/XeDt/1
	 OmnBwL/7SKMZ0nGUwnDDzmRrOMEsmJ20fMgogJu9cv0tqkG9fZlxBXJL/ApWaNehkIgBC
	 Q3G40NHq154EzPfA1PJAAKtFlAo660kXPJvLcN2bOlIbdzt6WXYYGEyWMNPsFtepR2qzx
	 gCjTR4Zh0Ag7ixOYv7jlWMRVTzWxQNKWUy+u+uX3lTFtjYK98CH6CnXFjJSGO3vxiGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yTcmuMnkNzSebcUDGuE3JkhELdrXB8BWi9yU8pBIEF0=;
	b=o2jFRXtt+OOWz9dONfxG9S1DfCoZan20Ww/jGR7lzUtWrJ4FUyvcDVFtn9kLsxyxgMoF
	 J6PyH6rzwyDg8KlwRkdG9JMHsNvvTw5+ybQUnjMS81OQFNRms3qHPvBKK5kH8GMgP+p0u
	 0jVJiYX3y3AXfS25XTFZtm+PYaHBa9ntEoUcE8Jjj1iG6ZIUPSPKG0UT3l/eWuyZPa+D+
	 9GOAHFkuuS/+NR+IlMqKj5Dn6P71rxve27lYTfaSEUMK9ddfqmQFKjOGjaebK7xPWvO9A
	 ihcMRJFqypiz27eJxChzXqvTaofgiGVVILFs8aFDbLC2lsHWoTdwq+XK9G/5whEPTiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p92V9elp;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E3606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 19:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D23E3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p92V9elp
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso12602885e9.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792785157; x=1793389957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yTcmuMnkNzSebcUDGuE3JkhELdrXB8BWi9yU8pBIEF0=;
        b=p92V9elpkIZgjPPLwyJYhCG1WQ4TdS/FVWcP3yGdKv1GCNPjYYEILmBuLyoXZZwWFF
         5yPiN0IQ1VjWirdmS7oUDCbgYrD6vwKLEl1quhL4mtFDLa93heV8SyOXvZvgKpPGwEJi
         TQh0Fpahizq124s8SkHz0NwGO/8t+smsWHt4NaD09ODzFxZGn8zyODGgi/yGXR2JgqQr
         l5X+DKhjS6AHNBF10xKI5nQiNdGhNExmGAN2N2HbM+KXIkCQjD1aMKgyPAFSw4xaqear
         YakK2fxOSMzbqtNvWjBHSHi3dOmPp+oYbJ98YDjq8qHYI2YVTxsxFx4J6XaAkcxr8+Ah
         PJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785157; x=1793389957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yTcmuMnkNzSebcUDGuE3JkhELdrXB8BWi9yU8pBIEF0=;
        b=B9Og9L0E1+UtHU/aa+m+LKgohZdyagYOtSqhZfVGcwnP+vdsLdPBQ5cvh1zyqes9Jr
         Hb7cEbt4yRQKKCHhhBwJF68YjVNWnRgdFx8JvgKkLbv9qxYuhZ2wu7of2NwFuUNoRFc1
         zQs+6jFGG9LS9R3B1olk5vyKk1OXhCp14kEYDWoHNiytG1C9IjslugPM1X6cAPG2AyW8
         6pntCdvN3kCPn/O9G0bzo/ExuL3u8jizDyI21NJsYlPQRNUuE0rxJoHxaTcyhZMqWWpg
         xM6O9KCdbvpqSEFn/11wX7+hoskW1L8+DSyzNFqXkgSDOrFh7HmwOpaPTxYxdm5G0DBC
         a3Dw==
X-Forwarded-Encrypted: i=1; AKwUvBwrUqHQZ6apITorEQaX5pHKPiLgxhuM577zUgvuFiSpGy7t9S4zb+XaSot4PPDOLRg1ZZR2beY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1WatcU1TZs4cfwAoaHJX5japkLxLi+KPhJh07RIkF75nEaRqM
	9iD66Rt4HelRL+U9V7430pv9U8UIXX+FMUAtjWoK+MjPGO4kMsuUeQ8=
X-Gm-Gg: AYBFou2aUp089U+OHEyNqBLop/MDpeDHbMTvmPDU8G9C3DN3qgiMTFmkaLcfBl8abA7
	pAj24tD/y9n3Ssvc+B2Uu0/Vq7n7z0/VPWh23Os4X4PzQmmXZqgE2iuzGmsI5Br5PkIIBzVNONu
	0Cik//+y0Ab3uS18SiP7XFFeewavBmrzbVFOzeLNWyYuC0WP+BtBEmXtCzRq3M6Ne/pJF0AxC45
	AA27dzghrXsUDPGX6U8S8LEjd2P4482mShsYY06vYZmetC3rgLPs8jBHxEJ3aqLeLKIn2+y8qcD
	RCu5CfWvNo7JpxDqL69IAkP+/ogR6N2BgD8uFef4++uXLYpyq6gu2NLc9Q3LjsLcBVoxM0a4Xad
	LhvnUccyM3TxFGuIQ8om5ZRMqPIfiYPKmoC7aqjx5jrB+ZwGXFPgIcXOWDTOhNyaxfF3GSbizBP
	8xIeuXdI0+OWCFMd8qjnK961dg67STwVerC52W9ke+OVyAXYXqCeDQsVsT/FzCdUHAIStU2yBKg
	qiffC/0HYEknczYJgwWBOUz
X-Received: by 2002:a05:600c:3f16:b0:4a2:1960:6db with SMTP id 5b1f17b1804b1-4a2196007e7mr25760645e9.26.1792785157088;
        Fri, 23 Oct 2026 12:52:37 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a55e9aasm3892025e9.5.2026.10.23.12.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:52:36 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	David Lebrun <david.lebrun@uclouvain.be>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net] seg6: fix tun_src RCU lifetime on namespace teardown
Date: Fri, 23 Oct 2026 19:52:34 +0000
Message-ID: <20261023195234.3524462-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

seg6_net_exit() frees tun_src directly, but set_tun_src() in
seg6_iptunnel.c reads it under rcu_read_lock(). The pointer may
be freed while a concurrent reader is still accessing it.

Add a pre_exit callback to clear the tun_src pointer before the
implied synchronize_rcu_expedited(), so all RCU readers complete
before the actual kfree in the exit callback. Save the original
pointer in tun_src_old so exit can free it after the grace period,
since the RCU pointer is already NULL at that point. The init
error path frees tun_src directly since pre_exit has not run.

Fixes: 915d7e5e5930 ("ipv6: sr: add code base for control plane support of SR-IPv6")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 include/net/seg6.h |  1 +
 net/ipv6/seg6.c    | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/net/seg6.h b/include/net/seg6.h
index 82b3fbbcbb935..210f4fa0d4dd7 100644
--- a/include/net/seg6.h
+++ b/include/net/seg6.h
@@ -36,6 +36,7 @@ static inline void update_csum_diff16(struct sk_buff *skb, __be32 *from,
 struct seg6_pernet_data {
 	struct mutex lock;
 	struct in6_addr __rcu *tun_src;
+	struct in6_addr *tun_src_old;
 #ifdef CONFIG_IPV6_SEG6_HMAC
 	struct rhashtable hmac_infos;
 #endif
diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 8c2b156c227a7..670052290e43c 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -447,18 +447,28 @@ static int __net_init seg6_net_init(struct net *net)
 	return 0;
 }
 
+static void __net_exit seg6_net_pre_exit(struct net *net)
+{
+	struct seg6_pernet_data *sdata = seg6_pernet(net);
+
+	/* Save tun_src for exit to free after the RCU grace period. */
+	sdata->tun_src_old = rcu_dereference_raw(sdata->tun_src);
+	RCU_INIT_POINTER(sdata->tun_src, NULL);
+}
+
 static void __net_exit seg6_net_exit(struct net *net)
 {
 	struct seg6_pernet_data *sdata = seg6_pernet(net);
 
 	seg6_hmac_net_exit(net);
 
-	kfree(rcu_dereference_raw(sdata->tun_src));
+	kfree(sdata->tun_src_old);
 	kfree(sdata);
 }
 
 static struct pernet_operations ip6_segments_ops = {
 	.init = seg6_net_init,
+	.pre_exit = seg6_net_pre_exit,
 	.exit = seg6_net_exit,
 };
 
-- 
2.47.3

