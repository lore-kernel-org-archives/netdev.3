Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516064;
	b=i+ZbZgLl5pZZ8W8wLp3XnMn2FAH28WqOf7jdevFo1SoBie0hDMCUz40rPdadUgdn13kS
	 ez9XMY6QV+cn2KmfFcvFEsgfXKgZh5LzRS4SKz3Gum5Qd2Eaitd5K7S1pJee1/qdb9cfi
	 nZGu13brS6Nnkj+WoOGLfK+FWomCMN5dG/8r95BRHbURlEFxuBCuOKrb5sPfMj16bd8lA
	 grpqqjGsoDA1/8TQbaD3D6nFmHduX2ypnHj/UiJtU8pGXzVORRLazCAnudZvrlZfKQATF
	 OArelS+ij/kE8K9OTfVSWtU56b6SHqSiY22GNzuM9lCj9/BhsDe5A6B2txD7YzLVo4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3Yb4kVEFgMEgPKm+KoyaP1A4M2GZljeQjc5uyGS7RaM=;
	b=aDym+SfIJSRwPml79fm9d7TDd6lL7LmmKTGrvmMFX8LwoxJJ6R9OdIkMGhbSdGaUe6/3
	 gPC1BynDNHEChBgMz0V2W4RZbfVpEWYHQwYDGr2B1CtNWkdP4TJTokc6u9PlNfi87c0Ty
	 jr8CmK0gN8GYtPNH39/f6oURoSPG/CjUNVfv83bJwaGRAaDKjIdb8iKqiSEmRb2iru1NR
	 CdKBcVtrs6rmDPfOWNSHWeGQfUw1lP2IVPigtODA3s6ufr0TxXTFAwUCYPvulTFihI11t
	 6FfEvA2U2+/vQdnaBE1ouQOOOfQ2gB4JPE7+c8Zf+II0WZMtU+tqNpk7pnB42aFkO8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=LnqU7fZZ;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB2F606A89B
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FB2F606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=LnqU7fZZ
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53c4b82919fso1771221cf.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794516063; x=1795120863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Yb4kVEFgMEgPKm+KoyaP1A4M2GZljeQjc5uyGS7RaM=;
        b=LnqU7fZZmWIwa5cGC7/3ZZfwKcvi/O6kUXU+kXsJpqk3FgtXw2cS1ZI3L6stI+6N1t
         JSwtn2NXkHxrTcnkOQ8745vdji2oUdnv67cQLQQYFdWKqMrRjHWeasbX8hfn5cSQNw2i
         3gVgn+/BuE9ZhWUAPhVFfDoqL7wf5A6LH7MCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794516063; x=1795120863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Yb4kVEFgMEgPKm+KoyaP1A4M2GZljeQjc5uyGS7RaM=;
        b=faCAeNcYUEEZp6xqU5cGnls3iqTfIM42FzZIpoqBPtQ+3xqDTJOJbLLstXiJgp/w3k
         FOp3boCNl17RRowIa+GQGeY8gZSlmxWR1afyHHPBLf0QT/kyXm61SjepD1y/DrgTEbJr
         FHSse28vBoEkVm5dfV7dtzYtGJ8QhlRi2uMfWh96A3ygSkg3BTq7cnqcKzCKO3zKsaP+
         hxAqtMa6EQVC512QQ7lUshVYrVz1wz9Irm8pceiYGJBx+AHlQJONEOSqAnud3dL1iNKX
         fymW9NM84hKJ0pzW5CBHD7Sv+1igwhGYxLQDNfYuzN3swPuumxMAJEXEyJORVDqAflPt
         CBpg==
X-Gm-Message-State: APuU4Z9TR7ci3B/kZoC25wm3SRPso9wn2GpIXoGe6aMFb09+WbzZJKel
	oTh5XKhKnFbh3z9/pcTMzKoB1JK0xltzfgITMc/wGRgaEGdX33IEQtcRkOU/ipRtKJ4OJweC6Jg
	u93A=
X-Gm-Gg: AYBFou1WTUmoJ3pGJ9Vsutv26QgnC0VTCsRWoJwKYPxQilnGjZwVsDfj7pSi69l1wyf
	+d4rL/ipCK9Fh5TF61B6x6gaWGqRsvUF+FK7q5ENdZeYkbLeezKOGqQy/hrCsYVoNjnMKQFSKss
	8v6UPMARNal5CL+IluKl5jaC0JBmciQ7wZKZ5BFYsIdUhw9rZO7baniWWBwC/O4NT/SejlAYCrO
	A9M/zWQOHf0jCVKzbHy2nn9Yfiqoj46oqLmo4ROz5PpO54n90MW/nnw2c6Ck5wZ6lVBeSlJZReU
	LQFq1GMcXu98jujMyU2/1YV7UD/dIEosxrJ+Jk02qadi7kk3txrFVwkwWgXciy+2X7vWoATGs2M
	T2E3QKKQ8E95/LEGLG+lpDwbuI2wt1kFmWIQVd7fygG2bKx1bnlgW6YVHzU0zC33VneS88cxu22
	ZvzgN4EgN86I0dOqQLfiZDgWlhZ6pzdquQbLBnhkQeksQQxQbHlv59z2Aij97qNZYuSBwihxC3P
	TrH9AapMP0MoCY/b06ptmF0bBWKWDL0dV+/gKZ+BdzeL2Qb273hRa2UDTu7kploLDJKLAwSrpQJ
	0BJdaa9brDr5E3UyGdVBfUgxfd5x0fxnKZSiZK1Ai31WlEVujJZhYmBpchi3v+gymPVtD4xxtYc
	=
X-Received: by 2002:a05:622a:229e:b0:536:33bf:7bf5 with SMTP id d75a77b69052e-55ac8895596mr9023091cf.29.1794516062959;
        Thu, 12 Nov 2026 12:41:02 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d61888sm4452116d6.20.2026.11.12.12.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:41:02 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v2 3/4] netfilter: nft_fwd_netdev: drop the stale dst when steering to a device
Date: Thu, 12 Nov 2026 15:40:48 -0500
Message-Id: <CORE-9NOG.v2.r0.20261112151659-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CORE-9NOG.v2.r0.20261112151659@mojatatu.com>
References: <CORE-9NOG.v2.r0.20261112151659@mojatatu.com>
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

This is a followup of the review of the teql arp-queue fix as reported
by Sashiko.

The issue:
The neighbour variant of fwd rewrites skb->dev to the configured output
device and calls neigh_xmit(), but leaves the skb's dst untouched. If that
device's neighbour for the configured nexthop is incomplete, the packet is
parked on the neighbour's arp_queue while the stale dst still describes the
device the packet was routed through. Draining the queue re-looks the
neighbour up from that dst, so the frame is built with the routed device's
link-layer header and then transmitted on the configured device. The packet
leaves with another device's addresses.

The Fix:
Release the dst before the device switch. Both lookup inputs the neighbour
transmission needs, the device and the nexthop, are supplied by the rule,
so the route dst is never consulted. Without it the queue drain keeps the
parking neighbour and the frame carries the configured device's addresses.

The release goes through skb_dst_drop_keep_metadata(), so encapsulation
parameters a route carries are handed over to a metadata dst instead of
being lost, and a metadata dst already on the packet is left in place. If
that copy cannot be allocated the packet is dropped, never sent with the
stale route.

Conditions to recreate the bug:
Two network namespaces, A (10.10.0.1/24) and B (10.1.0.1/24) in one, their
veth peers in the other with only A's peer addressed (10.10.0.2/24) so B's
nexthop cannot be resolved by ARP. Resolve A's neighbour for 10.10.0.2 as
permanent, then load this ruleset on A:

    table netdev t {
            chain c {
                    type filter hook egress device va priority 0
                    policy accept
                    fwd ip to 10.1.0.2 device vb
            }
    }

Send one packet to 10.10.0.2. It is parked on B's incomplete neighbour
for 10.1.0.2; once that neighbour becomes valid the frame leaves B
carrying A's source address and A's neighbour as the destination.

Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com
Link: https://lore.kernel.org/netdev/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com/
Link: https://lore.kernel.org/netdev/avTfQjFQYR2NNdRg@chamomile/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2:
- Do not drop a dst that is not a route: a DST_METADATA dst is the tunnel
  template a tunnel helper attached to the packet, and dropping it discards
  the encapsulation parameters.  Considered comment from Pablo Neira Ayuso.
- Keep a route's encapsulation parameters as well: a route installed with an
  ip, ip6 or xfrm encapsulation carries them in dst->lwtstate, which a drop
  would discard before a downstream tunnel or xfrm device could use them.
  The dst release now goes through a helper that moves them onto a metadata
  dst first (new 2/4).

 net/netfilter/nft_fwd_netdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index a48c2f765bba..3f2ffda1998c 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -14,6 +14,7 @@
 #include <net/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables_offload.h>
 #include <net/netfilter/nf_dup_netdev.h>
+#include <net/dst_metadata.h>
 #include <net/neighbour.h>
 #include <net/ip.h>
 
@@ -159,6 +160,11 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
 		goto out;
 	}
 
+	if (!skb_dst_drop_keep_metadata(skb)) {
+		verdict = NF_DROP;
+		goto out;
+	}
+
 	local_bh_disable();
 	if (nf_dev_xmit_recursion()) {
 		local_bh_enable();
-- 
2.43.0

