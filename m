Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AD0339365;
	Wed,  7 Oct 2026 01:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791335412; cv=none; b=nDScuOHyFofnR2OSSuEIQReMkeKkw0ZkQbrnr9jHETjSmgQtJI+Q3mExc/p5pstdJcDwYjsFhCOjYcEd36MNv0U7/eqyTxLgN840FUAJ9G9NgQzzkrelh57UoLOXevIAYvUwMbM+jfFJXIKWwVw1jNI0ULDLegJg391DY+znYNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791335412; c=relaxed/simple;
	bh=XPB4Bef5mEDoL3CPpGYEZuWSAZzO//y5yoTnCnXiseo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8PZyou9ToaSSZGvY6OTLkOpCTE0z186gGjwJwcbSRkgHfAKIvQLuk8TWGE0CK7S2X3CoG8kH/ieABlUY7CKsCpWxx9KNG+A/Ncxm2H07YhsylSYAHovI58Tb+eU8vywgRQ38x5qf+YCZAERjjVPenSN5IO7WAweGHjgANDA8d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLi7npim; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLi7npim"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD081F0089C;
	Wed,  7 Oct 2026 01:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791335411;
	bh=74b5fbEAIa4ZR39VRG/iTMgUBsDcbZMPv3K1PI+Hn7U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BLi7npim/kWoNScJTpdEj/6A8XXQf8BBwBlw6fcB0DfulqlB4/q+zve7r3B43deuX
	 m2fhWv8JRuXxAGIlmg5y/EUHPjobvbLI/iP9FhK3rLKKqzRbpXeNgFLiwx20KmjXUe
	 5vaqZBGk0+TLEMsyPDVFbLSrLMN2Zkjy4vQqguvn+u/WwPIlIfsKHAJ35yvmDXeeMa
	 B49GJx7afCkW8I+MAZoQ04NVA4TcrLDDFQOXkLscFuAq9AQQU1zvUD4B1rRCuWdv8H
	 HDsG8sG69N7Zq9Rl0QUdnoO49dZU1XEr3kb3WqfnhsoxS3afImILWtBRBmKOlcrlPS
	 jzTI8vThUNdNw==
Date: Tue, 6 Oct 2026 18:10:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Serge Semin <fancer.lancer@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Nicolai Buchwitz <nb@tipi-net.de>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: unwind the WoL IRQ after a safety
 IRQ request failure
Message-ID: <20261006181009.5c4fe5b5@kernel.org>
In-Reply-To: <CADvTj4obBNgR4w3BW4-gCU-=LUxesQdTRN=EdWTcx7VznFi4kA@mail.gmail.com>
References: <20261006-stmmac-irq-unwind-v2-1-194591c87460@gmail.com>
	<179127056620.2231598.8882282421523696709@kernel.org>
	<CADvTj4orth=RYtb78ND1rdiYh2yb6d+TjZt5ohK_-+1mnVpqfQ@mail.gmail.com>
	<20261006155214.63c5cb5b@kernel.org>
	<CADvTj4obBNgR4w3BW4-gCU-=LUxesQdTRN=EdWTcx7VznFi4kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Oct 2026 17:17:20 -0600 James Hilliard wrote:
> > Please make sure you read this paragraph, to the end.  
> 
> How much detail should I be including? I had previously been told to try
> and keep commit message more terse[0] and this info didn't seem particularly
> useful.

Not sure how to answer this. Just think for a second -
if the information was not particularly useful, would we be asking 
for it over and over?

> Should I put this info below the --- separator so it doesn't end up in the
> final commit or something like that?

In the commit message, please, it will also be very useful
to people backporting from upstream to various downstream kernels.
