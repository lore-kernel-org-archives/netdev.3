Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CA938B14B;
	Mon, 28 Sep 2026 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598549; cv=none; b=bl9IN9V5C2/JfUh+jHNGl4NQCBKBxOoqL/5YT+K8dMXUUoH/oj4EcyULUVN5+d8q/YuEH8LpSQ6EW8FTxZnQO6kAOieKF4WG2TxKJmhIIsGQc/EL6Bu7DnzgxwMCFJG4MTunZNgUyV5RT4ZYkE266AfeT+nwZwPZk4x92E4/1Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598549; c=relaxed/simple;
	bh=R0K3v8GIXw+nLWI5778ZR8Oq0kGOMAPkIhTwn+9q8A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBbKvTivrwMXMkbslpig2XrC2+U1t46xmOCE6iup2J9SZyeb8NEqDyq7LXrcniQQXTVzyYk9kppzluB0c5MwMCcoAcTN0G/GyyFn1ys5H7HCPoJdfXlgnrZHpFPg0Iyx0+A5Oja09CRhvyeyPs1dvoXt1A3i9tYbBPHKUTpmS5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NIx7dbUq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NIx7dbUq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MZzla+0P5xuLdosjzmtmcc/9+W3oWGoM0Yk12MuNDuQ=; b=NIx7dbUqcBDAJ3/ttVakBONFq8
	WMsHO5H71POTkJDbL5Nd8x//4vD9M9qbl/iXaSFpJlC4F8b44IQpD2ev2KppkYlpdAn6Y9Gv1GJ29
	JG5vkPlFol51HWcVPz9O6e8E8OmYQioSAiRt7dvcUJTWWyTm9lLItNhRMeEiytCK2xHw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBATZ-007hl5-40; Mon, 28 Sep 2026 14:28:57 +0200
Date: Mon, 28 Sep 2026 14:28:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, neuromoments@gmail.com
Subject: Re: [PATCH net-next v12 09/15] ax88179_178a: Add VLAN offload
 support for AX88179A
Message-ID: <caf64f05-d68e-4b72-b01a-97d552370510@lunn.ch>
References: <20260916-ax88179a-v12-9-60c04c9924a2@birger-koblitz.de>
 <178968030096.22033.824447734953057557@kernel.org>
 <289700c4-8569-4160-97c5-2fc37a901a9d@birger-koblitz.de>
 <f27b2a1c-afb7-48db-9682-acf6c0a83479@lunn.ch>
 <074fb937-52fd-4806-b225-c495e874baeb@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <074fb937-52fd-4806-b225-c495e874baeb@birger-koblitz.de>

On Mon, Sep 28, 2026 at 06:41:09AM +0200, Birger Koblitz wrote:
> On 27/09/2026 4:24 pm, Andrew Lunn wrote:
> > > You ask: On a busy bus, or when a transfer stalls and hits the timeout, this
> > > blocks
> > >    all other network configuration in the system for a long time.  Could the
> > >    clear be limited to rows actually in use, batched, or moved out of the
> > > RTNL
> > >    section?
> > 
> > How long does this typically take?
> > 
> > And what is the worst case, if the device is hot-unplugged?
> > 
> > If these values are small, i don't think it is an issue.
> > 
> 
> I tested this on an AX88279 with SS and AX88772D with FS.
> In both cases the time to update the VLAN offload table is 165ms, there is
> very little statistical variation, since 768 transfers are made, averaging
> out the individual transfer times.
> 
> I then did
> sudo ethtool -K enx6c6e07090001 rx-vlan-filter on
> and unplugged immediately the device. This is not an issue at all, since now
> all transfers fail immediately, so the whole table setting takes 2ms
> and then the device disappears.
> 
> Finally, I started iperf transferring 2.5GBit/s and only then changed
> rx-vlan-filter. The time to completion was now 173ms.
> 
> I really do not believe this to be a problem.

Yes, i agree, these numbers are all small. Thanks for doing the
measurements.

     Andrew

