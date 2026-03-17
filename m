Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F6A306B31;
	Tue, 17 Mar 2026 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764438; cv=none; b=JKmWv3xltK+Sdxbp6M1ssYkUs8rPsO5GN+kYqVXoa42nDgVeCIz3u2vyMegwVqEMbLrNjzhez2JwCFe8EO+7BHxDpfaaZq4CZGqdQx52p2aJRM2ytA2eoaLJWhTbbpC/w5kMN34QWX+7Byy/DYY/s/zJAziirSGJ6gX8OaXHSfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764438; c=relaxed/simple;
	bh=eZn0o8PN+VBSA5tcV2K+3PiV1G+nIqHRRVawlw+TQ+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqkD48B72J8SfY3r9LRJCdQBVg5RCKxOfxq2fhKab+aGKcKDQfyPCI6QNApTOkO68CmV6oT/XZG8M7m9nweHJEVp9iuW3s17uHV7uOVjUCWKak5pPuN4Fmef8hvVE4JYCzkHf8UVloHO/3JrmOCC+60+Kdb8oAVBYKnTlwidm64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S16UhQT8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S16UhQT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD14AC4CEF7;
	Tue, 17 Mar 2026 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773764438;
	bh=eZn0o8PN+VBSA5tcV2K+3PiV1G+nIqHRRVawlw+TQ+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S16UhQT8bb2nXpM4hdL0HYCSTk5YMwQ4mIPUSfXcsrievR3IXMNei7dv5Ot9b4XVo
	 6TLhBxLmUZDDRLSSQnHnMevosHrh0NZJigKWAUa0uM29cEVUCvkC7QABtIGwBG9bku
	 L2poa9fZInWvBGjYDe1Cx0fj4psafrvIJV9FQGeh2gjwsmNi5kgGs8n1ZAioemjZN/
	 fqJ62q09skuFzdwcB4TBLBDkPRUG0HgvOoyQDpbozLEVSBC1yywWQoUTaFTiNI4e39
	 UDRpb9lfrB9KcyC7ycVYaGAKSIqEtVU6iIc62GlkUwbX7IE4XMvcueJ8HUqXYtgJ/D
	 enJrKSwHtIZ+g==
From: Simon Horman <horms@kernel.org>
To: nb@tipi-net.de
Cc: Simon Horman <horms@kernel.org>,
	kuba@kernel.org,
	opendmb@gmail.com,
	arnd@arndb.de,
	hkallweit1@gmail.com,
	florian.fainelli@broadcom.com,
	bhargava.marreddy@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	mbloch@rooftopnetworks.de,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	rajashekar.hudumula@broadcom.com,
	linux-kernel@vger.kernel.org,
	ebiggers@kernel.org,
	vikas.gupta@broadcom.com
Subject: Re: [net-next,v2,4/6] net: bcmgenet: add XDP_TX support
Date: Tue, 17 Mar 2026 16:20:30 +0000
Message-ID: <20260317162030.1759004-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315214914.1555777-5-nb@tipi-net.de>
References: <20260315214914.1555777-5-nb@tipi-net.de>
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
net: bcmgenet: add XDP_TX support

Implement XDP_TX using ring 16 (DESC_INDEX), the hardware default
descriptor ring, dedicated to XDP TX for isolation from SKB TX queues.
Ring 16 gets 32 BDs carved from ring 0's allocation. TX completion is
piggybacked on RX NAPI poll since ring 16's INTRL2_1 bit collides with
RX ring 0, similar to how bnxt, ice, and other XDP drivers handle TX
completion within the RX poll path.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index f6a2567af7cb..922895bc7461 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -3637,6 +3782,7 @@ static void bcmgenet_timeout(struct net_device *dev, unsigned int txqueue)
>
>  	for (q = 0; q <= priv->hw_params->tx_queues; q++)
>  		bcmgenet_dump_tx_queue(&priv->tx_rings[q]);
> +	bcmgenet_dump_tx_queue(&priv->tx_rings[DESC_INDEX]);

Does this trigger an out-of-bounds array access?

Looking at bcmgenet_dump_tx_queue():

static void bcmgenet_dump_tx_queue(struct bcmgenet_tx_ring *ring)
{
	...
	struct netdev_queue *txq = netdev_get_tx_queue(priv->dev, ring->index);
	...
}

For the XDP TX ring, ring->index is DESC_INDEX (16), so this calls
netdev_get_tx_queue(priv->dev, 16). But the device only has 5 TX queues
(indices 0-4), allocated via alloc_etherdev_mqs() with GENET_MAX_MQ_CNT+1=5.

This means the code accesses dev->_tx[16] which is beyond the allocated
array, and the returned txq pointer points to memory past the array. This
is then dereferenced by netif_tx_queue_stopped(txq) which reads txq->state
from invalid memory.

In debug builds this triggers DEBUG_NET_WARN_ON_ONCE, and it could crash or
corrupt data.
