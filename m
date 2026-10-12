Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B634BA1CE;
	Mon, 12 Oct 2026 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825591; cv=none; b=CjKW/ZVn12sH9x8+cKURTWKqP/qJIsGDa7BKXRecvxgTgVult82Zssqcs28OgdM6z68fm0KHac8tpZ3Kb6PjtWF1zBtv/G2oZvIam365CxR9NrodYIjSwVA7Qbs47neXnIWoebQ+S0aRVjdD9dRyCziYFxAou38CYvE1aKtQCp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825591; c=relaxed/simple;
	bh=6TU+qgJyL1P+C51hctL+RoraPsI9x064jlMSM6ExMQc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QUU9gMq4FjuIBydMkhZlIgZnFTbvxqyEchAToZ94ydwQn6kvdnsxd9SvRpkobGrf7ydk+F6uUeDo/kQnhDdcuiFf4q9aFP7n0yj36UpCIYDBW6Qp/k4wOzbgCpAj5jpsywoJeA2eDGFix/lX1zsdEOmiTwYaOz897q86Rx/X9/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8s99tKF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8s99tKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27821F0089D;
	Mon, 12 Oct 2026 17:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791825589;
	bh=N20TDsP1zB7Qq/r8z7eDSI/dWJL/+1JhQa/qRj5xJdw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m8s99tKFC+8XiKEkFH+X7LsLCIGoPnio5dm5yqGm+l5Ka/Baq9jaWJ3/TwL7eGW0f
	 W5yjl0gZ9V1FPK6HSGiNuEw/h6FmFjLkIdIaomF5xz2HtEFbFVbgXI5aR85yAh+S+L
	 qyIhRXr9+dT3YYHs5PqiRGeoZYgcKVvpEMBGV7ZCNCQ27Xp6pI+/3mM9dC6HxK6pBg
	 ONXXii3vPnPUCm81eGcWTyVpzx3p6kKEwel2Wwrxsrz10V1+eIJv+LbyDRtqoCFTBO
	 H+KG7jVcEQYRQ6LJTgeGo/0I52BwyY4MxG5Xjv5Mkck3q/s7IzUxd3ROnJclQEQCtV
	 wsKkd8slklZPQ==
Subject: Re: [PATCH net-next V2 3/5] net/mlx5: nodnic: Add TX/RX statistics
From: netdev-bot+sashiko@kernel.org
To: tariqt@nvidia.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 cjubran@nvidia.com, gal@nvidia.com, linux-kernel@vger.kernel.org,
 shshitrit@nvidia.com, leon@kernel.org, mbloch@nvidia.com, saeedm@nvidia.com,
 dtatulea@nvidia.com, horms@kernel.org
Date: Mon, 12 Oct 2026 17:19:48 +0000
Message-ID: <179182558857.434549.10132144834821303501@kernel.org>
In-Reply-To: <20261008171821.660739-4-tariqt@nvidia.com>
References: <20261008171821.660739-4-tariqt@nvidia.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mlx5_nodnic_handle_send_cqe() reads wi->num_bytes for the
  tx_bytes update (tx.c:182) after mlx5_nodnic_complete_send_wqe() has…
- [Medium] The new 64-bit counters in struct mlx5_nodnic_sq_stats and
  struct mlx5_nodnic_rq_stats (en.h:47-56) are plain u64 with no…
- [Low] The new RX packet and byte counters in
  mlx5_nodnic_handle_recv_cqe() (rx.c:155-156) are incremented only…

--

net/mlx5: nodnic: Add TX/RX statistics

This commit adds TX and RX packet and byte counters to the nodnic driver,
plus a TX drop counter. The data path updates the counters, and
ndo_get_stats64 exposes them.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h b/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h
> index 19858e9da064a..d811bfe242ac6 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h
> @@ -44,6 +44,17 @@ enum mlx5_nodnic_cqe_opcode {
>  	OPCODE_CQ_INVALID,
>  };
>  
> +struct mlx5_nodnic_sq_stats {
> +	u64 packets;
> +	u64 bytes;
> +	u64 dropped;
> +};
> +
> +struct mlx5_nodnic_rq_stats {
> +	u64 packets;
> +	u64 bytes;
> +};

[Severity: Medium]
Can these counters tear when they are read on a 32-bit kernel?

They are plain u64 fields. There is no u64_stats_sync and no
READ_ONCE()/WRITE_ONCE(). Three places write them with plain ++ and +=:

  mlx5_nodnic_handle_recv_cqe()  - rq_stats packets/bytes, NAPI
  mlx5_nodnic_handle_send_cqe()  - sq_stats packets/bytes, NAPI
  mlx5_nodnic_xmit()             - sq_stats dropped, ndo_start_xmit

mlx5_nodnic_get_stats64() reads them with plain loads from process context
through dev_get_stats(). It shares no lock with the writers.

MLX5_NODNIC in Kconfig does not depend on 64BIT, and
include/linux/mlx5/doorbell.h has a BITS_PER_LONG != 64 fallback, so
32-bit builds look supported. On 32-bit, a u64 add is two 32-bit stores.
A reader such as ip -s link or /proc/net/dev could then see rx_bytes or
tx_bytes jump by about 2^32. On 64-bit these are still unannotated data
races that KCSAN would report.

Should these use u64_stats_t, with u64_stats_update_begin()/end() in the
writers and u64_stats_fetch_begin()/retry() in mlx5_nodnic_get_stats64()?

dropped is written from xmit context, while packets and bytes are written
from NAPI. So the TX side would need separate syncp instances, or separate
handling for dropped, so that each syncp has only one writer.

[ ... ]

> diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/rx.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/rx.c
> index 7736a1f24ea5b..808740ec39102 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/nodnic/rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/rx.c
> @@ -152,6 +152,9 @@ void mlx5_nodnic_handle_recv_cqe(struct mlx5_nodnic_cq *cq,
>  	skb->protocol = eth_type_trans(skb, priv->netdev);
>  	nodnic_handle_rx_csum(priv->netdev, cqe, skb);
>  
> +	priv->rq_stats.packets++;
> +	priv->rq_stats.bytes += byte_count;
> +

[Severity: Low]
Should good frames that are dropped because napi_build_skb() failed also be
counted? Earlier in mlx5_nodnic_handle_recv_cqe():

	skb = napi_build_skb(page_address(page), PAGE_SIZE);
	if (unlikely(!skb))
		goto err_recycle;

This jumps past both counter updates. The rtnl_link_stats64 kernel-doc
says @rx_packets includes "packets which host had to drop at various
stages of processing (even in the driver)", and that @rx_bytes
corresponds to @rx_packets.

Could the counters be incremented before the allocation? The failure
could also be counted in rx_dropped.

>  	napi_gro_receive(&cq->napi, skb);
>  	rq->cc++;
>  
> diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/tx.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/tx.c
> index f2efc8d3f5b85..6958c8a51231d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/nodnic/tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/tx.c

[ ... ]

> @@ -176,6 +177,9 @@ void mlx5_nodnic_handle_send_cqe(struct mlx5_nodnic_cq *cq,
>  	wi = &sq->wqe_info[pi];
>  
>  	mlx5_nodnic_complete_send_wqe(sq, wi, napi_budget);
> +
> +	priv->sq_stats.packets++;
> +	priv->sq_stats.bytes += wi->num_bytes;

[Severity: Medium]
Could wi->num_bytes already belong to a different packet when it is read
here?

mlx5_nodnic_complete_send_wqe() gives the slot back to the producer before
it returns:

	sq->cc++;

	if (netif_tx_queue_stopped(txq))
		netif_tx_wake_queue(txq);

mlx5_nodnic_xmit() stops the queue when the ring is one entry short of
full, but it still posts the current packet:

	if (unlikely(mlx5_nodnic_tx_is_sq_full(sq)))
		netif_tx_stop_queue(sq->txq);

So the ring can become completely full (pc - cc == num_entries). Once this
completion increments cc and wakes the queue, mlx5_nodnic_xmit() on
another CPU computes pi = pc & mask, which is the slot that was just
completed. That CPU holds only the tx queue lock, which NAPI does not take.
mlx5_nodnic_tx_fill_wqe_info() then does:

	sq->wqe_info[pi].num_bytes = skb->len;

If that write lands before the read above, tx_bytes gets the new packet's
length. The new packet is then counted again when it completes.

Could wi->num_bytes be saved in a local variable before calling
mlx5_nodnic_complete_send_wqe()? Another option is to update the stats
before cc is advanced and the queue is woken.

>  }
>  
>  void mlx5_nodnic_complete_send_wqe(struct mlx5_nodnic_sq *sq,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008171821.660739-1-tariqt%40nvidia.com
