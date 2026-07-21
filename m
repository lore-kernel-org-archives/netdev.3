Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66403425879;
	Tue, 21 Jul 2026 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616795; cv=none; b=NKtbv4DNT8MT9B7d/FxLkqRGnD7Im7u0CSzvQDyjXMaL3svaAIQVQr/rI6V7QvyCl90W5+bcrKC9Kw94XtUVjBDidQPIHMVeRPQI+5Rf7qZ3P5KjZ8Pfg8Xdu2+aoqaAuAz0Iv+Hht4mpkQmKUrRfUEla4gL5uevs+Y/5Dc2omk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616795; c=relaxed/simple;
	bh=XK+6qBK8hlvGTMcimu688/QHHn8GVcgS7Jar29ppbrs=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=oDiLZTVWppZV6yHg2CunxOdyqCXs37UPUANWWrcD/MIXvLGBWhOu9Mk7NOiBQlwFg/9kN5s2VZYdg7duiOTE9UF8QBDbx7qYqwsG0oTosI1/O8CMd0K3k0CKuBCbeOeWmjwZ/DPkNiH+RPInwpB/9Il0QFVZrhDEDMT17baeSfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oZaF9omA; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oZaF9omA"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784616782; h=Message-ID:Subject:Date:From:To;
	bh=F/Jpfod0I1c6EQREYl4OwYRIfntLRTx4KUFuboi4cwg=;
	b=oZaF9omAv9Br9IRxUT8vMCLh4S3L9HLwuSlb9Vx4HMHEX1OL/cyBWEW0xIu+TUKw+IPhQpJd73R5nWHbpRGroobL8ds/EjOqlYr9JWLegpYE0Vf4+18sWHueihZ6wFltaLAvq6MRnPdYu5s8xBwec3lQC6f/M7v6Gn9fYCbOaBo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0X7Z0f6J_1784616781;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X7Z0f6J_1784616781 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Jul 2026 14:53:02 +0800
Message-ID: <1784616772.1884272-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2] virtio_net: fix infinite loop in virtnet_poll_cleantx when device is broken
Date: Tue, 21 Jul 2026 14:52:52 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jinqian Yang <yangjinqian1@huawei.com>
Cc: <netdev@vger.kernel.org>,
 <virtualization@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>,
 <liuyonglong@huawei.com>,
 <wangzhou1@hisilicon.com>,
 <linuxarm@huawei.com>,
 Jinqian Yang <yangjinqian1@huawei.com>,
 <mst@redhat.com>,
 <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>,
 <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>,
 <edumazet@google.com>,
 <kuba@kernel.org>,
 <pabeni@redhat.com>
References: <20260716035201.3736582-1-yangjinqian1@huawei.com>
In-Reply-To: <20260716035201.3736582-1-yangjinqian1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 16 Jul 2026 11:52:01 +0800, Jinqian Yang <yangjinqian1@huawei.com> wrote:
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

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

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
>
