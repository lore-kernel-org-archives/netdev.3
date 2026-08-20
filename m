Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C4C3D5C06;
	Thu, 20 Aug 2026 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239628; cv=none; b=aNeUZM6E17WV5bHFwDSb2tKKsgGacGPaDdxOg4qZpPJUaGI+RaBYRGApzK2pVH2GAV4lvZezb6TqCr7FlelQLRpddX7528V1QN6BodEF9R9zba2Rsu6K+DZUkFsgWZICJ3u8pCRqXZQ2XFOabMEzxobJDgxrxq4XqFe2muSGZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239628; c=relaxed/simple;
	bh=XGHjW50OuDXq9pe0zZ7nqkB7p2Xe66Gbl7OseTEaCxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d89mwDOl1SjcsZoo4S7TNzuaG/OU5EyVB2akafi0G8WjCA4+yNnlsCTPe1rdS5z38RrDIOL/KkTG0Ah8xWmmAXIGdd+LreFdOWoF0DE7ug4c+vheGIdREEYadiUzP/1FG1WTYXTY6H/4peQ5bm1zN3EtprYc2Ic8LjWl1JAjAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Iev6xuGi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Iev6xuGi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Jn5cBQm1t72zZ6PkjaEjEbGNYb27E4smrhsCjnmnFT8=; b=Iev6xuGi/f0b8sNzUAIq5vFSxZ
	t0JlC5LNasmuTRCKk1ATxPuMSOLTWromKoKiPWQqrP7iXBFtNu9VPecL6dI6tpzu/R0HOkdXJcs0I
	FqqMqytq1SGkyD9fl3DXjQI+tik+QGjLJRq6Oj4cY20AldhksWT4gufq+YkR5HZ2e4wI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wx4fP-000oFZ-99; Thu, 20 Aug 2026 17:26:55 +0200
Date: Thu, 20 Aug 2026 17:26:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Manush Prajwal <manushprajwal555@gmail.com>
Cc: yoshihiro.shimoda.uh@renesas.com, michael.dege@renesas.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3] net: ethernet: renesas: rswitch: fix device_node
 refcount leak in rswitch_get_port_node()
Message-ID: <fa94f4c6-00b0-45e2-aaa2-256fb9bfb0e0@lunn.ch>
References: <6a868ffb.2915925c.31ad32.38af@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a868ffb.2915925c.31ad32.38af@mx.google.com>

> -	for_each_available_child_of_node(ports, port) {
> -		err = of_property_read_u32(port, "reg", &index);
> -		if (err < 0) {
> -			port = NULL;
> -			goto out;
> -		}
> -		if (index == rdev->etha->index)
> +	for_each_available_child_of_node_scoped(ports, child) {

> +		if (of_property_read_u32(child, "reg", &index))
> +			break;

Why did you change this?

Please keep the changes minimal, only change what must be changed.

I doubt you have tested this code in any way, so the change has
risk. By keeping the change as small as possible, you keep the risk
lower, so you are less likely to break it.

	Andrew
