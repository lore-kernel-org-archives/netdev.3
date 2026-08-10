Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF62E1DDA18;
	Mon, 10 Aug 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369113; cv=none; b=p4ncpZFVvh24K/PktsVeM/cb63J6Q1Z14eiDKy8lKK8p/JlPgUSGBVctBZdX5gK2c1y2dmdJnEK6SB/Brxv19G+Iq1X+D83+WJ7UvtNolDkvW4JQluv1sH04BVPppWCMWMSuLXgggWXopEYAZ26BoZ+Ziy+6wFXavt2KeIDBFo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369113; c=relaxed/simple;
	bh=i+7e8Ev3I+ovEDebu9NnIto0sTILCsJav4idWelgvyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQIb+bBmOmP0cJ7Khz3dQvkNVMyX0USsk8i+L+ZvRkZLZhwTSBJaAyh72lfibA4oY7GOXsUVnuGT16N7edrSzQdA/XyVqD0bHaanqxEVI/AEfiahu/AESUdsx/LVT0wMzScx6l2TsI/47xAwIGsGldUHYmKIRrb30bKNY7lX2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MBrqSR4p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MBrqSR4p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=QmHLiPQRoBcAgrF988RFRQ+za1VRAQaWnI/nJR0oAiE=; b=MB
	rqSR4pc68h1aofUZZbgAPFB9J2nZd51ASgWwBva5lYRnIKRoxt9Xnh1+fwxES5j5T4Jo2YRVfWXyC
	TVnQjEnlU/HVJ7DYJCj4M6wDbBLLUmRYD6jQhgpNtXPIpmJz5ISUpXWypqvHl1hsQlZ+oVlKADh2C
	068fbOzWZZCk+0c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtQCu-00Gvvy-7a; Mon, 10 Aug 2026 15:38:24 +0200
Date: Mon, 10 Aug 2026 15:38:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: qca8k: Disable mgmt Ethernet for qca8327
Message-ID: <cc6d8243-e82b-4f1b-acf4-13ba6a74baaf@lunn.ch>
References: <20260810061612.23745-1-kernel@kempniu.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810061612.23745-1-kernel@kempniu.pl>

On Mon, Aug 10, 2026 at 08:15:53AM +0200, Michał Kępień wrote:
> While the qca8327 switch appears to support in-band mgmt Ethernet,
> prolonged use of that protocol (e.g. for polling link state) makes the
> device unstable: within minutes, ports randomly go down and no traffic
> is forwarded anymore.  The same issues do not occur when MDIO is used
> exclusively, so ensure mgmt Ethernet is not used on the qca8327.

Do you have time to narrow down the cause?

I _think_ in band management is used for a few different
things. e.g. statistics, as you said, PHY polling etc. Rather than
turning everything off, could you try just doing PHY polling via MDIO,
but statistics via ethernet, and do an ethtool -S every so often to
see if you can trigger the problem.

Could you also check if the management packets are getting lost? Look
at the results from wait_for_completion_timeout(), is it timing out?
If so, is the retry mechanism working? When i added the Marvell
equivalent for in-band signalling i got the retry mechanism wrong, but
never noticed because i was not loosing packets.

Thanks
	Andrew
