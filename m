Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627207;
	b=Ur61ZVOX0zR697QPmCnd0Pnb4nZLJz3OMozZSJA+FAAxHRT7VA1L8QTd5ZkqIyYpR+/c
	 S4vkWC1vyXt4YuIkGa9MuZp/ufD3usiJl0whTwENeo+o0auFcofgZPLo9ZQ/D6kigeHwO
	 fLnOZnIyK5JvlgCFF+SG4oNkEYhuhVL7Yt+10I0fqoZRY7MIV+w2i+AAhOON1qobo4r3V
	 m32H2BjYia2r7kcIp4trPu5E0FM2L7syGz+mcYGi4iF8OaSofBLohv112abXlwuP/SUN8
	 bZ4M6KYzehotJ+F5CFOiZ0Z7n+gKiKUcgOgGKgsLljHRRyucEDJMHlnuhohdjf4/gbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627207;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=r00PHjeOPM8EiYAJ4n7o98k3BqG6YD5J3SM4dyyR34k=;
	b=RJqmptpv2J5FLsrIZgdD4NJCqNiyTtGdyzSWTyOacBclFH/KhPKWjNZPlMVNqTA5jPep
	 4XLlU53JqWhqzwHPdTCRblcSq+e3ix4aHbE4Rfh5/FBPsX/h083wE9hUXqQPeYl5lJSJi
	 B5dyYJLK6YKYXbQcnoxTdsOaZZ2/boSalyKN37nz9L7MPsp+2fYJQ76YR2GYoBqFvZLDj
	 gIVXnLpWbdMCiHdbhScetfEkeyiUWs4RAnU29Z1kpeIcXE5oxuTlhyjxP4rgScfp+MB27
	 NvxJ6I9KGHTNB+VsZQq39dQxNyK84HfrEl75181bOHBBGDp6El9PTC5yB7akd6lCr/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GuGH35Gn;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IdKAs3b0;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EE6606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 13:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71EE6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GuGH35Gn;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IdKAs3b0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793627205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r00PHjeOPM8EiYAJ4n7o98k3BqG6YD5J3SM4dyyR34k=;
	b=GuGH35GnpflFtzbKRHwSDhBNSIJFbDuyQElkz6wUSB3rgR/84vVI73+aClTHQ2W08KNm7y
	rDMkYfpcui3zQ3VGGyhx6tPiSkXS+OzSe3jMIExpnp/pZlZ1GJnKskIcR9OCBlUD8ln2uz
	uDv01m9NXsOl3QzbqoM9bFyNM1fKeoQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-fkDXn2gRM_O7tD-6_ThnJA-1; Mon, 02 Nov 2026 08:46:44 -0500
X-MC-Unique: fkDXn2gRM_O7tD-6_ThnJA-1
X-Mimecast-MFC-AGG-ID: fkDXn2gRM_O7tD-6_ThnJA_1793627203
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e0ef019a4so2555911f8f.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 05:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793627203; x=1794232003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r00PHjeOPM8EiYAJ4n7o98k3BqG6YD5J3SM4dyyR34k=;
        b=IdKAs3b0KXrxRinzERXP2dd0hFdSlhr/88682LtMRh2JDIBv8kZAfpn2gJGPaKNVSR
         Pgnrr5B2G7KTC3lXgiDDiOEvxcG1Y16lPty3z55XVFqqs4yNs1LYzZkfcz3NpjZnoOLC
         yeFk3vQ/sn/JXBfurO46bDhy5dTKOucofdMgGM92TLSfWNzNk9tOh/jSt9dx3TYMq+zY
         E8I495egnc+fkLaYcnJLQhCUlo0DwilEae/nIvzM2uU8y4mioE7MMKPbwnJ3ANQ1LbPq
         zuuJC5k7fJQsewYmgAsxidTW0gxC9X4tV9mK65roARN1+UAb3Lpzb0CjGwBZwsIqj8TZ
         ZamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793627203; x=1794232003;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r00PHjeOPM8EiYAJ4n7o98k3BqG6YD5J3SM4dyyR34k=;
        b=LKpHYoIbql5m1w7fJ/1McyUucAIC4AcO0fW31g5Ya+zub2VRdqffvIlErASaLgyY7D
         gmiYwmHQKJNZ8ofzXto+BvvS50sUKbvwUptCLksIVqjh6RXYnE4Um9THpDBwY7tp1OFG
         dp059C9twSN22UNJVDuiMyJVBvzrsnUfwejqSuY1M03AWmIdCzO2NBdsYV8bcz2mPACV
         D/fJ7uGARY1iHWe07xKUA3aidxlQMHtnQt02+s9sq9k+WjjwPlrEZLV1857pLHM6qEK0
         9ar7QDGUSPRTLOUQ7huDTzJgoxlZ5ULT2XmQ0N92LHJwP4PIaNyvID7E68cxveU/DyPb
         lrPw==
X-Gm-Message-State: APuU4Z9Sv+/m7vE4EZHZ/eMeC9R3UbuFvfa25R6ae9UQH8jZ0ciFO/ns
	A/0N1YI66a7Szxg0U0cRFUYIpU9NQpDxywZq/eXJ3Zg3pQWRnuMjTGPeL6IkY0i1cU3tm6MthR9
	26qZjkpnra1h4FKO8hVeZPIYg6cVMo59L0Fma/6MpxIA8Lm1wxsAChj6xYnT7MhIdDA==
X-Gm-Gg: AYBFou0p1xaQLt6do5uGNR2czvOj4jWFautfcSRLu8HYbXVxndRRxMv1VUzsowAc+7m
	YJnnw1XV3Alg/qdRtcltUAlB9ewxPJGXzivn48LPTy5jnHPT4umSpjZyaeYFQT9gg1R+oZAY+av
	qIpSiEhJDrfpGbytRCGzKCMTnT2axCF+1PIqvtkjuecGFU/TmFwuBhwA5j2KsDrrx0jgD6PB4SE
	7zN23utA9g+Z5ccmw/0Ih5HhnyrKa/K6nuVZ318UcW6pDfb2cjM9D8+aRi56KIdKWuF85b3Dr6Q
	czjqZbnkZnPw73952dMvNKruqpzBs4WCJ/T5sIxQdlZwyy0VW17ThMzZfzutt3mXTC5lyedJWzq
	wowmm3IyC2RYuBm+Bt1qJ64pVET4ZDa+Sh+7VYzHsIA==
X-Received: by 2002:a05:6000:24c5:b0:48e:6264:c373 with SMTP id ffacd0b85a97d-48e6e4f5798mr24880374f8f.14.1793627202782;
        Mon, 02 Nov 2026 05:46:42 -0800 (PST)
X-Received: by 2002:a05:6000:24c5:b0:48e:6264:c373 with SMTP id ffacd0b85a97d-48e6e4f5798mr24880306f8f.14.1793627202211;
        Mon, 02 Nov 2026 05:46:42 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80333sm21533707f8f.32.2026.11.02.05.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:46:41 -0800 (PST)
Date: Mon, 2 Nov 2026 08:46:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jianlin Shi <shijianlin11@foxmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, talgi@nvidia.com, hengqi@linux.alibaba.com,
	horms@kernel.org
Subject: Re: [PATCH 2/2] virtio-net: unwind VQs when irq moderation init fails
Message-ID: <20261102084624-mutt-send-email-mst@kernel.org>
References: <cover.1790751008.git.shijianlin11@foxmail.com>
 <4e21386a0840526578eac3dd10443758bf3b84e2.1790751008.git.shijianlin11@foxmail.com>
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
In-Reply-To: <4e21386a0840526578eac3dd10443758bf3b84e2.1790751008.git.shijianlin11@foxmail.com>

On Wed, Sep 30, 2026 at 04:19:52PM +0800, Jianlin Shi wrote:
> virtnet_probe() calls init_vqs() before virtnet_init_irq_moder().
> The failure path used "goto free", which only calls free_netdev() and
> skips virtio_reset_device() and virtnet_del_vqs().  The virtqueues and
> their DMA mappings leak.
> 
> Use the existing free_irq_moder label, as virtnet_create_page_pools()
> already does.  This is safe only after net_dim_init_irq_moder() clears
> dev->irq_moder on failure; otherwise virtnet_free_irq_moder() would
> free the dangling pointer.
> 
> Fixes: dcb67f6a9ead6 ("virtio-net: support dim profile fine-tuning")
> Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>


I expect v2 of this.


> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e34c52d059d3..ef61097c4404 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6996,7 +6996,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  		err = virtnet_init_irq_moder(vi);
>  		if (err)
> -			goto free;
> +			goto free_irq_moder;
>  	}
>  
>  	/* Create page pools for receive queues.
> -- 
> 2.43.0

