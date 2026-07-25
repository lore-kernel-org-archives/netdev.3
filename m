Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FF738E8D5;
	Sat, 25 Jul 2026 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995247; cv=none; b=a0nkIcgj8rK/d7iU85JogBvhDWYaisuP3K45unpuxKPHENZqVBxYxKH/wtzlzWL++fNQLgmSPRCW2psMNfnGvWtkPAeXAi82z9RHAeCmPXf72ORMkswh5pCxhDD1r9pyZ/wPqyWhtObo/IUFRx6dS5RjsKDMXHUPI9s2jQcA4u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995247; c=relaxed/simple;
	bh=Bs4pu0Gz/KN9LemewQfEUsZK0CXtHulCtehuti/ZxT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzHGZuqADKIyPxRpVjlj6iWcLYJYYyJEmJGdy6vVWS2L5EHk6s2h7OW5tbPh3EhVBnBKfB51FJdf7LGS0EyI6l/BAbjJZ2QQmBhN9lHEUMDFMyMC05EdJ4lE4kXODrTSF3Rbnv9K3i1KrdVa4iPrYD4jzUu6DrjMJFBodCHar54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xrQ7jRnC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xrQ7jRnC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zLScH10ehOQZxYltX1ITVVOGsVKQIZEZp8E2BLzNiRE=; b=xrQ7jRnCi671qZclifDUWLIwDE
	WKI5OM5ge56WTunY1tjF8fO79zvT/ShlndUQUTmP7BcAYV6IEzblxaMJzJBKnDes9+64SFud/BZTR
	r3Dt0Rg1T+00hfmS+somEZbE6ZvwOoCWPnOm8G+f3OoTJHb2jZ+YIhfP4lhvtJIZ6FKE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnenk-00E9z1-MD; Sat, 25 Jul 2026 18:00:36 +0200
Date: Sat, 25 Jul 2026 18:00:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Brandon Mahdavi <Brandon.mahdavi@mahcom.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lists@marzocchi.net" <lists@marzocchi.net>
Subject: Re: [RFC PATCH net-next 0/1] qca8k host FDB handling
Message-ID: <1f509bf7-7c20-4f60-b387-0294895b2b99@lunn.ch>
References: <20260725032159.421627-1-brandon.mahdavi@mahcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725032159.421627-1-brandon.mahdavi@mahcom.com>

On Sat, Jul 25, 2026 at 03:22:13AM +0000, Brandon Mahdavi wrote:
> This is an RFC because the configurations which exercise both parts of
> the change currently rely on QCA8K patches carried downstream by OpenWrt.

If this does nothing in Mainline, i would keep it until submitting the
mutli-conduit patches.

    Andrew

---
pw-bot: cr
