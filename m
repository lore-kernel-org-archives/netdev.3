Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C510E47A66;
	Mon, 13 Apr 2026 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077009; cv=none; b=uq4zPjsPDAaMnFXlteMTjFs+5ICBkOG5c472NJE5YvV/z1hn0La6tibB56uRrsP8T6bZc+Wj8Q4MVqG6lCW9jZSMul3hiiAvcgysgderMTACUSDkEq4fGyrFWuxtVQmNBgu62NSs0trPnf4NGRT143/dDgXn9gspniAweFGokWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077009; c=relaxed/simple;
	bh=DzDYCviVBC/5WJuRSXlQj5r75TlhKJ7JLvqGP1sDTdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGWOtFHQ8cw+6zOdJ4sYEipyuB+Pc0Vz0PnRo04zudPuY/Ju3UvMErok/vFio53jTDNCJp62IorSGF+BIk8DiMkIkffs0gvrSCcSHGZElamYaN351fDbHeXJDzsGvm3NJzKRmRhY659DtMvdBn96Jr7l1gozTmb2DAAOSqdEJRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QB0KplN7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QB0KplN7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12965C116C6;
	Mon, 13 Apr 2026 10:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776077009;
	bh=DzDYCviVBC/5WJuRSXlQj5r75TlhKJ7JLvqGP1sDTdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QB0KplN7FxSzSGhCiuI86DT8g8uBdLBX/VVUuhHADNbIeRRwMD8p0OqwXCiP1Regn
	 sVyQI37ugshMcrIOC1Mzq6IaKVlWZNhIZbtN0cpCP2yPNRiOwZ1KWXCC7PzwB9RTko
	 jOF1wD6Flp5w0Q78Xvb7S7Ps8rxiUctFFiRgOfM0=
Date: Mon, 13 Apr 2026 12:43:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] net: usb: cdc_ncm: reject negative chained NDP
 offsets
Message-ID: <2026041325-giggly-wrecking-e6ef@gregkh>
References: <2026041137-comfy-eaten-a1ed@gregkh>
 <2a6963c8-4a87-4fed-b875-d46f3ce53e42@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a6963c8-4a87-4fed-b875-d46f3ce53e42@suse.com>

On Mon, Apr 13, 2026 at 10:36:19AM +0200, Oliver Neukum wrote:
> 
> 
> On 11.04.26 12:53, Greg Kroah-Hartman wrote:
> > cdc_ncm_rx_fixup() reads dwNextNdpIndex from each NDP32 to chain to the
> > next one.  The 32-bit value from the device is stored into the signed
> > int ndpoffset so that means values with the high bit set become
> 
> Well, then isn't the problem rather that you should not store an
> unsigned value in a signed variable?

No.  well, yes.  but no.

cdc_ncm_rx_verify_nth16() returns an int, and is negative if something
went wrong, so we need it that way, and then we need to check it, like
we properly do at the top of the loop, it's just that at the bottom of
the loop we also need to do the same exact thing.

So I really think this patch is the correct thing to do unless you want
to add another temp variable here just for the sign -> unsigned
transition and but that might be even messier.

thanks,

greg k-h
