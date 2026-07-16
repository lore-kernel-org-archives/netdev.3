Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C98336F8F5
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 05:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784178875; cv=none; b=AU5jytTm+jFLdXex9lv3jYfpESKfrYpFGN2G0ADuhP1VL648mLn7k5sl4GoltKjbEQOnsfn1q2e2/TibfOBUFQSIhCcm3indSUGU6igwLZ+1rwUckSwtPnefAahjVLf9z7ySUL6VyQ93gW55KnRtSsGsR6mtj6nsUpaKhqQOeYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784178875; c=relaxed/simple;
	bh=2dv7Xp2yhNU1dw2G6/8qADYCMZeGeab7+y55mN9rsMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMmCXEoOd4LMqRZ++JAGcFnG5QxCO3FaFf8mBVPz2DlCieJDNInt0A0R3t+qM7l/QwYs+oXpPyrqRYDNdSRRimnFPCYOqO1UpzpO9Y1BtmTcbWHrld3peTu8vSYjRuUo7dsbYEndrsWxj4oJ8Msilp1LWoLE41XR9rsb9lunUu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0g7whNQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLQHqKVT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0g7whNQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLQHqKVT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784178873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YC1bxmvVJRWuz3ht/6dY0XwyFCC/YYtV/qcXCt5WC50=;
	b=h0g7whNQJY+HYiChe/shKdx0ZDDNr44+PGoBMecte5nEPXU3muct59mjO1PybCVRPISgtg
	mOYCUGr8Q1nydAtrmra1+4q8/5GsL7l7hlHvGKCctY9FPLZe9oyZm3cN/8x+U0jlKvPYT/
	oT+1JaFgHge47xHMsL5TZqanKq8U5g4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-zLMyvS7iMYWBQQ5hCgP1gg-1; Thu, 16 Jul 2026 01:14:31 -0400
X-MC-Unique: zLMyvS7iMYWBQQ5hCgP1gg-1
X-Mimecast-MFC-AGG-ID: zLMyvS7iMYWBQQ5hCgP1gg_1784178870
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so37769605e9.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 22:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784178870; x=1784783670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YC1bxmvVJRWuz3ht/6dY0XwyFCC/YYtV/qcXCt5WC50=;
        b=SLQHqKVTcXxfuY1zalbaK070/85UnYSodNC2+z/tyuwlRca+MQK0Lj3B/ltNUFDNiD
         NhgGN9yEbnYn2A0Qsr2dq5dnQEzzxIUSbDXpPhW/q+QN2/pc77EX/pB+gwvFsCa68mK1
         NmETWXZ74L1usKbej8kUrqriJdz2faa4C+fGv1pedws1UxlNY6ShkbZVWa6LixFOwWxJ
         Db/8AvAna6dHVhxyoDFIm95cMsni4kck/Jp7bBd9fRB6f45o4D+tvd55zUNWhlv44Iub
         N316C+iKq84mo5mCLpOhx02U5vqQCmmFxbq2AHKr90yaa2OOu1P3/ChiwHOwz2dkX99z
         Rg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784178870; x=1784783670;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YC1bxmvVJRWuz3ht/6dY0XwyFCC/YYtV/qcXCt5WC50=;
        b=UVjpeyqISCbAIzn9zeyLkpeAuktHL7B5SyS8VbEfoXZC44Zzh4xz1fxwDm9LM8bmsj
         w+Q0ejeN+/auuF4fPhwiqOe3cRKNb7rkunAem2otQOewm/NVsbTGFpb8T7RDbL2aQ9B7
         NRhL2Pgy/gvXkF36gktVXF+oz8dTldRe523Gniz9WftCHvT5ElC6SRYRhypWq1iXS/Cn
         YK25bc1ncf9d32IMAYTkJvzpN2sdT2wKDysD88sOB/uRdULbTw1EUeL65f/5gryTQMJr
         i55UbztEMNKL8mPrEhx5T7vIn0yNeVeRdWm/sXbwsMhJxowSDLjgs14Brb0ALXU4DSc7
         Cq5A==
X-Forwarded-Encrypted: i=1; AHgh+RqeFyT/hAqLjpOzy9SaPYt1Gr8XbZSuUtnv29uKEuB8XP0na0BRp6HoquP5G+50jW8xzNPHp5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/om4X6qBlVxFGfj1+fpBiCq/P47EGqzuubDMuUaT/jUROk1Ix
	o9H723/SrJ1nnOqWmd2H7AF0j0MkgN2svhj7c4SL/kOwHMod4jbx8Hcktd8IUDmvjgmi/b7S0wL
	kQ2JDDAoq+MOBLT6TrQSi2sHAo0xowdoRdRpjWbZw/Y6WjPTXftl336I5lA==
X-Gm-Gg: AfdE7ckrfoEo9EJHHeuRrJx3lmzPONigUBe+8vs7Y0WIeiiEffsY6mjN3QBHD13CfRa
	8ofK77Icf1qSYHD4/hKx0bJwKKKejZMz8zv5ADggfS7y0ctnxoJWuSM6InCt9c3QwFjC/PaM788
	vnJb91TkLGooqoSuYJtL1TCnZqDTyMfm2LUCneWVdE8anZ06WL/JXGFZhe8fVAzYTGl6aDlU0+4
	293Udm0i/fP9UR/3kQw5kMk3icNP5qdrVMKbO0QrLlJ24lPq9DWwFWrhdNXrb0Lch/cQKABVkbg
	4omvfRUgQ6CB1AQzJdvnzlV1NOLA14vcOayZtBfcQTb5ZbE7FMqKD2xMPQ29gMcKvIkdQdCbPYq
	HQoX1ej9BFHtzXBNVjH1DmOCh
X-Received: by 2002:a05:600c:4ec8:b0:493:a435:d870 with SMTP id 5b1f17b1804b1-4953c286e00mr62234545e9.27.1784178870171;
        Wed, 15 Jul 2026 22:14:30 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec8:b0:493:a435:d870 with SMTP id 5b1f17b1804b1-4953c286e00mr62234295e9.27.1784178869707;
        Wed, 15 Jul 2026 22:14:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464b7f84sm20560186f8f.27.2026.07.15.22.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 22:14:29 -0700 (PDT)
Date: Thu, 16 Jul 2026 01:14:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jinqian Yang <yangjinqian1@huawei.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	liuyonglong@huawei.com, wangzhou1@hisilicon.com,
	linuxarm@huawei.com
Subject: Re: [PATCH v2] virtio_net: fix infinite loop in virtnet_poll_cleantx
 when device is broken
Message-ID: <20260716011312-mutt-send-email-mst@kernel.org>
References: <20260716035201.3736582-1-yangjinqian1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716035201.3736582-1-yangjinqian1@huawei.com>

On Thu, Jul 16, 2026 at 11:52:01AM +0800, Jinqian Yang wrote:
> virtnet_poll_cleantx() contains a do-while loop that cleans up
> transmitted TX buffers and calls virtqueue_enable_cb_delayed() to check
> whether more buffers need processing. When the virtio backend stops
> responding during guest reboot, used->idx is never updated, so
> virtqueue_enable_cb_delayed() always returns false and the loop never
> terminates. Then it will block reboot process, and the guest will hang.
> 
> The problem occurs during guest reboot under network traffic:
> 
>   1. kernel_restart() -> device_shutdown() traverses the device list
>   2. virtio_dev_shutdown() calls virtio_break_device() which sets
>      vq->broken = true
>   3. virtio_dev_shutdown() then calls virtio_synchronize_cbs() to wait
>      for in-flight callbacks to complete
>   4. A virtio interrupt fires, softirq is deferred to ksoftirqd which
>      calls net_rx_action() -> virtnet_poll() -> virtnet_poll_cleantx()
>   5. virtnet_poll_cleantx() enters the do-while loop and never exits
>      because the QEMU backend has stopped updating used->idx, despite
>      vq->broken having been set to true in step 2.
> 
> Since the loop runs inside ksoftirqd (a SCHED_OTHER kthread), it is
> visible to the scheduler and does not trigger a hard lockup. However,
> the kthread never leaves the loop, so RCU detects it as a CPU stall
> and reports it periodically. Meanwhile, the reboot process remains
> blocked in device_shutdown() because virtio_dev_shutdown() cannot
> complete its synchronization step, and the guest hangs permanently.
> 
> This can be reproduced on a guest with a virtio-net device: run iperf3
> traffic in the guest, then trigger reboot. The reboot occasionally hangs
> permanently with RCU stall on ksoftirqd.
> 
> Observed on ARM64 KVM guest:
> 
>   CPU#1 RCU stall (ksoftirqd/1), repeated periodically:
>     virtqueue_enable_cb_delayed_split <- virtnet_poll <- __napi_poll <-
>     net_rx_action <- handle_softirqs <- run_ksoftirqd <-
>     smpboot_thread_fn <- kthread
> 
> Fix by adding a virtqueue_is_broken() check to the loop condition, so
> that the loop exits immediately when the device is broken, allowing
> the device shutdown to proceed.
> 
> Signed-off-by: Jinqian Yang <yangjinqian1@huawei.com>


Good thanks! Just the subject needs change so it's clear
we are changing virtio core not virtio net.

> ---
> Changes in v2:
>   - Moved vq->broken check to virtqueue_enable_cb_delayed().
> 
> v1: https://lore.kernel.org/lkml/20260713132025.703147-1-yangjinqian1@huawei.com/
> ---
>  drivers/virtio/virtio_ring.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index b438dc2ce1b8..5c169fbb418a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3233,6 +3233,14 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> +	/*
> +	 * When the device is broken there is no point in polling used->idx,
> +	 * the backend will never update it. Return true to let callers
> +	 * exit their cleanup loops instead of spinning forever.
> +	 */
> +	if (unlikely(vq->broken))
> +		return true;
> +
>  	if (vq->event_triggered)
>  		data_race(vq->event_triggered = false);
>  
> -- 
> 2.33.0

