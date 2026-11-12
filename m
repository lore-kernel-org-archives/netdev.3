Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523914;
	b=SBBt6ztxR66yw2h66nQXDy7l6X59Kbk1eqvQBVjPy5ogSmk90+/UR2XZI9r0fTS66wKn
	 mZRPAXexr6Q5KQ4S+kRYzzywspQErXjrk6HHOwUKu6ybKZ5SgbpZO4uDm8uWOKUZfdzf5
	 ghuTQZquqDZZ8Xc/KHrQt2GA/t/nR3r77V60DXLYV1ufhE2sc8tnlU5IC7CyhRZxU8UZt
	 4bRRqS8TUns62Wn0alTQ37HRdCOXdtu+fNXEdZcRMOzAnGocv/MZKH6sq1Qt/zqxiI8SQ
	 LRAuP3o7A4A0BrKsAFFTG2ahhBcry2C/3xbX8nQcpX/gaZWrZhmX6GOEcRdDS5GDJIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523914;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Co334PnVZfKPspzdaUWaBSnFnvG+s4uoTlNQvW8yi/4=;
	b=CC0L3sf2wjeUtA6UhiE2jctUlKee28M/RrTAy5BCqIIr8QOVcCxWmZL+SoLqhZ3cO+qn
	 DxAgUuv8iI/0u82q4/S8lqRaUGH3ccgGDetTBitoyzh3sqKmXZioXMKuVHd3uAEkm+W6H
	 /qNedB0X5MJkqnxp1E7GOtnZr77iIhKdR5o1PsL3SQjrWvCPyFjHDqZMlbJ6CTPjLDRNb
	 Iw7/ik1+xp/bZuUofK3SbtHd3y1wztu5+S2MZcDmj4lij4T6DHv4OZ90Y2Ys5dRDJhCUp
	 QwAlhxxBscTjG4QuvPaoHgIuoXuM7SH5VLZbKa3pe81O5UAy98AkY9ljvilRpub0X5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UgrXVnum;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ldI6g9O+;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5188606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 22:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5188606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UgrXVnum;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ldI6g9O+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794523913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Co334PnVZfKPspzdaUWaBSnFnvG+s4uoTlNQvW8yi/4=;
	b=UgrXVnum0bCruLJ90rTjeREjoOMORFue9hrPG758w2e0ocAz8UNBE9+gog5Fo0nMXgsdl3
	ZKBs8eptJlx29vMuCtGuLpi1Z+NnyrqaYunT0tOvqyQUw9GMQoUinT2C/ibudDmdYGnB51
	K7NgHqbTV06NZh9HFlp0U9k8uTFPO3g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-HzZSYR_DPjqfnJJj_WL7mA-1; Thu, 12 Nov 2026 17:51:51 -0500
X-MC-Unique: HzZSYR_DPjqfnJJj_WL7mA-1
X-Mimecast-MFC-AGG-ID: HzZSYR_DPjqfnJJj_WL7mA_1794523910
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a17741243eso1417095e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794523910; x=1795128710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Co334PnVZfKPspzdaUWaBSnFnvG+s4uoTlNQvW8yi/4=;
        b=ldI6g9O+pJ9gGBEPmzZzPDcWrNZkpH5CiZXo7/oLwboHmJ0Gss40UrmhGN3e/WW7+m
         8hmDCv2T4bTXqmVSN5oMCZQiLCOqzXMh99kFbwJEY+YOfHVre57nLSJVbTYzsaeXBlS4
         aBzQkx6Auv59JTgFC2sOfXLxU8BNAc1KOxHvxxuRA0NUjK+EQo09fQIarMeLfsaBcZwI
         xZd9Pj7YAbaAbDSIJaoc5Z4BN3azk5sLXzuagmeCvB8WnKUarjPHwYscEYbWxnlpD3f6
         qDPK+BrZIBfGlTdMNxIs/ULVoYjDmjo2k7sY/NWFPXfZMUlTh7hEY1l+n7bRnPbqtOsX
         nzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794523910; x=1795128710;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Co334PnVZfKPspzdaUWaBSnFnvG+s4uoTlNQvW8yi/4=;
        b=QbvQ6rY5vA98T3NCV0CBqnUW7Ogl9FmszRSQg6Vu6df1jq7zD9+w40BAt0vIOk/MDw
         TXDdFJxTgoPXbVaBqKtbya+jgbU+MOxrhpWmYe7H3fo9Rr9f11+snKwf5xmgRfyY0JyY
         2WTAFVyPmwKwBXQh61VOo57AcakgsnaTo0YlKg5/Z0NSYhU6bVfcnFvKwFwfgbppdUKs
         beUDMKEvelL4GEmJjAaQnskGU5P4K/o9/q33hzxMolKNxM5KF6NstDKyJZiMvHvIz/1c
         BXmsz7gsoWujPc6OHudovSeFhWbMsP+kWobrv0EotZD8ZwySFs+EbNG6YChtCtlHV2Yu
         oJFA==
X-Forwarded-Encrypted: i=1; AL+hErE4FVPAeC25xu9/qjXD0gNpP1Qd6o5e3CHZcpTrvwinLhvhcFWpTZSOsTSnmThIYVUoXrFNSDQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Hz1/9WSIa9Q9gI3dtMd9yNkf/vxsWJzSxRifaQRUOWd9u2eCJ
	oOs1idiPp/7j6B+2x87bVJpJBEsCI5g79yPkExMsMkKv7lRNvtpTL8iJ29CwyN5JBoPDIhXUNt9
	/LbLj7ejFXKOuSqgutIJv/BRB4k0WIOLZDNJI0/TG9aaOBV7qEzvfHL3FeA==
X-Gm-Gg: AYBFou2IXLw6SpQMnNsNlqBvXl1RkQ73ehJf1/7lBKJOxfdTvhNXcvcPQHZ0DM8O4YC
	ygJdTNTm2Nv/uF9sZW6gss5zlowSqnLgDIoVjdKIf6QUB2s+81DqR9kB+c9amb/5GFKLCZGXCLB
	4WzTOqWRxGyDrp+Mt3+IYlWE2mg0xyF+X4MGWiXT2wsDBAM4wwOroJYkPCoqIOcchXizM/0X72/
	woZJJ1ux4I5fstBKeGTfkRgFouyDDM3lI8VldYcsw58Ovvo74xkvBnhSvj+IxueQRkvezyE8cdJ
	x5TZk8voY7cynb+9bNcPnV9HbGSytov3b1CPqbu2o9GD/rgG2/4qpoiGXQz/ttVuvD2o8VdNQ+/
	pH8mZBOSowDfB5ldSdwbzf/1N6kJDRc2LSw8cBpF8Fg==
X-Received: by 2002:a05:600c:16d4:b0:4b7:6942:39be with SMTP id 5b1f17b1804b1-4bb55a6626dmr10367715e9.24.1794523910265;
        Thu, 12 Nov 2026 14:51:50 -0800 (PST)
X-Received: by 2002:a05:600c:16d4:b0:4b7:6942:39be with SMTP id 5b1f17b1804b1-4bb55a6626dmr10367365e9.24.1794523909636;
        Thu, 12 Nov 2026 14:51:49 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55af2a9bsm13836835e9.14.2026.11.12.14.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:51:48 -0800 (PST)
Date: Thu, 12 Nov 2026 17:51:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Longjun Tang <lange_tang@163.com>
Cc: kuba@kernel.org, eperezma@redhat.com, jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, tanglongjun@kylinos.cn
Subject: Re: [PATCH 2/3] virtio_net: introduce an RX queue watchdog for stuck
 detection
Message-ID: <20261112175123-mutt-send-email-mst@kernel.org>
References: <20261109094310.103979-1-lange_tang@163.com>
 <20261109094310.103979-3-lange_tang@163.com>
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
In-Reply-To: <20261109094310.103979-3-lange_tang@163.com>

On Mon, Nov 09, 2026 at 05:43:09PM +0800, Longjun Tang wrote:
> From: Longjun Tang <tanglongjun@kylinos.cn>
> 
> The backend raises an interrupt after adding buffers to the used ring,
> and the hypervisor injects it. If one is lost (e.g., a transient KVM
> failure), NAPI will not be scheduled and the driver stops consuming
> buffers. The ring eventually fills up, the backend stops notifying, and
> the queue is left permanently stuck.
> 
> Add a per-device watchdog that scans the RX queues once per second and
> detects a queue that has a non-zero backlog while making no consumption
> progress and receiving no new interrupt for rx_watchdog_timeo seconds
> (default 5, 0 disables it). On detection, reschedule NAPI.
> 
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
> ---
>  drivers/net/virtio_net.c | 104 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index dd2c41ef6fbe..ec7c248080c5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -36,6 +36,10 @@ module_param(csum, bool, 0444);
>  module_param(gso, bool, 0444);
>  module_param(napi_tx, bool, 0644);
>  
> +/* RX queue stall timeout in seconds; 0 disables the watchdog. */
> +static unsigned int rx_watchdog_timeo = 5;
> +module_param(rx_watchdog_timeo, uint, 0644);
> +
>  #define VIRTIO_OFFLOAD_MAP_MIN	46
>  #define VIRTIO_OFFLOAD_MAP_MAX	47
>  #define VIRTIO_FEATURES_MAP_MIN	65

No module params pls. This is not a sane UAPI.

> @@ -318,6 +322,13 @@ struct send_queue {
>  	dma_addr_t xsk_hdr_dma_addr;
>  };
>  
> +struct virtnet_rq_watchdog {
> +	u16 last_used;
> +	u16 calls;
> +	unsigned long jiffies;
> +	bool stalled;
> +};
> +
>  /* Internal representation of a receive virtqueue */
>  struct receive_queue {
>  	/* Virtqueue associated with this receive_queue */
> @@ -332,6 +343,9 @@ struct receive_queue {
>  	/* The number of rx notifications */
>  	u16 calls;
>  
> +	/* RX watchdog state. */
> +	struct virtnet_rq_watchdog watchdog;
> +
>  	/* Is dynamic interrupt moderation enabled? */
>  	bool dim_enabled;
>  
> @@ -443,6 +457,9 @@ struct virtnet_info {
>  	/* Work struct for setting rx mode */
>  	struct work_struct rx_mode_work;
>  
> +	/* RX watchdog timer for stuck detection */
> +	struct timer_list rx_watchdog;
> +
>  	/* Does the affinity hint is set for virtqueues? */
>  	bool affinity_hint_set;
>  
> @@ -3067,6 +3084,80 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  	return received;
>  }
>  
> +/*
> + * An RX queue is stalled if it has a backlog but makes no progress and
> + * gets no new interrupt for rx_watchdog_timeo seconds, usually because
> + * an interrupt was lost.  Mark it stalled and reschedule NAPI to drain
> + * the ring, refill the buffers.
> + */
> +static void virtnet_rx_watchdog(struct timer_list *t)
> +{
> +	struct virtnet_info *vi = timer_container_of(vi, t, rx_watchdog);
> +	unsigned long timeout = rx_watchdog_timeo * HZ;
> +	int i;
> +
> +	if (!rx_watchdog_timeo)
> +		return;
> +
> +	for (i = 0; i < vi->curr_queue_pairs; i++) {
> +		struct receive_queue *rq = &vi->rq[i];
> +		u16 last_used = virtqueue_get_last_used_idx(rq->vq);
> +		u16 calls = rq->calls;
> +		bool backlog = virtqueue_poll(rq->vq, last_used);
> +		bool progress = last_used != rq->watchdog.last_used;
> +
> +		if (!backlog || progress || calls != rq->watchdog.calls) {
> +			rq->watchdog.last_used = last_used;
> +			rq->watchdog.calls = calls;
> +			rq->watchdog.jiffies = jiffies;
> +			continue;
> +		}
> +
> +		if (time_after(jiffies, rq->watchdog.jiffies + timeout)) {
> +			unsigned int stall_ms =
> +				jiffies_to_msecs(jiffies - rq->watchdog.jiffies);
> +
> +			netdev_warn(vi->dev,
> +				    "RX queue %u stalled for %u ms, rescheduling NAPI\n",
> +				    i, stall_ms);
> +
> +			rq->watchdog.stalled = true;
> +			virtqueue_napi_schedule(&rq->napi, rq->vq);
> +
> +			/* Rate-limit to one event per timeout. */
> +			rq->watchdog.jiffies = jiffies;
> +		}
> +	}
> +
> +	mod_timer(&vi->rx_watchdog, jiffies + HZ);
> +}
> +
> +static void virtnet_rx_watchdog_init_queue(struct receive_queue *rq)
> +{
> +	rq->watchdog.last_used = virtqueue_get_last_used_idx(rq->vq);
> +	rq->watchdog.calls = rq->calls;
> +	rq->watchdog.jiffies = jiffies;
> +	rq->watchdog.stalled = false;
> +}
> +
> +static void virtnet_rx_watchdog_start(struct virtnet_info *vi)
> +{
> +	int i;
> +
> +	if (!rx_watchdog_timeo)
> +		return;
> +
> +	for (i = 0; i < vi->curr_queue_pairs; i++)
> +		virtnet_rx_watchdog_init_queue(&vi->rq[i]);
> +
> +	mod_timer(&vi->rx_watchdog, jiffies + HZ);
> +}
> +
> +static void virtnet_rx_watchdog_stop(struct virtnet_info *vi)
> +{
> +	timer_delete_sync(&vi->rx_watchdog);
> +}
> +
>  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
>  {
>  	virtnet_napi_tx_disable(&vi->sq[qp_index]);
> @@ -3230,6 +3321,8 @@ static int virtnet_open(struct net_device *dev)
>  		netif_carrier_on(dev);
>  	}
>  
> +	virtnet_rx_watchdog_start(vi);
> +
>  	return 0;
>  
>  err_enable_qp:
> @@ -3759,6 +3852,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	struct virtio_net_rss_config_trailer old_rss_trailer;
>  	struct net_device *dev = vi->dev;
>  	struct scatterlist sg;
> +	u16 old_queue_pairs = vi->curr_queue_pairs;
>  
>  	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>  		return 0;
> @@ -3816,7 +3910,14 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	if (vi->has_rss)
>  		vi->rss_trailer.max_tx_vq = cpu_to_le16(queue_pairs);
>  succ:
> +	if (dev->flags & IFF_UP) {
> +		/* Init new queues */
> +		for (int i = old_queue_pairs; i < queue_pairs; i++)
> +			virtnet_rx_watchdog_init_queue(&vi->rq[i]);
> +	}
> +
>  	vi->curr_queue_pairs = queue_pairs;
> +
>  	if (dev->flags & IFF_UP) {
>  		local_bh_disable();
>  		for (int i = 0; i < vi->curr_queue_pairs; ++i)
> @@ -3832,6 +3933,8 @@ static int virtnet_close(struct net_device *dev)
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i;
>  
> +	virtnet_rx_watchdog_stop(vi);
> +
>  	/* Prevent the config change callback from changing carrier
>  	 * after close
>  	 */
> @@ -6900,6 +7003,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
>  	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
>  	disable_work(&vi->rx_mode_work);
> +	timer_setup(&vi->rx_watchdog, virtnet_rx_watchdog, 0);
>  
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
>  		vi->mergeable_rx_bufs = true;
> -- 
> 2.51.0

