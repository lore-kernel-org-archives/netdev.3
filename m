Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0940A3A6B68
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427126; cv=none; b=SfjyF7p6oRKb554uPk836Muw1WDSIEgR4LybJS9Fup07B0nhUCGW9x6TG2mk4dE2fheHnZ25cbZKJEuIZztjfT5hwRUvDFkFhi/DX1d/B8HOBP7nnRDUZ4JyDIbsOpf+QLrSC7IREBTDRZmtVNX50FxPVHXZ8bIliGvTABeAm3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427126; c=relaxed/simple;
	bh=VMIbWQHO//PCMXVik6SVxnjpMy6P3GuyDaG/xbNdhbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8PBiBnAhJEWuGk9o1iG8fi6yKKE64QN1m6xgvm2xg/IW27Jesv/rSZDtlFHJulM73Tn/QnXt8MsS2lRcfYF58W8JcZf49yYq2+Ato2Ha4P551l93H4bOKrZy+fhBP3KDFZfE1rfJm05Q1yJ4MUpLr+3lLG3SvsG175Mnrwhlso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=em9Bg9tG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="em9Bg9tG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=44LI19TPP56+LR3xZGoXEf8OR6VJgitytoTo+CoHJ2U=; b=em9Bg9tGB5fyqUdqGxNevcUpai
	cAKV1po5I6iqwJxhAgEwYVDJTRa7qsLYBCYgszNxCOXKFE4u6gDZ3KqLjZ70mJj8PBeekP0/sxTTf
	ctyq++OZEs63IpnxDy01g9rV84lcyvPGq3oMlK58z3e1GIyWrx/GxYGI0x4ihcXwfHv4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6Fjf-0059P1-Is; Tue, 15 Sep 2026 01:05:15 +0200
Date: Tue, 15 Sep 2026 01:05:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	netdev <netdev@vger.kernel.org>
Subject: Re: Stmmac in the netdev CI ?
Message-ID: <6f5de297-e774-448c-b0de-6a65162f3923@lunn.ch>
References: <4ec29d6e-2afe-4710-b3a4-7d7e035de063@bootlin.com>
 <d90fa457-67d9-4c09-acfa-9ce0e09e87c2@lunn.ch>
 <652d0b7b-bc1b-44de-a2de-56e4319fcafb@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <652d0b7b-bc1b-44de-a2de-56e4319fcafb@bootlin.com>

> >> - The current kselftest don't mean much for stmmac, I don't have any board that has
> >>   RSS, queueing stuff also doesn't really apply, the meaningful ksft are mostly
> >>   csum and timestamping.
> > 
> > Does kselftest at least do the correct thing and declare a skip? I
> > guess most NICs don't actually have RSS and queue stuff.
> 
> It's a mix of both, some gracefully skip, some fail.

It would be nice to report those that fail. Maybe the author of the
test will then fix it.

     Andrew
