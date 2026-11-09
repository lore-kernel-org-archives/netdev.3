Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228670;
	b=pEVlS2uE9iY8cBdmYl2OicKFAByUPgnp+cU5iE2TJI2ajla2WX2JdSBNpBpxHmnVPBUu
	 uOCFY8bPh3hNSnfSD3h86Axmfc5zDjZ720Aw7OWU4pLj7dd6F9ajUEujNXX1TE62I/1/t
	 J7w4xukXj4sKgKQ3uQTHKel4KEV/+OUEEs7GU/8dkqW/25zXxcHZePTHXE2HUITxXnGHS
	 jBVITdx6SJIu0jx5px/4w4PWLODV3fS2ulqGJCV9i0WT2c1NRFjSDfhPyu7SRm8GYyFFq
	 T9WRtubF/CyPXtFr5G1xDfOHH1Lw1Bx45UJ/gfVLeOzjS8YSONOtrWOD+2fpM1E6FCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228670;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xMKd25EnS6bUedYZGkcOZxXWCwGfPAcr8fNNIRoGA8c=;
	b=0hQLuSsHFLE2xbj7etlzY7fXgHHhwxh9Jje+FA/YwBGjN6PazoeZgdDYCCVr5DBJLJl2
	 NvHMQt6412V1GbZkcCM/V2Kl8Baa2tOR86l5O3aiPCxmf3FT2ld9d5jRtxL/NoGOW65si
	 KCHwY4FhTR0ytnw72B9UM4dy8foSFrv4siStehjzCeWKr2q3+Uu8L7QU2yACrwlwt/LwY
	 dsayI3sQRkCvH2kTRobOuXHKJACmVp1tjl4cpkCcInSTpZM2sm34pLY1ImuHeWPY6Kkal
	 5wYG2jHOyRAG3sxt06m+W9HL8QjhXQiCDdJlE8XklU3fCvbUJ6KxbepqMLXBdQTIdpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9MF5eiC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87618606A322;
	Mon,  9 Nov 2026 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9MF5eiC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFA51F0089F;
	Mon,  9 Nov 2026 12:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794228670;
	bh=xMKd25EnS6bUedYZGkcOZxXWCwGfPAcr8fNNIRoGA8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b9MF5eiCe6k2xzg6jPbNosdLgMPXDk+BWYdlFRNiaTliFhdhsXa703kaEdfBflm6D
	 QXzcd25n3e6XNdSBk9fraqUUrNeQoxsRiH8wL0r588afPeOtoktvVeCKyMJK9JyHc0
	 5czfnAOeMdWHoCs431kI9hJwga0y7Zw8DQL/oBBikleWrCom7H+hnrTqffs91oqJo8
	 A6MbwjPFivZhYvBxyGShsankrihVtzl+ZXqGI2VaqExT0upaM28J3K3k4dt1qHiTLs
	 nLSeWhejneyjh+Qw5nf4qThOvSjbx3K9pmgTKoYyw2HZW7RzcVPdR4C542+1D2KxMN
	 V7yuOch5uyG+A==
Date: Mon, 9 Nov 2026 13:51:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Imran Shaik <imran.shaik@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Eric Dumazet <edumazet@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Ajit Pandey <ajit.pandey@oss.qualcomm.com>, 
	Taniya Das <taniya.das@oss.qualcomm.com>, Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 03/10] dt-bindings: ptp: Document TSCSS hardware on
 Qualcomm Nord and Shikra SoCs
Message-ID: <20261109-statuesque-polecat-from-lemuria-1b8ade@quoll>
References: <20261108-tscss-v2-0-d5f575010427@oss.qualcomm.com>
 <20261108-tscss-v2-3-d5f575010427@oss.qualcomm.com>
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
In-Reply-To: <20261108-tscss-v2-3-d5f575010427@oss.qualcomm.com>

On Sun, Nov 08, 2026 at 06:48:24PM +0530, Imran Shaik wrote:
> +  interrupt-names:
> +    items:
> +      - const: etu_summary
> +
> +  pinctrl-names:
> +    minItems: 1
> +    maxItems: 32

So here there is difference, that justifies different binding file.

> +    items:
> +      pattern: "^slice[0-9]+$"
> +
> +  qcom,etu-slice:
> +    description:
> +      ETU slice number for each entry in pinctrl-<n>, pinctrl-names and
> +      qcom,etu-event-sel.
> +    minItems: 1
> +    maxItems: 32
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  qcom,etu-event-sel:

Anyway, you need common schema defining qcom,etu-slice and
qcom,etu-event-sel properties. Maybe also pinctrl-names and other common
properties. The individual device schemas should only override/narrow
constraints


> +    description:
> +      External event selection value for each ETU slice listed in
> +      qcom,etu-slice.

Best regards,
Krzysztof

