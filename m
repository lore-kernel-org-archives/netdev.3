Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577906;
	b=gMpUNratWse+rXmGtq/us/ts7Dg/VukvlQwSMMNW9RbgmzYMITg7yWUaWbS+PB73KpBe
	 3cTDk8pkgsIC24uV4mhgjWj03By1Z/kayUcelBlvTenXuWIGVSVpr++tgNSe+Y5P1qPQ2
	 WXgxXZc042OXsrizjiRlTZkknENfIaamwEhPOSiBkbYEVEBH+F6hRh4ihGs9MXqEq+bV/
	 PrWAuuCSTsUzZRukPZ8tQqLTbCFbMqXyclo9SokZYDRJCpwXEaY6feSFbP8yc2fu1eLLR
	 9+oa5kqaZIMTAlcLxZ+7la9il2xAmmnABU5w9JqK9wBBYdS+vUBaIZxYxEsiRdk20Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577906;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nzwVW9fNWfGXZUemLc1dTW/hhZ3xpHtCMfznCyx8mPI=;
	b=LcwWA4gn0OPytWmr/YmkNg9ISNYImxmBXef8jHeIy7qppv/uBAet96VsvcAcE0ts73tX
	 rHKQjCr6LnndDNSikMgGYjFarik8LyLuCwiwQI89o6ozw8kKJAYwlwD8CJO/fz+d2u4Ng
	 p4KxbI0uqgpnFIUX5AX0K+yEgsC0KerqLIJ8rLZznCYnGYKvon7rZ553UMRV0DKIFJNBg
	 vv8Ndmw+89jT5qhRFkn30ODffTyKlWv4lJLNrnPk8VvtLFEmxtf6rEyvqViieyg9+hHig
	 VXrxWu3al7ePjacB0JpaM4TAjr5XwddHDwXdbTcGqLd9z35u0DWWGbwX5xqq7CjfW1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PquMVjty;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ECIV4Jho;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258DA606A88A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 258DA606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PquMVjty;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ECIV4Jho
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794577905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nzwVW9fNWfGXZUemLc1dTW/hhZ3xpHtCMfznCyx8mPI=;
	b=PquMVjtyZGfGYCr47ArvAw10Sx6XB1xjzp0Gz0SxHI8qWIFs80PQfh1xTcp4QHWjyKVu2g
	ysiGasak4ZP6CZkD9riBMfdwJ6fkwRcbc/cmQa9nrDb/CSlWsAJ3FGmmrtlZkFxNO+vfCj
	vjUaX5eIoNlUZBmyfUDOniWrUznGHQE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-OuLLWOS9N-yud_FWrdpAUg-1; Fri, 13 Nov 2026 08:51:43 -0500
X-MC-Unique: OuLLWOS9N-yud_FWrdpAUg-1
X-Mimecast-MFC-AGG-ID: OuLLWOS9N-yud_FWrdpAUg_1794577903
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4930269afdcso656364f8f.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 05:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794577903; x=1795182703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nzwVW9fNWfGXZUemLc1dTW/hhZ3xpHtCMfznCyx8mPI=;
        b=ECIV4JhoLU17HxPiNt/9IPbToz1Q9M0ZMdWYEbZF9dgHjBSqYjxBItkMJAdLrPIE/w
         9BaD9t99NeGPTSEuqAjus0I82h25o5EZpJtv8S6OvmXtCHTII9YNlxhqt80ejg7M4lPi
         jZaF+6TL4ftJXcnFmrSq+VQarvnvLHKzO38cnffKeUram4D6URkhgK1jKnUwQTBTzSlU
         VeS7ckUEYdgPXhCeZImkQ00tqQl3oG5kq2SXvcapUP2MG3X/gBOHnnM5VZuw7aMAYeeq
         g3W+5Gi/OaaFPtqtZWWkPntCnpw7El38l8SDggJY8npS4m1ealjIDpCzWcOZ9aj0b6i+
         mx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577903; x=1795182703;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nzwVW9fNWfGXZUemLc1dTW/hhZ3xpHtCMfznCyx8mPI=;
        b=bfYdZzYxsd4KNsFUJVKHfJ7uCZ9HBQN7t7xE34k494Zoh9ZDTFvf2dD9SNY6Hfueda
         2UeRCbMXAXK8OvqLmwcqaXqHBDJbCQIOe3sBiXJaGGzKA67LedCdLNJelJQmD9hj0Y5B
         8gcW4oiy6W5a5Osga8cg19SKloJV3ovjRBNel3R3uwojcbDF0QvYvSVRmLUFsjfX3ghs
         cNcWQ7nANDxnQMsOsXim+SQWP7Z2QVcToxJR+jsLmZ9VCN1Rd6zQlUrVFQ3BSDLXOpjO
         nQyTqx512Qz7CcnWbjGG/W8Vqx9hWhR4GWdQr0/vbxhdXmn9JmSm16k02yHaZFRS9Skv
         qWwA==
X-Forwarded-Encrypted: i=1; AL+hErHYZNu+qlNlejN+eXfJmhe5bZqaoKH+EGv/TrIO4jDwS0HVZ3IOXWAu4izmvBb3TwxdSaSe028=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ki1WY/Hc6DTQ9v1QKH5Y06OKM/LRhf1MJfsvVKfE1XjlM20l/
	aAwI91MdROFpic1X7wEbRbDngxQrigndCnoKbvMF7MPwaw/UeRJG5sC/rfnqRvaGa89ums3fKiZ
	8rsHjqHqc8hgt7yOI2yMuOLkH7oe0ZMxPr0FlbmgHwEq7hd1RUs90womM4A==
X-Gm-Gg: AYBFou336XtiQDJixDsMv5AwpIma6l1vChg5hp15vQ0RUIMnY1E4fhgTdqSIBLAS09A
	zzlmhtveLLFKOEXCe7VW7VevYNryPPAPG5KKSpd/lXkB0Gjm61zhnKU25KgZ4YcqY/W0skFOC5Y
	S0X75L+7YgSEdX0F3xuV/NUOB3ZmysnuUQLndiX79qwWVUlcMyxVeV9fX1xPjqohpgvJ9HPPGrI
	BrouPY9zokWuc/2tj+bCpccUlAZI2Z3BylLXLwLo8dWWE1hvq5L2VSp+kPJ5U4lWYWgCQ3JxBvK
	kUFObWKfcEwM8cai7ME3ZXYcC9jkuBWttZZTO7j9UUC/v4U1mp1pJmQd/58WAIrGV2N6wEq6AB2
	bGU34+N+AFVd6/Rv1EEgZw0WfjRkH4b4Jr47L+1Dd+g==
X-Received: by 2002:a05:600c:c16d:b0:4ba:495c:2f5d with SMTP id 5b1f17b1804b1-4bb55a3e3f0mr51424455e9.9.1794577902496;
        Fri, 13 Nov 2026 05:51:42 -0800 (PST)
X-Received: by 2002:a05:600c:c16d:b0:4ba:495c:2f5d with SMTP id 5b1f17b1804b1-4bb55a3e3f0mr51423795e9.9.1794577901867;
        Fri, 13 Nov 2026 05:51:41 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5667a8aesm42328895e9.1.2026.11.13.05.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:51:40 -0800 (PST)
Date: Fri, 13 Nov 2026 08:51:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: bp@alien8.de, dave.hansen@linux.intel.com, eperezma@redhat.com,
	hpa@zytor.com, jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	netdev@vger.kernel.org, tglx@kernel.org,
	virtualization@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH RFC] vhost: set dirty log bits without pinning pages on
 x86
Message-ID: <20261113083351-mutt-send-email-mst@kernel.org>
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
> No access_ok() here. vhost checks the log range when it is set up and
> I couldn't find a way around that, but GUP used to reject kernel
> addresses by itself. user_access_begin() would keep the check (and the
> nospec barrier) local. Something like this, build-tested on x86_64 and
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


So, you were right, it's better to check access. But I don't like
paying nospec. Let's use the modern scoped accessors?
Like this maybe? Very lightly tested, no time today, sorry.
If you want to use it:

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>



diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233e..0bffa43e02179 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -594,6 +594,28 @@ _label:									\
 	__ret;								\
 							})
 
+/* set_bit() on a byte of user memory; returns -EFAULT on fault. */
+#define set_bit_user(nr, addr)					\
+({									\
+	int __err = -EFAULT;						\
+	u8 __user *__p = (addr);					\
+	scoped_user_rw_access(__p, efault) {				\
+		__err = 0;						\
+		asm volatile("\n"					\
+			     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"	\
+			     "2:\n"					\
+			     _ASM_EXTABLE_TYPE_REG(1b, 2b,			\
+						   EX_TYPE_EFAULT_REG,	\
+						   %[errout])		\
+			     : [errout] "+r" (__err),			\
+			       [ptr] "+m" (*__p)			\
+			     : [mask] "q" ((unsigned char)BIT(nr))	\
+			     : "memory", "cc");				\
+	}								\
+efault:									\
+	__err;								\
+})
+
 /*
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.

