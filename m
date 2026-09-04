Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259842EACF9;
	Fri,  4 Sep 2026 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527013; cv=none; b=uk6nnES9dtABRux7ynj3uJwoTeDxcm9TsGASrBGYEy7IYp0nnYk0+7h+PB6DbyWcITnxa4T7n9rVM06CtE6aIneEzmlzjXQ5lMx7I8/8Qz/vzIBP2cww7lYAwisEDouTDHGABTTH2S6YGRaGqrE0qOhisjwx7yMOQfTQbSn+KXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527013; c=relaxed/simple;
	bh=ywp69Z/EQfELu1Cu/ENSmj5AOnSAU9k0SaaD2c0/nG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUbNMBAj/NZGdBoxBEVmHrTLhkfTjHBXUoR7RbOQp/Ey7SR/z+wUuESS7/yQplmMzI5d60kun/v3A1sDFof3zkvZXme+ocTqJxnhm70/fOWe0+sjKvrtEmlVNPEGZZF1AS3p5W77Ou9MYtDSXhrNNI5KIB81YMCb0dJLmU/B2cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ppaHSMG5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ppaHSMG5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=W//qXnKHeVFnl12e/hho0R9Becvtsb41L6RGoliCN6k=; b=pp
	aHSMG5Ln3PVJoLY+ub09ENOnDlCCylQCl9DlXtzb3ADlXsWOO0UwFAH+Cc44QBTqAwYo9L2YmjmGe
	K9I7sWyzXXQeFw/vSGjpiG8IlWvQzuyBVrDPfO8lSBrWY/bHWXulCwQVENUy22bHvSrRklwDImo8D
	AwYTvBEqadKF/bY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2TZh-002ybx-2t; Fri, 04 Sep 2026 15:03:21 +0200
Date: Fri, 4 Sep 2026 15:03:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: dsa: motorcomm: Use u64_stats_t for
 MIB stats
Message-ID: <8405d824-1a7a-4058-a390-ac7200fb5936@lunn.ch>
References: <20260903143514.532023-1-mmyangfl@gmail.com>
 <20260903143514.532023-4-mmyangfl@gmail.com>
 <ff900ceb-82eb-4356-97f2-4af75480a8c4@lunn.ch>
 <CAAXyoMNd1mR_EvCLhjvmKjCzDDXCqWdka-Gn1e8_atnnvGvw1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMNd1mR_EvCLhjvmKjCzDDXCqWdka-Gn1e8_atnnvGvw1w@mail.gmail.com>

On Fri, Sep 04, 2026 at 10:58:06AM +0800, David Yang wrote:
> On Fri, Sep 4, 2026 at 12:25 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Thu, Sep 03, 2026 at 10:35:08PM +0800, David Yang wrote:
> > > 64-bit variables might not be atomic on 32-bit architectures, and could
> > > lead to load/store tearing. Use u64_stats_t to ensure consistency.
> >
> > Can this patch also be broken up. It should be possible to use
> > u64_stats_read() without changing the locking? So one patch which only
> > does u64_stats_read(). You should then be able to add the syncp
> > code. And lastly the mutex changes. That then allows you to explain
> > why the mutex changes are safe in the commit message.
> >
> >     Andrew
> 
> u64_stats_read are meant to be used with syncp. This sounds like an
> incorrect partial patch, works only because of the internal
> implementation of u64_stats_t.

What is making the current code correct? The mutex? So long as you
have the mutex, the code is still correct?


You can say in the commit message this is an intermediary step doing
the mechanical work of introducing u64_stats_t. The following patches
will then change the locking to be more efficient.

     Andrew
