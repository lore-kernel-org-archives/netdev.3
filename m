Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794183029;
	b=bU7AV/P/0gM/MCYiLbBCuCS2aCAEG+X1LyIyWkTSy4CUrWDhundUb0PIIK6Y0eN3D3tj
	 xhSK/DyN6la49J3xwqm1l60x318ywlg7Fd7Vg+ElYy1/0Cplu308ujYlvZN6qbdNwwKeU
	 9Y+lR7+L5z2h41jJpeCbeMTHgBkiOPVpxVVB+XCWEG9uYCsIQ1ezWgMcL57M2AisoBRtG
	 orteeAl2NhY12enUMxzw/Wgw4q6zWd3qPQBlvQxRVtg7gGJ53BzCRkwNcusUDIpkAq3Xd
	 uvkuvCT6d+FkeRA/a7DvlX1BzkVdWBQt030w/ZzzBGfeipp8uXJhLrqKPZeS6hMEY3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794183029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=aTuh+D7Cip1uCxKjxcVHv7QGaADbK8cS88J8p1XYOCs=;
	b=gJfCj+evTseueokoBVPWeKS5uMmSwsDkaFHGHuDYgJsQYy8pdMWVRaUAzKSi6ccBCZX2
	 PeKqGCmhP5VmSR7PrLhsLO7s/RpMvJ+s5T9AnnWW6AgAPK+BR9fYruG0jDbMGTgxEXUct
	 7kV+Sm1rn80mmdK0fNYG0upG/fDJheEg8dC9ARsP+zdMsxxemoxkC0mpCoZcnMM1tBUGM
	 BMGdrA86bxyRN4cPHFpDSQemvcMdBYJlzeSgW0N1ktT6ypGS1vCKb8Cv6FsoKQQaL6X7v
	 wPUGbcsz3dA3qRSUIoIfykIImtD0bpIZm3SYIYRyt7iN4YR+b+Tp5K/9d1naHnPtmHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W7hA4wa8;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DCE606A331
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 00:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5DCE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W7hA4wa8
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36dbde64409so597657eec.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 16:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794183023; x=1794787823; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aTuh+D7Cip1uCxKjxcVHv7QGaADbK8cS88J8p1XYOCs=;
        b=W7hA4wa8ijNJCw4CwGow3NeB/DI++T5rK/FGziOfWF8uRnOTVrI9aTGxVpT/HoJEUu
         2Lbvlm3ENwuZ1tVxx/+z/mukTguORCOT7Czx6Pu7CmApHUatprL4ck/HxUp+naLG8rRl
         cKCtE5msb/z2sUNv8AgIvbRLp/jFtSzMQERePztWquALoHIH4U9rwvi0cXIuQ06/Xmrm
         S/I2MpyBFYsdz7+rhF/XIKgPg2aweWhtVuBCYl53c8vE7Mt9RVQ/+QkWDzekbKlVAxy6
         U7rOyh0hN3MpRSUijpXVAKQ5vOqy2yBv/pjuT+6BpnTnugv3AA6MOC6h6Nk7sIKclaUZ
         1jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794183023; x=1794787823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aTuh+D7Cip1uCxKjxcVHv7QGaADbK8cS88J8p1XYOCs=;
        b=iedhNnfuhhaUmIs2HAjskhcNI+MDCetKM2sCaWiwY1Q53M6sZtYODUGJLhrd2Olncc
         6cs7IB6QsCIJcG0RlEKq3+ysSko4dyCBGrBY6YfBfjPjpjaZ3ChcM8DFPAD9GNVsRwU8
         KZQdYbLw6wrtniwvmoceiltdWfaI7dRNQ1YX4TH5hk7nEFM4cwHG2k2yowtcJr7RdB8f
         QEpX7IUvuCwvN2jtdHauIJghli+wuWwTKUOa4aGlRX/dSmw2ymLvAeMftW4+gGwMscev
         WoMJAFx71Y2s3E5Ab73YwoeIft0pRbcHF3Fyq4QSjHcvEba4AWKN/v3IkmIw4l394eFH
         9T1w==
X-Gm-Message-State: APuU4Z+BAoOFvyuBAl3x1VTEshZgO/ztSMmnAQ7HUOCfE9uiijxw+JI6
	RusdD7qCqqXWM5/USZrzE9g8blv5XMJMO3aNwRaZy1sFEf8Tw+CuYBPB
X-Gm-Gg: AYBFou3tvRbWU6i/Ii8sHXD4NFc0zpPpTwfeAPuHh1jJ9/muhYjOpQOUSTtOdmBweQi
	tsC3805/KRAnZcdlWMOZiUpbUYCFxwfDlusI95VJZr5I6IhxwaqDOxmjqtxo3wqG5273/U/k99d
	6VyEhT+GVfp/eCz5zDTWg5yNgyZoFD280PzOYVD5Y+uA6bIMZyz4VXF5bbOw2HmqPniOcQvLQm6
	+Ch4zwZajWHXe5CBxpui2/ylP8ABJ4tVn8bNRuYHnniByOY1M4SqQaXlwWl/wpqkASGdkEkTmAO
	KFbVu09s9VR6W/f9fsZ8oFxMA1xYtZsR0r9E6dRSq8JFjFb/jtmN6qNhwChkB9O+to1T0G0++YA
	YSYmc3PMI1N2GDiEESr8Gb20G5RU9chdIEr4CsYGhdRV8PrsxExSIlFiLgi7NTdy8+ACAvWg3Rh
	g+xCWm0Wgg1xZUN2sRg3fSoOB+m81APkhb15herAjFjH+/unhwC5/UZYBJEubRWkUdOvSYK+uFK
	2pE4t1VoOjBWkdXjC8QyJ/owTsAp0ztmE9MtsmNDzM6HR4cVPV5B77eluMw76NByfxfqt7uE3bY
	KFPu8U1WUXQmHILjBblBh2BOGonhnIs=
X-Received: by 2002:a05:7301:9f03:b0:370:cc56:b61a with SMTP id 5a478bee46e88-37258c2acefmr6305160eec.39.1794183022661;
        Sun, 08 Nov 2026 16:10:22 -0800 (PST)
Received: from dev.local ([163.43.243.221])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265ff3415sm7790873eec.18.2026.11.08.16.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:10:22 -0800 (PST)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Mon, 09 Nov 2026 09:10:15 +0900
Subject: [PATCH net-next v5 2/2] seg6: skip the route refcount in seg6local
 IPv4 lookups
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-seg6-lookup-noref-v5-2-96dc6a652c7e@gmail.com>
References: <20261109-seg6-lookup-noref-v5-0-96dc6a652c7e@gmail.com>
In-Reply-To: <20261109-seg6-lookup-noref-v5-0-96dc6a652c7e@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabriel Goller <g.goller@proxmox.com>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2336;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=dRDW/7at3wyNN9uALP8BS6Z0fSc8Nk/01osTUNBgfr4=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBq8Q9ne54xSxsIqRODiS6WLgnKL/Om7qTS/htVc
 5aEz8M4s1aJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCavEPZwAKCRAq19F1Kl0b
 TTVQEACGqdYYTYW7PI6VwbE05E4slUIqB0LuMgzBlLKrtI2SGGsABRJkArKXg+htuZB8jUZmxTf
 HudCbPU1buxhsaxIP7aaoGxXHNZLf9n2Uu0g70F3CXOCAKIL0V9jl7G68p8Ct/HImDOmphK9dXY
 Py1eyi8w5gFveKa1DNM70phSy7pCuiEAp96qG1jJD8ftX2bdtt5pFX+wKYrnaY6b1awEq/0oZcm
 nUULivPGBjMMScq+YJa72ovYX7xfslOZ8JeDF8Z+J9+bL+v5OITxOAmPGFyVQ9XchboYT/1ZYY8
 KB8AKy1P1fOiNeKimpdquU51sFjwJdv3UHptGw1GIt5kpe2sGGeUCbHzxl/enR9vfUa8D3VvR8t
 N/qAGjZG5zluv6JVDSLmQnuUx4shuZiC67DLsv6tdtVH+1mFDQ5R0DYhYQBOr6nBfxTjDjv1oS2
 kj2GH16NvbBLk3mQ8meYTseUFGZeeLeOLNGXKJPHWvCXRQuZ5hMQqAcoUKSZoRN+h159mVebglN
 /henMKFfhgRhGvwiRnCxAgt+FEFjdsCDX7KU39zdTLsgLeJS80jmGXHvB7muQGFg2Q5ar1PhqnO
 oznE6iOMtDYs3HHW22yifuj4mh7dthExVUws8FFwssJVb7cDNYdIQhu+xuCaqNZuyNIRyDLytHn
 iqrCrxtOIAVtdrw==
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

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 net/ipv6/seg6_local.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 7fbcf590297d..209e31c21e33 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1096,7 +1096,7 @@ static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
 
 	skb_dst_drop(skb);
 
-	reason = ip_route_input(skb, nhaddr, iph->saddr, 0, skb->dev);
+	reason = ip_route_input_noref(skb, nhaddr, iph->saddr, 0, skb->dev);
 	if (reason) {
 		kfree_skb_reason(skb, reason);
 		return -EINVAL;
@@ -1322,7 +1322,7 @@ static int input_action_end_dt4(struct sk_buff *skb,
 
 	iph = ip_hdr(skb);
 
-	reason = ip_route_input(skb, iph->daddr, iph->saddr, 0, skb->dev);
+	reason = ip_route_input_noref(skb, iph->daddr, iph->saddr, 0, skb->dev);
 	if (unlikely(reason))
 		goto drop;
 

-- 
2.50.1

