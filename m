Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CDF3A83BF
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785448026; cv=none; b=KlV6w/xeHgynZV8HNNVJDDYeyrZ9ALb/EmLIYI4TKjzqiQ0/drI0T1glyRoPcrmeqw9vIAJKzFpqQa3qh1PRjHxzLj5hIlw2L8PIhhmEHfJDvcAvUagCu6lbEbLEFgKUeVROY8XfUcsLkJyALaL3rfAKK34idI9ZI1uGaR95A98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785448026; c=relaxed/simple;
	bh=w7iSUrEkyKIfpcXJr36ZtXbPrCa/n9wTF5n6WkXijcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZR5srbCeq4OKjz4ZboizJUiV2jdbnOdZSbkKzFUzw/vaTM4j4iNfD5wpkpltJlwoQ5kfzJe2gDRApYzcCmniDTKuvMf/bfOf7zeBMsbMHoLpIUIoaXRxQbwNTbm5rdoxbj1Pv9eoPrOspcMn+CDWYgug0WCU9OlOx9mHBz+04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX6wp9UE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX6wp9UE"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so3942245ad.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 14:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785448024; x=1786052824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HgSFHsXVsSy3LRIldCAG7H7RU31CdwstWIeTWGMAIC0=;
        b=gX6wp9UER48YblagjXnXhqdtDfisNlj0xYBiHmfgVnkn/la9tQQvXWATCruel+1yhE
         xImhh46q0Rwu6/ysRxWgYDrL3f1ltFMx8bF0Q6Kf1xWtzEBhBaXR9D2rT6ggjojzklK5
         3UwP0JTQdX/i8loJ9xKtxMJjvZPPKAIA9VBxYxYO5j/IWoEUfBJCQe54SnAErle8syoG
         8dnrygT0F0g2u1q9Cy4b0K2VETZKGWhcxMHDNNOt8eoltfb/NvKyQlTcb3rtaHUDKD4h
         evTe057x4Zm2k4cUb+quvjaQPFZ72pt3JhXGNub+K6NvXo8PmqKMGsB/gcQnubRfDXQw
         Cl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785448024; x=1786052824;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HgSFHsXVsSy3LRIldCAG7H7RU31CdwstWIeTWGMAIC0=;
        b=T45Sz2tlESlxbVkTWNkerCXJACSUWUnqroESkcbzJtKnz6H59OvrZI09DspoUpEdX6
         2EwO8J39BU7S5ZeKHtrwP5N9Uuf9/l7KyS+vpN4HFfzizVDkVF5ySGO5yLxN/acVVJPy
         lx8uUGfjikEbmCFnSPRn6xrLQEi4noSmjTpS13Wv3QQVJYUUaCpmg7C3CoNFRu3ASvbF
         Q3YA0exZYbly6GV+cFBsMZ9KubS0pKWMtpF1IL4qC2ixExcduFBD6/1bWhMGBAnQrNYR
         aDU9QPJ8GaZG/II+DYgF1lltGHNX0nBgs5X9Yzjb25gdAJDD8Gm9Hu7w+X1xi4hwDeOt
         z3/Q==
X-Forwarded-Encrypted: i=1; AHgh+RrT07znHOhOfwVY0Xk6OZBs83NtZJYiqruzC8L1qlsomKjlHNCVouYwllwFwDbmZdAAwaVNNc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHFn7v+jBKuRvUjoUizsr3zgJFuOHez5LwRt3f/fO6wdgq690/
	v9O6KJKnF41Ev3LvLkdXwfRcaCk10CakuD/WfdKZZRJqIpKc5TZ6jswTkAhrcqpB
X-Gm-Gg: AR+sD11yL6LWmAf184+OGtL64UImOP7CxdFxRpqkjrIkIVE6e6/zsrfpIYCv1og5oY1
	TQ3IIe4hgHGAaFNqgTSTSOiVH4VCOuXOJ+EjsrqMnV4qJzA9NrALAVCyQD0Cr7vP2Nt1QgEYqFJ
	YaqV+rOLQsKPUC0XxlgDRZMDd9mHNGNwbbf8eHUa8MDtV8ekv4QZuRKWLougj4ukzgvDy1t3CRi
	y3YZdaL+PRpz7bnVOg0TZRxVOQutAXzhZRBuzTG9etYaWonhFGyOFOb55v+DQAVoXoCGOV2uH6b
	7cue8FMXdZ5tuci8asriB/99BvP2ZTtsJYKK7q9mZ75yxdbvQfHuiTeOo0DFLLuxH9rceeckTrY
	6MjcmJHnMOXDXVa2aTZ7ICRHb97wUUQ5BGHxBsjBShwhA2wiTZ/tFqAdH9ZA8s9HlyOQhq0Jehq
	PxfF1O9xsOsEHUQDy7dQsN0olH7Sui2rLOksN8APXBpd6cDY/L6HqQldvM7+a+to9/XGkzVZr/f
	BSw2Ix9Ylg=
X-Received: by 2002:a17:902:f652:b0:2ca:a03a:29b2 with SMTP id d9443c01a7336-2d035b9ad39mr42104245ad.8.1785448023652;
        Thu, 30 Jul 2026 14:47:03 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:57::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a151fbsm31736035ad.10.2026.07.30.14.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:47:01 -0700 (PDT)
Date: Thu, 30 Jul 2026 14:46:59 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH v3 1/2] vsock/virtio: read virtqueues under worker locks
Message-ID: <amvGU9j4lHl7TnS8@devvm29614.prn0.facebook.com>
References: <20260729185831.3247971-1-bestswngs@gmail.com>
 <cover.1785352330.git.bestswngs@gmail.com>
 <e79f68ad9284c983364fc3ac46904b6d9ef50231.1785352330.git.bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e79f68ad9284c983364fc3ac46904b6d9ef50231.1785352330.git.bestswngs@gmail.com>

On Wed, Jul 29, 2026 at 12:16:54PM -0700, Weiming Shi wrote:
> Commit bd50c5dc182b ("vsock/virtio: add support for device
> suspend/resume") made the *_run flags transition from false to true when
> restore installs replacement virtqueues.  The RX, TX and event workers
> read their virtqueue before locking and checking the corresponding flag,
> so a worker delayed across freeze and restore can observe the replacement
> queue's running state while retaining a pointer to the deleted queue.
> 
> Read each virtqueue under its mutex after checking the run flag, keeping
> the pointer and state in the same queue generation.
> 
> Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
> Cc: stable@vger.kernel.org
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Link: https://lore.kernel.org/r/20260727035804.1860862-1-bestswngs@gmail.com
> Assisted-by: OpenAI-Codex:gpt-5
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 57f2d6ec3ffc..a8e1dd95ba8c 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work_struct *work)
>  	struct virtqueue *vq;
>  	bool added = false;
>  
> -	vq = vsock->vqs[VSOCK_VQ_TX];
>  	mutex_lock(&vsock->tx_lock);
>  
>  	if (!vsock->tx_run)
>  		goto out;
>  
> +	vq = vsock->vqs[VSOCK_VQ_TX];
> +
>  	do {
>  		struct sk_buff *skb;
>  		unsigned int len;
> @@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct work_struct *work)
>  		container_of(work, struct virtio_vsock, event_work);
>  	struct virtqueue *vq;
>  
> -	vq = vsock->vqs[VSOCK_VQ_EVENT];
> -
>  	mutex_lock(&vsock->event_lock);
>  
>  	if (!vsock->event_run)
>  		goto out;
>  
> +	vq = vsock->vqs[VSOCK_VQ_EVENT];
> +
>  	do {
>  		struct virtio_vsock_event *event;
>  		unsigned int len;
> @@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  		container_of(work, struct virtio_vsock, rx_work);
>  	struct virtqueue *vq;
>  
> -	vq = vsock->vqs[VSOCK_VQ_RX];
> -
>  	mutex_lock(&vsock->rx_lock);
>  
>  	if (!vsock->rx_run)
>  		goto out;
>  
> +	vq = vsock->vqs[VSOCK_VQ_RX];
> +
>  	do {
>  		virtqueue_disable_cb(vq);
>  		for (;;) {
> -- 
> 2.55.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
