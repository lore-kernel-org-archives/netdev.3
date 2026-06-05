Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5956B2BEFE5;
	Fri,  5 Jun 2026 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668272; cv=none; b=umcpSm29ftSF1OGNkIYRabk2bUQUpsAbFvdrzupZm9BWDP/gdOu1rcmOZXVqj6BGv3/sdRSZyMj2nKv1P9Z5tW70dBmH3THtOAP2nJ9v6zQYdBNeot5FkxTQNR7Z9BLhFUp7lXFla/ZsjYgM+vx1nhYn/DTLZzXGS6fr0Bvh9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668272; c=relaxed/simple;
	bh=bMuE4x/xwnv1J6lcCVfe0OVweZh+mrF+Yms8gNS54eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxdU7hTFisgJPgjWL+oIZWYzbb10NWkdkEGrKU3oH129HFsbkjjuvC7W7kcrzVRbwsPmnUnnSIXhsgZpAwYypLN0fgrXCJIsnF+FlB9CoTxtPdJiboT5Q0oWjD9fn2eRt3A2vGQzOD3YX754PlcGwBO4KbGG86TEOD96eoWNhYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Bo3VVqmr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Bo3VVqmr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=lRTi43Pb6AImbXcZqNNb2NBaT6asbEas00SHcRQI/Jk=; b=Bo
	3VVqmr3FpceEM4tORBT6wO8rikO8j3wHa7c9gADrtbV4FxlrL8L9PoUEeXkLTITLrmt0oq1ccrvIy
	4nlmmPG4GBj2P7yyoithnBxwtq1yUQ29ZSHb84f931utJUCAO2FNrcCfsgcwcRK9fKZ3B+gpmwsrN
	jBAoJUfr/G+S6qQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVV9h-006Ezu-9y; Fri, 05 Jun 2026 16:04:13 +0200
Date: Fri, 5 Jun 2026 16:04:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Nazle Asmade, Muhammad Nazim Amirul" <muhammad.nazim.amirul.nazle.asmade@altera.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: xgmac: report L3/L4 filter match count in
 ethtool stats
Message-ID: <334ba778-e004-4e63-891a-c8cc8ea352b2@lunn.ch>
References: <20260604083037.24407-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <5e912b43-7c06-4d04-9ba0-8f929150429c@lunn.ch>
 <ed1ead6c-0505-4e56-97e3-b8e32e3e8e2b@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed1ead6c-0505-4e56-97e3-b8e32e3e8e2b@altera.com>

> To reply on Andrew question - As per what I'm seeing, the XGMAC2 RDES2 
> only defines L3FM (bit 27) and L4FM (bit 28) — there is no FILT_NB_MATCH 
> equivalent in the XGMAC2 descriptor layout, unlike dwmac4 which exposes 
> it via RDES2 bits [27:26]. This patch covers all filter match bits 
> available in XGMAC2 RDES2.

Thanks for the information.

       Andrew
