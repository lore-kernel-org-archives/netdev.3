Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157047ACC3
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819899; cv=none; b=mh/QdFKZ21Pntkaq83fo6it+hqMlXH1qDf7KsNNAJnYJ7npPqePIYCAgLEsl6jMtUM2wd1IXajDDKb1b6Nle9VxXsnfqSr1Hf3x1kUg6NB2KcC9REHzTz3fxIj8VJYY1g6Ow/czp2pXd76DlOygKy87KXgh1eiro49M0bz9CLJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819899; c=relaxed/simple;
	bh=rSe9HD907K8IRLWvdPwE7ouRnZKLSw9p6mExkMka2to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAmTXzMClLgHDItenPOyu1BiVS7RGwsuCfHLFpZpyK6DxNLraAMSLdR6DmEhHOf9S5ASeIrzva4PW7RRKkOeRISiz68JoD1VdzuqPFCfCfaYYPDqXIg5AQueefCaDgyCcQq3s3ArzwStbjjT+3WxJ4rxB1JvF6maxa5hYWBbuuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzENcHB1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gkg1nX1Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzENcHB1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkg1nX1Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784819892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9OUorP8L7Hv+mWbQVnXQe/Nap+PNXLSDh1VLwTpZtYE=;
	b=LzENcHB1cpLjBEdZ9cuFWNVyohdTFmqAa5uS1Qe12rANZDve9zhxVseFElVf7pXst9gXQl
	RDr2tHAWamFHBsAgkwbkUq6vtPq+yuMrpPPXY77n4VvCCFAdCwm3Rh7b0pUYOQIASf0a7H
	Vl8cTZaFt8CghHIzzF8VvfxLetY4OfA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448--tbR4JP8NDSrFkIcfZh5Ew-1; Thu, 23 Jul 2026 11:18:11 -0400
X-MC-Unique: -tbR4JP8NDSrFkIcfZh5Ew-1
X-Mimecast-MFC-AGG-ID: -tbR4JP8NDSrFkIcfZh5Ew_1784819890
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f8398ed9fso725175f8f.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 08:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784819890; x=1785424690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9OUorP8L7Hv+mWbQVnXQe/Nap+PNXLSDh1VLwTpZtYE=;
        b=gkg1nX1YT69VX0y5vDJvJlU5Ajwm54l9OrTPblcGsl7N/P5Q64J5ADGi3YYcK3keQd
         aPeOK8yxFJxjvp4sVV1AdSpW/VpQPV3d6YTctd6h4js2uObCoQBrJ0Dy8AnTOcm4EpIt
         kBe1hhAI+STkwIjJ5ccgisfMHwVaQrSjfcjqQYW1tNS0pXzOA4KJezqQ58RqlnqyizdX
         4Z7tkrjKNXmU4DSWLeKHZ5G6jqViE5mJJhe/OwgYis7okSKb4tkzaNy2kaDTlk5uUu0J
         lOsYmjp12snxs/7ILSF6h8QKQxAuNtEUdsmbe2NCvnoPPneEd16TgzT1hCml928Yn41q
         ty3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819890; x=1785424690;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9OUorP8L7Hv+mWbQVnXQe/Nap+PNXLSDh1VLwTpZtYE=;
        b=X74eX0GZ5yZD86moWLesM1yPZ0qEbe0wd2OsMFof65H7uFA4xm8N/GehXwrAjlNy0O
         gmNqySNxkw2z2ZNjOVctldc0L3wDoUCffKEYEwgLnamZ11/C2QN/sIDHmmssJSRIybGi
         tU6XjjawW6ferrfT2vKVkRDET8amhWzZs4VzIw54kewH4pM5bYzCepXCDmSV8UhFzl0V
         pa1HhbcPjzM59i11qWyoQ1Xl3SN5OY1gdZno4bDtxJxb9nStaT+YQQYoKusX7l+/xo28
         sSYyYUBXQ2MbHt5xkz2c9WkEykp7aE3O/6Ulr5eWmiu2QW7GuN9fJ5XpotfYs9LTpCvy
         WSiA==
X-Forwarded-Encrypted: i=1; AHgh+RrOhQJp7eMAHeFsxrk0ET3lAC84UtN8ycF2y7dUeQStbONArSQSgZXOkOFQa6KP1Jv6jvywokM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKgrFrKsP7uBPU+JF+nZToULHcFe7cWwJIchZJHEyL/aKl3EFM
	/5mSvAjpa9ui7+j1o4wnRHHtRGJ/2LTE0/EcHMpeagp9iXvB7JFkC4m2a53PIavG0XZ1FF0+Y6v
	lUmyoCWUDolJKwkPnl3gywk0I7ETlyos2viOyGn4rTIsUJIVkCgrigAk0tw==
X-Gm-Gg: AR+sD13cH/70PHIZUWtIrzTYFXXUbQ6xB/iylVZAJdqMVMFYVCoaTIVFdOJhCYtQTDM
	XsyDyHJ346G+zauEcbTA4B1jgLXDZLVAdcO4eVO15gVojjCX5qEG0dn7GEAdL7oK+1MJAlG6yqs
	TNvzzr3W2IH4VOAAcRcVvtulsurbAEzo97dTTE3Y+j9KnQ6urf8baMS845o3vhtkHVmFNNLkv37
	2Jecvrn54j1//1xqNANx9iH3ZaycXR4k0P2cxtmjBJ9Joe9bzKBcMocCKIK6pdtJyWcWPS+MEIR
	hmZR5WSJ3jqAm7aNgkehie9nJX1oGwRHCT3SvLcqAz8rjs2FASBT17HVqfDoXUnpYMDfgCVYDRc
	IrtbybSq7CllAtKc9cpX6Jw==
X-Received: by 2002:a05:6000:4386:b0:474:13ac:a91b with SMTP id ffacd0b85a97d-47f8d7564edmr4641364f8f.32.1784819889720;
        Thu, 23 Jul 2026 08:18:09 -0700 (PDT)
X-Received: by 2002:a05:6000:4386:b0:474:13ac:a91b with SMTP id ffacd0b85a97d-47f8d7564edmr4641303f8f.32.1784819889120;
        Thu, 23 Jul 2026 08:18:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bc62basm16346454f8f.13.2026.07.23.08.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:18:08 -0700 (PDT)
Date: Thu, 23 Jul 2026 11:18:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	sgarzare@redhat.com, stefanha@redhat.com, dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com, bchaney@akamai.com,
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <20260723111557-mutt-send-email-mst@kernel.org>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>

On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
> vhost_vq_work_queue() only holds the RCU read lock while it dereferences
> vq->worker and queues work on it.  vhost_workers_free() however clears
> the vq->worker pointers and immediately frees the workers, without
> waiting for a grace period.  A caller that fetched the worker right
> before the pointer was cleared can therefore still be queueing work on
> it while it is freed.  And even when the queueing itself wins the race,
> the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
> future attempts to queue it are silently skipped.
> 
> None of the current callers can actually hit this: net and scsi stop
> their virtqueues before the workers are freed, and vsock unhashes the
> device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
> before the workers go away.  But the upcoming VHOST_RESET_OWNER support
> in vhost-vsock keeps the device hashed while its workers are freed, so
> the lockless send/cancel paths become able to race with the teardown.
> 
> Fix this by clearing the vq->worker pointers, waiting for a grace
> period, and then flushing the workers so any work the last readers
> queued runs before the workers are freed.




> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  drivers/vhost/vhost.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 4c525b3e16ea..d6e235c25254 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -729,6 +729,17 @@ static void vhost_workers_free(struct vhost_dev *dev)
>  
>  	for (i = 0; i < dev->nvqs; i++)
>  		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
> +
> +	/*
> +	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
> +	 * reader that fetched a worker before we cleared the pointers above
> +	 * may still be queueing work on it.  Wait for those readers to
> +	 * finish, then flush so any work they queued runs (clearing
> +	 * VHOST_WORK_QUEUED) before the workers are freed.
> +	 */
> +	synchronize_rcu();



Any way not to add this for all devices that don't need it?
Or preferably, even for vsock in absense of the new ioctl?


> +	vhost_dev_flush(dev);
> +
>  	/*
>  	 * Free the default worker we created and cleanup workers userspace
>  	 * created but couldn't clean up (it forgot or crashed).
> -- 
> 2.47.1

