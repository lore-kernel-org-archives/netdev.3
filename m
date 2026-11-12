Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474940;
	b=hnovrGIPDTOJXBUdcqWKQDC/tx1tvKgBLw3aPdp/q2XjQU/Ils0hf5k7ZHrWvCe+cT9N
	 vJn8DerfZJAP7HDtvZMkqg1AzykET7LC/wrpEt+7SDQ9ZTymytZUx2FyX0A9A5JWGld4A
	 fc+EIzb6fUybInc4xZPBDzO4RAL/8RBIQzccQ7zEps5nony7NTYcyj0tJxbFaUN/m3ZvQ
	 nKM9ecx/0Atus2T48S4WtHoVytWZOl/YXejIUJUnZxM6JdxyoBe9VWFx/PPNzVDIoCp0v
	 dlRxzudV9HNG35R2cOyQfx2lmVzkNqemLtN0g3U1kOediW327NlEm1A5jMdm3CoCN1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474940;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=in0wT3kSv8v4L0CNiG/ZIgaYFBbYCntKXbAs/Vd5cP4=;
	b=wkoqTnxwaY3XL1CsQYM8uPcOcwUTPHV/LkTBuss3sOC56PxyEJtg62UXN3lkzQe9WNAC
	 iqn0jMBqsAP1Qc/VuSjH9M/mXhzcBTJVJ+qwOaxoZ89oUOo/G0BJyP7SdPsGUIaJmRIBD
	 Rrg7jw3rJhHpg5SaWlwO7by5sZFIl8wVv56G9o7/YQVCLWZMpgRKYv1OaFx5cLCL/Blaw
	 LuVysG4mxLxdMnLRBaSwVijjcuWrUcAaNPI95raj1q0eDn3EaD999jgQDc1uXitu0gXFT
	 j8CmQiBuBX+r8W4P6/hbu91lTTY+ghcUtM8GZRApn9VIqDWIAiKvbHLRBWstwDSrpRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aMuTvq3q;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RBjixnsW;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0D6606A8A8
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B0D6606A8A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aMuTvq3q;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RBjixnsW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794474938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=in0wT3kSv8v4L0CNiG/ZIgaYFBbYCntKXbAs/Vd5cP4=;
	b=aMuTvq3qIoH43sv+1a7P8mAUyk7hzIxGncQhFZS7l5317fpGTaPqEkVvZk8AEWtDZgKSf/
	TaUUy3y1dNhIVRxz2oO0WwtmwY2WePLpuTTo+D0BoeK6BYN8YQ/YcUyZS/yDPgRp54OsGX
	Tk62qEa3stwnAzxKVZq2EX1rI2opIuU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-3EkoEd5dPYi5SMJXSKJpjA-1; Thu, 12 Nov 2026 04:15:37 -0500
X-MC-Unique: 3EkoEd5dPYi5SMJXSKJpjA-1
X-Mimecast-MFC-AGG-ID: 3EkoEd5dPYi5SMJXSKJpjA_1794474936
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-492425d771bso2544114f8f.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794474936; x=1795079736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=in0wT3kSv8v4L0CNiG/ZIgaYFBbYCntKXbAs/Vd5cP4=;
        b=RBjixnsW08WSzYaCIeMMgfDMxPNjBHIl29W/hMUL87tEOBmVisUX3PMetALgCVp1OX
         TZbZ1VfJRXWZ8BFWFchwd7tgIJoXRAMZ1nRX5repU5Q31o9xRq0O705WrzyZCRzxWddb
         YzmuGdP+BRePNQ1n67DeI4eA92tJVnyS+DaC8eQoIrM/soc8PR2bRDqAqpO4lWc9OeBY
         c5+uNuKmNSGznIGKIs8ZALZpia3CJOVSRzKC0zetFO/gA8PKmjmviNBxx4Fe7zOqIGOM
         D98ld0NhCtGmG7X8A60u7hB2G3VvOiQYhEqVBCgco8EMqeWC5jtGqCnPUtPrqYNvdkS7
         AcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794474936; x=1795079736;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=in0wT3kSv8v4L0CNiG/ZIgaYFBbYCntKXbAs/Vd5cP4=;
        b=OeJ0OjS+dJumZGgcZwE4Komks/l3+6rXAm9WcCvRMihlcp6UU4cPoM/z/VO1df3cWV
         2mtPnrLlwaRg1omy4d/T051KCWYRO502ese98c9MmbywiQT9ikaYnlYoxzR8KaABgbL5
         //NKPQWG/+F12tbrDnmEZaF7zbVjunr+5VxoTHYevp3UmbUaQm4WoCoTWdcUSaKaGt7B
         s4snmv+E0jSeKzF+fXR/3+B3BQrYI2NjKn4KuF8Wh4JikWm0dHElgmpvb/YLjEjr4RzH
         5qtNpSMqTeOL+DsYFZLoyxhsG74Dxum8BcxTIg0+0w6MnZ4sGSxaIWbjnHqfo6Pnc5ZH
         aY+g==
X-Forwarded-Encrypted: i=1; AL+hErGiIqP4gaKBt3RUJlE0gTjZ0jxYcPCPoH24LVz0/TfcLhv6dnKLU47Y7rC1Zz4PgaNSBmF+yvg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+u6wp9sUaCMAes8ANWcWveTgpROenGvHg/17YZqH26DKoPiZxB
	L+vv5dymYh49jy0VUrYdLm17Dosh4k1H+exjcIzCnCdejRor6XwRN0biJzLpVjVxOQ1J6D684hr
	WkKe5Kgrgn7jysbq1lQ+vTFJW/i9N10VSxkuMJXwmyeT9p0l5YiTg/+w+LLTfAWrTXA==
X-Gm-Gg: AYBFou1ySuuUkRXMdLFa/mcDexei481jdlzFdBha844AkO/CnK3utCkGyfo0FajjI1j
	iel7lKl9vYhoS4GIsvuool0lSbk7QTUBfycHwDaB0cd/a6x+6NdUfS+fPeinOzy/Abf6d0Fe4+N
	Bir8fpSex4jEZ3Dxl1uPmUH+qciHSvl7wmeCs9GtcfB9y/B5inZVZ2QVI+NfCANSKA7wbrVJVdE
	/Lq7SicsOdXSVMA1sg7yBNa3blwp5oKn2xSebOm+O1rgLFPTjekdqkHnGr5zoTCWsFun4Z40tqG
	i5Z9aRi96h5iruEUJ2qnMWEagJ715eDYf60rvuev206+dsrOC99aafZu3oHF6ebzhP59CTkTrZw
	x4La7Yazdfu228Sfcz55x2QLySP/+4jbUm+C3abdyFA==
X-Received: by 2002:a05:6000:4b13:b0:487:88b:4681 with SMTP id ffacd0b85a97d-499c6027597mr7970523f8f.10.1794474935549;
        Thu, 12 Nov 2026 01:15:35 -0800 (PST)
X-Received: by 2002:a05:6000:4b13:b0:487:88b:4681 with SMTP id ffacd0b85a97d-499c6027597mr7970448f8f.10.1794474934931;
        Thu, 12 Nov 2026 01:15:34 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498361f674fsm15808324f8f.33.2026.11.12.01.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 01:15:34 -0800 (PST)
Date: Thu, 12 Nov 2026 04:15:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vhost: set dirty log bits without pinning pages on
 x86
Message-ID: <20261112040926-mutt-send-email-mst@kernel.org>
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
> +static bool set_bit_to_user_fast(int nr, void __user *addr)
> +{
> +	u8 __user *p = addr;
> +	u8 old;
> +	int retries = 4;
> +	bool success = false;
> +
> +	/*
> +	 * log_write() passes a byte address and a bit number in [0, 7].
> +	 * On x86, update just that byte to avoid crossing a page boundary.
> +	 * Bound retries so a contended byte cannot hold up the worker.
> +	 */
> +	pagefault_disable();
> +	if (!user_access_begin(p, sizeof(*p)))
> +		goto out;
> +	unsafe_get_user(old, p, fault);
> +	do {
> +		if (unsafe_try_cmpxchg_user(p, &old, old | BIT(nr), fault)) {
> +			success = true;
> +			break;
> +		}
> +	} while (--retries);
> +fault:
> +	user_access_end();
> +out:
> +	pagefault_enable();
> +	return success;
> +}

Yes we wanted this for the longest time!
But can we use the nice scoped_user_rw_access API?
Something like:


        pagefault_disable();
        scoped_user_rw_access(p, efault) {
                unsafe_get_user(old, p, efault);
                do {
                        if (unsafe_try_cmpxchg_user(p, &old, old | BIT(nr), efault)) {
                                success = true;
                                break;
                        }
                } while (--retries);
        }
        pagefault_enable();
        return success;
efault:
        pagefault_enable();
        return false;


maybe?



> +#else
> +static bool set_bit_to_user_fast(int nr, void __user *addr)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_X86 */
> +
> +static int set_bit_to_user(int nr, void __user *addr)
> +{
> +	if (set_bit_to_user_fast(nr, addr))
> +		return 0;
> +	/* Resolve faults, or use the native bit layout on other architectures. */
> +	return set_bit_to_user_slow(nr, addr);
> +}
> +
>  static int log_write(void __user *log_base,
>  		     u64 write_address, u64 write_length)
>  {
> -- 
> 2.43.0

