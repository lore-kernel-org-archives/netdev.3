Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB82C42C50F
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789512099; cv=none; b=iYF5M+pVx7Kel1NL9sxO3w5tipl2TixsRxBag/kKvpXxyJV5vIbRhGrlMPC8m29M6jVICMz/laH91JUQR9BUbvDwdBLQmbShkDsEmAcDmbHy8fB7bNqNJdt77ELQKjh45UiX1x8JeUj2CjQGv3REH+jtHkU7Djgym6c1DNm5TDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789512099; c=relaxed/simple;
	bh=b5HK13t+01lwgK8AZFDZ/c6dAg/YzLEfRUoQx1+pzkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQSI00Uusxf7wLGvXkG60BHpkb/8CERff7jBbrI7PL5zb5gNSLHqyUN3My7z5hwzdJmPg5niJXTddztzang5AMix5Z43kVNBE0CUCV/KHTbvNY1lmP5c7eUKs+lrjJ0t4ZvpcnTG0aSopEtc8fI0PowzDIQQFKU8bAqDO0BHAb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXqLpPGs; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXqLpPGs"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c98e1942dfso200393e0c.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 15:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789512097; x=1790116897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dv7QSeB8GfKRYOXWHXl+MRBO8PNA3iqQd4syPlAQa2E=;
        b=GXqLpPGsdfhKOjl1gaEAsnDI7Mp+MYioj9hqxB3IKIJ+icU0z8gGvlLsCgFOHZposs
         TkkK2Hx0ddpO2e+O2f93gZCGzcssXMriDekgqFMV0QtB9bRexQya675lnyJcbQW5cm/G
         DBtKIM/xj2WxnEp2wcy6PlFqVmN1MKk3PZ1LC8gcBNgHBRmkMdTmmQ2FNou4cxU5qxsk
         G8XrNpsCyWKXH9u6a/e3jr3sE2ZHebjdSuOA4ORFTV5VTFYeT7YAc9LKpKyEuwylCYLU
         YfxqMizG/Ks/OilIEUtNoTJ89q74CBImr4E44/WV4+r1BnGiuZCQWBcFMAGpevaClpFP
         DeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789512097; x=1790116897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dv7QSeB8GfKRYOXWHXl+MRBO8PNA3iqQd4syPlAQa2E=;
        b=Tjrc1STFhAC634jNbREkhVnJcSiYvI8BVuYjCY33dd6r8EAaHU5yt0/txQPhi0Xtwg
         Sfj+cOIeobfXajG8rFRz+ZTeGas05U5VUdB7M+1Mq6+sr8YXgQJteVY0v4UkLaflWCF7
         dy++qcEQe7mesqLXqFYb3G4KhBLNwcyoqxMQ84L+9qrMoZ4UrX0TzJorBkV8dtzEFQUq
         L67w+bHdtA/85e6cvAKY79XnuRLeKj0psm4f1BkVATsEOp6yFBTgcYh70J1k6KEizn4N
         w6DcSSBNj1CI1JqIQJmjANC7HNB9OalOyuMIFUFILl1rjjjdzQMQYw97XS9lSaIrLPH8
         i7Hw==
X-Forwarded-Encrypted: i=1; AKwUvBxVTvYKtsf41kLt3RMN+hJNUJKjUNXeiaLt/lXYRjO0+pn8zYMpTCspjHmvxzTjU1NGm09k+bo=@vger.kernel.org
X-Gm-Message-State: AFuF++kV6YOYjgbVIPCh3RYmo41UrtnZ85abQQsb3ArAp9widyI04ljS
	Hj6Ax4eoV/2Zi6KN/qVQnCvaf57YoVus4SlYLmUvKU5jSOh9qkcu0pj1
X-Gm-Gg: AYBFou1UIMPvZSfebwk9m3FyoQvjDg5r/q4F91l4L9cc9XzKC6z8jGlbfwbNBOboqcD
	3hO54pUPLWIQVCpRE2u7FwB+5N8zNy8m2EYAQb1me6zUBwVTZYosPEr5dsRQxgFtmlTT6MfY+Di
	dqvMgEsnRuTqNpjbYG3jS+1HbtF6TzJArq6IG/VNs11Q3SbSXOTgcXf4vVF7BKqsz5/NlbkS19R
	r1Yf3AuyNnK9LwQCs8/2rM25QoCKVQ0IueyegBr19GlT9u7OYz6hJwSGBlVybjPVA+K5nIlOeiY
	HaJpbGonFCuSJ0PzL4CrP6VUVd2+xCAyek7M6+K/BhOOz7qHVAoHCgFifw4Os3pKSf2Yu1F3qdY
	oAvitgyb2MLdcI0qWZBvYGCAiJcgPX/jnlYat+KIaNyUsocbEuwkWcA0OFlMmK/FFT+PXyrFhPe
	J6d21FLPEPhM1fSjg5ACu9AuFdcHWUFiHokHVIF/RbmqeD+waaru14HBEbRVeDWrE=
X-Received: by 2002:a05:6122:d24:b0:5c7:fbb5:6ea0 with SMTP id 71dfb90a1353d-5c99ae061c4mr302570e0c.4.1789512096679;
        Tue, 15 Sep 2026 15:41:36 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9988e5f27sm974975e0c.1.2026.09.15.15.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 15:41:36 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 2/4] ipvs: stamp per-service secure_tcp on connections
Date: Tue, 15 Sep 2026 19:41:02 -0300
Message-ID: <20260915224104.639985-3-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260915224104.639985-1-adrianox@gmail.com>
References: <20260915224104.639985-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set IP_VS_CONN_F_SECURE_TCP on every connection bound to a
destination whose service carries IP_VS_SVC_F_SECURE_TCP.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
Changes in v2:
- Set the flag in ip_vs_bind_dest() instead of at every ip_vs_conn_new()
  call site.

 net/netfilter/ipvs/ip_vs_conn.c | 4 ++++
 net/netfilter/ipvs/ip_vs_core.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index 6fa3e1dc534c..0b465298b64b 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -1090,6 +1090,7 @@ ip_vs_bind_dest(struct ip_vs_conn *cp, struct ip_vs_dest *dest)
 {
 	unsigned int conn_flags;
 	__u32 flags;
+	struct ip_vs_service *svc;
 
 	/* if dest is NULL, then return directly */
 	if (!dest)
@@ -1102,6 +1103,9 @@ ip_vs_bind_dest(struct ip_vs_conn *cp, struct ip_vs_dest *dest)
 	if (cp->protocol != IPPROTO_UDP)
 		conn_flags &= ~IP_VS_CONN_F_ONE_PACKET;
 	flags = cp->flags;
+	svc = rcu_dereference(dest->svc);
+	if (svc && (svc->flags & IP_VS_SVC_F_SECURE_TCP))
+		flags |= IP_VS_CONN_F_SECURE_TCP;
 	/* Bind with the destination and its corresponding transmitter */
 	if (flags & IP_VS_CONN_F_SYNC) {
 		/* Synced conns are hashed, so they can not get this flag */
diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index ba0957798bad..aa8a3a964ffd 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -784,6 +784,9 @@ int ip_vs_leave(struct ip_vs_service *svc, struct sk_buff *skb,
 				      IP_VS_CONN_F_ONE_PACKET : 0;
 		union nf_inet_addr daddr = { .all = { 0, 0, 0, 0 } };
 
+		if (svc->flags & IP_VS_SVC_F_SECURE_TCP)
+			flags |= IP_VS_CONN_F_SECURE_TCP;
+
 		/* create a new connection entry */
 		IP_VS_DBG(6, "%s(): create a cache_bypass entry\n", __func__);
 		{
-- 
2.51.0

