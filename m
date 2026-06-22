Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0323FBA7;
	Mon, 22 Jun 2026 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147782; cv=none; b=U6mPSYY/NNMboT0tXH2YItVB85rVB0j95Z0rJNwZ/w6j0Yuhh+B4w+yIf7e4hA+hnhqrkkvRGuSZQxBWd7BroHVkYVBRC+9Z4J7L2NHj9kqkpddmuxj5gGvpRHSPkGszMksozxWo94plGW0FXODXYkS8oHJUQ19Bdnv4iUS1FaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147782; c=relaxed/simple;
	bh=PNAwaPyfeFAN5jmhjq3UqEWbMj4RHXJpvd/22xLK0lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ne162BH1J6sWI24lZlevR4dCUR9T6aP8POUfSAqYOEFLmw5m+dQ1ha31TjvoACm/+x6bDQ1/p0uPR3h2rHvR72Ocjx9jelZpELrvAomR6Vm1+XDDpD2VO/rSDmgOSwio7+n/W3iBHNCnb9Tm7pkYUFZWSslTy+G9IUyP9P9oE7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSNUZ7pu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSNUZ7pu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CA81F000E9;
	Mon, 22 Jun 2026 17:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147781;
	bh=hSLwvCEZqAbWTIqOAv5AWwP83yp2ofxs8EnL3FIWSVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YSNUZ7pu3LHk1J14Czs7mheXNU5Lsl4I1XFOgeRGW5vp3H3u7kxs3Z41GJTbOIcGk
	 PDG5UQlemj5IKy4tzgioxB9i8P+H+9roFC7r++Shmpw7S5YRfEOsSvjoaKr5KBXgTi
	 9lxFnTXls1s/yPUQ2Few17QPkLjCwYVGn3C/ZySYWkegaT60MJ0A9jbzI/wJrs0W2H
	 abT6lkbDfqxV840k2e8WaKbrmKTKLbdUCbNOUYYVW1A2zkR7qefNLQ7j/sT0br3Dw/
	 dJKEG8wWPRAvKz2tVrltqejDM0L5681tRYnyti9yWomjKWvtdfz1+gtSoxfx/uFMmM
	 vwhwsNC9idIWA==
Date: Mon, 22 Jun 2026 18:02:55 +0100
From: Simon Horman <horms@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sungem: fix probe error cleanup
Message-ID: <20260622170255.GJ827683@horms.kernel.org>
References: <20260620155326.80582-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620155326.80582-1-ruoyuw560@gmail.com>

On Sat, Jun 20, 2026 at 11:53:26PM +0800, Ruoyu Wang wrote:
> gem_init_one() calls gem_remove_one() when register_netdev() fails.
> That path unregisters and frees resources owned by the net_device,
> then probe continues into its own cleanup labels and touches the same
> state again.
> 
> Clear the driver data and remove the NAPI instance on this error path,
> then let the existing probe cleanup labels release the resources once.

Hi Ruoyu,

I think it would be useful to explain how this problem was found,
naming any publicly available tools that were used.

And to explain what testing has occurred.

> 

A fixes tag should go here (no blank line between it and your
Signed-off-by line).
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

...

-- 
pw-bot: changes-requested
