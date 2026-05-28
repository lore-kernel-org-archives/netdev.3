Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD772E7363;
	Thu, 28 May 2026 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989339; cv=none; b=qsdF8TwgGySfXIYdLuBl2HphY+EjF5F1DvUu0kAQZzSDxUdMPIiacFSMYkABCObGOs086guD5Ml8RZHr78eksDJ+MQAifsf7VKPzZJp1A7rWs71NmGaQn5n8mn5mL1U5ATTEYxZ/L9F7HHmC5wT8J6XNsnSC/Z5HHo9CrupxFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989339; c=relaxed/simple;
	bh=5G+T8hRM5X6Wlej1MnG33EDzJDbDxCSCTQPrDmWJjKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFwW12Du9CgbnyvyIVk07xbD41oLmukKmyQBtDGbsBFkj6kpA1cKfXJy7ukNryGbBxDavVNd/uj/2zafHNlXmeD8liwJ4uUCl8N9awUFxCBLx1pJSsalLiJ0H2CcU3JYAMT92GLOyUzZi46ntD79q6NGLSvFVfZJIPrv/yVDtY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nivTUmWS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nivTUmWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDBF1F000E9;
	Thu, 28 May 2026 17:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779989337;
	bh=h5u2QCA4IQHZmMF+M7+9tjgQWrAvtLUoEFMzcuaOtCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nivTUmWSUMLEztUCqRnyXAEKc7FeaZ/gbHkDoDAhHF5Foea+qxckdfpaaGrCXES7n
	 aKXOmmCMA7ujDQW7hQr+JV+UF6QFWcqegoTv4TKLSZizCPd2CRF8I8Zau0tzjMl2xu
	 ixpsrsU+aAgBnKkrrczIWeDc76cdt/YsjrcQ83ZFT9UuMW/cpm1VoOud34SpcbU4xG
	 ICJVHK0tiorBFO2ZTsxNUW6YiU6abuAee25YwR+EvjiZNIdDHmI40SUvKnvnDLm98T
	 2hkloN+3/aUBt/qDEVotlpspVrBsUa4gdmxyfZv6sWFWMKY7ard/OqltE8CuGkPJVM
	 /N+SFcHxDTbzw==
From: Simon Horman <horms@kernel.org>
To: kshitiz.bartariya@zohomail.in
Cc: 'Simon Horman' <horms@kernel.org>,
	kuba@kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ixgbe: implement get_queue_stats_rx
Date: Thu, 28 May 2026 18:26:52 +0100
Message-ID: <20260528172649.2666600-4-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526074744.36315-1-kshitiz.bartariya@zohomail.in>
References: <20260526074744.36315-1-kshitiz.bartariya@zohomail.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ixgbe: implement get_queue_stats_rx

This commit hooks into the netdev_stat_ops interface to expose per RX queue
statistics through the netdev generic netlink API.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 2646ee6f295f0..2184213727c7d 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
[ ... ]
> @@ -9740,6 +9740,21 @@ static void ixgbe_get_stats64(struct net_device *netdev,
>  	stats->rx_missed_errors	= netdev->stats.rx_missed_errors;
>  }
>  
> +static void ixgbe_get_queue_stats_rx(struct net_device *dev, int idx,
> +				     struct netdev_queue_stats_rx *stats)
> +{
> +	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
> +	struct ixgbe_ring *ring = adapter->rx_ring[idx];
> +

Simon says: The issue flagged below does seem to warrant investigation.

[Severity: High]
Does this code risk a NULL pointer dereference?

The generic netlink queue stat dump executes under RCU without holding the
rtnl_lock. During device reconfigurations (e.g., changing the number of channels
via ethtool -L), the driver temporarily tears down the queues and sets
adapter->rx_ring[idx] to NULL.

Because this happens while the interface is still marked up and before
dev->real_num_rx_queues is updated, a concurrent queue stats dump could invoke
ixgbe_get_queue_stats_rx() while the ring pointer is NULL.

> +	stats->alloc_fail = ring->rx_stats.alloc_rx_page_failed +
> +			    ring->rx_stats.alloc_rx_buff_failed;
> +	stats->csum_bad = ring->rx_stats.csum_err;

Simon says: While it seems to me that the heart of the issue flagged below is
            a subjective decision around the scope of this work.

[Severity: Medium]
Are we missing the packet and byte counts here?

The driver tracks these fundamental metrics in ring->stats.packets and
ring->stats.bytes, and they can be safely read using the ring->syncp
u64_stats_sync lock.

Since they are omitted from struct netdev_queue_stats_rx, the generic netlink
API will treat them as NETDEV_STAT_NOT_SET, leaving userspace tools without
packet and byte counts for the RX queues.

> +}
> +
