Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0538AC90
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782284915; cv=none; b=LpuOSbVI/JnjtYi0VpUnRRBRuWoRapEnZs6YozAVmN1YJvgMxFEemxf46e01zfwOlB9FokZiQcGo6YGvDqz02BzwlDPbt89FuYy/bxFScrBqX55FFQBNOPtd7/N3Dmqps8g4Elox68VbgFgwfhHKluLpp7JY5JCWZjNPAy4aQNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782284915; c=relaxed/simple;
	bh=xxRwD872hAY7e9+wcKaMu2M9Gp5015MokzS33Hl3FeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/GYXWgDROn5d78s3uQ7eY+NjFOMNraBUpbPW7gqKey9MP1TaupRpmCnon48uFVAgBESHO2wpy0A0ZmuImTdQIifexzgzwYev5DAXRQR/ByQdjsTlwE9O8fViwMhniVVXmyiUgelfM//JyWEa/CeV0EQekPafbKOI9kqO69L7ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+BG+dT+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qMI6S1uw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+BG+dT+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qMI6S1uw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782284911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SOVdOpEBfLtfj8+28uRc5uJ//FeD3/0uqHv5rRdyHRo=;
	b=Z+BG+dT+OKUcYXx4pNxEAJbz/7uOfClvFsr5wcjQi1rlPxMSUNGOHrMeNN0YLfx5L/MjOT
	YxxLVxYJNhQZyokjtDKnvmKwwQ51CH+W35kdtGUPLW3WtGPhEvNyHpkIEhMT0l0qPVUX5b
	dZJhO898lKGr7KRKT7qP3WSdd8Yc5nU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-1wkSF6YzMFawLTEpDvcgkw-1; Wed, 24 Jun 2026 03:08:30 -0400
X-MC-Unique: 1wkSF6YzMFawLTEpDvcgkw-1
X-Mimecast-MFC-AGG-ID: 1wkSF6YzMFawLTEpDvcgkw_1782284909
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490cc1ae292so4158405e9.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 00:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782284909; x=1782889709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SOVdOpEBfLtfj8+28uRc5uJ//FeD3/0uqHv5rRdyHRo=;
        b=qMI6S1uwInnIe96Dcnq+iyl05p+gIdwvCqJYUK+lCtmfHTo7lrqdNSQhx5MWuQjega
         ZY0lRACp5DPHvUOMSK7yTBeb62FaCGeRA7pHKfnvkSfXWVZtiNNOiBsC14yY8dVZIhcB
         T61J5mPPNVSb9UDD12GyBH/6qpRvh3I3LM/y2KVpQq4IRg3qjYTQv40vqSZCMVuT0dgb
         AnoNnS4faYBtK4DxGWXM6k5ZeFO0tqXbCQPiRzuugQm/XtSRO2Q6gImO6DNkNxMsN/D6
         YHt0AY78GMs6WiJkiOzXjFIK0cVaMK9CajjQ0Ws1xi3fV/41wWgW4vfyEksQKgElblYM
         WQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782284909; x=1782889709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOVdOpEBfLtfj8+28uRc5uJ//FeD3/0uqHv5rRdyHRo=;
        b=NoUFS+Ra3T5UbhmyAGWxx0lSTyMvcp6RAqx3DRhf6/b1o15fayKZZ0RZFR/feDlsf2
         XXUNAlRrT5ZlUBvG7BBqwTkmsea/ZwdW8jaAMMrtrTGD+w/kPOMHfNKKePFwKxYnjXTA
         ZOzyvCK8hQDYeKro0NX/pE/d0OhlXWykuyGdPOLYiUP9W7mZs+pymBI8MyUIdr/ZX1o8
         gRyJO8FDHUOcPTfSRLFTZL4bLsI1dBXOYKxYbprxR+jVCWyNXYN42aMWMQCWk41Gf7p9
         vgSqN8EcPF+MCwctaV5CUFJbtKUQaOh7mlTWdXaE6Usv7jpIPUeNamjvUvpm6IdYTmDV
         mY/A==
X-Forwarded-Encrypted: i=1; AFNElJ80BnptBoEYPrF3D4HGYGAXNx7oExRxm5mW0XZbuxxjcMMqdTITW7fXqLKhBkZuCAXVR8qB88Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsyFEaA1w9cnJOsEsKCme2e5TtKT1SpwR+55cBU+2+dmw6+iu/
	heuEDFKz4/Eg/WASTBhyOnMA0gkZeyd8Jod0y0eSwTiQOZVuV5p+8UG5TBosIAfyqbbbsIpcEIr
	OsNMZg2bGotP1VNOJUJXDh9TsPEJAuBeWel1OGTrjIyKiUA2KqVIP5UlUKA==
X-Gm-Gg: AfdE7cn9TvlydqJyXvsCzTKDQ3qYTXCYnx6blTQB6MNKeDB76rzRjWMIH0ppmFuzQQL
	CNFyDCAVpGnuPIGx/ejjRPcYK/sNjI28PFfF3mCe4QHP2CRIsLjrb8llZ2N+cqJCtCaFJrulQR1
	cM1wK2ouLjxHuTRqUTI34Cl7PAOCnpqOJraSUmWTWVVXGG5bxFGRMQNoQovme9pHeeBOXYPuTQs
	i4ZgLlj/ADrrc5ZkGU3sjbKcBrq3D7sRLTRkoQZrNyLPRAFfXIcY2cbct7bYIz6xSEAo7hmsEHG
	Iqak9NSLpI9OFTUoqXo7okaps/jB4Hq7GYnYpmaoQDgyRL8ij0TWesY2JEoF6KuyqxlwioahpSi
	hML1UvSjQg5868VYZdIDo9fvZC+vI4bnb
X-Received: by 2002:a05:600c:3b2a:b0:490:af63:2cb1 with SMTP id 5b1f17b1804b1-4925a0a9b8bmr88810475e9.7.1782284908814;
        Wed, 24 Jun 2026 00:08:28 -0700 (PDT)
X-Received: by 2002:a05:600c:3b2a:b0:490:af63:2cb1 with SMTP id 5b1f17b1804b1-4925a0a9b8bmr88809375e9.7.1782284907436;
        Wed, 24 Jun 2026 00:08:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49260e14d0asm23280535e9.0.2026.06.24.00.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 00:08:26 -0700 (PDT)
Date: Wed, 24 Jun 2026 03:08:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Longjun Tang <lange_tang@163.com>
Cc: xuanzhuo@linux.alibaba.com, jasowang@redhat.com, edumazet@google.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	tanglongjun@kylinos.cn
Subject: Re: [PATCH v3] virtio_net: disable cb when NAPI is busy-polled
Message-ID: <20260624030656-mutt-send-email-mst@kernel.org>
References: <20260624070206.85467-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624070206.85467-1-lange_tang@163.com>

On Wed, Jun 24, 2026 at 03:02:06PM +0800, Longjun Tang wrote:
> From: Longjun Tang <tanglongjun@kylinos.cn>
> 
> When busy-poll is active, napi_schedule_prep() returns false in
> virtqueue_napi_schedule(), so virtqueue_disable_cb() is skipped.
> The device may keep firing irqs until reaches virtqueue_napi_complete().
> Under load (received == budget), it will lead to a large number
> of spurious interrupts.
> 
> Fix it by disabling the callback at the virtnet_poll() entry. This keeps
> the callback off while we poll and re-enable

and it is re-enabled

> by virtqueue_napi_complete()
> when going idle.
> 
> Fixes: ceef438d613f ("virtio_net: remove custom busy_poll")
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
> 
> ---
> V1 -> V2: Remain agnostic to busy polling
> V2 -> V3: Add fixes tag
> ---
>  drivers/net/virtio_net.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..0a11f2b32500 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3008,6 +3008,11 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  	unsigned int xdp_xmit = 0;
>  	bool napi_complete;
>  
> +	/* Keep callbacks suppressed for the duration of this poll,
> +	 * busy-poll need.

I don't know what "busy-poll need" means. Just drop this part?
In fact, the whole comment can go, we know virtqueue_disable_cb
disables callbacks.

> +	 */
> +	virtqueue_disable_cb(rq->vq);
> +
>  	virtnet_poll_cleantx(rq, budget);
>  
>  	received = virtnet_receive(rq, budget, &xdp_xmit);
> -- 
> 2.43.0

