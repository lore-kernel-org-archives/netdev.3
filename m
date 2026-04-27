Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B5B2F1FDF;
	Mon, 27 Apr 2026 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300652; cv=none; b=pb6xErsY9Dzh+ntCquG1MH6rW/qpNozZRsEh4yqcYn3o0B0gqAPcCRwBPVzIEV9ugP5kQTU/na76CA4cyN3liYJKBq2WxHtNTlMEgjhSLVSRsmDCkvIC6JEM7YZqMjiTZdb+8fUtKKPi8BQOIrExHckQE6zd7S9i6pfgnX3SP7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300652; c=relaxed/simple;
	bh=+XDWluClPCIxBKWFMCjf59gTb67P2sZOhu0T+2vwniw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rM2txwTap5AkLpg+6k9fuphZ4Xtd6bvyQW5qbqokflKSGOYZ7x8OacjQOS4lDD+8oRZKSTVE7z/vE2HWUyz8OjFnjw30Lw1v8c8GI20mmEoSDIYBNfjJzNNuVGnvAjmCcIN5xVUTgtL8g0cOsgSpFn49UOLAQW+9zs9p7TdtKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1fHgpSP2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1fHgpSP2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SIRv+F/yN+XqWepBe3kRnv9VsZREc7qj4A4ycWlpOiM=; b=1fHgpSP2w4dMeNgSy6s88Z+m0p
	MKwtKQhgBi5BrRHLTzNQ/VIqTqUONta3CP/llazUHlzmrQPvnFpZRz/GuOUueud2Lj/CCr46ogUpM
	OvkKFSZDFZzjjQwJcUHcjNxVwwl2RoCznn5RhK/VTnd1aHtGr0HvkJApIMa44QBep5/k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHN5V-000B47-6H; Mon, 27 Apr 2026 16:37:29 +0200
Date: Mon, 27 Apr 2026 16:37:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: MAINTAINERS: Add self for the DEC LANCE network driver
Message-ID: <35084c15-d4f8-4f28-bf9c-9185971a212b@lunn.ch>
References: <alpine.DEB.2.21.2604271113520.28583@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2604271113520.28583@angie.orcam.me.uk>

On Mon, Apr 27, 2026 at 11:23:35AM +0100, Maciej W. Rozycki wrote:
> Like with the rest of DECstation and TURBOchannel hardware I have been 
> handling the DEC LANCE network driver for some 25 years now anyway.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>

Thanks for taking over these two drivers.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
