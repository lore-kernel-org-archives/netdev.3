Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478216;
	b=zMXQl8mCp1zgdUZFr7TGGRzqHuIedN7lgrSTKUctnSDwo0byRUpu2VDP5SulrQaKW3I0
	 q6On/n8a1Nr2OGT+LL4EDIUFE8UJDiaSSvcyBUvwQxsRC8MsktBDiWh42TuX80JI/PAK/
	 WM4gYeFoi9cbpfZReats6SIpSPCRzYdrvW8/PZmpIqeYnhYOndojDr+rihu9u6SzZAPGH
	 nPX9XzXpkN0t1w0vZ97uRaxIOQPpeaHvWF21A+jDgSOLNl5ukBEMnAvzdtS/lLO5d7u0/
	 f+FcAr//P5Zq/AmZlHELqqnDS6w4V7I33cdxnq47lXkLwZOc+DLBXLATncR7uUJRSmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478216;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dZQUAiljUbxO/eu4TRCEfrOqVOK81+mbOuXnFblvr+8=;
	b=QVvmTT1KvnHYGALTW0iCy6iAHscQVq8Ay8nTgpaq/ewwfEivCYJFlWH4P7kgdTxF/E0U
	 XfHqkhxAhMV1QY3bu7k36QTWXuUNQqjddxhqUblVdyets9FEa4lQGstpXhpFLrEZzU4i9
	 v+eyKhTayriZDbW66/ab55LqlBL5/nXy1/ydpeI/gmYMOhb8Y0g381CFyU0HHm++vCinw
	 z3tcBMilE6PtMxX7lsvgZFfBHXQLcAFIRqTF4A633FslXTO1aAMRY/9ogFwOxMrt0SZye
	 UpG5ceNNYfnFX0Th2TM30o18RLr0joQZY33snNfroceqruw5l+qd2FBZAoM1jvvrdsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UHqj5YET;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="ZZS/98e7";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D4606A33B
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 992D4606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UHqj5YET;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZZS/98e7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794478214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZQUAiljUbxO/eu4TRCEfrOqVOK81+mbOuXnFblvr+8=;
	b=UHqj5YETfBVyn4EcerJJtZE/utyXAw79ljkIEUeQ97SO2RhRExGzee7X6rkK9XrrC1IuFB
	sfKLrC0ydDxdWFQjYBaAD+N+hV3Ft/wP/gzuhfOKrq6BGfcV29Ygw6edk/4c3BbwRjbIUl
	+iu22/syzObHQxCp7uNNGW1eWjTWR0Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-yHxr2LBwO5uYtbzswiwW8Q-1; Thu, 12 Nov 2026 05:10:13 -0500
X-MC-Unique: yHxr2LBwO5uYtbzswiwW8Q-1
X-Mimecast-MFC-AGG-ID: yHxr2LBwO5uYtbzswiwW8Q_1794478211
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a16dc2323cso33527895e9.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 02:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794478211; x=1795083011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dZQUAiljUbxO/eu4TRCEfrOqVOK81+mbOuXnFblvr+8=;
        b=ZZS/98e7hTzHTSGfkOQMtdtVMwRHf5R7ryuR7PCPA2eB8uSBpyDzPAsYTDUrE8c1s7
         6Bbcw7gA0UnCboWXBGHyBwOAEpWX7QNbRNZKReLPknfCZLjPGuvHRe/GlpozugwnC4r+
         ckxIBN40YsOOfEKk9gs+W21PqXpi5M0XTINP/tW0/SGXqbDKWTDy1Yv2u25fvFiBXzqL
         ZauUIgbHEEHf3ys0/Hr37zfwpFJu4rue8u3BAwHjL+wS6nMjReXaWeWspg7NzFyHeZas
         dKncXM1E+AtVPk9wxpke/tfyEod4k7XIGOfYDxW7wVQ2XtDXCAvM8gSCxGQyHWvT6f5n
         RR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794478211; x=1795083011;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dZQUAiljUbxO/eu4TRCEfrOqVOK81+mbOuXnFblvr+8=;
        b=ctu7Ok8mH3C1vNKbfyfXKFCJJtovVDFMgxhk2ZHsnxIFkpW2RrGEwE3ea5xVWTh1O5
         lZdwVOicnGKYAzxj6peDiPjlBuDTQxu4HFY26C2XbgDGaMyZNr8ZFbQKKbn5SWNd/zdH
         fTZqij3s2IUP5gbVeSkZbYsxB9TC0RyBP7qRAyZIKAhfaDKmXqAsi6Y340SCIP7SlHEx
         JJ/l46mSwuWP5+ssZe4N1RPRNKQe+JlLKAR+zdFFDJJg5+m9c3c4lmFvZkJnwKQsxLay
         ykS4q1owDc1JtDwf7AMmvcaE0EnkhtvpwoqxRxEk3E57DNltaAAISSaZC4LZtyxJojao
         KqSA==
X-Forwarded-Encrypted: i=1; AL+hErGxh5/JMFJVLXqbl3AgZcwQbLyoPDrGNsPq6GLQTJkSya6MArX4XVAYubkrRvOnri1brNekpJ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8PPMTTYzOt1FPztO1MzbfjvZXlZR3SN4+SLh54dA6HIvX2knFL
	j8xvj2Qz7xd5fe0G8Le1WdhVUhMs+tC2xr8nDnmYJazOjme30IztrBl0AFl3imPvbZ2ZniVcuVe
	QP526UnF8yeP7KgLMEYu/r//OPvLem26g2YdYc/KiYWvVfMax4QFmTTvsgw==
X-Gm-Gg: AYBFou3jRe5hfLB6GuYQ/JtaYZE6Nm+r4QvvGfLcjyJrKwzLlIaOpnabtCHgW1g9DW6
	jsaabFALlGI4do7w+Nu2ZjtStqTLFMm7In81EJFX7hZM5T7Pv+VgDi/wyn2tkmruJPTFJM4d06R
	1Zb/RiyTDum+iNEN74a6WCKs8D8NWxykafwzMfi9DxwHALVfTT4wRzJCrwoQyntaymNM/BnZZxv
	tkEAiCcgbnEXFHlfhX8B269gnmLotxVU7Sb2oOXTm82QD8JkdNXwKcZqHDM+EYHfJjwZzI4axOx
	hnwrD1edihpattaruJw+tijIh7bMgwfxLCTki1H7CR4gJpEpz/OYCVxBrsT+4F6/hhFW32sxnlY
	rdLRd17AfxX0iGkfTAsgvcScpCrlTfAVPVyrUU5AnnQ==
X-Received: by 2002:a05:600c:6214:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4ba0939815cmr87754375e9.34.1794478210553;
        Thu, 12 Nov 2026 02:10:10 -0800 (PST)
X-Received: by 2002:a05:600c:6214:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4ba0939815cmr87753625e9.34.1794478209938;
        Thu, 12 Nov 2026 02:10:09 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365cbfc6sm16943454f8f.41.2026.11.12.02.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:10:08 -0800 (PST)
Date: Thu, 12 Nov 2026 05:10:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vhost: set dirty log bits without pinning pages on
 x86
Message-ID: <20261112045853-mutt-send-email-mst@kernel.org>
References: <20261112085631.128819-1-zhaoguohan@kylinos.cn>
 <20261112085631.128819-2-zhaoguohan@kylinos.cn>
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
In-Reply-To: <20261112085631.128819-2-zhaoguohan@kylinos.cn>

On Thu, Nov 12, 2026 at 04:56:30PM +0800, zhaoguohan@kylinos.cn wrote:
> From: Khan Zhao <zhaoguohan@kylinos.cn>
> 
> set_bit_to_user() pins the log page with pin_user_pages_fast(), maps it
> with kmap_atomic(), sets one bit and then unpins the page and marks it
> dirty. This runs for every bit set in the dirty log, e.g. on each used
> ring update while logging is enabled for live migration.
> 
> log_write() always passes a byte address and a bit number in [0, 7], so
> the update can be done as a byte-sized cmpxchg on the user address. On
> x86, try that first using unsafe_try_cmpxchg_user() inside a
> user_access_begin()/user_access_end() section with page faults disabled.
> If the access faults (page not present, read-only or needing COW), or
> the cmpxchg loses to concurrent updates of the same byte four times in
> a row, fall back to the existing pin/kmap/set_bit path, which can fault
> the page in.
> 
> unsafe_try_cmpxchg_user() is only implemented on x86, so other
> architectures keep using the existing path.
> 
> On an x86_64 KVM guest (i7-12800HX host), a synthetic used-ring
> workload with logging enabled went from 243.60 to 171.11 ns per
> descriptor, averaged over five alternating runs. This is the
> end-to-end cost per descriptor, not live migration performance.
> 
> Signed-off-by: Khan Zhao <zhaoguohan@kylinos.cn>
> ---
>  drivers/vhost/vhost.c | 50 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index e29f154706da..9c3045504709 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2527,11 +2527,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_ioctl);
>  
> -/* TODO: This is really inefficient.  We need something like get_user()
> - * (instruction directly accesses the data, with an exception table entry
> - * returning -EFAULT). See Documentation/arch/x86/exception-tables.rst.
> - */
> -static int set_bit_to_user(int nr, void __user *addr)
> +static int set_bit_to_user_slow(int nr, void __user *addr)
>  {
>  	unsigned long log = (unsigned long)addr;
>  	struct page *page;
> @@ -2550,6 +2546,50 @@ static int set_bit_to_user(int nr, void __user *addr)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_X86

Wait this is x86 specific anyway? So let's just implement it
properly, why do we need all these hacks?

I run a quick test on this in a VM, feel free to reuse:

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>



diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233e..3ed49c91a7434 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -594,6 +594,23 @@ _label:									\
 	__ret;								\
 							})
 
+#define set_bit_user(nr, addr)					\
+({									\
+	int __err = 0;							\
+	__uaccess_begin();						\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "btsb %[bit], %[ptr]\n"		\
+		     "2:\n"						\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
+					   %[errout])			\
+		     : [errout] "=r" (__err),				\
+		       [ptr] "+m" (*(u8 __user *)(addr))		\
+		     : [bit] "r" ((unsigned int)(nr))			\
+		     : "memory", "cc");				\
+	__uaccess_end();						\
+	__err ? -EFAULT : 0;						\
+})
+
 /*
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.

