Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842013E1D08
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587864; cv=none; b=fkOEN10q413SmnhbeiDMUv9t1foay1zTYJObkbTFMq+2yiVPnwUFpt9unomAhTUD77H4NCrBGZijj0MIgdtlAaSPUfmZauxgvfx2byOQUHMmG1053R8cP8eGbE9cjchI36PkiLzqYDl+TlBsBR+TP60RCn+UYxJM+MSx2kifJQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587864; c=relaxed/simple;
	bh=FrEfntmov+qQYXmwQeVp3dUpPvqE/1AIuY8xpE0ovqc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KfU3sAF7usY6JycZI91NuoRN4DGHw7eRB0rX21rB1cS/FWH72uwncYifJw7jDIyt6AftnsHWFG/Mk/HhraNwNqVTA/ZcfNBq6H4fN4bRlNmOt54o9JT8nx0mZbrGKYCUJ5WDxUY+d4KVaZR8NbdVDNYEMFEyYA1eHgEJv+mds+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=Rda9eMxH; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=emUJ4cpq; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="Rda9eMxH";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="emUJ4cpq"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 67OGAWtw011285;
	Mon, 24 Aug 2026 18:10:38 +0200
Received: from lubuntu-18.04 (host-80-183-189-234.business.telecomitalia.it [80.183.189.234])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 6C2E41200C8;
	Mon, 24 Aug 2026 18:10:27 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1787587828; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFXlZN8zHF3Fzl0G8SrGyFYEvW2MP+6LQ6StNQzwJ6k=;
	b=Rda9eMxHDhogBf1nFZvzUNuiJjGmcuj1g+WR0gSvw5e36vIa9EBLVq/Ng0rQgJ+c+uIWRc
	Okke7yRpaBfwgaDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1787587828; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFXlZN8zHF3Fzl0G8SrGyFYEvW2MP+6LQ6StNQzwJ6k=;
	b=emUJ4cpqjQEXJ1QnwpT0ixdUrU1XRNVQy5rHETON5Tat3/PpoPXlncMc28q7ym8DXKhXq+
	xgOg53rODBK2xb3jfTUheO7Elu7kXEu94XzBRrrhSLsJCd5vzsw+dSpKatVlePoVC47pQK
	Q0yD+kHBW9p8h5oVt1z8fD+JoLDfxiBvH0rDkuumRZmMsxYx8D/6Z1gFS+rjlzhdRa9ahv
	QzwL2ImC9otaND4JH3awtd6ZLs5Oav5OfnWksM1YUGG8wa6tomVUTNN6BVUPSO8vSjSoqY
	dmcLX7dRJmaMZ/iMihYUKP9o3AJdDvzLErkeeWmzxWIdLL/ncZFSAwCNcxv6DA==
Date: Mon, 24 Aug 2026 18:10:26 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, david.lebrun@uclouvain.be, vega@nebusec.ai,
        zhilinz@nebusec.ai, stefano.salsano@uniroma2.it,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v2 1/1] seg6: reset IP6CB after IPv6 decapsulation
Message-Id: <20260824181026.83a27650269be8b6d06878fd@uniroma2.it>
In-Reply-To: <83541e78b0eb0d5adc169a318a51e3055f6bf820.1787388261.git.zhilinz@nebusec.ai>
References: <cover.1787388261.git.zhilinz@nebusec.ai>
	<83541e78b0eb0d5adc169a318a51e3055f6bf820.1787388261.git.zhilinz@nebusec.ai>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Sat, 22 Aug 2026 16:49:27 +0800
Zhiling.Zou.zhilinz@nebusec.ai wrote:

> From: Zhiling Zou <zhilinz@nebusec.ai>
> [snip]
> ---
> changes in v2:
> [snip]
> - v1 Link: https://lore.kernel.org/all/6a236dcc43d141a9105e8ee1b84bcccc628d83b0.1786894895.git.zhilinz@nebusec.ai/

Forgot to mention this in my previous mail.

The v1 Link in the changelog points at a message-id I cannot find.
The correct one is at:

  https://lore.kernel.org/all/cb0b571546147162dd63bd3a93952144734b1503.1786896221.git.zhilinz@nebusec.ai/

Thanks,
Andrea
