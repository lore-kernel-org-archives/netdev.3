Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117E41DDA18;
	Fri, 29 May 2026 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061347; cv=none; b=sRYPuoj6XJ67WbNvpXY8Ev5kC/DOAG02wEqqn00zKfnHeAxGP9zWnmPAJvMzVLO/rwGA65XId65VNO/MLN0m7mGXj6cpgE1VWRlz0JLZlfxOQpPc80zldz26/t89iCnPhMEBi9O+8lP7QnVUmkM2TbW+NIVCRyl5suf6H7spxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061347; c=relaxed/simple;
	bh=8zCx3xmJGEJVTxfSVvzIHW091hSzk/vkBkAeCMJKMXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SE8swHhC70/jyIFXKY0yLlkVvgziNSZKntM4nQnQPWdbIn04MO/XH33ip7U9L8w6L41Sw09D23+9vVw0ed+3hqAlU9Hyzp1mD5aPxnkxG+Zfc3m/hHmCGWxZOYhfoHEabhX6lBhe/lorwVCOzddu0jk9owvPPRsfOtfgPvtZXCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DEhxgxh8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DEhxgxh8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=kpSdIt40pW1yYSiBqzGx/ZOW/QCilCntdnUlwDZm+IQ=; b=DE
	hxgxh8CL4VsZe23nP6H5ewPpkKh0SGDu/YUNiHUM7Kq5RW1sZXEwaJpEs50EXLcg86RtCz1+N8GV8
	gEs53+H1aXx0uoJzxgIKYIU+Hw+p3+Ge7YZq6tRUf425S6os7sgQKynddyo+eJRLX7Vb3wTGQDBsx
	2k+X4yR4PiBjFss=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSxGi-0055gZ-Ns; Fri, 29 May 2026 15:28:56 +0200
Date: Fri, 29 May 2026 15:28:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, cedric.jehasse@luminex.be,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH net-next v4 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
Message-ID: <6040cfca-0af7-41cf-b7d0-00bd8be837bb@lunn.ch>
References: <20260528-net-next-mv88e6xxx-cbs-v4-0-8bd13b906457@luminex.be>
 <20260528-net-next-mv88e6xxx-cbs-v4-2-8bd13b906457@luminex.be>
 <DA213B68-5654-498A-B688-B92703923CCE@padl.com>
 <gigqfzdzvtoegjd6kb73g2xv4j7uq7f5s2lkrwspiosni3c44p@him3vof5vzrm>
 <793226E0-82B1-464E-9A18-969F773B70D4@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <793226E0-82B1-464E-9A18-969F773B70D4@padl.com>

> > That's not the same logic.
> > If one of the two function pointer is NULL, the other can still be executed
> > (Maybe not that likely as that's probably a mistake in the driver)
> 
> True, but agree also that it shouldn’t happen (would be a driver bug).

However, a kernel splat because you have jumped through a NULL pointer
makes a good bug report. It is much more obvious what is wrong than a
report that somebody tried to configure TC, but nothing appeared to
happen.

	Andrew
