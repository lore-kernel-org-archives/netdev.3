Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBBE3EC81A
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367249; cv=none; b=JGLCVBa2gUKhMHQtwiNTAe08AyTgyML33usnDcmlpG/LxIAlYz0WN6dn2PNPNWj/vcSHKLFhBevtPH6jmnqWQ1VpFKKRrk0cLJDtoiTa9B3Il/yEvWw21si0Hfln/UpdujyE6yHbRuElU7YwO87pQ9tzXqpjKRjsCWq9zSXXM7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367249; c=relaxed/simple;
	bh=Tsj2LyxhGGK2KN6sB3xFHKF7hvfCO/DiO5qQdGZhda8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iYd/KsMnSWyg+ctIMpivKkjZ1Qx7Rnpb2sG5s3Zm66HbQEUEByF/tl3j8Dhp/RUXHNOxwM7K08j5uBJAsnX34p+LqU09zG0fGRJ66LH8IaTIKj0TBEOJZkgdL3aCbKfih9CmMVGc2n0IdSBpVUEtcJKAe4Bzp5VMk7wWsbTj2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qxJ7wjOb; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qxJ7wjOb"
Message-ID: <2aef652e-d98d-4ca5-8270-5f108e5593a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786367234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nEpLZt3LoZTFzzcI8wHc8o5Fj8Pf/NyxHhgChDYP7U=;
	b=qxJ7wjObkIj5YB5gUStZLpWZeXxY6QwUms0z4MKJ7JFPjk33YkciSlfZip7yxAUgmvUR7f
	A5F6bWcjLoqNZuVJaQm+UwjZjg/Nh3l9prI3BOPiszVgEzWGBoJW9VxtjriYsehlTK3Wt1
	NO5uEH/cOHDn3WGrDCdipCBJ5W1FqBc=
Date: Mon, 10 Aug 2026 14:07:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] virtio_net: Fix resize of the RX ring
To: Anton Protopopov <a.s.protopopov@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260810120728.47445-1-a.s.protopopov@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260810120728.47445-1-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/08/2026 13:07, Anton Protopopov wrote:
> When a AF_XDP socket is attached, the virtnet_rx_resize
> should resize the rq->xsk_buffs XSK buffer array. Otherwise,
> when the size grows, the virtnet_rx_resume() causes a write
> past the end of the array. This is easily reproducable with
> 
>      ethtool -G ens3 rx 32
>      ./xdpsock -i eth0 -q 0 -r -z &
>      ethtool -G eth0 rx 256
> 
> Fixes: e9f3962441c0 ("virtio_net: xsk: rx: support fill with xsk buffer")
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>   drivers/net/virtio_net.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3e2a5876c6c8..e34c52d059d3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3444,17 +3444,31 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
>   static int virtnet_rx_resize(struct virtnet_info *vi,
>   			     struct receive_queue *rq, u32 ring_num)
>   {
> +	unsigned int old_ring_num = virtqueue_get_vring_size(rq->vq);
> +	struct xdp_buff **tmp_xsk_buffs = NULL;
>   	int err, qindex;
>   
>   	qindex = rq - vi->rq;
>   
> +	if (rq->xsk_pool && ring_num > old_ring_num) {

why do you cover only the case for growing buffer? Don't we expect to
free some memory in case of shrinking? Should be fine given you are
swapping buffers completely...

> +		tmp_xsk_buffs = kvzalloc_objs(*tmp_xsk_buffs, ring_num);
> +		if (!tmp_xsk_buffs)
> +			return -ENOMEM;
> +	}
> +
>   	virtnet_rx_pause(vi, rq);
>   
>   	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf, NULL);
> +
> +	/* virtqueue_resize may have changed the size even if err != 0 */
> +	if (tmp_xsk_buffs && virtqueue_get_vring_size(rq->vq) > old_ring_num)
> +		swap(rq->xsk_buffs, tmp_xsk_buffs);
> +
>   	if (err)
>   		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
>   
>   	virtnet_rx_resume(vi, rq, true);
> +	kvfree(tmp_xsk_buffs);
>   	return err;
>   }
>   

