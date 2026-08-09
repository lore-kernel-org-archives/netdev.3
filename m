Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CC223393E;
	Sun,  9 Aug 2026 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786312744; cv=none; b=AGgTCdQ5GEwxnnFOytt7tVauFgL/4I3eaYtdNIr6pNz0eISdqEvVPLM6etL/2xjxqCi6J3IG4+JN/DsGJC7je+eyy0rAo6bx8Qg4kxL98rBPoYx6hJ+t4YMJJJ4HD6vMyEu4M+l3i6bohWKE31MvgXRgtCGUqM4KplWFRXop2HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786312744; c=relaxed/simple;
	bh=k79Yv0d4OeHnb/rHrhI1Y3WHQ7eMEm6VLWZuW+3W5Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVsI/VpJTXZu+EfjbVfI/5Cyx9YB5CxdRxpHsBgbQIW2SzOcGcIFwGRtG/L5h5RrDz7OV5qq0HzJQNQ/9PY/5pYL7SRMlgMwbyJcQ5dDO5/WgPuqy8DWKCFNcw6UOICNFKeAvGtLgv9yd4Ynqt4+KCu7uSnnke/VRWZ35CEerS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UT9kxKRH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UT9kxKRH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bv4vQpENqSL0oaKxKnd0My5r67vgBWsw1itVF11BgVI=; b=UT9kxKRHxTVHECzMalsw691BBl
	mqV9iwO84WEpGAnDiDaWKb2cOO8Bqcebq1Te4DdMYsSh7qOjj3rDwelS/Ml5Sr86Yd+bNRTOu6oQ4
	8HKaHiscxUKLrecqV1Ih8+vFY51i51+NCplAV5fiM7w7maOy/NKpUtR+dHT0mL3gX41Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtBXY-00GrIn-TJ; Sun, 09 Aug 2026 23:58:44 +0200
Date: Sun, 9 Aug 2026 23:58:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v13 06/11] net: mdio: realtek-rtl9300: Add page
 tracking
Message-ID: <35e415fc-a398-477f-a39e-10842ea44ca2@lunn.ch>
References: <20260807171058.522833-1-markus.stockhausen@gmx.de>
 <20260807171058.522833-7-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807171058.522833-7-markus.stockhausen@gmx.de>

> Looking at this implementation one might argue that disabling/enabling
> polling might be a cleaner solution. But one must remember that
 
I don't like this, but will accept it if you block C45 over C22. That
probably means you cannot support EEE, since there is no safe way to
access the EEE registers.

	 Andrew
