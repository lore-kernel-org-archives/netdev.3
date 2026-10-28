Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179163;
	b=CbBqTqie3wTbBAHVTCTvq77+TnPohT4hlAeAf8lkEPuwHHnK6ZFHRQBunBK3N9PqcU9D
	 ULw3JHfgK1Gkysi467yMRBbCceYpAoOM2N1Qqiy+d7dAX62Sl/efSqlIfq0vjeWIqkGWH
	 HNZAYPnWo9oMW160MzHro06QYZu6NjaK4BL6EB0SeShPJ/GxgmjQbN86BqVBGCyi1CSmB
	 KZqhdPSqmNS0yi3mEV1TJRNTehGkhbeN/87o4va/WDbyKm56g2BwJpiqqw54uYJwZF4lZ
	 qTrbc65skzjKC9IQ9MZDFb94SXrioHw6hPAjqkJfj86HBdz/tSgggcN5r1Dn+j314BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=4XCHXI/FWHj7MU3SgLB6xjThlzF9v+ynDOkqKImHCD0=;
	b=ls8Kq1f/ndSgyOqEVseUrJYw4g9xunGoYWRoc/yhFTqcFIq5pvKFommIFfHo5fhRQzQ2
	 NUnx97Uu5nkdBX1p9sruUUDYwBWpkPlQXzL+YBewzBh0eF+dWP87YWUjE3EXFjcMlL8Cx
	 dPm622axoCbhLbObQpFr9Tj8tgjSXbiW0CKZQOcMX2HuKB2uByZTLXrs79HsaSyB8cCqh
	 Qc0FLUA+x4bY3vVywvoIC98ZVJ31Rn/+9kDHu9CTtLOmkuO39Fp/34wNZ2o2tLd1QvFyC
	 U2e9RWl/yAVMdILQJcBk8Ha/MKqtLeyC66NfI9qDNzUdGGbZJmoqGEeRws2mz8D7YtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=jEPXtPoY;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C58606A31F
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0C58606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=jEPXtPoY
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91c79f306e9so8970556d6.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 02:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793179162; x=1793783962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4XCHXI/FWHj7MU3SgLB6xjThlzF9v+ynDOkqKImHCD0=;
        b=jEPXtPoYHiaqzc8VKI6X2ReBPMPGM90QICrWEY1QCN7K/LrTc9Dj5NP7xx/fnkQ4TF
         96fP5MvhTbrzw+m7TP5vxPRvAiZokKRAfkJ03tmxYWhpkRhvkKvxKkLR63mZwY9jcYBr
         VKs2jQVv92sAEzf9fgoq0uEdelHI4THJJeNPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793179162; x=1793783962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4XCHXI/FWHj7MU3SgLB6xjThlzF9v+ynDOkqKImHCD0=;
        b=iaju+PqjuIWJaq215f79fueooYT8YUhxSKo/VFTYTQGHAOZNMYmDs+C/FVg5N63HQM
         cxae6YfI5nhrx1xi2tqYZJAomlHx3+OS+1lC/P9zFhcKUODOCWF/jj76F38pVU4NZ5w4
         +osS037k6mWclbejoqxCD7PZZ4zedNlkPC+FBCHOEqEZZBO8/h6ac8gWW8lfKyh4rGYK
         Nc0Q4Y3SzoYmNBAnZRuLzlyh0pKmmkyB0vpIbc3UZ96tH0lmY6tvAzcjzk3+kad+W2E1
         0Bra+Eyu43cpYgubRYYAdq0fkEbA2HOl5iI3AtTuOPQOtoaeBAur60qVPOIj+mb9AU9y
         xb5g==
X-Gm-Message-State: AFq9FYJ2rZuLNpwsBAgj4nkp37bv4hpx4fgpDNOjUqWhz56DVfKwyUhc
	G6rLsh7k4XRlsUZrEmYn5lpM3NRSvQDt6zh4HCIi08QPHPgnxEcS64TwCsneYSke5UpnijKAH0B
	O9Hw=
X-Gm-Gg: AYBFou3YmLIN2qgjo08TFjODspS/7zpziZqtqMX6r1IqU3llhbu+AP570AXOAWPMUCz
	OvgVLxoOS/in1wgoJ00hKgDDD9Q7Qql2Ysr8gmKHxlPyFbxROGAByYmxu50dozoQUBc202IG2aw
	Mykg8doTimKbf8SGhViGFCcGT0o0CxD2idEq5lqs2lt0AKgr0GvI1pvT0vMQzpCYzzLubXOigDt
	UG0gjYqFGKkjqYJjOiRNaenabvVmCr18+JE5pQ7MbjBPdeL8aIlr+aAVaPnOsOhMuPOt9lDoaiS
	iqR58ti4fsfO3vUBJaPfABIx0PgTUqis/YUgC045qASHi8p3/TJwzPl5ogINZL182xHheZRMbQj
	51pGmY45x+Ch2dzYw4hxGJ9r3IruZSBqPs1fSdY23yfcOb4DyUm0bzjgw5mXx1gFb9KkKj+ZT5v
	0aEQkAqKNaALPXVThGIlc68PY4N8SPlg0WutNUSqX8vyfO5BvnjaY78tlkiu2oidZS+MusL3oTL
	jLdMYZZehqW+f6W1NLbxxd8pFFW29ho98R7Yqd192cDBpNl5jBB91ZHPS+J4L1KbT5ZscE2rAtx
	BcdvYZYq7rhg42DnILrinQIwcDLTBTJ2uTMSue6mpmE9QesAhP6WCYlcxoKsHzAuobDvJk/h/49
	w6KTyRDDdPrQcAMc=
X-Received: by 2002:a05:6214:5c0a:b0:919:557c:f0a1 with SMTP id 6a1803df08f44-91c7d1a0992mr27886216d6.24.1793179161578;
        Wed, 28 Oct 2026 02:19:21 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c50e10sm126822716d6.25.2026.10.28.02.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:19:20 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Eric Dumazet <edumazet@kernel.org>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <kafai@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
Date: Wed, 28 Oct 2026 05:19:16 -0400
Message-Id: <bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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
This is a follow-up to the short link-layer header fixes[Link].  After
vlan pop_eth, a privileged SCHED_ACT BPF program can call
bpf_skb_change_head(skb, 1, 0) and then bpf_redirect_neigh().

__bpf_redirect_neigh() calls skb_pull(skb, sizeof(*ethh)) after checking
only that mac_header < network_header.  It does not check that the MAC
header is long enough or that it is linear.

A SCHED_ACT BPF program can do:

    bpf_skb_change_head(skb, 1, 0);
    bpf_redirect_neigh(lo, NULL, 0, 0);

after vlan pop_eth.  The skb then has mac_len == 1 and only one byte of
linear data; skb_pull(ETH_HLEN) trips the skb->len < skb->data_len BUG in
__skb_pull():

    kernel BUG at include/linux/skbuff.h:2839
    RIP: skb_pull+0xc5/0x100
    Call Trace: skb_do_redirect -> ...

The Fix:
Drop skbs whose MAC header is shorter than ETH_HLEN, and use
pskb_may_pull() to ensure the Ethernet header is linear before reading or
pulling it.  Re-read ethh after pskb_may_pull(), which may reallocate
skb->head.

Fixes: b4ab31414970 ("bpf: Add redirect_neigh helper as redirect drop-in")
Link: https://lore.kernel.org/netdev/20261027082604.1485903-1-edumazet@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/filter.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2..4d344ec09736 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2432,10 +2432,14 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
 				struct bpf_nh_params *nh)
 {
-	struct ethhdr *ethh = eth_hdr(skb);
+	struct ethhdr *ethh;
 
 	if (unlikely(skb->mac_header >= skb->network_header))
 		goto out;
+	if (unlikely(skb->mac_len < ETH_HLEN ||
+		     !pskb_may_pull(skb, ETH_HLEN)))
+		goto out;
+	ethh = eth_hdr(skb);
 	bpf_push_mac_rcsum(skb);
 	if (is_multicast_ether_addr(ethh->h_dest))
 		goto out;
-- 
2.43.0

