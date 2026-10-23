Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763287;
	b=3T79w4k0/9vJG8LlJX/+TZr8GpnyIBDdmHeX36x5F/eYZMtSqskhXWS1TQcWR8w89GJ8
	 ZFn65x58Ga8rD+Tpo8DBie4REfTtMjNdRZ+/8l6iEByDgjexG4oIBdUISgc0SRSOB/xCC
	 W4iUgw52DqUf4rDzvB+3d4E/WlOdqGJemXfG4/tyT0xbzgk6KSsvF4tM0fYlwo/haubTJ
	 nD2e3T5A/9q84njXKF3RBmvmoPv6GKqWsGitQlXSRpgpjJdad/UmsJTGChDupHOV886F+
	 AaDnGG8qYeCB/CNR08I1EG8VccyN9GZZ2QrpdD0vZ/hfWHrQ3S0KBsImLPncWn8W/Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=aTuh+D7Cip1uCxKjxcVHv7QGaADbK8cS88J8p1XYOCs=;
	b=lnRESuAaJcNFjUsMm/iAZ2hVeQ4b24Hbp3rcbS9vUwv2EI5zDEVPfMgsvBfadKrykWaS
	 cUNy3bgSRYZ7rpYsTsJGF178nnNZPZiA5IOZSan9/b35QM9B7OSoUwfUeK61zxIppBX4z
	 KE+1SA7JGJCglPPaqlKPiL8bvXb0m5vj24ZtFhY5eCv6nIWcmSOfeoNGvQA21P4ggTcAc
	 KzWnO0B26DNRigumllQFjGHusQvXVesY3swU/X/OJC/VDlh7OrElrdJQDCvwKkulmLrRT
	 9Av0pY5T3iZTDag70MqWLp/KbkoVAL9N1AzIw21zNnCJZBJcfkxHknCTYN+ZeMBzOzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Y1d/PBQp";
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559D0606A32F
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 559D0606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y1d/PBQp
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2db80fcdf8bso4702955ad.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 06:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792763287; x=1793368087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aTuh+D7Cip1uCxKjxcVHv7QGaADbK8cS88J8p1XYOCs=;
        b=Y1d/PBQpYKY6/A/y71lA65P779UqaI8jgvAt/xfUqzJ47TuTdD/TgWgrzFAERp4DgD
         1rovMaCMal5+BfirxwrV+nyvBf29jE8f4OP8Bm5ybJVOuVfc4mIdxD06ygbJRbd945e2
         mpp/+y02xSsEHvyQPh4WwI02BfxmO/rW9Lgd+EivWxhu6VSztRAt8W71aAQjlGnlPqUD
         oXU7PHPGItaP6U789LSd/Ovm3Zwb+8J5cCA0bYIZAulenW6WWn5uXFtZzdoqg2nG5hvA
         prOq+66GfNJ1wRr/zYdLRrIwCtEHpinh9POKCj215i5TSXOIf+nY2dJFuU5fMPmGQQ3f
         60ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792763287; x=1793368087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aTuh+D7Cip1uCxKjxcVHv7QGaADbK8cS88J8p1XYOCs=;
        b=uyqzT0ZRpQlPA39vgwexK1x+ClkwqcHk9PkmyFOdKLRY62khRSquTogXAZ7dOoVRSF
         LtJQsGOXI7JAeWXpw6ikYmOqi/NAw10h9Anvb+EzOjE9ZPQWxjJWuLFED/poeS3x+q6t
         4jl2UkZvQHionKc3UOviPLChg+FhtVUMUnTqCiv0nuYyiQZa4rsxZeDB7yZ7xJLG6wwc
         MaDhqULtyo7VPbj1Diu8D3DxsNa6c3hPgayxPsUz6DwU0kGlLYXl1k05MOhyI5hA5X4T
         Bqa27k9LCz2W9SBvuiCVMtokeF8B1eyE6gpaU3oawjxSa/kNGBUq8t7KS6hdUUv/+uWh
         ctkA==
X-Gm-Message-State: AFq9FYIIaYqqsTRhnx48wfbMOKsQ3ZFDyS1W9oPUl0H6NNxYFhB6bmIp
	HBr7UNy53gD17bfDIh8vqf6lsnpCkI0ExUAGvcMyVFELEYLd1ZNbUVPx
X-Gm-Gg: AYBFou3LVEAt0hIbZkg7FWAA+GEULl1sw1Qk02UJ+frvbS75mQar0zOw40QCwoR8FMv
	7FsZuDn8gIwDLBMw3LhGrBBbreTUaYYoDmpjpVa3p65DzsWm73hRMZOyN7T2hIzpdTRFHVtwi4z
	tU6edd7ggINaASwlcBP7MoBaSyiJdZKHW2W7cT9Uex41PaAucZHnxNOUnWTFe0RVvjgLLTl5w8L
	vAbmrGU1pJChdap1K+jzh3li+oylT68DB4hoYzERTX8gTzM7MMBdbdb4LJRlWFOCxvrQOUz5G2w
	lVMOB7WNOEBK2nRRUIJ7HpDHMJys99aZgXX/FnECN1mniP6qdRpElvnpHQd/kl7QSESfRSRg4Dy
	6Xl+/DS1x/9mG5/I86IiOxh6A7wf12RMfSm3IHWoqFZT3CFZbC/n0bjfwHGkp3bmR285TRClDhz
	frrfucPPpcZJwhfR5my/d32m4H6qetuBrV5192+FQ+sfyplN3LHU+CC/hzIZcYsQjxasOMq1oHj
	/en9pj8KEhgJsRw5IvvrLQjEn0ClcfwIRj7jgpfwZ3SjxsHChgVWeyO
X-Received: by 2002:a17:902:cf0b:b0:2e9:9524:b004 with SMTP id d9443c01a7336-2ea7d07bdf0mr21009825ad.59.1792763286653;
        Fri, 23 Oct 2026 06:48:06 -0700 (PDT)
Received: from dev.local ([163.43.243.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea946778ccsm521295ad.9.2026.10.23.06.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:48:06 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Fri, 23 Oct 2026 22:47:57 +0900
Subject: [PATCH net-next v4 2/2] seg6: skip the route refcount in seg6local
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
Message-Id: <20261023-seg6-lookup-noref-v4-2-0ad0a83960ef@gmail.com>
References: <20261023-seg6-lookup-noref-v4-0-0ad0a83960ef@gmail.com>
In-Reply-To: <20261023-seg6-lookup-noref-v4-0-0ad0a83960ef@gmail.com>
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
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBq22WNPxnrDPhFO8axQuCzhqgzOhWydCaY329WX
 j1Ei2p6tgKJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCattljQAKCRAq19F1Kl0b
 TR8RD/4lGPTKbC9FNWBsj8NkZsNtj43e1D8FfzYa9V6UIWyJ2fkqVvoes07yH8beA2ofnin1nzd
 kcHJqbXHHV6lr5cQ96Zogc6bNrwzcKSOu/tCGZGjcewJrGfe5ECdOrHLaTiMBBjbNX2aKzz0x4P
 EZmZtyioDL+cZBMI9hnRgLAznqJi2sNcpeyz8JXxYN4r1Wpkzm9+/uZ/REoIziwJ+9msA6pOFad
 7Sse6sbbLtjH5wtczdUMzvRbjlVcXz9RkzGN0LNw14R2EjHo8fPYmMOqEWmfRv08NHaI2BCFwGH
 lBMQoXJJXhOHv3o2HkKqLeIjLceFYv9LZzUXNRW5PHfsF7S38dPPTlDs4fWMsHwPBkPPgMniqZR
 6fP4YRQux1DvJDXurBrQgor43DEZSqx5xCOaw0DEIDayptZTp2GGxgkMxy+9mOSq24ERIPG83AD
 XTRTPKU09yEjhd9OxaXBZ/9v9tvjM8LAqRGCFgC2V/MUaZShrQ6MrkWR6kZaT/9EzXwV2sXiP6I
 CHaYIEV2XnNu35llLD/RDZBURAQXfKofXCcIlPcw8NtU4/0slgEAUPNDrIxu/VsYrR5tLVLKUej
 uFNlgaLe00MBnq7wB8rwl/AoO3oxrTVttMQKxcv/FljU+9wVvaKqHTU+J/KP0A3NwPeMnK2moaw
 Je6LVzpHISBH1kw==
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

