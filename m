Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0C74A64EA
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265388; cv=none; b=R6yA20YG+y4phcJ+mwARpHY4eg675gDb01DQRpNXKZ4Gaj9TtrpsnkAnaVO5dTby7weQNvyUll8rtlP/I0MzSIxpF/203lio6RBlO5jKemtPrpMDgmnGkIizxJ8rZwSnmap+9Vz2V1I7P0dtHJ0dweAkCx4+H8gMIaQPToYEf54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265388; c=relaxed/simple;
	bh=SzpsF1R44Ubodi/lWdByRj3ussGr5imnuwlywY4gVK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwptWeOe/FwNI0Mh0gSs4CQu6Rjlxhy6WaP1FJ/Cr5rwJPsF6z/KHBFpbO/IrjCfo6Nd8onT616vMu7xpBiWe8GJg7/dmakCQEgE6TjpqfVJBerkbhCt/DnnUWY3fhSlmuaXvcb3Yjm3J+WJ8J326STaWlUNDlX4pB57gvgUQCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfBMH7yh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UshE4h47; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfBMH7yh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UshE4h47"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790265385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BsIicbnwmHZxyMI07vJAKZ5x+YHru/pqorNr3bVuoUs=;
	b=NfBMH7yh+OQawnmR1xv/rmEYxHv33zlbk8fsr7uz2Ck8uqlhrUgr0dd5HMjNk+dYqZ5dhl
	HRc9AF3suWhnPq5A65LyH2iWnm7dHk9AiSRAOiNG8g5KAAe5HEb3ZmyPArxK7vXMnbF1n/
	u0e7MT/CaLmbirTkF6v86G6hf3E+uXY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-pblDVA2OOESEyWSZUmoTNA-1; Thu, 24 Sep 2026 11:56:23 -0400
X-MC-Unique: pblDVA2OOESEyWSZUmoTNA-1
X-Mimecast-MFC-AGG-ID: pblDVA2OOESEyWSZUmoTNA_1790265382
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c29452ecadeso234112966b.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790265382; x=1790870182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BsIicbnwmHZxyMI07vJAKZ5x+YHru/pqorNr3bVuoUs=;
        b=UshE4h47sI9NtWfWCugd+LddLlvaa7IXNIR2zXv1pn0UWX77z2W8IiMbg3cFLOsP4c
         EIfrab0R59uhfBMlpROLHM1hi3E8xcuLbc2PTsXbr4EiDqoIYIpt4wwdW/ZURcMPJT6Z
         xAvGt0sOKqJ9/XZwO9mok/dS+QGyeH/gipNoU7BZ1ZB0MTrYZYL/Nx/uI/qSS6F9QvNY
         LVVjMWvROYKaBIZtrp5gwl6BmGgHNKAwdbUyrmWPPI4Sma3Y+ob/KHB7fdeNCytrpa47
         QvC4d8x+dx3CnY0LPBu3h/7hBQuj5oJoUxk82MAVnG4JzKYHfTXluh39a9SfPFUyAEZN
         RazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790265382; x=1790870182;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BsIicbnwmHZxyMI07vJAKZ5x+YHru/pqorNr3bVuoUs=;
        b=YwzpPic0Q0GwGd2aGU3WNU13SAe1O+KhCjzGuplrvv4zyhFAxzB7miBJfBDy3uCmZz
         qx4eKJVKpYG7Kq63EEkt+iMdXD0V1vOq+uzkGM6vcIOk1eymn6MX0aMUY1qljA13GGKj
         sq5/LYOteBIJ6xeCSQb7295Yrd14TrlzVKAkcplUhbrRUKYbnWgn6FhTk+1OxbopMtmr
         Jti65joGv6ICqPD/oOPBANiHN2is48h/up6Toswj8KG5KwQJlIKE3CjcPXWIfyTpIAFr
         IuC0tUsR9F7oinIaz7uyOB7PYkYT0zdRene5pri3TCMI3g7Irt8cLzSJM4aTMqevo32i
         kzew==
X-Forwarded-Encrypted: i=1; AKwUvBydiIO8AGdCMWXcqkw0CFjJr18J5mvpXd9kfLKAfFebqThnQNUPKEz+K6oDVObI/RbgayVo4rE=@vger.kernel.org
X-Gm-Message-State: AFuF++kbSwn42R0EaRO1wwzW8PjDchmXa57su5cXsSetZSR52Sk6TJq0
	2+vNPWcQgD/hl3wsMXrsgI0rddvtirdOR4nnsuwzLDZ8xaYwhQLEiO9Ap6dc6R+lpGZdk350TJK
	DgawI2uStxgFwzT71tbV1LL9JgURnk37s5zguP4geSih8geZhiNZp4g0OU9bkeMCFAg==
X-Gm-Gg: AYBFou3vESuKJzg6BXfkGnVKOt/FuO2PWMnjbV7U9EjqifnwRAIH8lGrd3amT6C3HaH
	jv1U+UG0G7zQtwjlqjm6qfqpz+J+a+olKL8wkgjXewVu11tO2Czqe7jPxi2n+SafYrspDu74iQa
	N7R6HZP5Dqko9FuetGEXGwAsPWzDe7WhDoCKzKoXUfOzaTJf2hyopSCkVqWvA7VX/ecBRf9wYI2
	5hcAm61BeBit/DCxrAobcwG3qJA0B9UgmLrP2aBDl8ZmQdvuUnaR1FlmPpB7UIFTObEXwfEtchf
	HzM07PB85GJ0nkA2PzAC77c7icZEwVvvhAFADnPRk1zknSW5R6P4+wRyTBbPXXSmCFVG+rtPYzA
	sitKzU8fP00mRTFVszEkYjipmFVDDra+fmDYQXDPV7d974jbeNXS3v+Y9NqZjE38WIQ==
X-Received: by 2002:a17:907:968b:b0:c26:1648:a072 with SMTP id a640c23a62f3a-c2ac2594bcdmr230041866b.45.1790265382233;
        Thu, 24 Sep 2026 08:56:22 -0700 (PDT)
X-Received: by 2002:a17:907:968b:b0:c26:1648:a072 with SMTP id a640c23a62f3a-c2ac2594bcdmr230038666b.45.1790265381573;
        Thu, 24 Sep 2026 08:56:21 -0700 (PDT)
Received: from redhat.com (2a02-ab04-0158-f000-2548-f3bd-8b42-b18f.dynamic.v6.chello.sk. [2a02:ab04:158:f000:2548:f3bd:8b42:b18f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae33e046sm312897966b.8.2026.09.24.08.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:56:21 -0700 (PDT)
Date: Thu, 24 Sep 2026 11:56:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>, stable@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vringh: reject empty / undersized indirect descriptor
 tables
Message-ID: <20260924114316-mutt-send-email-mst@kernel.org>
References: <20260924030627.13287-1-fangxy@xiaopeng.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924030627.13287-1-fangxy@xiaopeng.com>

On Thu, Sep 24, 2026 at 11:06:27AM +0800, Fang Xieyan wrote:
> move_to_indirect() rejects an indirect descriptor table only when its
> length is not an exact multiple of sizeof(struct vring_desc).  A guest
> descriptor with VRING_DESC_F_INDIRECT and len == 0 passes that check, so
> *desc_max becomes 0, yet __vringh_iov() keeps walking the (empty) table
> and aborts with -ELOOP only after reading one full descriptor past its
> end -- leaking 16 bytes of memory adjacent to the table into a kernel
> stack variable.
> 
> Reject any len smaller than one descriptor, before the existing stride
> check, so no descriptor is ever fetched from an empty table.
> 
> Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> Cc: stable@vger.kernel.org
> Assisted-by: Hawkeye:GLM-5.3-flash
> Assisted-by: Qoder:Qwen3.8-Max
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
> ---
>  drivers/vhost/vringh.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Leak path: once move_to_indirect() sets *desc_max = 0 and points *descs
> at the (empty) table, the next __vringh_iov() iteration first runs
> 
> 	err = copy(vrh, &desc, &descs[i], sizeof(desc));
> 
> i.e. a 16-byte read from descs[0] -- one full struct vring_desc past the
> end of the table -- *before* the "indirect_count > desc_max" test fires.
> When the guest page backing the table sits just before a sensitive host
> page, those 16 bytes are attacker-influenced adjacent memory.


> The multiple-of-16 stride check is kept for defense in depth.
> 
> Userspace reproducer (move_to_indirect()/__vringh_iov() extracted verbatim,
> 2048-byte region followed by a guarded red zone):
> 
>     [VULNERABLE] return=-62 (-ELOOP)  OOB-read=YES  bytes-past-region=16
>     [PATCHED   ] return=-22 (-EINVAL) OOB-read=no   bytes-past-region=0

it seems nicer not to fail with EINVAL not with ELOOP as we currently
do, so the patch is fine. but the commit log if weird, looks like
an ai hallucination.


"an attacker" "vulnerable" and "leak" - is there an implication that this is a
security problem somehow? Because I do not see how this data gets
anywhere.

> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9066f9f..0767748 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -197,8 +197,9 @@ static int move_to_indirect(const struct vringh *vrh,
>  	}
>  
>  	len = vringh32_to_cpu(vrh, desc->len);
> -	if (unlikely(len % sizeof(struct vring_desc))) {
> -		vringh_bad("Strange indirect len %u", desc->len);
> +	if (unlikely(len < sizeof(struct vring_desc) ||
> +		     len % sizeof(struct vring_desc))) {
> +		vringh_bad("Invalid indirect len %u", desc->len);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.50.1

