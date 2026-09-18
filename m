Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167143B6BF2
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789698949; cv=none; b=LHcru+FbKb0Rk9bToMHb/7zFqYHDJmhFyNxDif8gV+LwtimsHZqHyVE4SRyvtO3LY0LmZi7nyT75QFR6eThlr6bsdONwtHVfH64tUTeeyuYDUrBCbhyPgPvpDnNMy0R6ddNJuviDsh81JsT7q60ho/CS2tk+YOzIYeidj+N0LmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789698949; c=relaxed/simple;
	bh=FZQAOCtbrfdB5WJykX2GMAXbs4gtfYufa6rLQPVxmXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p26Gf3zs0RDj9E32EwPwPnB1dIUWQ63Lf5lIKs/scby5jVL3fyPIzaBEkp2gLSpy3SF3ZOOPxcwUFsrUNxFADWoXCuR/4K7fXh4rYUv6Oi+onDmtSVy7wtNah3d9MjdqY7rpbbbe8uzcDcx3qz512Mj4/OC4mpUQItHzE4TZ+Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PhCPNuN7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PhCPNuN7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QeE/wqc6T4llRSmw6JjL8XJNQCRkW+lwGiD8Smvri0E=; b=PhCPNuN7H7IRD6kxOABw56x79f
	ugVP2NQkMDhDEpelzPwzHILE9d2hVJsMmZZhOm1PAB84TGWYf6CVu+dJBm2qVfKpWyxDMpy+Qanjp
	4jAq6MmESIXDFtcx+tQOD5aQL2FbmZaQvTqGNiAz+O0Wa4tOJ2Zn/bL5QRgdq1K8isro=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7ORo-005muy-Mr; Fri, 18 Sep 2026 04:35:32 +0200
Date: Fri, 18 Sep 2026 04:35:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>,
	syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: phy: allow phy_detach() before netdev
 registration
Message-ID: <6e5fdc60-26ed-48af-950a-f0593aec624b@lunn.ch>
References: <20260918022316.237646-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918022316.237646-1-chenguang.zhao@linux.dev>

>  phy_attach() does not set dev->hwprov. It is only written by ethtool
>  TSCONFIG after register_netdevice().

Please could you point me at this code.

       Andrew
