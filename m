Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481257;
	b=pv1YzTcKBMsG6Wn97hDfjYQPcqqLIr1N/+rvKYvtTlrZqWquDdXxuemkTZPoS881x0mh
	 fna7FQkPGDKU/Z4IkANJWCbccMWarDIDqrLDTVWsFtgXPP8UrsL0bjQP5f4trxuxUXyBi
	 6oqufYF1HA/7MwAuVAccgm5/iTfDP8oNUa/z1okjzUnl9d/CqwNOIdJV0c+rENO6KBoFp
	 1h00LwjRTWTN5L3zAPsPAW8GcUZa5Bnf4vS9bX09e1B9psbjkQGrvbuHmRHj0GG6f8m4i
	 3vlknKnKqUjLtuhVr1ZwA9MHu/Z6wPX2eBTUEpyUKwPKMUkbusU7/8zc5XFwBVDzaHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481257;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=L15bPl1z+TmuF5jLbulKy1ru9ueDI4BOgxdDiM49enM=;
	b=0nuPH1NVvT1wUSSRuJj0BFxXO4zYBfKMdoDp3FyaC93UT4DG4KKG6IaLL1hFMur1GOJP
	 2JkB5KleMPIWOjbEfdhyy7VUi1GSJcnLpdqqq10AZTkFOSutr/EGZWwl317IfnYd0GvhR
	 q59vD2VukbVkBWDVmxG/m3RBaJ7wJX/VGaUK7TEDgvHADyAg87ewa4V8HAO6Etg2y1BU7
	 ifpDATXFYYPU+eEVyvI+/BSkztoLGUPjpWdDoL8ixURkFhDd87IXsRTBSfSEhg9AyTUHX
	 WETjxpPM4kH9LtZy9lUG0r3TW/Ydlg3vJaRb4HbHI3Ahh+2m2Ddty9qAGJMSzWdtuWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HG93I0MV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51684606A33B;
	Thu, 12 Nov 2026 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HG93I0MV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2211F00A05;
	Thu, 12 Nov 2026 11:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794481257;
	bh=L15bPl1z+TmuF5jLbulKy1ru9ueDI4BOgxdDiM49enM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HG93I0MVe39n3RDSb7W8ehFki5M1rlw8aRYeBdvPEVB0a1nl7/qMXCIgzNC+4VyXQ
	 TfpgiVDWNJSYXsGx4LS5/NUKA4RLAf19EcR4qAAF6GdhXaoUbzwXlBjQfK1h5OevQS
	 WnO0+bQpoQcMkPJ5N0DF9betT39K6qBIx/Z3HjlasETY+0EUmCeBYPJ3jqYiMNSxVP
	 1da/N7mPXrVVf1Eh6TpSfc9525/WPsyVVMs0ftgLXokZ/ENbh2Z2c/RtHYS4EzpY1E
	 vo/xlnLUztiZLQm2RRu5t73YgYu5OC3yjKEv/oRAGTMpQn/wl9Ub84G4jVZ5YO5qJQ
	 wX6Ntfz/8gnNQ==
Date: Thu, 12 Nov 2026 12:00:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Asdlerto Korry <korryasdlerto@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	David Heidelberg <david@ixit.cz>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, oe-linux-nfc@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: qcom: Add Samsung Galaxy M52 5G
Message-ID: <20261112-tough-sparkling-raven-bf33fb@quoll>
References: <20261111-m52xq-dts-v2-0-063289405882@gmail.com>
 <20261111-m52xq-dts-v2-1-063289405882@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111-m52xq-dts-v2-1-063289405882@gmail.com>

On Wed, Nov 11, 2026 at 05:07:45PM +0200, Asdlerto Korry wrote:
> Document the Samsung Galaxy M52 5G (samsung,m52xq) smartphone, which is
> based on the Qualcomm SM7325 SoC.
> 
> Signed-off-by: Asdlerto Korry <korryasdlerto@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

