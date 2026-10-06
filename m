Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ADC39A7EF;
	Tue,  6 Oct 2026 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791289460; cv=none; b=G+shtdO4dP5nMJx5YjskxuDxnalQU1FspJ5Hh7V8hm5MYvVZNyxZCWWFnfRPTmEWEuFkWR/CAVmbImWeta44Ou8fZvYeDjsw8GBhoRs3PglZLzGuzGooJueP1CsHcXHrvxe06KnghOLsCNI9OykQH+lvBFQn7pbjw+EpZAODs/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791289460; c=relaxed/simple;
	bh=7S6bsfzOwKenBeK18OPgTrNNVNtxK7kYAfeiNHPqzCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfbyGTod3Gh+DZaVolGAvz3FN6tjV/nJhe6UWBc2+2Jh0RETq9oMMvyJy6Vb7FivXsm+Zr54AD7AsTfSNMWyzR6Nl+f1tynyxMwJWwF7/yJKrX8fdq2jM9iRH48ndaKwruF+uRgR6F1YPHe5qXRUJzAOo7ln8qltLTxRFaBIJ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZFzSoz8J; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZFzSoz8J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KLleRmOpqOayU9qrImpyZNShZPBIsLRye0/rS7Bp56I=; b=ZFzSoz8JpZab3mu+2cDYde8S0h
	lstJGclgS6yamx4FoSsiiYiZUK9wTRnXrxpqH9TUWti8MXJN55SEJUcxqsqbw/GjcOAQEr6eI2NeT
	wAkqwDPj1r0c9x7nnvBIQz2Y0rBLB5XG5geJSI5kpheGGyw3ypTdM9pOWGNDMHpp3P4I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xE4DD-009G6Z-43; Tue, 06 Oct 2026 14:24:03 +0200
Date: Tue, 6 Oct 2026 14:24:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani.Rajagopal@onsemi.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Piergiorgio Beruto <pier.beruto@onsemi.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Jerry Ray <jerry.ray@microchip.com>
Subject: Re: [PATCH net-next v8 04/11] net: ethernet: oa_tc6: Move constant
 definitions to header file
Message-ID: <6c5d7e37-79ba-4513-b74d-2372406214ca@lunn.ch>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
 <20260928-s2500-mac-phy-support-v8-4-7e011aacc309@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-s2500-mac-phy-support-v8-4-7e011aacc309@onsemi.com>

On Mon, Sep 28, 2026 at 03:25:11PM -0700, Selvamani Rajagopal via B4 Relay wrote:
> From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> 
> To help other source files within the module share the
> constant definitions, some of the definitions from oa_tc6.c
> are moved to a header file. This header file is still
> private to OA TC6 framework.
> 
> oa_tc6 structure is also moved to this header file as it is
> needed for other source files that are part of OA TC6
> framework.
> 
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
