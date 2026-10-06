Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1BA33ADAF
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303373; cv=none; b=h/QRyTYqsuLlc1a668wHxQ8rqPdli0CQN2ehEAFXBd+IWxWN9tHyThtmtOv5zAK6phD0SHVDSKVaBp7vnoPG2Mg0pBRB6NYGnmWtQebm+nme9c/fnS4CwY6+pqcFgUJIgeHBchSj2KC6IGjMmCaqif/ZPmZsU3Y4PIgH+i/93HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303373; c=relaxed/simple;
	bh=xLJ9oFFa1UkSW8u0wpKS29JyrwagUTWxwo0mNsCEq6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFAQJF4U97mtDhw2XL6XwM0VbjVpiFVYbCxP5ZnBU890hJbwUeDBU0kv2gj6siQ9a/JDUxN9D+eCPGiqO67ru6zRkwf7flagJta55NPn6XlAfmQREkeK/2q7wXmZpiYgc7G3LBxdSMTvM6rjibj82U5HQ10O6UXeYVetMCiunoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BEnTXUJ5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BEnTXUJ5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VxVyM9hmncGBIV/gmyYrI39F/7GJ3OoISTel/MywhKg=; b=BEnTXUJ5/i00o6D8qacmU8s1EG
	KjgLoRQk1TTiDMP5ndmtp/x5BUAfYyVZ/wFjIoKQNnRN1w0A9FgBaa6AzQr5M4x49nyBoMENp0W+c
	XJfJ8fJ+br5hrh1YxJatNlSkaiMHNnbcGMNgYm4plC/1/rDeO5BKS+ug1ahHnOp5xCxE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xE7pi-009IKK-8T; Tue, 06 Oct 2026 18:16:02 +0200
Date: Tue, 6 Oct 2026 18:16:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?S=E9bastien?= Royen <sebastien.royen@armadeus.com>
Cc: netdev-bot+sinfo@kernel.org, Woojung Huh <woojung.huh@microchip.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: fix KSZ8765 fiber detection
Message-ID: <027573f7-b768-45df-8368-6dcd4700e999@lunn.ch>
References: <20261006130006.134847-1-sebastien.royen@armadeus.com>
 <179129640372.2231598.1056441247005614175@kernel.org>
 <4585ddfd-122f-465d-80b9-c907a530075e@armadeus.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4585ddfd-122f-465d-80b9-c907a530075e@armadeus.com>

> This issue was discovered when upgrading an embedded device from kernel 5.10 to 6.16.

So is this a regression?

If it is, please take a read of:

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

and consider if this should be backported to stable.

You then need to set the tree as 'net'

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew
