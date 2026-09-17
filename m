Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AFC4E36CE
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675577; cv=none; b=Sorw6rEES5FH1CpXfDmGM3CrOhPrIrQMakk+vzOqxBV9vMKiQmBhVs+x5ozpuZtL7Dx/Tz2tSrpw78PiUXdHy2JO2QNWn6x+XV/h3I3BWhtd3px/0o/LnIy+j4jrUa+OQN9HyQyoyrK/70tdpUNDcyWy6a9o8lHtZvJ7jJdYM9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675577; c=relaxed/simple;
	bh=KWV6aWQYmH4deDnVX82coMiZxImTQreqd6fjSuI1h10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tccyz5x7TmuhgiqGyp7CIqV9tLxOLjef9UEpIv/5SbqCm4EtTzOf+NQzuy7n+uyga9sgwCXROAC0sewbFUoOkJDzYKMX5MGSRVVtMW6upFm42WKcUSlUgkqLJcggQp9bvP3yhPXGGJv447DJc/xEwok+rIA/0DL/myfkPZaMZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPJC6Ysv; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPJC6Ysv"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b1ae7089c1so651124eaf.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675567; x=1790280367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9OLuSfUhJFvayd43S3ln5vAMWoBx4ysBdw/1W1WxYpU=;
        b=iPJC6YsvlxiCl4gTV0RpIFPlgccU/0sTFOa+aDPuHUPBkTopw/MfjHSnuySxpxWUTf
         h1vN/4tAevEmr3PrdonJgRW8EnnZaFnn+38A85fTz1qIwjPyePVkF/04zTo7WXXrxI7h
         cS1gQxRk/W0kUg2fkERPKhRXb9t9yNqvykhOjqN303ltei9v0lTR+LcJgzOcfowvt1uJ
         by0pY6SETKOzHwbvDJ9Yo2DYDbZ5EhS7RyDXxhC6xm8/ErFwQcFM9JcTGtbRsJTlgqCf
         kVvGut+OGf87aHlih9PZyc6+ZXidS+7+6Zg8v7ZJSNSYHeJY1CNtaL6kBZ26h4+uEegf
         iM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675567; x=1790280367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9OLuSfUhJFvayd43S3ln5vAMWoBx4ysBdw/1W1WxYpU=;
        b=prC0cRH777lXWONs/owKr2aXlVJH8NMdoaNa0h71eS0Vde4fRvyLCPDv8FSIrLSryX
         QYcJ10FirbHfJgywLBVElGh7UuN5Sw/m8XmKa+8h8RPvKsb3MC/jDTVAcRHG5eNewizl
         nUROTFLBfHEufZZFzKBeBDPWlZ0LPRnUB95zVR6FNhd8WykW82pHK/31y6luUEZ6sh0u
         fTWjDkeuMKC/v6en3Tbq6ZpOd8BS51EtuYGlPjKjzIUlG7e7F/Szpyuddt336bhwFqhO
         xy7OtjOlxSnzidE0vKQuNuQt//ocnltm5xCdSaSJktW91MyJ3LSoiFdX/muAkD4oZDkV
         XQuA==
X-Gm-Message-State: AFuF++nDxs2cO69bZFgDXZNeSd3p3l/k9WCUHotAArtV++Ekdn+YSFV9
	3l2IwMiRGFvnAsIHLVZSlnhkxgfL63Tldm32rJ8XicMAV87i71GsXxOg
X-Gm-Gg: AYBFou1qBA3t9MIsiIXUdp+bitCBEhUJKdh4dgeAI62OrrphvOjqWZRo1Ty+TspfX1l
	19VIZIJzfSSB4ScE/DrsER9MsSDDBcSP29TrrFxYtxHrR3BkgMN8MLzIeWBL+0gFX6Fh+WIwNfg
	EDeyPRpFkRuFcR/0uphCdW2XTixtfVWASrwywZyIKMG0hfvo+plyJKtV0tB/HXvVqp1Ix31v1Gw
	98/prnCBNrHc4h1O5YUplBHHXVhrjkoah9Qd7C0YZnXQed/s+xfi5aRfTJM/seBOoHVAa33TzOx
	kRPwr2MKfieGCOSxh3nnaXeObnm5dMmHRGPYd7WD+FlHBH25Tc+ZZw7xR39RKJNOay2zcM6B5k3
	wjYp+Z3yhqdGCM10ZRFMfkr3LgKRuiG0P7M3e9PM5pfTDM8tRvo48Vai2BKbopxGO/zfTnCP1l7
	KPFFZHxjbkuqx1T9oLn6jfsLkZrFCcj9jauqLcmz4QoXC/vUyH4ut3fF1R5MHIpg==
X-Received: by 2002:a05:6820:4c15:b0:6c8:dccc:eb1d with SMTP id 006d021491bc7-6ca9cb58461mr89553eaf.55.1789675567532;
        Thu, 17 Sep 2026 13:06:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:53::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c8f727fe99sm3378877eaf.12.2026.09.17.13.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:06:06 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 10/15] bpf: Allow all struct_ops to use bpf_dynptr_from_skb()
Date: Thu, 17 Sep 2026 13:05:36 -0700
Message-ID: <20260917200542.3689605-11-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260917200542.3689605-1-ameryhung@gmail.com>
References: <20260917200542.3689605-1-ameryhung@gmail.com>
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

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/core/filter.c     | 1 +
 net/sched/bpf_qdisc.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e753552..47b7a8f73069 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12887,6 +12887,7 @@ static int __init bpf_kfunc_init(void)
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

