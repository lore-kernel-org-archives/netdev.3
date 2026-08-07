Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5363F6C3E
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786109836; cv=none; b=nKh4j/dqEH4oonOkZW7feCBbvtEZkvajRrPWn72ayT36GAcs3/8QxVbNNNfkUWQTWy0H0chRAPFOEQorZ4ZKY8hbr72xmjtOvMcS2DvB0ADCkuhTUnHlSwnqI4YLNHrmvadn8ZLIRg+l56trDde7ZUj6JYA+N5tG4s4/YmdAWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786109836; c=relaxed/simple;
	bh=1sH8tCAEtaOcsi3an4gHAC1JqrD6rl+g+W6rTnxSDus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgxZ/+7J0Mc5aN9ORdCrCsIEiMf6/S+PZaOoQqmwu3nDyPyEBMLEZ8JB5wpO04lpmjxNXlBEPXa+LfwRMArim2+H6/fH02C3Q9m8ujw/yCtjC1zqFS1BQmyzRh1dgO/2Pkk1h/45dBC7QDMh/8xE2HC1EQKgKxr4dCnkFSEa92k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NIZz7Su4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NIZz7Su4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9RKH03O1CnDJMYAN1NpHgrVmEAoPwMFGkarMgZYinr4=; b=NIZz7Su4wKPSoCYWpq7C3gkPG0
	VzyOZ+99U3UcV2xSu60tGOPVgNQC46Uxy3IdVmqdyYrxUnoB0RQ2vCyJxGrv5fo0Of4nXjsmBmlWv
	q1h7emz1jZ/r2jrlO0sq9R55J8/6IJuSP2ZgeorMGXwyQAsNasDFP6h34uNvShPMRPOo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wsKks-00GZkv-VY; Fri, 07 Aug 2026 15:36:58 +0200
Date: Fri, 7 Aug 2026 15:36:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: xuanqiang.luo@linux.dev
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, luoxuanqiang@kylinos.cn
Subject: Re: [PATCH net v4 1/4] net: phy: add PHY package locking helpers
Message-ID: <3984eccf-168c-43fb-86a3-dcf21d32ddc4@lunn.ch>
References: <20260807070729.12545-1-xuanqiang.luo@linux.dev>
 <20260807070729.12545-2-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807070729.12545-2-xuanqiang.luo@linux.dev>

On Fri, Aug 07, 2026 at 03:07:26PM +0800, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> The PHY package API provides private data shared by all PHYs in a
> package. Drivers are responsible for synchronizing access to this data,
> but the API does not provide a lock for that purpose.
> 
> Add phy_package_lock() and phy_package_unlock() for drivers to serialize
> access to package-private data, including its initialization.
> 
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
