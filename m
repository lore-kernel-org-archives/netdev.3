Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F6345CBC
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790532833; cv=none; b=PCMPDdCrzuibkML0y7XnTyOM2tPVB27I9KFThpESdkens+6d3XHyi3t3c+VnhvQ1kjX8G6NzEld/AHNny1qh90+8p0DAgXQPgkS2TdwK2yiV/H+jyn7ckPKAhJj48ZMkMg/uVuVaCdHkY975K7JZ/UMNmU3TB1ZvlbaCsOEr1Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790532833; c=relaxed/simple;
	bh=3oTqZsbJwBRoOJpwLKg7GnbiVVZPitNE8J6RjqQk/4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXDCjqY8kFoVEDa+55Hi6JHguyGaQBy7a/gFjbddms6nTC0IC7yeLS/7vVbUZlUIbzU7TqljMXXv2hGW/X0OJTLsD8zLaKSU4YPVLgOXF52fwlIjABtRQYyzG90ohJQnx6xzW8kFuqRAovpTdYa0ail4kAzJimU62uS6ORJXubU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JF9gFlGp; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF9gFlGp"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso17352655e9.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 11:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790532830; x=1791137630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yF3ar6bs1d3X9n2jCLXGnKhuTUv7JBFcQdF8WKwyH2w=;
        b=JF9gFlGpgwPJb82PVdfCZRfJ3WDPJZTdO4VhQ/I64R3nqQyNoHTIU/TUvxW944Tf8G
         gdtXvAsgkx1kTuIVShCwvkuPvzbySf8OqLTsXMNY8ttU574BLotez4mM77FWagv5ESm5
         a+XMKtIaOTAqqTavfP8qSxxjUWqJ4gzn/O/Mp3TJ4Q1zh1A8XnhxAE4ZKuwruXtxztmV
         K3hl9eRg0uWIoQWI1HE6DwZUIACZdUpZjrtxuQ1slvCzwz06+ek0JEwyg77OXAadJg9B
         ZewnVUsTsGUQcRjvbLKi/3vDn5Ak9EnuGPoNpx+JVtKMw0OqK/cWttbkbSl6ijFROE/+
         IUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790532830; x=1791137630;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yF3ar6bs1d3X9n2jCLXGnKhuTUv7JBFcQdF8WKwyH2w=;
        b=IgSQi2H1dHbZnfp3BskOROOxnLiv5rO/pxJAx31CmvAQZ8HJqErhWjZsbTfa7opoA2
         VGtwuLkTS+ehRDSTDUMwxI00N8hnK1nezKyiY3eIBfDr3JlVc8UV2GVOI6/u7xZHMR8a
         jjPjx2A9uoBvt0JSE2bTxNqpKuDM5fc0RA8CBo6RfkeR3Cr6dmY62JfLqJIDau6Q6TaZ
         ZP/4LrcTgikhXgxtOF59B6tGMiKhWFuw6V9g/7Deejpb61xlRK6inHS/08GUsyhC8zTR
         TmSwbnYUaqgVf63dw5BAwASOFhQu5COhDAPocJ0FwwA68FEV1JgaznF5x41sfC4QsFcm
         6S3A==
X-Forwarded-Encrypted: i=1; AKwUvByKriuYVYxNFWe8AxPoH8NabJtu6EEysspPrsUK6RBi8jNBOdBNj35IRS/Kj/EofNUlHMx+dNE=@vger.kernel.org
X-Gm-Message-State: AFuF++mQ70gj3DQ4aCtajt0WRWyapOFODN0f3tjL+SJC7ZpOMDkNI3yI
	ymYWk9ZsHwaJa8V9hB6CRgqg/HgPxFUmeUM8s3QVkiQ25Eo1XSEuTu07
X-Gm-Gg: AYBFou35wzLXuXdF9HeCg9GOKPjM7a5eXA4XwPVwaWtpvolfDmgIIxOwRFL+0KLtc1w
	vOAxv/zSRuwnUXdOK4ckxv8DyueKidRhJbW1HUG5cIkP+uq3sG9+/tNqDjw0FUVpcuOnIl71QR3
	09kc55lyqFsg64NZYna0t6ZR8uqk34T6SyiYbIpuv7XAfLQKS9+4Qd/63Ws0MudnYzORFTP4su0
	uwqDetvOTRdWIgg7E3m8SVTjUfSaOnrk5C/pKGMMbVuTaMU/bPIdCRkoI+t6YnV5P/LvbNHKzHW
	L+fFfTwHXJjJWmSCCeHTgNktwASEcp6E39/k7nHWG6Y9RH3Af1JeenpNSJLxQsG16pWLOmtdD/N
	FOnn0bazhVmWSUh1+jNQbaG5jCPz4cKn1mcB2Rl3GQhUK0xgRw3J/M4RvaYdWs/AwSHrYcNT1+P
	McLJpbDg8SiW4vXlKo8nqgyZrfeIfA8RU8bEXJYc4SJU+x0+DAGpjqi0zwu3DM740/WWd8snWXX
	ba4Zf69hVFsD0lU9a5irnOM3nQRTk/CVP+dJ+f0QnzT9x+hmpB5WkReAksy7DQeJlaX+e9wzXpv
	SUw/Qpvy8mwZTI/e4MBBFOLi6/O0hvmQqBqBRwBfOixHDnJC
X-Received: by 2002:a05:600c:1d06:b0:49e:69ff:c6b1 with SMTP id 5b1f17b1804b1-49fe7bcc25dmr179111265e9.31.1790532830326;
        Sun, 27 Sep 2026 11:13:50 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff141948dsm89612395e9.1.2026.09.27.11.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 11:13:49 -0700 (PDT)
Message-ID: <e6421d43-3388-4e02-aece-42fb7034746f@gmail.com>
Date: Sun, 27 Sep 2026 19:13:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: devmem: use memory provider helpers for
 net_iovs
To: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org, axboe@kernel.dk, sdf@fomichev.me,
 bobbyeshleman@meta.com, almasrymina@google.com, kaiyuanz@google.com,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20260922204348.717198-1-sdf@fomichev.me>
 <20260922204348.717198-3-sdf@fomichev.me>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260922204348.717198-3-sdf@fomichev.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/26 21:43, Stanislav Fomichev wrote:
> Use public memory-provider helpers for DMA address storage and page-pool
> association instead of open-coding page_pool state and accounting.
> 
> Zero the net_iov array because net_mp_niov_set_page_pool() ORs
> PP_SIGNATURE into pp_magic. Reject DMA addresses that cannot be
> represented in net_iov metadata.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

> @@ -247,7 +245,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>   			goto err_unmap;
>   		}
>   	}
> -	binding->area.niovs = kvmalloc_objs(*binding->area.niovs,
> +	binding->area.niovs = kvzalloc_objs(*binding->area.niovs,
>   					    binding->area.num_niovs);
>   	if (!binding->area.niovs) {
>   		err = -ENOMEM;
> @@ -274,8 +272,12 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>   		for (i = 0; i < nr_niovs; i++, niov_idx++) {
>   			niov = &binding->area.niovs[niov_idx];
>   			net_iov_init(niov, &binding->area, NET_IOV_DMABUF);
> -			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
> -						      dma_addr);
> +			if (net_mp_niov_set_dma_addr(niov, dma_addr)) {

I'd do this chunk as a separate patch with stable+fix tags to
keep it minimal and help backporting, e.g.

if (page_pool_set_dma_addr_netmem())
	// fail;

Looks like the bot was saying the same (with an extra wall of text),
but I guess it depends on whether you need it backported.

> +				err = -EFAULT;
> +				NL_SET_ERR_MSG(extack,
> +					       "dmabuf DMA address cannot be represented");
> +				goto err_free_niovs;
> +			}
>   			if (direction == DMA_TO_DEVICE)
>   				binding->tx_vec[niov_idx] = niov;
-- 
Pavel Begunkov

