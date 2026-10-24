Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852131;
	b=iHewk6vQE714EQzVBN6rHBhYsRtuvNhFMV9aeRsSpNg2fMR9r0YzuK/pnH0U33kloDcN
	 vyh9toY+LUSBgjwu2WGdDYYlbdALvXiJH6b3KwRIe+4ENo1bu/M1Kwwsq/GQ9CMBAEZze
	 O4LNPxLcILR0jgq7dyPMZDHdji19tV15R4POh7yqasd3Kix8bfq6e9BjB5qmUBfcXgGcP
	 c+yfc0Lscp6RjMk/1wwVn8o0ro/PKhUrgSJEh47V/dVwnmZu2XHZEjwWU/9LgGtr+oOyr
	 6AdtNJYzobAmxjR1LWTFvghjxKYIjhOZZtAdjvKvohKSmqHF4wr37zvMKhVbAFg4DCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/2EUS/g+TmWUynwL0bo6Y5RIYTXHaFvkE1EYzksbXCo=;
	b=l4vUSS8F3XPxA2LcB0dyIJlkGk6h5OMQQ3t2urrdKcZTg+12emPvtPd6zOzOHbWmILV3
	 9zzLP26b27eRXxyDKngrBw46c0kYgkk/jTj5whLEAiq9w7Y/LrN85oR0jFN/SzEdaVCYv
	 nOHyUUrt85mGB8oC6eWIe6RszOT7on+tHJy15r4+cKWIWbYGv5hQ4sv3UgCXGJVot6ybK
	 hDJYQcGKW4lkRvE09jD2ZlgdTmgcK0mBEwrkhypBdnczEvavzLTzggnFvp4hhE0mfdDT0
	 KoEilyTUdK1m/e0WhAdbjoq8ZxBUCjLvJBfltHMMM1tKBCRu4ilvojeIBFebbtEABVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=c+6IWIWv;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D26606A330
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 14:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2D26606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=c+6IWIWv
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-917ad52d7b6so16985356d6.2
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852130; x=1793456930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/2EUS/g+TmWUynwL0bo6Y5RIYTXHaFvkE1EYzksbXCo=;
        b=c+6IWIWvoV0juEB8eR2KxeLBOtkF34gPKQDPfiG0RNV4FRwivieadp/Y7RBMjRwNJz
         q7Jt0HJn013aJCqhnkSjD+9kh7IywgtEpnuC2hWiTwBFSQ2vmV9pixoS4+IkuR/27Mdt
         i8fNuB3cBdcCp4ywu5yzW1/rJvZFW/UxEisok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852130; x=1793456930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/2EUS/g+TmWUynwL0bo6Y5RIYTXHaFvkE1EYzksbXCo=;
        b=Yhx6He1r3vvleW3z8KW7WVvg/cte7GmfJQk20KTImr/sYEmnBLI4qcdJaKMzSFc7CU
         TWlCacMyxDxn7sno8qI1G8tCSDyBOSMIQKgSZXNupgbC8bBSHIgZyC+LK/sJT8AgxQ9t
         CAQILMiYnidqcA8TolKz8xmhyPltb+ZLNONJ+j9u4i6lW6E24M49z7u+RhE1pELyQZwT
         dgkKF1xwvwyCFUHNneqxfo3Fr2KTt5oKZlZlQpkaDuAp+WOGEskF46SnUY4V4jplq2AH
         oz1s1rlMq4tElIl5bDGrolw01Ql88/+J5+9Z+KNKnfUG5Hrdz+abEFlJiVGD0WTbvf+1
         xYMw==
X-Gm-Message-State: AFq9FYLfZpw7KwGSuFfEjcQbwj/iiXfIuSpz2rc+nQyTvGEgS5AljhpV
	sVoYtQYfPeRLZ6Q+Azg1efxpgmEJqRT4+/KMWAbkPBoCCh28CmmLfsNUbs4eKoIrCFtpi0iFIWc
	BugA=
X-Gm-Gg: AYBFou3Ag8NkN1mVFl0SjwHoRl71eqVVFam0NClq3Kwg0L+unuDeLl1saJSd8pR94U+
	Kh91I9EX3CP4q7zGN/RLUksFBPZ68lYS3QL1eeGS4JP9emRGWQx1q5vltoLVfze/G1uaDWO15iw
	c+LWsY/4OyiVbpwsZ5v71jXNCPJqGghLyQd6ltu/DWFAlLBfudi1vPkc37TMPsTuIv1iVSU7hca
	0EKVfEyQ9QOREijJDpzZKR5p1ROy+Q26jwqED/3LNaRUh7PDstLT1clHR3Oes7XKiRAt6qIu9Dk
	+22DDnMr0T1QrtNgMr5ZtDBg+gdh8K2uitLG2PRN4vYuTJXIfuL9aOZYyZRWYBEzs7nvsN0+6ck
	AcFgr6JxBgZSZhnyCsE2qfgSFud3vephUUHB9ttPUK1hjF0I7skNi0BW+NWASjdh/pS5R032kxD
	GWG22T1GSFYZzf2GpelccV0ahihGkkEZ4yCKKmXmyPBB092DbJTyroGSGqqgFxgkm6X0gMCeHjs
	YuzW95nTxZzbnSleQRV+l/swHz+hgpYDZM4xpKOWQI24aTxWNmVrmras+rD/A/NpMM7SxVqrdc1
	nUPh0MaUqzhSPvpb3nkXHaS9CioTo3RXXveFxeuZSw==
X-Received: by 2002:a05:6214:2467:b0:917:8b9f:d62 with SMTP id 6a1803df08f44-91c48e40138mr33470466d6.18.1792852129746;
        Sat, 24 Oct 2026 07:28:49 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a7cd7esm22349976d6.2.2026.10.24.07.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:28:48 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowangio@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/6] net/sched: act_vlan: pull the inner Ethernet header after POP_ETH
Date: Sat, 24 Oct 2026 10:28:36 -0400
Message-Id: <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com>
References: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com>
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

The issue:
act_vlan POP_ETH removes the outer Ethernet header and leaves the inner
Ethernet header at the head of the packet.  A non-linear skb can have the
inner header in a page fragment, so a following eth_type_trans() may find
less than ETH_HLEN bytes in the linear area and BUG in __skb_pull().

The Fix:
Pull the inner Ethernet header into the linear area after skb_eth_pop():
drop the packet only when pskb_may_pull(skb, ETH_HLEN) fails.  This keeps
valid non-linear packets whose inner header sits in frags.

Conditions to recreate the bug:
- egress tc filter on lo: action vlan pop_eth.
- AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=28, and a non-linear
  eth / inner-eth frame.
- The inner header is in page frags; a following eth_type_trans() can BUG
  in __skb_pull().

Fixes: 19fbcb36a39e ("net/sched: act_vlan: Add {POP,PUSH}_ETH actions")
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.38722ee638a21@gmail.com/
Link: https://lore.kernel.org/netdev/CAL4WiipJLzZ9ywOPaFHZ+wePTOuO+6+aaRCVXMHz+xmmQm2hcA@mail.gmail.com/
Cc: stable@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v2 -> v3:
  - no code change; add Eric Dumazet's Reviewed-by.  act_mpls makes its
    pull unconditional and act_mirred drops the skb_network_offset()
    condition; see those patches.

v1 -> v2:
  - pull the inner Ethernet header with pskb_may_pull() and drop only
    when the packet is too short;
  - keep the OVS TEB and NSH members and restore their Reviewed-by
    trailers;
  - replace the TUN patch with the act_mirred consumer guard and add
    the act_ife egress fix.
---
 net/sched/act_vlan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 6a375fdc63dd..bca95e0bbf64 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 		err = skb_eth_pop(skb);
 		if (err)
 			goto drop;
+		if (!pskb_may_pull(skb, ETH_HLEN))
+			goto drop;
 		break;
 	case TCA_VLAN_ACT_PUSH_ETH:
 		err = skb_eth_push(skb, p->tcfv_push_dst, p->tcfv_push_src);
-- 
2.43.0

