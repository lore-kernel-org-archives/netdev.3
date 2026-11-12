Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527833;
	b=rdIzKL4kxu33vsJxmV6xgAcOxhd89o0UCCSuTDMFnI5Qi0aJIxTZ54+ivpWmnUHGZmlf
	 +GFObo3GEvlhHULpzp1oMZUZmFJpByOCPwlT+LvTMJmUVK0Onlk14o9LkPIY2lLCVLr3y
	 wj50vA447lDPKWxnsdvzaYQOCbAp8joj9rU6LXDEkC1hiNJMC0rAtnPqUyX/lsVZ6l9r5
	 k8i7cCVPSmsaFo0oH8ubDZmPgcxfs1XfufOlbo44VGy76gnHoThGa12RW64hv0Lls1HlQ
	 ktAvCOTisKwabJRz926OpzOyYUm6uL8aCTlVKLQf2AC4hN6Zv/IW01f2NYMTL4JffVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527833;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=B6FaAHVJBXDe9emSneAne2gRV0yGhgOXXcIzjaCOERk=;
	b=zMm19vdwVLPvT0xVN+xZC+Sd48Bjxr3XSjwAF73K/0zA4ZV6fre0dniZCGgwon7Y1e9E
	 x2RK3m40B0bmMiRqL1aD6RBpApa/pwpa5MvMlz77sIuDjNLZOw5nhzqGgO02eN1xPnoea
	 K06vgQW1qUe1VdX7K/W7lTi0+JV++V/Bq7s1NbFEuTHMj7JITFIUhxye/Y9zHpPiBj3uV
	 0IuCxvfd4tiVNQ/0Ki3jbqtlfhqefD3BItQTUEvu5rR4OhhDM48To7e7K8ElT/RJWMAmA
	 Xe5/n5F6PHyV3MFBJjpaZshJ2dKlRQhR0Ew+UWD+vFoTzRk1U9bOO9e3+3erGkO7W0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJHTdTP5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EDC606A882
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJHTdTP5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980151F000C4;
	Thu, 12 Nov 2026 23:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527832;
	bh=B6FaAHVJBXDe9emSneAne2gRV0yGhgOXXcIzjaCOERk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EJHTdTP5bFXc/m1F6TnbbkTuBFF7FPQ+gTU14WvQDlltER+rrlBqSpRQCaK0YcxPE
	 eopdm+NXy3+BqwxWvQKYdAF0fs90zfL2FJlZozjIQ3cn0XZ4u8wqOP3jXKHNZXbH5b
	 Xly7KwB4eWtBf9e+7Gt6WGs+zTlF/AWOng8UH6hPCiiz27w7CxEMk3ZAz2c95oTvRu
	 tY4iMWXNDMKei8B6o6ijkLiFPKmw5EYQh2lqEpLfDAlUYmrJsaiQG1hmP/Sb+j4Dgo
	 +fG6ztwwWMHh0t9gyzbJK+B/2cmH3v7HYuP/jOuzewb7uyaKXVIX+ld59PUgxW2Wrx
	 6iyVagxAi5j/w==
Subject: Re: [PATCH net-next v8 11/15] ibmveth: Add per-queue RX and TX
 statistics collection
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
 bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Date: Thu, 12 Nov 2026 23:57:11 +0000
Message-ID: <179452783113.2199510.7647821675893385517@kernel.org>
In-Reply-To: <20261109235556.60604-12-mmc@linux.ibm.com>
References: <20261109235556.60604-12-mmc@linux.ibm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Statistics readers now take every RX queue's replenish_lock
  with spin_lock_bh().

--

ibmveth: Add per-queue RX and TX statistics collection

This patch moves the adapter-wide RX and TX counters into per-queue
ibmveth_rx_queue_stats and ibmveth_tx_queue_stats arrays allocated at
probe. It exports packets, bytes and hardware drops through
netdev_stat_ops, adds ndo_get_stats64(), and keeps the existing ethtool -S
keys by summing the per-queue slots. It also adds a per-queue
no_buffer_retired carry so that rx_no_buffer never goes backwards across a
reopen.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index a0c3c06d2b9d9..45adf6e9be09b 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1063,7 +1197,45 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
>  	p = adapter->buffer_list_addr[queue_index] + 4096 - 8;
>  	drops = be64_to_cpup(p);
>  
> -	adapter->rx_no_buffer = drops;
> +	qstats = &adapter->rx_qstats[queue_index];
> +
> +	if (drops < qstats->no_buffer_drops)
> +		IBMVETH_STAT_ADD(qstats->no_buffer_retired,
> +				 qstats->no_buffer_drops);
> +	WRITE_ONCE(qstats->no_buffer_drops, drops);
> +}
> +
> +/* Snapshot live+retired under replenish_lock; see retire_rx_no_buffer(). */
> +static u64 ibmveth_rx_no_buffer_pair(struct ibmveth_adapter *adapter, int i)
> +{
> +	struct ibmveth_rx_q *rxq = &adapter->rx_queue[i];
> +	struct ibmveth_rx_queue_stats *qstats = &adapter->rx_qstats[i];
> +	u64 drops, retired;
> +
> +	spin_lock_bh(&rxq->replenish_lock);
> +	drops = qstats->no_buffer_drops;
> +	retired = qstats->no_buffer_retired;
> +	spin_unlock_bh(&rxq->replenish_lock);
> +	return drops + retired;
> +}

[Severity: Medium]
Should the stats readers be taking replenish_lock here?

This lock sits on the RX datapath. ibmveth_remove_buffer_from_pool() takes
it from NAPI for every received frame. ibmveth_replenish_task() holds it
for a whole multi-pool refill, which includes netdev_alloc_skb(),
dma_map_single_attrs() and the h_add_logical_lan_buffers*() hcalls.

The new ndo_get_stats64 calls this helper for every slot, whether the
queue is live or not:

ibmveth_get_stats64() {
	for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++) {
		...
		stats->rx_missed_errors +=
			ibmveth_rx_no_buffer_pair(adapter, i);
	}
}

The rx_no_buffer ethtool -S key, ibmveth_get_queue_stats_rx() and
ibmveth_get_base_stats() also call it.

As a result, every /proc/net/dev read, RTM_GETLINK dump or bonding/team
stats poll takes up to 16 BH-disabling spinlocks. Unprivileged users can
trigger these reads.

Each acquisition pulls the lock cacheline away from the NAPI CPUs. A
reader can also spin with BH disabled for as long as a refill takes, for
example during the initial replenish in ibmveth_open().

Before this patch the driver had no ndo_get_stats64, and netdev->stats was
read without taking any lock.

Writers already hold replenish_lock. Could they keep a single combined
monotonic value (retired plus live drops) updated with WRITE_ONCE()? Then
readers could use READ_ONCE() and skip the lock.

This also looks unchanged at the end of the series, in "ibmveth: Complete
set_channels down-path". There, ibmveth_rx_no_buffer_pair() still uses
spin_lock_bh() and ibmveth_get_stats64() still calls it for every slot.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109235556.60604-1-mmc%40linux.ibm.com
