Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFB92DB78B
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252647; cv=none; b=ojnNmsoPRtgbZMYvFXmBE8vuAb/Aj104CTBSp2Caqxx3BjaGqPBu9RJb02taIfvy2KLZ2lrfX/0ZDqHmwDRKNh0qbn9uvgbzbV8n4br7nQH5DoR+RHFpwUNXDeoNOha4UGdJFvqhNj3FjlIVwmMhOK62V4mNGL7/NT+fcx/bQK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252647; c=relaxed/simple;
	bh=E3k2KFJC5Kpsm6RrzIJ+HVsT6arOOMIj3f9XyiLwGyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMydv379C9UfKGPxptCdygfRwmizrSWSSn3hgOq6gPuPMPLckj9/8hsVMYjmk80dnE6E30vb1WINptrB37Wf/ThaaB98NV7tssXzfSvbCQcH1O5x9mBDh7Zju6tFqjV8bbwvbiv6jQ4KaXRz47gJks2C1B0stDiwciX1Ju6cInI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=O2uZqZfg; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="O2uZqZfg"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so2871329b3a.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 08:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785252644; x=1785857444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8kJyeGI8L3V0IAqYou544rNxKptwzjPjr8r5SGNglkM=;
        b=O2uZqZfgf+sd5fsPlL2h/Xl98ojHJuNivT6paXrqyz+XHEnoJKovfQRt57lSMmqpGa
         EGdh7eQpH2lKnmespmvvhdQWocJDavCxH6E/bX67qjPG+5sh8yBVwJEHhP+QUhQu83u3
         0XIU4WnCByCHMBKAwJ8DQwoHnF7M+QH5FDjMttybkrh0672gce4GzM8r9jaMR8jnwDkt
         bDjzhtoVPUgEdluuM/GMWM5SZUNES4cmdJX5CegTCDGO5TRkAxL032pcx7q/F8fFKXuz
         NOXYCsZ4f1aqslShFMZqdhEM4139/fVmFemA0HuW9YR+RQVGm0uOWlkmfxX5FK9p3+bd
         1tLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785252644; x=1785857444;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8kJyeGI8L3V0IAqYou544rNxKptwzjPjr8r5SGNglkM=;
        b=Hk513YPVX0x0dMlC99NhROVDTOzHO4ybu+B4rVnPSRPl+Ui/HX2iME9nNw0QVTST06
         C/gVfQBv9/LyHirU8xdJbtCAXhBbhaLkBVDX7JGe+qAojw9B4OrnA0oICQhYql0ULf6s
         ap8k14dUutzaUp8g8ZfuoLzMe4ec2ii/h/EjmOWn8sl1E2PkwkMhLIXJv+Iotp9v3f5/
         18RBMm92A4H0Hlx/TibLdxrZF10lQLcunsWqAtksCF04oFptV/+7Oy0dhok2ArYFh/qh
         J50pZFS/nhcW3voa6SzHAWP+1OsMfpnRIMJHK5e55bR4wxja0WoKjrcaJpjcb0KEEEb0
         luBw==
X-Forwarded-Encrypted: i=1; AHgh+RpldeWV4LrxxavVYpAeQV7u0ofQ7zkWS1fEAXGtOpSOuDay83Og0498yXmvcRQhPGtD0pEvsd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzKLNozcXWVOE3TX6JgaHycvDb3WCTOfSRcffUcSusiMyejh+q
	uLis8c89Y7IoNzv7Wyq41NspobUMHTX/zXDHyvVgeCcgQ1xZgHsj2V3EOSFQ6q1NQJQ=
X-Gm-Gg: AR+sD10FqGc/itWguIlh1nQSIrIb0UuMRKbSf9HgnQDzQAegGwY2mjN1FTcd8aDM/IS
	eIZ/g28Hw4VexkdNydBcLCP2BqUL38umHGDjy6z4yR3alMrgNVokfoclB/bXjfPcIVAxXuOssnO
	KyMGxPitJ7C9yN6jc3Mll3PSJsbpdDiNABE/rfI82A83m8mKkgHZSNX5GHQ/g8JxmOpsN8ckYRG
	7v8YqmsPLHTydvdkCfkrrmkduoonUBdhWPyQt1qB3/RVHsIKXy/+SP+nGQsZyUnuuX5LHKDKDKP
	I3NmLJc6tpYkRN55fcp/quXMgbKvRHPfqvchW785q/AaHNv132jbN/3qCwsBFyLJCy9tQArFC9W
	QGzxTWNFZfvApQ7ryGtD96qrkf5Z4kMAnW+laDO4QuBXQB89kuXlUWpLPlR0=
X-Received: by 2002:a05:6a00:4c8d:b0:848:8715:c2cd with SMTP id d2e1a72fcca58-84e933add88mr3388843b3a.47.1785252644148;
        Tue, 28 Jul 2026 08:30:44 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0301b3csm97521b3a.34.2026.07.28.08.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:30:43 -0700 (PDT)
Date: Tue, 28 Jul 2026 08:30:42 -0700
From: Joe Damato <joe@dama.to>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, stefanha@redhat.com,
	mst@redhat.com, will@kernel.org, ralf@mandelbit.com,
	viro@zeniv.linux.org.uk, kuniyu@google.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	13667453960@163.com, stable@vger.kernel.org
Subject: Re: [PATCH] net: datagram: fix integer overflow in
 zerocopy_sg_from_iter
Message-ID: <amjLIvXcwsret4qR@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jiangshan Yi <yijiangshan@kylinos.cn>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, stefanha@redhat.com, mst@redhat.com,
	will@kernel.org, ralf@mandelbit.com, viro@zeniv.linux.org.uk,
	kuniyu@google.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, 13667453960@163.com, stable@vger.kernel.org
References: <20260728064235.337877-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728064235.337877-1-yijiangshan@kylinos.cn>

On Tue, Jul 28, 2026 at 02:42:35PM +0800, Jiangshan Yi wrote:
> zerocopy_sg_from_iter() computes the copy length as:
> 
>   copy = min_t(int, skb_headlen(skb), iov_iter_count(from));
> 
> iov_iter_count() returns size_t.  When it exceeds INT_MAX (e.g. via
> io_uring provided buffers), the int cast wraps negative, wins the min()

idk I looked at the code and it looks to be capped at INT_MAX, so i'm not sure
that the io_uring example could ever happen ?

I think the commit message misstates what is actually possible

> comparison, and the negative copy propagates into
> skb_copy_datagram_from_iter(), which can trigger WARN_ON or corrupt
> data.
> 
> Use min_t(size_t, ...) so the comparison is done in the correct type.
> The result is always <= skb_headlen(skb), which fits in int.
> Fixes: 3a654f975bf9 ("new helpers: skb_copy_datagram_from_iter() and zerocopy_sg_from_iter()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  net/core/datagram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index c285c6465923..fd8e17d25a3d 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -783,7 +783,7 @@ EXPORT_SYMBOL(__zerocopy_sg_from_iter);
>   */
>  int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *from)
>  {
> -	int copy = min_t(int, skb_headlen(skb), iov_iter_count(from));
> +	int copy = min_t(size_t, skb_headlen(skb), iov_iter_count(from));

I don't get this.

Wouldn't copy need to also be a size_t to be consistent with the general
"idea" of this patch ?

If you leave copy as an int aren't you just shifting the alleged overflow to
the assignment ?

Even if you changed copy to a size_t then.....

>  
>  	/* copy up to skb headlen */
>  	if (skb_copy_datagram_from_iter(skb, 0, from, copy))

this would still be a problem because len here is an int ?

I feel like if you really wanna fix this you would have to use min3 or
something instead of min_t ?

But, I'd probably just leave it and not propose a patch to change this at all.
