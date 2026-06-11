Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118F3E6DD8;
	Thu, 11 Jun 2026 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191269; cv=none; b=QGWXUywmwSLPnvQ11ciCg1xXvv64ujy0Ptcigyw/AsLKFwT+/YbyWaHCsvUz3yyRF2pxgDJh/Wb6QZgJX4byfrabvMEoWs7C+FbNAyNUGe0TgEkP47kN1KYuJjRriIh6w+JlRtno1nHc485FFx8ZndpYST2C05Iioi+i6uXk0qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191269; c=relaxed/simple;
	bh=wrj4lalTc3AYDvqQq7xQg/8gITXDClmdh93VbzRtEiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlR6sW7bMgO5W4lcvitjLcLnZITdTk74CLVJ8hOaJ7ZkfbZo8cGxHQwqs5HttqL1V37u50IRA1oy6k3RZEMpkmoPbT5WOWbfHwbzpnS45faQX25aYpmKr16u5yj2efmBr0dWCGbKU/RX8GCGk8qONF40N/UMbRppqEIzDL8M1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osYG+Qey; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osYG+Qey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F521F00893;
	Thu, 11 Jun 2026 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191267;
	bh=ohLurThQc3Ri47VzFPST5IsrbVqmfEKuH6/7JIkAFaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=osYG+Qeymn/FEPZ6LGvNn1TDlJ+i2ZYRXhnU7MnpeQfaDwjT8L4DY/D61d2bByThg
	 L1Q+HjdyORR1AYHgFbLntplxQgGwkBUfRBG6b4pn/degX/6hof5cCtjrC0xgv6064U
	 4wKxjVh6pcHgyHTBRdyXzf2rhjUmS+OnI3aDo1KFLlQlMT5FIBQM9PDnyiOq/eFx+K
	 QuEi0ivBwHUnn/stFV4UelRkXQyK9BQYPDp/yGg0sdfQBdbBUjey8v8sV9SLwYMQjg
	 4Qa8/Wat8uQXaF2+rS56f/b/e/ADS9RzLweYxG864e/UZlgRioUeTnpggb2sbVHnc3
	 Tij1o2CzoMjWA==
Date: Thu, 11 Jun 2026 16:21:03 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/4] net: dsa: mxl862xx: move phylink stubs
 to mxl862xx-phylink.c
Message-ID: <20260611152103.GT3920875@horms.kernel.org>
References: <f551d90bf2f6820ed6785f5f8e6548d4fc3bd598.1780968180.git.daniel@makrotopia.org>
 <20260611130750.575946-2-horms@kernel.org>
 <aiq4GEDlCok3B2lT@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiq4GEDlCok3B2lT@makrotopia.org>

On Thu, Jun 11, 2026 at 02:28:56PM +0100, Daniel Golle wrote:
> On Thu, Jun 11, 2026 at 02:07:51PM +0100, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > ---
> > net: dsa: mxl862xx: move phylink stubs to mxl862xx-phylink.c
> > 
> > Move the phylink MAC operations and get_caps callback from mxl862xx.c
> > into a dedicated mxl862xx-phylink.c file. This prepares for the SerDes
> > PCS implementation which adds substantial phylink/PCS code.
> > 
> > > diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> > > index 2f22adedfbf67..a193f3c07d359 100644
> > > --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> > > +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
> > 
> > [ ... ]
> > 
> > [Severity: Critical]
> > This is a pre-existing issue, but the crc_err_work can execute after
> > dsa_unregister_switch(), leading to a use-after-free of ds->dst and
> > dsa_port structures.
> > 
> > In mxl862xx_remove(), dsa_unregister_switch() is called before the
> > asynchronous crc_err_work is cancelled via mxl862xx_host_shutdown():
> > 
> > drivers/net/dsa/mxl862xx/mxl862xx.c:mxl862xx_remove() {
> > 	...
> > 	dsa_unregister_switch(ds);
> > 
> > 	mxl862xx_host_shutdown(priv);
> > 	...
> > }
> > 
> > dsa_unregister_switch() tears down the DSA tree, frees all dsa_port
> > objects, and drops the reference to ds->dst.
> > 
> > If mxl862xx_crc_err_work_fn executes concurrently or after
> > dsa_unregister_switch() has returned, it traverses already freed
> > dsa_port entries:
> > 
> > drivers/net/dsa/mxl862xx/mxl862xx-host.c:mxl862xx_crc_err_work_fn() {
> > 	...
> > 	dsa_switch_for_each_cpu_port(dp, priv->ds)
> > 		dev_close(dp->conduit);
> > 	...
> > }
> > 
> > Could this order in mxl862xx_remove() result in a use-after-free, and
> > should mxl862xx_host_shutdown() be called before dsa_unregister_switch()?
> 
> To really address this a guard in mxl862xx_host_shutdown() will be
> needed. I'd rather do this in a separate Fixes:-patch targetting 'net'
> rather than in this series targetting 'net-next', right?

Yes, that sounds like a good approach to me.
