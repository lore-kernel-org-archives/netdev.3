Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E3C3CF1E6;
	Fri,  3 Jul 2026 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091673; cv=none; b=KRpfCRfhimTeG7xF+ZrxkZcOf8TN8/wq1935e2DNkNcWHZG8GoYeLxqD/Yk96VurM6ynZYBcLukupL2w5OVcHxYurVM9qXIlGbtYvmYc+zkWv0oWIAX6YLCJwFjmX6IwRbg0HddmylIvzN1pFxhaRCJPaI03z+rG1XPz2CkuoRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091673; c=relaxed/simple;
	bh=R1/O5JlS/n33NKbG2z8EknjWMBeKQt6khewGBpj2aWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Su6YDXk9+flsFFAkDQEOoHLXWWAmWYRbdEwz7X4u+vdA89IrT+PKTaO5LFMigZ5Ap1VXnBEwkpFKzvH2PVtnxy1d6zQL6eKrNiAoUy5JZCr6b60v11jcF9tmaf/ug+A6dKXfCUXVNJ2EU7fpkrNwbnQ9n+GfGNsXjJk+15Ae1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LzMTjp9G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LzMTjp9G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9CGZy+iTDMY+oiZk8zxdoTY/wmOHlXsP+ARFCQrTF04=; b=LzMTjp9G3AsM4xMovYO9FVO/Kt
	0UHTO2mWpYmKr0KxlATSjbSf9njlc1EiV0/BtJBzGW9ayL5C3f7gtuEd7ydrXzyHJfIyuym2beFRN
	77YCaRH+9ntklSv0+x5QLGxRhA8mWuOpj4yIjQn2aQPmiO3eVTI+XjXgu1mcQc7esvEE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wffat-00AZ87-Mc; Fri, 03 Jul 2026 17:14:19 +0200
Date: Fri, 3 Jul 2026 17:14:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Cedric Jehasse <cedric.jehasse@gmail.com>,
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.dea>,
	Max Hunter <max@huntershome.org>,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: dsa: mv88e6xxx: use ARRIVAL1 counter
 for all peer delay messages
Message-ID: <4a097adf-56f1-4af6-8d50-386a297f2bd1@lunn.ch>
References: <20260703-mv88e6xxx-ptp-fixes-v1-0-0138581889a9@padl.com>
 <20260703-mv88e6xxx-ptp-fixes-v1-1-0138581889a9@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-mv88e6xxx-ptp-fixes-v1-1-0138581889a9@padl.com>

On Fri, Jul 03, 2026 at 04:41:58PM +1000, Luke Howard wrote:
> mv88e6xxx switches have two arrival timestamp counters for timestamping
> PTP event messages. This permits more than one arriving event message's
> timestamp to be captured. This is useful for the case where event
> messages from a grandmaster arrive at the same time as PDelayReq/PDelayResp
> messages from a peer.
> 
> Previously only PDelayResp messages were assigned to the second arrival
> counter; this patch does so for PDelayReq messages as well.
> 
> Signed-off-by: Luke Howard <lukeh@padl.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
