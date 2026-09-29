Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2160519934;
	Tue, 29 Sep 2026 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682893; cv=none; b=OoqMDnfS+7sljRRhlqvithOuPkVMLhPluEXeuN84/A4MoWCRgk9giTX9///v9WGF9j8S1KKdbnrRzwCRDGAXfuo8jtbW6jACKL+oDi9Py3aclUzhbhBGbo3Su2YCPBl2mevWsAh4ubzwAj2WSbUf/fHweS9Zk7Aw/86Rb5ksWvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682893; c=relaxed/simple;
	bh=DtqkbPUa81FQQrzsYaoaL1FIE2UdQgTyoycbJmy1bmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDrB0/T7idW7NLpPX/NFrOwkwJqrCEKS6qfxDY5y842H7bxdkaCkWkyV4z5v292wkqgjpqQ3jo8Knzm3PzRxp9B41DCNnsqTzeop6vm9iJD6zs3WEqiAgpxL+7pj1kRfJqafaQk3HJeyGtbKjtoPytGfBWUZLTR7XMo5gjvxAuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B8GD4qiK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B8GD4qiK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E5+DOXgoT9iAoCF5tpbNaYvfjMDSAHAT56qKN1IGRIM=; b=B8GD4qiKYcgBmoI6UBQO0tLNeF
	exB4SQZ3F2yX8xK0wBIa1eLDjwMAWlebcegGhh/Wy2G+HJA4wvERgY9arbv7oXE5ub+4IbUQZcthl
	gcM61MiyEKZWGIKNXy+qnm/riQL9Jirq6zJh0plkTGyvFbuX+LbGiPzLfONKcKYWAOCk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBWPk-007wQt-7x; Tue, 29 Sep 2026 13:54:28 +0200
Date: Tue, 29 Sep 2026 13:54:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Jerry Ray <jerry.ray@microchip.com>
Subject: Re: [PATCH net-next v8 07/11] net: phy: ncn26000: Support for
 onsemi's S2500 internal phy
Message-ID: <e8959c33-1b50-46e1-b9b1-029f5fec81f5@lunn.ch>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
 <20260928-s2500-mac-phy-support-v8-7-7e011aacc309@onsemi.com>
 <CH0PR02MB78673D8A3CF809B016983DAC838D2@CH0PR02MB7867.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR02MB78673D8A3CF809B016983DAC838D2@CH0PR02MB7867.namprd02.prod.outlook.com>

On Mon, Sep 28, 2026 at 10:50:00PM +0000, Selvamani Rajagopal wrote:
> Andrew,
> 
> Thinking that I don't need to remove "Reviewed by" tag for minor changes, I kept it.
> .read_mmd, and write_mmd callback was changed to use newer callsbacks
> recently introduced in the in the kernel.
> 
> Let me know if you want me to remove "Reviewed by: tag for this change.

Minor changes like this are fine.

      Andrew
