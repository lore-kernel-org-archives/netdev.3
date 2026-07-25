Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ACD36AB46;
	Sat, 25 Jul 2026 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994919; cv=none; b=Xe6vScHtlFQught96IGwAvOODjRaB5lB3HlQlFd8vdQdM7VvAKLaPxMJd5sczpvCdG4F6oKi4u29QXhtAmEP/V/h+WdHJTeUfcRQNVbEgmEOIfVxX+eYlvvFN0DLl/nifk1YQeFVzD/i0/AxKLaMkcUOS1WVMXbX+IYAA1RLG5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994919; c=relaxed/simple;
	bh=yP10mmGUzrg/48obhb3r+1+xGk7SMUGXjV+yYmGclSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQxf6UMq+lrgnXjEou+Ypb8VocGi7o8RKekwSQPmv8mgP+Ybuxth8RFdaTLSCYjvX4ziHBTLZFgPpjUsTGlDTxNG2YGOHqXDInaBM9NGvhpwuMaWFcmC4/saHlzgcF0SN4mM2TKf/XC/GTEpPCVZ0i4KvI/Z48QiwWlEAzpaugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Q3ZcSQOE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q3ZcSQOE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=I/ImIEgfG79EqguJb0BUA/LECi0DJfTpT1YcXuMgOAQ=; b=Q3ZcSQOEtgB1Zd7o4V2PvQplNJ
	gmEXEMKQxYhfa78o4yEPbGkbI5YV1n/aDQj+8g8oZ+1S0b0rIsFcn5eVZKn/W32a9t2asxo2lPMli
	1DJTQK8BQuveN5pU7PId/NEFax28JpstDDuI8ETjJ/CgPTinqmBPTuSHO59ARMSESUVg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wneiD-00E9uH-Io; Sat, 25 Jul 2026 17:54:53 +0200
Date: Sat, 25 Jul 2026 17:54:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Luke Howard <lukeh@padl.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Cedric Jehasse <cedric.jehasse@gmail.com>,
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/3] net: dsa: mv88e6xxx: various hwstamp
 fixes
Message-ID: <d46fcc62-b032-4bf4-9397-a11f1b523125@lunn.ch>
References: <20260719-mv88e6xxx-ptp-fixes-v3-0-161386ac8a62@padl.com>
 <20260724165207.6a03c9db@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724165207.6a03c9db@kernel.org>

On Fri, Jul 24, 2026 at 04:52:07PM -0700, Jakub Kicinski wrote:
> On Sun, 19 Jul 2026 15:30:52 +1000 Luke Howard wrote:
> > Three fixes for improving the reliably of hardware timestamp acquisition
> > on Marvell switches. In our tests this eliminated missed timestamps in
> > ptp4l, whilst also preserving PTP event and general message ordering on
> > switches that support embedded timestamps.
> 
> Do you know if there's any precedent in the existing upstream drivers
> for overriding the reserved bytes? It's not normal for devices to modify
> the ingress frames. Perhaps there's some precedent, but if not I think
> we should gate this (eg with a devlink param?)
> 
> Andrew, do you have any opinion? Or perhaps Richard?

I have a dim memory of PHYs who change the packet by adding time
stamps. There are definitely DSA switches which can put the stamps in
the DSA header/trailer.

    Andrew
