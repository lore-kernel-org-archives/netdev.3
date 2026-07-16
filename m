Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABCF41B8D7
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203898; cv=none; b=LDrSa3DC0YKdtbBHUOCdKvtIpuVhjgloKDAhhQpKK3ZgWUtQ4BxRjJNcp5gaoHkF9Qg7pOpGeICMxLg1X6QASxhEX+X/qt3sTEt7Nbag8KQ4If3jMRoDC/vokPKzNzj0qaw71WB0xdPxJ+gl95qZHXdBgERxQZa0QoruvtLtQac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203898; c=relaxed/simple;
	bh=ficmtKuo7z7vZ8G39pNmXFCtmwsRKePX95J90ttlbg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuoMKOhWVqbFfM3P6jveargoRzRbZ1SFepojoG/Kmxkm+1B0RujegrOb3Tbf67q0HM1AxNZWusAzmxAqQ29EUYiX0nV9MRuGVdgW3jPUPxBdhjdY1I749yP0dpiMD86uuqSf1YwdNJvQAxyHAIAb+6esDIjo3rUCsLZzdJPqfRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTIor5XP; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTIor5XP"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2cc8ed77bbcso37219775ad.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784203897; x=1784808697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W6mgtFDEnWRLf8qUl6KQcn7fDeFTCrbz36aB9g0zHLo=;
        b=NTIor5XPrvQFsSFa8q2AU/l83sBKGnAlCVivydJu4+WGIZjnhISkTZNCtpXtcJLk7C
         TGjtikdtSuctZ3G4huI+0hVFeDSqgWp8i3HKyaLnaohgs4erMyx7Rcu2FP29RXwpd/xL
         a3GuijaHV67fRLwLYYaiEYkec9Dk187KSKb3+fkrzzdYuD2C1RycQhsQVods7KFV6PpY
         2qAi0ApvB18mAXNqB110BmvJZh2/vwFc2+Y5IvD0t8bkbpnAjroUExYVMzJfYx065I9H
         QqWe4PBkxiAgOTcIOIfOw1j3wdjbSqMNgKgAnuUNivQhh7QvtEjS/fSJE+0AU6+xeHyv
         n6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784203897; x=1784808697;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W6mgtFDEnWRLf8qUl6KQcn7fDeFTCrbz36aB9g0zHLo=;
        b=IRae3V+kVcpz3nfq5YsHeTLVxvaYRGY7dt2E1WqGutOkCFF2OiMWxHyB4fIf0+WKaI
         RVzo2Snb5SQcVLJTkRNp+bnys3D9DSHNqRKMyJ+ODozadaeKOXMQXy/CR4dM6c8CDFdp
         9s4QyKuQ2yqGv54YvjH/mTQtz758M+hhol1azxmyWQn+ZgLjYM5EGwksLB5ahuoliKyP
         P63bz1NijfMHISty61FM03/vdxpHnPbxq7i8FofB/so2eRddR4ljwGidyKYOFJQOMGRd
         XBYWYdMazMcaSJYY+vFCODX+rv5dapNg/jyKoe40KXgqkzKdt68P0vv7rryPCJUnc7tI
         1m7Q==
X-Gm-Message-State: AOJu0YwxdRRGSe0l3jlrJ6qcvNTxG+GARkAGf9AMJUYDlqi560cSSC+M
	dbGRV1FgPUX3HHU6AYq2CqlWGGUASmv1qqDfyNzjn8+qUwWubJ9PwHzp
X-Gm-Gg: AfdE7ckyrHi6z5+EDXDeY4ivCMsJWoHJk7Ixc55Ni4lZOmvr3eH5eKmdAwS3QWzW3Yu
	P5vi6GI3tuWdRf/1SFQ+zQ6PHxLpw0uQ9OQg8HDSkP2DhMh5clVuP9a7vEeYq3NP1VeXTb1j7h6
	cdXodzGKRRb+/+MQ6bdPsrSxyFE06a26C5BpeTCR20E0aLZpmkoArjdgC4VHMhgtW5iVrhWOnzH
	I24XQM/GCaM+vawnSQhAQ1MeU5q5LyUHf4GyL5Qzd9eQNIWGE6+FbklfIrcY6W8vBk0O4F78YBr
	ow6vWzS2T+3u4zXk/M4quSopPeNZ6ZKsQFboIwjuIVds73/ZwEFaj/SLYMa8302UPbksV8ogsl4
	AqewqyZ4LqDivX3NeoJjtWmyokQzqwULIISMdeL53OY5JYHGh5hnaAJMkOesNyOZ3C7tE5A==
X-Received: by 2002:a17:903:3885:b0:2c8:1c05:16aa with SMTP id d9443c01a7336-2ce9e9b0f2dmr221502645ad.19.1784203896731;
        Thu, 16 Jul 2026 05:11:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf106de4b7sm19146975ad.69.2026.07.16.05.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:11:36 -0700 (PDT)
Date: Thu, 16 Jul 2026 05:11:30 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Subject: Re: [PATCH RFC net-next 3/6] bpf: Allow skb extensions to survive
 packet scrubbing
Message-ID: <aljKKt6nCB3fjFVA@devvm7509.cco0.facebook.com>
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
 <20260714-bpf-meta-inside-skb-ext-v1-3-5871c07a8dd6@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714-bpf-meta-inside-skb-ext-v1-3-5871c07a8dd6@cloudflare.com>

On 07/14, Jakub Sitnicki wrote:
> skb_scrub_packet() drops all skb extensions unconditionally via
> skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv,
> vxlan_rcv, etc.) and cross-netns forwarding (dev_forward_skb).
> 
> This makes it impossible for a BPF program to pass metadata via
> bpf_skb_ext through a tunnel or across a netns boundary. The extension
> is always lost at the scrub point.
> 
> Introduce skb_ext_scrub() which consults each active extension before
> discarding it. Extensions that request preservation are kept while the
> rest are torn down. When the extension slab is shared with clones, COW
> ensures isolation. Replace the skb_ext_reset() call in
> skb_scrub_packet() with skb_ext_scrub().
> 
> Expose the opt-in mechanism to BPF via the BPF_SKB_EXT_F_NO_SCRUB flag
> for bpf_dynptr_from_skb_ext(). A program that sets this flag when
> creating the extension signals that its metadata should survive
> scrubbing.
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  include/linux/bpf.h      |  1 +
>  include/linux/skbuff.h   |  2 ++
>  include/uapi/linux/bpf.h |  3 +-
>  net/core/filter.c        | 11 +++++--
>  net/core/skbuff.c        | 82 ++++++++++++++++++++++++++++++++++++++++++------
>  net/ipv4/udp.c           |  2 +-
>  6 files changed, 86 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6b918a5b61bf..a46ca53c5b27 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -4214,6 +4214,7 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
>  #ifdef CONFIG_BPF_SKB_EXT
>  
>  struct bpf_skb_ext {
> +	u64 flags;
>  	u8 buf[CONFIG_BPF_SKB_EXT_SIZE] __aligned(8);
>  };
>  
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 584d8440d352..66afa5489007 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -5063,6 +5063,7 @@ void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
>  void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
>  void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
>  void __skb_ext_put(struct skb_ext *ext);
> +void skb_ext_scrub(struct sk_buff *skb);
>  
>  static inline void skb_ext_put(struct sk_buff *skb)
>  {
> @@ -5132,6 +5133,7 @@ static inline bool skb_has_extensions(struct sk_buff *skb)
>  static inline void __skb_ext_put(struct skb_ext *ext) {}
>  static inline void skb_ext_put(struct sk_buff *skb) {}
>  static inline void skb_ext_reset(struct sk_buff *skb) {}
> +static inline void skb_ext_scrub(struct sk_buff *skb) {}
>  static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
>  static inline void __skb_ext_copy(struct sk_buff *d, const struct sk_buff *s) {}
>  static inline void skb_ext_copy(struct sk_buff *dst, const struct sk_buff *s) {}
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 3eee4467422d..02da170205de 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7734,7 +7734,8 @@ struct bpf_insn_array_value {
>  
>  /* Flags to control bpf_dynptr_from_skb_ext() behavior. */
>  enum {
> -	BPF_SKB_EXT_F_CREATE = (1ULL << 0),
> +	BPF_SKB_EXT_F_CREATE	= (1ULL << 0),
> +	BPF_SKB_EXT_F_NO_SCRUB	= (1ULL << 1),

Do I understand correctly that you do prefer the NO_SCRUB mode? Any reason
we need to have scrub mode? If it's all produced/consumed by bpf, maybe
we can just carry this data unconditionally instead of having a SCRUB/NO_SCRUB
option?
