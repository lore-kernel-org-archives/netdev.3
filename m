Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE6C1C84AB;
	Fri,  1 May 2026 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777645750; cv=none; b=KG4LacxPfdd4zgg8EDkr0NSkQWFLnvZaOuOvJiVkfWLCZdeJXsc/gVQH4Ihm9EqiSumeEj/fV+PLFNksUFwIOObkk6g6PfSYoXwL8+bt4rl3IeX7/Vl3ONPPD0yWqt7CgxqMvUl/cUkeTfGB/5d3uZ0nwG3OgsIayIP/LS5zRHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777645750; c=relaxed/simple;
	bh=rZeYrXuy/lw8ZEd3MCYUa+x+GsP9QlIkHRZD/cvF3Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmD2V8LuYutflb1PIhUlVviGFJhIbNKe3I2QGTGgQydrxzOkgKqLNFznuTMZGMCYOd3ZeVdDDujsOGBAd3iyqWM3T71plt+fKBMq8otAcO+XRiWpMX37b3Lld2FRPXexTm1xe+CyoOyOiTpz6ZDc1LIHrxacWysj6odZtTEYCBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnnwATHD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnnwATHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEB2C2BCB9;
	Fri,  1 May 2026 14:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777645750;
	bh=rZeYrXuy/lw8ZEd3MCYUa+x+GsP9QlIkHRZD/cvF3Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qnnwATHDDC4drElmEdb/KEvQGvzZgviwX7f1JePNfzJxustgYZe799vQQo3ww2PrD
	 AHpssSeaKL2Xd2+N6E7C8A3xgxEROe0ZP+y1YkkHelkdN6Zl5ackE8potUtxfVmdYp
	 9atFCbqPq+Os/VgstUddbnKK+0oR02Q8XE9/mIxIryTSKVZ/1go5W8vdul1bvJZjxG
	 ENY+UKYfAl6leor/74c1NpY9SijbPwX/wab1Pv71ZlBLwmnDiYRk2Os+Z1QNDeiBrk
	 h4CtjGfGnVPhCrNvR8cewrGlX32BaHkt4QwB2myXQMpzo2L0+D9k1O9M71FF64L7si
	 4mQHX1cdt4h4w==
Date: Fri, 1 May 2026 15:29:05 +0100
From: Simon Horman <horms@kernel.org>
To: Alex Cheema <alex@exolabs.net>
Cc: oliver@neukum.org, bjorn@mork.no, oleavr@frida.re, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: usb: cdc_ncm: add Apple Mac USB-C direct
 networking quirk
Message-ID: <20260501142905.GH15617@horms.kernel.org>
References: <20260429175739.34426-1-alex@exolabs.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429175739.34426-1-alex@exolabs.net>

On Wed, Apr 29, 2026 at 06:57:39PM +0100, Alex Cheema wrote:
> Apple Silicon Macs expose two CDC NCM "private" data interfaces over
> USB-C with VID:PID 0x05ac:0x1905 and product string "Mac". This is the
> same protocol Apple already ships on iPhone (0x05ac:0x12a8) and iPad
> (0x05ac:0x12ab) for RemoteXPC since iOS 17 -- both data interfaces lack
> an interrupt status endpoint, so they rely on the FLAG_LINK_INTR-
> conditional bind path introduced in commit 3ec8d7572a69 ("CDC-NCM: add
> support for Apple's private interface").
> 
> The id_table currently has entries for iPhone and iPad but not for the
> Mac. Without a match, cdc_ncm falls through to the generic CDC NCM
> class-match entry, which uses the FLAG_LINK_INTR-having cdc_ncm_info
> struct, so bind_common() fails on the missing status endpoint and no
> netdev appears.
> 
> Add id_table entries for both interface numbers (0 and 2) of the Mac,
> bound to the existing apple_private_interface_info driver_info.
> 
> Verified empirically on a Mac Studio M3 Ultra running macOS 26.5: when
> a Mac is connected via USB-C, ioreg shows VID 0x05ac, PID 0x1905,
> product string "Mac", with two NCM data interfaces at numbers 0 and 2.
> The same PID is presented by all current Apple Silicon Mac models
> (MacBook Pro/Air, Mac mini, Mac Studio across the M-series), mirroring
> Apple's single-PID-per-family pattern from iPhone/iPad.
> 
> After this patch, plugging a Mac into a Linux host running the patched
> kernel produces two enx... interfaces (one per data interface),
> "ip -br link" lists them as UP, and standard userspace networking
> (DHCP, NetworkManager shared mode, etc.) works without any modprobe
> overrides or out-of-tree modules.
> 
> Signed-off-by: Alex Cheema <alex@exolabs.net>

Reviewed-by: Simon Horman <horms@kernel.org>

