Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD9A366DAE;
	Mon,  9 Mar 2026 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773044567; cv=none; b=c7sAmFlkNs9dT4OLm0pYTaJeLCgeey8IXhGy2pfAXb13HOCJpCsiTC4Rt2DN3X1YYTtLI437Ejku/lDSBde1/wUT2jfIRdrfQ0qRC1B5PZCeyVI9b8zo2s9t+mMQu9OSuztElv1np0o2DeE00I52zuNa1/5aeflaXWEf+qaIyFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773044567; c=relaxed/simple;
	bh=dwOb26n+ndlLmoZCocyESbjisGLEC0JSCWvIfFI6yw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfbdBGXUqdLWaU9Ikrsj/Zn/IpJy+0ieEW+6bkiOW+HAv60e8Iu5q6aE87EJKDfIpT5vwQvTVr/IHD9jsicNR+tYcXOeugkpRvrvgUAuOxm7n+LLLuowVJBaqrEBHuZt0k8dmnr4HzKOGq3bsFZs+il3XX+vOCR4zuOOPfnxZBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcgMHH6k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcgMHH6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C222C4CEF7;
	Mon,  9 Mar 2026 08:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773044567;
	bh=dwOb26n+ndlLmoZCocyESbjisGLEC0JSCWvIfFI6yw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZcgMHH6kZRxZ3Z3gIfrcXaU70ljJsobap+10i7s1uhAKE0HNV7LZTtuLyqMBSq743
	 sEaWBEhQWdn++wyX8tXqzbpLj5ULAG+Xkt2bTC5mwzFNK19VHLpoklWqctbFnu3/vN
	 GZdEWROgicL5ggyxtpQnUfLj6kVh3YtTdcqIx5N6KKZENM0SXR/ld2ZQfTSLHkhTt7
	 RtSfm8Phe/oRR/i6nmcW/dKbYUj3IpDw4yYoAR2dQIoifeIz9FBJjT9+KjR3OEIk2q
	 UU0brJgOKXG8HELuUeVqH9yAV15ULGV4YgEZe8HlG3wV9iMkFrhdM4gR86EhNghxZu
	 oNFHQJM8nor2A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vzVsy-000000003bl-2fnF;
	Mon, 09 Mar 2026 09:22:44 +0100
Date: Mon, 9 Mar 2026 09:22:44 +0100
From: Johan Hovold <johan@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tobias Waldekranz <tobias@waldekranz.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mdio: mvusb: drop redundant device reference
Message-ID: <aa6DVKUgvkW9r80K@hovoldconsulting.com>
References: <20260305104722.16217-1-johan@kernel.org>
 <20260306191923.4ae5a6e1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306191923.4ae5a6e1@kernel.org>

On Fri, Mar 06, 2026 at 07:19:22PM -0800, Jakub Kicinski wrote:
> On Thu,  5 Mar 2026 11:47:22 +0100 Johan Hovold wrote:
> >  	ret = of_mdiobus_register(mdio, dev->of_node);
> >  	if (ret)
> > -		goto put_dev;
> > +		return ret;
> >  
> >  	return 0;
> > -
> > -put_dev:
> > -	usb_put_dev(mvusb->udev);
> > -	return ret;
> 
> better still:
> 
> 	return of_mdiobus_register(mdio, dev->of_node);
> 
> and you can remove int ret; as well

I tend to prefer explicit error paths as combining the two at the end of
a function is a common source of errors where drivers fail to clean up
before returning.

But I'll drop ret in a v2.

Johan
