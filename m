Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF9534E75D
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791736213; cv=none; b=TmSSnP6uxGR2qydzTQBa/7DpZcMNY/x/xeFczi/C429zJQwDlMSWM4GMhSsgW4OYGJt6Dr88DTrod6uDSuZiNpEvG/nFNAx1r9lSJkluNrE0fMNe9B8ZIk/k4CJFazUNkwP6qrZtRMjlugej0gvAAXEuuhi0i8/Oa4uFEqWfSl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791736213; c=relaxed/simple;
	bh=hEc0kCOZfiUiEVRrrIDOsGo2o7eOAQwwDExOmAG8wnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnbiXx3izMbWYhjUMMB8Y0YM7Q1hCoHQwRCWf3vlDfzZA4g+NQ8Xm/4rv/HE1+Dm5aBt3wjtvnN+3iTfO3he8VyLGEmrD/7fWBcYV8WcR+jN9Y6EWivkcQAiNdBBSxaFrLVvC7HcQmYHpBbjVCjEU3eRk2PQwUIXwrrlswvlYSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=E5o32VkB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="E5o32VkB"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so9055825e9.3
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 09:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1791736206; x=1792341006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IAgIBxS7QL67cIVzFUUyXiPNC+DuOESUIt9z3Xwqot0=;
        b=E5o32VkBFUzMHQRHx4jBWnA/wI3H7iAaw3hVn5jnobA4t2hdgxVT8zAz1/377VgTue
         yR+bjHD+D/6C8EsB5WnpfWkJh76MVSlcSiJUTgBHzgGBT9ZlalzBV3WH1DVqgA6hvBws
         DWnEakL7S0yYGmLics/zDc7GmstJ0w9VFM7NbD3kG7slFO6/6UnI3BRX5qEW1i3xlGr6
         YffIK1RQHglZePGxSmSDdYpykAcaexzxez08hzAhMfBAGJQOlWJkDt3AiIq1P5Qp4BYn
         9ThV0zWUUUYIwUh59ES9ioE8TmhaRVwTpDQbzrSg+o5xcZwHPtgtxDjL2OS68MiuUFId
         Ybpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791736206; x=1792341006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IAgIBxS7QL67cIVzFUUyXiPNC+DuOESUIt9z3Xwqot0=;
        b=rczwLpSO9vpU2mf1lmuTtbqx2m9nTEmLVTH9TZzKnmEZk9DcSpMxfccgJano0QNPq3
         DaBfWqn7Gc/J3MDCeIm2oT/iGuiHf+gMYKJNjNd3bfzxw6n0fHYuV0Knt+6t218HMTay
         hw6xvG85OrWs3SrHLJ4/HFM7MeVrX370IC6iLMq7DxtAHvbtRfYViIbH3o6paMkDU5lG
         HgNv2he4JlizsLP4wcx4zYiVptEf+Zz8ytdMpEmfWbvJysW86bG/oZDfLzpevY3shZiU
         Qy5LUmHjZJL4KheGUI5gzUEDGcZiMOqYnUZB7HWiJnrWKJ1fD0Jmisv/+/cEU5dl4xUD
         uAaQ==
X-Gm-Message-State: AFq9FYJIVOcD9if/gDwJ4KESW0QhRDc9KQyhSYkuPFRt6DSgqEWeZ6q/
	N8rkAO6kU9CEy41nIJIlRhK1o/8y4N27cfVZlFQ0O4Acp+JuoSnGlBZyIekBqnIeVNtZR4yRa2A
	WCexAig==
X-Gm-Gg: AYBFou3oAGiSnRb91r4loqk2MOvBhkmh+R1jIiOlzyxtMTS9hfDvsmCuQLaDDOdkpjz
	mT9Q9TXo57/p0v16sgwHroei5PfOYR/OjQU4gTcZ4U56FnAJdzVCqoFAtNwS3xxSmeDhMIe3lHC
	Y1JJcJOhTdkzug1WulBMhwK3xt+ghAp4d5pSZUlgM763rXpBrlrS4WYjIm6+4KLV3fTC74NpI6u
	UyYxGCerBoBtY7B2u8hP+s+YOak7WBdfhG50DHZXSTuUKixs0Pl2b+R4sT0E4r6MHH0/7lSJv/t
	uj2NV0dgKsiNxxcWrDZUiwf+mVC+M+mx6nK20E7zfmrkIi6Wbt6tcNuSjVtrxaeYjTaBOT/t4aM
	6vMyMQH5ldLnDul+zLBqwSB+EJWVRR9IT5L2mE9SnMH+Rb3qEvutY3sE1uIvF8VSHp0rXgMfRVk
	NDu15NXxZGYBv+tG4z4BkSS9w0/WJ5MDpJKJJXWq7QnA7cOb4WvZ9KL4S8v1hnH3ROATOki5hRS
	NE2SVpn1gXy68FOEhG+UoxJqwPN2654asbtxKwtdW8baXQ91zFnu6ZIGdB6PcpYPOg5PB05gulY
	QdrasNiiJSRxSwEMAOOlAgfvEezLegWrOWG0fr+j6ayk1oIJFsR7z3rLbygR5FdYUXAuUXB9kIR
	YiIf6tAHycu+i6kVEoyMhnhHR7Vu+rSI5rC81szUGKH1qN745TpMc4X+g6AMbrBzpTfy+dQvEFw
	mTknRkk8rvGONnk4FUW92O2dPwhMBf8//BwIUALLkeztrD1BjF
X-Received: by 2002:a05:600c:4747:b0:4a1:88de:9e8b with SMTP id 5b1f17b1804b1-4a18e49d65dmr136454365e9.5.1791736205975;
        Sun, 11 Oct 2026 09:30:05 -0700 (PDT)
Received: from Desktop.vpn.uni-hamburg.de (dhcp-40-52.vpn.uni-hamburg.de. [134.100.40.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9acc936sm14657920f8f.44.2026.10.11.09.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 09:30:05 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	willemb@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 3/3] ipmr: do not drop GSO packets that fit the MTU after segmentation
Date: Sun, 11 Oct 2026 18:29:57 +0200
Message-ID: <20261011162957.1328474-4-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011162957.1328474-1-julius@bairaktaris.de>
References: <20261011162957.1328474-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipmr_prepare_xmit() drops a packet with DF set when skb->len exceeds the
route MTU, without checking whether it is a GSO packet. A UDP multicast
stream received with fraglist GRO or UDP GRO forwarding enabled is
aggregated into GSO packets, and every aggregate is dropped with
FragFails, while ip_forward() lets the same packets pass by checking
skb_gso_validate_network_len(). Do the same for multicast routing,
leaving room for the outer header on tunnel vifs. ip6mr has no such
check and leaves GSO packets to ip6_output().

On an IPQ8074 router with fraglist GRO on, a 10 Mbit/s stream of
1316-byte DF datagrams routed by igmpproxy loses 14.5 to 15.5% (n=3)
and 0% with this change.

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 net/ipv4/ipmr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index f0666749b14a7..983565c0711fa 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1914,6 +1914,7 @@ static int ipmr_prepare_xmit(struct net *net, struct mr_table *mrt,
 	struct rtable *rt;
 	struct flowi4 fl4;
 	int    encap = 0;
+	unsigned int mtu;
 
 	vif_dev = vif_dev_read(vif);
 	if (!vif_dev)
@@ -1946,7 +1947,10 @@ static int ipmr_prepare_xmit(struct net *net, struct mr_table *mrt,
 			return -1;
 	}
 
-	if (skb->len+encap > dst4_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
+	mtu = dst4_mtu(&rt->dst);
+	if (skb->len + encap > mtu && (ntohs(iph->frag_off) & IP_DF) &&
+	    !(skb_is_gso(skb) && mtu > encap &&
+	      skb_gso_validate_network_len(skb, mtu - encap))) {
 		/* Do not fragment multicasts. Alas, IPv4 does not
 		 * allow to send ICMP, so that packets will disappear
 		 * to blackhole.
-- 
2.53.0

