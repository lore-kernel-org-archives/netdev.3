Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793041893;
	b=YCPKHxxe7h3UvJSbGgukChGtoh4Fdm0cI2ELlmSl01BxKMB8FAgsQAtG8ahmnxGlmwU7
	 BeZl1Fqjehyi2bUBsdJkQz3pdkQUj85hO9QID7LsKo1m5Z6yVJjlQRPCvibKksfoz56UG
	 qXQJvP+56EK109dh7Am9yEnDPOF+8IQwSljunCwqyoql9m9GgLUlsOC4oMErRz1k1hrSs
	 gCVkUxgu69vEeRtXwsWrGgpSITKYULCo8WICmx1XRNGde+4abMhMebxJKQs6ykl4k2Ckj
	 CdlXZNRK/BRE8zv6fX8KdiU9+ylksJ/ok2WhXVYvyrbH/WE/C+LeJ3SfP4LsQs5+8yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793041893;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=s/blq41Vx47KQQHMBVWDCS4GUGvH4dkNTdKaeGxRU44=;
	b=IBDXaNHhiS3ikjpUJsKkW4AweKnz0Vu8VdVk95wxkNuOGaUbbkjWdYZilvrP+bH7I1Kl
	 TfgJA0s4Ut8Jo85o0z4qufk9ru5rndfk13EW0tm1yMBuKqNGxnuDxKBho6sxXNvb3hEJp
	 3VOxIfMaxH2W523iy7fFX0KyHT0Au8tu3gAhrksrwYJdacBTIR5rGyyPFM5xWXjVgqgZJ
	 aiGUuSM3UTy20r/XigsTcPoonuKWFIktWxDqIhEyiMA9Gj85yvnE+y/v33FCmmsvUogri
	 6HEHhaY5P9JxgbKoYuy7oUqPlHAFu0pFXax9Jk4esCgK5qZijvWARl8KMSKaj/rTJAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=hthgjYyB;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FC8606A31D;
	Mon, 26 Oct 2026 19:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4FC8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=hthgjYyB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=s/blq41Vx47KQQHMBVWDCS4GUGvH4dkNTdKaeGxRU44=; b=ht
	hgjYyBpMtM4Eaj7r0AUQ016jUppx6Z/sQlm/35QxGvTp2NXnjarDYPtZF55UpRlsdW8xCZJXwDrWb
	AZCqKVR4vrALyWNJHiHW/Ygkd9PyC+3EIxPcKtTmGJrcNDSsh0mBsCCc26JSVM0Fr34W3jMSETBvL
	dMUTi/8ocGdgEfg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xLQ6H-00CphE-Jc; Mon, 26 Oct 2026 20:11:17 +0100
Date: Mon, 26 Oct 2026 20:11:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>, netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 2/2] net: dsa: b53: restore the NSP IMP port 2
 Gbps mode
Message-ID: <bab723f0-742a-429b-a22d-bd086ef35389@lunn.ch>
References: <20261022211104.2091128-1-florian.fainelli@broadcom.com>
 <20261022211104.2091128-3-florian.fainelli@broadcom.com>
 <CAOiHx=nXKnzqB+-BvYg7rgxpLq9p2JP2xk8JchK-3+fqzpG7nw@mail.gmail.com>
 <47511aa5-3032-4bd1-bf8d-bcb1a2280367@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47511aa5-3032-4bd1-bf8d-bcb1a2280367@broadcom.com>

On Mon, Oct 26, 2026 at 11:34:36AM -0700, Florian Fainelli wrote:
> On 10/26/26 11:31, Jonas Gorski wrote:
> > Hi,
> > 
> > On Thu, Oct 22, 2026 at 11:11 PM Florian Fainelli
> > <florian.fainelli@broadcom.com> wrote:
> > > 
> > > The Northstar Plus IMP port uses the switch's proprietary 2 Gbps mode for
> > > its internal link to the AMAC.  Its fixed-link description reports 1 Gbps,
> > > so applying that speed clears PORT_OVERRIDE_SPEED_2000M and leaves the two
> > > ends of the internal link configured at different speeds.
> > 
> > Sounds like the devicetrees are wrong. Shouldn't that fixed-link
> > description be updated to be 2 Gbps then? ;p
> 
> That's a fair ask, however that would require introducing 2Gbits/sec all
> over the place, and it's not like we really have a good way to report that
> even through emulated PHY registers. This would not be a bug fix however,
> which this patch set is targeting.

Hi Florian

As far as i know phylink fixed-link does not care what the speed is,
and it does not try to emulate it in the PHY. So it probably just
works. Assuming the DSA driver is using phylink.

       Andrew
