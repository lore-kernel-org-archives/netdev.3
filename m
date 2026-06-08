Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B8B36EAB0;
	Mon,  8 Jun 2026 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941630; cv=none; b=Rfy4KcZWXchi7ngNde2eZXgmRxC0zHcWf3SvqBt4g2k20QndiNCDAyxc+1xt7d+8kTdahP8zpQslP7fzJwzfxUrFqAhk/Zlj6sXAYGgvOSdcQjuSyqpEpPYHvt2jNHR9eq6+dRK30Ofy5/afoWk82chJOcl3IDJB/1ZDnKs4GmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941630; c=relaxed/simple;
	bh=k7jobtBur3nwKwvUjEq741NUgy8oXhsSl6WzP5vKMUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmXRYELjByavoBZvkFax2t6c8aQJziATd45yc6r1ndqxYk8ExugczTl5ikMERee01RabOQP/QsIVjCNi5Cc9y3V+1bo7JfzuIrx1DlQv0f01EfZR2Jjvg6yfR2fCDB0eKvG4yn1C0etMa40GfNPpTZ/rWCDrFFG71Enln22VsiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ny6JtGQX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ny6JtGQX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ukkqCSJYJymwDKVFR3FRxQ5qMDpnzgrQ0A2cuIJy/rg=; b=Ny6JtGQXQ8+HWFml2J7iRvF0rd
	G0nyeYi5fE6tfTkWgoBgkEfYlUeoaoGc/Bkkd3KHZ4J/r4zeJjlrbYRMClHlzcIgF/NgWSmMxSwhp
	bvvRE+cylP9S7jL8YNYKzbeG5WjpqiglvdN335nkhXBB2HLW/r6NAhH092mSaFodIpwk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wWeGi-006frf-OS; Mon, 08 Jun 2026 20:00:12 +0200
Date: Mon, 8 Jun 2026 20:00:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jens Emil Schulz =?iso-8859-1?Q?=D8stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/9] net: dsa: lan9645x: add basic dsa driver
 for LAN9645X
Message-ID: <9ee993d0-9a71-48ff-b368-fcebe1ee9e48@lunn.ch>
References: <20260603-dsa_lan9645x_switch_driver_base-v7-0-b2f90e676707@microchip.com>
 <20260603-dsa_lan9645x_switch_driver_base-v7-4-b2f90e676707@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-dsa_lan9645x_switch_driver_base-v7-4-b2f90e676707@microchip.com>

> +	dsa_switch_for_each_user_port(dp, ds) {
> +		if (dp->cpu_dp->ds != ds) {
> +			dev_err(ds->dev,
> +				"NPI port on a remote switch is not supported\n");
> +			return -EINVAL;
> +		}
> +
> +		if (first_cpu_dp && dp->cpu_dp != first_cpu_dp) {
> +			dev_err(ds->dev, "Multiple NPI ports not supported\n");
> +			return -EINVAL;
> +		}
> +
> +		first_cpu_dp = dp->cpu_dp;

The reason i asked about NPI ports is because this is looping over
user ports. Yet you say one of these user ports is a CPU port. That
cannot be correct.

The first port returned by dsa_tree_for_each_cpu_port() would be
first_cpu_dp.

	Andrew
