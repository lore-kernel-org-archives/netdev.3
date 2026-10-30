Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334144;
	b=0mArMbSd8oyMNujMdbYkRH9pMxqlJoX+d5sHEbwbBdHw1eA0ro6pt2B0cj0ImFPXDKkg
	 +EcpU2nMTVkQIXv+uX5YIR4g4HWfLu7KjUfJHnF6qUWmN3k1fgbDJotJc3B91onnlN4k7
	 i7BTgxN8dQuxmnLeOkGjtbh8oZYyaBD2ZChX9ygapVBj+gnY5TdYuA3abiZm3vD15k3hg
	 iFpiAQ9Pj71JVDZTp6IGn0CPTXi7qJTjqIKPt/9FH41ThgAQtQ98caBCpSmXc7GxSCKzd
	 YmWyskOGHWuwbh8Ht9DVW5XMFgFQfV2unvVTQrl75SXMCYQCpLtw/0/PyEyE8yKA+eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=3hxk8649SkhtYbceP5bCvTVG9m2eHm+fN4Hc1Hzwp+A=;
	b=mwB8+I5RyjvFMR5EjfAqBpxxMBgoqt3Ycem803siZVPWdKg6c8AdfqJofKy+AHV6aqNY
	 KpAG1iGyxu5tT94m/z32hZT1kVVSVgWtrGe8g19tARJRIaUez5dGLS/GNRMVVGorCpAnc
	 +aWljRMHHC+CA6gengX1uhzUk59ZQ8ND4tc7xGv+0H/7aQXeCutiYpmGVNKPEfvq8QOiY
	 98He7tBHp+r+n04SWBMaQV2X7FEtqEElXkLN5ajXZKGy+o/G2JpDXJS3wBGWuC7DfXYI/
	 dq5ubmhWwo07RI6DgusS+yr8WX6btUxjV+jD42Pbs/5vQFWjvqYCsAxJ1+qvmjux8/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=PG3pL5zo;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4C7606A31D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F4C7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=PG3pL5zo
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4a822463a22so190092fac.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334143; x=1793938943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3hxk8649SkhtYbceP5bCvTVG9m2eHm+fN4Hc1Hzwp+A=;
        b=PG3pL5zoX4SQwnml5tmfvXQ5UQ/7jf0o5+CpeisrSd5QgzbQ/Nl5Qq3ZwXXz4VnJjt
         FMzmZIPqHbTL5y5yLcFE6XR2l+CpI8MtoDEVC8TPeWzzkOhvySH1nOWkEAI4xEHYuDD4
         Kb3BeHkNgoMdMnRyA4tTK7XduGFmzblIkwctY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334143; x=1793938943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3hxk8649SkhtYbceP5bCvTVG9m2eHm+fN4Hc1Hzwp+A=;
        b=gJlS7UtU6/8wZi2KYNgNB79cw7f4dQ0WFOkCfEzHexvlcfjzZMDWDzlDdcD0pDfXX0
         dXTDhiMzuO+l97dVipqzQKpwHSM1Bmuq2LgNx9RWt0xWb10jT7WXKP9ahmwibzOjDCpj
         JXeX7sfwK2AM8ZrclC1JOsfnG4mjWtxoAcNCc0qBMLqPYe4CRg6b6E2PYkfvnQohOlkd
         LRwYnF3aRtF2GuJakZgLMEwf8T1JWt3VMTigm7Go9c9UIskPjbnWSV1CvQ4GjT0gARJj
         QFTZiH72x6y7b0lFsB+2b4SQmsgE9ibcxumusEBS4mDF7Oui8EOP22epvY7g5d48fZW3
         bEQw==
X-Gm-Message-State: AFq9FYIpyTgBDISrnOGEKt9adaKGFj2AAvJ21v5v8EIEJf+pU7YuTu1U
	QWl+f9bFb9sp11GtXYavR2dQM/2CFAW1Q/JJKxC1OXwo8p8MHvMXixdy0di0Cxh4GzZ/1N64WkS
	t+ESrJhI=
X-Gm-Gg: AYBFou0Q0Nclui2jRKDTZJc5SoMrdtAMN2AmwM3t2AQfVOHhGKF1nsMPBnpTH67S/pa
	zRJgq+t9DDfpG2ZfDzqkQin9pwXmxLpFBeJ6mr6C290ZLZNQGux6+h44mcNOGgzOFnp4fB8rn2Z
	6cPTZtVGbMDxNNB/5TxxVZdK3K8Hnbq690cL/9Zqs3JV6zq9GkYEInDMPfzbO4CUiyQowOoHbEM
	PAEI6lVRU2qtYpPN61MSbpyvVmSY4AY6cBJ1682Mrq8FvQEs9W4k39ytMClAA2618ezyJGCa/pk
	aEwMrwP85Rif29ASsQUFPrELBgXhuM6s9FeOvFpVAHdLpdIAiNPHz2KPGDUgxGAGvDLVdow0hjA
	kxSUqraMZxDoozkb073MCPdBxMReqwwrdSDjscqUYuNKMcwaxvk2q4JqWG02oD8qp5WhVp3ZkN9
	GXKjyOd4m0SoPe589oP5CohTyGWmxT5csMAFAZ0u9ZBJok9ghHbdP2RGOLVUHZS8INZN9wuF+y0
	XFyZEpQESdNHfKb+kqx5xLanYPshqJjPnPVjuDTolsKre5d541G2DnMsyLSyiB72q078qZMlnGy
	FESC9V3W1WsY6njtc+H5iFh6+VlqUn8Wb6rYzk7E4FpykQz572+m649JwYTJEl/W1fiQ13RH7Sg
	xcOynBdya+gsn9N5tLULaGYQL/aKj/A==
X-Received: by 2002:a05:6870:8092:b0:447:a816:9328 with SMTP id 586e51a60fabf-4a9072faa72mr850834fac.6.1793334143209;
        Thu, 29 Oct 2026 21:22:23 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a90aee8c5csm810431fac.10.2026.10.29.21.22.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:22:22 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] ip6mr: Serialize multicast router socket ownership
Date: Thu, 29 Oct 2026 21:22:21 -0700
Message-ID: <20261030042221.73996-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

MRT6_TABLE checks whether the socket owns its current table before
acquiring RTNL. MRT6_INIT also looks up its table before taking RTNL.
Consequently, concurrent TABLE and INIT calls can initialize the old
table and then change the socket's selected table. Another INIT can
register the same socket in the new table.

rawv6_close() calls ip6mr_sk_done(), which clears only the first table
owned by the socket. After the socket's RCU-delayed free, the other
table retains a dangling mroute_sk pointer. A subsequent multicast cache
report passes that pointer to sock_queue_rcv_skb_reason(). This produces
a KASAN slab-use-after-free in sk_filter_trim_cap().

Look up the selected table in ip6mr_sk_init() after acquiring RTNL.
Likewise, re-read the current table and check its owner under RTNL in
MRT6_TABLE before updating the selection. This preserves the single-table
ownership invariant shared with ip6mr_sk_done(), without changing the
locking of the other multicast socket options.

Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 net/ipv6/ip6mr.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index af968a2c2a78..01a1087bc7c8 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1623,12 +1623,20 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags,
 	}
 }
 
-static int ip6mr_sk_init(struct mr_table *mrt, struct sock *sk)
+static int ip6mr_sk_init(struct sock *sk)
 {
-	int err = 0;
 	struct net *net = sock_net(sk);
+	struct mr_table *mrt;
+	int err = 0;
 
 	rtnl_lock();
+	mrt = __ip6mr_get_table(net,
+				raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
+	if (!mrt) {
+		err = -ENOENT;
+		goto out_unlock;
+	}
+
 	spin_lock(&mrt_lock);
 	if (rtnl_dereference(mrt->mroute_sk)) {
 		err = -EADDRINUSE;
@@ -1644,6 +1652,7 @@ static int ip6mr_sk_init(struct mr_table *mrt, struct sock *sk)
 					     NETCONFA_MC_FORWARDING,
 					     NETCONFA_IFINDEX_ALL,
 					     net->ipv6.devconf_all);
+out_unlock:
 	rtnl_unlock();
 
 	return err;
@@ -1745,7 +1754,7 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		if (optlen < sizeof(int))
 			return -EINVAL;
 
-		return ip6mr_sk_init(mrt, sk);
+		return ip6mr_sk_init(sk);
 
 	case MRT6_DONE:
 		return ip6mr_sk_done(sk);
@@ -1872,16 +1881,21 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		/* "pim6reg%u" should not exceed 16 bytes (IFNAMSIZ) */
 		if (v != RT_TABLE_DEFAULT && v >= 100000000)
 			return -EINVAL;
-		if (sk == rcu_access_pointer(mrt->mroute_sk))
-			return -EBUSY;
-
 		rtnl_lock();
 		ret = 0;
-		mrt = ip6mr_new_table(net, v);
-		if (IS_ERR(mrt))
-			ret = PTR_ERR(mrt);
-		else
-			raw6_sk(sk)->ip6mr_table = v;
+		mrt = __ip6mr_get_table(net,
+					raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
+		if (!mrt) {
+			ret = -ENOENT;
+		} else if (sk == rtnl_dereference(mrt->mroute_sk)) {
+			ret = -EBUSY;
+		} else {
+			mrt = ip6mr_new_table(net, v);
+			if (IS_ERR(mrt))
+				ret = PTR_ERR(mrt);
+			else
+				raw6_sk(sk)->ip6mr_table = v;
+		}
 		rtnl_unlock();
 		return ret;
 	}

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
