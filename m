Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D9F20E334;
	Sun, 20 Sep 2026 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789915728; cv=none; b=WodChcT8LCD0IJP+HVbd6nZctrYUUkzpIn1SCvaUZGYghiCz8E+6rmdUAFL4rfRtlbob2gr2aCXucFWqxM53ryj1EM1+SiIzRARHmuAM/3dLoATg7xQn5xPX2C96lDk5ErcDWrOD9FBZRMKei+VLFGlJhubeSVX6pN+j6lZwBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789915728; c=relaxed/simple;
	bh=nZ9HjAxlIS4r2NQWtQxakSk+53oPfC6Kwmot1ZXiPZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQROcyNYFGBfEVcoE3+SHFlhDrlso0gXk+8vF/U07HrX7ahSnqjyXVkckFzTeUMbnq14SFcJNnGZEsH32V2dY4Eb64Rm7Kvhv+oWVTBTf0cFgdcpCPDUbdf3VV+pzySq1sqssuslT0m55Ikk3w+jckZz1QJBh9XKl8wZcIFZlt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F+KpU0Lb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F+KpU0Lb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xlCAbUX4OJfPRqN+rBgONcgqC3zzixt1jGl+Uj/jAHE=; b=F+KpU0LbmuUqBdLniJAu9CdRgB
	Gc9izxQbDC6rriYrdyLF09AJfjfIoZ6x545j9ZYnm9rKc3qDjywVFrl2pJ65I5GIHDTJ85BhmIFvf
	JPvOLiE6rMWMwqTzfJSGm/6MND9C2Xc+cFbBqA4dBtcUsfFKsPzsYjAT/dSJ4iPLif88=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8IqL-006AP0-QU; Sun, 20 Sep 2026 16:48:37 +0200
Date: Sun, 20 Sep 2026 16:48:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: nicolo.giuliani6@studio.unibo.it
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: continue without PTP if the TAI
 period is invalid
Message-ID: <66937bde-51a0-49d2-9ae7-f27fb4f8ecde@lunn.ch>
References: <20260919-send-net-v1-1-4355c72465ee@studio.unibo.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919-send-net-v1-1-4355c72465ee@studio.unibo.it>

On Sat, Sep 19, 2026 at 09:52:07PM +0200, Nicolo Giuliani via B4 Relay wrote:
> From: Nicolo Giuliani <nicolo.giuliani6@studio.unibo.it>
> 
> Since commit 7e3c18097a70 ("net: dsa: mv88e6xxx: read cycle counter
> period from hardware"), mv88e6xxx_ptp_setup() reads the TAI clock period
> register and fails with -ENODEV if the value is not one of the supported
> periods. mv88e6xxx_setup() propagates the error, so the switch does not
> probe at all, although it is fully usable without PTP. Before that commit
> the register was not read and the probe did not depend on its value.

The point of the failure is to indicate an assumption in the driver is
not valid, and we need to examine the assumption.

> 
> The 88E6193X on the Sophos XGS 107w reads 0 in that register, so its
> probe fails with:
> 
>   mv88e6xxx ...: unexpected cycle counter period of 0 ps

So the assumption is, all devices have valid values here. So the
correct fix is to refine the assumption. What does the datasheet for
the 88E6193X say about this register? Has its meaning changed? Marvell
like moving registers around, is it somewhere else?

    Andrew

---
pw-bot: cr
