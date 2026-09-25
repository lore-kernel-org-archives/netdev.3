Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F08E4908A7;
	Fri, 25 Sep 2026 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790334879; cv=none; b=knSoh89AfR1+WwafQi8t7QVefrQUVIGDIZexYZB/Y9lUhSyg8SKKmjTHc2Gh4QxKJeDXxmNiDhM+w0q8HPcKnRj340wuBvzLxG1ka4Ygr3IZ929XRwvjs96LUCzRqjJ90JkOzcG7iC3ORkHvzlQiocriWF7fhyqkaOy3wnL4TJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790334879; c=relaxed/simple;
	bh=XFRmRqD0S8HRwXe5K66T9yAq6vH5i3q5/YKKrKVP8xc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z+SFFiREhnOcrtxMzKldZgbPcxVTaUIXUhSQI7wf2Cjbz5Z/OH5g4qhkV3ctpOCVgGBK+7ReGwzbZk+N5Lqu6nsaaEc1AzU53Ypk1wbl/cSiSq1ijp3RQx/G3lhKEnxCNsfxQhhvwzUXLxzPvlB2lMq9UlOXs/2CWkac0ysDfoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPql0FwJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPql0FwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377E11F00893;
	Fri, 25 Sep 2026 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790334878;
	bh=xqZvzrdwp5abRn7IYM0pqfB5k12MK5VAXrtZcoWY4gY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EPql0FwJVwIdAesbh+JfdXxGcitCAl+UAthKjEIx9NIdOUQ59b6Y1EkQ9Wy5UU7wQ
	 57FDs2scOUIaxbqqaKtPkGRCUsrm1BhBzK0Irnb09slL8XXI2HAwjKxmSMS7dkb7FW
	 mz2EU3054+gEPZ8JVqWBrHV2Lts7iOSy/ZskfPTrSMNpqCbYaD9OSn5nFGP6lW1k5m
	 B2TL90dIkgX6RAYXXYjtFiTRD0QwwJr2oV83hz+EXx2OVKlT/e9b5QfwgopTCjhgjd
	 +fCv0W0aYfrJ/BLhvanBmbzSSeV7v7w2cnXABJKcP5Rgu3e8NYsD6vzZO3fUeVSp5/
	 zrHw/+R5syXiQ==
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: align real_num_tx_queues to
 mqprio configuration
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, daniel@riscstar.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 11:14:36 +0000
Message-ID: <179033487678.2160803.10600059804699788917@kernel.org>
In-Reply-To:
 <20260924-stmmac-mqprio-prio-offload-v2-2-fdd8b69efccf@oss.qualcomm.com>
References:
 <20260924-stmmac-mqprio-prio-offload-v2-2-fdd8b69efccf@oss.qualcomm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] After this patch, stmmac_hw_setup() sets the real TX queue count
  from the cached priv->xmit_qdisc.num_tx_queues instead of…
- [High] __stmmac_dvr_probe() sets priv->xmit_qdisc.num_tx_queues =
  priv->plat->tx_queues_to_use (line 7926) before calling…
- [Low] The commit message says the new field 'is restored to
  [plat->tx_queues_to_use] when the mqprio qdisc is destroyed or its…
- [Low] The patch fixes a user-visible inconsistency: on reopen,
  real_num_tx_queues is reset to plat->tx_queues_to_use while the netdev…

--

net: stmmac: align real_num_tx_queues to mqprio configuration

This commit adds priv->xmit_qdisc.num_tx_queues to hold the number of TX
queues enabled by the current mqprio offload. stmmac_hw_setup() now uses
it instead of plat->tx_queues_to_use when setting real_num_tx_queues on
open. The field is set at probe, and reset when the mqprio offload is
removed.

> The field defaults to plat->tx_queues_to_use at probe time and is restored
> to it when the mqprio qdisc is destroyed or its setup fails, so a device
> without an active mqprio offload keeps the devicetree configured queue
> count across reopens.

[Severity: Low]

Is the "or its setup fails" part accurate? In tc_setup_dwmac510_mqprio(),
the new field is only assigned on the success path:

	priv->xmit_qdisc.num_tx_queues = num_tx_queues;

	return 0;

error_reset_num_tx_queues:
	...
error_reset_tc:
	...

The error labels roll back algo, the TC map and real_num_tx_queues. They
leave num_tx_queues at the previous configuration's value.

stmmac_reset_tc_mqprio() does not run on a failed setup either. Because
hw_offload was never set, mqprio_destroy() calls netdev_set_num_tc(dev, 0)
instead of ndo_setup_tc.

Keeping the previous value matches commit 02fffd1939f6 ("net: stmmac:
preserve real_num_tx_queues on mqprio setup failure"). So the code looks
right, and it is the description that differs.

The message also calls plat->tx_queues_to_use "the devicetree value".
stmmac_hw_init() clamps that value, and ethtool -L can change it at
runtime (see the comments below).

> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

[Severity: Low]

Should this have a Fixes: tag? The mqprio offload has been lowering
real_num_tx_queues since commit 195e4f409a40 ("net: stmmac: support fp
parameter of tc-mqprio"). The related fix 02fffd1939f6 carries
Fixes: 195e4f409a40.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 0c9083f8846e0..ad6be5166b956 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3772,7 +3772,7 @@ static int stmmac_hw_setup(struct net_device *dev)
>  
>  	/* Configure real RX and TX queues */
>  	netif_set_real_num_rx_queues(dev, priv->plat->rx_queues_to_use);
> -	netif_set_real_num_tx_queues(dev, priv->plat->tx_queues_to_use);
> +	netif_set_real_num_tx_queues(dev, priv->xmit_qdisc.num_tx_queues);

[Severity: High]

What keeps priv->xmit_qdisc.num_tx_queues in sync with
plat->tx_queues_to_use when the channel count is changed with ethtool?

stmmac_set_channels()->stmmac_reinit_queues() only updates the plat
fields before it reopens the device:

stmmac_reinit_queues() {
    ...
	priv->plat->rx_queues_to_use = rx_cnt;
	priv->plat->tx_queues_to_use = tx_cnt;
    ...
}

The new field is only written in three places: __stmmac_dvr_probe(),
stmmac_reset_tc_mqprio() and the success path of
tc_setup_dwmac510_mqprio().

Take "ethtool -L eth0 tx 2" on a 4-queue device with no mqprio offload.
The reopen then does this:

__stmmac_open()
  alloc_dma_tx_desc_resources()   /* rings for queues 0..1 only */
  stmmac_hw_setup()
    netif_set_real_num_tx_queues(dev, 4)
    stmmac_start_all_dma()        /* starts 2 TX channels */

The netif_set_real_num_tx_queues() call succeeds because its only upper
bound is dev->num_tx_queues, which is MTL_MAX_TX_QUEUES. Since dma_conf
is freshly kzalloc'd, tx_queue[2..3].tx_skbuff and dma_tx are NULL.

stmmac has no ndo_select_queue, so skb_tx_hash() can pick queue 2 or 3.
stmmac_xmit() takes skb_get_queue_mapping() without a bounds check and
then does:

	WARN_ON(tx_q->tx_skbuff[first_entry]);

Can this dereference a NULL tx_skbuff? stmmac_tso_xmit() seems to have
the same problem. The same thing happens if the channel change is made
while the interface is down and applied on the next open.

In the other direction, when TX channels are increased, the extra queues
are never exposed. ethtool -L then silently has no effect on TX, and
ethtool -l reports a count the netdev does not use.

Before this patch, stmmac_hw_setup() always used the current
plat->tx_queues_to_use, so real_num_tx_queues matched the allocated rings.

Would it make sense to update or clamp the cached value in
stmmac_reinit_queues()? Using min(xmit_qdisc.num_tx_queues,
plat->tx_queues_to_use) in stmmac_hw_setup() would also work.

Either way, what should happen to an active mqprio offload whose ranges
no longer fit the new count? It could be reset, or the channel change
could be rejected.

[ ... ]

> @@ -7923,6 +7923,7 @@ static int __stmmac_dvr_probe(struct device *device,
>  		priv->xmit_qdisc.prio[i] = priv->plat->tx_queues_cfg[i].prio;
>  	}
>  	priv->xmit_qdisc.algo = priv->plat->tx_sched_algorithm;
> +	priv->xmit_qdisc.num_tx_queues = priv->plat->tx_queues_to_use;

[Severity: High]

Is this set too early in probe? __stmmac_dvr_probe() calls
stmmac_hw_init() later, and that can lower plat->tx_queues_to_use:

stmmac_hw_init() {
    ...
	if (priv->dma_cap.number_tx_queues &&
	    priv->plat->tx_queues_to_use > priv->dma_cap.number_tx_queues) {
		dev_warn(priv->device,
			 "Number of Tx queues (%u) exceeds dma capability\n",
			 priv->plat->tx_queues_to_use);
		priv->plat->tx_queues_to_use = priv->dma_cap.number_tx_queues;
	}
    ...
}

The cached value keeps the count from before the clamp. Take a platform
where the devicetree or glue driver asks for more TX queues than the core
has. Every open then calls netif_set_real_num_tx_queues() with the larger
count.

Ring allocation, DMA init, NAPI and stmmac_start_all_dma() all use the
clamped plat->tx_queues_to_use.

Could traffic hashed to the extra queues hit the same NULL
tx_q->tx_skbuff dereference in stmmac_xmit()? That would need no
reconfiguration, only opening the interface and sending traffic.

The only thing that brings the cache back in sync is installing and then
removing an mqprio qdisc, through stmmac_reset_tc_mqprio().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-stmmac-mqprio-prio-offload-v2-0-fdd8b69efccf%40oss.qualcomm.com
