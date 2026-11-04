Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806884;
	b=tJxKelkEkqj3u7c37GfMyoTtIJeTw0I8IuV/ki71XSjLkMtkSHPFjnIplT2SyiXW3/as
	 lllZFxfNn1HUqPE+clDLcHTp8uU/apR5q5pohnfitHI7kK+oSM/o1O6RxoxuE+agybao3
	 0He28ufskb5AKyYERNUGgYvVK0Ik21FT95SUkod2Hf4JN4q1sPVC61yaikrQbpPRvMT/h
	 I0ow6uIFPG4c1Ibl1d4/rruABxbxp1js/LP67L+CLgEi9J2q6P+f6M74YM6Fe24QDxQr4
	 VrmTJN3ydv2Zh+z8V/1zNzU1z7cv536jhyX7v/ylVSr0hKUt6aSv/aWj7Fj7BmjZqGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:In-Reply-To:
	 Mime-Version:References:Message-ID:Date:Subject:From:To:Cc:
	 Content-Type;
	bh=o/kOhyN2ooFYx8Pst2gddYQu9Aw2TL0sBUfCDuxPOOQ=;
	b=fzSj2FaSXWO9I9GJyuaBdKVY85VvAUtMD7B2+YuaVCTzM+YPEeqD+MdjPXFNXGMwimRM
	 z0JpzsllUzZ8wr28NK2cJqLs/lRDXnSaLIT1ekBvaRjNFS0i1m6Ud7vylv1ND/GHp8Tgt
	 2rwMELBxKyf9tNAIO+/4MohMA+XmCV1Wlg76rZ8DjWOr0W0Z9T28iM+qKC9SPMgAOTr6w
	 uexwIXAOg6OWAL8A93RPixAWqG5zisjA5UNcq7a9Q9ABs6mTYzraBsLYfSYbIAgGPqY49
	 VdgFXPJcpkTC+HzXL/hsODhpXZ2qo5ZzOzStuy2n+wZmtce7cE55vFgRFrA22jFAdNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HjMV6rni;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F722606A334
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F722606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HjMV6rni
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3662e7a9299so2918366eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 07:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793806881; x=1794411681; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:date:message-id:references
         :mime-version:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o/kOhyN2ooFYx8Pst2gddYQu9Aw2TL0sBUfCDuxPOOQ=;
        b=HjMV6rnirPdJA5id8UtVqWjrEqOxCFYgbInEUndmQBG9IGwqDf4eKd2nUhUcDuBa3W
         naoBjcrkRW9gQf1MgmsEvth6cdjetKsDsXk5XwDhxNum0s1qFMPG5+ilvaSzEQ+xZYwY
         Tv84bFqfYa5rKy+gTZBe0bSqag2Uj/m70AJqsib5x6i3m9jVMzOnLwUHLDlB5N/Yy0bM
         XL/iW1TkDGelxrI33iHoh2+RTycqt68eYKdYqnBam82nBZdAnsI5QqyOYER9lr7Q8Uol
         5fCr82D46xBT1klUloOTTCg1G6OOxhv2vXv4GNihAsw8nlvpL4SA20uZbSuQ4dPVuriQ
         4jHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806881; x=1794411681;
        h=content-type:cc:to:from:subject:date:message-id:references
         :mime-version:in-reply-to:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o/kOhyN2ooFYx8Pst2gddYQu9Aw2TL0sBUfCDuxPOOQ=;
        b=jTqFABBJWOombFVosdzlL0wo8r9ykiiP5RHanWy00H6jTzuT3H2fjEZg0p16x5ldVH
         6cHle4Vrd2m+8TkwEdtVPVxyv0AZvITS9BOoIYXjEB1UB3i0ojJm6Bx1c/6I+Pinq8zv
         jNbv3cjc3jNpFgsKRMfNKIYEGqgxNXHpVmn1qMFgxtjVmNkmyRVK2nhILEP3OGwYwmKQ
         HZiyT4a8MM7IHcWEll0bpdpR1PuHOShhZND2PFLc9jNozYUd5jOTreX8OcJS2+2RnPX0
         JL2QJwenfBLZjITXBKf8pX4lhO/oD9HbURLaup6F96y+tw28lpradEXxr0ZzZArdPE53
         iRWw==
X-Forwarded-Encrypted: i=1; AKwUvBwI9gnS/0ZKHxcuj0M2ANq64r8U/O+UOGXrij5s6I3e2Q0JOTEm8LVPiwLsH2wis2zuTsdf7cY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uP+hSnCVAi1GyxZ0y1NEm8VU+VKxMChHU3u7YaQl2G8UcjkL7
	s1vXY0JgssRozqWk/qA662YE53I7fKznvIbOefEblcRDDBBvzbPiNHdv9b2+sboApcCta7CAGSo
	O8b5vzN1GxMh+Irhwb5m1Nl95Jg==
X-Received: from dycmb18-n2.prod.google.com ([2002:a05:693c:20d2:20b0:359:198a:8046])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:3d06:b0:358:eccb:af7c with SMTP id 5a478bee46e88-36a42404840mr35928950eec.33.1793806880735;
 Wed, 04 Nov 2026 07:41:20 -0800 (PST)
In-Reply-To: <20261103235152.1904727-5-sdf@fomichev.me>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103235152.1904727-1-sdf@fomichev.me> <20261103235152.1904727-5-sdf@fomichev.me>
Message-ID: <18e4e1daa184cadc.3137322e32382e36372e3935.ceab9.0000sendgmr@google.com>
Date: Wed, 04 Nov 2026 15:41:20 +0000
Subject: Re: [PATCH net-next v2 4/7] net: devmem: add a per-device netmem TX
 frag size limit
From: Mina Almasry <almasrymina@google.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@kernel.org, 
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	sdf@fomichev.me, almasrymina@google.com, bobbyeshleman@meta.com, 
	asml.silence@gmail.com, razor@blackwall.org, daniel@iogearbox.net, 
	leitao@debian.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 3, 2026 at 3:51 PM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
>
> Devmem TX frags are bounded only by the net_iov size, which is about
> to grow up to 2MB, more than some devices can describe in a single TX
> descriptor.
>
> Add netmem_tx_max_frag_size, U32_MAX by default, and cap devmem TX
> frags to the limit of the device the binding is attached to.
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  Documentation/networking/net_cachelines/net_device.rst | 1 +
>  Documentation/networking/netmem.rst                    | 6 ++++++
>  include/linux/netdevice.h                              | 2 ++
>  net/core/datagram.c                                    | 1 +
>  net/core/dev.c                                         | 1 +
>  net/core/devmem.c                                      | 1 +
>  net/core/devmem.h                                      | 1 +
>  7 files changed, 13 insertions(+)
>
...
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 3ac700d37e59..ba2f887dcd39 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -12350,6 +12350,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>         dev->gro_ipv4_max_size = GRO_LEGACY_MAX_SIZE;
>         dev->tso_max_size = TSO_LEGACY_MAX_SIZE;
>         dev->tso_max_segs = TSO_MAX_SEGS;
> +       dev->netmem_tx_max_frag_size = U32_MAX;

I wonder if netmem_tx_max_frag_size should default to PAGE_SIZE instead
of U32_MAX, and have drivers opt in by raising it after verification
(e.g. SZ_32K for bnxt and U32_MAX for mlx5 in this series)?

With U32_MAX as the default, large frags are enabled on all NETMEM_TX
drivers unless they opt out. For example, fbnic also has a 16-bit TX
descriptor length (FBNIC_TWD_LEN_MASK) and only avoids hitting
dma_error here because its tso_max_size happens to be 64KB today, and
gve hasn't been tested with >PAGE_SIZE devmem TX frags yet. Defaulting
to PAGE_SIZE (similar to tso_max_size = TSO_LEGACY_MAX_SIZE above) seems
safer for existing and future drivers.
