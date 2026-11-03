Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738967;
	b=NIN5+KwlzVLo3epSVGob+XXYKohvyBIeV/pwNH3mqwbw4bjWGisYE6EoMqCoP2ZtLqL5
	 10PWQxAUPApaSSKMF+zQARuTGtJKCg4879oWCLi3Bihq4eEK6HYgjVrNd42A9uaC6FOm2
	 YqTbxSl1Sx2Qu78KmLg+t/7F26Su7ggIhxq+5/60OOFP6aUSNCWVMkH1YbO8sUB6Zc/C8
	 1hDZCDWqZXxseZID3vxCSv05ARBt8iSlsRQMQynZ5ou8UKEogvV0/x338q6xB+z37keiz
	 9l0QxX4rtZK+YIMfoIaCmIn1fkU9ZGelLSDuXPLbuLQv+nVxkLY9Iqom7vLNUfi0ILw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738967;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=FGhJGJT7/ajXBG/Ryc6jGnf7WdwsklM7FcdhFTQMZHo=;
	b=FeJ9aXyim6XCxKg+R2wuucWpiHCTIDVCx+X2uWxDbabidI9vQSUJJwzkv4IEyxVmvgEG
	 ONKcP0K0WnjlCMafWiPYuPbEo4imYBvqkKUPbkHigE9G7kcssy0nm5+S0wmEmrYO0P7UZ
	 WluLC0HwOd/TmqKa9qSbYZHUCNQmfJI78hr+DvTba3+ImCpOJAtsoLEY6M8eUtG3atoA7
	 4X4koiOgL9LVSvXazrfaV4p637wCOIazdqgdN38xQ+K8wvKXaJIKp8GajYacNZvi9b29z
	 O9+dY19ItU0wtxAAutozxweOVL1MOSZ/bo6pe5tN5iWMGlgt5FDjDT/zTOciOqyC3Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=gFZr+y5N;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2F5606A324;
	Tue,  3 Nov 2026 20:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C2F5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=gFZr+y5N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FGhJGJT7/ajXBG/Ryc6jGnf7WdwsklM7FcdhFTQMZHo=; b=gFZr+y5NvotJO80HhnQaOhsgTN
	YFOM0LShQYwZ2DbGuI2G5b90By4jiBXrTPrPIpZ6vEQDqbbCad4V807MCpRYqXpajD6DuA2AdJiBp
	iTA8FAZDX76W0LBFSJNO25mq2MdLiCdO2bYqbvHfZS1cFGZpS4SYNCut2te9orGXAUtQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOLRP-00EAjb-DH; Tue, 03 Nov 2026 21:49:11 +0100
Date: Tue, 3 Nov 2026 21:49:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ciprian Regus <ciprian.regus@analog.com>
Subject: Re: [PATCH net-next 0/5] net: ethernet: adi: adin1110: Add OPEN
 Alliance TC6 support
Message-ID: <49b292c4-c0e9-4b19-aa4d-d15dd20d25b6@lunn.ch>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
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
In-Reply-To: <20261103160918.409701-1-iustin.stolniceanu@analog.com>

On Tue, Nov 03, 2026 at 06:09:13PM +0200, Iustin Stolniceanu wrote:
> The ADIN1110 supports two SPI host interface protocols: the generic SPI
> protocol, which the adin1110 driver implements today, and the OPEN
> Alliance TC6 protocol. The protocol is selected by the SPI_CFG1 pin,
> which the device latches when it comes out of reset.

Is it possible to read the status of this pin from a register?

   Andrew
