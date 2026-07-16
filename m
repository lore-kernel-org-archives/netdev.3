Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF30B3BE647;
	Thu, 16 Jul 2026 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188742; cv=none; b=rp7x5z7cu0ZfycxFZjVSc6YkrPk8zyY/pDAfFNz3IG+G7SjtT8Z2Ia1PGv9ko6uxNCZcqQjOw4Xu/Eb06HODfw3P0+bTlmJSnRWZ+j6Ss4zpnBP8Go06psI7Z87hGpmwcpWcC807IfUL4Owwoao/waJcGqCx21xgmNJ0sznOTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188742; c=relaxed/simple;
	bh=xzq5N5RNqroeNZva+Vj07hm294xE/Hd5pBwCdNQFYFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1oEDN5NQKK5sLv7oteHheDmjN7uhLig7eDZV8JtS0xlOQ+jHk0SjDtUo793fl8MXJ8nTgcVt6/Bkn1l5PbSsMpzV6b/hzFwxm2FPhBZZTzuRcaebdIPQ2euuV63oETnnAnptWFK7pYF9DE8YhikJeR29o+OqkWsQ5ArjdjiVD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3+2Dbel; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3+2Dbel"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25E21F000E9;
	Thu, 16 Jul 2026 07:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188741;
	bh=t0MLUzu4/38/rnGJWlGUx8+09X/UZJgiNMjr2bABd+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a3+2Dbelza/k2TLM3XoF5e9KFenkg4LEg6+mY40znphC2+LfGks8VxxltmEbEE0DV
	 ROrNX0AYnzCCL8PmAqF439DkOII0i9xS0jdvKqmnL3Mk5WUjY0DVwg7k+EkW5Hjyj2
	 OF4ejYshlmcUQf3nVcBMnVNdigTka4+gom0w9FUoegGvhlcTyTRz7uhlm0o3fEr/Is
	 JvI1tCmH2Yo79eBCF+u8tMfU6VyP21UX4rgUC9e0Jdhtl/flB+RDF9rKRvxEOKLsLp
	 GdMHSXfkqxopCDS4vzcUybGjNunNOs7SdxSCLNeC+BuKrY7O9aRf2bF4F+I9qJ1hiK
	 XUL1F6QnnPrkA==
Date: Thu, 16 Jul 2026 09:58:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: dinguyen@kernel.org, maxime.chevallier@bootlin.com, 
	rmk+kernel@armlinux.org.uk, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: net: altr,socfpga-stmmac: Add
 altr,socfpga-stmmac-agilex5-tsn compatible
Message-ID: <20260716-turtle-of-massive-thunder-be8283@quoll>
References: <20260716021932.20037-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260716021932.20037-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716021932.20037-4-muhammad.nazim.amirul.nazle.asmade@altera.com>

On Wed, Jul 15, 2026 at 07:19:31PM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> The Agilex5 SoCDK TSN Config2 board uses a GMII-to-RGMII converter
> implemented as FPGA soft IP between gmac1 and its PHY. This converter
> provides the RGMII TX/RX clock delays. Document a new compatible string
> for this MAC variant so the driver can detect it and configure the
> interface accordingly.

Last sentence is completely redundant. You are not supposed to reference
drivers here. I even EXPLICITLY marked this with BOLD font (as a common
mistake) in DTS101 speech.

Explain why devices are or are not compatible. You claim they are
compatible, but driver still treats them partially incompatible.

Best regards,
Krzysztof

