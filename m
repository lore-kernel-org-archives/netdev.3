Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5073A6EEA;
	Fri,  6 Mar 2026 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805698; cv=none; b=Kv0V17fFSjxImFxhi00BFlJc2bS2BDAyhWOAfak1U8Cr/7D/73YqAR5obcd8NlPHDnY2Fu3b7eH/22dYPPaHkOf49bV6EqgbvHTg80MaC+klwtpD4+gettsbwqKGzAIayivqF4I3eaUaK0MHkESYcSfKtIMCda0Nskvgstmd4nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805698; c=relaxed/simple;
	bh=63zKECe4DXmb408odUP+uE9C37xIRUftI6U2nqTWygg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDsoiYpnQ2LG1tbBNQcXG6GYXe+rnOZ7j+hd+Glx4MKZLsZdp+Wbd6B6gnpCGqZKveu54CBLrTVH0faBxZxCwdPcNe7B2l0+iGMoQ6l7GbFao++x6IKQqI6ld9KMxwU4cWm1RWVER+8TYmYLntlKRimtVaJujQsqD4lLPk+G/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QUMireeO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QUMireeO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MirfIR7Fld7DvyfLq9p3EnVSzA7tLEd1Eqq9yuQL0IE=; b=QUMireeO4aEf+KSITfWawFA2LF
	tNODAY3TgouFyFnjIaz/qRnEmmVmogpGG2NJ6UqEqrsu0060jU5jWIdfnkdCdR3GSRf8aVDmY7Ysa
	G8UxqUuGORMrtXu7Om66TDY6wGkMfm89B87fMBKkiTUGEs6g0vw7DTdGj07qIPhff2eA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vyVjh-00AU97-OX; Fri, 06 Mar 2026 15:01:01 +0100
Date: Fri, 6 Mar 2026 15:01:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"taoren@meta.com" <taoren@meta.com>
Subject: Re: [PATCH net-next v6 5/5] ARM: dts: aspeed: ast2600-evb: Configure
 RGMII delay for MAC
Message-ID: <344e1aed-f2a5-4249-90c1-2b848ee39d7c@lunn.ch>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
 <20260302-rgmii_delay_2600-v6-5-68319a4c4110@aspeedtech.com>
 <d38f54b2-4a99-4a54-8403-e4f4a9704386@lunn.ch>
 <SEYPR06MB5134AE0B0042E05E8E58A5239D7DA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <70ed84fd-ac9d-4157-ad20-36deec0c5f82@lunn.ch>
 <SEYPR06MB51341775B041AF86CC8769F69D7AA@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB51341775B041AF86CC8769F69D7AA@SEYPR06MB5134.apcprd06.prod.outlook.com>

> Could you please help confirm how we should proceed with this project?

That is up to you.

If you do lots of small patches with good comments, you probably can
do it in Linux. But you need to convince reviewers you are not
breaking backwards compatibility.

I think the bootloader change is simpler. But i've not worked on
bootloaders for a long time.

> 3. Send a patch to correct the phy-mode settings in aspeed-ast2600-evb.dts so that they 
> match the bootloader after the fix.
> 
> mac0: "rgmii-rxid" -> "rgmii-id"
> mac1: "rgmii-rxid" -> "rgmii-id"
> mac2: "rgmii" -> "rgmii-id"
> mac3: "rgmii" -> "rgmii-id"

You will do this anyway. However, just so that backwards comparability
gets tested all the time, i would suggest you only change mac0 and
mac3. Leave mac1 and mac2 with old settings, and add comments that old
values are being used for testing, and they should not be cut/paste
into new .dts files. And add a comment that mac0 and mac3 require the
new bootloader, if you decide to solve it that way.

	Andrew
