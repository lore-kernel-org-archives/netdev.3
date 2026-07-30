Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323FD3C871E
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400221; cv=none; b=OPHsEQaHxCdAuYU/Dkcg5K41GcYUFvuVlLQbFy/cejjb3khYIri95Omzxz0WNp1xQ6OIdorbeIaEx5lyRlMC0VVf8Z5qs8uvyaKQWJpjjjxq5K5uMilfsQ+sCoTNkMmOODukT3BF9ouDs1RL8OopeE+33yWw3t1pt52L/d/vJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400221; c=relaxed/simple;
	bh=SKCawZyJ18LIWo/TXdAjj24mqMeJQGIHXE6x68vNbwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbO7tI/VbAwbEIyXkobLe37HYtQjdfuG2no47FlopX1wuE+k1ncykmX5b9mvZpKypB/XpP1L4F37OAjA3H90KpmgOCx1Mpa1vmbVU7EhiVKgIxojPeoaQk5kGMi7tn96d3W57Y54IduJFQoyoBxPg5xe56FfE6r/8M1pyOroMMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5jraFo9; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5jraFo9"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81ef8adf7a7so1656767b3.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 01:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785400218; x=1786005018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LOsNwn1XETjvDtGfeNQeQJmlf7vcHA2X05x3Dyf3ZGg=;
        b=S5jraFo9In0fPWE9ay7C87WbXsVkrgKV8vakMvzVMaETLgDveph1a8ke9M3ArZd0o0
         UlSS8D22DXs6X51UvMBf+bSJtD7cpCYFaw3Gk8HRjzUDD2ZPrd5hCXGG8Rn6FbOA7rRX
         ZFqGL9Jt78L5hiS3ENoYqIhJGYRME9Sz5kJPQgsqObSulQFHnDaEEihvAekVpkig6vQl
         /xpc39p2uII1cIQmYih/pbFOIlT6Bdc7/a2pgUF8YzRoK3VM9phoOIXLakdIJ+NiFG8B
         8rlphXKgbwbGFJNw7osEGqRcDgB2cEyBj0wGDzR+8OIcDXWJxgkxsA/W16yw6nja+1ey
         1gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785400218; x=1786005018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LOsNwn1XETjvDtGfeNQeQJmlf7vcHA2X05x3Dyf3ZGg=;
        b=nRfZ6ejKEOijPhiIDY8ZAB1dpZU0rBPZmX1iezA0wHgQge4TMOpAfDfrbORVaReB9U
         D2k7IPFvDToqMBUhHQPzjNArX6xb4bg1SNVsGDhiZkaOLhSGcOI61TJExDDEAEnKKP+/
         3VVgLVawIUxrf8hWS/bjjwSx+a330+cRVjfgSK3plpbmE0A0nlxIPyfKdhsArEgtl4BC
         OAmY5fIBEuu+tDdZ7WSsYErwpdX5mCcD8V8dQ4gt6Tw6NJcaxB+oIoQryyo/UOb9HOKe
         7+rPH+Cq4IzaIBjj9qQLLFxsdCZlEdP3ndGXTsRcTqpW9HS8oqCIXrUrC2SCUASwN5PU
         MSGA==
X-Forwarded-Encrypted: i=1; AHgh+RrN9yoE30AhkWxOcIzBd11bkjsmRw4eA2c1c5yK+dH/KDRsd/PMAm6bx9/rFwXLEtVb5GwXwow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCTYSvwaLvsrkvtM9SDSx5DTodXmSbseyJXBY36Z2IhwICXqD9
	K5nThFPdJXwUtwC1OoBAKQxxUNe6/YgvobHQLtNebdAIggYM/CDusd6w
X-Gm-Gg: AR+sD123Jq3DG0qgouB84XWdyYXzgcSWIbJvSaASEJZC/9NJ0Y4sNsAtu5/QrUCRyZQ
	93l8ueAAs/B+aetTbZIOUGnpT32XSfVzzaOy4wMIDdNiYEHXXw9w9ClVIF32n4cG8xTma36KPcG
	Dd3FwPGpqIvLSQrsOZlpKGQWHcUorTiwBgQSMt2N5A9GDepTNZ/+ynQ0LqHwymMyKP02lIFIa8i
	83Rq0ljWc1l5/qDMqppvKocJDIJiOU2M9aP9IxMpNvzeKV8x+Tj1BJCp73UKBcuOw5TILj0V44H
	8YOO++I4eAwwqob6scLS8BYnECufDNU5i54nyI17WRDWlI4uX2ePTB3kLpFHbduw77p5cLCBXim
	PkaIe5nCIQzwoR8Z24nSWgET4Cg4T1GoroqhedQIf+RI8q5p6D0OTaVl4KuVMfu4XSRlA1O+7Ea
	oVGYjwVD6dkQN5uH5Dpb/ygOPBBjc5nLLH2ovhGUnt6cvrAqAKb4Z4uacqkqb3Iu9a/0YfNNHH0
	5iTJm4uadg5hezJ9D+YZh739aaN6xAx0luVg4Wo/HQeU37cOKy+Ljw=
X-Received: by 2002:a05:690c:c4f1:b0:81f:45f0:21d7 with SMTP id 00721157ae682-81fb8741de0mr19462267b3.0.1785400218085;
        Thu, 30 Jul 2026 01:30:18 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8a89719sm6356597b3.27.2026.07.30.01.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:30:17 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH bpf v2] bpf: Fix netns reference imbalance in conntrack kfuncs
Date: Thu, 30 Jul 2026 16:29:58 +0800
Message-ID: <20260730082958.2065194-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729163141.213611-1-nicoyip.dev@gmail.com>
References: <20260729163141.213611-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The opts argument of the BPF conntrack kfuncs can point to a shared
map value.  __bpf_nf_ct_lookup() and __bpf_nf_ct_alloc_entry() read
opts->netns_id separately when acquiring and releasing the network
namespace reference.

The reference imbalance can occur as follows:

  CPU 0                                  CPU 1
  read opts->netns_id (-1)
  skip get_net_ns_by_id()
                                         write opts->netns_id (id)
  read opts->netns_id (id)
  put_net(net) /* no matching get */

The reverse transition leaks the reference.  Repeating the unmatched put
can destroy a live namespace and crash later users.

The kernel reported:

  Oops: general protection fault, probably for non-canonical address
  KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
  RIP: 0010:bpf_prog_test_run_xdp+0x52c/0x1700
  Call Trace:
   __sys_bpf+0x1662/0x50c0
   __x64_sys_bpf+0x73/0xb0
   do_syscall_64+0xf9/0x540
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  Kernel panic - not syncing: Fatal exception

Snapshot every input field of opts with READ_ONCE() before validating or
using it.  The netns_id snapshot keeps the namespace get/put pair
balanced, while the other snapshots keep the remaining options from
changing partway through an invocation.  The individual reads can still
observe an inconsistent combination during a concurrent update, but each
selected field value remains stable for that invocation.

Fixes: aed8ee7feb44 ("net: netfilter: Deduplicate code in bpf_{xdp,skb}_ct_lookup")
Fixes: d7e79c97c00c ("net: netfilter: Add kfuncs to allocate and insert CT")
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v2:
- Snapshot l4proto, ct_zone_id, ct_zone_dir, and the reserved bytes in
  addition to netns_id, as requested in review.
- Rebase onto current bpf/master.

Please queue this fix for stable kernels.

 net/netfilter/nf_conntrack_bpf.c | 76 ++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 24 deletions(-)

diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index f98d1d4b42c3..c3395cb98c00 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -122,42 +122,56 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf_sock_tuple *bpf_tuple,
 	struct nf_conntrack_tuple otuple, rtuple;
 	struct nf_conntrack_zone ct_zone;
 	struct nf_conn *ct;
+	u16 ct_zone_id;
+	s32 netns_id;
+	u8 ct_zone_dir = 0;
+	u8 reserved[3] = {};
+	u8 l4proto;
 	int err;
 
 	if (!(opts_len == NF_BPF_CT_OPTS_SZ || opts_len == 12))
 		return ERR_PTR(-EINVAL);
+
+	netns_id = READ_ONCE(opts->netns_id);
+	l4proto = READ_ONCE(opts->l4proto);
+	ct_zone_id = READ_ONCE(opts->ct_zone_id);
 	if (opts_len == NF_BPF_CT_OPTS_SZ) {
-		if (opts->reserved[0] || opts->reserved[1] || opts->reserved[2])
+		ct_zone_dir = READ_ONCE(opts->ct_zone_dir);
+		reserved[0] = READ_ONCE(opts->reserved[0]);
+		reserved[1] = READ_ONCE(opts->reserved[1]);
+		reserved[2] = READ_ONCE(opts->reserved[2]);
+		if (reserved[0] || reserved[1] || reserved[2])
 			return ERR_PTR(-EINVAL);
 	} else {
-		if (opts->ct_zone_id)
+		if (ct_zone_id)
 			return ERR_PTR(-EINVAL);
 	}
 
-	if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS))
+	if (unlikely(netns_id < BPF_F_CURRENT_NETNS))
 		return ERR_PTR(-EINVAL);
 
-	err = bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, opts->l4proto,
+	err = bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, l4proto,
 				    IP_CT_DIR_ORIGINAL, &otuple);
 	if (err < 0)
 		return ERR_PTR(err);
 
-	err = bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, opts->l4proto,
+	err = bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, l4proto,
 				    IP_CT_DIR_REPLY, &rtuple);
 	if (err < 0)
 		return ERR_PTR(err);
 
-	if (opts->netns_id >= 0) {
-		net = get_net_ns_by_id(net, opts->netns_id);
+	if (netns_id >= 0) {
+		net = get_net_ns_by_id(net, netns_id);
 		if (unlikely(!net))
 			return ERR_PTR(-ENONET);
 	}
 
 	if (opts_len == NF_BPF_CT_OPTS_SZ) {
-		if (opts->ct_zone_dir == 0)
-			opts->ct_zone_dir = NF_CT_DEFAULT_ZONE_DIR;
-		nf_ct_zone_init(&ct_zone,
-				opts->ct_zone_id, opts->ct_zone_dir, 0);
+		if (ct_zone_dir == 0) {
+			ct_zone_dir = NF_CT_DEFAULT_ZONE_DIR;
+			opts->ct_zone_dir = ct_zone_dir;
+		}
+		nf_ct_zone_init(&ct_zone, ct_zone_id, ct_zone_dir, 0);
 	} else {
 		ct_zone = nf_ct_zone_dflt;
 	}
@@ -171,7 +185,7 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf_sock_tuple *bpf_tuple,
 	__nf_ct_set_timeout(ct, timeout * HZ);
 
 out:
-	if (opts->netns_id >= 0)
+	if (netns_id >= 0)
 		put_net(net);
 
 	return ct;
@@ -186,46 +200,60 @@ static struct nf_conn *__bpf_nf_ct_lookup(struct net *net,
 	struct nf_conntrack_tuple tuple;
 	struct nf_conntrack_zone ct_zone;
 	struct nf_conn *ct;
+	u16 ct_zone_id;
+	s32 netns_id;
+	u8 ct_zone_dir = 0;
+	u8 reserved[3] = {};
+	u8 l4proto;
 	int err;
 
 	if (!opts || !bpf_tuple)
 		return ERR_PTR(-EINVAL);
 	if (!(opts_len == NF_BPF_CT_OPTS_SZ || opts_len == 12))
 		return ERR_PTR(-EINVAL);
+
+	netns_id = READ_ONCE(opts->netns_id);
+	l4proto = READ_ONCE(opts->l4proto);
+	ct_zone_id = READ_ONCE(opts->ct_zone_id);
 	if (opts_len == NF_BPF_CT_OPTS_SZ) {
-		if (opts->reserved[0] || opts->reserved[1] || opts->reserved[2])
+		ct_zone_dir = READ_ONCE(opts->ct_zone_dir);
+		reserved[0] = READ_ONCE(opts->reserved[0]);
+		reserved[1] = READ_ONCE(opts->reserved[1]);
+		reserved[2] = READ_ONCE(opts->reserved[2]);
+		if (reserved[0] || reserved[1] || reserved[2])
 			return ERR_PTR(-EINVAL);
 	} else {
-		if (opts->ct_zone_id)
+		if (ct_zone_id)
 			return ERR_PTR(-EINVAL);
 	}
-	if (unlikely(opts->l4proto != IPPROTO_TCP && opts->l4proto != IPPROTO_UDP))
+	if (unlikely(l4proto != IPPROTO_TCP && l4proto != IPPROTO_UDP))
 		return ERR_PTR(-EPROTO);
-	if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS))
+	if (unlikely(netns_id < BPF_F_CURRENT_NETNS))
 		return ERR_PTR(-EINVAL);
 
-	err = bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, opts->l4proto,
+	err = bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, l4proto,
 				    IP_CT_DIR_ORIGINAL, &tuple);
 	if (err < 0)
 		return ERR_PTR(err);
 
-	if (opts->netns_id >= 0) {
-		net = get_net_ns_by_id(net, opts->netns_id);
+	if (netns_id >= 0) {
+		net = get_net_ns_by_id(net, netns_id);
 		if (unlikely(!net))
 			return ERR_PTR(-ENONET);
 	}
 
 	if (opts_len == NF_BPF_CT_OPTS_SZ) {
-		if (opts->ct_zone_dir == 0)
-			opts->ct_zone_dir = NF_CT_DEFAULT_ZONE_DIR;
-		nf_ct_zone_init(&ct_zone,
-				opts->ct_zone_id, opts->ct_zone_dir, 0);
+		if (ct_zone_dir == 0) {
+			ct_zone_dir = NF_CT_DEFAULT_ZONE_DIR;
+			opts->ct_zone_dir = ct_zone_dir;
+		}
+		nf_ct_zone_init(&ct_zone, ct_zone_id, ct_zone_dir, 0);
 	} else {
 		ct_zone = nf_ct_zone_dflt;
 	}
 
 	hash = nf_conntrack_find_get(net, &ct_zone, &tuple);
-	if (opts->netns_id >= 0)
+	if (netns_id >= 0)
 		put_net(net);
 	if (!hash)
 		return ERR_PTR(-ENOENT);
-- 
2.43.0
