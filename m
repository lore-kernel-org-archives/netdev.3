Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915030;
	b=f6KNntH5p4XVL5F54Q7+AOib3I9QfQtUzWHmE0fi6UzfThbKtDMgSqK9aECripjWTBSr
	 RkbxIysE96Vq3H+6YZtx8w98nXbu5jSPv3cTFx3boCAkXlo1toFoaAvv57TQ3VtRe+NEU
	 cuqeN1c2Do1AAhPSsaoGW2aRkfnx+5RJkcLVOraOJIYsNU4l/9kiF5F3MsmsDNHRqluk7
	 3sDUoLP9IAnxna0PW1YIoRtQHr/3tgZBT34dzakYYkbqx1D1bWJsX3BYPiEI+VqO8f8Fi
	 1oPUuuXIlktQg4lGfuKOEQ4Wq+KWbIbVkn5KOcR8v8XwufLxBbxmfLNmppW+JFeBuQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915030;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=kxFI2GFVoJa97jcX7ipRojoEPGOqoDfgUs9THsIEv3E=;
	b=YC61/4gSoR4At21tlbPpEcsXlvApYXTjKYMGEqt00ZGd89zuW8YtA3DbNoq6OfX6Mxvz
	 kdy6xYrvtK07v59huMGZDqvJVOn3o4YLKVjEKuMBXXvasLusEuqgZjKYJCBhIgnU0YBZZ
	 1PNYFtoVs+Nq7Z/RZW0eE71JiiO53BwxC4o7pOg/DgrB85I0Mcse/Y+bbIkQ/oAG5EyF1
	 aN/O7hxPTd9pT4qVfH6ZGC8Hq58mYfIiKAylIemKjn+98z+0+CE9HvOEgDkbjsRWldd24
	 wES8QfE6LYtES5VKowfK/5lajyLphCZLiWgrzEi2Zf6/NIIwe5YcA1C4RiNmHlfHmBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=fUNscaPY;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAA6606A31B;
	Thu,  5 Nov 2026 21:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CAA6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=fUNscaPY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kxFI2GFVoJa97jcX7ipRojoEPGOqoDfgUs9THsIEv3E=; b=fUNscaPYoByuVDnvTWOJzI2t3P
	tQfqYdoz8/jhSoNjaY448mxxGESPJHSlLJqdLbie+hgCqO1wCuvza/inNNzl7HXZ/zDVvxoxUb8/g
	0/LAdYqf1l5U+cjyDNEW6UsawkqeNjcv7xRJBqN/tyPOufxVNNBCAD5WpgBCOHbTYaOo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xP5F3-00Edw8-No; Thu, 05 Nov 2026 22:43:29 +0100
Date: Thu, 5 Nov 2026 22:43:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joseph Telaak <joseph@telaak.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Chuanhong Guo <gch981213@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-mips@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: Add Siflower SF19A2890
 GMAC
Message-ID: <7b4ab738-85c9-4747-bf89-1a5532af6901@lunn.ch>
References: <20261104-sf19a2890-gmac-v1-0-a15965a49574@telaak.dev>
 <20261104-sf19a2890-gmac-v1-1-a15965a49574@telaak.dev>
 <e134193f-ba1b-47c1-9a06-419b1b796ea0@lunn.ch>
 <CAPY4CJ74O1tFVCpcN9seoeWDF0VR9GNfKuE+rWODQamN2sjL3g@mail.gmail.com>
 <ba32cd69-23a3-464f-a74b-68a29e7b8202@lunn.ch>
 <CAPY4CJ6mCc5HgQUZd2Mq3C=Tsmwp=-acAV8dsWcpO_J87Pr6rg@mail.gmail.com>
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
In-Reply-To: <CAPY4CJ6mCc5HgQUZd2Mq3C=Tsmwp=-acAV8dsWcpO_J87Pr6rg@mail.gmail.com>

On Thu, Nov 05, 2026 at 03:57:45PM -0500, Joseph Telaak wrote:
> > Do you have access to another board which has a PHY connected, not a
> > switch?
> 
> No. The GL-SFT1200 is the only SF19A2890 board I have, and the only
> other one I know of, the vendor's evaluation board in OpenWrt, also has
> a fixed-link on this port.
> 
> > There are unexplained delays here. Is it the switch, this MAC, or the
> > PCB?
> >
> > We need to understand if tx-internal-delay 0 really means 0, or it
> > actually means 1065ps.
> 
> I can't tell that from this board. The sweeps measure the sum of the
> MAC's delay line, the switch and the PCB, and I have no documentation
> of the line's own delay at step 0.
> 
> What they do show, in the MAC's steps: the windows repeat every 8 ns,
> which puts the start of both eyes about 4 steps (0.2 ns) below 0. TX
> ends at step 51 and RX at step 28. So with every delay at 0 the link
> works, but right at the early edge of both eyes.
> 
> Until that is known, how would you like v2 to describe this board?

The delay value makes no sense to me. It probably works because
something is broken somewhere, either the MAC or the switch.

We have to be careful with what we accept, because we generally
consider DT blobs ABI, old blobs need to work with new kernels.

When we find out what is actually broken and need to fix it, we would
normally have to do that without break running boards. And that is
often very difficult and messy.

So i think we need a get out from backwards compatibility. We need to
be able to break running boards with old DT blobs, in the future when
we fix whatever is broken. Maybe the best way to do that it make the
MAC glue driver and the DSA driver depend on BROKEN.

    Andrew
