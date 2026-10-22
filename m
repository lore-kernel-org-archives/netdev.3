Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635084;
	b=HLLu2s6BKdOfS9w0C0K9MKRnC4H4EraPB7juNjeCCavNjxixc2UMmG1+3VaJOFkmdT8S
	 oQJkp4i/FH16hemURyAPdrxbM0GX1XbfQSro7sJc9OZh39mQK70u5on2/zv79R+9CDa+j
	 a8hqI2+3jPo64RhOcVjJY0cr/SQv8IOwEtbx+WWnbR81opVp9qqDBtHNkMlzhXtXKwvHq
	 GjZaEnEW5mCNk/S/fNGgbchAEvV1mpuAUdVhqIXZd9yxHvKsjgIxmA2786mBHHVoidNGs
	 nnjuKvfMZ6nlF1X5SKYLFzsTxQTq/z0xqsL/CFnqbKgwvHfpWzB53T1OTSBIY9XQIlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635084;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NVpJPsHPb+g87dZ4jzbZKza1MAEpX4JtDsoNjlMaUsw=;
	b=ftTmD+9B+SqYl+EtHN8D64xo+JC3gL/DIAd9U/FoVLu0ZogQF2kylngJOZKJutMs9IYj
	 WSY6ZdwF3IrJu59vZaOp+UsjH9y0zlFFSnss6ILaPEQvd4gMudZzcOEc4I8LYw/4EKFgD
	 h9qn0ZZKyJxZVOcuDCKLAfDa7SlWzo1nYHZJPxRFm8R0/cYdxKfk5wUe/VEnCYn+/VeRc
	 j9PcfB9wwfGHNQc29tDaBq4GwyvHswVj7RbE7IG2OBZXl+rreGJ46p5PW2TMzBPmLQJON
	 nIL5WsKPqBdTLrJ6CUR0iqU89CLBQ4QWf0QsKjxOcgjN2xRpHfnEIX1V+1hrY4kr12w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQ7UYTVF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45032606A31A;
	Thu, 22 Oct 2026 02:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQ7UYTVF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4D31F000C1;
	Thu, 22 Oct 2026 02:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792635083;
	bh=NVpJPsHPb+g87dZ4jzbZKza1MAEpX4JtDsoNjlMaUsw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CQ7UYTVFlYKUjN/9ndlYFGdcEC1tqhYjzia13KPLTe6fvW8MZ1r90dbbWmB6ycdLK
	 1sPYvOsEUB68E8vQP32CNrjkDTsAvJgkNA2zgSC4cjwv5FftU1/yfTxYsNG/NSoD4c
	 CPB/ZArcijXNEgeoyOv5X1SLoG94znqlsppcS7sgfPLnt86bOzwNSyaPk6BUMjLzvr
	 94NxUa8vsxGvQGSoK6QCWsm+zR3NgoLHzeCSqL7KAY38pN6FLUhAiNCPfP8ZxVfyxI
	 1tgD1tzH4hUn2jgEvjR9rit5tv51cagpIzK500GCzCh8J4aBknPqJwopODn+uCTRjw
	 ne3hxxXrlcqYg==
Subject: Re: [PATCH net-next v16 1/5] net: dsa: motorcomm: initialize
 dsa_switch based on chipid
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Thu, 22 Oct 2026 02:11:22 +0000
Message-ID: <179263508238.3135.2126359044683205033@kernel.org>
In-Reply-To: <20261020111115.3072180-2-kyle.switch@motor-comm.com>
References: <20261020111115.3072180-2-kyle.switch@motor-comm.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] When yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid) fails,
  yt92xx_register_switch() (drivers/net/dsa/motorcomm/chip.c) prints…

--

net: dsa: motorcomm: initialize dsa_switch based on chipid

This patch replaces the hardcoded dsa_switch setup in yt921x_mdio_probe()
with a new helper, yt92xx_register_switch(). The helper reads the chip ID,
looks up a per-series descriptor table and fills in the dsa_switch fields
from that descriptor.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index d4fc20c52a58d..4add61b89310a 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

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
                                                          ^^^^^^

[Severity: Low]
Can this print an uninitialized value?

chipid is a local u32 with no initializer. This dev_err() only runs when
yt921x_reg_read() has failed. With the MDIO backend, the output pointer is
written only on success. Every error path jumps over the store:

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

So if an MDIO error happens during yt921x_mdio_probe(), the log line will
show leftover stack contents. The wording also suggests a bad ID was read,
when in fact the read failed.

The same string in yt921x_chip_detect() is printed only after a successful
read, when the major is not recognized.

Could the read-failure path just return res, or print a message that does
not use chipid?

It looks like the final patch of this series, "net: dsa: motorcomm: Add
support for Motorcomm YT922x", rewrites this branch as a plain "if (res)
return res;". After that change, chipid is printed only on the unknown-major
path. The intermediate patches in the series still contain this code.

> +		return res;
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020111115.3072180-1-kyle.switch%40motor-comm.com
