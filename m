Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0B5379EEF;
	Tue,  6 Oct 2026 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791312247; cv=none; b=VL88CrELIj2m3wneXVrlQfgPPuwtwMci2tIgHx7AIMVU5cYkS6DExNJtmHVstHwtWEtZARpqBxil+zmUQaNzrj+HrOhlonr6oGK5/nnTLOrYhzpCB1h+5iKeT5AGjKLmmhDB21C7n+do40d0y/ibEgYajsJMDz6qOG0jT3wUJfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791312247; c=relaxed/simple;
	bh=8jU3HpeW1PFZDe4k0VvvBLCsBHQ72RW5B7IP/YFQHps=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qT4ojnGW/lrNhZMFyGOQE5CyhaElpeBakwunTdQi7jtM03fLnYQB4U1r7i4D4GZb8V8MZH45KgBS1zTwR0cdYppLoHrZwxvC9AOW5iD709wl/J3p/zS3QYZzLqhEXIDLIe/kMe7e32Anxn4IR8tcPVPKxkH3RUsDsSKpEK9i7pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0/Taybx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0/Taybx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85671F0089B;
	Tue,  6 Oct 2026 18:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791312245;
	bh=CmFnd9IiK0DPixO3IAGeQCq6zesCpCUp2b4ws/dEwoA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b0/TaybxOFKKTWfmfdyMArwPyU6wVaKg9mK+Kn3iCospL9/V5czhe3IspsPxIQrFf
	 ZhtvzDQSbKPiikC/iT6pMkg0K64nD6WtPIvJkMimkrfOz1//9lcZlsIewCbhAxEMZA
	 K2P9sKQat09+d8AOBFtL+l17Mvi6oE7zie7egv1U1cwYZDTAC9l+VWpPXmY7p/7tNn
	 3/Z15UE2SOgfZkgKTBxDaxSO5IwcJnwTm8zj1IgvW0bYuqD0tk5U7V0YqPZn26YCjc
	 G7N3b4vYpRYjxApe8icvrjBcaMYf9tevJimppCRYuc9H5EqxGfxM/n+O7lngaf9WOk
	 Sg9wnzbaSMZvw==
Subject: Re: [PATCH net-next v11 1/7] net: dsa: motorcomm: initialize
 dsa_switch based on chipid
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Tue, 06 Oct 2026 18:44:04 +0000
Message-ID: <179131224421.434549.2169215823718202294@kernel.org>
In-Reply-To: <20261002173706.1225502-2-kyle.switch@motor-comm.com>
References: <20261002173706.1225502-2-kyle.switch@motor-comm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In yt92xx_register_switch()
  (drivers/net/dsa/motorcomm/chip.c), `u32 chipid;` has no initializer.

--

net: dsa: motorcomm: initialize dsa_switch based on chipid

This patch moves the hardcoded dsa_switch setup out of
yt921x_mdio_probe() and into a new helper, yt92xx_register_switch().
The helper reads the chip ID, looks up a yt92xx_series table entry by
major number, and fills in the dsa_switch fields from that entry.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 3ff2de383157a..79422def16ffb 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> +static int yt92xx_register_switch(struct dsa_switch *ds)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct device *dev = to_device(priv);
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

[Severity: Medium]
Can this dev_err() print an uninitialized chipid?

chipid has no initializer. This branch runs only when yt921x_reg_read()
fails. The read goes through yt921x_reg_mdio_read(), and every MDIO
failure there jumps past the store to the caller's variable:

drivers/net/dsa/motorcomm/chip.c:yt921x_reg_mdio_read() {
    ...
	res = __mdiobus_read(bus, addr, reg_data);
	if (res < 0)
		goto end;
	val = (val << 16) | (u16)res;

	*valp = val;
	res = 0;

end:
	mutex_unlock(&bus->mdio_lock);
	return res;
}

So an MDIO bus error during yt921x_mdio_probe()->yt92xx_register_switch()
would log leftover stack contents as the chip ID. KMSAN would also flag
this as uninit-value.

The message is also misleading in this case, because no chip ID was
read. Could this branch print the error code instead, for example
"Failed to read chip ID: %d"?

> +
> +	major = FIELD_GET(YT921X_CHIP_ID_MAJOR, chipid);
> +	series = yt92xx_series_lookup(major);
> +	if (!series) {
> +		dev_err(dev, "Undefined series info for the corresponding major\n");
> +		return -ENODEV;
> +	}

This branch is where the chip ID really is unexpected, but the message
leaves out chipid.

The existing yt921x_chip_detect() handles both cases the other way
round. It returns res without a message when the read fails, and prints
"Unexpected chipid 0x%x" only after a successful read with an unknown
major:

drivers/net/dsa/motorcomm/chip.c:yt921x_chip_detect() {
    ...
	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
	if (res)
		return res;
    ...
	if (!info->name) {
		dev_err(dev, "Unexpected chipid 0x%x\n", chipid);
		return -ENODEV;
	}
    ...
}

Should the chipid value be printed here, in the unknown-major branch,
instead of in the read-failure branch above?

> +	priv->series = series;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002173706.1225502-1-kyle.switch%40motor-comm.com
