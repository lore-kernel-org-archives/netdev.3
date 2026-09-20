Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262362D97A6;
	Sun, 20 Sep 2026 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789930725; cv=none; b=nKX4/ok7XTbkO1/TUKFkdt4hVJFqrluZVGtekyC8TNrhnWXmPQCky/xL83jWRxMfZAxjVluMp+W9nqx6QD7Pi13XE0hsgTrrNhqNvm54j6MrIXCpuwENcxJzU7Tp+CsZONVM6gu7CNiOq3iKRcqql7el6zG1iChUUXg2zWn6diI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789930725; c=relaxed/simple;
	bh=znNhHj4L2n/p2Lp5h9Kwr4jYUjH66grR1RIRJN15M7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jl+GmhDjRA22LZHVe3OzDJHMw2HxlOREQLtook7dS/BQZ9E98n1rSlCZlHkdA70G9LUaOQ+qSapJIZKkkg12ApBXp+YX2efb+3lAY8Y9snQgNQEXQRrEX/us4iQOS8ne6ge8/m70ax0MvJztA3TkDWrNfXJVYqAAy36v5B2tQKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AcuVNqjM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AcuVNqjM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=qYQleoFvs99p8ooFy5bGAQ/ufyR4hI12KJUFrG0P1DA=; b=Ac
	uVNqjMcWbNu4FtNUWYhZK2mLHeTv7msvavESzCcaekD9MbxdyD5RbKjbazBlOT8IHRm+7gIkXXSqt
	m8E052xgfd5Fgl3gteTda6xwqTSBtVxk+nOnxK//YRynqHlufNwvl1I0nUEuTnjmrYk73y24S08+E
	r/pNN0Ewmv+Rbec=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8MkF-006Bb9-Qs; Sun, 20 Sep 2026 20:58:35 +0200
Date: Sun, 20 Sep 2026 20:58:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Nicol=F2_Giuliani_-_nicolo=2Egiuliani6=40studio=2Eunibo?=
	=?iso-8859-1?B?Lml0?= <nicolo.giuliani6@studio.unibo.it>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: R: [PATCH net] net: dsa: mv88e6xxx: continue without PTP if the
 TAI period is invalid
Message-ID: <fde8b48a-10ed-46fd-b477-18ac57df8a88@lunn.ch>
References: <20260919-send-net-v1-1-4355c72465ee@studio.unibo.it>
 <66937bde-51a0-49d2-9ae7-f27fb4f8ecde@lunn.ch>
 <DU4PR01MB12163870875DEF21E5C39DD2D80852@DU4PR01MB12163.eurprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU4PR01MB12163870875DEF21E5C39DD2D80852@DU4PR01MB12163.eurprd01.prod.exchangelabs.com>

On Sun, Sep 20, 2026 at 05:34:01PM +0000, Nicolò Giuliani - nicolo.giuliani6@studio.unibo.it wrote:
> 
> Hi Andrew,
> 
> > The point of the failure is to indicate an assumption in the driver is
> > not valid, and we need to examine the assumption.
> 
> You are right, and my patch only works around it.
> 
> > What does the datasheet for the 88E6193X say about this register? Has
> > its meaning changed? Marvell like moving registers around, is it
> > somewhere else?
> 
> I do not have the datasheet for this chip, so I cannot answer that from documentation.

I don't have the 88E6193X either. But i do have some other datasheets.

If the device is using the internal 250MHz clock, the register is
expected to contain 0x0FA0, 4000picoseconds. If i remember correctly,
the patch which changed things was because different devices have
different internal clocks, hence the need to read it.

There is however the option to use an external clock. This is
controlled via TAI register 0x1e. If bit 14 is 0, the internal clock
is used. If 1, the external clock is used. With the external clock,
you need to write to register 0x01 what the external clock period is,
in picoseconds.

So you probably want to check what register 0x1e contains.

	Andrew
