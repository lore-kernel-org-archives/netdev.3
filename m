Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328219;
	b=dZOSDuJswkPmhTuzoweI+qrC037czquFX5NqZD0jTyICSxlz2qpXJxeOG6ZO/RwcYP5a
	 S1oT6IQhUnTlAqi//4resIHQbPyvqHJoaCpSvTbsF3r9LYWy6F+gQgnFl20MexyFUAKpv
	 a0POo/vpGZGvNCtAggYWo73z8raeaq9K9H1gvIagf5Kz7bFpJXgKzY/i8lrsXVAC8ZdED
	 Y5dZVZsAOK8synX3653EkrX+dx79crzDGd9hpavtNohAiTjqgECBCKNNOAomfbJVNgi+T
	 dkM0QuGPff5cNv+rlxjcsh/jfVR3Pr8qIz69CmlOjcr7ORelYWkQT5INHBR1Zp6xWqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328219;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=qlkRdP+OemHI6B7OgiIXHMh7VZdytCmNUQ3brR2dwjM=;
	b=htIfiAFJTBgmNaS2W9l2jXQOj55YMHfTzgQIpZdJm8THcuwChR1Jtm9jumVfMPDq52mi
	 UDYE0APlAfuAOep1vlt2TxiOyVpnrxE+Ax04R2aML8jO34MB8lnOdnmW1EHC901EgWnQ7
	 +KOJWq4islbjOaZPO1OSW7gFnUeOpZcjr7sjnRfHhzgHiohhKVXNxoigJXjZViMalh2QD
	 a+OONAhY1lEYkjZvNZUozI/lmP0+MJu2IePryayUwJNbNsLZxoi1OEWFR5/1Lrp8OvdfO
	 fgWCC5cfUCDJzy59G54zq8ghyecHBwBbN3vYCAeJVB2O/+0Ar4dpLErC02HQw6It6wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=3y7X+bTh;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A706C606B514;
	Tue, 10 Nov 2026 16:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A706C606B514
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=3y7X+bTh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qlkRdP+OemHI6B7OgiIXHMh7VZdytCmNUQ3brR2dwjM=; b=3y7X+bThelV+CkgEm5Zy7gOuvD
	rFstJRk+/gHKPe2G8aUQ9GmHqV3rp/aZcEkTgnoPXNBjnGBxBcJTnAxN3Y0VO7s2PrK72lRJwIA0v
	Jgflh6z2WOJXqMeoNcp6xt8KX7QnLZZtSGwlOCgU1hsDYxWk823THRqV83y0Tc4Ht8/4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQojV-00FWqg-65; Tue, 10 Nov 2026 17:30:05 +0100
Date: Tue, 10 Nov 2026 17:30:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, hkallweit1@gmail.com, chenhuacai@kernel.org,
	kernel@xen0n.name, edumazet@kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, neuromoments@gmail.com,
	beganovic.emir@gmail.com
Subject: Re: [PATCH net-next v20 01/13] phylink: Add phylink_mac_interrupt
Message-ID: <7c78c868-efe4-4b0a-b09a-c196210644e7@lunn.ch>
References: <20261106-ax88179a-v20-1-37b5a1189983@birger-koblitz.de>
 <179427470922.994134.16776316201780098943@kernel.org>
 <64d05861-c4e1-4506-ac2f-4109f1062932@birger-koblitz.de>
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
In-Reply-To: <64d05861-c4e1-4506-ac2f-4109f1062932@birger-koblitz.de>

> At this point I am asking a human to intervene and tell me whether anything
> really still needs to be done.

Do any of the patches not have a Reviewed-by: from me?
I thought i had given such tags.

We should merge this code.

   Andrew
