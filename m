Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106956;
	b=dYqotMkO3u6ArPSyYtclZVFoSP5Wy38UtXJMDsQBAbFyIJfYtEpGHpUt9aMbhj9wdLrn
	 1slCrDnt+ZudGnUeRStT4W0MYDmLvXZ9N6LGNyfM7snHLmmkR1rNuxBu/3xcQBKq/QBkb
	 38/i5pcYDtRBpU8IB7dBNE2t8dn7wqaaY7RSpQ6Z9GWFSw1vf1YRuxhwOADQ9D1gUr5uQ
	 /O0oShk+75nZXNcJsjlgGiTy1FBe597irTNruwD9ixpitOFYOdPNP3GEBerBNZo/jeouN
	 /fMz2lGd9ejqPc75YNUrqYAxuURgNp1wb4diM5KgF0X8mBY01RRlUwBiuSYcAVf7qsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106956;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=gVfhc1iFGlBjeBwbUagMKY2t326g1zG8dwVh7cILbtc=;
	b=yxynURn4MH1cAckuZURuBJ3Ly1Q01y7ibeRgT+nMky6ZcAdQqYacrscS3Rh4OS4L0LhO
	 izP4GvJ15EZKnZJJNElYR601ZgOyXC8RM6ut5I+/ZxooUKkL9opEiz1OZ3wlKyl8H55Hu
	 efSSPkMUtKB82EPxYSLOG0GgWqoSHvwil8go9ovndwHUV+Fy5WiWEFo8Gg3a/3ZcjbfqQ
	 WvsKWgvfa8Il7DDkoH7wXnpOBqGHSfrL0ZCqU3TggmsIiJRmlNXRuw+GX/ccJeX3Ux2nu
	 wuAuWg7mTs1sdJjjGJVvT+owfpTrY1fMhPlOtt+Wqy9wHJR1I4vDNHleakr1SkkoE7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b="EvRH6/rB";
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C08606A326
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17C08606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=EvRH6/rB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gVfhc1iFGlBjeBwbUagMKY2t326g1zG8dwVh7cILbtc=; b=EvRH6/rBxxqStWlH3tyuUmrttn
	A+h/OkLWvbuTwe1VmT4ffHIcEcRPTBtA614C5dO66XAUUFa4o/vVRend92esOA9dwhnouLxTLKUGj
	/xX+oY7oJhbj5EmFJfuyRZsJXS3ZG9BIDN2v8D6vYPXsH6c1lEsZUTN+6Z7f29ae0LB8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xLh1q-00CwLC-Qm; Tue, 27 Oct 2026 14:15:50 +0100
Date: Tue, 27 Oct 2026 14:15:50 +0100
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
Message-ID: <364891b2-88ee-45d0-899a-cb2e919eae6c@lunn.ch>
References: <PH0PR09MB114568347F3E0622F9102AF628A662@PH0PR09MB11456.namprd09.prod.outlook.com>
 <c9f7ba83-ab92-4b2a-915a-1513c90a49a4@lunn.ch>
 <B0D3346C-ACAD-4938-8B3A-501F9CD52C64@pnnl.gov>
 <8546582a-e5be-471f-87e5-5eb68433083f@lunn.ch>
 <8D2A251F-C6BB-49AE-84DB-459FD7532306@pnnl.gov>
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
In-Reply-To: <8D2A251F-C6BB-49AE-84DB-459FD7532306@pnnl.gov>

On Mon, Oct 26, 2026 at 10:54:34PM +0000, Smith, Cameron T wrote:
> On Fri, Oct 23, 2026 at 03:00:23AM +0200 Andrew Lunn wrote:
> > So if you use it without MACSEC, you preappend a new header, and send
> > it out. Isn't the inner header than in plain text, making it somewhat
> > pointless?
> 
> Yes. In practice if MAC Privacy data is not encrypted, the changes 
> it's made to traffic can be trivially observed and reversed. However,
> the standard doesn't require encryption or mandate how encryption
> should take place.

What happens in practice? Just because the standard allows you to do
something does not mean we actually need to support it, especially if
it gives a sense of privacy when in fact it does not.

From an architecture perspective, i'm wondering if it should be a thin
sublayer in drivers/net/macsec.c. That then forces you to use it in
the correct way, it does actually give you privacy.

> This flexibility allows the use case where mac
> privacy encryption takes place on another device, such as an 
> Ethernet Data Encryptor. (See 802.1AEdk-2023 Section 21.8)

Does linux support this? And since this is 802.1AE, i assume it is an
extension to MACSEC? So would it be implemented in
drivers/net/macsec.c ?

> > For the timing part, how does this interact with TSN, sk_buff->tstamp
> > TAPRIO and ETF Qdisc? Clearly you want to reuse as much of that as
> > possible.
> 
> I definitely want to reuse as much as possible. MAC Privacy can use
> VLAN tags to indicate priority (See 802.1AEdk-2023 Figure 17-2), but
> I will need to look more closely at this topic.

I suspect this work will split into two parts. You will need TC and
some form of Qdisc, maybe extensions to the existing one, or maybe a
new one. And you need a layer somewhere to do the packet manipulation.

> Adding a MAC Privacy link to an existing Ethernet link named eth0
> without macsec might look like this:
> 
> ip link add link eth0 name macpriv0 type macpriv
> 
> Adding a MAC Privacy link to an existing macsec link named macsec0
> might look like this:
> 
> ip link add link macsec0 name macpriv0 type macpriv

As you can see above, i'm not yet convinced it should be a new device
stacked on top of macsec. Please explore what it would mean if the
packet manipulation part was inside the existing macsec driver. And
the packet scheduling is done via a Qdisc.

    Andrew
