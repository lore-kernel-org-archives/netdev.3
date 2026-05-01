Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C155214A9B;
	Fri,  1 May 2026 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777665410; cv=none; b=JWLr2wuDDDmqn803v0C2zl70BTYU0xEaIDAn6wXjGoJqvEJWJoI5qrUH2hp+zENIjF7kD5uZzb8WFzf4giXSUdqpdJ+szc78BbgP+wFeq5I5YykEiMfDPvXmd17s6HKRlLcaAmfgdtkIZFHbdFNj2VUupdPr37UpkPQEnqCCBak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777665410; c=relaxed/simple;
	bh=gRk6c5PSCZJxG/OjKX+Bd+ZXttg/7lbRD4qbB0NH4CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbGSNowhJ2cOMghSuqx8sJLzo7c/0XhSul4T+oJR1eOjCewCgnWNyogjOrPU4aJFTD5eFUFmUs8ywWv6y16Q+HBZj7siFIU56wAYVxotNb7ga1U1N5PdUyJZzrgKvUbHx/LvPMW+NuUOWh96uSmX35dfCg+spTtywo83o6slmgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C+fc/IFk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C+fc/IFk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ta3dqrIiRZf2tX8t2ntecDU3XhU1R7miSnMpaOkMqIo=; b=C+fc/IFk/HyN3728/Pn5T8qMbh
	cvVQ3yQvWvIDUv9VP6OPiNmAciHNwitiHHM210A1PBBxhUlMPS+0CH9i0i9kbZF3sBHImgbdUsUbD
	I4SxdO41BBMD5jw+X45NnZwn+wT0lzmtp9hJr3Hc+sLkJ6b5EVS4cQvIvZ+LSq9Sxk+Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wItyX-000sCr-96; Fri, 01 May 2026 21:56:37 +0200
Date: Fri, 1 May 2026 21:56:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/5] net: ethernet: oa_tc6: hardware timestamp
 support added
Message-ID: <608a8be4-18f5-44c3-990d-be83a8f1652c@lunn.ch>
References: <CY8PR02MB924976A9160ED3FB0883911583322@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB924976A9160ED3FB0883911583322@CY8PR02MB9249.namprd02.prod.outlook.com>

On Fri, May 01, 2026 at 07:15:35PM +0000, Selvamani Rajagopal wrote:
> mii_bus structure can be allocated/populated from vendor's code
> to accommodate vendor side customization.
> 
> Timestamp support implemented following OPEN Alliance 10BASE-T1x
> MACPHY Serial Interface specification.

When i see two items in a commit message it is a good indication the
patch needs splitting up.

We want lots of small patches, which are obviously correct, with good
commit messages.

    Andrew

---
pw-bot: cr
