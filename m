Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8CE392C32;
	Tue, 10 Mar 2026 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168702; cv=none; b=c0TV3B4+EspUDE3TNCBOhn8DUJRMNfAkP3zgykm4RpKWHD44Icji5DBrMtXVj5Z6Vl0+4LisVeyIWKzUBqifgsxkKCX0c1N2OrCYKhALEw0K6Hc7nwBoVuzIBWSD5cYszGSOvAa+F7J5UsL1u23twCrLhei6WQ1Jaky6RQTKa+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168702; c=relaxed/simple;
	bh=A5wTxPE5SrPOdJv/iNzGPpISq+CsXMntNU7YgGpAN4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xb8dGDOjwwkgmfZY4usdbXwQ2zVskNdDxHEw+FyhTXGWtH/K8jJWk+6yusi1WNLPWAFKJA6jVuIxS+2FN5cnZlFVz0Ng51PtnFmETiZ6sGR4VXAlHddoEaEcQaGOQacltppdgNOXcpaN99SEC6prwavEYxxfpbvCaMTcfDeQoQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CscYQbV4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CscYQbV4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Qt+Ic0gPMVCjU2aXhV6UJ1ki5JCMs1V1BvKY+5Uz38I=; b=CscYQbV4+BLIXI4dIPpx1Wfmff
	h7IrNMeUpeYdyaNsuWSzDCp8Tm2b84OwEakGdFzibsp8COGKfiQ5CMtrWI9jEhxPkIGPbcSRYMRFV
	qhrJtqveeYPUj0dNVhW4fB9NTxWdvlSBksuKIm2C4qV+V1SF//yNTz0lCWtsRTpsQXes=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w02Ad-00B4WB-KO; Tue, 10 Mar 2026 19:51:07 +0100
Date: Tue, 10 Mar 2026 19:51:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: bgmac: use pm_ptr() to clean up PM code
Message-ID: <d4e69dc2-fb7d-4bd6-8101-974b132fdf94@lunn.ch>
References: <20260310072637.739541-1-pengpeng.hou@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310072637.739541-1-pengpeng.hou@isrc.iscas.ac.cn>

> As you suggested, I've swapped the #ifdef guards for pm_ptr() and
> marked the platform wrappers with __maybe_unused. This way, the compiler
> always sees the code, but the linker will still toss it out if power
> management isn't being used.

Think about that some more. If the compiler always sees the code, and
then throws it out at the optimizer stage, why do you need
__maybe_unused?

Do you try building this without the __maybe_unused.? Did you look at
other examples of pm_ptr()? Do they also have __maybe_used?

      Andrew
