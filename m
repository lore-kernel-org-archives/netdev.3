Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A329C4A204D;
	Fri,  4 Sep 2026 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529522; cv=none; b=Ja1UyGidrLPgrvUWFc4bBSLXpW4V1HHUylbSR14XRHRhR2gpi54M34TFqKr+hZrni5tcGuc/zhqndiIhMWzC76H6prlDIg2IC6pZ6UGng5wjYwanUSqTzCnh6BZG+8HYe9CD9BMQlT6NQ/srFy2X/9NPOhW3rAT9UYGWc7CiCQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529522; c=relaxed/simple;
	bh=G0G/Hk0/hBhCNciIg62snwdLrgzK3SzxltwwQARrTcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkfr06hdKZl2SEBsxUg/skU61DDK5R5e02rPzWfApOMbIGYFGss3OBBjHgrakQqgOZwBApdZBXvj05ktxQ8Ik3/frTDKK4XZnmRvXP6/gSf6z4QgtqouvfzU+nB5fja98fC48l7vVdrRgxAyE2PvMhIVgxf74jjd8DmZOXdrO9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VX31RNfA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VX31RNfA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BbZxUPUIB/cHOeNiB9yoBWyozEvbvfC3BgYqpk2w06Y=; b=VX31RNfA7hP5/8vzYoBr5rhIFP
	Rj6j+0c+VXVjYhRAcGDkPs3/K8XGELKaKEglRp6XYef1RySJWEel6mS4v2wfwIbO9e4rETg8hX0Mk
	TF/ZtbaRq+AORoPPnS3yfBGVX4d0cLKzsvW5AAJDWAgBxLw0mNNmp6PI9Pmn1OfQsdKw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2UE7-002zdE-1V; Fri, 04 Sep 2026 15:45:07 +0200
Date: Fri, 4 Sep 2026 15:45:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v5 4/6] net: dsa: motorcomm: introduce mib_init
 to control MIB polling initialization
Message-ID: <47d2ccc3-c138-4691-8019-2bddbe9a548f@lunn.ch>
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
 <20260904095416.1692962-4-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904095416.1692962-4-kyle.switch@motor-comm.com>

On Fri, Sep 04, 2026 at 05:54:14PM +0800, Kyle Switch wrote:
> Add a mib_init flag to indicate whether MIB polling has been
> successfully initialized. This prevents the driver from attempting
> to clean up MIB-related resources on removal for switch families
> that do not support MIB polling, which would otherwise trigger
> errors or crashes.

This one i'm not convinced about. At some point, you are going to make
initialisation of MIBs conditional. Why not use that condition to
control removal as well a setup? Why do you need both a conditional
and this pp->mib_init state flag?

> @@ -4771,6 +4772,7 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
>  	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
>  		struct yt921x_port *pp = &priv->ports[i];
>  
> +		if (pp->mib_init)
>  			disable_delayed_work_sync(&pp->mib_read);

This looks odd. When adding an if (), you would expect the next line
to require an additional indent. Was the indentation already wrong?

    Andrew

---
pw-bot: cr
