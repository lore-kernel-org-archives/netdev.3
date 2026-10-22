Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792660140;
	b=ZzgLMEwy+eMNv6eQscviv692KMMs4/YnaWV0ARVFB6/yoyReSqzdWw6sFDe5Nz3FxOCg
	 uSrYrN8/gpAdcDgzLzexwAPqPGlCUMP/abHfpIIAPdIZBN4OUBrmhlwFj4PmXIsqSXbXq
	 E+xxyAClStgVlKX71ED1AlG8C2k00PkFM7R43wkM2N/PrKFMWzmlObQlUh1DSarKkXkYp
	 5Ig4FthZ9JIfJcgdDQa4IMQ18dgKUUnq/q4/W1pefGRRde1OQ2DKa0fPtRDYXJdKlBBYJ
	 VI0tkSxMn6ehhS2V0UUO2cxC2lfkgqnjxChKcyLOIiciXybS5ZQ334IW+nDbMYrAicg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=x1gSHT1c/ki0I3qgcb+mFwc26qJiBmIOj6KoD3ALLCc=;
	b=bwzP4nDrDKsSbdiEy5AucAbZG/X0sL2wZ5wyBTVKojXUKhb8nKqsQqLXMSz3bziugiDj
	 9JrwAhzx3W0SxykaDByyqM3dW2+Dpk/szTvTYNqMVTuCNos1B/gFT93AU9PcMY06ogxsS
	 b6fvR00mSRZyeIgAWFhXXdQVPMrcgKAbwKCIg+Z3ApFFowFiU6i7IhL5Q0daCs9jembFX
	 mWx96lRVgbPg6S1wKM1N+FArRGzpx6V86RyBqP9gsq6tnu5W9fSMFAlUAMul9Q0LW24SO
	 Hb/p82r/C6oV+EQQEy2/4FjAlVlfefe5rvYMqR/LjYbEZFB315KgE/85G3fnzAVKLKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YmGQigzz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C6F606A333
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52C6F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YmGQigzz
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e985106c0cso12973335ad.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792660140; cv=none;
        d=google.com; s=arc-20260327;
        b=hN6huQ3RT0EU7Utn04acdW2uTbyMT0S0+Dysu9Ljb5C3EBIhU/DcYvk6pAmirVCr5v
         u5/LT/3vz4/wYfcMoJoCv65QG7VUKf3ryLiacn5x4Zl7I2cbpRr8ux1hSdlYg7vk4x3D
         XhHJjt0KLd7LU1UiuAZx16F4fGzMmIMMoMFh0rwc0SIRui4Xn2AwcroUgO9q7dlLHvz/
         AM+Ss1XTlLzf7WeoLSHDxjsxolcUk5l6vEGWHfr9VaXurKziFS9cxuCzqj/MwJiiVIML
         S+3VmPpmHsNd8wUVMX8w4Lp7XFbfLmZp2P8kUGOLT842BcM1LBGhJsnGHkCW3J7S8dgF
         8KPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x1gSHT1c/ki0I3qgcb+mFwc26qJiBmIOj6KoD3ALLCc=;
        fh=ygR8cQklBaTHyX7tttNtWArSJ+7fHGeSprGWou1iGAs=;
        b=Yl0oZT0lk/8XA4IRKgwis2bxFJa366YyaWzIHx+sWwMVDQB2YH6Zg7XGReXFjPS7QF
         dMc57oy6TUTQuGgkejpnyLgOE+mbJ0xWp16G9cPUl+R6vCGvO5PFAZYFri2kyJBOw3nQ
         k+MCC+ACIoK9i2UweJShafdVoz9y9R1zDoLsTaCZx8r0o1lEToJ3LjIlF3WJYaiBFVjG
         vsiaWOnP3jDujwiAPb8X6VB1bc8XtZR0SsWg9au+KUiUIe0t3q+9GH2Cb8Tk1CtYTRCE
         ieZykTbpdCPQ5GP4GUqJmQt8wHo9FHgG/OpWrlPIv+z5USPQeiRDW36Djb3/m2LdVApA
         42Gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660140; x=1793264940; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x1gSHT1c/ki0I3qgcb+mFwc26qJiBmIOj6KoD3ALLCc=;
        b=YmGQigzzpNxmz09qXtRdiVAK3ae/6WkZsxqw93zZJtYIX++tGjQia/CgPAiM4TBa+r
         ptWQx78OluWSJywzHD7RbDxl5Pzxv6pMtJWxp1qYj+33zQyeQKIT6dvH31zerqn+chQl
         Zv7Ccf1j8QvsEl44BzYNZGlQ7UXEa7qkl/AfERI46VlWCKNo+jMqDm1vkaRKv8OD8Fmb
         nm76IU69MfG9g5BT9EfFjkOa5N5DKX3PJLzP0A4Jjh0X2pvMnyznwwy5kZAMks4loUUg
         pNWCi8zUVH2BZiAnbbx4cePPbTezwl1AYgHm6ak3DK7Tb9/5BE4Jttw8gxlYiMsNYCoI
         yo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660140; x=1793264940;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x1gSHT1c/ki0I3qgcb+mFwc26qJiBmIOj6KoD3ALLCc=;
        b=mfqp4mvDoeur8n80/KinqkgfH8jloOmAEUV4sxd6UNhTwXb9s9K17bxuX6JqlfTjM5
         fgesUx4GpHWSBAbHVqTEHoZqn4T4P3JpBGJvPq0aEdEGlPm5GxxjgO0FPKRXUN2vxPjO
         eUXduHJfgqRQdIXaFCSeKogI5KNeDoabQy5EdhOUzO9YeAQBuPD5+INUEoiJmEqmi8iw
         ENuFWrLZvdN2gGsVoPyMvdxyYCNe8dRPLY0Z3Cov0FXY/ilL5Ra0dFZUHz176EyhOfjJ
         Z1ssEQh3C/MgQN9SzZjFibcbMaz5QO8P3+jPWi0AFc37i9+PuGJf18XTwZMpD3BkC0D/
         ksaA==
X-Gm-Message-State: AFq9FYKfInygK9m4b7Z1f4rAFqbhF1BI2Hwxy7Thx6amlGqILnBtJacf
	MoPfxdxfAs0iQb+ROXHC5o5IQiRIlJWiD//4PwB14/uX/+Q5Mel++UWkyNXjS/eMvNWdgrCsFle
	ZBf3HY6P1D+uPu6ZwuLLRGVSMNRj/9WE=
X-Gm-Gg: AYBFou10X8MpVUNeqO8GQDWZ1mmz/HQkhfvgF3s+hvsZZjqGDSKy4wmn/zn6RjVHWm2
	g2/tf5oQjAmBeov599gYF86/GqFT7t3fhJ77rST4LKRugy4kYfJ31m6eVRaXEiLV72xgW9L/7az
	OTN9b9mmx30fa9WIIlCHdhOx8aLzriZJbgfqFIzeg0X4Xeqete/qg4uMqX7SaRBduJk4Qo2pHns
	r/dh4Qe6HpISNxoMwWdoKrGlPhe3D7f4TW7En+cakxLLNmAzkVhwowNBTC2QvKeFQYe4a5gXf2q
	GSczHEdhVSpNcjevh3AIa5Qq4nw9TV8RDl571Lh6e1/mQKFdnzryIKc4XcJvtGf2oJkzDH3nDRf
	v4AVlXU+pEDkvNjW89nsKMR2DmWpHLiKk+TeHd8I=
X-Received: by 2002:a17:903:324d:b0:2e8:8637:5e3 with SMTP id
 d9443c01a7336-2ea43ca9b18mr41320045ad.34.1792660139775; Thu, 22 Oct 2026
 02:08:59 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792654486.git.zhilinz@nebusec.ai> <d2b51708a3ada3b12b986224ee8340ca7ef5b3be.1792654486.git.zhilinz@nebusec.ai>
In-Reply-To: <d2b51708a3ada3b12b986224ee8340ca7ef5b3be.1792654486.git.zhilinz@nebusec.ai>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 22 Oct 2026 12:08:47 +0300
X-Gm-Features: AclHuK8matChSdrnMT5vbHsjOJ36t5qQf1YuHOVEVae9bK9_y35Mye5KmB-ETCM
Message-ID: <CAJ8uoz0PTUVOTk5LV+LrP4tL-bEiVoKX4jL_V5nQcvSzk=Msew@mail.gmail.com>
Subject: Re: [PATCH net 1/1] xsk: validate consumer ring producer index
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Oct 2026 at 11:04, Zhiling Zou <zhilinz@nebusec.ai> wrote:
>
> __xskq_cons_peek() trusts the userspace-controlled producer index without
> checking that the producer-consumer distance fits in the ring. In
> __xp_alloc(), an invalid fill descriptor is consumed one at a time until
> the cached producer is reached. A one-entry ring with an invalid address
> and a forged producer index can therefore keep the kernel in this loop
> for billions of iterations in receive context.
>
> Treat producer values beyond the ring capacity as an empty queue.

Thanks for spotting this. If someone intentionally messes with the
ring state, it is ok if they get no traffic through. The important
thing is that the kernel does not get affected negatively.

 Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> This
> bounds the consumer to the userspace-provided ring size and prevents the
> long loop.
>
> Fixes: c5ed924b54c8 ("xsk: Simplify the consumer ring access functions")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://bugtracker.nebusec.ai/f/13760
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
>  net/xdp/xsk_queue.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 1bc42c8902f4b..315b656534749 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -344,6 +344,9 @@ static inline void __xskq_cons_peek(struct xsk_queue *q)
>  {
>         /* Refresh the local pointer */
>         q->cached_prod = smp_load_acquire(&q->ring->producer);  /* C, matches B */
> +       /* A malformed producer must not make us consume beyond the ring. */
> +       if (q->cached_prod - q->cached_cons > q->nentries)
> +               q->cached_prod = q->cached_cons;
>  }
>
>  static inline void xskq_cons_get_entries(struct xsk_queue *q)
>
