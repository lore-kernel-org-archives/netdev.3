Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE2137186A;
	Mon, 15 Jun 2026 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567821; cv=none; b=lUqsXYyLpWLQft22BIxB+Y3zHQXsi59vyaRkK5lVmij4kuUulIRAaiFirHJhsXGhKQpUKW2ZJsO6jOnVkNUBvjMIEw5Pt2DQ1A4/SsyTd+QZ2C7Z30NqD2lFolV1jLFZL6VKsO9IwDnPPyzR7psxWVBS1EOxMCOsA1QkSolBlSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567821; c=relaxed/simple;
	bh=u+VdMQAPwin0vklpDkgVQzdr4/UVXMs3t/Qahc7Hl/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yrx+iuVY/TStJizcG806WyTRC1tJ3u1ykD3Q783ekSUD+ZyevcnG+7YVWMrUcbbGHVKAYxhVdtj5TUPQQXhYywt5qOtSpTPPUhA94VB2KFle4ZE4fQkVeHZNkao53+SoNOilUeXHk6MWckk5PKee3h5qNBQfcTMBQ0ZOXvTfC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csXy83Ir; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csXy83Ir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0491F000E9;
	Mon, 15 Jun 2026 23:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781567820;
	bh=kJvU7XOIbSyX9Zm4EZO5FyKhGmgcOkVUxZvYfOyaTQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=csXy83IrQ+/9BMRoGJEi/VDlG3CXFWEBKqtWSWTCSusM3nwspAb6S2W8QCU5OwP6w
	 lTO9gFwH1kjLEN+UjdezTZhvdVpqa+uDLzXmd+noDXwbl+uTm75M9ow4ur7rOEu8r6
	 ofwkVyVhXJYX2U6unvGcsejPPVL95+/joy/DZdxoGu/6Bs9CeUSZ/QSzMHHQnRrf2G
	 VdPoKcUm+KEdchc5pvuOTQrFtB5bmWgI0lyhOOiVskDDLLGEv1e7N9kDPSrW7wKyS0
	 usmpyC6JdBMmNtt699G+Z3cFbp4XidIRz4zgjAR28+nL8UGbM1t1EXTy0RNn3C7NYI
	 QjvLYP1HSfDaA==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel@makrotopia.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	chester.a.unal@arinc9.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 7/8] net: dsa: mt7530: implement port_fast_age
Date: Mon, 15 Jun 2026 16:56:58 -0700
Message-ID: <20260615235658.1060805-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <e6cdb705f0ec142283071e1966000d3a76f71a16.1781312667.git.daniel@makrotopia.org>
References: <e6cdb705f0ec142283071e1966000d3a76f71a16.1781312667.git.daniel@makrotopia.org>
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
Subject: net: dsa: mt7530: implement port_fast_age

This change adds a .port_fast_age operation for the mt7530 DSA driver.
The implementation triggers an ATC flush of all non-static MAC address
entries and polls ATC_BUSY for completion.

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index dcf72ab0cd66..c96420c291d5 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -193,6 +193,21 @@ mt7530_fdb_cmd(struct mt7530_priv *priv, enum mt7530_fdb_cmd cmd, u32 *rsp)
>  	return 0;
>  }
>  
> +static void mt7530_port_fast_age(struct dsa_switch *ds, int port)
> +{
> +	struct mt7530_priv *priv = ds->priv;
> +	struct mt7530_dummy_poll p;
> +	u32 val;
> +
> +	/* Flush all non-static MAC address entries */
> +	val = ATC_BUSY | ATC_MAT_NON_STATIC_MAC | MT7530_FDB_FLUSH;
> +	regmap_write(priv->regmap, MT7530_ATC, val);

[High]
Should this transaction be serialised against priv->reg_mutex?

Every other accessor that touches MT7530_ATC wraps the write+poll
sequence in mutex_lock(&priv->reg_mutex)/mutex_unlock(&priv->reg_mutex).
For example mt7530_port_fdb_add(), mt7530_port_fdb_del(),
mt7530_port_fdb_dump(), mt7530_port_mdb_add() and mt7530_port_mdb_del()
all hold reg_mutex around the call to mt7530_fdb_cmd():

	mutex_lock(&priv->reg_mutex);
	mt7530_fdb_write(priv, vid, port_mask, addr, -1, STATIC_ENT);
	ret = mt7530_fdb_cmd(priv, MT7530_FDB_WRITE, NULL);
	mutex_unlock(&priv->reg_mutex);

If .port_fast_age runs concurrently with one of those operations, can
the two write-then-busy-poll sequences on the same MT7530_ATC register
overlap?

Could one thread's poll loop observe ATC_BUSY clearing for the other
thread's command, leading mt7530_port_fdb_dump() to read stale ATRD
data, or could one thread's freshly written ATC command be overwritten
by the other before the controller has executed it?

> +
> +	INIT_MT7530_DUMMY_POLL(&p, priv, MT7530_ATC);
> +	readx_poll_timeout(mt7530_mii_poll, &p, val,
> +			   !(val & ATC_BUSY), 20, 20000);
> +}

[Medium]
Is there a reason the return value of readx_poll_timeout() is ignored
here?

The structurally identical helper mt7530_fdb_cmd() in the same file
checks the result and emits a diagnostic on timeout:

	ret = readx_poll_timeout(mt7530_mii_poll, &p, val,
				 !(val & ATC_BUSY), 20, 20000);
	if (ret < 0) {
		dev_err(priv->dev, "reset timeout\n");
		return ret;
	}

Peer DSA drivers also log on failure (b53_br_fast_age prints "fast
ageing failed"; rtl83xx_port_fast_age prints "failed to fast age on
port %d: %d").

If the ATC engine fails to clear ATC_BUSY within the 20ms timeout,
mt7530_port_fast_age() returns silently and a subsequent
mt7530_fdb_cmd() will write a new command on top of the in-flight
operation. Should this path emit dev_err() on timeout to make a wedged
ATC engine visible to operators?

> +
>  static void
>  mt7530_fdb_read(struct mt7530_priv *priv, struct mt7530_fdb *fdb)
>  {

[ ... ]

[Low]
Is the claim in the commit message accurate?

  "This is consistent with what other DSA drivers do (b53, realtek)
  and relearning is fast."

Both drivers cited actually implement per-port fast aging.

In b53, b53_br_fast_age() calls b53_fast_age_port() which writes the
target port to B53_FAST_AGE_PORT_CTRL and selects FAST_AGE_PORT mode.

In realtek, rtl83xx_port_fast_age() calls
priv->ops->l2_flush(priv, port, 0), and rtl8366rb_port_fast_age()
flushes only BIT(port) via RTL8366RB_SECURITY_CTRL.

The mt7530 implementation flushes globally and ignores the port
argument entirely, which is the opposite of the cited examples. The
hardware-limitation rationale ("switch does not offer combined
non-static AND per-port match mode") may be valid, but the b53/realtek
comparison appears to be the wrong precedent.

A side effect not mentioned is that an STP transition on one port will
flush dynamic FDB entries on every other port and every other bridge
sharing the switch. Should this divergence from the typical
.port_fast_age contract be called out?

> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
> index abf19aa69520..decad7a93dbd 100644
> --- a/drivers/net/dsa/mt7530.h
> +++ b/drivers/net/dsa/mt7530.h
> @@ -165,6 +165,7 @@ enum mt753x_to_cpu_fw {
>  #define  ATC_MAT_MASK			GENMASK(11, 8)
>  #define  ATC_MAT(x)			FIELD_PREP(ATC_MAT_MASK, x)
>  #define  ATC_MAT_MACTAB			ATC_MAT(0)
> +#define  ATC_MAT_NON_STATIC_MAC	ATC_MAT(4)

[Low]
The new ATC_MAT_NON_STATIC_MAC define uses a single tab between the
macro name and its value, while the surrounding ATC_MAT_* macros use
multiple tabs and align the values at the same column. Should this
follow the existing alignment?

>  
>  enum mt7530_fdb_cmd {
>  	MT7530_FDB_READ	= 0,
