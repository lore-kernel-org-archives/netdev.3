Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE11242D88;
	Sat, 18 Jul 2026 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784383905; cv=none; b=OPCWWg0Pm53RCycRjy1nIFMEHpnN1MdJFo75xL/xJGUznjQm7q/uF7LYM1LSgOGVp3lyk66jI9NVsBYluloH826oeYem1NXoIqARBBPTqvcVbOmZbyOKKGgDWVkP+Bs7au44Mya8rCvKxNLNsVtSGzm1FCKGkbgP+/itxJfwsIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784383905; c=relaxed/simple;
	bh=zcl9LKq8pjhBh4RrRGyYK5ctdqdeFIv13OkEhSMRo18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8cUxHscLa7V7ET47XSSDVF2Tr9obfwZ83XKf8CEKaoa3ZGZiB98e5zmnrdT1wy1oh4GlrMFKh9JDHF0VFZKNHfX9/aNTg+2SOLp+wUaLsvOXaOat0w2HF8P3Yj4ZgV+uAynL++rn3Kwtahyz8sCmt0/xb+gu4TeaRD/LqXcLjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xWpzv42w; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xWpzv42w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2pwakpXnKK3TWqol+7rA8TT2J1dLUNUKBR7V6X6RgX0=; b=xWpzv42wTclDI5T44ap4bG3z9r
	Td04QSugNUSAqFZm+2l4GwmwS4Aj0qTPq0YZkkaEPCSkXCC8J3vRQISeWQaisHZ6O7/NvQDERVho6
	jwzG/NuFhLsXJkZk4XeEHi3llOn/VtMtY89VHlCC3+VJwxkhkc1xGcduT4ZizKfZpfrU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wl5lU-00Cx1n-DE; Sat, 18 Jul 2026 16:11:40 +0200
Date: Sat, 18 Jul 2026 16:11:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: tresonic <tresonic@mail.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, regressions@lists.linux.dev,
	rmk+kernel@armlinux.org.uk, kuba@kernel.org
Subject: Re: [REGRESSION][BISECTED] stmmac: suspend hangs since 1b9707e6f1a9
 ("net: stmmac: enable RPS and RBU interrupts")
Message-ID: <36957839-b03a-4403-b08e-12bbadd8bc0c@lunn.ch>
References: <7941d239-e5f5-43b5-ae0f-20398221e027@mail.de>
 <17ebe5ba-16a5-4b3a-94cd-e9707c88df3e@lunn.ch>
 <72b91ec7-202c-4301-bcd8-b818cf8d72a0@mail.de>
 <21068662-c44b-4266-b634-24e5eac8cd96@lunn.ch>
 <8f6aca6d-6619-401c-bed7-8d42732d166a@mail.de>
 <09ee8651-4f29-4ae0-8e82-a32a1f7ad04a@lunn.ch>
 <97d803a5-ca6e-4d4a-adc2-f97cabfded65@mail.de>
 <46e90a47-4507-40fe-b74e-efef932e9b62@bootlin.com>
 <54128253-eb77-48f5-a673-94fb65edb78f@mail.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54128253-eb77-48f5-a673-94fb65edb78f@mail.de>

> Sorry for the noob question, how would I submit this fix?

There are two documents for you to read:

https://docs.kernel.org/process/submitting-patches.html

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Since this is a fix, please use the net tree. And include a Fixes: tag
indicating the patch which broke it.

> Just commit and separately git send-email to netdev@vger.kernel.org?

./scripts/get_maintainer.pl will give you a list of email addresses.

Or take a look at

https://b4.docs.kernel.org/en/latest/contributor/prep.html

b4 automates some of the steps in producing patches, keeping track of
versions, working out who to send to etc.

Often with the kernel, the code is easy. Getting the processes correct
is harder. But we are here to help.

	  Andrew
