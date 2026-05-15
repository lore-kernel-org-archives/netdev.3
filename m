Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29413D0C1D;
	Fri, 15 May 2026 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863262; cv=none; b=GYbigyFytsHDecWivm/ichwf9ayj/lH9bc9xjcijRsU4giJ3J8qQVp8MhO/bao0RdiZx0Zox25cni7acBwQ1LgAEZKsnu0h+d53Y6RN1G8EXlcH68dbueeuy503l1YjFNbSUHEB0dHLhvV02+zcc14yVQpdyYEW3UYY7tGmfyjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863262; c=relaxed/simple;
	bh=1xY+MwKUx8ynj5LAJ08uaazXsaRTDq+ItIwRAmB1VO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg8Q/QuFNj1Vz0q9WjY1Q4kuvD39eE4veYyoPQb9AQjcys3ulsay36Xwh0fRU7CpkaGrcxN+XJCwMXS79BW9UujVdXWT38FmPb7mdL3PgqILuIBbq/rJtvHq3HH8ZAp2fJ2IEFO0EchRsJZRO9GKfAJG13PR3gwHspcYpzld34Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jpTPbqSA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jpTPbqSA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4JyYHEKlxCnPVRYAT3Gu8uaoQVNX4sD2nZVMko9IIe0=; b=jpTPbqSAcd9YT/H+VsWMbsa5gR
	55Lx7w8qs/tnbUlx7G0tnbM/Wz8ZrXuZAVgRV2Btc68IP8dpT7QY7/NDalck789QCC0q/aomWL4he
	aZwQ6l85LjWa1hFgrUGSbsLsyxG7I0+nR8l1yNg5i2ojhS+gILl59oK+JokRlol05bLI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNvaf-0035cW-Ng; Fri, 15 May 2026 18:40:45 +0200
Date: Fri, 15 May 2026 18:40:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Message-ID: <3bfd9650-bf67-4abb-8820-2cab95ef6402@lunn.ch>
References: <CY8PR02MB924916514D414B698DEB9A1883042@CY8PR02MB9249.namprd02.prod.outlook.com>
 <ab821805-49dd-4b55-a77d-0f25e0247bff@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab821805-49dd-4b55-a77d-0f25e0247bff@kernel.org>

> Also, did you consider the board layout?

Hum. How would a board design convert a level interrupt into an edge
interrupt?

Use the level signal to gate a clock signal? So while the interrupt is
low, you get a stream of edges? Does that really exist?

     Andrew
