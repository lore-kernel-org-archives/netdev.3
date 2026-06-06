Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F18C3A1B5;
	Sat,  6 Jun 2026 02:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780711889; cv=none; b=F3x2px+xFkqgVvuBEzsEbQ3ARvHEMkp8zKzCoa06pnQjR8chVFIY+xO0zUxSRaLqKO66NMWB1xQMlSrLWx8CFYa5wquzwarFMp5JurgLyOEaefahNm+AYdRdeuNNvjV5DsfWHk7RTHe/xifU4EM8QZ415NEZr8KnhKgD/nDxXhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780711889; c=relaxed/simple;
	bh=CDtN6bGonm4f08tjGeZFwWVm/lbfJvhFDUM2odeM728=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZXOUQKtpuk1xVhyUwq9Tu8FFmVLx63N6vS35aprEA1cJKgfi/7Mj/+xfTwNTsjc5WtHbMqTNK9pvGLJlniWvkPbfzg4PIhiVxpG7c5D1nuGsZY9itNwjc9GCXP6EGlr6ZdXqEhvhewdRfv8Hj2IWfi/ULQ/UVR1vxu+XgEV1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWFbpA7b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWFbpA7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660761F00893;
	Sat,  6 Jun 2026 02:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780711886;
	bh=eLkQJZKVDcNyvW9cFEhOXxtr+s4qCGIKL0GF/iM5EQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IWFbpA7b4lw2hkZ0ov9TqafrmCYH4zhzJ6zk+YW57u7IjLnDpG+PKb1PuSVvrHNdy
	 fB+8zJf8EBA1mu+hFKi5qML+rm9O9gclPfR4i8zYfcsksbWXpVGXyU3w3twMW0htUZ
	 ArsPfk0iXK4w0PqyVbPNVo7aNeQPVV/DqKZBo+HVNir6YCru8mgkxKasIE6Wnywn8O
	 hlB+rWbxXFK7DWfLZz54DxGZRxqVnCl8jESsZhDxFQH3fBqTXBnfS5QyKk7629ei6w
	 xpghe8HUrfD5xSDKNVeV3uRC84xWEUcHfa3ZymJt2EyMCZYBogWjYriKuHUDq29I4r
	 tZigRl4QwkudA==
From: Jakub Kicinski <kuba@kernel.org>
To: ioana.ciornei@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 12/12] dpaa2-switch: add support for imprecise source port
Date: Fri,  5 Jun 2026 19:11:05 -0700
Message-ID: <20260606021104.4124892-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603143623.3712024-13-ioana.ciornei@nxp.com>
References: <20260603143623.3712024-13-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
dpaa2-switch: add support for imprecise source port

Switch ports configured as part of a LAG group are not able to provide
a precise source port for all packets which reach the control interface.

The only frames which will have a precise source port are those that are
explicitly trapped, for example STP and LCAP frames. For any other
frames (for example, those which are flooded) we can only know the
ingress LAG group.

Take into account the DPAA2_ETHSW_FLC_IMPRECISE_IF_ID bit and based on
its value target the bond device or the specific source netdevice.

> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index 7aef34778e220..163f6c51c1606 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -3270,8 +3272,10 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
>  	rcu_read_lock();
>  
>  	lag = rcu_dereference(port_priv->lag);
> -
> -	skb->dev = netdev;
> +	if (DPAA2_ETHSW_FLC_IMPRECISE_IF_ID(flc) && lag)
> +		skb->dev = lag->bond_dev;

[Severity: High]
By assigning skb->dev = lag->bond_dev here, isn't there a risk of a
use-after-free on PREEMPT_RT?

The explicit rcu_read_lock() is dropped before handing the SKB over to
netif_receive_skb(). While NAPI's local_bh_disable() provides RCU protection
on standard kernels, softirqs are threaded on PREEMPT_RT and do not provide
an implicit RCU read-side critical section.

Between the rcu_read_unlock() and the internal rcu_read_lock() taken by
netif_receive_skb_core(), the threaded softirq can be preempted. If the bond
device is concurrently unregistered, synchronize_net() will not wait for the
NAPI thread, allowing bond_dev to be freed before netif_receive_skb()
dereferences it.

> +	else
> +		skb->dev = netdev;
>  	skb->protocol = eth_type_trans(skb, skb->dev);
>  
>  	/* Setup the offload_fwd_mark only if the port is under a bridge
