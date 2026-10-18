Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381D3B3C0A
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792360548; cv=none; b=ro1WYrjrkGJ2tKmTnQfoGNFASomsJZVUJ2uA4xzvWmuWYNyjUQpmCeGuQjt9bnAfPCyMEy0XIqUHBoc3Vms10z9tTP0b2OIMKQV4rCqLwL2TdnZYqnBVf5Zoe5OvhH0tuROzkTbamR96/XyvUr5TE3bL2g8cVguIH8Eh5x9eLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792360548; c=relaxed/simple;
	bh=/81qyDB2ZTDWuhk8Dbjw7F0rpwlTXhCjHBMyPIqZqPY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMzIr0CQlMLJ/BG86+p3XBVRb9tk5KoKpmh2KvoU5/N3x1Hh+seX+Kuu2EYCbwcEQYWKz8JXAWPk0PGkLO/6pPzkl0/SAu16ONCR7yEHbmQB9LwAXSSMs9qsgndwWZATheZOevRiEFMnNq82PE9pwUa5uBhxSXFzL6Q0kMtBYfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1g05Qn7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1g05Qn7"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49e73611928so14849655e9.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 14:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792360545; x=1792965345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mO8z2rdDr7jvYldNhIWGcld34J+7H1AXGt8+f2Y4wRM=;
        b=j1g05Qn7bQT/vTqcmRC2e5bdVnoa+bPRbcOY2Qjci7DZ1SwH58WL61IONwyEebvg//
         tJlUE+1WjGqvFcE/QT0wI4U9RloCEn7b3J35y/Ilsezo1caFMMwnJJYbFAs5jJqkH1zt
         A5IBToL6JhEMVmTwI18gR64fV2qvWPAs3sXP+WIjHjoqwX9OI4kNTpRKykDiQErIW4Om
         n3RUrzzcu8pRlbZORxlj5T/fxanZGoV7UnTH0TRD5nVr9DvMM9kSpx3uSj2yeSCyksqb
         MxcXZdpfA3pv8prfeFcw5HdfJNqw9hCNRFea9Mf0kmWehx512hbexSM/+vUhoXB1J7JW
         2Tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792360545; x=1792965345;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mO8z2rdDr7jvYldNhIWGcld34J+7H1AXGt8+f2Y4wRM=;
        b=LqcRlsve7bAwOoWudrM5VV7lhzy0JbjSt53Pt+pSoIiUbENizDPieQXi5kA/OUKdOR
         mYwm1AwzJULK4ucaUKZ1q30hOdMhFyzlGcCG4XqfGe/TA00PECiLlm8m2AKX2GQj+Lp5
         rbkKXSf2yqBNVTudkGvLzpP3XwbDaRBZLsj1DCeJKGmQV6vKTnr7v1UjI/OzW8x3HqBy
         +3aBriP4vgJ4KXctWuF8J5UFumB+edxAdx9X1NXjDlqGM7XrSDRzo/Kqmjj35SDEEWyr
         bv8LK6P38Lbpcr8LIYHw6F+MR6OLx813oEQMIuy+TzxUGLKt/Kyo9wuEmnfNimrWiPY8
         Qfdg==
X-Forwarded-Encrypted: i=1; AKwUvBxLKgbHARv3tgIWs7INpEFhm61yOuhaxKkoGhjLKGX6vk5kzJpua1JWUIEJZaxWYvFcQQaMNOw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIepwLit5wEfu15zYJtOgX863dPDVpbxRx2a+6fv7VKAGWVw/Xn
	hJVmGcATotx7Vg1FR0c1STVHjfsh86KG/eij44m3nsUW84F3xnLYNKPi
X-Gm-Gg: AYBFou1c/JmlBYupLHwo44IUPtfbGjo//YIdhYgHjzauAjC8qilmvE6e35ZBfDYT+NV
	sdNvF+l54wr2+dZPMP1ZWQby2gv8Ir87vNhPXGdxzmtsS6gY5eDTtwisssMOJy0xifWT20h5a2V
	Bnbx/HH/RauxMEVoW1E7oYvc7lQLsdxYIMmzJcn2z4fB7Swa8pIkDXmI/V5KaZekjxmdUhSQCy6
	pT0D+SCfR4QxohdakntRAmHBYb0Td5rpZn5oDI6b5ms6p+q4L4VitnmlMcQX1kEYAuqQ/kPCKt+
	s3S/+bpw8INJ9XGXxnYje+zCvnAGEX93IoxzDeil0+Sq9GXbkMrKuzboDjrwXhL+g8Xl66Fwy8g
	NJ4vfYpRt+i158R7zl56qVm2DiaKv2oQoJuJfilU943qCP2ZOTK1rxwOnvNIje2VyuVXRzXkuJx
	O2IPxwFmKGY6oGiYoJ6IyN2ne9EJ7Cuinch6jcXIls5eVg5TZcYeSXyMtm63O+3jrVUEkTqWf7D
	5M8RKqfjLIxe16rkc/8qaLRz68jouMVgV6f7noAgbNrLWJI5pqLqZkIW9/iOw==
X-Received: by 2002:a05:600c:5254:b0:4a1:e57b:667e with SMTP id 5b1f17b1804b1-4a1e57b68c7mr44096785e9.4.1792360545025;
        Sun, 18 Oct 2026 14:55:45 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1d3e2e602sm233945255e9.5.2026.10.18.14.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:55:44 -0700 (PDT)
Message-ID: <6ad54060.58e5e2d3.9d5ca.ba8b@mx.google.com>
X-Google-Original-Message-ID: <atVAXtsBXdMec-Jo@Ansuel-XPS.>
Date: Sun, 18 Oct 2026 23:55:42 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Stanislaw Pal <kuncy7@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: qca8k: report port statistics from
 the MIB
References: <20261018153658.209999-1-kuncy7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018153658.209999-1-kuncy7@gmail.com>

On Sun, Oct 18, 2026 at 05:36:58PM +0200, Stanislaw Pal wrote:
> qca8k has no .get_stats64, so a user port's netdev counts only the
> frames that cross the CPU port, through the DSA user netdev's own
> tstats. Whatever the switch forwards between its own ports in a
> hardware-offloaded bridge never reaches the CPU and never shows up in
> the counters of either port. The same goes for a conduit that forwards
> in hardware past the host: on a GL.iNet GL-B3000 (IPQ5018 with a
> QCA8337 on SGMII) with the conduit offloaded, a 482 MB upload over the
> WAN port moved the wan netdev's TX bytes by 0.74 MB, while the switch's
> own TxByte counter for that port grew by 503 MB.
> 
> The switch counts every frame in its per-port MIB. .get_stats64 may be
> called in atomic context and the MIB sits behind MDIO (or the Ethernet
> management frames), so read it from a delayed work every 3 s, as ar9331
> and rtl8365mb do, and hand out the cached result. The counters keep
> their value across reads (QCA8K_MIB_CPU_KEEP); only the difference since
> the previous read is added, so a 32-bit counter wrapping between two
> reads does not corrupt the total.

If we really want we can reset after each read but that is problematic for
the ethtool OPs unless we also update that function to store local u64 MIB
for everything.

Up to you... I would start with keeping and updating all the below things
and then evaluate the needed changes to reset at every read.

> 
> With the change, on the same board and setup, a 732 MB upload moved the
> wan netdev's TX bytes by 764.9 MB, the same as the switch's TxByte.
>

This really seems a task for the MIB from mgmt frame... May I ask why those
are not used here?
 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Stanislaw Pal <kuncy7@gmail.com>
> ---
> Tested on a GL.iNet GL-B3000 with the patch on OpenWrt's 6.18 kernel,
> where it differs only in the context of struct qca8k_priv. Built for
> arm64 on net-next with W=1; checkpatch --strict is clean.
> 
>  drivers/net/dsa/qca/qca8k-8xxx.c | 157 +++++++++++++++++++++++++++++++
>  drivers/net/dsa/qca/qca8k.h      |  47 +++++++++
>  2 files changed, 204 insertions(+)
> 
> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index 07227ae8b..9fef54a88 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -1851,6 +1851,156 @@ static void qca8k_setup_hol_fixup(struct qca8k_priv *priv, int port)
>  			   mask);
>  }
>  
> +/* Without .get_stats64 a DSA user port counts only what crosses the CPU
> + * port, which is nothing of the traffic the switch forwards between its own
> + * ports. Report the switch's own port counters instead.
> + */
> +#define QCA8K_STATS_INTERVAL	(3 * HZ)
> +

I would like to see define in the header file, not in the middle of
functions and declaration.

> +static const u8 qca8k_stats_mib[QCA8K_STATS_MIB_COUNT] = {
> +	[QCA8K_STATS_RX_MULTI]		= 0x08,
> +	[QCA8K_STATS_RX_FCS_ERR]	= 0x0c,
> +	[QCA8K_STATS_RX_ALIGN_ERR]	= 0x10,
> +	[QCA8K_STATS_RX_RUNT]		= 0x14,
> +	[QCA8K_STATS_RX_FRAGMENT]	= 0x18,
> +	[QCA8K_STATS_RX_64]		= 0x1c,
> +	[QCA8K_STATS_RX_128]		= 0x20,
> +	[QCA8K_STATS_RX_256]		= 0x24,
> +	[QCA8K_STATS_RX_512]		= 0x28,
> +	[QCA8K_STATS_RX_1024]		= 0x2c,
> +	[QCA8K_STATS_RX_1518]		= 0x30,
> +	[QCA8K_STATS_RX_MAX]		= 0x34,
> +	[QCA8K_STATS_RX_TOO_LONG]	= 0x38,
> +	[QCA8K_STATS_RX_OVERFLOW]	= 0x4c,
> +	[QCA8K_STATS_FILTERED]		= 0x50,
> +	[QCA8K_STATS_TX_UNDERRUN]	= 0x60,
> +	[QCA8K_STATS_TX_64]		= 0x64,
> +	[QCA8K_STATS_TX_128]		= 0x68,
> +	[QCA8K_STATS_TX_256]		= 0x6c,
> +	[QCA8K_STATS_TX_512]		= 0x70,
> +	[QCA8K_STATS_TX_1024]		= 0x74,
> +	[QCA8K_STATS_TX_1518]		= 0x78,
> +	[QCA8K_STATS_TX_MAX]		= 0x7c,
> +	[QCA8K_STATS_TX_OVERSIZE]	= 0x80,
> +	[QCA8K_STATS_TX_COLLISION]	= 0x8c,
> +	[QCA8K_STATS_TX_ABORT_COL]	= 0x90,
> +	[QCA8K_STATS_TX_LATE_COL]	= 0xa4,
> +};

Why STATS and not MIB? Also I would like to have all these register
converted to define if really needed and update the ar8327_mib struct.

Also Also why not use that directly?

> +
> +#define QCA8K_MIB_RX_GOOD_BYTE	0x3c
> +#define QCA8K_MIB_TX_BYTE	0x84
> +

Why this? For 64 bit?

> +static int qca8k_stats_read64(struct qca8k_priv *priv, u32 reg, u64 *val)
> +{
> +	u32 lo, hi;
> +	int ret;
> +
> +	ret = qca8k_read(priv, reg, &lo);
> +	if (!ret)
> +		ret = qca8k_read(priv, reg + 4, &hi);
> +	if (!ret)
> +		*val = ((u64)hi << 32) | lo;
> +
> +	return ret;
> +}
> +

Maybe generalize the logic in get_ethtool_stats?

> +static u64 qca8k_stats_delta64(u64 now, u64 *last)
> +{
> +	/* a flushed MIB starts again from zero */
> +	u64 delta = now >= *last ? now - *last : now;
> +
> +	*last = now;
> +	return delta;
> +}
> +
> +static void qca8k_stats_read_port(struct qca8k_priv *priv, int port)
> +{
> +	struct qca8k_port_stats *ps = &priv->port_stats[port];
> +	u32 raw[QCA8K_STATS_MIB_COUNT], d[QCA8K_STATS_MIB_COUNT];
> +	u32 base = QCA8K_PORT_MIB_COUNTER(port);
> +	struct rtnl_link_stats64 *s = &ps->stats;
> +	u64 rx_bytes, tx_bytes;
> +	int i;
> +
> +	/* all of the slow MDIO reads before the lock */
> +	if (qca8k_stats_read64(priv, base + QCA8K_MIB_RX_GOOD_BYTE, &rx_bytes) ||
> +	    qca8k_stats_read64(priv, base + QCA8K_MIB_TX_BYTE, &tx_bytes))
> +		return;
> +
> +	for (i = 0; i < QCA8K_STATS_MIB_COUNT; i++)
> +		if (qca8k_read(priv, base + qca8k_stats_mib[i], &raw[i]))
> +			return;
> +

As said MDIO here is extra slow especially for MIB every x seconds...

Autocast MIB is a MUCH BETTER WAY.

> +	spin_lock_bh(&ps->lock);
> +
> +	for (i = 0; i < QCA8K_STATS_MIB_COUNT; i++) {
> +		d[i] = raw[i] - ps->last[i];
> +		ps->last[i] = raw[i];
> +	}
> +
> +	s->rx_bytes += qca8k_stats_delta64(rx_bytes, &ps->last_rx_bytes);
> +	s->tx_bytes += qca8k_stats_delta64(tx_bytes, &ps->last_tx_bytes);
> +	s->rx_packets += (u64)d[QCA8K_STATS_RX_64] + d[QCA8K_STATS_RX_128] +
> +			 d[QCA8K_STATS_RX_256] + d[QCA8K_STATS_RX_512] +
> +			 d[QCA8K_STATS_RX_1024] + d[QCA8K_STATS_RX_1518] +
> +			 d[QCA8K_STATS_RX_MAX];
> +	s->tx_packets += (u64)d[QCA8K_STATS_TX_64] + d[QCA8K_STATS_TX_128] +
> +			 d[QCA8K_STATS_TX_256] + d[QCA8K_STATS_TX_512] +
> +			 d[QCA8K_STATS_TX_1024] + d[QCA8K_STATS_TX_1518] +
> +			 d[QCA8K_STATS_TX_MAX];
> +	s->multicast += d[QCA8K_STATS_RX_MULTI];
> +	s->rx_length_errors += (u64)d[QCA8K_STATS_RX_RUNT] +
> +			       d[QCA8K_STATS_RX_FRAGMENT] +
> +			       d[QCA8K_STATS_RX_TOO_LONG];
> +	s->rx_crc_errors += d[QCA8K_STATS_RX_FCS_ERR];
> +	s->rx_frame_errors += d[QCA8K_STATS_RX_ALIGN_ERR];
> +	s->rx_missed_errors += d[QCA8K_STATS_RX_OVERFLOW];
> +	s->rx_dropped += d[QCA8K_STATS_FILTERED];
> +	s->rx_errors += (u64)d[QCA8K_STATS_RX_FCS_ERR] +
> +			d[QCA8K_STATS_RX_ALIGN_ERR] + d[QCA8K_STATS_RX_RUNT] +
> +			d[QCA8K_STATS_RX_FRAGMENT] + d[QCA8K_STATS_RX_OVERFLOW] +
> +			d[QCA8K_STATS_RX_TOO_LONG];
> +	s->tx_fifo_errors += d[QCA8K_STATS_TX_UNDERRUN];
> +	s->tx_aborted_errors += d[QCA8K_STATS_TX_ABORT_COL];
> +	s->tx_window_errors += d[QCA8K_STATS_TX_LATE_COL];

Is it correct to give window_errors to TX late collision?

> +	s->tx_errors += (u64)d[QCA8K_STATS_TX_OVERSIZE] +
> +			d[QCA8K_STATS_TX_ABORT_COL] + d[QCA8K_STATS_TX_UNDERRUN] +
> +			d[QCA8K_STATS_TX_LATE_COL];
> +	s->collisions += d[QCA8K_STATS_TX_COLLISION];
> +
> +	spin_unlock_bh(&ps->lock);
> +}
> +
> +static void qca8k_stats_poll(struct work_struct *work)
> +{
> +	struct qca8k_priv *priv = container_of(work, struct qca8k_priv,
> +					       stats_work.work);
> +	struct dsa_port *dp;
> +
> +	dsa_switch_for_each_user_port(dp, priv->ds)
> +		qca8k_stats_read_port(priv, dp->index);
> +

No reason to scan for a port that is disabled or not connected...

> +	schedule_delayed_work(&priv->stats_work, QCA8K_STATS_INTERVAL);
> +}
> +
> +static void qca8k_get_stats64(struct dsa_switch *ds, int port,
> +			      struct rtnl_link_stats64 *s)
> +{
> +	struct qca8k_priv *priv = ds->priv;
> +	struct qca8k_port_stats *ps = &priv->port_stats[port];
> +
> +	spin_lock_bh(&ps->lock);
> +	memcpy(s, &ps->stats, sizeof(*s));
> +	spin_unlock_bh(&ps->lock);
> +}
> +
> +static void qca8k_teardown(struct dsa_switch *ds)
> +{
> +	struct qca8k_priv *priv = ds->priv;
> +
> +	cancel_delayed_work_sync(&priv->stats_work);
> +}
> +
>  static int
>  qca8k_setup(struct dsa_switch *ds)
>  {
> @@ -2020,6 +2170,11 @@ qca8k_setup(struct dsa_switch *ds)
>  	/* Set max number of LAGs supported */
>  	ds->num_lag_ids = QCA8K_NUM_LAGS;
>  
> +	for (int port = 0; port < QCA8K_NUM_PORTS; port++)
> +		spin_lock_init(&priv->port_stats[port].lock);

Considering everything is run under the same delayed work, does it make
sense to have a spinlock for each port?

Either have a delayed work for each port or a global spinlock for the task.

> +	INIT_DELAYED_WORK(&priv->stats_work, qca8k_stats_poll);
> +	schedule_delayed_work(&priv->stats_work, 0);
> +
>  	return 0;
>  }
>  
> @@ -2033,9 +2188,11 @@ static const struct phylink_mac_ops qca8k_phylink_mac_ops = {
>  static const struct dsa_switch_ops qca8k_switch_ops = {
>  	.get_tag_protocol	= qca8k_get_tag_protocol,
>  	.setup			= qca8k_setup,
> +	.teardown		= qca8k_teardown,
>  	.get_strings		= qca8k_get_strings,
>  	.get_ethtool_stats	= qca8k_get_ethtool_stats,
>  	.get_sset_count		= qca8k_get_sset_count,
> +	.get_stats64		= qca8k_get_stats64,
>  	.set_ageing_time	= qca8k_set_ageing_time,
>  	.support_eee		= dsa_supports_eee,
>  	.set_mac_eee		= qca8k_set_mac_eee,
> diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
> index 956338893..47e9e5631 100644
> --- a/drivers/net/dsa/qca/qca8k.h
> +++ b/drivers/net/dsa/qca/qca8k.h
> @@ -442,6 +442,51 @@ struct qca8k_led {
>  	struct led_classdev cdev;
>  };
>  
> +/* MIB counters behind .get_stats64, in the order qca8k_stats_mib[] reads them */
> +enum qca8k_stats_mib_idx {
> +	QCA8K_STATS_RX_MULTI,
> +	QCA8K_STATS_RX_FCS_ERR,
> +	QCA8K_STATS_RX_ALIGN_ERR,
> +	QCA8K_STATS_RX_RUNT,
> +	QCA8K_STATS_RX_FRAGMENT,
> +	QCA8K_STATS_RX_64,
> +	QCA8K_STATS_RX_128,
> +	QCA8K_STATS_RX_256,
> +	QCA8K_STATS_RX_512,
> +	QCA8K_STATS_RX_1024,
> +	QCA8K_STATS_RX_1518,
> +	QCA8K_STATS_RX_MAX,
> +	QCA8K_STATS_RX_TOO_LONG,
> +	QCA8K_STATS_RX_OVERFLOW,
> +	QCA8K_STATS_FILTERED,
> +	QCA8K_STATS_TX_UNDERRUN,
> +	QCA8K_STATS_TX_64,
> +	QCA8K_STATS_TX_128,
> +	QCA8K_STATS_TX_256,
> +	QCA8K_STATS_TX_512,
> +	QCA8K_STATS_TX_1024,
> +	QCA8K_STATS_TX_1518,
> +	QCA8K_STATS_TX_MAX,
> +	QCA8K_STATS_TX_OVERSIZE,
> +	QCA8K_STATS_TX_COLLISION,
> +	QCA8K_STATS_TX_ABORT_COL,
> +	QCA8K_STATS_TX_LATE_COL,
> +	QCA8K_STATS_MIB_COUNT
> +};
> +
> +/* Port counters for .get_stats64. That callback runs in atomic context and
> + * the MIB sits behind MDIO, so a worker reads it and this holds the result.
> + * The MIB counters are cumulative; last[] keeps the previous raw values so
> + * only the difference is added and a 32-bit counter may wrap between reads.
> + */
> +struct qca8k_port_stats {
> +	spinlock_t lock; /* protects stats against the worker */
> +	struct rtnl_link_stats64 stats;
> +	u32 last[QCA8K_STATS_MIB_COUNT];
> +	u64 last_rx_bytes;
> +	u64 last_tx_bytes;
> +};
> +
>  struct qca8k_priv {
>  	u8 switch_id;
>  	u8 switch_revision;
> @@ -469,6 +514,8 @@ struct qca8k_priv {
>  	struct qca8k_pcs pcs_port_6;
>  	const struct qca8k_match_data *info;
>  	struct qca8k_led ports_led[QCA8K_LED_COUNT];
> +	struct qca8k_port_stats port_stats[QCA8K_NUM_PORTS];
> +	struct delayed_work stats_work;
>  };
>  
>  struct qca8k_mib_desc {
> -- 
> 2.43.0
> 

-- 
	Ansuel
