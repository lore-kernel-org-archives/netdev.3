Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3851745628B
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791627051; cv=none; b=YVGvHv9L5A8VrF6lLmyxIU2snN5nkzJwWS8K0/uKpzFJHJi1uDT69ymFfHai1ZExNYvv57maHALqw5gUIbJdK72EgjOG498YVGCAJTtKNXAqj6jE9uLE1Rn5NypYJQgh6yvG+oxAbbWvkKjvQCUToEcwbbNYJcF12nCOKnwOqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791627051; c=relaxed/simple;
	bh=NxGySGRW/C4GCaMH6YssU1T4XSy1dh7+6mdwaFS162o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pw7I0NwR7LuguqqJ1TbH0SkajqkTOCLPT14LlLt5fYqRfwQnHxL64QX0xfOddjyUOxMWytdRoas9FwaueVj7y79w+8xSKvJZozqkpLFaljZXW5aB/Og6KBzVEZaRsJ3KqIEdDq2FfB+ZGOH4Xh/ywOojYL+XtFz2d7qQRzyf6zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7KmN93j; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7KmN93j"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-88bc25fcd0eso337519b3a.2
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791627049; x=1792231849; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LK95suqIwIMlxETWM1WHHhD9KjnaZrkA6Wag74W8qQc=;
        b=O7KmN93jJMp5T8lXtaZarBG3EEdwX0wRSCov9uSYS1PPsnYrGKFlekfF4UdMdiMrOx
         wDY2g3smPSBBM+E9s+ldcHKjAzwFQEcYdGvgrPPg3/3qudqqG+ryPW1dYJUZbHITO2pt
         3op4/nqk7bqf1Qg2Z0+QDfIDfxyfpkqKT6TeBXsV3SO2jSH8/5AqVtN9Ohqz6ERUaybK
         AY+RTvQl+dUdpmE6VYkG5KELBKPx37+f4rShKKTG2QOV3E1iEaAUpRFJw6FQTmhy+aOh
         Vatckbf3FSFRKOqYoQNSg+0UhG+BjkEBSupKqHMX7/oxUPu+DIOqN25P41uzskYYBfWh
         8xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791627049; x=1792231849;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LK95suqIwIMlxETWM1WHHhD9KjnaZrkA6Wag74W8qQc=;
        b=nVqal8XwXeNpcFtMxeShVj9t8yjJQZ8xyOAo/3PDxOPdf+2To5BzHtXtbxgTQi6+o6
         D6IDIjUZU8oaMgBDfirx55HcYAQTNgyhsjUu0i+RXNkLsRDHIsfoeW/HsT9n4GlxMlcm
         yKZngtlNbHuwzygzwfjzOVGC1hP7mtIKZB/jtcbHW7IIJQXyiTSGudEA67CuHMRVlJPW
         jKC7yZWkL6O43a7NVDEbB3ETHaUhW6+tLJWyuJaCufFuQE0sBJm7ID+Z/yW6+KOFoftr
         rLWbOLTNYVz3hjwMxXnYFF71xr5xTmFbOb1XGF9zdrZqKktJB7MSCAFWo+eFA2yRyisu
         XuZA==
X-Gm-Message-State: AFq9FYJ+rYBsgOOyYtTx/RtJRspjhbvhExKXVvceIpD3wpyL8Jjc7aSs
	/oO6AkWJ/PDWqmApqPaLzIPfQuiZeEsQTiSo8+yBa5oRA64jjqbp0tYqICDFP1Cf
X-Gm-Gg: AYBFou05Tgv2rMis4eOzymMbtja3yD07GoGzRMY6vwwvLuXxzi0CcNaVjd2UeJ7mANO
	fFdmtE7jDt5fhu4wu0EeOlJN4uVuWt2q+EWw1KYa2luQ+02dtoghPJCuuCMU8FW/VcreZlmdkwh
	QZWXuuWy2L/MUBip8Y8sEY4BJAYA1SxJI2vUUfJ70K4UDf6/esgBxUN7hr5AKhPnUUba8AW0sIr
	TLgJt/fFO32qDiR3Qix/6/JSK+byAcnkrhZSwCIWmj8z6x4JKsB4Q++oT5wUdzGu3//AvPdFl1P
	mMElhgyi1iFa+gU9HDjdXlNAr+hxB8BRK7sxZ2UqNQ9q0SKufKBb0QlaqeVj7TDL+6sJZ64uFu4
	fsGbsvFe9T0RLj99U/RWibbkqZrr2R3gO15dCX4FTsav0NFs3jcGgOHzX5/fVw2I16wUqGhv288
	AX0d/b1Yx1TDuNRMw61o2S0zOWN4nCNXS2zzuZhvxnCDqaBGHDFzLEHgknFl0m499/PuMwFGCe
X-Received: by 2002:a05:6a00:44c9:b0:851:c2a6:172f with SMTP id d2e1a72fcca58-897c3ef97b0mr3883417b3a.7.1791627049250;
        Sat, 10 Oct 2026 03:10:49 -0700 (PDT)
Received: from dev.local ([163.43.243.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c37de99fsm2069988b3a.25.2026.10.10.03.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:10:48 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Sat, 10 Oct 2026 19:10:40 +0900
Subject: [PATCH net-next v2 2/2] seg6: skip the route refcount in seg6local
 IPv4 lookups
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-seg6-lookup-noref-v2-2-51c09dd98197@gmail.com>
References: <20261010-seg6-lookup-noref-v2-0-51c09dd98197@gmail.com>
In-Reply-To: <20261010-seg6-lookup-noref-v2-0-51c09dd98197@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2368;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=NxGySGRW/C4GCaMH6YssU1T4XSy1dh7+6mdwaFS162o=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqyg8gPPHzi05/ZRz5TTStwF4TZCswAt/8CysTL
 Lk7tE52VriJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCasoPIAAKCRAq19F1Kl0b
 TW0CD/95ZrgxR1P0lfP0hcouuWftAdsCGfdvbAyfLk+KwTstaTMgqaQcqi97dUrU9qrQ3XtKg3l
 kfOHuF1Z6Y8hsY+cqtepcO7+AUqlEBR2W0gG7zzyTLrTk5JnMq3jlnDZtrC8u2lMSprYwyatJDO
 NKGYNszMQxlo2lgvtK/jbGw7+nMfLSRZ45h2dxCpuZDPX2gxvjb5j3IMiy0lhrJwdDXpoh8P/gW
 OZWz2Zk6Hf31zoyrtMkcm2sX59XDK5TxOU/eVOgMkwSm+34ymse1xv+tow8131Scpxyrai9btEK
 tCgAmSUO7PXiAXsWU0+zdFObfu1CqK7xfe2Er+MXD9AIP6aSaOfFIi2qpfw+qnUIcC2qjERoH0o
 3aciJWRzHE9i27ii0PhffQ+X4p0xGgnKd9oZKGKFSyriSpeZECFTmNJprF87Nryy4xbOdhCTpKc
 QpalJJHRUwx1wUlwJTnow1t0uHh8DMIn+Jv8NT8xNpTbLmJBZcECLlNaHHYPMPa2i9jVZLgG/K1
 V1NasURqPtV/du34uvAr3eSY3pw/Fmi5lfXr6nHEW+zKmPIa2NswMNFo2FymvjCrgJdlBHVK35k
 22QT+veOOecervVtJS7IjMKCSwkoG2iSC3z4GkpznBWGYFecxi9LrLh5nCFT875LPYDTNJ8j2YZ
 z9EEaTxStyLbrqQ==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

ip_route_input() looks the input route up with ip_route_input_noref()
and then forces a reference on it, which is dropped again when the
packet is transmitted.  End.DX4 and End.DT4 call it from the RCU
read-side section of the receive path, either directly from the
seg6local input handler or from a netfilter okfn, and hand the skb to
dst_input() before leaving that section.

Use ip_route_input_noref(), as ip_rcv_finish() does.

Throughput at 0.5% packet loss of 82-byte IPv4-in-IPv6 UDP packets
(no SRH), spread by RSS on an ixgbe 82599ES across two 10-core Xeon
E5-2650 v3, offered by TRex over 10 runs of 10 s, in Mpps:

  End.DX4
  queues  cores                   before   after
  1       1                        0.791   0.811  (+2.5%)
  10      10 on the NIC's socket   6.118   7.394  (+20.9%)
  16      10 + 6 on two sockets    3.305  10.205  (+208.8%)

  End.DT4
  queues  cores                   before   after
  1       1                        0.481   0.489  (+1.6%)
  10      10 on the NIC's socket   4.328   4.588  (+6.0%)
  16      10 + 6 on two sockets    3.351   7.153  (+113.5%)

Every CPU takes and drops a reference on the same input route, the
one cached on the nexthop.  At 16 queues that cache line bounces
between the sockets, and skb_dst_force() and dst_release() together
take more than half of the cycles for End.DX4 and over 40% for End.DT4.

Assisted-by: LLM
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 net/ipv6/seg6_local.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index f23330278922..60abd139dbe3 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1099,7 +1099,7 @@ static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
 
 	skb_dst_drop(skb);
 
-	reason = ip_route_input(skb, nhaddr, iph->saddr, 0, skb->dev);
+	reason = ip_route_input_noref(skb, nhaddr, iph->saddr, 0, skb->dev);
 	if (reason) {
 		kfree_skb_reason(skb, reason);
 		return -EINVAL;
@@ -1325,7 +1325,7 @@ static int input_action_end_dt4(struct sk_buff *skb,
 
 	iph = ip_hdr(skb);
 
-	reason = ip_route_input(skb, iph->daddr, iph->saddr, 0, skb->dev);
+	reason = ip_route_input_noref(skb, iph->daddr, iph->saddr, 0, skb->dev);
 	if (unlikely(reason))
 		goto drop;
 

-- 
2.50.1

