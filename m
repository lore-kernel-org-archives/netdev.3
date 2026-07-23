Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C8C399892
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829311; cv=none; b=BXFYXSW/VmcRQmoIuU2FLawLtb19t1y582H9v8XePHVqzkSsETi1le+vuC3y8xZildgIU3F6y2YMWqCsHl7OUp3TjYiG9fP/0HioPaK8c+smTN8DKDzBmDPEa1VtG3J1BlvWjgo1D2mtqDJbjpN3CbgOs3ltDYBNL7vnM9ZHkg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829311; c=relaxed/simple;
	bh=9BXmd5UbPJGt/0KOaPK6fNIhWXXaeM81IS4SqmRfuow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKO0ObX5aXHbiKrerAK/F3uZVl14WfLGlMXoVlR/nvBJtkXdE9HYWac8FKG6/WVdvuLrV87vf3phzpa0njz15kBVdMv1AFGG8mpVgRoDACa39F3ud4EWngGQIERDEQTI56Ot6kweYD0wQF94eNuoKKLOi/kyloaHO48mgjeJPsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBwkql0+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBwkql0+"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso1027774a91.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784829308; x=1785434108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GIMpsUmHWaYqaztT29E06m7v8GokydsJhFwiKqXDKLQ=;
        b=QBwkql0+ORfVqRMVGvJRdxYHzLWou6biAeaAd1MEM1ZpTKvNIGN9Vd8wioa47/cU94
         ai2z5YopIFrDqx2uGdB7tWm2iYPfBdfKxL+AFQ2w313Rm5TT4vPc997O5jamKAAp0QKm
         Bb6jWjL32roh1VPEs4OpAmconcLe20FY+8eVgMaInNtuaIDAxfQucZ+CWkfhHRtAzo6R
         0xSHc3TxAvuyIT+XMDBorCoHb3frChJs1+bVdNYsxdtx3ooSR5+bVUaA8X8J3wIQMD8i
         30gF0WgSrUkm7vNkvaLV+2FgoJUrgWFgssXqNNv8/V0v72/YUwIQc7AmuFlcrj9aB238
         ESlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784829308; x=1785434108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GIMpsUmHWaYqaztT29E06m7v8GokydsJhFwiKqXDKLQ=;
        b=UuSGt3hAs5qWsHo2FTCtieW46bzb/AFAlj+3FL46EozFvTi24knvRLdNgGg9CPa3IF
         qpVVoZCN8VL3eDS+gzDIeoVq90Mkpf9MWeB3YDqRVSrWB3rtj89bNMD/cuU71V8dmcMc
         HgjSRgnaA+892pwfxC7AtBDBgwljq2UelKXaJ/Iwg9O+okMU+tlaXwv8xUbTr3aknOOe
         /wamMS2h+GkZEbd3En0cx8t1vGzQhMluGPLjkBdnyYotrSagGxJW/mxXPNZQKy20X4Bh
         N+8/QTUFvfY2s/xJKq/VT3y2391oI4ftAcV4VA22OT53PJ14HxXovjM+Im2Gi7Cn84Zo
         O4Uw==
X-Gm-Message-State: AOJu0Yxjk93Tt9MdVE8jlHh60/qNUliWRo8H0sXOfPOT6HXcuDGLQExI
	aL9+IhQpTAQRJX8uXZa/oGgjHs1xNkJR8A2xXRJcX0aYKMvNfJc2B1spG7BIfEdDUgE=
X-Gm-Gg: AR+sD13+ECV+6b30YYcj60PHwScgw9Bidoeu5K2eSCc96nEQ8HsSb4y88zPSuu7HRun
	IAT1914ZEJ3X4V9084H1SjUIAEXeGLjty5I2q0qfswBBFkjJTcUTObtCuCO3+nEpA3a7WfhZxCG
	sU4/ppiCjrtxhm0Z+jrQ/j2Y/qIYqe+F5s4BZMfqTsiT9KFYUpxYdT49QG8IwG2/Fl0Bh4NwVga
	rEKtN1K6lO8+gX7FNTzxhWrUYz1uoVYktAzU5xuiQs4vl+7Gm/VSjPlEyjRdxojStWiJK/ViTmn
	KUJdDZQdw4Wy0elVUQ4d/A4hrwx4MuLEoHGvIkiBL50vIdVc61dVkBfzcWaanh5ZPeznIFs5SwY
	egqgWnL//J1K6+aWAPiPApvdxUUW7kBuA5hjoduMfiJGAdvlvR3IA1aHfRvnWQxilKwi84pO8wg
	JNwIgb0DhNACbNnDd9JQk=
X-Received: by 2002:a17:90b:568b:b0:380:f34a:6ff1 with SMTP id 98e67ed59e1d1-38ec6440dc6mr4441973a91.17.1784829307666;
        Thu, 23 Jul 2026 10:55:07 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130262d2sm15943883c88.7.2026.07.23.10.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:55:07 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	peilin.ye@bytedance.com,
	cong.wang@bytedance.com,
	gnault@redhat.com,
	vega@nebusec.ai,
	bronzed_45_vested@icloud.com,
	enjou1224z@gmail.com
Subject: [PATCH net v2 1/2] net/sched: act_skbmod: require a full Ethernet header for MAC rewrites
Date: Fri, 24 Jul 2026 01:54:47 +0800
Message-ID: <4c367ee0418b50fe3c3e4936d95e3b8a0c46daf5.1784709375.git.bronzed_45_vested@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784709375.git.bronzed_45_vested@icloud.com>
References: <cover.1784709375.git.bronzed_45_vested@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wyatt Feng <bronzed_45_vested@icloud.com>

tcf_skbmod_act() rewrites DMAC, SMAC, ETYPE and SWAPMAC through
eth_hdr(skb), but it derives the writable length from
skb_mac_header_len(skb). After a prior action strips or shortens the
L2 header, skbmod can still attempt the Ethernet rewrite without a
full Ethernet header being present.

Reject non-ECN skbmod rewrites unless the skb is on an Ethernet
device, the MAC header is set, and the MAC header length is at least
ETH_HLEN. Also use ETH_HLEN as the writable length for these rewrites,
which matches the bytes actually modified.

This fixes a buffer-size length miscalculation that can corrupt
short or non-linear packets.

Fixes: 56af5e749f20 ("net/sched: act_skbmod: Add SKBMOD_F_ECN option support")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/sched/act_skbmod.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index a464b0a3c1b8..30c2eac17aff 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -38,7 +38,6 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *skb,
 	if (unlikely(p->action == TC_ACT_SHOT))
 		goto drop;
 
-	max_edit_len = skb_mac_header_len(skb);
 	flags = p->flags;
 
 	/* tcf_skbmod_init() guarantees "flags" to be one of the following:
@@ -49,6 +48,8 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *skb,
 	 * packets.
 	 */
 	if (flags == SKBMOD_F_ECN) {
+		max_edit_len = skb_mac_header_len(skb);
+
 		switch (skb_protocol(skb, true)) {
 		case cpu_to_be16(ETH_P_IP):
 		case cpu_to_be16(ETH_P_IPV6):
@@ -57,8 +58,12 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *skb,
 		default:
 			goto out;
 		}
-	} else if (!skb->dev || skb->dev->type != ARPHRD_ETHER) {
+	} else if (!skb->dev || skb->dev->type != ARPHRD_ETHER ||
+		   !skb_mac_header_was_set(skb) ||
+		   skb_mac_header_len(skb) < ETH_HLEN) {
 		goto out;
+	} else {
+		max_edit_len = ETH_HLEN;
 	}
 
 	err = skb_ensure_writable(skb, max_edit_len);
-- 
2.47.3

