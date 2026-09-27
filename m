Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B683DD879;
	Sun, 27 Sep 2026 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790532405; cv=none; b=Q9mz99Xu3/BxkLYA2vlNerJfHAo0jBLl62/FRjjkcIFoTRYEK83RsXQfv9xOLW8TExgQs7pSq99Ix1BO0Op783Ik2hoIwQz8DUzMWQEL8Ljs6q0DPl9g5GqsoIBdhF/mWknVAF0nIcpW3vUQtLxVQZnFI7GdBEjWC/fPqCPve3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790532405; c=relaxed/simple;
	bh=D77+YxAIXks1O7FygbC0na83/yYgCKW9ueZrfQEjkQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTTxpASPXfzCss8eFLfBCbjj33HYy0e1c1+e5kFXZd5B+AwYFBrnomM4gPNlTG4LYxa5H8gLnxFIoDTdcj7tSCt9RVYlsjimMsfcV5p7G4h895PdELr/m3q9CcgWhTL1/KK7+A9jRSl1ZiNDGQn/fMe4U17aMgxSiKBCM/2y6/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF0P6tTs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF0P6tTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896241F000FF;
	Sun, 27 Sep 2026 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790532403;
	bh=6XEoCOiEHSF66Tl36XozdroZPLAJ+sF9zsLneNYmRCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SF0P6tTscRw/xse4NZsRmcE0+XRrIguAUwdAlc2M7cQYDKKuDz7fI7K1x16wUjYzv
	 sbKVLwmEcN55ZBNFi1iI9LRbaE/0GWphRfSFq1D1Izs+ppcmPDlmkr79i50uNbvEZs
	 lBGaZbyZ0ajSJMcbPgOqgHt0LE9jciMyqnZxjxRQbQjZQqMuC/tRPUIV51jSWjy10z
	 TXu+PiScqIDCEzsqXSrH2EmX3+U6pwqp6KAlUgd9BepoKpd6hevIPG1+Yt080JaI22
	 5C5BtKtXO5gsZ3lp8BwM7a6yKxZaFj/AlvZ3WH+3hLuUAfRE7vtkDuB8K7i4RMZ8MZ
	 yjJCn647PNBVA==
Date: Sun, 27 Sep 2026 20:06:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	LABBE Corentin <clabbe.montjoie@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/3] dt-bindings: net: allwinner: add H616
 EMAC1
Message-ID: <20260927-amazing-loris-of-criticism-bfb38b@quoll>
References: <20260921-submit-h616-emac1-v1-v5-0-ada661ed9e9b@gmail.com>
 <20260921-submit-h616-emac1-v1-v5-2-ada661ed9e9b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-submit-h616-emac1-v1-v5-2-ada661ed9e9b@gmail.com>

On Mon, Sep 21, 2026 at 06:45:25PM -0600, James Hilliard wrote:
> The H616 secondary EMAC uses a separate system-control clock register
> and supports only RMII at 10/100 Mbps. Add its distinct compatible
> without an older fallback, since using the primary EMAC clock register
> would not work.
> 
> Constrain the PHY interface mode to RMII, matching the hardware.
> 
> Reviewed-by: Alastair D'Silva <alastair@d-silva.org>
> Tested-by: Alastair D'Silva <alastair@d-silva.org>

Tested-by is not applicable here, please drop. Don't blindly apply cover
letter tags.

With this corrected (and assuming Alastair actually did review the
binding... otherwise just don't use blanket cover letter tags):

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

