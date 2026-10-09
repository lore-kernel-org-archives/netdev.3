Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44614B95C2;
	Fri,  9 Oct 2026 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542922; cv=none; b=TsMP5UT0kPC+XSbY/KjqKc1oDZ736sq03Bk4Ppw0t2MmrS/EWfpPysdhrrvqRYsFMyfhYeNTPgcboGqZrBuy0Fpi36spJovD2OXuZePaFR7JHPck/6y1u6n93PWEe5jSceZ2GY7BPajVXvxLVf0MrOHXuOpPiWd5C62YkWkYHHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542922; c=relaxed/simple;
	bh=2kYudB23WdCh2EDu24f2HgOLKStQOUUAgwwViShoqgM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=But9y7Nj/tbJ6JTln1wI3lP5be2XPqCwS4+oOPbigehIRKdPx/J4+aCJ5gJ6x+yWJ4Qu6BZttCbfTOAYwTC0HX8JRj9+/SUi1hM0Y9QPQZxwShER5FgHOnyjk4wAuhHmJghmnTOYz7jaqGRbxNVC2E9VyTHGWMFmbusrSQIDHQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOjgZ5E0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOjgZ5E0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C135A1F0089F;
	Fri,  9 Oct 2026 10:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791542908;
	bh=JeEPKINs+wxcbLZptYMkoX/ARbKsAW37Ofj5cN1xJjI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XOjgZ5E0uAMfm+tkiGs07k88lSED/lYh5lfbPNoVeY/iozj8OomR9PmGLjtsm93Am
	 aBSERFLiG7a5grip5QbOpZPpfhAN9rz1vVr0oQd+SjOHtTA1R00MWvC148Xhqux1HA
	 ENPqPbIe02c/lu435ZdsTwXE+scVnyV6u3FhavFfy2u5eyJNYZ1opN5sGMqf2mX+SA
	 dn70CiBYovG3DGs5wAqjnNiElikKqjqKz9peof5RvVU+OaPwfIFR8Oqj4MjMDeuL1l
	 iCM7kgnnHl5vTOM4L8kmQSnrVNKdz1BGg3u0es3bZ+QHEze+B/RyYadlo+19MIzov7
	 iKSAehG48DTkQ==
Subject: Re: [PATCH net-next] smsc911x: propagate reset GPIO errors
From: netdev-bot+sashiko@kernel.org
To: phucduc.bui@gmail.com
Cc: steve.glendinning@shawell.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 09 Oct 2026 10:48:27 +0000
Message-ID: <179154290727.434549.17639920596465691112@kernel.org>
In-Reply-To: <20261007104731.507647-1-phucduc.bui@gmail.com>
References: <20261007104731.507647-1-phucduc.bui@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] net: smsc911x: clock reference leak when regulator_bulk_get()
  fails
- [Low] The commit fixes a real, user-visible probe failure, but it has
  no Fixes: tag and its message does not say what goes wrong for users.

Pre-existing issues:
- [Low] The header comment on smsc911x_request_resources() (line 409)
  says "Request resources, currently just regulators." The function also…

--

smsc911x: propagate reset GPIO errors

This patch checks the return value of devm_gpiod_get_optional() for the
reset GPIO in smsc911x_request_resources() and propagates errors,
including -EPROBE_DEFER, via dev_err_probe(). If the regulators were
acquired before the GPIO lookup failed, it releases them first.

> diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
> index 3ebd0664c697..41423baaf0af 100644
> --- a/drivers/net/ethernet/smsc/smsc911x.c
> +++ b/drivers/net/ethernet/smsc/smsc911x.c
> @@ -439,6 +439,13 @@ static int smsc911x_request_resources(struct platform_device *pdev)
>  	pdata->reset_gpiod = devm_gpiod_get_optional(&pdev->dev,
>  						     "reset",
>  						     GPIOD_OUT_LOW);
> +	if (IS_ERR(pdata->reset_gpiod)) {
> +		if (!ret)
> +			regulator_bulk_free(ARRAY_SIZE(pdata->supplies),
> +					    pdata->supplies);
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pdata->reset_gpiod),
> +				     "failed to get reset gpio\n");
> +	}

[Severity: Medium]
This problem was not introduced by this patch. The new "if (!ret)"
check depends on the same behaviour, though, so it seems worth raising
here.

If regulator_bulk_get() fails with an error other than -EPROBE_DEFER,
the error is logged and kept in ret, and the function carries on. The
reset GPIO lookup and clk_get() still run. If clk_get() succeeds,
pdata->clk holds a reference. The function then returns the saved
regulator error anyway.

In smsc911x_drv_probe(), a non-zero return from
smsc911x_request_resources() jumps to out_request_resources_fail.
That label only calls iounmap() and skips smsc911x_free_resources(),
so clk_put() is never called and the clock reference leaks:

smsc911x_drv_probe()
  smsc911x_request_resources()
    regulator_bulk_get() returns -EINVAL, saved in ret
    devm_gpiod_get_optional() succeeds
    clk_get() succeeds, pdata->clk holds a reference
    returns -EINVAL
  goto out_request_resources_fail
    iounmap(), but no clk_put()

The "try to continue" comment also does not match what happens. Probe
fails whenever ret is set, so the driver never continues without its
regulators.

Is probe meant to continue without regulators, as the comment says, or
should the regulator failure path just return ret right away? If it
returns early, the new "if (!ret)" test before regulator_bulk_free()
would no longer be needed. Either way, could this be fixed together
with the GPIO error handling, for example by returning early or by
calling clk_put() before returning an error?

[Severity: Low]
This looks like a fix for a probe failure that users can see. Should the
commit message have a Fixes: tag and say what goes wrong?

The unchecked lookup was added by:

commit dd0cb7dbb065 ("net: smsc911x: request and deassert optional RESET GPIO")

Before this patch, devm_gpiod_get_optional() returned
ERR_PTR(-EPROBE_DEFER) if the GPIO provider had not probed yet. That
error was ignored, so the reset line was never requested or deasserted.

Some boards do not pull RESET up, for example the APQ8060 Dragonboard
named in dd0cb7dbb065. On those boards the chip stays in reset, and
smsc911x_init() reads a bad BYTE_TEST or ID_REV value:

smsc911x_drv_probe()
  smsc911x_request_resources()
    devm_gpiod_get_optional() returns ERR_PTR(-EPROBE_DEFER), ignored
  smsc911x_enable_resources()
  smsc911x_init()
    returns -ENODEV

-ENODEV is not a deferral, so probe is never retried and the Ethernet port
is lost.

Could the commit message add the following tag and a sentence about this
failure, so the fix can be picked up for stable?

Fixes: dd0cb7dbb065 ("net: smsc911x: request and deassert optional RESET GPIO")

[Severity: Low]
This problem was not introduced by this patch, but the header comments
on these functions look stale.

The header on smsc911x_request_resources() says:

/*
 * Request resources, currently just regulators.
 ...

The function also requests the optional reset GPIO and the clock. With
this patch, a failed GPIO lookup can now make it return an error.

The header on smsc911x_free_resources() also says "currently just
regulators", but that function also calls clk_put().

Would it be worth updating both comments while touching this code?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007104731.507647-1-phucduc.bui%40gmail.com
