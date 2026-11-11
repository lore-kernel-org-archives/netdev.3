Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406612;
	b=e8bEJHNpUXfiArykjjmFIK7+00zWZR+HrCEKoKucWwSJn8msm/ZQrGkMjOZuJyQxhgIz
	 J03twxOLXB4IIzA9P+dBlK4OSkCVgw5To/QbjjrsNjy4FMM/ybJI20kY0RnKpIcK9sfu3
	 p/aYTdOCjTgaJi54Gy+n9YiZJ5bpnlA3ElfaZpqmeMS9QNwFLCFU+F9AQw4S+TP8fLTNv
	 b0P1hu938xFlKJ91smGoYL53VKwwcFhTx+KZjiYZFGkGV26B/laoH10BPgPaV5BRXBc+R
	 FCTYTTMNJk611axITNZ7VPNF7q8PtMNUMkasubChBFpxKdvts1VlsWJv3YCyzThN17Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rxh6ySQw4OyzmF+zvez+p31cAvwAIQMJM/KeP5k2znw=;
	b=nlQZT5o0SsFfiuITryxcANjbLGxQ67qKc+6Ji44UV4jji8to2F5L6wqQ3lGk0OyqfhXh
	 VI3eG2PkeM/vjpO7VWYDzFml/GOdCkK8mLQX4mWJYUoefnENA5BluIuuUxDuvFaLTihdH
	 eiCXXweQhwIw4YfUeQUMIWdtuh/A1f7UuwzII6hO3hA6uxEi6mnIAC07w4YogTluoGmso
	 s3IBCJcy/y6gyykn9+BHav2kKWrVoDc+0grhchhSBZybkWwRZXxHxlZMJs5Qg75cARcXN
	 DPXY9WYChS4Ho7DvWVZg4Zj/uqP9MEfSrABO7QmrMdkvLRp0Yj5C+fJ3b6ao24AbkjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=PkOuAvhP;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00765606A336
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00765606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=PkOuAvhP
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53669f7b518so32542601cf.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 06:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794406611; x=1795011411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rxh6ySQw4OyzmF+zvez+p31cAvwAIQMJM/KeP5k2znw=;
        b=PkOuAvhPVdtzJ3wJgKaLOTUIfWGW2ZvolzadQnNSWT0uvvZq9KvTMm6jBKhUkb6MaE
         BCHFnx5z6Bo5mDTJGyI6oPI6IeT7T0KK0DY1aErqz+2uFReDs38ZFl6kgYnPkeVGiKUB
         whj4ZiaJEzjJNVw8xmStgAv0PsTye5lxa6S2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794406611; x=1795011411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rxh6ySQw4OyzmF+zvez+p31cAvwAIQMJM/KeP5k2znw=;
        b=oExMsbUEc3An09obubwAnO+blrZPG+r4DlmWTXGi51F2JF3jbKoOJxVEEQrOaUl5EK
         n+wQbSZzHa30OQyGa7WWwp/qewRlleGE3DBs3aOjOGfJ4Ok14nELGFCW64/2b2SQeCtV
         uelUlELHVp8+Q/SfPCF2TMRhb9XWorPopQHdd1ArGoxM3kdZSHdEYk5YXxu0y5wXMVFr
         1y4A5rX6y4STEN3QT5kJa2EVXk9mlnVXbMenz+2fqzAwtyswQcKM4bl5x3xlPED4798B
         CQ1eQ4iCRjaxmv8Q/YpDj8bGpRaobtsW8VcSV9/5x6v5EPaWCOT7m1dV9owFbi21dfdJ
         1+Zg==
X-Gm-Message-State: APuU4Z8iD1+5DPfkLDa/N9wJcgLOrji7u3UYWOei/zFfj43C1n5UUf2v
	v/FewNjHXDBB0MeU7XVWmIyevEblSEW0h2q9xDV7nidPbYxXtPojKPMuogPaZc59OGB8IU4cnm6
	EoIA=
X-Gm-Gg: AYBFou0a7KIUT6AYPPyLa6BHcEkvpcMKCwAeSlr9mMF7dGOeE36AK54+xb5geFbk6dF
	tZ57S3TucthoCQWTPcrLqQ+FdaZTtlWndKETDO1Zc13By7rYQdE1cs4FPsde4txpNQLFVsVbnv8
	LC0wyJjN9Pzqv94ATxKGZhiJc273LTvxlnn1J6QKZJDBMR0NikiYRM4x7fSG1BseCiLiDoqyPNK
	X4HJrXWKNQAGp9ziZdtfbm1Wb01qQUcF8rgo6ILmzOap4gJMS+szKY7sMyuTgijwpXdPUSw/gm0
	i7OtDwqx8UuNuDu8cF8AqYAzu0JCaxk9Gwow/Q0ZF74qJaZ/VuA5ePyi2lvkxiLUrrkJjvOZMNM
	ejlJxBeCIy77yEHLz61zqUK/ruvtFUYmGilhPBQioCUHQ7QCMrBR4LhcdcU8OtqDmQTrAuwxLb/
	Gao3oZWkPr/+XkndSkEhLL15mUS+hkl31EL0FeE+1utjsrc98/oly24L4rF333SMXQpIm8Hz242
	KvUqBYKnA74rc+vb7Vco8iGkwYUZIT4/ngPv4ekXqtUmBe9vQzFta7JEfcSk32dZ9aiNHs5r9mb
	tgSdmWsCXhu6KmyKxdwiBKXmqNKS7k+avfYXenkC1BHkQFo5AAcCGJ1OqV/p/DV9HT+vU69aucz
	MKRLFZV8aC7iDXA==
X-Received: by 2002:a05:622a:13d4:b0:532:cacd:e420 with SMTP id d75a77b69052e-556bdbeb543mr38533561cf.6.1794406610942;
        Wed, 11 Nov 2026 06:16:50 -0800 (PST)
Received: from localhost.localdomain ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550be2e592sm51505041cf.24.2026.11.11.06.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:16:49 -0800 (PST)
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
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	sashiko-bot@kernel.org
Subject: [PATCH net-next 2/2] bpf: drop the stale dst when redirecting to an explicit nexthop
Date: Wed, 11 Nov 2026 09:16:38 -0500
Message-Id: <CORE-9NOG.v1.r0.20261111073528-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CORE-9NOG.v1.r0.20261111073528@mojatatu.com>
References: <CORE-9NOG.v1.r0.20261111073528@mojatatu.com>
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

The issue: __bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6()
install a dst for the redirect target only when the program lets the
helper do the FIB lookup. With BPF_F_NEXTHOP the program supplies the
nexthop, the lookup is skipped, and whatever dst the packet arrived
with stays attached while bpf_out_neigh_v{4,6}() switch skb->dev to the
target device. If that device's neighbour is incomplete the packet is
parked on its arp_queue with the original route's dst; draining the
queue re-looks the neighbour up from that dst and builds the frame with
the original device's link-layer header, then transmits it on the target
device.

The Fix: drop the dst when the nexthop is supplied. That branch never
consults the route dst, so nothing is lost, and the queue drain keeps
the target device's parking neighbour.

Conditions to recreate the bug: two network namespaces, A (10.10.0.1/24)
and B (10.1.0.1/24) in one, their veth peers in the other with only A's
peer addressed (10.10.0.2/24) so B's nexthop cannot be resolved by ARP.
Resolve A's neighbour for 10.10.0.2 as permanent and attach a cls_bpf
egress program to A, with vb the index of B:

    struct bpf_redir_neigh nh = { .nh_family = AF_INET,
                                  .ipv4_nh = htonl(0x0a010002) };

    return bpf_redirect_neigh(vb, &nh, sizeof(nh), 0);

Send one packet to 10.10.0.2. It is parked on B's incomplete neighbour
for 10.1.0.2; once that neighbour becomes valid the frame leaves B
carrying A's source address and A's neighbour as the destination.

Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com
Link: https://lore.kernel.org/netdev/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index aca8160b26a1..2af24f371648 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2318,6 +2318,8 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 		skb_dst_set(skb, dst);
 	} else if (nh->nh_family != AF_INET6) {
 		goto out_drop;
+	} else {
+		skb_dst_drop(skb);
 	}
 
 	err = bpf_out_neigh_v6(net, skb, dev, nh);
@@ -2433,6 +2435,8 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 
 		skb_dst_drop(skb);
 		skb_dst_set(skb, &rt->dst);
+	} else {
+		skb_dst_drop(skb);
 	}
 
 	err = bpf_out_neigh_v4(net, skb, dev, nh);
-- 
2.43.0

