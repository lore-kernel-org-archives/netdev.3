Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BED21CC64;
	Thu, 12 Feb 2026 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770908554; cv=none; b=IsAnwHCS+c/O7b6XHXnwgY1N4TEIyhuBKg/IogHfaSONt10X86ZmeOWxhoVZMqeLzGuUEBmPEAB3bbfwD/uEzZlpaQQhaR66Ve0/Yi8deou18gRcusxfgtZQLuV4soNVCYhYM/22iaMgWC54WtoT7vHuz5qItPs/KqOLtzPuVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770908554; c=relaxed/simple;
	bh=EMoDt1IiNsxkfqiKjCS0UPDXsAwhArjBJsUXQW8L6vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUuiFWyEeE7FLzldYCFAconaOwS6R0L193rPwt/I5oKKbl/dilG4jXT+xBzMB7R9NTyIsrhq1adhoHS0wpYi/qHePT/F7NojbaSYhVSxZxzmd2xaDO03lPtBUOhelzVvZDAzZC2WNsj//bsigKLz6WIAsLXsb85xyCy3gHbY4aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8c/L0BI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8c/L0BI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40583C16AAE;
	Thu, 12 Feb 2026 15:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770908554;
	bh=EMoDt1IiNsxkfqiKjCS0UPDXsAwhArjBJsUXQW8L6vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a8c/L0BIsS1ke73oi1t0EZDfo8QIdqzaWM1nV6ZIXWZo4QozN3QbT5uEy1EJD7u7A
	 QBTKui+slf0xBu+H+MX4RoqXlZszimHjTb5mMVMOYtiPyVGJTFaESsJRsw6l9tAT/A
	 o/OgjaamyEel2Y/CzJe/jzF+dVuxk2tERpFjnN79tqJh0XnnUdhqs1T/UlcOlr1Gi5
	 e6EmvI4kB6DjBn2PBNGn/nQl6ckZMiZW/uInyowUIrokv8hyve8Uwd8uSiUVtSWFpg
	 DiSFsEL1fUaTCEI1UDHaCp6Fc6Gh9jibLwhz+Nx4Qf2AagRMaudOMmd04Y4Fu/vnAO
	 vNSBHUAQZIqAA==
Date: Thu, 12 Feb 2026 15:02:30 +0000
From: Simon Horman <horms@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Zheyu Ma <zheyuma97@gmail.com>
Subject: Re: [PATCH net-next] net: arcnet: com20020-pci: fix support for
 2.5Mbit cards
Message-ID: <aY3rhuzCG-SdRrC2@horms.kernel.org>
References: <20260205065113.33547-1-enelsonmoore@gmail.com>
 <aYoAMrEVDNydXQdq@horms.kernel.org>
 <CADkSEUjdGka7vpZEKrF0a0R1S=S+bzjCpDRidF5d93_H7b2qtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkSEUjdGka7vpZEKrF0a0R1S=S+bzjCpDRidF5d93_H7b2qtw@mail.gmail.com>

On Mon, Feb 09, 2026 at 01:58:38PM -0800, Ethan Nelson-Moore wrote:
> Hi, Simon,
> 
> On Mon, Feb 9, 2026 at 7:41 AM Simon Horman <horms@kernel.org> wrote:
> > I do wonder if this should be targeted at net rather than net-next.
> Should I send a new version redone against net, or will this be taken
> care of by a maintainer?

I'm unsure.
But at this point - a few days have past - I'd lean towards reposting for net.
