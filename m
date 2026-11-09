Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230691;
	b=MRISfF0alKwTXeBaaf0bmOR/jqvdxdn32b5ZhlQuIBFRxUt/RHeT7H+TVTN+DUc7enAI
	 0e55EAVvjkMdEO77adwr8GLdeoLjDMzkYnyUQKqc2x7uJxC4qKeCtSRWuMxnCUyJscNCs
	 Dq5oYfPatCC1ij8Ul6aUYIpBwJJBGcslMrI9lP6jgP+Vt9pfSz/VooYPu/rhbMZcEe+Rm
	 0s0+8zLBXEY6o2wGalsCp4ovqKm7Ha8i1pKCdkDp8cvyUlNNpkp1M0hVMm5bejme4fHV9
	 oqTLEy5F28x35W5TTO6NC/NMzQCg3yhi8PcDpyuBX776X42hcnEoJxVRcl1r03FNtZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230691;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=GAhGvR2eLM43D67mkW4MLIlB8OtmJdVrtLFaXc1IelI=;
	b=gow4BrvUE67gmSf9sgUscZHeLPCrt9EDLi+ZVH4TonDhzalbERAZtSMh8eFfCIg6Lv72
	 qA+EoxRQffAu3czBBk9AMLlDZlRcLcxW3+ebUGysH9ZK2LV0CnnOs/CEWfu94AmMu1ibx
	 KjAMHATnXIextAck7hN1BgTgptMUI6gd3gj3Hug/pb5AfdzB2yVjg3/4bkpf475JZtOsz
	 Sv68h+sJtlTv5P6A4aDWrFhQc1LPbVHsd3lHoY/Zbx6XwCrrr/ZzN7Yjg6RSfka7fvJyv
	 QPTlqwODPIHTfRlFoZSBteqqBmIMB8UGMEay85X4g/G9Yb/r+O5VOPCc1hpOCXZPnuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Sc3XWC0o;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AC8606A31C;
	Mon,  9 Nov 2026 13:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42AC8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Sc3XWC0o
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GAhGvR2eLM43D67mkW4MLIlB8OtmJdVrtLFaXc1IelI=; b=Sc3XWC0o9YL+V/AmfeKnHsFyJ0
	vVfKA4JHN882lL+MOYBFLDIGLN+oDrl2vp2bTf5n99pUEMdSkRUXAKkkAtQql77wjLw9ebcP0waST
	awreAzSJ4xneNLxoPThu5vc/wtRCtFJwtkRtiCUigrFwjhDILyDPWTwnDMcXZnnPgaXM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQPMP-00FG0A-3G; Mon, 09 Nov 2026 14:24:33 +0100
Date: Mon, 9 Nov 2026 14:24:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?5p2O5bm/56GV?= <liguangshuo@mail.sdu.edu.cn>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH net] net: phy: micrel: Fix potential shared PHC
 use-after-free
Message-ID: <198e6702-0663-4183-9aaf-0fa4082dbf79@lunn.ch>
References: <20261107-0d0c29e10a-net-micrel-lan8814-1@mail.sdu.edu.cn>
 <71089325-dfab-45f7-9ebd-1feb65013863@lunn.ch>
 <AHAASAAGLPGJfVjn9skPJKoS.3.1794229559658.Hmail.202321181@mail.sdu.edu.cn>
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
In-Reply-To: <AHAASAAGLPGJfVjn9skPJKoS.3.1794229559658.Hmail.202321181@mail.sdu.edu.cn>

> >.probe() and .remove() should be opposites of each other. What happens
> >if you do that?
> >
> >    Andrew
> >
> >---
> >pw-bot: cr
> >
> 
> On LAN8814, one PHY registers the shared PHC and owns its pin array.
> If that PHY unregisters the clock in .remove(), the clock goes away
> before the pins are freed. If another port is still bound, it loses
> access to the PHC. I added the handoff in v1 to keep the clock
> available in that case.
> 
> I'll rework this around the PHY that registered the clock. I'll check
> how the remaining ports report the PHC after that PHY unbinds, and
> what happens if it binds again while another port is still up.

That is not what i asked for:

.probe() and .remove() should be opposites of each other.

Take the probe function and reverse the order of the lines.

Then reverse what each function does.

	Andrew
