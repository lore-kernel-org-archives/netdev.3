Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32FB37F8CC;
	Wed, 21 Jan 2026 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002113; cv=none; b=GnCeNOg4McM42tnnJtbz6PSwoamF1Wu7sOw3QEUgkQANCDmztgeHEwWjd62FE9flhj2Iojh6PctBRnWh3uoNvBqHfAg0/hht0xkPLe7wMRVrvdHDwrpnQMYWdICvvqcoPeulZnijmwaInPtsaZ23bFfaVSjB8ApaXsFme5QjKmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002113; c=relaxed/simple;
	bh=KMY6p5RxPooO1A3xc9kw1wozZc1FITiT/Sbv7idXSuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+D1qkSHGtvuK32JRuRFmuUyswUxj46NDda1BVHlSbL8nxYa4yhT87BGCkl9bpMUq/zAqyW1x36KNLTn4BKJCPPq181lJzwfgDHbiC1PFRAI6svS5/R6FO3gqnRiQ/MnDvtaBK9BzEKL9ZMWcVV22pr997p2K3m9Zgk+wIOwykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Gem2gW6Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Gem2gW6Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=91ng+dWvriUJkQa0Nnkh6sYZkPI9OFnP/uS4yARCOzw=; b=Gem2gW6Q8iWnDdGVp1laNC8PgM
	e3VPV+91ETydvzk7WILIPThilQb0EBZgkn5JEIBC4wf/56Vmv+OY5miHi8x3fK8p8uZ+kHXfWr9QC
	nBOvxbHXlLaGH078O4kSnx7MwGmAzAo+BMdFupFe6QuFv6c3p1fUfTB0wuYbs0RDnj5s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viYFs-003p1J-J7; Wed, 21 Jan 2026 14:28:16 +0100
Date: Wed, 21 Jan 2026 14:28:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: ethernet: litex: use
 devm_register_netdev() to register netdev
Message-ID: <8e057e88-a77f-47fc-925c-39c650db9d24@lunn.ch>
References: <20260119040446.741970-1-inochiama@gmail.com>
 <20260119040446.741970-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119040446.741970-2-inochiama@gmail.com>

On Mon, Jan 19, 2026 at 12:04:44PM +0800, Inochi Amaoto wrote:
> Use devm_register_netdev to avoid unnecessary remove() callback in
> platform_driver structure.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
