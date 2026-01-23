Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E302D249E;
	Fri, 23 Jan 2026 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196945; cv=none; b=cHnfoEo7PiCOwLk0+Nr5yOBV4dQl/lnd4ZhBWMoH15ImeGKB+uBkpouyJinhfc5SpisUY8vXfUuvgM7QBvdgAVPA1EyWowv2SIFCxLbilQ4IcLPBMuqYhfax2eQDKdrzIoXYf9A1eLt50At7JkaXwzGsIiefTbwbfVMpMM56nRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196945; c=relaxed/simple;
	bh=meKOjVZZ9dwSHarbTeQEmq9FKIEjKTRIj0vYgs6ZiaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3fCyE8xDrXuDT/0SQ4dAjW+SSkLS57vX+Q0cBoo4F3zva98M2Oc1T7grwEs3O1chDNZjQaf/bM6zcUvOtvDlHYtqJuG5mALExw7X4By8tiafAcJOnAcVJ/jeyMcSaSntX73TRGFpLkemt0jwmvQ3cgzvCiy4rVUKKBJdoTYLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DOiOvcO4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DOiOvcO4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=25nCw+68nHZlmTNCLEUI5W7nESEF803EIPLazWLHuC4=; b=DOiOvcO42IoJp6A4Z8uIl/n1A+
	pSd0Yp0VFU1/PzpUEtbSPohkt2b9GQYr8a2ggBCCdFGBODSl5iOyGRSuKLgYEo/rDPNOU45mzfQUe
	dAzfhee0UYvz4I2AMp0wqVZeo6Qplvd5Nm4VQTpHW0ZkVxnxK2k2qwNaJe/xw5OStGQk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjMwV-004JLK-EV; Fri, 23 Jan 2026 20:35:39 +0100
Date: Fri, 23 Jan 2026 20:35:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] net: usb: sr9700: use ETH_ALEN instead of magic
 number
Message-ID: <ab732666-bd4b-474e-8180-0039f7d61683@lunn.ch>
References: <20260123070645.56434-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123070645.56434-1-enelsonmoore@gmail.com>

On Thu, Jan 22, 2026 at 11:06:39PM -0800, Ethan Nelson-Moore wrote:
> The driver hardcodes the number 6 as the number of bytes to write to
> the SR_PAR register, which stores the MAC address. Use ETH_ALEN instead
> to make the code clearer.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
