Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953F03EC822;
	Tue,  6 Oct 2026 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288932; cv=none; b=rWjYGL5ybISI4hPyDUQfw9ltQLuviNnBuc/sjar5w2YBGSBVCbZ4rCYU9tOSp5+NMF2tQu7c6tmt4ApVOxzYcn0UZYB2BZXyhbPk7uMMTPoUo7Zx6Idp1ywrr+0REdJwbi47HyzH7gTXfLpX31W1mcJRK3XqY0iaxYRaGp3W7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288932; c=relaxed/simple;
	bh=tUrPiKIZT4ww8XMCI2nldMULUNKr6RzPAE7VvvgmAaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uojKmJkTby1FKiz/wGwWs3wYT96o2SD29pFrHrl/h0/8oyANuc8ZxLzehnEfktt40OlSshrkPIpQcpe0pc6VDKRN52UZqjqp5jlzBCoW1C738J1+W5rDHT7C6zXrXOX/WnyWP5amrzSRcMH9DBYAe0kj9uo3vz8OGdcaC2+FJq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yFGp/wWc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yFGp/wWc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y73ZLuSi6gPAw08ejBkUpSp7OMn+d2QtodJ4+iFscNw=; b=yFGp/wWca4s/qr82aCVBZhRDox
	tl6Rw2aIrWGUbq4fSeDXUCRgzGuEEEGiP8z1zyALkanhbPmWCHs1mM8WqUDFCgn7x0BuXIvZCqSK/
	FYAOOOl1q4VP+EiEGieN67al98PAoLcgt3I32c0pjuEhUijHqpT/7+IrPJr0GaTlz/uw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xE44Z-009Fxt-Tj; Tue, 06 Oct 2026 14:15:07 +0200
Date: Tue, 6 Oct 2026 14:15:07 +0200
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
Subject: Re: [PATCH net-next v8 02/11] Documentation: networking: Add
 timestamp related APIs to OA TC6 framework
Message-ID: <2a33ddbf-803c-4a4b-ad03-2b8ad35dbb79@lunn.ch>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
 <20260928-s2500-mac-phy-support-v8-2-7e011aacc309@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-s2500-mac-phy-support-v8-2-7e011aacc309@onsemi.com>

On Mon, Sep 28, 2026 at 03:25:09PM -0700, Selvamani Rajagopal via B4 Relay wrote:
> From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> 
> Added new APIs to support hardware timestamp feature as defined in
> OPEN Alliance 10BASE-T1x MAC-PHY serial interface specification.
> 
> Added the newer read/write APIs that takes MMS as one of its parameters
> as these were not documented so far.
> 
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
