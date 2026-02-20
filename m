Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D400343D9E;
	Fri, 20 Feb 2026 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771593577; cv=none; b=Ft6mkAURuVWhgWFXAIU7RPFmltrzkTN5pC+9yd2bYSPhc31IcDrRU9PYehRnVp2hTjGYtymV+jj/ZYyaK4NyNmZ0B8lxTs9uya2TsqYzDxOVStfsQwOEnNY1G81S80+mVoM2czYfYQPURMU0AfmlcURP4uSv1klKPsntXoNr3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771593577; c=relaxed/simple;
	bh=Z9baX1Oc+0kIjmmdNJGyqpVBLR+OE/bICX4S4c8DmYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Smfzp92E7XHqWokLsJY6ZrKKkQfC9jtxmTKUaMKdMzfxsfu9VrdF4NvtOvYvr3leSLmERBLAy6sfnmW29Q34li4RS5/Mh2oZzkHaFbHGZEjf8g+1Ko/8b/Pz4DkTrR3Cux48mCm1akFJo8DYSrnzARAfa14ewXNZ/6RmLR/C6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DUALUD8b; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DUALUD8b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BDq9fah7f/OdHSSrS3O1cbxrV2lTIxsoY2PgpJA2L3o=; b=DUALUD8bPdRkoch97BuRH8q7+h
	xAAm34QnuoubNAAKhIINeh9RbQ/RMeN7yrPUEYMuXJL4GJ9Iv09vj2ubhKKxTtlaIvEZsv5SVIrK8
	MO3VsDRqDYTTsGFSWXj4EQc9HCDH+76mURXtj3EkflZB+TQMntqhl7pG+c0DULsH2uP0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vtQPu-0084QU-OD; Fri, 20 Feb 2026 14:19:34 +0100
Date: Fri, 20 Feb 2026 14:19:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfc: nxp-nci: allow GPIOs to sleep
Message-ID: <d991e47a-0275-4f8d-afef-0e26fbd2bfdc@lunn.ch>
References: <20260220115906.102470-1-ian.ray@gehealthcare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220115906.102470-1-ian.ray@gehealthcare.com>

On Fri, Feb 20, 2026 at 01:59:05PM +0200, Ian Ray wrote:
> Allow the firmware and enable GPIOs to sleep.
> 
> This fixes a `WARN_ON' and allows the driver to operate GPIOs which are
> connected to I2C GPIO expanders.
> 
> -- >8 --
> kernel: WARNING: CPU: 3 PID: 2636 at drivers/gpio/gpiolib.c:3880 gpiod_set_value+0x88/0x98
> -- >8 --

Are there in tree boards which have this problem? Should this be part
of stable?

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Did you use ./scripts/get_maintainer.pl to get the To: and Cc: list?
It is very unusual to see an empty To:.

	Andrew
