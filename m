Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E028B30E0E9;
	Sun, 31 May 2026 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780240687; cv=none; b=qx/SOLVNpHHyE4en48K1wWyu/KOsAtjDqGxaQlSgID6Ah9IP+ck+KS9MQWGd7HorlehDxZIN0RLSoOB9LK5a+DZis3u5J9CA3aDJCoc51kAfI1qN69K6jAtxboyoVAMClDxC7YSIAi8ZGojGOEMAMxzbT4zWbGJ/Xy+tjCayq+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780240687; c=relaxed/simple;
	bh=CEY6hqCLm0xcdy74ufH4/UIcM2w3R4zLeWyBZEjlFRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9eTfzkTWrEJGi6USVJT/VlUoqPLAK+QbSRIjaKIkFd52ftMscckRNadyLYld+kOmKIT/EC9exD9eIB2myoXgoy38HkaYo01TmCpp7kDhBeS6jiNCwrSQV2YXnm1TGZUfLx2oJiPo+eFkE/jQDdEqigUc6CyBK5wk32Y2poSGb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YvSHMsUJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YvSHMsUJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Nb2HTIAJzF+0r5/UEU/MiDGrMxmFW1wAllLzjjL1dwo=; b=YvSHMsUJbcw9fgLCdmCbPwlAcb
	QUwEC1Ol402L3avTekNywUEx9Sj5II5k7S+ONLATVUwMRjZvNpolM7XLDzSAFtwg17FBvo1xICjbN
	XE73ty+dJB3OoyCxLOQIxfW38reQq9GDMh4gLgFsXGMy3NaRS0UAGoGPdS1nPoO2oJWg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wThvK-005N3g-NR; Sun, 31 May 2026 17:17:58 +0200
Date: Sun, 31 May 2026 17:17:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 12/14] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Message-ID: <d11027e3-5f34-48bf-8c75-638118dd4c9c@lunn.ch>
References: <CY8PR02MB92499D69207F6CFA01C196BB83162@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92499D69207F6CFA01C196BB83162@CY8PR02MB9249.namprd02.prod.outlook.com>

> +	/* model information */
> +	u32 model;
> +	u32 version;

These are not actually used anywhere.

	Andrew
