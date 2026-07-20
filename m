Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F141DEC8;
	Mon, 20 Jul 2026 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554667; cv=none; b=HJtsCm4GLLIzN/bOJGoIoJbUSMtmr21hb8e/IV+kDIMK/3wkg1Fsp+pqfOgHd1gD8nmHwvIlXCYxOGGHXBzVrRa8UDt+UwCnCxhdTZgS/NSD8ba0cKM2NQd5LAGJAP49TftUtR2D9EcVjrON+zHCFCewJHUN8JNY8IZIsdS3ot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554667; c=relaxed/simple;
	bh=zlYwNl/Yy5M3XxmCQFaJEP2ezB3t1CAypx5HYeeAhGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3Mzf2GwC/n6NFRus2039xnbGulXG3z/cDaHzzKMti7vk4SRyH3VDM05wDediqs3e9jM7KMBPysMwXeV5nqoLHlFP88UlB0hZrRxCSsYhO1S+Ys4H32FZHB/CpmZMOoBNo39ZZ+RTOUPKTrc4pB+C9kkbdmbhpqkGImtruM3kSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tiAFgYuN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tiAFgYuN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G2EGhsuaHVLZRl+o3u34XmMvktvgXy8Y7soaKygN/AM=; b=tiAFgYuNj+h49EDo6UghApL1Dk
	79v6u85zceyiF4u+ZLYwuxjcO1Wy39Mg70jUL/8vxWBSSJAMQBpxGmjy1YYT2Nlcbh6X5nmzB3O+I
	S7rsXZvdsjvfJVx4kw6XJdpw9sgBzd42r+Pc53zw/cLPP+eJ7OVa2AtI2werIu+Eq0Uo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wloBb-00DGeY-1L; Mon, 20 Jul 2026 15:37:35 +0200
Date: Mon, 20 Jul 2026 15:37:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [Patch net-next v3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <f3b70dc6-95ff-4add-8b1d-6534fe4dc3f6@lunn.ch>
References: <20260717054807.1321374-1-kyle.switch@motor-comm.com>
 <06a5b8d1-f3a5-40e9-af12-52c5c9fd99e6@lunn.ch>
 <3d87f3d1-83c6-49b5-ac6f-59880c6a6c6c@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d87f3d1-83c6-49b5-ac6f-59880c6a6c6c@motor-comm.com>

> >> -static struct phy_driver motorcomm_phy_drvs[] = {
> >> -	{
> >> -		PHY_ID_MATCH_EXACT(PHY_ID_YT8511),
> >> -		.name		= "YT8511 Gigabit Ethernet",
> >> -		.config_init	= yt8511_config_init,
> >> -		.suspend	= genphy_suspend,
> >> -		.resume		= genphy_resume,
> >> -		.read_page	= yt8511_read_page,
> >> -		.write_page	= yt8511_write_page,
> >> -	},
> > 
> > I still don't like this. Please stop diff deleting all these and
> > putting them back later. It makes me thing something changed, maybe
> > white space?
> 
> Ans: I tried to refactor this issue by hanging the position of the newly
> added code. However, the same issue may still arise in other code segments, 
> without modifying the existing code.

Look at other patches on this list. Look at the diff generated. Do you
see the same sort of issue? I'm pretty sure something is wrong here.

Try

git reset HEAD~1
git diff -w

and see if you get a different diff. That would indicate there is a
whitespace change you need to revert.

	   Andrew
