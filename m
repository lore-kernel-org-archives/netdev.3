Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609864;
	b=11nH3GX2iouRMpDCkYjTiHxrOXRouqK7I74/ntzJScrd1XFYT3Ibxx7rsfwmaHDqdj9W
	 tA3npMF4sgE8Z1+q2ArVi6N6vqndufzSEvmllNlW0az5Do7bYvemo1gVgDvUtiuILnEWE
	 DVdVeh21BEuXFhRel45uNkhYeciP5mTvRMJpqIC0Eru6Ccn9tI5f65OSVfxb5zaPn+CjK
	 go3RlsJEPM3KnKxPJFzzJ4fny4sf7kxdHytAliJA3juPvy9bykQ/8Klgx91bKjzHyFbEl
	 R4vUx9cfPEFYlIbH7KHWk1bKk+ZAGFs0XHmzEZQKkg11hjev4l/HhRM9OZSolUbrcIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609864;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=aNoZYchhBD0PRHKSpgpGOdm9ECbjm6wGy/swNIhG7as=;
	b=XDFDsOIPOghe9A1TW7fy2pxr5DV7S9piiP9rOK64RUugqsPmX6gwWxM4R3G/CwdBa9rR
	 qV0lxxEurQUfOz1xAAv3TyymbkWrpFa3gbRecRJ64Uquh0RnCG37V+VAUbZ7Ee9piM0s5
	 nRW30zyYk7gMuqCLFCfpce0MwpGG6bs7aN0ZxLfDgUV53LEP4Y7tRfnqfpIQRN+fjoan6
	 TjAhdI51JsDcEl7A6sr9J+5VJOdIT0D7uHf6bYH0S9Zc+VxOXs9cqWtePhgjNXekEvWIn
	 WV5H3vZLrNt3auPZBJfNh9c6qDrnvKqEfirnuB5m/6+WrEThL9HtmiclncU0R5QiypQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=PwslOr6j;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E10606A325
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 19:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35E10606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=PwslOr6j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aNoZYchhBD0PRHKSpgpGOdm9ECbjm6wGy/swNIhG7as=; b=PwslOr6j4ec5yG2R8yjbJ+CJaG
	Pj/q5/fgWkeAafWSgCDrgdcRvTtG3BBugUanneWdPiHAFaBpLKgbVvBnTOixkO1hReadPg9GU7Mx4
	7ql0t20WpJivkxgV/Hk70XsfQIgVr9JUJ6MIh4ej5uYhncl3APhmK6WC+NT6mDld5p08=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJbi5-00C99M-5Z; Wed, 21 Oct 2026 21:10:49 +0200
Date: Wed, 21 Oct 2026 21:10:49 +0200
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
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: MAC Privacy Protection Protocol Driver Announcement
Message-ID: <c9f7ba83-ab92-4b2a-915a-1513c90a49a4@lunn.ch>
References: <PH0PR09MB114568347F3E0622F9102AF628A662@PH0PR09MB11456.namprd09.prod.outlook.com>
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
In-Reply-To: <PH0PR09MB114568347F3E0622F9102AF628A662@PH0PR09MB11456.namprd09.prod.outlook.com>

On Wed, Oct 21, 2026 at 06:33:58PM +0000, Smith, Cameron T wrote:
> Hello networking and Rust maintainers,
> 
> I'm working on a Rust network driver for MAC Privacy Protection protocol (IEEE
> 802.1AEdk).

Hi Cameron

[Goes and looks at 802.1AEdk]

  Abstract: This amendment specifies a MAC Privacy protection
  encapsulating protocol and its use in conjunction with the MAC
  Security protocol (MACsec) to hide the source and destination MAC
  addresses of user data frames, and to reduce any correlation between
  observable frame sizes and transmission timing. This helps to
  protect user and application identities and to hide the purpose and
  content of communications. Management of MACsec and privacy
  protection is supported by YANG models and SNMP MIBs. Privacy
  considerations for bridged networks are reviewed.

So this is part of macsec?

You probably want to include Sabrina Dubroca <sd@queasysnail.net> in
the discussion, the macsec maintainer.

Lets start with architecture. How does this interactive with macsec?
Is it a layer on top? Is it integrated into the existing macsec
driver? Is it layered below? Are there devices which support 802.1AEdk
in hardware? There are PHYs which can do macsec and there is an API to
perform this offload. Do we need to extend this API?

We should first make sure the architecture is correct. There is no
point discussion rust abstractions until the basic design is correct.

	Andrew
