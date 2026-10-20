Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524612;
	b=tDiWNW30wPi7BGhSfUy89GjiC0dmM17bEqHnRTZbbqfaIw2LraU+itF59c7pcnf6ZKR/
	 bS+hJ3lZudkMnDfSVop/V+fPBNoOYh3/jzybXbZkGF9mI5FiK4CApmFi8Tp38vWbjFEdx
	 aKDyy40LsW0T2MJ/IG0eXurDJ9AriW830fzPb27dPreQRfBYrmoQQwKrou/zE99CajThg
	 QXgVqU5pA8GsFCVdu7jLxdsFOE/PsKh8i5HHkR5NNCBJmy/X/09IPD1XCW0xk8MCEVeAR
	 wo1sZcZ/pOAd9iVNaSeIAmaN5//LYJ3TGzkmrPi4YLyY9/NPadxwOkcKYmshgL85k6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524612;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Ro+ZQGqvoHjxfsJoqJ8Yh63KTW/BZhi188QX3SNHCQU=;
	b=XReSWmyk04XHA9hfOMOTB+JssWLyb/2y9wxC7pbBgTNO+AyuaubSWaBLM2/C33oLY4v4
	 VVAayQZqj/NwvVYJA+qOa+85bJTIj6C/iJZKrOhATGioF9fj0Eu182rjzHzQ5lSfrPc6s
	 aztsC++/GWyHr6jCRQU949Od0vWaEYc+dOOLNz13iJNGBF89C+Gv9UGgOrTC4r3XEZGdT
	 u75DBr3e7tV3pZybauM7JpxTsbFHNLOdsBFqKoK0SJEUI2zA+YVfs57SGEHbezo56/98y
	 8qzsQ81SfZXxj3doUCjeZOVq/oDUlP52hdWCQzMZOL4hXxiOuyEe3AL8Fhizj1c6yzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=HGxkr8il;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF18606A331;
	Tue, 20 Oct 2026 19:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BF18606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=HGxkr8il
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ro+ZQGqvoHjxfsJoqJ8Yh63KTW/BZhi188QX3SNHCQU=; b=HGxkr8ilpsS8CX1H+RCJQyXN9N
	kgK96RizNWOsvfnVMSk8Tt1EQ7flE2KgXhZ5O/fI2/MmGTw3xKY9+D4UtEo/+1sR+IS99TLqIPlNm
	mdqkHxouGZwgPCqcGJG3oZmu6wsPQNdQpn2ZN4AgPmvYJhZi3WoFFmVjVMPyCzulyMTs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJFWw-00BueB-Gr; Tue, 20 Oct 2026 21:29:50 +0200
Date: Tue, 20 Oct 2026 21:29:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"edumazet@kernel.org" <edumazet@kernel.org>,
	"piergiorgio.beruto@gmail.com" <piergiorgio.beruto@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"jerry.ray@microchip.com" <jerry.ray@microchip.com>,
	"ciprian.regus@analog.com" <ciprian.regus@analog.com>
Subject: Re: [PATCH net-next v9 03/11] net: ethernet: oa_tc6: Move oa_tc6.c
 to its own directory
Message-ID: <e40a4fae-b339-4a5a-b21e-3a31dd3ddd5a@lunn.ch>
References: <20261009-s2500-mac-phy-support-v9-3-dcefe1d0bf0d@onsemi.com>
 <179166121127.434549.2014178695820662916@kernel.org>
 <CH0PR02MB786710538BD4784E5CF2C9A183672@CH0PR02MB7867.namprd02.prod.outlook.com>
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
In-Reply-To: <CH0PR02MB786710538BD4784E5CF2C9A183672@CH0PR02MB7867.namprd02.prod.outlook.com>

On Tue, Oct 20, 2026 at 04:48:48PM +0000, Selvamani Rajagopal wrote:
> Andrew, Jakub (and other concerned reviewers).
> 
> This following feedback about change of module name is being raised regularly. While I understand 
> the concern (and I agree with it), this is how it has been from the beginning and I didn't see any 
> concern from the reviewers. So, I thought it is ok to leave it the way it is.
> 
> My question is, should I change the module name back to the original oa_tc6.ko (from
> oa_tc6_mod.ko that is used in this patch series). If I choose to do that, original file name oa_tc6.c
> would have to change to oa_tc6_core.c or something like that.

I don't think we consider module names ABI.

However, some distros, especially in the embedded space such as yocto,
do make use of the module name, it produces a binary RPM named from
the module name. So if a rename can be avoided, that would be great.

Git is pretty good at following renames, so renaming oa_tc6.c to
oa_tc6_core.c in order to keep the module name the same should not
cause problems.

    Andrew
