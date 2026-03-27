Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A1E391826
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774614539; cv=none; b=J22xZ2E8sK7rCcygqpISTLBLjbeV+a9q4DwsoFztNeN5DvoMA/BAehNmx6Nob8DLK6EaFEOzLio0JG2SFr4lw59CUZZYZP/20F7YNlg3DyecJb+ohYRsLJ1m/q/qwDhI8uj57T4h5z1qGTkUWiUS+ZMptmHXPztCoiDP5ANncLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774614539; c=relaxed/simple;
	bh=3j0HyvQljmQ/t1JC2oGpNr03/yiAJOffD/xcXeljd+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Shj2GBb+W/UBp9rgJxJzXhj37RNVe+1O9sPouD2BFTlZx3oTBAnIEbFsROCz3Wjw/4R2XbxHrgtcCYcUmFNzZ38VSzYbt9gX9WzF9H2hLBBKc72ujZz+hkD0n1dyk0p8tRGDmJnWfl8LxTF4KgE8sGW69XnqvKJQLrq/GkvD/Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PDKtxyOI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PDKtxyOI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rMqhh+p1MSRt692TuvrcDmyWwsgHJy7OUH9oJQP2h+M=; b=PDKtxyOIYHIaBcKCNJr4unw8ae
	zL5WHKGpUnimNP29O6ge4TaBo5kzjqLqJ6cdyMRi8t6XisrTmL63nOYYoS6Ig4NitHl8no1AznF0S
	UG6rNr4lp0J44rnGzKVP2yGSh8lFUBBKFnrgk9TVkOnilpQxYC1mluhP5Xt7d6AsLI/8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w66J1-00Deh5-Tp; Fri, 27 Mar 2026 13:28:51 +0100
Date: Fri, 27 Mar 2026 13:28:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linusw@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: qca8k: Use the right GPIO header
Message-ID: <45f47abf-00f8-4a78-a29d-36b36f65c64d@lunn.ch>
References: <20260327-net-dsa-qca8k-v1-1-94e613a5c369@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327-net-dsa-qca8k-v1-1-94e613a5c369@kernel.org>

On Fri, Mar 27, 2026 at 01:23:45PM +0100, Linus Walleij wrote:
> The driver header for qca8k includes the legacy GPIO header
> <linux/gpio.h> but does not use any symbols from it and actually
> wants <linux/gpio/consumer.h> so fix this up.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
