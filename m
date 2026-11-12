Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513193;
	b=yRrjZckyV0XmQazzQ2Pb5bpklwCWrc3zgD73R62s/albrOpHhnP9G6yIhuB1cfksB8ZQ
	 Z5X5ugRgi7CdtNOf+7nbs9NLRlY5MUvcvh0r5whHboAyVPk0rJ027xXMS8DbcTNZ43Eii
	 qOUeDOUBanl8QeTny0sESKawQFXWIL/ffOX0Hqyaa5Bi5IULSU5DYJJdoWi1iwU4tBbfW
	 ckXre2Oeq1PZCwLHXwvhyk3fc9c85KUvcbDdd1V+AaXoM2jFwDa0OVlhS2vVCt+Gbwe+m
	 29UYy8kn1j5DkJfCBIiEcbFVHEeEry/PS+DpYYv4fBgy7tafb9sRi6mL1ObiDTYmKrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=slMJ/jl0C3PRYQL80eM6Rik84HUmAPDqG/+JqwCg8f0=;
	b=Ovg/4LR3NFsyqz/nx6+yRxjBLkL6cIBrf2u/NnIu4ngvM8qLzBCtQp6+REgRLEnbc/+Z
	 NDclcwcemskguk1HwVmhwP2DbbVUpZIP720HJVfL/WHH4xtmiVSXWWAvkOO600x5KlkuE
	 gUhGWp/xJFxgzhMBsf7C9P3In+Go4cakU5IOdRVpJubaez5Kuz9ogS733DO1aQ6NgW2Wu
	 7NtOjvlEm0lEQ4lTqVaYCy+HxvHlgSLOvN2OCjTTr4PSudLr43oS03alPGaxa+phyr9BF
	 v34DQWAaiEK8VwsxOpyLpcva3GjPEP8ZifEQs9TEB6JeLuE4312XbhbdTQTyVwYZg0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XOvykWdZ;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB559606A32A
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 19:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB559606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XOvykWdZ
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ed08b07213so1190455ad.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513192; x=1795117992; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slMJ/jl0C3PRYQL80eM6Rik84HUmAPDqG/+JqwCg8f0=;
        b=XOvykWdZa8akqe46XxXcrhPdSdqBzB7qNT4fuFywibfxQufgbTNScOQjj91AfQqUZw
         wmbVWY6cyWAogeH+okdshWEXjy++ULfcj4DQ9nRE1p5Q07j61mwgC5xiXku5NX3VeaJf
         jzGj5QgklpL2p6GeZi5PywWO0zN8hv5iG3w2BfhW/grvky+gs6T8hwl7wD0GeIw+r4Y7
         tbwRpUv+wXlFY11ybqJtpnPlvWZyMvMFNlu79mVZ3Nw3NAnT7oYMN1jJZ13VwHKWsX9f
         nLAZ8PU3gD+zm7kHmsHmshoT2Bb+y8BOMpYkjVVhGXHOpsv6kRL+zhP/btDwUKU1OFGz
         TxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513192; x=1795117992;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=slMJ/jl0C3PRYQL80eM6Rik84HUmAPDqG/+JqwCg8f0=;
        b=ypBJ5OrE39UcF/c2fSfWuX/IP1IZFwOoJWlJMQAj6N0hchV8I5gxvNsScyluaAfY3N
         SvH+zhIlO2k7CX8kZW5iMltDoOQX29OpaSzHlF86z+iFP8S+2hEAhAaC1ZcH5zY+9MHg
         mssXth8Fn+xlgXAhhuxtR0pe2cI/BZ5lKQLVJYbp9YU8QDdEjoNo31CMSzNp+m2D7SiR
         mpfqXnPYswL1we0sjVPPQApYG+yTgmkVF8WST2lZIqpMZRzPpDaGe2rYH7dPjjfcOaMG
         1CHXL/tfTLMtD9Xo+p3tanIvI8CMHbmzvVTzLwFXjUF7F+SS62NJERHATzxzBtC0UA1b
         gYFw==
X-Gm-Message-State: APuU4Z8yS64hoOYhg0eKK6Q6FkB2UkEkMT6FO0JDsnpTvRUeyTfNdyOo
	8c7dPmmz5jl0w/vcXRdxYEIzJUQ5+FnlUhYxZ0imeg4+umXQa0f5QKeF
X-Gm-Gg: AYBFou3Ja395KM7HJ7DO9Dptq4A+0m6cN6y5wfJdcNlQPDQBeutfz8KWg1wlRS6KOm1
	tROV6oMFSHwqkaLq39EeAkSJvqfTbSAMH1FMA0xKQ/k20uvArZWlThBsnNJ4InZIOiQBmBXmOHf
	+kkvilM4YjTvt1zIzqu0HB/ehEf3MQ16BmSrRxHeF+BsPPeGC2DMl+BqB4+asWnqdfSjwaea1FX
	93oKTurgOqRkTWIzoP1vKLXze063907n1xYjdeqTIBonIE2YvlgHf7YlkLikZ9XN+YbxH+S2iXk
	wJGGZP8i9v9jSvoE/5Z3YvhKeZlVnFgx4CCmFPc6LO5t1zXnsjg5kOPLqp1qDWVBVoDQLqSqDLx
	kZ5yU+0bSrRifAL8oU3DvFPxEy9wxTMyehuw7VDIRXR7d1wZCgR/buFNN8Ra1ye8KTTChNPUPAu
	9MBuI50DfTKQytlvur2eWliGa0bYdchD6OTgr6YsHB0UP07kIwitU+yNiqbUGhUrkRE1Yxg33zQ
	rV/2XR7Xt2CGL1rK6HJuZmcZaVpAmUIV87E4TwsH9frPY1TDhJ8FhFMazFuomK4d4T0REO7THPb
	yWUpl6GnyrDtS+gUsXBpT+VnRGOACDOVyQTc81lKgrV+61l9liE2bdKWO6NFIvJSxz2BRtWB/Mj
	mAKVKouP6g4GKL9m7NXhd0CxzTF8jhLRCJs0=
X-Received: by 2002:a05:6a20:5491:b0:3e2:82d6:467f with SMTP id adf61e73a8af0-3f7a75bf032mr171001637.26.1794513191665;
        Thu, 12 Nov 2026 11:53:11 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2053d26sm90591b3a.36.2026.11.12.11.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:53:11 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 19:53:10 +0000
Message-Id: <DMTHU30GGMF2.1ISXFYKE43OM7@gmail.com>
To: "Shihuang Liu" <shlomojune6@gmail.com>, <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Jakub Kicinski" <kuba@kernel.org>,
 "Quentin Monnet" <qmo@kernel.org>
Subject: Re: [PATCH] bpf: Reject offloaded maps as map-in-map inner maps
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261112105620.57520-1-shlomojune6@gmail.com>
References: <20261112105620.57520-1-shlomojune6@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Nov 12, 2026 at 02:56 AM Shihuang Liu <shlomojune6@gmail.com> wrote:
> +	if (bpf_map_is_offloaded(inner_map))
> +		return ERR_PTR(-EOPNOTSUPP);
>  	if (!inner_map->ops->map_meta_equal)
>  		return ERR_PTR(-ENOTSUPP);

No need for a new check.
.map_meta_equal in the ops means that the map can be an inner map.
See the comment in struct bpf_map_ops.
Drop it from bpf_map_offload_ops. Then the next check rejects the map.

> -	if (inner_map_meta->ops->map_meta_equal(inner_map_meta, inner_map)) {
> +	if (inner_map_meta->ops == inner_map->ops &&
> +	    inner_map_meta->ops->map_meta_equal(inner_map_meta, inner_map)) {

bpf_iter_attach_map() has the same problem. It checks map_type only:

  BPF_LINK_CREATE
    bpf_iter_attach_map()      accepts an offloaded ARRAY or HASH
  BPF_ITER_CREATE
    prepare_seq_file()
      __get_seq_info()         bpf_map_offload_ops.iter_seq_info is NULL
                               bpf_map_elem_reg_info.seq_info is NULL
      seq_info->seq_priv_size  <- NULL pointer dereference

Something like this (compile tested only):

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 0fa3f2a..9ec3bbf 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -38,6 +38,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	if (!inner_map_meta)
 		return ERR_PTR(-ENOMEM);

+	inner_map_meta->ops = inner_map->ops;
 	inner_map_meta->map_type = inner_map->map_type;
 	inner_map_meta->key_size = inner_map->key_size;
 	inner_map_meta->value_size = inner_map->value_size;
@@ -65,7 +66,6 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	}

 	/* Misc members not needed in bpf_map_meta_equal() check. */
-	inner_map_meta->ops = inner_map->ops;
 	if (inner_map->ops == &array_map_ops || inner_map->ops == &percpu_array_map_ops) {
 		struct bpf_array *inner_array_meta =
 			container_of(inner_map_meta, struct bpf_array, map);
@@ -88,8 +88,9 @@ void bpf_map_meta_free(struct bpf_map *map_meta)
 bool bpf_map_meta_equal(const struct bpf_map *meta0,
 			const struct bpf_map *meta1)
 {
-	/* No need to compare ops because it is covered by map_type */
-	return meta0->map_type == meta1->map_type &&
+	/* An offloaded map has the map_type of a host map and its own ops */
+	return meta0->ops == meta1->ops &&
+		meta0->map_type == meta1->map_type &&
 		meta0->key_size == meta1->key_size &&
 		meta0->value_size == meta1->value_size &&
 		meta0->map_flags == meta1->map_flags &&
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index a58c148..9e459a2 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -176,6 +176,10 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 	    map->map_type != BPF_MAP_TYPE_RHASH)
 		goto put_map;

+	/* An offloaded map has the map_type of a host map and its own ops */
+	if (!map->ops->iter_seq_info)
+		goto put_map;
+
 	aux->map = map;
 	err = bpf_iter_map_check_prog(prog, aux);
 	if (err)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 04a3b3c..c8146db 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -112,7 +112,6 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr,
 }

 const struct bpf_map_ops bpf_map_offload_ops = {
-	.map_meta_equal = bpf_map_meta_equal,
 	.map_alloc = bpf_map_offload_map_alloc,
 	.map_free = bpf_map_offload_map_free,
 	.map_check_btf = map_check_no_btf,


Pls tag the respin as [PATCH bpf-next v2].

pw-bot: cr
