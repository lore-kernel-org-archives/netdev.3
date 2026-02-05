Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6109E1A23A4
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 00:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770250888; cv=none; b=n5HwLNYb4Lq6qpDpn25WLR0CQVygCpnJZOW04aYsRjbqLQVEUJurjG4ek7ocCdDjojY9ip/57SfIJnpF1YTxQqBJsTiDYcI3LTcZuV5AGJLn8vNWZL8zFxOCWnW1pBcFzo6U1Pnu+YwSFDAKjo7m049bMnjeHvgBqhYUhsO884E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770250888; c=relaxed/simple;
	bh=hLAbki5h7AW9BsnSTh13LcgnzN4GmBZtSGoVwrOmins=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hLrf+YhmUOWYrP9XsxLyRhw40aTOv2NZIOIN0QS4RmRgw3uCBF4xTvMRhp73n9SiKNXKFZOfPPtcoDmize1r2YQthbyFd3O5ACwrDH1+xKDIZBTPH35Jyhq2BBOUP/PwLLFL5RAn9gdCGEl7rsP1N+GXQYU9INR/3B+UzR4Vw0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 98A3792009C; Thu,  5 Feb 2026 01:21:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 90FF892009B;
	Thu,  5 Feb 2026 00:21:25 +0000 (GMT)
Date: Thu, 5 Feb 2026 00:21:25 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
    Don Fry <pcnet32@frontier.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: ethernet: pcnet32: remove VLB support
In-Reply-To: <CADkSEUgHZEi5=pWORZv8_L8B_X9Fu3jp=BsGnjGq7a2TLHDH_w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2602050003510.12532@angie.orcam.me.uk>
References: <20260131012119.25863-1-enelsonmoore@gmail.com> <20260202182054.0a755aea@kernel.org> <CADkSEUiAvv6eHEcLBkHRW8KFqSgcxg46+1BE25T50hT6ZkGbbA@mail.gmail.com> <20260203145729.5c491d71@kernel.org>
 <CADkSEUgHZEi5=pWORZv8_L8B_X9Fu3jp=BsGnjGq7a2TLHDH_w@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Feb 2026, Ethan Nelson-Moore wrote:

> > IMHO we should probably start deleting the "QEMU emulation uses this"
> > toys, too. virtio existed for long enough.
> I wasn't saying we should keep it *because* QEMU emulates it, but
> rather that it shows the driver is not totally broken and is likely
> also working on real hardware.

 It's not "likely also working on real hardware," it does work as noted in 
the previous iteration by Thomas (cc'd again), who wrote the driver, and 
myself.  Most recently verified by myself 10 minutes ago with:

# uname -a
Linux [...] 6.18.0-rc1-dirty #70 Thu Nov 27 04:14:19 GMT 2025 mips unknown unknown GNU/Linux
# lspci -s 00:0b.0 -knn
00:0b.0 Ethernet controller [0200]: Advanced Micro Devices, Inc. [AMD] 79c970 [PCnet32 LANCE] [1022:2000] (rev 43)
	Kernel driver in use: pcnet32
# head -4 < /proc/cpuinfo
system type		: MIPS Malta
machine			: mti,malta
processor		: 0
cpu model		: MIPS 74Kc V4.12  FPU V0.0
# 

It's the netboot device for this platform, it has to work.

 Please stop spreading FUD then.

  Maciej
