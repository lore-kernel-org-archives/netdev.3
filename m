Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328020;
	b=jN/MMvHe4FnMQhWh6g3QDUJeeD1woRr1k2RAY5DhfVnw/KMeMKOC7lNDqDGG72YBYE3U
	 JZGHFhfGAuV5Pyz5uAKf1MjWx+QH0+ttC4b736pDhsZdZ7v3Ng2+i8EKb9oSnd+4zKS6/
	 YY99vvUzaB5arfCGML9+JJuWtCDK9oJC8ZDXx3/16VSNfYLs/JppVrYWa87ZP3YVE98z/
	 HavtTz5YxH33SbpABKQmQLIeD0QnJyaAaURpIK9h62TgO1ZSv6X/o2i8959HEozZGgIhB
	 ZuwiEwkeQJt8O4O17NIXhoTCygHhP5hL8RXyJo+i/2BSZNonHw4R3fqngqYb345jWmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328020;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=8YXOzvY7IUW/LSbmp/0DOSFVXfbenFfh8SMEk+g5Wks=;
	b=XVzESaxqXGzved3mCwV6QexCNnPSK7T1fmTERc/lRNheMlGpGXSKzNuCS5Wbmd5mfPUg
	 8fix0fhsrG8qFokPO4HyWoPYuktBXPEvUHfafmWS3qSD3btTcNoRStIbMM+w/hYqODIkF
	 qqGFxWOAqU7XN+yqcKC2fxMR7zjtZ4iVsFLmjZ8xhtCv9ekcIL//HsLK261bRxmax3SH6
	 7T7twcYfBrV4rqdv9ByPvvnGh8hSypLgoxZGC/Zla5E/vBrsHAe8KgQ2sLr9C3KtgJhWJ
	 k/1rjYFE55egXqbgC24jP7dDhxtFONDztq67hHlXa5guoUk6lHgHEU+g2dJHyP8G9zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Rofwc+qq;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0433D606A33E;
	Tue, 10 Nov 2026 16:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0433D606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Rofwc+qq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8YXOzvY7IUW/LSbmp/0DOSFVXfbenFfh8SMEk+g5Wks=; b=Rofwc+qqBE/AC50bcT9LYTHwL1
	Ud68lfqZWQYamWsh6F9pfZ6PPmYRahXnFjhkpty7dQeXiQheILRmU/QT4dgpaUHIWT5E2075+v7wx
	ErNwXutl3S37K1qegpIwn9NmNkT6xYEOkiCmzYev2wwwbHhKD4GUK2fPEgaQ6Ll/EYRI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQogK-00FWnf-1h; Tue, 10 Nov 2026 17:26:48 +0100
Date: Tue, 10 Nov 2026 17:26:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Paul Louvel <paul.louvel@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH net-next 2/2] net: phy: marvell: add RGMII-to-Copper mode
 configuration
Message-ID: <3033fffd-a19d-49c4-b013-d8462d50c34e@lunn.ch>
References: <20261109-marvell-phy-rgmii-v1-0-026979ef4f13@bootlin.com>
 <20261109-marvell-phy-rgmii-v1-2-026979ef4f13@bootlin.com>
 <avHb1O3lfPsEb0YY@solitude>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avHb1O3lfPsEb0YY@solitude>

> This first part belongs either to the first patch (deduplicates the mode setting code)
> or to a separate patch.

Yes, that was my thought as well.

Apart from that, the patches look O.K.

    Andrew

---
pw-bot: cr
