Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019277;
	b=PIDsEmEAuHAFJwMbwiFNS4L+sAQB7Kt1sTXnogoBwzOKxakaH1UFLqOLUPfRtpBbFuYo
	 yzVHBy2CBULkQkHh+p6SqWoIGc1Df79QBodhP+W8FcY7zQwjP1mac8dmdc+ja/MsTSVQd
	 x7J70AISObfTGcFlAWgwZPZI11iEkhMGWtuaWZWwUha/F6eL/vKwFsbjsCT/uISN2/t3G
	 VLkPxqfPVP3wLP1aHArEChSZM7USOEW3/4kl6NuUY2V8AiJltwHrZsLeGhh/IoTDUU9zH
	 +h67+pQoSh1oJ/zrMcGQFZtllgjAXqkJLmJJUKCnE4YpqIlxfEk//YBtqisClj3Yo/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019277;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=t9x1jy4p7mYlDdJ+09dy+8fKQ8oVqna0wgGfRMSr56U=;
	b=PR6VQvf7JvwQ+kM3RK7qICTTI3l001XO3G/5e5KOX008TCEzo2NxsxwpmnfDxuIx29c+
	 2zF+3T6tBDB94SZgofeGPxWGo33Hq8reH+kAUdpshLJi9stAV4bRoBRNYS4I+iUKH2y6E
	 O+uvu0w0M03f2DjFGBpL+IjPJD0bxBl+XH41G+TkXyF/VREV3mMxSWy6BorjLnbXONeEZ
	 n8Dz81Z9EuPmycjgncGaloRmbm9jPS7JnMA/58qon9RClQjIdEF2fgb7ctNji3zm7sklz
	 AxDhXHPg6e5trsA2p1pSo+jI3HsG8o27e6XIrQHsC5bY6JFuRdognGmilWiDjXyf6Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=We4LM5rj;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B83B606A31A;
	Mon, 26 Oct 2026 12:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B83B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=We4LM5rj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=t9x1jy4p7mYlDdJ+09dy+8fKQ8oVqna0wgGfRMSr56U=; b=We4LM5rjKcXFNoN9BqA2nSNWLJ
	lsQEdax2Af5GmHuKzXiCpJQ05Jv+xI/SnCAgi7AIuNIFHSW9uwmz8BCCqFixaSyTs2dQkeScPzPVc
	PDfXmwVEGAMBJ1SnBkfj7LtDTUfJiVk+bBfsQlbZvVdHh5QnGqXcaunizgVXaH9tkCtM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xLKDQ-00Cnaw-RB; Mon, 26 Oct 2026 13:54:16 +0100
Date: Mon, 26 Oct 2026 13:54:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Igor Velkov <iav@iav.lv>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Wei Fang <wei.fang@nxp.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: phy: move irq_suspended and irq_rerun
 out of the bitfield
Message-ID: <b99454f1-9c3e-42eb-ad03-3941015879a2@lunn.ch>
References: <20261026045343.837889-1-iav@iav.lv>
 <20261026045343.837889-2-iav@iav.lv>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026045343.837889-2-iav@iav.lv>

On Mon, Oct 26, 2026 at 06:53:42AM +0200, Igor Velkov wrote:
> irq_suspended and irq_rerun share a word with link, autoneg_complete
> and interrupts. phy_interrupt() sets irq_rerun from the IRQ thread
> without phydev->lock

As you say, it is an IRQ thread. Because interrupt handlers might need
to access the PHY, which is a blocking operation,
request_threaded_irq() is used in phy_request_interrupt(). So you can
just take the mutex and make the RMW thread atomic.

     Andrew
