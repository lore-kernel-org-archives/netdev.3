Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D800F155C97;
	Thu, 18 Jun 2026 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781781852; cv=none; b=gF/Nt8O+qPExvtwj4g7+GR6KfZEN3KOfegd7UUHBcMVfxTojHKrpdZ5pJDm7Y2c2Vs6BQSBIhCSaFC1KTX5ohgJdVYuLofEqtvL8BU/kQSUNweQWmKekU6Un7e3/iNI+kroe0P/iK0vcA0aQWHnCbvY1xbuS2WCeGwIkZNIVrqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781781852; c=relaxed/simple;
	bh=VImDC8judLx38ouaN+xL3fKfJVJGYjZYzMhuQtCxzqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTf5ee1hKo4WdznyyHTiiHcwE1BYqwpANbz62sbxlKFKfp012MfgwnZLJ60g63UIX5snEEY8o2UMrbAQqtGTjahC5EzHO9waPwzNsRAQxjWst8W32q1LZKPVKyh2LVXKg/8uTfXTr9RgOeYwpvIfqd92rbxI+IUJJxY6SM9weII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yXsum/2J; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yXsum/2J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KIVhtGDOftKGMoqU6D8/d4TMAblKDzksnARw6vxVdcw=; b=yXsum/2JI2Ph64k4YrNglCS8tA
	xlEjQXaixDCl1NhwC4ls/bBCyr0q/m2NDKVMHhp1f+7/VPhNfLyGxO/oQ6N1kR51WUC2XHvhiK+Qt
	ON52Kx4BQSw8U6UUYRtbNVqEoghiP53xQpw77Oz8uevBbKio2CeNQ0mTr/XeC/O8fnjg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1waAqg-008KhB-Rm; Thu, 18 Jun 2026 13:23:54 +0200
Date: Thu, 18 Jun 2026 13:23:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Finn Thain <fthain@linux-m68k.org>,
	Carsten Strotmann <carsten@strotmann.de>,
	Jakub Kicinski <kuba@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	chleroy@kernel.org, npiggin@gmail.com, mpe@ellerman.id.au,
	maddy@linux.ibm.com, linux-mips@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
Message-ID: <91591775-3ac7-4b1f-91a3-9c58df96d9fc@lunn.ch>
References: <20260616084901.3319d82e@kernel.org>
 <1781694488854.956546368.818588236@strotmann.de>
 <489024bc-b6e5-f601-3bce-444d75abbf5d@linux-m68k.org>
 <2791b2e3-bf58-4dce-9262-4f1d8d3241fb@lunn.ch>
 <CAMuHMdU0em2r-SixT_+EpWJnm4f0g8mReYKBXOw42=HGb_T8WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU0em2r-SixT_+EpWJnm4f0g8mReYKBXOw42=HGb_T8WQ@mail.gmail.com>

On Thu, Jun 18, 2026 at 10:13:08AM +0200, Geert Uytterhoeven wrote:
> Hi Andrew,
> 
> On Thu, 18 Jun 2026 at 10:01, Andrew Lunn <andrew@lunn.ch> wrote:
> > If the appletalk community can take the workload off the top level
> > maintainers, respond to all patches within 2 to 3 days, give
> > Reviewed-by, or make change requests, it can probably stay in the
> > Mainline kernel. Otherwise it will move out of tree.
> 
> "2 or 3 days" is rather short.  If we would have to move all code
> maintained by people who cannot respond to all patches within 2 to
> 3 days out of the mainline kernel, you'd end up with a networking
> subsystem without supporting OS ;-)

I do agree that every subsystem is different, but that is the speed
netdev goes, often faster. There are around 150 patches a day
submitted, and in order to not drown in those patches, they need to be
processed fast.

It is however known for a sub-subsystem to move out of netdev to a
mailing list and a git tree of its own, and just send git pull
requests to netdev. It can then move at its own speed.

	Andrew

