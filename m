Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B604A397343;
	Wed, 26 Aug 2026 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768918; cv=none; b=rfXxLqi7qPi2W5rpDkPsp0zUCFcTDbwQWoYB/NlsJdQaDdVTpMyCVIIezjgxBwoNkyoesuUdRzMf4NBhkN4wCwq3ulqNJdwGE/kHHH3rUSwZT3ik3/jDp3/0rBZHXfXRf8f1NUaYQad39lLNeG5Nvvc5g88oyF+MKZnA48/SX7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768918; c=relaxed/simple;
	bh=A0ymosu6mYwVP/TskPaLTOXJ3vp1mkV/Uk4tHLtAyEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVvEiUXlKxFKauOrbSKoTqvO6oefbXcBruNTsMx00UHZG22SJyO2ZCGHQp3+DpEBzYN5il3X6AwNmivHjnh8BRVfxARziQMchzxI7SgxzNX0Q0Y0xalBzu4rOIl1uAPAePMSo5eNCc7LF/pv6gFJw6dpp2KMFle6/uS3/SqLu2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bPoEI2E4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bPoEI2E4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rlXEgBPszyMY13F08Sg/qicoNcVit6PBydQLjeJitBk=; b=bPoEI2E472DYXjOwIBw/zBJgke
	wbmq0/6wYSfu7wHWw6xPnpqUZ41Pm4mo4QSY2My0uwT65q8VzdfEtqN0ydW9j3B98Tz6raNLM71vk
	jb11YPjm+2BiXRDz5D0NKwpu1rSTL66f4RJc6btZ8Wr3UOvBsf9/S+a/kPCzEAdopfTo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzIM9-001YoB-3T; Wed, 26 Aug 2026 20:28:13 +0200
Date: Wed, 26 Aug 2026 20:28:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Minda Chen <minda.chen@starfivetech.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net 6/6] net: stmmac: selftests: Don't test flow control
 for small rx fifos
Message-ID: <5ac1be4c-34a2-4917-bd82-00044ab60af4@lunn.ch>
References: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
 <20260826140500.616466-7-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826140500.616466-7-maxime.chevallier@bootlin.com>

On Wed, Aug 26, 2026 at 04:04:58PM +0200, Maxime Chevallier wrote:
> On dwmac1000, dwmac4 and dwxgmac, we only emit pause frames if there's
> at least 4096 bytes in each queue's fifo.
> 
> The phylink mac capabilities are still MAC_ASYM_PAUSE | MAC_SYM_PAUSE as
> otherwise we won't be able to negotiate 'rx on' pause. ASYM only will
> prevent negotiating 'rx off tx on', while SYM only doesn't really
> matche the reality (not symmetric if we can only do RX pause).
> 
> Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
