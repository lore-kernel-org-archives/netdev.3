Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548835;
	b=ahEXdC43wfdH5iz9DmA1XFRtSU+Pi5ojiM8dhm60Xo/OFDnUKVEgEAfU1fT3po2VVJco
	 FwAC0Sc/gPhZVMRAm07Gt3L3SollXtLD6CjBdME69cyANetLV+asZQi0gzlAwGCJ78DJW
	 wLrvmBO+w8qVtpogbd8U8lotSekzR94UQ/kS3kzw/Vow7MH0jpdVYv+doxNv7qBdXSQfq
	 7Hip17efZp/Z/ivuPNYrKaHL2KKtDJ9Xb6r4vQtafOkgzScb0Lj8obN9GEnwPfwdinktn
	 XykqqeBbDFrzrm4aQsf/fC037grVx9O22/STppuofn6h5SJRsCti/lgG0i8v6L2BSfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548835;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zv2dwLznTDzlBwaiBmqu3E6e2BGNnEevgfuztfawCII=;
	b=WS6O9b4LC/P/1uRD1c3+RsiDYTtxgfT2GMO9fD4oNdaLyeJZkyZ/v3YqXUN2x3Ac3CkZ
	 xACm69sskJinDr7bR8jAb4wP/ZbYaWGuwiIvP6TyaGI/MpK9uSpsPFw5NBtm2yVLD9yME
	 q/yO4XpPIA1MuRKzJhG/S5rE/+I1QcVxI06v1OHYJjgzaj+v3Qh4OZFKyIW+ZYTfmD2Xz
	 41tnJPd2H6pxTcVlL8/IzZM4fHzmw4WBJA7blh1DR1rNW2YXm91d0MhGuBBxtm+njbD2w
	 4yuSutrCxcPmHjjfv73cjvMKPdeQ4+8q8UlXFjHajysl6pjDgkOR9XCNVa6Mm4Ps5Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VRUCH7A5;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kx1EArwl;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC07606A32A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 05:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AC07606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VRUCH7A5;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kx1EArwl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794548834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zv2dwLznTDzlBwaiBmqu3E6e2BGNnEevgfuztfawCII=;
	b=VRUCH7A5X78vBeGc4sinXweIdZJAKlJNpCa8Q5iygIZvcOEPjsSKMqHjuxZ6yboEcksUdh
	OXrtExEugR2k++cly4qmaSRDbnib4bWwCkvhyge9NN3NY5KrlYwh20lMTQ2zvayYTHCGnv
	QWNa+h+tPcYgmKhmd8Y0i7haQUgzCVw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-f4yYyxLKP2Ccy44oIYXNBA-1; Fri, 13 Nov 2026 00:47:11 -0500
X-MC-Unique: f4yYyxLKP2Ccy44oIYXNBA-1
X-Mimecast-MFC-AGG-ID: f4yYyxLKP2Ccy44oIYXNBA_1794548831
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4ba078abd70so3037665e9.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 21:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794548830; x=1795153630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zv2dwLznTDzlBwaiBmqu3E6e2BGNnEevgfuztfawCII=;
        b=kx1EArwlWeE8EHOxBgI15kP3cZxEl//llm1cQIwT7cDh7jWtmu3m2q0brkuk/prvYz
         JhWxGgYXB1//jimEFovyYIE2JZNEkjitFvGb6ikeZ2Y1DvpIK3oIri74V/n5EFpgFqhr
         4gQVpTxgkquuYNINLUTwwlktc/9U3+uO5UxloCMCJrkHFAyaTxdTtGcnR0j7IuNz+nBw
         MJo5e6X86q0q+87qEovDHKxKSVJhc1zoWLvJUEV4FasPY9pyZ82KmI56nXqFMG2QfGvF
         P98/+Y3/xkRf45BZzsXUCdaGcBGFQdyueHSRkJDqmbTR3G7hXtO94Vbaf3ufrkyzsnaf
         rl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794548830; x=1795153630;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zv2dwLznTDzlBwaiBmqu3E6e2BGNnEevgfuztfawCII=;
        b=zjqLh5WIpbMoPHfO5QO2IHKXNoDSnsCfVI6G2fj30kx7B9IR3Bus8sbDp7dmAT9zsb
         GidX5C14jJp4NOihFDJEtx+0jDktJPddP+HlAhdxz5o1PKcQm4eOXxGavuE2DFdjIR8Q
         p5nfg/oPRZ/s2vOUcp4S+IujB/Bwc8ZGGASmgpUoLfRaWzETtipWjMVp02j5CGtEiyV4
         ggEEAzArxY33JWWzWZNSrizrD8liODZArF0GME1GvNOw8VLosxe0IDrmh44E3psDKghh
         +6X9k3S3to6RFurGL+x1RRCpA7KBzrCBkk/MeNzpjpn0OJHFyRTsq1+WqBrWTLe1cDQF
         e3iA==
X-Forwarded-Encrypted: i=1; AL+hErGUn3254sCB+xHkCC6qsZNe/oU52J3gy0/sFKCKDqTOKXhjyMGaqT0hirGK9fiHVQ4sSuFztGk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/eHv29fOdodN6D5LTUH1yfMfQoHgOesEB9zBmzeIikmz12TJV
	JmGkrikYBfvlLgVV5cg2SdeCp8hADZYLl3DtQ13NSQtkUadRW5c7EInHvqMd831EXgOD3mNCyCp
	/SG2lqy2qGtmcakqXL5CecQgaN6KWoIHwF0WHHJgaWTHL9q6ReMKO9sz5pg==
X-Gm-Gg: AYBFou0XSsfHQrmjNKJDvqcFOrCwxXimXN0Piq+JeKR4uNQLopl9nLVDCs15V/rKgMO
	tIlaXq1wviR2Sks3PxD6w2b9QOyiEM9LKN6QNMnGSDYsE3Z4syrDTUvpvTlhMzJhCIBynRvpA9J
	MzrIkatuVTvDFk4a81GnUFBVZP/PhAWSMxvluDBurVAMBpVypbl/rc3uv9tiPRMKUg1E82hiE/X
	s3w7NC7RdsIpq9Ui9LU8DjUqHjb3KvOyckTqyPiAHIRrWZZRNYTM976aZ/sUMoHBa5Z7DDJIH1a
	+scFP0v0KV01yuieruIlirzRwCmHh4TcJjEdDpiiNQcz28gO682ttZGKnuvLDBdZfmOXEvpisPG
	GjOLYEJeX9NhGKiTvxWK8AyTCyzsprpjnWpNq8oq08w==
X-Received: by 2002:a05:600c:4685:b0:4a6:eca1:7d5c with SMTP id 5b1f17b1804b1-4bb55a91e31mr25254795e9.32.1794548830555;
        Thu, 12 Nov 2026 21:47:10 -0800 (PST)
X-Received: by 2002:a05:600c:4685:b0:4a6:eca1:7d5c with SMTP id 5b1f17b1804b1-4bb55a91e31mr25254505e9.32.1794548829900;
        Thu, 12 Nov 2026 21:47:09 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm122130755e9.15.2026.11.12.21.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:47:09 -0800 (PST)
Date: Fri, 13 Nov 2026 00:47:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: bp@alien8.de, dave.hansen@linux.intel.com, eperezma@redhat.com,
	hpa@zytor.com, jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	netdev@vger.kernel.org, tglx@kernel.org,
	virtualization@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH RFC] vhost: set dirty log bits without pinning pages on
 x86
Message-ID: <20261113004435-mutt-send-email-mst@kernel.org>
References: <af7f05bf637337d35fdd10f3e0dbb5e39d7780e7.1794480795.git.mst@redhat.com>
 <20261113012937.40818-1-zhaoguohan@kylinos.cn>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113012937.40818-1-zhaoguohan@kylinos.cn>

On Fri, Nov 13, 2026 at 09:29:37AM +0800, zhaoguohan@kylinos.cn wrote:
> On Thu, Nov 12, 2026 at 05:53:47AM -0500, Michael S. Tsirkin wrote:
> > vhost had a TODO to replace page pinning with a version
> > of set_bit that works on userspace memory, since forever.
> >
> > It is really best to avoid GUP on fast path entirely.
> > Implement set_user_bit and use it in vhost, to do just that.
> [...]
> > lightly tested. pls test and resubmit with your tool.
> 
> Thanks, this is much simpler than my version. Two comments on
> set_bit_user() before I resubmit:
> 
> > +	int __err = 0;							\
> > +	__uaccess_begin();						\
> > +	asm volatile("\n"						\
> > +		     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"		\
> > +		     "2:\n"						\
> > +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
> > +					   %[errout])			\
> > +		     : [errout] "=r" (__err),				\
> > +		       [ptr] "+m" (*(u8 __user *)(addr))		\
> 
> errout is only written on the fixup path, so it needs "+r", as in
> __try_cmpxchg_user_asm(). With "=r" gcc drops the initialisation; here
> (gcc 13.3, x86_64_defconfig) it even shares a register with mask:
> 
>      1a3:	lock or %dl,(%rax)
>      1a9:	test   %edx,%edx
>      1ab:	jne    1bd <log_write+0x5d>
>      ...
>      1bd:	mov    $0xfffffff2,%eax
> 
> so every call returns -EFAULT, and log_write() stops after the first
> page.
> 
> > +	__uaccess_begin();						\
> 
> No access_ok() here. vhost checks the log range when it is set up

exactly

> and
> I couldn't find a way around that, but GUP used to reject kernel
> addresses by itself. user_access_begin() would keep the check (and the
> nospec barrier) local.

What we *definitely* don't want is nospec on fast path.

> Something like this, build-tested on x86_64 and
> i386 only:
> 
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -597,19 +597,23 @@ _label:									\
>  /* set_bit() on a byte of user memory; returns -EFAULT on fault. */
>  #define set_bit_user(nr, addr)					\
>  ({									\
> -	int __err = 0;							\
> -	__uaccess_begin();						\
> -	asm volatile("\n"						\
> -		     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"		\
> -		     "2:\n"						\
> -		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
> -					   %[errout])			\
> -		     : [errout] "=r" (__err),				\
> -		       [ptr] "+m" (*(u8 __user *)(addr))		\
> -		     : [mask] "q" ((unsigned char)BIT(nr))		\
> -		     : "memory", "cc");				\
> -	__uaccess_end();						\
> -	__err ? -EFAULT : 0;						\
> +	u8 __user *__p = (addr);					\
> +	int __err = -EFAULT;						\
> +	if (user_access_begin(__p, sizeof(*__p))) {			\
> +		__err = 0;						\
> +		asm volatile("\n"					\
> +			     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"	\
> +			     "2:\n"					\
> +			     _ASM_EXTABLE_TYPE_REG(1b, 2b,		\
> +						   EX_TYPE_EFAULT_REG,	\
> +						   %[errout])		\
> +			     : [errout] "+r" (__err),			\
> +			       [ptr] "+m" (*__p)			\
> +			     : [mask] "q" ((unsigned char)BIT(nr))	\
> +			     : "memory", "cc");			\
> +		user_access_end();					\
> +	}								\
> +	__err;								\
>  })
>  
>  /*
> 
> If this looks right, I'll fold it in, run my test in a VM and resubmit
> with the test as a second patch.
> 
> Thanks,
> Khan


Given the point is to optimize this code, let's optimize.
vhost pre-validates addresses so accesses are safe without
re-checking later.


-- 
MST

