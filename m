Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368E449659;
	Tue, 14 Apr 2026 04:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776140612; cv=none; b=TnbCYsygFpxDItgrZICg/U2/xonEWR9u0olIpOPwsrgd41RlyDy8BAVWPV/gtZpvgxeuouE9JOsz1xg+cAV7slmDtSDlPn9r3cRqRbxTBdqzDU9H1ayF0tAuSO5oj4iFptasNVPOl1aMarJV1Bfn58FT4YYcQClEjPEcAeIBIqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776140612; c=relaxed/simple;
	bh=tOs7o5531vIaspUjfVVujFIInE6pdAjgIestE4yhouQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7CgngsPcY+yMOusR87vqCDBCOKmFs95vfJ8RuBHPwmTP9ThOrRj78i6MCEy8Bmh14AhmA8cQk9dYFObo9VVVXEUX3AJh+n8Q1YShVBoz97/rXZnw8epkDh1kjekx13isJbZqiZVnYYubItc92E0gFFWTDWv6bjgYJmAVtpS71M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=plX0o7Ms; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="plX0o7Ms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1407EC19425;
	Tue, 14 Apr 2026 04:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776140611;
	bh=tOs7o5531vIaspUjfVVujFIInE6pdAjgIestE4yhouQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=plX0o7MsDQCg1X7nB2v2u5lkau157PyJvuWsyT2ke3/N2eDCcW7NABnI4voLKHfHW
	 jQ2B9Kv6MXxozceezS+5JivF20zXUzn95wbZypQ8kXchjf7MiWipAAwm9QzpU7BcSV
	 kHFFc5CHZaRpmZezWku7cN/7wjAtV/BZV7KJzMjo=
Date: Tue, 14 Apr 2026 06:23:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] net: usb: cdc_ncm: reject negative chained NDP
 offsets
Message-ID: <2026041408-resume-mandate-c25c@gregkh>
References: <2026041137-comfy-eaten-a1ed@gregkh>
 <2a6963c8-4a87-4fed-b875-d46f3ce53e42@suse.com>
 <2026041325-giggly-wrecking-e6ef@gregkh>
 <198c1240-80a6-456c-8b12-25158c90c965@suse.com>
 <2026041355-designate-spiritual-e785@gregkh>
 <87wlyavnl3.fsf@miraculix.mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wlyavnl3.fsf@miraculix.mork.no>

On Mon, Apr 13, 2026 at 06:20:40PM +0200, Bjørn Mork wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > On Mon, Apr 13, 2026 at 02:11:50PM +0200, Oliver Neukum wrote:
> >> On 13.04.26 12:43, Greg Kroah-Hartman wrote:
> >> > On Mon, Apr 13, 2026 at 10:36:19AM +0200, Oliver Neukum wrote:
> >> > > 
> >> > > 
> >> > > On 11.04.26 12:53, Greg Kroah-Hartman wrote:
> >> > > > cdc_ncm_rx_fixup() reads dwNextNdpIndex from each NDP32 to chain to the
> >> > > > next one.  The 32-bit value from the device is stored into the signed
> >> > > > int ndpoffset so that means values with the high bit set become
> >> > > 
> >> > > Well, then isn't the problem rather that you should not store an
> >> > > unsigned value in a signed variable?
> >> > 
> >> > No.  well, yes.  but no.
> >> > 
> >> > cdc_ncm_rx_verify_nth16() returns an int, and is negative if something
> >> > went wrong, so we need it that way, and then we need to check it, like
> >> > we properly do at the top of the loop, it's just that at the bottom of
> >> > the loop we also need to do the same exact thing.
> >> 
> >> Doesn't that suggest that cdc_ncm_rx_verify_nth16() is the problem?
> >> To be precise, the way it indicates errors?
> >> As this is an offset into a buffer and the header must be at the start
> >> of the buffer, isn't 0 the natural indication of an error?
> >
> > Maybe?  I really don't know, sorry, parsing the cdc_ncm buffer is not
> > something I looked too deeply into :)
> 
> Oliver is correct AFAICS. These functions could use 0 to indicate
> errors.  This would make the code simpler and cleaner.
> 
> The negative error return is just a sloppy choice I made at a time we
> only supported the 16bit versions.  Didn't anticipate 32bit support
> since it is optional and pointless.  But as usual, hardware vendors do
> surprising things.
> 
> Note that cdc_mbim.c must be updated if cdc_ncm_rx_verify_nth16() is
> changed.

Ok thanks for the background, I'll rework this after the merge window is
over.

greg k-h
