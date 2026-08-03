Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20803932FF
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 06:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737401; cv=none; b=n7wABuK7b7wU0kOeCpkMdMo/7vkaMN1EvIq9Ib9zeBEvAfEqDHuwLRT79pc7TRta65HGnJ4QoQAK4N5e7qo6GJV+kDDtrhCFN4m/601wA1RHZKdwtJqgsTf5XJ5+MHfz8LrXK2YkUeVZj+yI/TGCxldH9iO36YONa3kEUHhfOPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737401; c=relaxed/simple;
	bh=kGVTFjQOt0Sx2VxVQgyTluCNk7T0u6JCg8f0cfpLT/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+LJM2bvu508SsXS1i1YAtU97zE1n6bR+2MS5XTAv8JiXyxAos4SZEbpdlnbJlNiurR04JS0h3SaiWqQs72MnfeDCDX6Nz5wN7280D3MQYU3oneLoKxKAIOV9jhmn5/3oRawfKA2FA4EX+z2H+uLaO9n6YyFydUpY4m5MX55efY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhcJgmjh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FvHGZchd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhcJgmjh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvHGZchd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785737398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=opESCzEHUJBRfpmQVy8tuXudchPZvHydKoko2MNrriA=;
	b=BhcJgmjhDvJkeHHmDmeqj2hez+ED7mYyqU6lEJb1tIwX7OWP1oMprRU8QrXnZnEJ1HFbBz
	2srCWwvU6vQSazvr/bvAhaT+HY9+PVeSRAOgtVXekntlWQCnVYxzFk15YsbdQPCR3ybnbN
	jUbckhSKTZqducjBDeEyB6Qpw9xiIk8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-1_Knk7o1PwK3bh_HHiwwDw-1; Mon, 03 Aug 2026 02:09:57 -0400
X-MC-Unique: 1_Knk7o1PwK3bh_HHiwwDw-1
X-Mimecast-MFC-AGG-ID: 1_Knk7o1PwK3bh_HHiwwDw_1785737397
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4954dcd6131so19144245e9.3
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 23:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785737396; x=1786342196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=opESCzEHUJBRfpmQVy8tuXudchPZvHydKoko2MNrriA=;
        b=FvHGZchdvONJS+J8kYurf+KKzcwXdFxqLzdjcrlGgswTL5BQI6InNZwcG6MLj+XwZV
         jxKJu0og2GPyjCZ9I1N37XK3M3k0/JQ4HxFMyr1AJY1Q0QOsGQndSpfYLxzNSTiSQG2f
         fAVh9ZdodhRF9syVhcoi29bkJUcmK4aAFIhSBa6vrEVoJ6b0c1Vpd3gEHI0/jBn/Lzda
         E1InX6WuA37HoVs5XE81QzD4XLgCSeCjzF2DeZ1va3x6rPkHlq98Z8MJBA3q8lOXyVCF
         6553wSE8llbWdOC11+v/4Sd66z2mDDK+24pEBIaePGJKNyvPlElzEqx/PU6xB/Kq0rcq
         S5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785737396; x=1786342196;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=opESCzEHUJBRfpmQVy8tuXudchPZvHydKoko2MNrriA=;
        b=SlM9CLiYINXjZo5udmXtqfLgE4xaUP8WGFlDO58MzuJgjUoJlzLSNWozkczZiTp/MZ
         Yiu4tDiVeUdwbIt+1wAUShBwIKsfX8OVDoyBwKyMPY4AfS4P51KVRhuzNcQTw2hV0zoD
         Wcvjh0B4N2WHSMb5BnOJfDdcQ/0Nr7iew3fZKggxde1PR3pOVldZJqOwD7e5xlGbvXuM
         7oJAD5t+mfTACh65jzIi+t+MRbzHXHtsUTHV52J5tFTl/HIOl0p9kdLZ8/LHTDm0hh5j
         yP6i3/0vH07xSZaQfctQLMFralL8HbK07ySCQ6450xIV/vdiZWh42+kIx8Oc569t9gzO
         1MdA==
X-Gm-Message-State: AOJu0YzSMMQVQ4ooaYHjbKLP1ag3sQuPQ1Iwgf7jXdaE+tKumcPOWSrS
	XMd9BabdzPlowd+SID/iCTSu2nqZAkPNCaYya6sJGYc4AnLYMrUDYUFYFoY7DR71nNYx9aXhQKd
	mzaCBEGNMdMKf2O7thveG8IRCyEPJ4ZCG1vEKCSxGEdMmQ3it0X6o44TRmw==
X-Gm-Gg: AR+sD12HY3TSokLLkZFYZhGttH6awZsCeA5TRw7fYT1AkS0dKQNFPgK5JczkGAvuKhW
	J8nvm0ZibAhQ61QxtQjeCqfBYpL1qOO8Y8xb/y25sVYghTpkhhkSGOWG8UeWyeSWz9DaR8M1B7V
	bfAv1oCjQGHMhiI50xhtRYdZ+7AXCd4nQK8Aj8RxYZ9Te1CBghRWUS9zWSclo6O3h/VrqkjJOsp
	0cP6E6N0OloalrZT+KZZdZjLMQp1IMWswCTSpo9XDbZQpedN1RBMjZedrCHtqwV+oL7RhI3D78X
	3v++SuSFRvFUI/GM4rjanXT/iueh74vAEEgOhWwx9YyD8Z2o5Z1EciWIRzTGSqB+A0awy/riMsw
	yxQGJGxQn+3DpRavIh7pwRg==
X-Received: by 2002:a05:600c:c490:b0:495:7538:d4ea with SMTP id 5b1f17b1804b1-4980c5fd773mr159725945e9.0.1785737396402;
        Sun, 02 Aug 2026 23:09:56 -0700 (PDT)
X-Received: by 2002:a05:600c:c490:b0:495:7538:d4ea with SMTP id 5b1f17b1804b1-4980c5fd773mr159725185e9.0.1785737395940;
        Sun, 02 Aug 2026 23:09:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980878dcb4sm327289125e9.13.2026.08.02.23.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 23:09:55 -0700 (PDT)
Date: Mon, 3 Aug 2026 02:09:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jun Yang <juny24602@gmail.com>
Cc: netdev@vger.kernel.org, Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org, TencentOS Corvus AI <corvus@tencent.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: reset the vring metadata cache on vring
 reconfiguration
Message-ID: <20260803020641-mutt-send-email-mst@kernel.org>
References: <20260803014823.68623-1-juny24602@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803014823.68623-1-juny24602@gmail.com>

On Mon, Aug 03, 2026 at 09:45:14AM +0800, Jun Yang wrote:
> From: Jun Yang <junvyyang@tencent.com>
> 
> vq->meta_iotlb[] caches the vhost_iotlb_map that backs each vring
> metadata region, and iotlb_access_ok() returns early on a cache hit,
> taking the hit as proof that the region has already been validated:
> 
> 	if (vhost_vq_meta_fetch(vq, addr, len, type))
> 		return true;
> 
> The cache is reset on VHOST_IOTLB_UPDATE and VHOST_IOTLB_INVALIDATE, on
> device IOTLB (re)initialisation and on vq reset, but not when
> VHOST_SET_VRING_ADDR replaces vq->desc, vq->avail and vq->used, nor when
> VHOST_SET_VRING_NUM changes the region sizes.
> 
> With a device IOTLB attached both ioctls are accepted while the vq is
> live, and neither validates the addresses at ioctl time: vq_access_ok()
> and vq_log_used_access_ok() return true early because the addresses are
> GIOVAs, deferring validation to prefetch time.  Once the cache has been
> populated that deferred validation no longer runs -- vq_meta_prefetch()
> hits the stale entry and returns true -- and vhost_vq_meta_fetch() keeps
> translating through the old mapping as
> 
> 	map->addr + addr - map->start
> 
> for an address the mapping no longer covers.  vhost_copy_to_user() and
> vhost_copy_from_user() consume the result with __copy_to_user() and
> __copy_from_user(), which do not check it either, so a subsequent used
> ring update or descriptor fetch accesses memory outside the region the
> IOTLB actually maps.
> 
> Reset the metadata cache whenever the vring is reconfigured, so the new
> addresses are pushed back through iotlb_access_ok()'s slow path.
> 
> Fixes: f88949138058 ("vhost: introduce O(1) vq metadata cache")
> Cc: stable@kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Signed-off-by: Jun Yang <junvyyang@tencent.com>

And it seems AI assisted writing at least the commit log am I right?

You are supposed to use:

Assisted-by: AGENT_NAME:MODEL_VERSION 



> ---
>  drivers/vhost/vhost.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 4c525b3e16ea..77c96993100b 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2126,6 +2126,14 @@ static long vhost_vring_set_num_addr(struct vhost_dev *d,
>  		BUG();
>  	}
>  
> +	/*
> +	 * The metadata cache holds the IOTLB mapping that backed the previous
> +	 * desc/avail/used addresses and vring size, both of which are being
> +	 * replaced here.  iotlb_access_ok() takes a cache hit as proof that the
> +	 * region was validated, so the stale entries have to go.
> +	 */
> +	__vhost_vq_meta_reset(vq);
> +
>  	mutex_unlock(&vq->mutex);
>  
>  	return r;
> -- 
> 2.55.0

