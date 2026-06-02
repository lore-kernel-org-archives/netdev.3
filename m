Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AD2305E28;
	Tue,  2 Jun 2026 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780404391; cv=none; b=sMLjVBiCCfJJ30pHLYYa7x6GNqptiWipI2TvRi7FXS2kx5pG5NTyrY3NyZdBQo/eunIVYhU0hMi2cmtbi1lf1FpRrP3czVKzM/Iur58pja1bABnuE72htStPuGl5zHckWaY8AJSmAdhbzHCf63iVIkOJch2sI2lcN7aSkwwf/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780404391; c=relaxed/simple;
	bh=YZPOmdO/aMZIbz179qmFYbqzfLLT8Uj2LUHzLm7foeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZBIZTDMUAab/X5hESZ9UYxdFYzOI9c+UWpGrIQV/S/NE7igNch17tiJYeniN9sNq7AHgTG6PiYOzdmTpwUb42gqMGvCwSi8HvRdWf4ILHB/AjV64Ipu5HVDrqaVgiH6J9tqvRP+tf6wbkIDVyD9AJB95nv9qDuTZ5NvbSIc5yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QdBfcOBi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QdBfcOBi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+ybPQ++oUNcvi5fNihznikvCl2CDujyBnu9XjvptCzY=; b=QdBfcOBiSdJAnhbwGar/sXfXP2
	4vk6nxkrfdtcWiiXhUox3OnqdIIiCPh3Ffh1hEeF2Axa8QSvkwWQRws4qDSebXRJ/AysOgB2CrsgJ
	awQ4oQE/tO5MD/N/PMihS+f7gH4MmL9Bq2rNsVkcqH0LWg3hHEofBpRYXZt0++Vtl12M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUOVi-005giA-9C; Tue, 02 Jun 2026 14:46:22 +0200
Date: Tue, 2 Jun 2026 14:46:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Stefano Brivio <sbrivio@redhat.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	netdev@vger.kernel.org, yuhuang@redhat.com, justin.iurman@gmail.com,
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, idosch@nvidia.com,
	dsahern@kernel.org, Chris Adams <linux@cmadams.net>,
	Beniamino Galvani <bgalvani@redhat.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>, ihuguet@redhat.com,
	regressions@lists.linux.dev
Subject: Re: IPv6 address insertion order (was Re: [PATCH net v2] Revert
 "ipv6: preserve insertion order for same-scope addresses")
Message-ID: <da080bf1-fa2b-402a-a249-ee5ac004fb05@lunn.ch>
References: <20260529112357.5079-1-fmancera@suse.de>
 <20260529134045.56330243@elisabeth>
 <ah57wxGjL7JBORR1@zatzit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah57wxGjL7JBORR1@zatzit>

On Tue, Jun 02, 2026 at 04:44:19PM +1000, David Gibson wrote:
> I get the impression there's a rough consensus that the best we can do
> now is revert this change (already done), and make a new patch which
> changes the insertion order to the "correct" one conditional on a new
> flag.
> 
> Stefano has enough other fires to fight, so I'm taking a look at
> implementing that.  Some initial thoughts, that I'm soliciting
> feedback on:

I've only been partially reading along...

Are we talking about RTM_NEWADDR?

I've never worked on the code dealing with addresses. But in general,
if you want to add new functionality to a netlink message, you add a
new attribute to the message.

https://elixir.bootlin.com/linux/v7.0.10/source/include/uapi/linux/if_addr.h#L26

	Andrew
