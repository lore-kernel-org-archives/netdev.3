Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084E5437448
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995213; cv=none; b=arhGNcAu4FqV/JCuhYxPqqajBP1uvceAHDCzWuuinUWdloHGQ+3UKXWxOUXT8vXMe8X+S8GXMvpP3T7JkpSRKO+HCUPovtysx3qyG4m80rlkQuFNhDrW+Gdrbijg0DxMhcPkXtf7UNma9AHeapajHSSH3Z2TJPSZiYa1dNRfaik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995213; c=relaxed/simple;
	bh=8ffHjvO4mRfy8kfn09MFEqN+cz5yscwnFlqeXvW11Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9QpbnCfZiiQT/TDR6rZhM28KBGafc/xfd6OAdKW+goYBTGKZ/Mup9WPNSpG3ETB7guKi1K/HPK5+UpzaknE7JGVfSeF0fjzXO1BIQ3x4MVgMn/C8ogVN2zJKRBiMlEsOqMQ8di7Ne0tbynSLC3iF+oPbVirFH7fwD8HRoXIBpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bpckZpIm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bpckZpIm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Wj6a3pZGer1bcqk6v1Ep26LKjHUmW/0dkV9mW5wrsRc=; b=bpckZpImCIWboJVWLHwCTEzCMQ
	8qvhGHXfSR66AHulQQ+auGB4hqNtj0FvQVyfWszHL7rn+NPLMRe/yVyQsMSxMmhYWK2ze7sMLn4yq
	CIyghFpZ8VBApXdvcrI5zjW/BrxRnI3lPZSAvBTM2laUhiPLufFr+432ujgzLQKfuepo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8dWM-006Ke4-0j; Mon, 21 Sep 2026 14:53:22 +0200
Date: Mon, 21 Sep 2026 14:53:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, 'Mengyuan Lou' <mengyuanlou@net-swift.com>,
	'Andrew Lunn' <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	'Eric Dumazet' <edumazet@google.com>,
	'Jakub Kicinski' <kuba@kernel.org>,
	'Paolo Abeni' <pabeni@redhat.com>,
	'Jacob Keller' <jacob.e.keller@intel.com>,
	'Kees Cook' <kees@kernel.org>,
	'Chenguang Zhao' <zhaochenguang@kylinos.cn>,
	"'Russell King (Oracle)'" <rmk+kernel@armlinux.org.uk>,
	'Maciej Fijalkowski' <maciej.fijalkowski@intel.com>,
	'Simon Horman' <horms@kernel.org>
Subject: Re: [PATCH net 2/3] net: txgbe: keep MAC enabled for NCSI and WoL
 for SP devices
Message-ID: <f8c17a72-ede0-48e7-a870-ed4d1f918bfc@lunn.ch>
References: <20260920085114.1062503-1-jiawenwu@trustnetic.com>
 <F55611137A66BAC3+20260920085114.1062503-2-jiawenwu@trustnetic.com>
 <0b4c65e5-b2c3-4c8b-9db7-d221ffab6ec5@lunn.ch>
 <065701dd4970$1953a5a0$4bfaf0e0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <065701dd4970$1953a5a0$4bfaf0e0$@trustnetic.com>

On Mon, Sep 21, 2026 at 10:22:49AM +0800, Jiawen Wu wrote:
> On Sun, Sep 20, 2026 10:56 PM, Andrew Lunn wrote:
> > On Sun, Sep 20, 2026 at 04:51:13PM +0800, Jiawen Wu wrote:
> > > The .mac_link_down() in phylink callback disable MAC TX unconditionally.
> > > This is not suitable for devices using NCSI or WoL, where the MAC needs
> > > to remain enbaled after the link goes down to support the corresponding
> > > functionality.
> > >
> > > Skip disabling MAC TX when the subsystem device ID indicates an NCSI or
> > > WoL device. Keep the existing link-down handling for other devices.
> > 
> > NCSI i can understand, but phylink knows about WoL. This makes me
> > think your WoL code is broken. Please review it.
> 
> WoL functionality has not been implemented on txgbe.
> I'll change to fix NCSI first, then support WoL later.

I actually think we need a better solution for NCSI. At the moment,
each MAC driver has some sort of hack. It would be much better to just
tell phylink, so it can do the correct thing, similar to what it does
for WoL.

    Andrew
