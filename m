Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4D339E9AC
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358386; cv=none; b=usPm3Vmhp8v0Vm4tZXdqvYtZQZY4HTpH4t2wDqkzB5tQt/7mu0WZ0aYmAIs1aeusBok/E1uL1+bhNA8Kta5r+UiRdQmRnqfiLryqzu2u4lsTNPDd6PcsQtpjy9kkarAJz6TR8WplKZ6/Sse02EVmYnxM9PdoAlMWO1E1KcxpdPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358386; c=relaxed/simple;
	bh=XwQfRbXfrNuIcQEj0+OhqhxLBV6AQPlwF5ItObbRv+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+YGzhX/QM6tCxx9ddP4mwA/ZwaYKw7DCMaFQ09CmoKuzjWww+jB2B8WtV9HePyBU408frHx/Q91lbmwh4zDmoi5rrYdVcOnoR/tWMUdyhmxmTjV1jN60bDCUQlUFnmjT/5r33g4Wm52z+DjyTOxIrWO5+yXC+eIrosItSkW9Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+k5PSF4; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+k5PSF4"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a0e525db1eso2197830eaf.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 10:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358384; x=1783963184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pu+3c0HyaSf1ZVjVmWnlGizQs+nvFxxTW9EelDXDZ/4=;
        b=b+k5PSF4DPn+Ml/2ltwubxSOLGBO8lfZZwWcu8xJP4UYSUMU4CUvIGBvY1psfYtrI6
         8O+Gu4CJBHEf1TpIuAWMZgkwQcxl61/SALoqWIns6p6p/1VvKJzPyG1kRVYWtnaK/qUL
         mE4e7w8JQ7T5C/qVHEOmMRHsUI2Us9JofShJnPGbxYrKzlCu822EV3wQ+lvSQ15LOWcI
         Tum6iGeGogIg1/tlZ1wzFiI7DcQf0Ttp7oYZHL0mCgwLs0y2rsvcNdBGiMks9Cy1hUmM
         1ULmPz6iCdB8m6b9oQz6AR0E9EOUSRKotxRnqc+tuuSMjxHigL6WmnwiBf0EBh8z+P2f
         lAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358384; x=1783963184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pu+3c0HyaSf1ZVjVmWnlGizQs+nvFxxTW9EelDXDZ/4=;
        b=lR66h/j0vZlcSbkFi3XRyx1KKbY5DzcSOTWD+gTqCkp5py4lcbhtYFmfxZkJG0ng7W
         RFbo6stuFHpB3AHS6Y1g97zRg6Xra1qgHdYGRmDg4J2xOuaMbRZYliWd8yLlAc1etBbm
         KBtFc+/M4UOkAAzas5FU+r2qyWnGn9RHAoxP+bEYHwuKLaMHVkL0jl5d0RPv75YZWXLl
         B1EN7S4t8XCiGtaZ/TgH2kl83f5Ajma/EtjPvzpBODaAyjD9YUjz92bTQU+d2i2lpJ7f
         1UQg2ZUM2tPAqaYeDIX3klv6IMEJv2gx7cPG0sm2SPuOgW9nI55iIcri00vrmmuaBX+f
         g87A==
X-Gm-Message-State: AOJu0YzAEly5s/Fd4sspii/zvcv9mhqPawo7QdvrleUDkPCV9ql5wxVi
	VLcq92hOL1a+Zjoczk4GdvTkT07OV3a0B0cICwFXlgQbB6HJtLdSnwHV
X-Gm-Gg: AfdE7cmKwqPcG091UXDuPDkNe9Dja19+bfateCtK7Ol0mPbC29f/sv01xU0O4zL/rci
	iNkdL4YiCrKS6iHXe4cC4nY//al6YuLaIHvYqDvDmKLbZKUAweOsEak/OXY7Ksxe0Z/OkQxDQzE
	+f59fqaVb1V9WJeBbBuzyaf0oWGWw2duUQehff0WPHfTjvQ30ZDBEgreZRKy34h4KbGaw5LRctH
	gNzRwhECiURoxqlpLmuealgtXbTnrAK5lKbrhYHM04V8F7Mo1nsvAhmvlkFK5xKSP3PXkTmtuo6
	ZOh0ITwom0fjlsscuILzrtWmLd0z37mjexFBfO8gOlduuN2D9YEG80lMhSHY4NA7Go9AIR/Bhrs
	lVUIOl3hItdbMBGaAztYK7qGdZ/70fGn/HHXPgkNEanqnCf3MUmHybUqSs7t9BVAqTsXsZaaDWj
	5LFfk=
X-Received: by 2002:a05:6820:1356:b0:6a1:8496:b12a with SMTP id 006d021491bc7-6a355289755mr1081428eaf.23.1783358384474;
        Mon, 06 Jul 2026 10:19:44 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a310003927sm8478620eaf.6.2026.07.06.10.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:43 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 10/15] bpf: Allow all struct_ops to use bpf_dynptr_from_skb()
Date: Mon,  6 Jul 2026 10:19:12 -0700
Message-ID: <20260706171918.317102-11-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706171918.317102-1-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_dynptr_from_skb() was only made available to bpf_qdisc, so far the
only struct_ops type that needs to read an skb. The upcoming bpf_tcp_ops
header-option hooks (parse_hdr/write_hdr_opt) also want to access the TCP
options of an skb through a dynptr.

All struct_ops programs share BPF_PROG_TYPE_STRUCT_OPS, so register
bpf_kfunc_set_skb (which holds bpf_dynptr_from_skb) for that program type
once, instead of per struct_ops. This makes bpf_dynptr_from_skb()
available to bpf_tcp_ops and any future struct_ops.

With the kfunc now provided to all of struct_ops, the bpf_qdisc-specific
registration becomes redundant and is dropped: bpf_qdisc_kfunc_filter()
only constrains kfuncs listed in qdisc_kfunc_ids, so removing
bpf_dynptr_from_skb from that set (and from qdisc_common_kfunc_set) lets
it fall through the filter unchanged, and bpf_qdisc keeps access via the
generic struct_ops registration.

Widening the registration is safe: a struct_ops that does not receive an
skb in its context has nothing to pass to the helper.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/core/filter.c     | 1 +
 net/sched/bpf_qdisc.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4f5cbcac3e78..05f492c215e0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12635,6 +12635,7 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kfunc_set_skb);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb_meta);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_skb_meta);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 098ca02aed89..5691c13781a8 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -280,7 +280,6 @@ BTF_KFUNCS_START(qdisc_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_skb_get_hash)
 BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
 BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule)
 BTF_ID_FLAGS(func, bpf_qdisc_init_prologue)
 BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue)
@@ -290,7 +289,6 @@ BTF_KFUNCS_END(qdisc_kfunc_ids)
 BTF_SET_START(qdisc_common_kfunc_set)
 BTF_ID(func, bpf_skb_get_hash)
 BTF_ID(func, bpf_kfree_skb)
-BTF_ID(func, bpf_dynptr_from_skb)
 BTF_SET_END(qdisc_common_kfunc_set)
 
 BTF_SET_START(qdisc_enqueue_kfunc_set)
-- 
2.52.0

