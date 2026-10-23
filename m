Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717235;
	b=SxA/fA/uCS5/du6kXEI/dKJnR3UxqdnHmMUrWUKkgRE43aVfTLY3Y3aFM1ATuDiPP1y3
	 RbhE9OJvQ1B23TWbzoQGipku+6KqPArJMutyshOpX2zVn1o0mSL8IFjUfZNO1uUTaCvCY
	 rmxedPKV/pWExICCbIRIFHK8/vzu0frzbaZEYG48hjSfnUUzsD6acCayu6MQlBDUsbaQw
	 66BuE3n9qXwJsqOmMWCryk0K8Zjs8bC92yNBS4Wem9xhwK0b7BUblzsKW1ncBXS2Fa32y
	 G8HVSg+fuK11vTzROa3sBmYJRZ/XqXIPXUDu0A1OJ29WRiG+O1NstPw47J/h/n8IIaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717235;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=zVaLpAsIiVIQmfpchL86u6CwfMuZG3f6IGNtdW3duIQ=;
	b=4S0eIO83kKAFbtAuVb+atgr+HPhfjEPV7+Jw/0yLr+bEIVGYyD0FtozbSwn0OIZR2Ujq
	 V1QP8UbvhjFEUdQThBmFO4d2PvSO18miLS04s114xisDothb6uZ0xRIi2pGcjihYptb5e
	 eQfaXDCssTNQQ4XCG0wXfseqzCRHsfy1mByvt9QQO9LcCaLjDlT//j4844MEjIcM6wAY+
	 tuVjDs9t9D5vgFT9MY2oSMziftkEC09M7jjnM8imLebQeTrPlMXPrOnDoF5nPbBMtXrsj
	 LkDLvBLflm3HR597xiHFUbf0J+lhCWDVclL8nOoG8ttLsw47L6lr69P91ZBMyzgsZgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=aRiPIfvj;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF518606A31E
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF518606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=aRiPIfvj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zVaLpAsIiVIQmfpchL86u6CwfMuZG3f6IGNtdW3duIQ=; b=aRiPIfvjVQA7h18uJt/1agMPLr
	Y0DonfCYcCGiV28sjAVqzbJvrUqZ+Znre4jJIzeAj+FmYTpOMZwg8r2WE7nHAlC3+pMXdlB5dY5mx
	+xetCuRk9iWriFyWLbzWeg5L7N60QUPubV00y2bqP3VO+Xh3fjz8lzeLZ7nv92MYdXos=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xK3dv-00CLt0-Fw; Fri, 23 Oct 2026 03:00:23 +0200
Date: Fri, 23 Oct 2026 03:00:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Smith, Cameron T" <cameron.smith@pnnl.gov>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"ojeda@kernel.org" <ojeda@kernel.org>,
	"boqun@kernel.org" <boqun@kernel.org>,
	"gary@garyguo.net" <gary@garyguo.net>,
	"bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
	"lossin@kernel.org" <lossin@kernel.org>,
	"a.hindborg@kernel.org" <a.hindborg@kernel.org>,
	"aliceryhl@google.com" <aliceryhl@google.com>,
	"tmgross@umich.edu" <tmgross@umich.edu>,
	"dakr@kernel.org" <dakr@kernel.org>,
	"daniel.almeida@collabora.com" <daniel.almeida@collabora.com>,
	"tamird@kernel.org" <tamird@kernel.org>,
	"acourbot@nvidia.com" <acourbot@nvidia.com>,
	"work@onurozkan.dev" <work@onurozkan.dev>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"Griswold, Richard L" <richard.griswold@pnnl.gov>,
	"Phillips, Aaron R" <Aaron.Phillips@pnnl.gov>
Subject: Re: MAC Privacy Protection Protocol Driver Announcement
Message-ID: <8546582a-e5be-471f-87e5-5eb68433083f@lunn.ch>
References: <PH0PR09MB114568347F3E0622F9102AF628A662@PH0PR09MB11456.namprd09.prod.outlook.com>
 <c9f7ba83-ab92-4b2a-915a-1513c90a49a4@lunn.ch>
 <B0D3346C-ACAD-4938-8B3A-501F9CD52C64@pnnl.gov>
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
In-Reply-To: <B0D3346C-ACAD-4938-8B3A-501F9CD52C64@pnnl.gov>

On Thu, Oct 22, 2026 at 10:55:59PM +0000, Smith, Cameron T wrote:
> Hi Andrew,
> 
> Thanks for the recommendation to include Sabrina Dubroca.
> 
> On 10/21/26, 12:10, "Andrew Lunn" <andrew@lunn.ch <mailto:andrew@lunn.ch>> wrote:
> > So this is part of macsec?
> 
> Yes and no. It's standardized by IEEE as an amendment to 802.1AE and 
> intended for use with MACsec. However, it's defined as a separate protocol 
> with a dedicated ethertype, and the specification allows it to be used 
> without MACsec. 

I spent maybe 10 minutes looking at standard, so i've not got a good
understanding of it, so maybe i'm asking dumb questions.

So if you use it without MACSEC, you preappend a new header, and send
it out. Isn't the inner header than in plain text, making it somewhat
pointless?

> > Lets start with architecture. How does this interactive with macsec?
> > Is it a layer on top? Is it integrated into the existing macsec
> > driver? Is it layered below? Are there devices which support 802.1AEdk
> > in hardware? There are PHYs which can do macsec and there is an API to
> > perform this offload. Do we need to extend this API?
> 
> When used with MACsec, each MAC Privacy protection Protocol Data Unit
> (MPPDU) is placed within the payload of a MACsec data unit. Also, as 
> mentioned above, use of MACsec is not required, and one could use another 
> protocol, such as Ethernet, instead. Because of this, I think it makes 
> sense to implement MAC Privacy as a separate driver from MACsec. 

For the timing part, how does this interact with TSN, sk_buff->tstamp
TAPRIO and ETF Qdisc? Clearly you want to reuse as much of that as
possible.

> To my knowledge there are not currently any devices which support 802.1AEdk
> in hardware. Implementing MAC Privacy as a separate driver means
> hardware offload for MACsec can be used without changes while allowing
> Linux to perform MAC Privacy.

But we need a path for when MAC privacy is in hardware. However, is
that actually possible? The encapsulation to hide the MAC addresses
and perform padding should be possible, but what about the timing
part? Can that be offloaded? I guess not in a PHY, but a MAC
implementation would be possible, it pulling packets out of a queue at
a given rate, adding the extra header and padding, and then putting it
on the wire.

What does you user configuration API look like? Can you give us
examples of what you think iproute2 would look like, both with it
stacked on macsec, and directly on top of Ethernet. And what tc
commands are required.

   Andrew



