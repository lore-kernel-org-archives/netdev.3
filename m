Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C28827FB26
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132706; cv=none; b=uGkR+9jmlula4BPZDkTBSDFi3NKkNJwIfCyZuVLfq8VZmqCphYqZjIXg6DYS/wdeiG5UUJkAJGOt1VKSam+ZjpGHWLotFzyuWNwGWzz0WC6zU+h67fBmBZxZxMiMPbR70wmbcjBS7P6gAFDCd7mDB/KNFf0ILVStweP/5xR7t2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132706; c=relaxed/simple;
	bh=Vb/kRJk2pjrfyrXSTw4+JICmQPE/EquDuSGPYEguVE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfgJEj6e27UVvonF/sk1Gu/LwMqlu9A/HWDUhtV+DmIQdY2Q+iCQ0x+tgMSjAJaMn4kxp+44vuXo8j8yfx82w5TRW+IvZ2QEIJPmga1FuJ5qZBpVM4UAWEN90yIjAzbO9T+OWIobYBhxw/2xfkvuVHYwMRrsW7LkFU2N7t0l2+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OO8iqdHP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OO8iqdHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644B0C116C6;
	Fri, 23 Jan 2026 01:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769132703;
	bh=Vb/kRJk2pjrfyrXSTw4+JICmQPE/EquDuSGPYEguVE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OO8iqdHPRItV223nIIoEigB7P+wsq5AFojtVZbj/Nybc7BIX4GtA+MITO0BpG92AL
	 2XpZMsE9Wj4av7o2g782x5fTq0i3bUL6xo35mbLEkutLJOWCZQw+z3E1sCksrsXVZM
	 +2zLJSbYTZnp9Qn8t/8QJUT4ECGBEU3aouEqbAUmrIIy65PyGRjkzI+0Fg4Hj9R4c0
	 ENQyWYNrrAXB4A9Jz1KBAtXkRdUC9b2rUeJF0U+j6MmKsUrXSAP3HLPby6OEl2RLQB
	 C7P1rBXhTxuRctOnFroL2HHIbZJeKMuQI1Qgd0HsdDK+plKaMuTFLVk7yaSsKxDrk5
	 EEdPXukwDYohA==
From: Jakub Kicinski <kuba@kernel.org>
To: danielj@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	mst@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	jasowang@redhat.com
Subject: Re: [net-next,v16,05/12] virtio_net: Query and set flow filter caps
Date: Thu, 22 Jan 2026 17:43:38 -0800
Message-ID: <20260123014338.3007350-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121220652.894364-6-danielj@nvidia.com>
References: <20260121220652.894364-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
virtio_net: Query and set flow filter caps

This patch adds flow filter capability support to virtio_net. It queries
and sets flow filter capabilities during probe and restore, with cleanup
during freeze and remove.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..03bd3d2c2b0e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -5727,10 +5934,31 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  			return err;
>  	}
>
> +	/* Initialize flow filters. Not supported is an acceptable and common
> +	 * return code
> +	 */
> +	rtnl_lock();
> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
> +	if (err && err != -EOPNOTSUPP) {
> +		if (netif_running(vi->dev))
> +			virtnet_close(vi->dev);
> +
> +		/* disable_rx_mmode_work takes the rtnl_lock, so just set the
> +		 * flag here while holding the lock.
> +		 *
> +		 * remove_vq_common resets the device and frees the vqs.
> +		 */
> +		vi->rx_mode_work_enabled = false;
> +		rtnl_unlock();
> +		remove_vq_common(vi);
> +		return err;

If virtnet_ff_init() fails here, remove_vq_common() frees vi->rq, vi->sq,
and vi->ctrl via virtnet_free_queues(), but the netdevice remains
registered. Could this leave the device in an inconsistent state where
subsequent operations (like virtnet_open() triggered by bringing the
interface up) would access freed memory through vi->rq[i]?

The error return propagates up to virtnet_restore() which just returns
the error without further cleanup. If userspace then tries to use the
still-registered netdevice, virtnet_open() would call try_fill_recv()
which dereferences vi->rq.

> +	}
> +	rtnl_unlock();
> +
>  	netif_tx_lock_bh(vi->dev);
>  	netif_device_attach(vi->dev);
>  	netif_tx_unlock_bh(vi->dev);
> -	return err;
> +	return 0;
>  }
-- 
pw-bot: cr
