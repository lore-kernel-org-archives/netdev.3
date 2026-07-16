Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A7305693
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784162654; cv=none; b=EJEFTtFEhTu6AcotEC5UIO8egrFRTbR6JqHFl5R6RWgEPNvR1wPPYr6wgKyE9Jkh9Eh4g2zpGIBYjT9TSbXpwskYKf8NHs94XB2fz0ZTM+BPXp9dIK4WF6Fz4IQErhOlMWYUbE6xIggyVftSGFYlyBulpiHaKnnEjSMCh9VTRlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784162654; c=relaxed/simple;
	bh=WhaPoRb0QmwTgOHptlhNgtNX0s0Rws9PcuRWlOBdLN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8tKZj6YnnRl4aGo9R3ErucY+2Wu/bpOmFfnOfR6bBx6lYAUqAmEO7q978KboSSGhZWUq6P731mUeQZuQCMD32xH1LtO7qDYBMemBtFHsUriJlLrtBLWYYgqv3Lfn/BFby4qgVfxqdVO2aA7CX4BG+H7sa2l0oNu4jRlWiKRozc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3Xbxs28; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3Xbxs28"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca7c1176317so4451523a12.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 17:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784162647; x=1784767447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wj3qOVD1qVOw8XUvfGDy0ElOIdjPdoQAPsV1zxudQMA=;
        b=J3Xbxs28jmmW4cEXtT6nmgy8HKTR0w677P7JwwvAmcm4YHf/R6EFVF1lTWeV448h9O
         OJvCudHaPnxB/QgYlmqEeWv+o75iYJGqA6gqSTWP9vqCPrSp2pgTQpJVU01Wv/iIPiOg
         RuqZmbo2VG0xMyUi4CJMGvYwUQJ9MI0J5YQLk5vHQvFzXuEraoLgm0MVX3E3KMea1dHu
         4tS8pV5gTVySN7kAmW4Nx/rA6h8um+8g57JrqFXiJcHcUO/6RY3RB5XxV4DLGDUdhQIP
         ytLWpqG9p+TYO2YW7h0esU03RiWkJjnk+hAq4hugi6m1QCjlmMWO0nB3wML+6htX+JGi
         2k+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784162647; x=1784767447;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wj3qOVD1qVOw8XUvfGDy0ElOIdjPdoQAPsV1zxudQMA=;
        b=iSNBE1Lxrn0FzntZSR2XKSfbdd/bb6cICzUTt45bRZRv7mF3tOgj1RSkx8a4nyb5W6
         AxbHGm6ugmdDorw77bGUbwoXIHCi1L3WFyhUgXJAx8UPT9m1y32LqEU4Pw27K3tHSUoM
         vfAeHJzfdF3jsWxFaz0f2GGLa/LKCkuwgvOdeyQ8wTsD0PIrm8+v5PbMobyRxvVz/H9Q
         A05STELG9gQalzIRc49WNV5iyMRHMjT63qclF7+XjRX2NATStw8YadjeFik1m3ymKfgK
         /iv9PLgu/XrYLufwcqNFgmwVPm9DKN98R8TQH/RFfERAfNY7CSgWLjfLQr4+6hyYrkl4
         Idsw==
X-Gm-Message-State: AOJu0YzqZfE7vxNRF7Gi2oeQ3JhCa2dFducmx8dr4C0/y+eVcEDZDW+J
	g9r3jvQknABZL7QNATmAgj43GU6HiBY5zOvk6SigPyoLKhht4Hala8rZSozDIQ==
X-Gm-Gg: AfdE7ckqCOveuYjO807OYEgp6WfA8WxUnKuVOCyDz11fe0zH5vE7lMTlfQDbXuFups2
	Yxb9jr4C10qcJ74glPrOHWZzjbp92eUDJr5iblKbafzFo85A8gOfQ+X4SoMuKHz45Xi7ET7tNH5
	87XCyr32XpYUT6GzZSzeoQ4tTPSFV3b1+vjLb5w9bLtsVTS1GqdK9H5eh5UlnQNH+0K6LlhLhhe
	C+5UNuQuKeqpxp8p4DXzm7CaitRQVN+oPBbybHzuaDzK/2Py+RFigPXFVN9jT0VUaWG8G7P5M7E
	HV3WSIiofx7QpBMLn34uua/jnAcjsXzQ27Ww7QK7X+YYu2VLAiHWBBenTaLQxsWCoK3RVt7eNZd
	EyHHvwLjskoZ8KRd1ROeF/J0oAI3tpLwVUQGXl/LXQuyM7ii5px/DNPB8JfoiiqpHoCWbjwBjvX
	ry8bRr5YYyxLL2TGGky0MBR5ivHm8yzp/UI6o8sRXje6C1RlL2YYOXsCTG4kLdH9ZsfpElwYAaI
	qAat7xn6w==
X-Received: by 2002:a05:6a21:2291:b0:3bf:b40b:def2 with SMTP id adf61e73a8af0-3c36c0f6cf0mr5511456637.9.1784162646934;
        Wed, 15 Jul 2026 17:44:06 -0700 (PDT)
Received: from l.localdomain ([76.166.220.66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4284a92sm4107620c88.4.2026.07.15.17.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 17:44:06 -0700 (PDT)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tom Herbert <tom@herbertland.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-kernel@vger.kernel.org,
	Dave Seddon <dave.seddon.ca@gmail.com>
Subject: [PATCH net-next v1 05/11] net: flow_dissector: add fast-path for single MPLS label + IP
Date: Wed, 15 Jul 2026 17:43:51 -0700
Message-ID: <20260716004357.3652679-6-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716004357.3652679-1-dave.seddon.ca@gmail.com>
References: <20260716004357.3652679-1-dave.seddon.ca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds flow_dissect_fast_mpls() — straight-line read of one MPLS label
entry (ETH_P_MPLS_UC 0x8847 / ETH_P_MPLS_MC 0x8848), extracting
label / TC / TTL / BoS and writing to FLOW_DISSECTOR_KEY_MPLS lse[0]
when the dissector requests it.

Byte-identical with the slow path's __skb_flow_dissect_mpls() called
with lse_index=0, bos=1: the slow path returns FLOW_DISSECT_RET_OUT_GOOD
when BoS is set without descending into the inner packet (MPLS flow
hashing is on the label stack, not the inner 5-tuple), so this
fast-path does the same — no IP tail-call.

Multi-label stacks (BoS=0 on the first label) defer to the slow
path. A depth-2+ variant can land later, mirroring the vlan ->
qinq staging used for the VLAN gates.

Why this matters: MPLS is the dominant SP backbone L2.5 and the
existing slow-path traverses an iteration loop per label even when
the consumer just wants the label-stack flow key. The fast-path
saves the iteration overhead for the common single-label case while
keeping the slow path as escape for multi-label and the
entropy-label case (which can only fire from label 2+ anyway).

Gated by:
  - new DEFINE_STATIC_KEY_FALSE(flow_dissector_mpls_key)
  - new sysctl /proc/sys/net/flow_dissector/mpls (default 0)
  - dispatcher case htons(ETH_P_MPLS_UC) / htons(ETH_P_MPLS_MC) with
    static_branch_unlikely(&flow_dissector_mpls_key) guard

When the sysctl is 0, dispatcher cost is one not-taken JMP per
matching packet — same per-shape pattern as the other fast-path
patches.

Documentation/admin-guide/sysctl/net.rst grows an `mpls` subsection
under /proc/sys/net/flow_dissector/.

The helper also mirrors the slow path's out_good terminal writes: for
the standard flow_keys dissectors (which request no MPLS key), the
slow path returns OUT_GOOD after the first LSE with nhoff advanced
past it, so thoff, n_proto (the MPLS ethertype) and ip_proto (0) are
still written at the exit label. Skipping those writes is observable
in struct flow_keys and would break the byte-identical contract; the
in-tree KUnit equivalence test added later in this series catches
exactly this.

Assisted-by: Claude:claude-fable-5 sparse smatch
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
 Documentation/admin-guide/sysctl/net.rst | 19 ++++++
 include/net/flow_dissector.h             |  1 +
 net/core/flow_dissector.c                | 83 ++++++++++++++++++++++++
 3 files changed, 103 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 1096e6ddca39..1ee5419ffaeb 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -534,6 +534,25 @@ code != 0).
 
 Default: 0
 
+mpls
+~~~~
+
+Single-label MPLS frames (EtherType ``ETH_P_MPLS_UC`` 0x8847 or
+``ETH_P_MPLS_MC`` 0x8848 with bottom-of-stack bit set on the first
+label). The fast-path reads the 4-byte label entry, extracts
+label / TC / TTL / BoS, and writes them to FLOW_DISSECTOR_KEY_MPLS
+lse[0] when requested. Byte-identical with the slow path's
+__skb_flow_dissect_mpls() for lse_index=0, bos=1: the slow path
+returns OUT_GOOD on BoS without descending into the inner packet
+(MPLS hashing is on the label stack, not inner 5-tuple), so this
+fast-path does the same.
+
+Multi-label stacks (BoS=0 on the first label) defer to slow path —
+extending to depth-2 or more is a follow-up, mirroring the
+vlan -> qinq staging used earlier in this series.
+
+Default: 0
+
 3. /proc/sys/net/unix - Parameters for Unix domain sockets
 ----------------------------------------------------------
 
diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index df85162959cc..8df7821ba769 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -432,6 +432,7 @@ extern struct static_key_false flow_dissector_eth_ip_key;
 extern struct static_key_false flow_dissector_vlan_key;
 extern struct static_key_false flow_dissector_qinq_key;
 extern struct static_key_false flow_dissector_pppoe_key;
+extern struct static_key_false flow_dissector_mpls_key;
 
 /* struct flow_keys_digest:
  *
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 21a3f5e0ea05..0ec1a6a1bb0e 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -48,6 +48,8 @@ DEFINE_STATIC_KEY_FALSE(flow_dissector_qinq_key);
 EXPORT_SYMBOL(flow_dissector_qinq_key);
 DEFINE_STATIC_KEY_FALSE(flow_dissector_pppoe_key);
 EXPORT_SYMBOL(flow_dissector_pppoe_key);
+DEFINE_STATIC_KEY_FALSE(flow_dissector_mpls_key);
+EXPORT_SYMBOL(flow_dissector_mpls_key);
 
 /* IPv4 version/IHL byte of an option-less header: version 4, IHL 5. */
 #define FLOW_DIS_IPV4_VIHL_NOOPT	0x45
@@ -1396,6 +1398,73 @@ static bool flow_dissect_fast_pppoe(const struct sk_buff *skb,
 				      nhoff, hlen);
 }
 
+/* Single MPLS label (BoS=1): write FLOW_DISSECTOR_KEY_MPLS lse[0]
+ * when requested and stop -- the slow path returns OUT_GOOD on BoS
+ * without descending into the inner packet, so the fast path must
+ * not tail-call either. Multi-label stacks defer.
+ */
+static bool flow_dissect_fast_mpls(const struct sk_buff *skb,
+				   struct flow_dissector *flow_dissector,
+				   void *target_container,
+				   const void *data,
+				   __be16 proto, int nhoff, int hlen)
+{
+	struct flow_dissector_key_control *key_control;
+	struct flow_dissector_key_basic *key_basic;
+	struct flow_dissector_key_mpls *key_mpls;
+	struct flow_dissector_mpls_lse *lse;
+	const struct mpls_label *hdr;
+	u32 entry, label, bos;
+
+	if (unlikely(hlen - nhoff < (int)sizeof(*hdr)))
+		return false;
+	hdr = (const struct mpls_label *)((const u8 *)data + nhoff);
+	entry = ntohl(hdr->entry);
+	bos = (entry & MPLS_LS_S_MASK) >> MPLS_LS_S_SHIFT;
+
+	/* Multi-label stack: defer. */
+	if (!bos)
+		return false;
+
+	/* Neither MPLS key requested: the slow path returns OUT_GOOD without
+	 * writing the key; skipping the write block matches it.
+	 */
+	label = (entry & MPLS_LS_LABEL_MASK) >> MPLS_LS_LABEL_SHIFT;
+
+	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_MPLS)) {
+		key_mpls = skb_flow_dissector_target(flow_dissector,
+						     FLOW_DISSECTOR_KEY_MPLS,
+						     target_container);
+		lse = &key_mpls->ls[0];
+		lse->mpls_ttl = (entry & MPLS_LS_TTL_MASK) >> MPLS_LS_TTL_SHIFT;
+		lse->mpls_bos = bos;
+		lse->mpls_tc = (entry & MPLS_LS_TC_MASK) >> MPLS_LS_TC_SHIFT;
+		lse->mpls_label = label;
+		dissector_set_mpls_lse(key_mpls, 0);
+	}
+
+	/* Mirror the slow path's out_good terminal: nhoff advances past the
+	 * LSE, then thoff/basic are written from the final proto/ip_proto.
+	 */
+	nhoff += (int)sizeof(*hdr);
+	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_CONTROL)) {
+		key_control = skb_flow_dissector_target(flow_dissector,
+							FLOW_DISSECTOR_KEY_CONTROL,
+							target_container);
+		key_control->thoff = min_t(u16, nhoff,
+					   skb ? skb->len : hlen);
+	}
+	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_BASIC)) {
+		key_basic = skb_flow_dissector_target(flow_dissector,
+						      FLOW_DISSECTOR_KEY_BASIC,
+						      target_container);
+		key_basic->n_proto = proto;
+		key_basic->ip_proto = 0;
+	}
+
+	return true;
+}
+
 /* Top-level dispatcher: eligibility check (only the two standard
  * dissectors and flag subset) + per-proto switch with per-shape
  * static_branch gating. Each case's branch is a forward not-taken JMP
@@ -1449,6 +1518,13 @@ static bool flow_dissect_fast(const struct sk_buff *skb,
 		return flow_dissect_fast_pppoe(skb, flow_dissector,
 					       target_container, data,
 					       nhoff, hlen);
+	case htons(ETH_P_MPLS_UC):
+	case htons(ETH_P_MPLS_MC):
+		if (!static_branch_unlikely(&flow_dissector_mpls_key))
+			return false;
+		return flow_dissect_fast_mpls(skb, flow_dissector,
+					      target_container, data,
+					      proto, nhoff, hlen);
 	default:
 		return false;
 	}
@@ -2598,6 +2674,13 @@ static struct ctl_table flow_dissector_sysctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_do_static_key,
 	},
+	{
+		.procname	= "mpls",
+		.data		= &flow_dissector_mpls_key.key,
+		.maxlen		= sizeof(flow_dissector_mpls_key),
+		.mode		= 0644,
+		.proc_handler	= proc_do_static_key,
+	},
 };
 
 static int __init flow_dissector_sysctl_init(void)
-- 
2.54.0

