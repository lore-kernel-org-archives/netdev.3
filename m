Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E079F3B42CE
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075179; cv=none; b=dAK7KCen/7lCZ2HbhT1Fq1vGWz0wLbmUMYgMRLTZ1VvLL0iz7U4uoh4oxqJObxQtZLtgl1V/wFklGe8P++VSkRj4ZFclDKMpr0NWUV9Hbe6mK+gvBEJ9KskrByI+fO193kKkArkbiojAXF++dyHYhOL20QiXn1BeV8/d8cbJBDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075179; c=relaxed/simple;
	bh=eRSqI15l3j5EhZBq3lARZcN78mzCenYHCSlvnMFt0VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ls4FW9k7UPuZnnT2IKrEv8CX0hrf3CVVNHS31r0NScYHWF/qOQO8nnLth/sS/V/rP902IAF3+8tCeAY2V0cT/2xVak2W6agYKTGmcrT+45Lu8kRCKBIfcWHgGVmxYadoqPpdLl6j9OTVBUOJxaeKWDDHFtQmc2ERjF5aTtx3iWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcN7B6pX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcN7B6pX"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1095557a91.3
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792075177; x=1792679977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=beLzBZIUZpM7ObPiV9MC0Cpwnobx3bUdDDmAgDdY05I=;
        b=XcN7B6pXM0znzaG5ISRfsWtkRvZ5tMQ0mvRsi/bfDZbyZt0Oz7FpKzd+8YCbzxYpqT
         LcVoYfdNDQBJg/Qgf1xD5a4YjZsyOa4FL9GRH4nOyCtNbRBIJ6PlTGRiQ2h+92Qk5hV1
         UHZUmKfCb6985KKyMa/92rMhzE0kD+SVy6hXu3as4zHRJh7PuJJdli/QHXmaNBDCgr+y
         47LtliuC6oUHG1DYOAMRykWcujuQWIhoOgdGKaXAipHVs6oAZTHq63BvDPv5//1BxGyq
         +2XIY/xOsvnAMVmu0bZuD6bPtjxbL44Q/hg+TFVEh2q2m4xFtdZH/JkImiHHGVPybRfL
         oOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075177; x=1792679977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=beLzBZIUZpM7ObPiV9MC0Cpwnobx3bUdDDmAgDdY05I=;
        b=TWaEv1kCNXf6INhKafSP0GhQTE52NvsWjUE0F794ShpD171Xk/vUxuIJ+fbBaIWp5Q
         yn39r75VAVxU0/NMGCFTNTGLDK7uvmyUzzQ+JyHDwbN5P2ODlzUNpGefmX9YmDa0izzR
         WfJh/ZvyIi13Fad63rFcToq5lH6q7UKHHyznmZQl8enaC6O+T5Z128sGVuuHeI/LTEmC
         zImpWeSJy0shcahUa07Ef0I+lRmDuabNNvR5v733vDmKaBTIXzRtJv22YgB8Wv86kjlQ
         RZ/nT4jPFiqex/SRJwzM61gnXj76cryZAdbRdwoO/GyGmbOpJFc/JJdMg+o1Xm8m9CrJ
         e9og==
X-Gm-Message-State: AFq9FYKVCl2zUOefQWMVE37910OGDQ07GwJhsueTQ7HKlkPRzUYEt/mI
	W1QgFB8q1p4TamtLCM9KTPhdKDH6ERzoqRFR9zut6N4Wvsc3fshgFmbr
X-Gm-Gg: AYBFou1m2UtGxJkY2rD9j9VWm/mNGjpeqyrPNSEt/+OZnfbMTjCq8HqE/j4+cemZhm8
	uQUaJcpbX8EPTPZDJBtyZ38fvd3wJ1jIdzUuzJ6V32NPizGHpys1C7SQJDyNerHUxAdyCvHH3r9
	jBLQPw/M5AjjkCM1iPzijt/D8DZHVo685ylP3EA90trQ2tSfvtF7Xq2AJKCW2qxXesW+8Ghhj1t
	OejrPMAeMlT8DeTpmr+To/izC6TMo9v9kn9nTBhkiAQ1eUBGopPwtv7wMP4tkI23OV10l2XozU7
	KrcU/nf5jSsUyCn2PvNysLK1gmUebh0Aa8uhnai41S9KmffUKK7GYUCfKvK0aEsXorLyDn4cH9R
	6Uw2x8YRWoHfu7uH+Jh2ltZSJTLvkvUxWMdxzAgDfH6E8sU4E23nXvMiiFj6gnzrqq6MBjtzhg8
	B2PPJ4nn8hY7vz8LyKJJ8GiW6Aejlgetqaie1GXuWSk3gS0EVULeJrZbUeXddk5iXgJGnXP9nlJ
	T6vME3H1g==
X-Received: by 2002:a17:90b:164c:b0:3ac:8897:7b9d with SMTP id 98e67ed59e1d1-3ac88978372mr4119325a91.1.1792075177278;
        Thu, 15 Oct 2026 07:39:37 -0700 (PDT)
Received: from dev.local ([163.43.243.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9377fe6esm2583465a91.3.2026.10.15.07.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:39:36 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Thu, 15 Oct 2026 23:39:28 +0900
Subject: [PATCH net-next v3 2/2] seg6: skip the route refcount in seg6local
 IPv4 lookups
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-seg6-lookup-noref-v3-2-6d51a60a67d3@gmail.com>
References: <20261015-seg6-lookup-noref-v3-0-6d51a60a67d3@gmail.com>
In-Reply-To: <20261015-seg6-lookup-noref-v3-0-6d51a60a67d3@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabriel Goller <g.goller@proxmox.com>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2354;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=eRSqI15l3j5EhZBq3lARZcN78mzCenYHCSlvnMFt0VI=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBq0OWgV62Y71e6frflzkP6jeb/zQmRMj/piFjtl
 j1M6UTYKS6JAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCatDloAAKCRAq19F1Kl0b
 Tb8AD/41ovbQl0BD6p6B5m5OaBmrqSMug/dkuXjnalKpT9oVpg78b2t9rhYCKnbwV2dD0Qhn3So
 rGkndlgJFKVk4ujcyauzb57F7m8z9DXQYCRjhQHFqm28f3z0WlX1vftI45tM+0BjpMQLV1qLZZr
 F9l0jbfceHPOnfzaisqYOQR7RNJ/CSUOYF5/WuKH2fV4hVgfLj7tm8JsBKya68NVoME19u7Q6Qj
 VqkqqZw8h29hdMTSWgZZuSLV3LhYksBfuP9wpCmyJ7mglDPz0l/DY26dWf/OAZ06bIjPNF0hf0l
 ZiqkDW17Akf5A3//YRr6O1Ym82FnUtOan052hI4QuUvd/bmCp87RwSh0lYSBLazyNRS8YEGJ8Qn
 qXH8mrrOkpUTqDVnWYPrvTG2QLsDX2AOeqebDfRVq09QNtaFFIHbmovUNmCKomcrK+nq7Wmukvr
 ywocbxIEtpKc1lOay8qpsspTNP8Fqiu3Pksl5I2e8Zwz0r+xqf4H3rgps9pi1VU88KZw9sgfxAh
 dy3PnUJMfp1PghxuZUR9Kg9fYsEfqFyBTw9KCcQ0n25F4/iBnTpxQCYraQ/Q1ng7l+s+npUBVfV
 s9EZm69wu/Iw8clSdDDgjnYqyXG4bxyUKcG0Y1QBssQDVAOb6uYUhOKxo0gEDeD8pZuXlNDAdFo
 Ox9ew7pfQOStwQg==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

ip_route_input() looks the input route up with ip_route_input_noref()
and then forces a reference on it, which is dropped again when the
packet is transmitted.  End.DX4 and End.DT4 call it and hand the skb
to dst_input() within one RCU read-side section: the one of the
receive path, or that of the nfnetlink verdict handler for a packet
reinjected from NFQUEUE.

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
index 965263ff65d3..66b22c61b835 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1095,7 +1095,7 @@ static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
 
 	skb_dst_drop(skb);
 
-	reason = ip_route_input(skb, nhaddr, iph->saddr, 0, skb->dev);
+	reason = ip_route_input_noref(skb, nhaddr, iph->saddr, 0, skb->dev);
 	if (reason) {
 		kfree_skb_reason(skb, reason);
 		return -EINVAL;
@@ -1321,7 +1321,7 @@ static int input_action_end_dt4(struct sk_buff *skb,
 
 	iph = ip_hdr(skb);
 
-	reason = ip_route_input(skb, iph->daddr, iph->saddr, 0, skb->dev);
+	reason = ip_route_input_noref(skb, iph->daddr, iph->saddr, 0, skb->dev);
 	if (unlikely(reason))
 		goto drop;
 

-- 
2.50.1

