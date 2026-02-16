Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F953321B0
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771259138; cv=none; b=MBz50PquU7elrqfxk3F0TQFdC7dsdONk6eBaEx5Mo4LKEn1uTjXv4PUZJPW9GV5VIz/ASGWr7G0lpVNIdoIokojq92nTieHRSHZFaFk0PH73K1GNn4COamu36/P4Zw4mZ+kkMq+vRtDsKFwiedMmVdJtsAd6cQOigFfyB1gMcv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771259138; c=relaxed/simple;
	bh=Ta4kICJ8Y9QJyH+T6a9wkyN42wP3ffVBmrjA3P93nNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbhU1OhVQAz60Byb8m5pH9SS6qx9rwmpHfa4QCAg9zw/8++KptVHLbLjpkqq2/2CeotlgCk02H7jmv0Eho6Ok5gbeR4ORQ+deg0Av3AI90KM/M5hNIYhneN1AnY7w6nPiiNzOEbKFUg6x/I/qZJ9kPIa2bkeXh1/QQrafp3fyHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HuIStSfF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HuIStSfF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LVdUmiB0ZqaQigmrzQPPDJOm/XTAfJoKvIXnDMYbanc=; b=HuIStSfF/XAyIc6Mv//fn8W9B5
	qwe/TxRCCfRWCba8c9p3QUE72ljod+t9epIC9LrwNAw2wDf9l2tVZjsXzNJzQknpgt3kTsRDJ15Fj
	dynvqUlkMYZQiDviT0WOWwBVicmTYeHnSH3KVKjdiZz7jP0b4I+kHIk8KoEPIYTI5L5s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vs1Ph-007W5l-Ke; Mon, 16 Feb 2026 17:25:33 +0100
Date: Mon, 16 Feb 2026 17:25:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Felix Maurer <fmaurer@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH RFC net-next 0/2] hsr: Add additional info to send/
 receive skbs
Message-ID: <d80e1fbc-04ed-4bb7-81ea-b298c6a0f15a@lunn.ch>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <aZNBfh81p1zBvbi2@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZNBfh81p1zBvbi2@thinkpad>

> Is there a reason not to create and bind one socket directly to each of
> the underlying slave interfaces, with a socket filter attached to only
> receive the HSR+PTP packets you want?

I don't know HSR too well. But what you are suggesting is what is used
when you have an 802.1 bridge on top of two or more
interfaces. ptp4linux is configured to open the lower interfaces of
the bridge and sends/receives frames out the ports as required. I
_think_ it only works in L2 mode, since the ports don't have IP
addresses of their own.

If HSR can be made to work in the same way, you might be able to avoid
all the invasive changes.

    Andrew
