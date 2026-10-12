Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C213777E;
	Mon, 12 Oct 2026 03:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791774114; cv=none; b=cObZq+9njCBkp+IxJa6Oof6VC0VO+znaR6PRm0Qcqw1rBHAPpUI/7QPxty7miEduorHbWK4uyzoZgOKOHsw0cVi3lGUz2MCThJZYpkyMgInY6QfP1OFzTD++j4Le+fG5r+knZP+ypJ9yhUm9jmH4nRns9nnXq1E40HWycanG2zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791774114; c=relaxed/simple;
	bh=/DSZWa9njgA2gJBbrqczJDySU39sjfYx6qEBEZX/aQM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mse651zcDQgxvBj4i9en2yt2TCHFgM9Q7uqgBCl8ga/cXItDHLqUynohib1a3NZBphcpM/wdSDaFdFh7YXQupRsrFB1l0KG2N3ZduQEO78CcGc4w/6LqQKqzHT0pRabgkk+9ypKrq0nDSaYtBEbqRTiGPlBtIQzW9vMiNadGyDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f57QizkW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f57QizkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1996F1F0089B;
	Mon, 12 Oct 2026 03:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791774113;
	bh=oI3lzkdahAm/zXK7Q5T7j+FGZ2ppaib+hrM7wL53O4o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f57QizkW7t7EgScg5TD+MpsQZJwepgSI6gS/iAWd7tvu3DtMbtzGMznlBgI8zHCX9
	 RDpfMNOwDZJeYAXwSGOVI3TXLzUSRhuGC/UuEhBDqWBubZTAcTCtRowFZOZdXECSH5
	 z73mQ2i6ugRcOkQX1oyiSSD9m1MueSbUwNXydlNeaGksqMsaQgGMfd+GsnmZ5IWpq/
	 KDroRC4RFGkbF4GucqRSenfNj/sNN1DXlFZghs0/8BIs4iw+dPubeqE55dgopYm8vf
	 k3wjRco5FXxuCO1g4dyQWKSB3Ly990C5ksQxoUdOYfKy1VT4g+la3aA9RapNNTTxIg
	 Jb2lCcaygZ8lg==
Subject: Re: [PATCH net-next v13 1/5] net: dsa: motorcomm: initialize
 dsa_switch based on chipid
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Mon, 12 Oct 2026 03:01:51 +0000
Message-ID: <179177411161.434549.11883600135286117076@kernel.org>
In-Reply-To: <20261011025043.1859940-2-kyle.switch@motor-comm.com>
References: <20261011025043.1859940-2-kyle.switch@motor-comm.com>
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

- [Low] The commit message does not describe the patch accurately.
- [Low] In yt92xx_register_switch(), `u32 chipid;` has no initializer.

--

net: dsa: motorcomm: initialize dsa_switch based on chipid

This commit moves the dsa_switch field setup out of yt921x_mdio_probe()
and into a new helper, yt92xx_register_switch(). The helper reads
YT921X_CHIP_ID at probe time and takes the per-series parameters from a
new yt92xx_series table. If the major is unknown, probe fails with
-ENODEV.

> Replace the hardcoded chip handling in yt92xx_register_switch() with a
> data-driven loopup based on the chip ID.

[Severity: Low]
Is this description accurate? yt92xx_register_switch() does not exist
before this patch; the patch adds it. The hardcoded ds-> assignments
that get replaced were in yt921x_mdio_probe().

There's also a typo: "loopup" should be "lookup".

yt92xx_series_lookup() is an if-chain on the major, not a table-driven
lookup.

Could the message also mention the behaviour change? yt921x_mdio_probe()
now reads YT921X_CHIP_ID over MDIO before dsa_register_switch(), and it
fails probe with -ENODEV for an unknown major. Before this patch, the chip
was only identified later, in the setup path:

yt921x_dsa_setup()->yt921x_chip_reset()->yt921x_chip_detect()

That path still reads the same register, so every probe now reads the
chip ID twice.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 91cc5647f2b66..d4c20658216a6 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -4078,6 +4078,67 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {

[ ... ]

> +static int yt92xx_register_switch(struct dsa_switch *ds)
> +{
> +	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
> +	struct device *dev = yt921x_priv_to_device(priv);
> +	const struct yt92xx_series *series;
> +	u32 chipid;
> +	u32 major;
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
> +	mutex_unlock(&priv->reg_lock);
> +	if (res) {
> +		dev_err(dev, "Unexpected chipid 0x%x\n", chipid);
> +		return res;
> +	}

[Severity: Low]
Can this print an uninitialized chipid? chipid has no initializer.
yt921x_reg_mdio_read() only stores to *valp after all four MDIO
transactions succeed, and every error path jumps past that store:

drivers/net/dsa/motorcomm/chip.c:yt921x_reg_mdio_read() {
    ...
	val = (val << 16) | (u16)res;

	*valp = val;
	res = 0;

end:
	mutex_unlock(&bus->mdio_lock);
	return res;
}

So if the MDIO bus fails during yt921x_mdio_probe(), this message prints
whatever is on the stack as if the switch had returned an unknown ID. It
also never prints the actual error in res.

yt921x_chip_detect() does it the other way round. It returns quietly when
the read fails, and prints "Unexpected chipid" only after a successful
read with an unknown major.

> +
> +	major = FIELD_GET(YT921X_CHIP_ID_MAJOR, chipid);
> +	series = yt92xx_series_lookup(major);
> +	if (!series) {
> +		dev_err(dev, "Undefined series info for the corresponding major\n");
> +		return -ENODEV;
> +	}

The real unknown-chip case here has the opposite gap: it doesn't print
the chipid or major that was read.

The last patch in the series, "net: dsa: motorcomm: Add support for
Motorcomm YT922x", appears to fix both. The read-failure branch becomes a
plain return res, and the unknown-major branch prints chipid. Even so, the
bad message is still there at this commit for anyone bisecting.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011025043.1859940-1-kyle.switch%40motor-comm.com
