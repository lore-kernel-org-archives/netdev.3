Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477061;
	b=1YpNQuvVBAfttCLRCdaXPkYif8jE5tmcv92M1wmnN3152qgHVl4XHp7KqQsFm8AHvHV1
	 lGJwTZS89MjsraenYaC0nTSfcJtmZFd2B1TlbK0AveJBmJQGBH1YIm/RhUlbD8yK32SEH
	 YbVWaOVf/SQJUgzW2Z7RorwmyNd89jnlEkXZUaMImhYnQ/6ZjWoYK8GqRYI1svmiegvFN
	 mftYpbE3m09wuMS+PnEsKIDKxkmaYWwZpr/7sV3WF0JKrwY28CvcDYgekQATPQg4cXLd9
	 V0+BUKz51LMBisTcWCczYW9FYr+wOiyB/n2ytQWuaZjf1/gtklQsQzfnJ1KbPyhQkZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477061;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PWjpZTISxAW1ioWo7zAlKfMSm3zMo7GsaFnXjvMiMuw=;
	b=T7eLHjpCEcZuJ2s3rDQ4rpiCckHoI8mdwIT14cIfMWPAWHTvkyjsPnB0wdukiVi+LfK5
	 qcfUC0dtdUkPP7GN5syxLvCEZ9ulsTFd5Z2sDzUr1JEnoYVXiTRO99rsqjWtSNWh0WWw+
	 WSVJJ095eRP9R+vOIZIRFj8ObtRLej4yAaZzar4qXdUTwtI7IdsOQcyBUVMPB9lrJjCXe
	 9J7m6WXpuKqsSu4fM/Cg21sQ/TLaO66J2PYpBhSPZF+MA0BVh1LagSZEvyTAJsf+QzVIi
	 tlYnqWEA2Nk/G9uRSjW3fMBHiFW0HK7XusvgJhx+fvn1AuxQfDOqVXnm9senysiJs7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RXWiPM9g;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KXyVzv0L;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666D3606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 666D3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RXWiPM9g;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KXyVzv0L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794477060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWjpZTISxAW1ioWo7zAlKfMSm3zMo7GsaFnXjvMiMuw=;
	b=RXWiPM9glKt8c84teQV76D3GrDKVCOBLB6mn2I1ijFJCQb4OMmrlLDFWCcFqryVtl+9qRw
	S3cfhJCt406aNjQazTVjoMN1ShBkX16QufH020lkNxDnsh6+qRCYZrayYpANo3TONKVu6z
	RBoTMv3PIYpNxhWQR2LTSjOAj9vwT1o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-D5RkwmI5OzieIFQDSDHFwA-1; Thu, 12 Nov 2026 04:50:58 -0500
X-MC-Unique: D5RkwmI5OzieIFQDSDHFwA-1
X-Mimecast-MFC-AGG-ID: D5RkwmI5OzieIFQDSDHFwA_1794477058
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-490a0e72578so3003677f8f.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794477057; x=1795081857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PWjpZTISxAW1ioWo7zAlKfMSm3zMo7GsaFnXjvMiMuw=;
        b=KXyVzv0La1EfoYmGOSDKursoJv+qB7cu2AJUrUEF+n8lT7MCegQ6v5eAFLcMOoxTDA
         MIRxwqu8JNwlXDP9IIP+vlCNr6Dyyn8ppqi1Wl9Rfiux8jDryy5qgvsyQugg59ylrxbV
         CtfS2Kx1304JWpicaWTxUB/Ts31PlHSunJAL973MX6sviRV4hGudIt80nYsG8MndH9Z3
         licU8sniPAMzlXmxntNJUNxafI5BH28UZlvgsEDW4ahZMUvlXPSDv7JKT8mTbNhhYcoJ
         GKVvDaiv4Kjv3WLys74kpWVx1O0MY5pZBYpNmC+4s37WIjxCoQNTAghsCzwEv2Mxi738
         m7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794477057; x=1795081857;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWjpZTISxAW1ioWo7zAlKfMSm3zMo7GsaFnXjvMiMuw=;
        b=NsNa+hYh0oudizt4jPioL5u2V+W5G4w8a4quDTuowEdDrStZPGpMlllUoyC+p7fXkz
         /Bbvk5v6nuElFs05pABvbwC66Fm8J3xMPthj+tKTT4rntTin2odmH2TU6EqfHqZttv1N
         uy6OoFYTf0AD3q655/eGKVfbx20uaejDrqF0bWlx61Kqr9fsIgTHLnh1lQ2zcnlvsQud
         GrMr02muKoGzZ4LyXaZASHPkA8Cb6Px2wFRbyaXO0ToOkb2Tzyt8YJ1P7LYHj7e7H3KT
         BU/ZZXwjWoO89tmdNL6BaecSEyA49/i61mW90/rkc/TjD6HcCz29fMMNQuLuWILz3DGU
         1hkA==
X-Forwarded-Encrypted: i=1; AL+hErEoepF/vKRDne3CyquNLqbXqQCddSc0JbUgr+++CdhYY39RbNEZHKFR4kIcVmfwkqiMpYtNu0M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rimmVwbBKIdEZsz0GI9JYP3C6B2KjcM2dABid3aIY0R6HJ/NX
	UyFgGs+aI+/NUaDmfsQbRxT0LtSPf2kqBdsbYDD5oZSVl8JJSO+Qj+ro1rCdnat4EqfmFN9kzzx
	PsLw72qZCdSvEiGUkT/Uf4zjqtEYIRIuSQEVRt6KHiv49DtbCshfEcJg7VA==
X-Gm-Gg: AYBFou1j0fM8bU2tT1UCjvQCagS68hjsKP0PR7yfy9QIAbg9Uf6P814PzCTpKTy1X3k
	5O9yGGH9JllNx51xVNS/dm9H6+Pg+b43dRdYhsdJqrWIR4oxctlaSCTmM7kWWMP6uleJoYpNqQA
	sg3QvJrgc6bjK2V30K5GPpG7qFwedeM1fgKwQR7wTB++7NWP9lFr4qWKPZZ/17EWKFFzce6FXip
	hz+7yerVDTqMwa0wjesQP+AeVOPxkzZP38m9A/RmnC/c9GC+ytKXWWF/vT+LS9pshRnQ35oyVak
	nJxf4i6Ld0VRl95JYOMtTdKZAHf+/VWcjJzetELHcx3K9/VkkdjD5/90EelTL16CdSjRBKXxwdx
	Sd3sq+bUr4AEhipBg62gTi8Mi1jIgQzRD7vDze7kZfw==
X-Received: by 2002:a5d:5f91:0:b0:48d:f9a4:bd68 with SMTP id ffacd0b85a97d-499c7dfe760mr9013242f8f.27.1794477057313;
        Thu, 12 Nov 2026 01:50:57 -0800 (PST)
X-Received: by 2002:a5d:5f91:0:b0:48d:f9a4:bd68 with SMTP id ffacd0b85a97d-499c7dfe760mr9013178f8f.27.1794477056650;
        Thu, 12 Nov 2026 01:50:56 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-499823761f5sm10614988f8f.2.2026.11.12.01.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 01:50:55 -0800 (PST)
Date: Thu, 12 Nov 2026 04:50:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vhost: set dirty log bits without pinning pages on
 x86
Message-ID: <20261112044557-mutt-send-email-mst@kernel.org>
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


Actually why do we need all the unsafe trickery, is there
a reason? below seems way simpler?

+static int set_bit_to_user(int nr, void __user *addr)
+{
+       u8 __user *p = addr;
+       u8 old;
+       int i, ret;
+
+       if (get_user(old, p))
+               return set_bit_to_user_slow(nr, addr);
+       for (i = 0; i < 4; i++) {
+               ret = __try_cmpxchg_user(p, &old, old | BIT(nr), fault);
+               if (!ret)
+                       return 0;
+       }
+       return set_bit_to_user_slow(nr, addr);
+}








> -- 
> 2.43.0

