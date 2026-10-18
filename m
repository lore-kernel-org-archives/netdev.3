Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8835F5E3
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359704; cv=none; b=rQYEgWjBEj2m4HlPZ1DmdRrhleMotjbQqJJdCf5mgoerEqDo1lZLaUqDwkT5pXiLdvSM7U/c+zNr0JpGXu7wIejjR0L64bYg7qVOYgweGsVinPR9rcbSsRTy/eYb/f289EN34nv91/5C//UWkU/NhnIkLWP0iq/YNGNRXDlE32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359704; c=relaxed/simple;
	bh=QpgY1mHMPAh+BF52MMdR/jItFN7LZuBUhKsHUTs7ZxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwD+gXh7FZeHui71OffKvVsWH1Ti3ZManQmtYMrCSjN5NeScCHIjQ2JVxqC7bV4y6eukAFXUPzxpXJEdUdQNqDMoCsg7Kt5tDefNnrjF4fPQcwB+mEZ08eqU5xDyywkX3u5RI8D7lAA+2Wkz+Z9kMl94YJ32/bnHYmzebDFtVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9rqkEOi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=okZBJI/E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9rqkEOi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="okZBJI/E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792359701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R2sM3UmHiQ62epsC/FE3R8schNmhPjjNgAmVVqxJiF8=;
	b=Q9rqkEOicmke1USFq2SC8SiG3etUwMkfXp2AFV3Gj1L2V4FbCKvTaYj744wOrHoWfMXbrM
	fiuRje/90szZxI40jNFr9hpd+EcC66yLFgqJupMNy70qQnMYRfwq5mRag9Gf3PhyDSl+ZC
	GaedyEnj7CciBYMyXvIT4btEPplblDw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-3mx9FHKEO1O63crUeuz8vQ-1; Sun, 18 Oct 2026 21:41:39 +0000
X-MC-Unique: 3mx9FHKEO1O63crUeuz8vQ-1
X-Mimecast-MFC-AGG-ID: 3mx9FHKEO1O63crUeuz8vQ_1792359698
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1df6c2937so10214095e9.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792359698; x=1792964498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R2sM3UmHiQ62epsC/FE3R8schNmhPjjNgAmVVqxJiF8=;
        b=okZBJI/Es/jSsi48kQOtMvp+hrjgpPCUuLiqAZg2lI8YZnCRcpJOc69w5k7FI0sMWx
         cpil5UJKPTGaY9mNLgqs2RJpxWLjOk7p0juNQFK7cwstRrIxSeqmeF+zEVpTQM/V+xqB
         Z+ZdfhTzIbEtxCpuBKHDV0rM2f/8zAdff/ltUuUgAdQ0QuZime02I2RdzsOHTgmCKEsQ
         n7/PqsVU4WpF2GoXhg9Fio+lYK4O2ykbeZ37ug5p8g4d0PLIjrYhDBLDay2xdPfSPWSp
         zlyrwrv6j2PVqZYOkNQA/DubKuM/Ls3+6Eb2/e1xOSCYOB7fp77ofOb6Vl1wLtYLIsEP
         MIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359698; x=1792964498;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R2sM3UmHiQ62epsC/FE3R8schNmhPjjNgAmVVqxJiF8=;
        b=W/68jMRQgeVH6yILvTYaOUxTTbfgRJkpFVyGeizovRXy6tJ/U7NU+fbGg/rlV8Nscg
         QG3kwj3MuiDkytGuCqyDFd0e7btViojNmgIXwEAgnJ94TEMtVBRSFmW4QDXLiMn25ZsA
         Qbkjb/YcYkPwvSjUqK6diFAs82+H2rGoVe0hESTigpmPIeLcW0q+6oiGdpMPCkl/jF1x
         ATjodppVz7ZYWXz9XYHBqjJPzIFxhEe/a1kwkqLYwy9L5QK1taQwXgVCBlF3MnYXOkGR
         khEoakqdJ9ulD/KypHwK6JSqyXhedyc3mmXT4qXSRr54Hwaj5dW5KZdDiN44eM9cKZlB
         EImw==
X-Forwarded-Encrypted: i=1; AKwUvBzV8YTxOMt8R4E3z1kxWGkHoxQAm+9lFCjrDcvsr4gTSW0PoFEtaDhtD3xWWfpL1lKZ0wYrESE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXacmIJJC7nHahSWixg2o9day+a/sGtngUe2rEggEgtz62LAzE
	LstV2oLKVqnrTMvCjJsmNEJkuIt18RSWY6NHy1hTi6zA4Jy4/4rzqtG9udLCFxf15LSvelzFilw
	WYIfLWiz1yaVxJFs5VLtWDT2Sz7f0oZ0rDMRgXGEeHOEdyeETc5UXoGUw6w==
X-Gm-Gg: AYBFou1RFrFybopPoJLtmf8twn9qfeEEVZ03fGvsM9SBeuRgQi6Z0ctcBLLANY/GZgf
	fNAooyzce3hjOWv6FNoay/MLWhDX1UEOx+UViaLaGQ+G+fHaWyexPx43MXQsiEVaa6HX56dLypJ
	bJCjRfV6zZkwPYUIbNI/cEzFLxKdxhnWXwrab93iDmzXSuUTSjCRjr04J9kedqlG6R4cu5kn4Er
	TWwhPRonXqIeZ6SiFQKjpSSethg0H3bMQi4Ol1Hfj6MmLM5acxdpuIbyBLwTVspqjGnMfnVDy2O
	gXpHYv4wfXdhDj3NtQg0+W/Nc6zKaAewOvjkPAGKGrvt0gQ9iaMx1ugslvzmy4Nj+Jam1Q==
X-Received: by 2002:a05:600c:8709:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4a1d760536cmr116501175e9.13.1792359698233;
        Sun, 18 Oct 2026 14:41:38 -0700 (PDT)
X-Received: by 2002:a05:600c:8709:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4a1d760536cmr116500815e9.13.1792359697712;
        Sun, 18 Oct 2026 14:41:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e9423f20sm12734705e9.7.2026.10.18.14.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:41:37 -0700 (PDT)
Date: Sun, 18 Oct 2026 17:41:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, eperezma@redhat.com,
	linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018174010-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <CAHk-=wjxOy24XQnSSGimnHbp9mVjUETBE5HrS+W9E8mRrtxBLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjxOy24XQnSSGimnHbp9mVjUETBE5HrS+W9E8mRrtxBLw@mail.gmail.com>

On Sun, Oct 18, 2026 at 11:11:44AM -1000, Linus Torvalds wrote:
> On Sun, 18 Oct 2026 at 10:34, Linus Torvalds
> <torvalds@linuxfoundation.org> wrote:
> >
> > And __get_user() together with access_ok() is actively wrong and
> > stupid. It's slower, bigger, and more bug-prone than just using
> > "get_user()".
> 
> Btw, if you have *multiple* accesses to the same structure, that was a
> historical reason to use access_ok() with multiple __get_user() calls.
> 
> But it's not a useful pattern today - and hasn't been for years -
> because the real cost is not the access_ok(), but the stac/clac that
> surrounds __get_user() on modern hardware.
> 
> If performance is really crticial, the new "unsafe_get_user()" model
> is the way to go.

Thanks! I'll try to find the time to look into converting vhost to that.
The flood of ai found bugs I am dealing with will abate any day now.
Any... day... now...

> Here's an UNTESTED example patch of how to do a conversion. It
> generates much better code than __get_user() ever did. That patch
> looks good to me, but again: I didn't actually *test* it (and the
> reason this signal.c code has never been updated to the modern pattern
> is that it really doesn't matter for performance - I decided to use it
> as an example not because it matters, but because it's a good example
> code-sequence for the legacy model conversion).
> 
> Somebody should test it.
> 
>                      Linus

>  kernel/signal.c | 56 ++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 30 insertions(+), 26 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index d31ebcb6ed4d..0fd1296e912b 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -4776,12 +4776,12 @@ SYSCALL_DEFINE3(sigaction, int, sig,
>  
>  	if (act) {
>  		old_sigset_t mask;
> -		if (!access_ok(act, sizeof(*act)) ||
> -		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
> -		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer) ||
> -		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
> -		    __get_user(mask, &act->sa_mask))
> -			return -EFAULT;
> +		scoped_user_read_access(act, Efault) {
> +			unsafe_get_user(new_ka.sa.sa_handler, &act->sa_handler, Efault);
> +			unsafe_get_user(new_ka.sa.sa_restorer, &act->sa_restorer, Efault);
> +			unsafe_get_user(new_ka.sa.sa_flags, &act->sa_flags, Efault);
> +			unsafe_get_user(mask, &act->sa_mask, Efault);
> +		}
>  #ifdef __ARCH_HAS_KA_RESTORER
>  		new_ka.ka_restorer = NULL;
>  #endif
> @@ -4791,15 +4791,18 @@ SYSCALL_DEFINE3(sigaction, int, sig,
>  	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>  
>  	if (!ret && oact) {
> -		if (!access_ok(oact, sizeof(*oact)) ||
> -		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
> -		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer) ||
> -		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
> -		    __put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask))
> -			return -EFAULT;
> +		scoped_user_write_access(act, Efault) {
> +			unsafe_put_user(old_ka.sa.sa_handler, &oact->sa_handler, Efault);
> +			unsafe_put_user(old_ka.sa.sa_restorer, &oact->sa_restorer, Efault);
> +			unsafe_put_user(old_ka.sa.sa_flags, &oact->sa_flags, Efault);
> +			unsafe_put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask, Efault);
> +		}
>  	}
>  
>  	return ret;
> +
> +Efault:
> +	return -EFAULT;
>  }
>  #endif
>  #ifdef CONFIG_COMPAT_OLD_SIGACTION
> @@ -4813,12 +4816,12 @@ COMPAT_SYSCALL_DEFINE3(sigaction, int, sig,
>  	compat_uptr_t handler, restorer;
>  
>  	if (act) {
> -		if (!access_ok(act, sizeof(*act)) ||
> -		    __get_user(handler, &act->sa_handler) ||
> -		    __get_user(restorer, &act->sa_restorer) ||
> -		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
> -		    __get_user(mask, &act->sa_mask))
> -			return -EFAULT;
> +		scoped_user_read_access(act, Efault) {
> +			unsafe_get_user(handler, &act->sa_handler, Efault);
> +			unsafe_get_user(restorer, &act->sa_restorer, Efault);
> +			unsafe_get_user(new_ka.sa.sa_flags, &act->sa_flags, Efault);
> +			unsafe_get_user(mask, &act->sa_mask, Efault);
> +		}
>  
>  #ifdef __ARCH_HAS_KA_RESTORER
>  		new_ka.ka_restorer = NULL;
> @@ -4831,16 +4834,17 @@ COMPAT_SYSCALL_DEFINE3(sigaction, int, sig,
>  	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>  
>  	if (!ret && oact) {
> -		if (!access_ok(oact, sizeof(*oact)) ||
> -		    __put_user(ptr_to_compat(old_ka.sa.sa_handler),
> -			       &oact->sa_handler) ||
> -		    __put_user(ptr_to_compat(old_ka.sa.sa_restorer),
> -			       &oact->sa_restorer) ||
> -		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
> -		    __put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask))
> -			return -EFAULT;
> +		scoped_user_write_access(act, Efault) {
> +			unsafe_put_user(ptr_to_compat(old_ka.sa.sa_handler), &oact->sa_handler, Efault);
> +			unsafe_put_user(ptr_to_compat(old_ka.sa.sa_restorer), &oact->sa_restorer, Efault);
> +			unsafe_put_user(old_ka.sa.sa_flags, &oact->sa_flags, Efault);
> +			unsafe_put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask, Efault);
> +		}
>  	}
>  	return ret;
> +
> +Efault:
> +	return -EFAULT;
>  }
>  #endif
>  

