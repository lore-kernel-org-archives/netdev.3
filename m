Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E187138C2DE
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822651; cv=none; b=QRDBx8cwdx++iBGZ/6IM52v16Pk5FWZnzU/YH6qz6QRmy5qSmoUPDAAzWEJGe1FQ8u5PG4l4v2m8la0cb/HfXPtSfrGdSRbrSCUxwZIE0wFvs9GP1D3P5HR4je6HYxJML4rK1oaEvpszQPuOK7BYIxkw+VUU6BkAlpAuwlxyFDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822651; c=relaxed/simple;
	bh=bRDmGBN0A0L4rnXo7MbVsBXhWZwX1P+XJBRFib6eF4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fz+S54OEJKOF2XK3xRUth6UZm7JaWpcPQ9vgZK4+U7ls6oRz2MZmFPfrGL0SJy/o83VqaghrExYXzIDReHzZxwlnkAj68mP+RW8hxhY5mxoWf46BIhR3mYfYRZi4E9gDTyDkTK3lRHtp0zeWmt0SaAAncu1WZVtf12dQRx12FLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hxz0Sp8U; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hxz0Sp8U"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ceaf8a1265so7989325ad.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 02:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787822649; x=1788427449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VSR/bClKeTuG1diFol97BSsJcvWxyuc7r+zjFXxTJx0=;
        b=Hxz0Sp8U6pnr9ioWN8wfg25r14AOByCGOth0/dTKH7bsUKZLLk2oQF4AEQN2hLJ8Gy
         NmGw/LLxL/4pmbNlMYvHK5RD+1+/LrKjHbN0p9jFV7qpOVSwoSp7VGrtxipzUOha52IF
         eAW+qU4dbUZcEhJBUfZj161/3CTVaCCnMNsh8TS80zagP7h8NzXivpUsuIyBJuAB64ci
         ntZptU7Bx//esqgCU3PwoPbuD51h5cDppDVsWUa1eFyXrH/fkzsZ/Ugkpp7EIBycWHq4
         3rokQlx8NcpFgFVPCkMX7vYO21USxQ2KG2G68xpICfZvqg6rxlx4htYR7g6XXGOA/5Kp
         Nqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787822649; x=1788427449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VSR/bClKeTuG1diFol97BSsJcvWxyuc7r+zjFXxTJx0=;
        b=DeAD1GptDiEayX2haMbfNS3dHS1UwgMdLguKhjFw0iPHsiZucHuF6nuX2kTlwB18rb
         bGZR13BnOw5peGfyPevPBk5sdEe9aD+qCJgt5h8kRxWEKlxvwpVaJg7AGRPGIeDegY2a
         5h8YCZwUTg8SXgTBOqYSG4ZY/yhLbb7SLINsNMGiUizs6zxq8oDykHC6rftHB8I+cfr+
         CuhTMuDzxBdHFc8DCbqkLOTD+BEBByvPq9GkMdbg1TZDSwzSWdmSLJXLzp+8hP5aDuQq
         TDhe4Q6Gag2HmtjBdxlnUWjLeB3hvYhArGaoRtwJ1ODIjBaJu2ZurDorzdEG4sAX2neM
         lpVQ==
X-Gm-Message-State: AFuF++kenn/zyB4UtqjPzBqjxiEC8Ax247PVBW6Cm0jUqs089mgerzju
	RJ+TIUoo/qYcy+us3dEdWlRCoy3/HSq6kNz8kr1oE7j3hqDsh6AFWIRm
X-Gm-Gg: AR+sD12dqQ9vXIEf7eL7/eUEaTQWWrp4kRt6Qb7HRWLwXw5sev96YBOVMp9eS3XO/zn
	ua5+FotXG7Zg4JIFAB97udKOCcTVvRZ3MQzCOn5LEasj5hziDd6DlGhxHxcXPX9JE2wwxkxB7Ps
	8i5BsbF5lLFFCl7QPK8GufegKqlJbqeKg7ZuiwkbqiumSCBNhY4VE0+cBwwPX0IRU+UFBO0gWU8
	CtYVBQ5fhJboCGw2OCup95+nMn/KCho/Hnozu2BTsCMGbLyMT1WSCv3ThzsEGU6/ugtMScAdvKv
	dX1IjaSQboqx+34N6oeWdSbLOyB/JLDDpdQJTO/K0/Jij2kZeAmqBX8C/a4H78aQh/qoArbGUgR
	zExl6RRay2Z5NVeneJXjqMVor27L6SjBSSiDXp70B3yXb3N0qFyQJSntAkW0/rCPUUFn52ikeZL
	F316/LhlLjD2K6BEo45/fZEBSvfx4MmJwJt4oEjKRXM26IeSjS9d0jyZBHmam20NyaBA==
X-Received: by 2002:a17:903:40c6:b0:2c9:b396:1a55 with SMTP id d9443c01a7336-2d707b9ad9amr237051265ad.12.1787822649044;
        Thu, 27 Aug 2026 02:24:09 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704c25c2asm15250725ad.70.2026.08.27.02.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 02:24:08 -0700 (PDT)
From: Fourie Zhang <littleddfu@gmail.com>
X-Google-Original-From: Fourie Zhang <fouriezhang@tencent.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>,
	wenxu <wenxu@ucloud.cn>
Cc: netdev@vger.kernel.org,
	Fourie Zhang <fouriezhang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net] net/sched: sch_frag: reject a negative L2 length in sch_fragment()
Date: Thu, 27 Aug 2026 17:23:27 +0800
Message-ID: <20260827092345.2301937-1-fouriezhang@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sch_fragment() bounds the L2 header length only from above:

	if (skb_network_offset(skb) > VLAN_ETH_HLEN)

skb_network_offset() returns int and the comparison is signed, so a
negative offset passes. sch_frag_prepare_frag() then stores it in an
unsigned int and uses it as a memcpy() length into the 18-byte per-CPU
l2_data buffer:

	unsigned int hlen = skb_network_offset(skb);
	memcpy(&data->l2_data, skb->data, hlen);

The offset is negative whenever the network header sits behind
skb->data. ipv6_srh_rcv() runs in that state, because
ip6_protocol_deliver_rcu() pulls each extension header as it walks the
chain and the segments_left > 0 branch pushes back only
sizeof(struct ipv6hdr). act_ct enables the static key that gates
sch_frag_xmit_hook() and sets tc_skb_cb(skb)->mru, which survives
receive and forward, so an act_mirred redirect from a root qdisc can
reach sch_fragment() with the offset still negative.

A negative L2 header length is invalid, so reject it through the existing
"L2 header too long to fragment" path. A non-negative offset behaves
exactly as before.

Reproduced on v7.2 by an unprivileged user with only
unshare(CLONE_NEWUSER|CLONE_NEWNET). RDX is the truncated length,
(unsigned int)(-42):

  RIP: 0010:memcpy+0x8/0x20
  RDX: 00000000ffffffd6
   sch_frag_prepare_frag+0x364/0x440   net/sched/sch_frag.c:74
   sch_fragment+0x1c7/0x7a0            net/sched/sch_frag.c:122
   tcf_mirred_to_dev+0x7a9/0xf10
   ip6_forward+0x114b/0x31b0
   ipv6_rthdr_rcv+0x40d7/0x5e10

With the patch applied the drop path fires and the packet is discarded.

Fixes: c129412f74e9 ("net/sched: sch_frag: add generic packet fragment support.")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
---
 net/sched/sch_frag.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_frag.c b/net/sched/sch_frag.c
index 75ee52750919..b68a198b1646 100644
--- a/net/sched/sch_frag.c
+++ b/net/sched/sch_frag.c
@@ -89,9 +89,10 @@ static struct dst_ops sch_frag_dst_ops = {
 static int sch_fragment(struct net *net, struct sk_buff *skb,
 			u16 mru, int (*xmit)(struct sk_buff *skb))
 {
+	int hlen = skb_network_offset(skb);
 	int ret = -1;
 
-	if (skb_network_offset(skb) > VLAN_ETH_HLEN) {
+	if (hlen < 0 || hlen > VLAN_ETH_HLEN) {
 		net_warn_ratelimited("L2 header too long to fragment\n");
 		goto err;
 	}
-- 
2.43.7

