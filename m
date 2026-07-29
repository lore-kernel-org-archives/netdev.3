Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73550459AC5
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336277; cv=none; b=GKAYsVrd8CAynx1cQkRTUMQD6634cDCZeEB+yabiK9W+Tuz4dmXOdSczpN5mIQo0yfCVQyzIsIYa8OkMHy+wOgbN2DY4PPK+3rWKhpj5C4bqeWnrUa5o+3xLcyw4uzjvF5in3/VeYwEqGJzTOaFtitkZpqaFW8+89ht/1f71iNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336277; c=relaxed/simple;
	bh=BJS1HA8rokFIiV0ne5cRaLj+3cbfWQFKkW4X/b+NT0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzlcIixhJmEfvVBSAeS8IHBLURSDuJjvC5/pnVSZOMlrKxSRCEMFtrqmUSY/aulSkWvhXWElgh3rUIKdIes7037i7eXJdyD8gU2Va0GpAqdiJ1/scxEJFcWNdzoLXYYQfITJxW37EFuDsZmDR9ooPPE3RetI3oqUqFKcPlmxQKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNWcPWPn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LdpwD0qW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNWcPWPn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdpwD0qW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785336274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5H5BXZFmwChe72ax9v3fx7rbm4FIcGAxuXQx1+sJiZI=;
	b=YNWcPWPn9bvAPNDTNyD2ILT5WLEI7d/1jOq4dpgpaLzenlwxMGF/XU2WLVa/vLq1u6VZKJ
	g+ZOI/W2pWL6E13TVrj9aatcGZ3t2u3miOaCvVp26h4zpIWMhRQCJrx2qQ02AyOdegEs7j
	C/6E8lnswo7449EYUtRc1NypluOrXHU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-hgMBF3DsPxi8Yy4vpMckKw-1; Wed, 29 Jul 2026 10:44:33 -0400
X-MC-Unique: hgMBF3DsPxi8Yy4vpMckKw-1
X-Mimecast-MFC-AGG-ID: hgMBF3DsPxi8Yy4vpMckKw_1785336272
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4955d314945so7428225e9.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785336272; x=1785941072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5H5BXZFmwChe72ax9v3fx7rbm4FIcGAxuXQx1+sJiZI=;
        b=LdpwD0qWphlkCEBxQYrOyS6FkvxzQKoLILQlGrnVFFL763mILU1nefBW7SlHcpU+F6
         PjsWBFtIiA5eajvFseDlOKCMEAcaW5LJFbXiUOBs74aiww/s+Z87klLkY/Y+rhzwSR8k
         r37Lha8dRLpCV3ekeHsespKsfqWahPFrN2YlbPI7ad38HSW684mQYfpFwdyhNZcI8ra+
         uGqzah5sS2rSy9osSn3Gx5X54MNQCKUqy6sM6s7R2OU340BUNGqWlJeiKkdZOPY+F/MX
         2lpxXmvTyYOGArBoPERg7O/d40hNo1FtNK6OpUs4P7806N6wrqoMsJIsyTA64/53k5Kk
         EVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336272; x=1785941072;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5H5BXZFmwChe72ax9v3fx7rbm4FIcGAxuXQx1+sJiZI=;
        b=mzctf4uwEEG7Pt2RDfL/3ASLbQsHI8ohIEARoWU0jaqokYiZbC4Kg6kh1cYFYfNKp5
         JxXlSSCBMtvlRBMdb3PEIeCJB0IgTlAOpYWHv3PLoP8045+zfVtSvAq46XpYnrIy//HF
         FW7VyHhlQPSwxUhRLmHVaAIRr9mroNu8bvt+wA62T9qqmnu/Np7zQOI/fQg4kNjmBwVT
         PCgoMbA65syqKBJbMNR5f+49Z7F/nogaYVmLSH1bLE7FlPk7GmvkxznKEc58kvHwKO0W
         N9wPNeUl3gKGmpbF+Onbv/0B5ic40kB6Dfq3rQWxmhOYhce9cXJ69oILb7nSTeeNgRbC
         1KoA==
X-Forwarded-Encrypted: i=1; AHgh+RoA2/C4BCuJKxm8ZSaUv57VPZNeMeYuwEOuWd48VSxPBWaP7SbCebu1hOE9Kl/r6itGTB0QfZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWHECBAtpw1P+ZxQFcA9sV/FAWc0SzLgQWKf7yKLaUiU5pXt9K
	bFY1eQnOxhIk6c7OAbziD6N9IJfN6dMLPsDbQsk+gl7J76DoHPxrWAn0PMm3Xq0K7nANeyFMaCj
	Vk8fkXcA5A7I66PVbUJ4gA+8RYcnAxFXeH2fzHkKSgFncOg2zOHAHKF4p9Q==
X-Gm-Gg: AR+sD12tnr8hNRut7qjog/GkVLIE18vhhc7x2q5EOacZO6cadTSr05aNTnhudGO/M6F
	tH2Nx8MnlUnMf+W58EFPoLikq9rFDIMHYS604Lc+mqiQvAbDU2avDYJCJDQjFzakblbOZEABzFf
	xWE+PuHmny2W/7FtrasoJLsAaBx6dhONEI4xmdOQnGe18Dd/lpLntEW4oLpilSJGxdnGCW6gGB5
	pPfnn+/pu0dGvqcstwLnnWBNDaVs24NEEhrN6Ql8BxS26g0tfHT63JToJsSH67LstwI08hgNnaF
	73zk8YPdop1ztLiKe1TEbiDySFHhqgslDG2UboJxar29m6OPJ75k/eH9Tu1M5t/ZGbJb4NTIOXB
	rLIf0K6q0Blf7O6EjPqq++SpdBKe3NccnUdi1hxX5U6s=
X-Received: by 2002:a05:600c:c162:b0:495:7285:a498 with SMTP id 5b1f17b1804b1-496c656540fmr82603525e9.18.1785336271628;
        Wed, 29 Jul 2026 07:44:31 -0700 (PDT)
X-Received: by 2002:a05:600c:c162:b0:495:7285:a498 with SMTP id 5b1f17b1804b1-496c656540fmr82603015e9.18.1785336271121;
        Wed, 29 Jul 2026 07:44:31 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4976bd52f3fsm36693245e9.0.2026.07.29.07.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:44:30 -0700 (PDT)
Date: Wed, 29 Jul 2026 16:44:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: prevent workers from using deleted
 virtqueues
Message-ID: <amoPm0aVfnadsJaF@sgarzare-redhat>
References: <20260727035804.1860862-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260727035804.1860862-1-bestswngs@gmail.com>

On Sun, Jul 26, 2026 at 08:58:01PM -0700, Weiming Shi wrote:
>The RX, TX and event workers read their virtqueue pointers before taking
>the mutex that protects the queue and its run flag. A work item delayed
>across freeze and restore can therefore retain a pointer deleted by
>virtio_vsock_vqs_del(), observe the run flag for the replacement queues,
>and use the freed pointer.
>
>RX has an additional path: when rx_run is clear, the common exit still
>refills the RX queue. A queued worker can consequently call
>virtqueue_add_sgs() immediately after freeze deletes the virtqueues.
>
>BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
>Read of size 4 by task kworker/2:1
>Workqueue: virtio_vsock virtio_transport_rx_work
>Call Trace:
> virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
> virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
> virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
> process_one_work (kernel/workqueue.c:3314)
> worker_thread (kernel/workqueue.c:3478)
> kthread (kernel/kthread.c:436)
> ret_from_fork (arch/x86/kernel/process.c:158)
> ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>...
>Freed by task 141:
> kfree (mm/slub.c:6566)
> vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
> vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
> virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
> virtio_device_freeze (drivers/virtio/virtio.c:658)
> virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
> pci_pm_freeze (drivers/pci/pci-driver.c:1098)
> device_suspend (drivers/base/power/main.c:1968)
>Kernel panic - not syncing: KASAN: panic_on_warn set ...
>
>Read each worker's virtqueue under its mutex after confirming that the
>queue is running, and only refill RX while RX is running.
>
>Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
>Cc: stable@vger.kernel.org
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Assisted-by: OpenAI-Codex:gpt-5
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>---
> net/vmw_vsock/virtio_transport.c | 14 ++++++++------
> 1 file changed, 8 insertions(+), 6 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 57f2d6ec3ffc..79cf19f58943 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work_struct *work)
> 	struct virtqueue *vq;
> 	bool added = false;
>
>-	vq = vsock->vqs[VSOCK_VQ_TX];
> 	mutex_lock(&vsock->tx_lock);
>
> 	if (!vsock->tx_run)
> 		goto out;
>
>+	vq = vsock->vqs[VSOCK_VQ_TX];
>+
> 	do {
> 		struct sk_buff *skb;
> 		unsigned int len;
>@@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct work_struct *work)
> 		container_of(work, struct virtio_vsock, event_work);
> 	struct virtqueue *vq;
>
>-	vq = vsock->vqs[VSOCK_VQ_EVENT];
>-
> 	mutex_lock(&vsock->event_lock);
>
> 	if (!vsock->event_run)
> 		goto out;
>
>+	vq = vsock->vqs[VSOCK_VQ_EVENT];
>+
> 	do {
> 		struct virtio_vsock_event *event;
> 		unsigned int len;
>@@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 		container_of(work, struct virtio_vsock, rx_work);
> 	struct virtqueue *vq;
>
>-	vq = vsock->vqs[VSOCK_VQ_RX];
>-
> 	mutex_lock(&vsock->rx_lock);
>
> 	if (!vsock->rx_run)
> 		goto out;
>
>+	vq = vsock->vqs[VSOCK_VQ_RX];
>+
> 	do {
> 		virtqueue_disable_cb(vq);
> 		for (;;) {
>@@ -689,7 +690,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 	} while (!virtqueue_enable_cb(vq));
>
> out:
>-	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
>+	if (vsock->rx_run &&

Instead of adding this check, what about adding a new label...

>+	    vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> 		virtio_vsock_rx_fill(vsock);

out_nofill:
> 	mutex_unlock(&vsock->rx_lock);

And use it when we check `vsock->rx_run` ?

Since we are taking the mutex, we don't need to check it again.

The rest LGTM, but I agree with Bobby about the split, since the Fixes 
tag here is confusing. I'll reply there.

Thanks,
Stefano

