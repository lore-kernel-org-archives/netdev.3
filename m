Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401033F3294;
	Thu, 13 Aug 2026 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647089; cv=none; b=dbt2ZNnFK+xYEpU4satzNGqd2UNdZoFL3GgI+3+eJvcPh90VJ9o0i2QT1DL6C8+z0EUOnOWHnqLXBYPoVYITS6JgBo7529bd+XNv1BUXKeftNX2pGX7OefhqUBcmMLvpYu8oPjImovKFbkDbif0O4pSetCWtTmB3qlL4iUbdNyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647089; c=relaxed/simple;
	bh=UFfFPl3Oi4e50+KwpMJVx+N3vTHjZMY6Id1j81FtCG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLBBtbh4C4IQVaJJNTC7lGlHV9xHBTFWCyzRNCFSonfZeO1WAMbENV6N1sQpDmYUjTpQS8Dw9bar3M+g/JDyf/aCxj60OhEgPS1JBL5TQxQ4p5IsdtNMe7qwUIwFMWoedZLpv4cz3p6J4y6WPZdimKURLnLH4+e61b7gBD+a39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PkTHhduJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PkTHhduJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VwiJHQpH93UDlQ925FTS2gUpIbOxzRFqQUEZ60EDu5U=; b=PkTHhduJshFaMPlLkYIXUyhZpP
	rpx8j8H6NLXRbXgCEkjGoYFuzNAiVF2AlleiZZ1ZCSMkjOZ44JeGr7s1JEYLW18VTgwLCogOtqNnX
	/FJ0zymITKrjVBi5NwAq6/3G8V6GQ4T15LruSVEZghFq8SqYztAnvflqsyU4XCKl5IWI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wuaWG-00HTpB-UU; Thu, 13 Aug 2026 20:51:12 +0200
Date: Thu, 13 Aug 2026 20:51:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v6 1/4] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Message-ID: <190d172c-ee3c-4396-baef-1f0765f72ec8@lunn.ch>
References: <20260812-fix-race-condition-and-crash-v6-0-6cf90f4a271a@onsemi.com>
 <20260812-fix-race-condition-and-crash-v6-1-6cf90f4a271a@onsemi.com>
 <DM5PR02MB3369B6A836C24C3DCE913F5683DB2@DM5PR02MB3369.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR02MB3369B6A836C24C3DCE913F5683DB2@DM5PR02MB3369.namprd02.prod.outlook.com>

On Thu, Aug 13, 2026 at 03:53:49PM +0000, Selvamani Rajagopal wrote:
> Paolo, Andrew (or anyone who knows)

Paolo can probably give you a better answer...

I assume you are submitting to net, and your patch is based on the
most recent net. So the patch applies cleanly there? This in itself
should not be a problem.

> What to do for the following error for my submission to the net repo.  I see the following error in patchwork.
>      "Conflicts with pending/net patches (net-next-2026-08-13--06-00): error: patch failed: drivers/net/ethernet/oa_tc6.c:693 error: drivers/net/ethernet/oa_tc6.c: patch does not apply

I think this is giving a warning that when net is merged to net-next,
which happens most Thursdays, there is going to be a conflict. How bad
is that conflict? If it is trivial, don't worry, it will get
handled. If the conflict resolution is not obvious, maybe you can look
at it now, and provide the answer?

	Andrew
