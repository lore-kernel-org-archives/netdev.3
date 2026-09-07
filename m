Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC9E41C302;
	Mon,  7 Sep 2026 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788805398; cv=none; b=jIIpIIH752vNRHdRNr1hrNyf3pwgNC29IrcDKt6wqwTG4xf5P3ymB8Fpn/NqvD5jIquk/DEbg0/biulkr+iXNOW/ZQAAkQ8gIS+b0aWqbd/fiPW70nvWuCOZjjBArzxO9Je+gbJEAQqSTSmiT4124rnvWld73YsG7FfBRq0HF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788805398; c=relaxed/simple;
	bh=hAFls6C/FBSrXui55V4pIokGtjt5x3LLxMF1ICdYqbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiaZ/4ZgAFzp8hTGieH1yv9H2XEp8vE6a3nvj0UyqUYoSZsQM8TfH+4m66G8bUMk0PhvNlNtZDC/7r4F43dDNjbg0sQqxnFyEMIRuIwHg80emGGLFz4qoFV1VfdNg7t7XfDaPwV0OoSpYWFjUy5qWsyFQHVb343O4Cl3TU5OImY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nGLsoQjX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nGLsoQjX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qSIgHqWN4qWVtbrgyGWn0dkivDCQZ75WvKuqVIbpooc=; b=nGLsoQjXPknHgOO940CsR9Z8FU
	AtIe6ltxHCt8S0dG7WKB/CPVZAogLQqG+54+P9FFdhfV4ClIrkRPvGngZ6pydvSCmkxn0pMrmPF3W
	VB3nwuIg5b8CGhLPkY+g+nLlyrq6x/gTK3TWrubSWfEHmJaPC9xQOGo6iM81BAiaHuEE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3dzm-003aq6-6e; Mon, 07 Sep 2026 20:23:06 +0200
Date: Mon, 7 Sep 2026 20:23:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oliver Neukum <oliver@neukum.org>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>, Simon Horman <horms@kernel.org>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>,
	Mike Hsieh <Mike_Hsieh@quantatw.com>,
	Mik Lin <Mik.Lin@quantatw.com>, Potin Lai <potin.lai@quantatw.com>,
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Subject: Re: [PATCH 0/2] net: add USB CDC Ethernet NCSI support and fix
 unregister UAF
Message-ID: <1db2f8a7-6a17-410e-be1a-e9ac0b91e6d3@lunn.ch>
References: <20260907-ncsi-over-usb-v1-0-6b74d2f1196c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-ncsi-over-usb-v1-0-6b74d2f1196c@gmail.com>

On Mon, Sep 07, 2026 at 08:15:54PM +0800, Potin Lai wrote:
> This series introduces NCSI (Network Controller Sideband Interface)
> passthrough support for USB CDC Ethernet devices and fixes a
> use-after-free race condition in the NCSI core unregistration path.
> 
> In DPU (Data Processing Unit) platforms such as the NVIDIA BlueField
> series, the Baseboard Management Controller (BMC) communicates with the
> host or DPU via a dedicated USB CDC Ethernet connection for out-of-band
> management traffic.

I'm confused with the architecture here. What normally happens is the
BMC has a standard Ethernet interface which outputs RGMII. That goes
into what is in effect a little 3 port switch in the host
interface. That switch allows packets to flow to the host, to the BMC,
or out the PHY to the medium.

Because the PHY is in effect being shared by two interfaces,
management of that PHY becomes "Interesting". You don't want either of
the interfaces setting the PHY down because it would cut the other off
from the medium.

What is the architecture then USB is used?

     Andrew
