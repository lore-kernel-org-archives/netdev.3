Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516077;
	b=owt4VnFbMG8JR16BqURzX1DNTIu48O0Ex6/oENgugt5HQ+inw86jvsDWGmkAQsjNb4qk
	 iUkTCWHYmLXasDJqiNF2YI3R1msl+ltS0AIRqs2ckBK7SvfcnfDHUhdMAF9mOQV1Oi/bj
	 aoHOiphyzNMYMildA5pdB137OemagNbbqk+NntAi6bdTL55psWdEdoQlb0Tgx444A3cEi
	 8W1zFhLFm2RldBqdBQm1tnL8rEltz9tCOTm/dyyV7TlP4QUuie00/DgJqckqpP/3ThVcZ
	 DyqxcVaO8236q19bSyJ6Zo/3L/l8jwcaWBztJbXctvCgxEXJF83dPOQVorMMX39gSvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xXKJrbALur9qe5R1OS4jb0FmQE/KqmF7j3A3hmQEcbY=;
	b=qV+um34j6PhwwSC9SBwjSCX5vLekB7ZjcnVLFPw5jMf3zMpjZRiLFbbFFJ5654seL9Lr
	 v/MMJlexoQhjuM0ypSP+sFgJmOWtiLE34D9QYxUwsF5NeiDjbrSwWDEmzYyhbV6EDZuI7
	 Ar6FVNp0H82vetpuNlqXvoyYP3YDdzAv+CUBmJOB6WjiI3wyItxXGBljC+drSOMExnQ3a
	 Qbehao6VUkmCL5f4q3i+dhFBbhEF4UFR5Mx3biPXiYqKOqmYMiPOD1mg3jNcxhycotyYv
	 UM9q/+6VtqIIA1xSSLdOCTyePH/olw+lOM0/MU4ZtPGAtMdNGS8YRSi4TIg65dBG/tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QCCeiEPd;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D5606A327
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E23D5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QCCeiEPd
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91f0b9f0b1cso3043126d6.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794516076; x=1795120876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xXKJrbALur9qe5R1OS4jb0FmQE/KqmF7j3A3hmQEcbY=;
        b=QCCeiEPdNJrcVUtK/DxCUhgGfoj2frCxgAy/wmSkApRQgfDIonwFzsTYT8ILwV3F+u
         QX5pxCNrhbnRKOJ2vWHH5n3PG9K4SInOJUDsYIGjUdxBCE0gfPT0KTrIHI0+rZ/o0pft
         smGUFJUfk518nVFOW3jNoV2uRsn4TU11b1Siw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794516076; x=1795120876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xXKJrbALur9qe5R1OS4jb0FmQE/KqmF7j3A3hmQEcbY=;
        b=YmG543Oo/UJrPPaR33rk+tODauRXjN+b7AV/r3WqZuUZI2h7+kd3BYKEZhgyEZr4xB
         6b0wz+YBrswf/Ve2ApLY4u0X59uNsg6AcFmn1RnGd9RE4tKklAI8Dee6x0kgFAiSeZcO
         Uc7cdBXRWy8LwslpL248Uqo9fXysh8hGqfpwnq1fhPDvcoya8ZJmK6c2+GnqTq43hWSu
         2tDVLw7ITgwIBJ9HM72g+iuWAJCR14NO/WoeOQ8+pmCJF1zScB0Uan9GOAShwNbLqKr4
         s5JBUXTOWux/I9uBxKeKtXPTnS0NQVkmABtg7tJiPn+kuBKBz7wTSZ+DeuKyAnrTSNh3
         ssFg==
X-Gm-Message-State: APuU4Z/iyfeKhX6hPAN4gsl/fY24KY4urcwwbHcSeDr+A+LXAgilpDq/
	bmofu+UeLUqeYI7SyAVn0zt35ynK7LXOXTMfIwX7YIMq+za9jNlmtwco1vXO40pul9MQiMv88kU
	y3Ps=
X-Gm-Gg: AYBFou18MvhCfydh+IF0IEewJQoLVqxQNO3/Mckp5XicFgtDbZy2D+J0X28GKSH5FKS
	A57TeJnFE/4bqPLujSoc6vyio9egVRbOAry5wT6S3ld05jXAczHMIG47xGzZFliSOlyGd6Ad7FO
	IwHde2WpWq0dkpoboq2H7gYYV9OAWs6IxjSzXlrE+wEImMaBoWJMMX6uO69RomTwZlplPNmAbqt
	JTLNYuVnmS3IdywDnucZUp4CZ9xxoOXt/LRPwUxHvnB1H/9ngLXLBTtoMyKmmRB+hMCHD2ISUb+
	8pzolDCKh0cJlGQmPXUsVUaIqYmSRe82vC6YJd6PNf6tyJPlmCgHheFOTjlU9oE+W/1n3jrrRo6
	YZkwSol9Y7Rkx2pNJuHzP8PE/IO9Ro0UEeq5s3gqJ9ijDEnE775e1hEmRt1MlXmxBRnT+3B1PEh
	0TNOhAtH5LFWjEVj+AWHA9F4Ix7rXKICXHAOiXrMwQqYwN5XLJDmZDlR+VXb6MOc3CugxXSkjFT
	wqjp+rwQMUfNGg05L5ci55lWW3R6KEQtJw2hncGJGYGF6Kt9UJ/j8HOJ2TrHtzk16kqDPaMMvpx
	rJuu0zjjUIGuwcaYAY7UecICeT35M4TpF/cWbwFpwGyvzleCoI1V81yh0SKRpS3PsTzU0PqgKs+
	/qBIWTaFsyqPlN1ic6eBw
X-Received: by 2002:ad4:5764:0:b0:91e:93df:7968 with SMTP id 6a1803df08f44-91f2427df7dmr8048966d6.58.1794516065405;
        Thu, 12 Nov 2026 12:41:05 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d61888sm4452116d6.20.2026.11.12.12.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:41:04 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v2 4/4] bpf: drop the stale dst when redirecting to an explicit nexthop
Date: Thu, 12 Nov 2026 15:40:49 -0500
Message-Id: <CORE-9NOG.v2.r0.20261112151659-4@mojatatu.com>
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
__bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6() install a dst for
the redirect target only when the program lets the helper do the FIB
lookup. With BPF_F_NEXTHOP the program supplies the nexthop, the lookup is
skipped, and whatever dst the packet arrived with stays attached while
bpf_out_neigh_v{4,6}() switch skb->dev to the target device. If that
device's neighbour is incomplete the packet is parked on its arp_queue with
the original route's dst; draining the queue re-looks the neighbour up from
that dst and builds the frame with the original device's link-layer header,
then transmits it on the target device.

The Fix:
Release the dst when the nexthop is supplied. That branch never consults
the route dst, so nothing that describes the route is lost, and the queue
drain keeps the target device's parking neighbour.

The release goes through skb_dst_drop_keep_metadata(), so encapsulation
parameters a route carries are handed over to a metadata dst instead of
being lost, and a metadata dst already on the packet is left in place. Both
wrappers take their existing drop path when that copy cannot be allocated,
so a packet is never sent with the stale route.

Conditions to recreate the bug:
Two network namespaces, A (10.10.0.1/24) and B (10.1.0.1/24) in one, their
veth peers in the other with only A's peer addressed (10.10.0.2/24) so B's
nexthop cannot be resolved by ARP. Resolve A's neighbour for 10.10.0.2 as
permanent and attach a cls_bpf egress program to A, with vb the index of B:

    struct bpf_redir_neigh nh = { .nh_family = AF_INET,
                                  .ipv4_nh = htonl(0x0a010002) };

    return bpf_redirect_neigh(vb, &nh, sizeof(nh), 0);

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
- Do not drop a dst that is not a route, and keep the encapsulation
  parameters a route carries: the release goes through a helper that moves
  them onto a metadata dst first (new 2/4), and a copy that cannot be
  allocated drops the packet instead of sending it with the stale route.

 net/core/filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2d574ae52c4b..4980fb8db299 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2318,6 +2318,8 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 		skb_dst_set(skb, dst);
 	} else if (nh->nh_family != AF_INET6) {
 		goto out_drop;
+	} else if (!skb_dst_drop_keep_metadata(skb)) {
+		goto out_drop;
 	}
 
 	err = bpf_out_neigh_v6(net, skb, dev, nh);
@@ -2433,6 +2435,8 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 
 		skb_dst_drop(skb);
 		skb_dst_set(skb, &rt->dst);
+	} else if (!skb_dst_drop_keep_metadata(skb)) {
+		goto out_drop;
 	}
 
 	err = bpf_out_neigh_v4(net, skb, dev, nh);
-- 
2.43.0

