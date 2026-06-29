Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF53CA4A0;
	Mon, 29 Jun 2026 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782773071; cv=none; b=juFZZCYOU7b7px+PghOXXZviu3VhbnlV7S4nK3Vf7vN9hEAMH1en5dErXSVuL41ot0CgYJXpa2HM087v2nM6HC+1yJYWSZWrfFqDhsEH94EEU/F0Me3ecphum3GjgPG53jal6QaJxsKPXNmxlJcZtNXaXyYlKMfxgxJqrcjEuzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782773071; c=relaxed/simple;
	bh=CwjX/tWoY0+eFeZZ9KWqp1glp6cgktwbVG45cb6bUZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMNDL2x996oAyz1OZBZ+HSwCMVmuXuJPL/7pR8WXVV5608cC2LPCUN/dhJ1boe1V18obh4GdKT/G+uDv8afecdoWkrPdAb+vGFVfe9uxkvG9jI0waseDAUHFA9CTnLMXZ8m62JMNWx+aBoDe5AHASf8MTsG8Kg1V5cZJxEC5EH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbYC2Vnn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbYC2Vnn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BE11F000E9;
	Mon, 29 Jun 2026 22:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782773070;
	bh=OefiiQrvn89AQEAbF+kGS4kS8/GJWqFI5ZJnOSdsCfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cbYC2Vnnv7l9+B93g8prUprSTItivhvehfcNo7h4yJojxc8YAGLbFVEfMv+867yA2
	 lFoRW8k6l7C0I2B2JWDecjIf5XFf1qf20eXIgZDp251xA+jMWYTdnhqRQLvovs2Slm
	 FntTrmYH7+zCd6HNiWFdhcC1sdMzrXXoN1fuj3WmTbsxR3D8wwcYsJjtRl/WYRxJvg
	 W1nPaYY831mp4nzjO36nYMJYDW3Kd6B92L9msYtOiM9mFUNPwRGiJqr4PJByi7FIUB
	 BINLFLwGUdyTd6cKhxDNTgkftEvyMsG2SbruT95sU2yhmgakK1f7QNnuKxeEko8C/v
	 shx3XoJe6paXQ==
Date: Mon, 29 Jun 2026 15:44:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: fix missed le32_to_cpu()
Message-ID: <20260629154429.11fb5a49@kernel.org>
In-Reply-To: <74e05f3d-39a6-4a4c-8bc3-d4f23a54ef69@codethink.co.uk>
References: <20260622143707.497198-1-ben.dooks@codethink.co.uk>
	<b375d36c-112e-4662-b538-fd10fa927ecc@bootlin.com>
	<20260624192205.4485cd61@kernel.org>
	<2a92fd9d-42b3-4564-b784-ec504d4d82b8@bootlin.com>
	<74e05f3d-39a6-4a4c-8bc3-d4f23a54ef69@codethink.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 12:11:08 +0100 Ben Dooks wrote:
> On 25/06/2026 08:07, Maxime Chevallier wrote:
> > Ben, what's this "prototype" sparse ? a custom tool of yours that
> > you used to find that ?  
> 
> I have an RFC to add variadic and thus also printf/scanf formatting
> to sparse. This is waiting on review after the original got re-worked
> to add scanf and a few other bug-fixed and shuffles.
> 
> Ref: https://marc.info/?l=linux-sparse&m=178185274600679&w=2

Ah, makes sense. This most definitely need to be part of the commit
message.
