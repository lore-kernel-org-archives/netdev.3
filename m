Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AA6303CA0;
	Thu, 12 Mar 2026 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773301818; cv=none; b=hvjUuoEckeqtpJvaN6nf/suUt+pEu7NdlhfuRxtS+cqEOhPTLKinvGWmy+jPmpkh6YezkQMi39dMfzfy1fUEB8jeqfd8U3U/zumnECoc35lT7X9SvxLh5WaX2z5e05pvr+MA4pmx8h25qk1Kox6hqyrRVAHmYe0e76/k6rtamto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773301818; c=relaxed/simple;
	bh=G9iOh8MH53BV8yifyGIrscGOuqRgXXDAZ+PHM0PPFrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNE7VOM1RAg6W6bo+3ucTGim4GKJFDSUn87oMlVoJMTJ6Sz3YEKluEdco+3ezIcCITyqlKGj3YYcNbmpgETUeF2V6eA1yISAyTMnWv5vJcgSH+75ioQIYzlNwq9omb4lvCgYoPqcWwgaiiNWDEfhl4whO8mCbWw7p0AwLZ+zJDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 021B71A0542;
	Thu, 12 Mar 2026 08:50:16 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DE62A1A06DE;
	Thu, 12 Mar 2026 08:50:15 +0100 (CET)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id AF65E20263;
	Thu, 12 Mar 2026 08:50:15 +0100 (CET)
Date: Thu, 12 Mar 2026 08:50:15 +0100
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	rmk+kernel@armlinux.org.uk, vladimir.oltean@nxp.com,
	boon.khai.ng@altera.com
Subject: Re: [PATCH v8 1/5] net: stmmac: Use helper macro for loop over
 queue-based arrays
Message-ID: <abJwN5bulKxQpI+K@lsv051416.swis.nl-cdc01.nxp.com>
References: <20260309-dwmac_multi_irq-v8-0-f0cc5bc811a7@oss.nxp.com>
 <20260309-dwmac_multi_irq-v8-1-f0cc5bc811a7@oss.nxp.com>
 <20260311203707.1d5ba94c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311203707.1d5ba94c@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP

On Wed, Mar 11, 2026 at 08:37:07PM -0700, Jakub Kicinski wrote:
> On Mon, 09 Mar 2026 18:55:20 +0100 Jan Petrous via B4 Relay wrote:
> > The stmmac driver contains similar pattern for processing queue-based
> > arrays, ie. interrupt lines, etc. Factor out the for loop and provide
> > a macro STMMAC_FOREACH_MTL_QUEUE(var, limit).
> 
> This is macro is neither shorter nor more readable.
> I really don't see any benefit here..

TBH me neither. Or, I see only "descriptive" benefit, what, of course,
is nothing must-to-have.

I will prepare v11 without this.

Thanks.
/Jan
