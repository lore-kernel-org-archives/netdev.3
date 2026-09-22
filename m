Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D51351C04;
	Tue, 22 Sep 2026 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038729; cv=none; b=PPx0A+jywvq3L/TTQUteW8bfweCdqJ7GszQK/inZdZWX6qEpTfxRGjyKhis51Z5js5AsncIXSQd5I8DFhn9KGm+Zbr42dycv+ONrAcjivy0g20UF0yOo7wqcWcuMLFNBlvBToWdj2BM52Y+m2y077AhB/qfkjzMBAb9nUjKIRI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038729; c=relaxed/simple;
	bh=gr6b9m0jRLh4HlWNdvaZUBFOeZj2EuZzA6RYsYci3uc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RTuMnQU9+u/1CWhki1L07zgNiQOF//SVv3xGa0qSh0pn9+sgxsy/g71MdxBmZoJCdVQqBqSXGhXcMM8plrXQ/Mtz+TJ2nmPFL7OKQEnJ1wGiqadyPFhI64XJGqrvoeV4t3mwtwjbBrJlsPN046p9+jsebzdZyO47sTn8yP0Mcl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWEaj28w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWEaj28w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0950B1F00893;
	Tue, 22 Sep 2026 00:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790038727;
	bh=Fj7IcJdYY+pLsSwYKdWSO4yXUX3XKHZGyWbxP/kpjas=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TWEaj28wNbh0Vj+XJzwCgZKVH8qtHPWgu1qapnQ+ulrRHnev620k0eG5kwVG31kYa
	 slqU7HhUr1onQJ00efnGRrrhxf6Y4BXpDwy5PaXxw0DxzCTH1uG+mkRykRVng0n0DG
	 ixHO7mm04oM21/d4GU8BZaoc/ExeADdQZU3/Eb+pYVXznvbLzE48sjz1xGj8XYU0tI
	 xD2TBh6k4Wb+aAARoS0PrPa77Jfx6jmxGdvcPNZyDJsdypLMPixte/UAc1bVH7hu2Q
	 yWstLNbQYiK8QRl8s04+6aRJAGfh0mLS480g5kXzNS3jdgdqfEHwicbYATADkW5YhR
	 W6cstEH0cHRsA==
Subject: Re: [PATCH net 2/8] net: bcmgenet: initialize u64 stats seq counter
 for all queues
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, cursoragent@cursor.com, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de
Date: Tue, 22 Sep 2026 00:58:46 +0000
Message-ID: <179003872658.2160803.12033283808833060821@kernel.org>
In-Reply-To: <20260918000732.276506-3-florian.fainelli@broadcom.com>
References: <20260918000732.276506-3-florian.fainelli@broadcom.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit has no Signed-off-by line and carries tool artifacts
  that must not reach upstream: `Change-Id:…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but writers to
  the same `tx_rings[i].stats64.syncp` are not mutually exclusive, which…

--

net: bcmgenet: initialize u64 stats seq counter for all queues

bcmgenet_probe() only initialized the u64_stats_sync seq counters up to
priv->hw_params->rx_queues and priv->hw_params->tx_queues, leaving the
seq counters for rings 1..4 uninitialized while ethtool -S still reads
them.  The patch initializes both rx_rings[] and tx_rings[] seq counters
for all GENET_MAX_MQ_CNT + 1 entries.

A couple of questions below, one about the trailer block and one about
the locking around the tx ring syncp that this loop initializes.

>     Fixes: ffc2c8c4a714 ("net: bcmgenet: Initialize u64 stats seq counter")
>     Assisted-by: LLM
>     Co-authored-by: Cursor <cursoragent@cursor.com>
>     Change-Id: I6c3debbd9fa5e7a151789fccf3d9a38db184f434

[Severity: Low]
The trailer block has no Signed-off-by line from the author or submitter,
which Documentation/process/submitting-patches.rst lists as mandatory for
the Developer's Certificate of Origin.  Was it dropped by accident?

The Gerrit Change-Id line is also still present, along with the
Assisted-by and Co-authored-by: Cursor trailers.  Should the Change-Id be
stripped before posting, since stable backport tooling parses this
Fixes:/Signed-off-by trailer block?

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 7b089de9484e3..055e1362173b4 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -4134,10 +4134,10 @@ static int bcmgenet_probe(struct platform_device *pdev)
>  		priv->rx_rings[i].rx_max_coalesced_frames = 1;
>  
>  	/* Initialize u64 stats seq counter for 32bit machines */
> -	for (i = 0; i <= priv->hw_params->rx_queues; i++)
> +	for (i = 0; i <= GENET_MAX_MQ_CNT; i++) {
>  		u64_stats_init(&priv->rx_rings[i].stats64.syncp);
> -	for (i = 0; i <= priv->hw_params->tx_queues; i++)
>  		u64_stats_init(&priv->tx_rings[i].stats64.syncp);
> +	}

[Severity: Medium]
This isn't a bug introduced by this patch, but while looking at the tx
syncp being initialized here: are the writers to a given
tx_rings[i].stats64.syncp actually mutually exclusive on 32-bit?

The NAPI-side writer in __bcmgenet_tx_reclaim() runs with ring->lock
held, taken by bcmgenet_tx_poll() and bcmgenet_tx_reclaim():

	spin_lock_bh(&ring->lock);
	released = __bcmgenet_tx_reclaim(dev, ring);
	...
	u64_stats_update_begin(&stats->syncp);
	u64_stats_add(&stats->packets, pkts_compl);
	u64_stats_add(&stats->bytes, bytes_compl);
	u64_stats_update_end(&stats->syncp);

bcmgenet_timeout() writes the same syncp after bcmgenet_tx_reclaim() has
already dropped that lock:

	bcmgenet_tx_reclaim(dev, ring, true);
	...
	txq_trans_cond_update(txq);

	BCMGENET_STATS64_INC((&ring->stats64), errors);

The timeout callback is invoked from dev_watchdog() as:

	netif_freeze_queues(dev);
	dev->netdev_ops->ndo_tx_timeout(dev, i);
	netif_unfreeze_queues(dev);

which stops queueing but does not quiesce the TX NAPI, so
bcmgenet_tx_poll() for the same ring can be running on another CPU.

On 32-bit, __u64_stats_update_begin() is only:

	preempt_disable_nested();
	write_seqcount_begin(&syncp->seq);

so there is no cross-CPU exclusion and the sequence increment is a plain
read-modify-write.  Can interleaved writers here hand readers such as
bcmgenet_get_stats64() and bcmgenet_get_ethtool_stats() torn 64-bit
values, or leave the sequence permanently odd so that later readers spin
in read_seqcount_begin()?

Would moving the errors increment under ring->lock be appropriate?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918000732.276506-1-florian.fainelli%40broadcom.com
