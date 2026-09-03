Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A63A49DB94;
	Thu,  3 Sep 2026 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443297; cv=none; b=qLLbnOsHMI3/Kw65AEQTOBl0xz5u5Xtb64eU2rVjhdkJswOOsaT1GzLZngmjWNfll6N/j1ZMQKg5SU1bx0uwbEqhInt/Yur3Orz7Tr0nbSqNR5Su9NU9jD06aqTFdq/X2qq0Erm46/dhPakhvFAmApmjB6vzs0J7ehf8TSVFLww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443297; c=relaxed/simple;
	bh=1J/kC4Ihy2eG6s5M9mZicW8c6cc8GKwz1L+YwrAlmH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJrAAjirtdRNjW0ZaWv7UbUTUFFM+K6q+qSR12YKwSTr+kXLhY72VaOsHh9iJ/xgbRu+fv9G56BNalMNrDJxnZqARvg0cRBKpktBJO7u3vBykgI9QxgqrKFYcUwNCN6q/saQCbHer7BRa0G+xqkECmmvAziYuh9fQZfCMSMm5Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NghgxCIe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NghgxCIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1007A1F00ADB;
	Thu,  3 Sep 2026 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788443274;
	bh=bjxQon8BXhX+sOSPB9cNCMo6pqyNPDASmF8A4lzjpwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NghgxCIe0VTmb2qdsstXtkNah6akSHRy+WH4H4JGQyKT35Y1M4TW/I2JL5Q2EGrLU
	 7Ah31nOAefVJAVP3sOOODkg850vdKZPGo00EQ773DC4DE3QPpyYXFFJyoL3BZgEGnZ
	 ks21dLZqYPZXpm05PCDkMhXLerZfG372zCVcUzELMhS6mCPF1tA932LOjB0ETF2IEI
	 zk7KrCk7ZU8vIYasLCJRjWGWlvI6YHA+U25rWHtuf5u33QpyV1AXIvHdLHw/TkoEBD
	 /enk3yFkXpPDst/4BKOvZ+SF7mJj0+7c30lL4J6uyVBKtd0bqbf80CBwRCOWBAf1oS
	 c+pDemEd9xNMw==
Date: Thu, 3 Sep 2026 15:47:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kristian Brox <isyourbrainfoss@proton.me>
Cc: David Heidelberg <david@ixit.cz>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: net: nfc: add st,st21nfcd
Message-ID: <20260903-inescapable-discerning-ibis-fcfdde@quoll>
References: <20260902-fp5-st21nfcd-v4-v4-0-ded2f1c501be@proton.me>
 <20260902-fp5-st21nfcd-v4-v4-1-ded2f1c501be@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902-fp5-st21nfcd-v4-v4-1-ded2f1c501be@proton.me>

On Wed, Sep 02, 2026 at 09:22:18PM +0000, Kristian Brox wrote:
> Add a compatible for the ST ST21NFCD NFC controller. Document optional
> SYS_CLK (clocks) and VPS_IO (vdd-io-supply).
> 
> ST21NFCD is not I2C-only; the ST data brief lists I2C and SPI.
> Split the spi-max-frequency if/else: forbid it for
> st,st21nfcb-i2c and st,st21nfcc-i2c, require it for st,st21nfcb-spi,
> and leave it optional for st,st21nfcd. Add clocks and vdd-io-supply to
> the existing st,st21nfcb-i2c example instead of a second I2C example.
> 
> Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
> ---
>  .../devicetree/bindings/net/nfc/st,st-nci.yaml     | 49 +++++++++++++++-------
>  1 file changed, 35 insertions(+), 14 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

