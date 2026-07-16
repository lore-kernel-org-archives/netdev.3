Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD98830B525
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784162646; cv=none; b=GQDBO4dXFi6P/NWw9cPBvqkvh/A5icrHSrvz3rtDWZ+G8tkRtr3WAMiRJ4OQozlQYJL+s125OmNPXlYwJeru2IgQ0aEzJj6/czGzICxqM7rd5zXmi9hJiM3MVAbaEpGz/led4LKVBr9C0TWAd7YLoUWEHvfrBaSnecdU3v7MVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784162646; c=relaxed/simple;
	bh=LkzKdUO+JmG0HF2usl69sh+fsYe38FuCXJBrcY3/aIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcuEns58EzgjJ+fRAi8z9P4/w2nX6wfDCe+e3YcXlwZ802ePsC63iicT1l/Gs1wpfOitsLD9oY1IR0m9FH1aKQbp53Ddqu8IOvHokVjheKkTMPw40T4bwQYtzq6MzsPu5CSXnCdp/VulMHwzBsi1+vl+xbHYh18JysmjjnM+ILo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/gteU5L; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/gteU5L"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so3895043a12.2
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 17:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784162644; x=1784767444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oURpgbk9qcfxkTyiXEXzSzC9IFYy3cXT62egJ45Q2qY=;
        b=N/gteU5Lrf3Krb9xet+Gq4QYxFc2PYezqcnSa4OPDHBB0hLA751f+ajI0TtytaJNVz
         Iim62SNDb/f79+kfGOxAfpy7Zle+NcI9IHk0Q1dTmkvwcWVwnJBkdn9xf8x6ph225LRL
         enu+1kXarLHkjlCX+sgB5PF7m5pqDbX+XclG3QosD8LMJboF3KgADSpZ9kxI9pp1z3Al
         8vnUbHdP0XwKr/TaSooO+3vhNH/FvS9v8I3oid7LhDQvN/Zs98EAyVAxxgdbJtSbKwaF
         kvDNPCpvAO8o5W1oOXQ3w+GV/pqN0YVbYZlp9Tiigxr3kWKWOSRglpX8/GK3Z/mJAyPv
         RH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784162644; x=1784767444;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oURpgbk9qcfxkTyiXEXzSzC9IFYy3cXT62egJ45Q2qY=;
        b=U8iZpe3/Y4XFmjAjakmjEf5usQYBRRAcNIjKEvqmbGz7gTTrx1nsVzkyrS1jMslQBY
         KFg56v9Z1tlJV1eqir/Jjbh9zMfmnn7CmGW/BNYM5GhAKUo2MCoYzCTNxr2V/NJ9t8rd
         6uStv1Swy39JDbiagLNoP3qR8J/k9n9S3Q7+MwgvAC/mUUQ7tu3hmvjn7uSz7AsD0t4S
         zN4nW14qJIRvlX3fD/chudH35pAzrBNlN3gkXErjyZ/Cid/8CjKt3P6DecKoYY8z2VOr
         q1LuikLDWSRIZGCkNnC4CfNCczQC+FMwY/7vHm1tkSmYuRhvzmhpnsaJKPtwWIYzRVXU
         CSCw==
X-Gm-Message-State: AOJu0YwFfjy5FIzae6PDRwzgqd4VD/EGEyxCkgCAbcUvs0Iqf6VtxLx7
	cPZ3gkaipIOoevgOGBiK/nzxQuVHEO2xfEQA1O2+Y1UDt+BDMLMK29JOTM5iPg==
X-Gm-Gg: AfdE7ckAV3invEyzI6yIyuhEzXkTJNx0A3wnt/4UjBmUa/mlyAveBtDOkSw6HuI8s1d
	5p8ywT57pAbs+rWZ89jsK50HRYUyKblUg5ekQ+RHROo9Pu4NFJK61qM5ATrds1F4Lk1PDXpjOG7
	G8i/MSIWz+qIC1NVIlGr0Kt5H+D4/qTVld/xSJW8CIqbNqhw9y0GLQ2hw13MaTAs+yp0FtOCtOz
	hMfKMO3/kKp/kUkREbaz/K5IjMPEBrtgMH2Mmk8jhT8+96KMzCbkvwAfjq+Ch5zsCAk3O7U9vJN
	aqXwJZOqyZG2DJd7Z9QMkF53ORUthufFJMkdeyFrB2xnPe77jIASmbEe1Fc3AgxxrF4IGibEVok
	1l5KgsPla2pNKH8FWizD9W+joUPAE/O94quXGKmg2Y7nA0o7IAXu3xBdc78an85tFfrSUGrN3Od
	7zuafCJsdvetyIOQQnCvS71LI9CR+O/JCb+oaprCtqpFCJ92xcTnTGvBRqXSD8Jwblah0rF1cQk
	goKdocoIrK827Z2IwtI
X-Received: by 2002:a05:6a20:6a22:b0:3c3:8041:89e3 with SMTP id adf61e73a8af0-3c380418eedmr2728200637.63.1784162644049;
        Wed, 15 Jul 2026 17:44:04 -0700 (PDT)
Received: from l.localdomain ([76.166.220.66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4284a92sm4107620c88.4.2026.07.15.17.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 17:44:03 -0700 (PDT)
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
Subject: [PATCH net-next v1 03/11] net: flow_dissector: add fast-path for VLAN and QinQ + IP + TCP/UDP
Date: Wed, 15 Jul 2026 17:43:49 -0700
Message-ID: <20260716004357.3652679-4-dave.seddon.ca@gmail.com>
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

Extension of the parent series covering the VLAN-tagged shapes: a
single ETH_P_8021Q or ETH_P_8021AD tag, or two stacked tags (the
canonical QinQ S-tag + C-tag), in front of IPv4/IPv6 + TCP/UDP. Adds
flow_dissect_fast_vlan() that consumes the tag(s) and dispatches to
the existing flow_dissect_fast_ipv4 / _ipv6 helpers on the inner
ethertype.

  - What this covers. VLAN-tagged Eth (8021Q or 8021AD, depth 1 or
    2) + IPv4 or IPv6 (per parent's shape constraints) + TCP/UDP.
    Both hardware-stripped (TCI in skb metadata, inner ethertype in
    skb->protocol; only ever the outermost tag) and in-band (4-byte
    vlan_hdr at data + nhoff) tag forms.

  - Keys written. Outer tag: FLOW_DISSECTOR_KEY_VLAN (vlan_id /
    vlan_priority / vlan_tpid / vlan_eth_type); inner tag (depth 1):
    FLOW_DISSECTOR_KEY_CVLAN, mirroring the slow-path's
    MAX -> VLAN -> CVLAN state machine. Bumps
    FLOW_DISSECTOR_KEY_NUM_OF_VLANS when requested by the dissector.
    Byte-identical with the slow path. Past depth 2 the helper
    returns false (defers to the slow path).

  - Gates. Two static keys, each with its own sysctl:
    DEFINE_STATIC_KEY_FALSE(flow_dissector_vlan_key)
    (/proc/sys/net/flow_dissector/vlan) gates entry at depth 0, and
    DEFINE_STATIC_KEY_FALSE(flow_dissector_qinq_key)
    (/proc/sys/net/flow_dissector/qinq) gates the depth-1 tag.
    Defaults 0; off has no behaviour change beyond one extra
    not-taken JMP in the dispatcher switch.

  - Sibling-key handling. The two gates are coupled in their proc
    handlers: writing qinq=1 auto-enables the vlan key (QinQ extends
    VLAN; depth-0 entry is gated by vlan), and turning vlan off clears
    the qinq key (depth-2 cannot fire when the outer entry is off).
    Reads always reflect the underlying key state.

  - Cost. On a miss, one ethertype switch + the static_branch test.
    On a hit, ~3-5 ns added to the IPv4/IPv6 fast-path body per tag
    consumed, while the slow-path's per-tag handling (state-machine
    transition + proto_again rewind) is skipped -- net saving
    ~30 ns/skb on the single-VLAN shape and ~50 ns/skb on QinQ.

Verified byte-identical by the KUnit equivalence suite. Isolated
dissector cost on the allshapes microbench (all fast paths compiled
in, range across 7 measured microarchitectures): vlan -18.1%..-38.5%,
qinq -16.1%..-39.8% -- see the cover letter's performance summary.

Assisted-by: Claude:claude-fable-5 sparse smatch
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
 Documentation/admin-guide/sysctl/net.rst |  31 +++++
 include/net/flow_dissector.h             |   2 +
 net/core/flow_dissector.c                | 147 +++++++++++++++++++++++
 3 files changed, 180 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index aac82169e019..824f4b735caa 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -485,6 +485,37 @@ when this is 0.
 
 Default: 0
 
+vlan
+~~~~
+
+Single 802.1Q or 802.1AD tagged frames over Eth + IPv4/IPv6 +
+TCP/UDP. Handles both the hardware-stripped form (tag in skb
+metadata, inner ethertype in skb->protocol) and the in-band form
+(4-byte vlan_hdr at data + nhoff). Writes FLOW_DISSECTOR_KEY_VLAN
+and bumps FLOW_DISSECTOR_KEY_NUM_OF_VLANS when those keys are
+requested by the dissector. Byte-identical with the slow path for
+the eligible shape; defers on any miss (QinQ defers; see the qinq
+sysctl).
+
+Default: 0
+
+qinq
+~~~~
+
+Lifts the vlan fast-path's depth limit from 1 to 2 so two stacked
+802.1AD / 802.1Q tags (canonical QinQ S-tag + C-tag, or two stacked
+802.1Q tags) are also fast-pathed. Outer tag is written to
+FLOW_DISSECTOR_KEY_VLAN, inner to FLOW_DISSECTOR_KEY_CVLAN, mirroring
+the slow-path's MAX → VLAN → CVLAN state machine. Byte-identical
+with the slow path for the eligible shape.
+
+Auto-toggle: writing qinq=1 also enables vlan (QinQ extends VLAN;
+the depth-0 entry of the helper is gated by the vlan key). Turning
+vlan off (writing 0) also clears qinq (depth-2 cannot fire when
+the outer entry is off).
+
+Default: 0
+
 3. /proc/sys/net/unix - Parameters for Unix domain sockets
 ----------------------------------------------------------
 
diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 7d513a6cbb55..4f36f3889a28 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -429,6 +429,8 @@ extern struct flow_dissector flow_keys_basic_dissector;
  * /proc/sys/net/flow_dissector/<shape>. All default off.
  */
 extern struct static_key_false flow_dissector_eth_ip_key;
+extern struct static_key_false flow_dissector_vlan_key;
+extern struct static_key_false flow_dissector_qinq_key;
 
 /* struct flow_keys_digest:
  *
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 88b1bd1cc4ca..826314e28db0 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -42,6 +42,10 @@
  */
 DEFINE_STATIC_KEY_FALSE(flow_dissector_eth_ip_key);
 EXPORT_SYMBOL(flow_dissector_eth_ip_key);
+DEFINE_STATIC_KEY_FALSE(flow_dissector_vlan_key);
+EXPORT_SYMBOL(flow_dissector_vlan_key);
+DEFINE_STATIC_KEY_FALSE(flow_dissector_qinq_key);
+EXPORT_SYMBOL(flow_dissector_qinq_key);
 
 /* IPv4 version/IHL byte of an option-less header: version 4, IHL 5. */
 #define FLOW_DIS_IPV4_VIHL_NOOPT	0x45
@@ -1242,6 +1246,93 @@ static bool flow_dissect_fast_ipv6(const struct sk_buff *skb,
 	return true;
 }
 
+/* Strip up to two 802.1Q/802.1AD tags: outer tag ->
+ * FLOW_DISSECTOR_KEY_VLAN, inner -> _CVLAN, mirroring the slow path's
+ * MAX -> VLAN -> CVLAN state machine; more than two tags defer.
+ * Depth 0 is gated by the vlan key, depth >= 1 by the qinq key (the
+ * qinq sysctl also flips vlan on -- see the proc_handlers).
+ */
+static bool flow_dissect_fast_vlan(const struct sk_buff *skb,
+				   struct flow_dissector *flow_dissector,
+				   void *target_container,
+				   const void *data,
+				   __be16 proto, int nhoff, int hlen,
+				   int vlan_depth)
+{
+	struct flow_dissector_key_num_of_vlans *key_nvs;
+	struct flow_dissector_key_vlan *key_vlan;
+	enum flow_dissector_key_id vlan_key;
+	__be16 inner_proto;
+	__be16 saved_tpid;
+	u16 tci_prio;
+	u16 tci_id;
+
+	if (vlan_depth >= 1 &&
+	    !static_branch_unlikely(&flow_dissector_qinq_key))
+		return false;
+	if (vlan_depth >= 2)
+		return false;
+
+	vlan_key = vlan_depth == 0 ?
+		   FLOW_DISSECTOR_KEY_VLAN :
+		   FLOW_DISSECTOR_KEY_CVLAN;
+	saved_tpid = proto;
+
+	/* HW-stripped tag is only ever the outermost. */
+	if (vlan_depth == 0 && skb && skb_vlan_tag_present(skb)) {
+		tci_id = skb_vlan_tag_get_id(skb);
+		tci_prio = skb_vlan_tag_get_prio(skb);
+		inner_proto = skb->protocol;
+	} else {
+		const struct vlan_hdr *vlan;
+
+		if (unlikely(hlen - nhoff < (int)sizeof(*vlan)))
+			return false;
+		vlan = (const struct vlan_hdr *)((const u8 *)data + nhoff);
+		tci_id = ntohs(vlan->h_vlan_TCI) & VLAN_VID_MASK;
+		tci_prio = (ntohs(vlan->h_vlan_TCI) &
+			    VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
+		inner_proto = vlan->h_vlan_encapsulated_proto;
+		nhoff += (int)sizeof(*vlan);
+	}
+
+	if (dissector_uses_key(flow_dissector, vlan_key)) {
+		key_vlan = skb_flow_dissector_target(flow_dissector,
+						     vlan_key,
+						     target_container);
+		key_vlan->vlan_id = tci_id;
+		key_vlan->vlan_priority = tci_prio;
+		key_vlan->vlan_tpid = saved_tpid;
+		key_vlan->vlan_eth_type = inner_proto;
+	}
+	if (dissector_uses_key(flow_dissector,
+			       FLOW_DISSECTOR_KEY_NUM_OF_VLANS)) {
+		key_nvs = skb_flow_dissector_target(flow_dissector,
+						    FLOW_DISSECTOR_KEY_NUM_OF_VLANS,
+						    target_container);
+		key_nvs->num_of_vlans++;
+	}
+
+	switch (inner_proto) {
+	case htons(ETH_P_IP):
+		return flow_dissect_fast_ipv4(skb, flow_dissector,
+					      target_container, data,
+					      nhoff, hlen);
+	case htons(ETH_P_IPV6):
+		return flow_dissect_fast_ipv6(skb, flow_dissector,
+					      target_container, data,
+					      nhoff, hlen);
+	case htons(ETH_P_8021Q):
+	case htons(ETH_P_8021AD):
+		return flow_dissect_fast_vlan(skb, flow_dissector,
+					      target_container, data,
+					      inner_proto, nhoff, hlen,
+					      vlan_depth + 1);
+	default:
+		return false;
+	}
+}
+
 /* Top-level dispatcher: eligibility check (only the two standard
  * dissectors and flag subset) + per-proto switch with per-shape
  * static_branch gating. Each case's branch is a forward not-taken JMP
@@ -1270,6 +1361,13 @@ static bool flow_dissect_fast(const struct sk_buff *skb,
 		return false;
 
 	switch (proto) {
+	case htons(ETH_P_8021Q):
+	case htons(ETH_P_8021AD):
+		if (!static_branch_unlikely(&flow_dissector_vlan_key))
+			return false;
+		return flow_dissect_fast_vlan(skb, flow_dissector,
+					      target_container, data,
+					      proto, nhoff, hlen, 0);
 	case htons(ETH_P_IP):
 		if (!static_branch_unlikely(&flow_dissector_eth_ip_key))
 			return false;
@@ -2367,6 +2465,41 @@ static int __init init_default_flow_dissectors(void)
 core_initcall(init_default_flow_dissectors);
 
 /* Per-shape fast-path sysctls under /proc/sys/net/flow_dissector/. */
+/* proc_handler for net.flow_dissector.vlan. Writes of 0 also clear
+ * flow_dissector_qinq_key — QinQ depth-2 is meaningless when the
+ * outer single-VLAN gate is off, so the slow path would have to
+ * handle every VLAN-tagged packet anyway.
+ */
+static int proc_set_vlan_key(const struct ctl_table *table, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret;
+
+	ret = proc_do_static_key(table, write, buffer, lenp, ppos);
+	if (ret == 0 && write &&
+	    !static_branch_unlikely(&flow_dissector_vlan_key) &&
+	    static_branch_unlikely(&flow_dissector_qinq_key))
+		static_branch_disable(&flow_dissector_qinq_key);
+	return ret;
+}
+
+/* proc_handler for net.flow_dissector.qinq. Writes of 1 also enable
+ * flow_dissector_vlan_key — QinQ extends the VLAN fast-path to depth
+ * 2; it cannot fire when the depth-0 entry is gated off.
+ */
+static int proc_set_qinq_key(const struct ctl_table *table, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret;
+
+	ret = proc_do_static_key(table, write, buffer, lenp, ppos);
+	if (ret == 0 && write &&
+	    static_branch_unlikely(&flow_dissector_qinq_key) &&
+	    !static_branch_unlikely(&flow_dissector_vlan_key))
+		static_branch_enable(&flow_dissector_vlan_key);
+	return ret;
+}
+
 static struct ctl_table flow_dissector_sysctl_table[] = {
 	{
 		.procname	= "eth_ip",
@@ -2375,6 +2508,20 @@ static struct ctl_table flow_dissector_sysctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_do_static_key,
 	},
+	{
+		.procname	= "vlan",
+		.data		= &flow_dissector_vlan_key.key,
+		.maxlen		= sizeof(flow_dissector_vlan_key),
+		.mode		= 0644,
+		.proc_handler	= proc_set_vlan_key,
+	},
+	{
+		.procname	= "qinq",
+		.data		= &flow_dissector_qinq_key.key,
+		.maxlen		= sizeof(flow_dissector_qinq_key),
+		.mode		= 0644,
+		.proc_handler	= proc_set_qinq_key,
+	},
 };
 
 static int __init flow_dissector_sysctl_init(void)
-- 
2.54.0

