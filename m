Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36947384CE8
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775162; cv=none; b=ONfevnqiJJY0ILW5CEy1VSwUe8DmxD3e0hid3IQAJXhCbw4oL2x5kaOhBOl9pbaOsTxBFM07MqTyfAGwWFV1sfiBWK1x7XVZ1wp4Y6C+H8M3IJuh1lSTKdyzvdCEmu3u4S5TIDZAa9AKpziQ8ODT/yff/hP/iR4qSkvL2VvTpc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775162; c=relaxed/simple;
	bh=mqUEgn1Epw+wydGosGOX18016E8j2UEyqJXR33YIW5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifdCmjFLS3A9/c48swj4NwoE0Rwwu0QPa6DNxonORv9GMYqx7jS/DmCqA/9Zjl73Q+wkBigC8Ug7QxNEyCXbie59Pb51Tz9Xt9OaVI/7ZAqj8lEEYgRo9sh1bbW/vyAHSxNqcvUdL3bcI4hpXhM2RIQxETECcuWnHi/cwuJFwV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QG2wKTl5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bf/T82Fh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QG2wKTl5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bf/T82Fh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785775160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6ljzSC+4qTqONEyzGjxVIdBzwjub/8R38l2gLkronQ=;
	b=QG2wKTl5A9gegMCKZ7Oab52jCpGhjpB8uuLnxqBC1UOd7/ECdb9bSqIZjfpPJaaRhnTkXU
	pFviQ0LgYm4hfVNB4r0gVYt/ZXlRUIxmud2OVuv88VyOXcsYXhABqgCjTKcBilTh75Jgt/
	fqlmLAiYP2TQPVTh3TDzf1kzFgUdhz0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-HnZDmU-sPoaJI8NufgfBoQ-1; Mon, 03 Aug 2026 12:39:18 -0400
X-MC-Unique: HnZDmU-sPoaJI8NufgfBoQ-1
X-Mimecast-MFC-AGG-ID: HnZDmU-sPoaJI8NufgfBoQ_1785775158
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47faa02f707so47426f8f.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 09:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785775157; x=1786379957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x6ljzSC+4qTqONEyzGjxVIdBzwjub/8R38l2gLkronQ=;
        b=Bf/T82FhOZFKFhomK535ZGW5bjnkG1gOWVAc5cg4dEqP6SgJU6hgq3NrEsIc3qFFTL
         r/WPUtA5Rkx8dJwJkUCkToDuqbeTVtxNtxfTUl6wJ5bH+pzuELQe6OOXT+3N6kLINrw2
         3J3/c/Ld4SreQEUPUaET1quiaLcmDxr7mI2onBQ3LBKNNF6A4KyOJluEQdOWfVIVAeek
         4sJL7tuIb0nzgx7Gppca4yI/c2K749XXn7EfdtZI4Eq8cqjbqaekBjXCpyoGq/KRuRJ0
         PnqQywWAD3PqMATjfofc7qUcafCChX66ZFmtW9W1pbanUkL6NgJcb8LfetPStcslYLff
         9e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785775157; x=1786379957;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x6ljzSC+4qTqONEyzGjxVIdBzwjub/8R38l2gLkronQ=;
        b=Zai0dPjIYyk3eSg/FATrFE82CAuChp4Hwruo5IE4eQrEqnBD9cNlNq/pG8qc6w+S/r
         6Fb4j1vljLSPR4u9WtgqRUM6EhVjAjYLHWeZvm0zY58HmwiXRp+bgL6WeKnjAVKi9TH1
         tpZ+2C9vHobt6sZTfPDN0H/CoVDqHi6+QZZ2jIQb3EQvc4c//ifZZA3t1BdkbCO+eCEM
         jccCAezFWcVrQuXYAEscZrBKwR63sJAIGIEZIxzHnYOSH7+Xb1/3ew6QjW3niGJ/E/xw
         HJh9lZPjjOVNeE0FCyUCSxBT2pZDKCCi9mTaWA9HE8LZHqWOJDVihmUmxsC4MqJw2rfS
         8zaw==
X-Gm-Message-State: AOJu0YyGAu0KSNqm65yNAMxuxfoX7MiCseEqsa9LPCB2wV31mFMxbnr9
	J9wkVi3pgFsUvRZEsLSpA3XqMQhOYRJSgwhNS1U/PhzIOoPKsrY6JpFwTiMAxaeo5SgfmS8OEbt
	/RqvyhjNfGCUBB6BrkaylA9gIlTC2BCpe7wjrY8tLmJ0TX0BmIM9N1tTdIw==
X-Gm-Gg: AR+sD11PV+4UCje0u//r2hbTg7KcIyDKCxyFXlqWNMorrb1BXRkKI2UOT4lXIvtJYnq
	JUsK57wr1JHxWI9zWy41xUAxVYDCeuD297QH9phywAMIQpbO1E8XQuKfq0KnJLYvFfI5xLdSGmT
	ShX5ivjDfjPqhrsc0jIQwiT3jiVdOSvDlhKhBTX/WHIua/irA0wbl86nTenZVGpnjkg75B9qJoC
	rhGSb9JDwBP9D2aS32AiY29+4gEB1S1fbKbNiMPG6wsovFmzpt61GODBPW9mYe8XRXm8DXoyQP3
	t3nujkGNRmVKVAgeZnfaGtMs3q+NuoI+PhapYiEZQzhcdbd3o7ty77ByduefYOsl19RLFaEM2kV
	Rm5oY6psBG383rV17yb7l+w==
X-Received: by 2002:a5d:5f94:0:b0:47f:7fe0:a287 with SMTP id ffacd0b85a97d-47fe81983f1mr844395f8f.2.1785775157515;
        Mon, 03 Aug 2026 09:39:17 -0700 (PDT)
X-Received: by 2002:a5d:5f94:0:b0:47f:7fe0:a287 with SMTP id ffacd0b85a97d-47fe81983f1mr844296f8f.2.1785775157008;
        Mon, 03 Aug 2026 09:39:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4562667sm36096625f8f.24.2026.08.03.09.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:39:16 -0700 (PDT)
Date: Mon, 3 Aug 2026 12:39:13 -0400
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
Message-ID: <20260803123853-mutt-send-email-mst@kernel.org>
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

patch itself ok:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

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

