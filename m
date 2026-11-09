Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228524;
	b=zXOJksTmGdaXnDiTgtsu1CrjWZnme4Qpfm6RHZ30sW8QT7hwFd5k79qq2LFoS6rWXIGd
	 /KNWZOv3SrMhlXId313cn1o+WJN1q5KvwkZZuU8RNS4nUu3usnGFpRPoK26kwJp0hegF1
	 mh+TFuwMWi94mpCsNZd2SVsvJwvTssbMv0Myf4p9zl0XJwNVKgvHG6rZHI6Bb2TlJiC/S
	 zEfw9KYmMPdbzkhUnCIKab9eV1ly5Lme9zFUThCfo9QMGJedfmEg7+JCxcVxhdt0Capwi
	 Y22xw9e+OoN7W1v5DE8cOQYykKme6mi/4V0dYItrDSnKxExkLxPFQSfx+OrSsVO6DBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228524;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UINM18WE1biFyxB88oecpmkDb6Uj5RCBHghv2wECHUE=;
	b=IMwmvx8RVmUfK7QPo8UzNjvHbLSmZ2hyKpcb+1Shl+YaHIW/vcJMAke+rZQ1yICDci9Y
	 gyW7+8YlBYGkOirwlCZ1MaDeDoy387fEQZBXdXKsKD0h9/YB5z87D1Og11yh72JBJ1RTN
	 6JZqzKPAhYMdspaXcs2Z3qOFV10unkgpL3QjUG8LWb5QcDbXYCKrmSNDVcliX46nUlBAU
	 j2FFCm5ce+6lGBaGSsUApQ/MFnku8wc35R5q885UIGXVkcuGIAGPOJiRbN9tOBnQe6ULS
	 VKTXomR9RRRC8lzdpAY/k2IcsoEgqDdUnR26KCb7CYiG7ERhxCFgcb5rdBrgcs/he/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BPAuCnuH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04666606A321;
	Mon,  9 Nov 2026 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BPAuCnuH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC14F1F0089F;
	Mon,  9 Nov 2026 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794228523;
	bh=UINM18WE1biFyxB88oecpmkDb6Uj5RCBHghv2wECHUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BPAuCnuH3urpeUYQdqTNc2p3G+iO8b647QtrTA2aaryb9cu31RLLKiYPXKInCDDtO
	 JufoxY6mpvZcfpMGNgHIvs01HMwKYrFksKAvk1SnSLHTKwCV+X+G1KgSGP+92Knf0X
	 J3DLsJU3KT5hXERN1DjAYTl0LAbx0MPz+hLROA9ClcOVeVra5j+ljwzxNXCnPLAkQ3
	 LJvaltBhYOt6jid86afML9io99yBkOjxvQ6UhVkG6k4uRT2xYsT39POhcT5VBS9769
	 4glPoTeW/VMFLHMmWRZBvZBQ3ChZNjzQJlrTlf38rLOLY+6zRHByw7Fa7sj7hc5yg4
	 9Rhh6hw7tMjVg==
Date: Mon, 9 Nov 2026 13:48:39 +0100
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
Subject: Re: [PATCH v2 01/10] dt-bindings: ptp: Document the TSCSS on
 Qualcomm SA8775P and QCS8300 SoCs
Message-ID: <20261109-qualified-pristine-newt-ba1c0c@quoll>
References: <20261108-tscss-v2-0-d5f575010427@oss.qualcomm.com>
 <20261108-tscss-v2-1-d5f575010427@oss.qualcomm.com>
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
In-Reply-To: <20261108-tscss-v2-1-d5f575010427@oss.qualcomm.com>

On Sun, Nov 08, 2026 at 06:48:22PM +0530, Imran Shaik wrote:
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: qcom,sa8775p-tscss
> +      - items:
> +          - const: qcom,qcs8300-tscss
> +          - const: qcom,sa8775p-tscss
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +
> +  reg-names:
> +    minItems: 1
> +    items:
> +      - const: tsc
> +      - const: etu

...

> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - if:
> +      properties:
> +        reg-names:
> +          contains:
> +            const: etu

Reason for same devices with different address space details should be
provided somewhere, preferrably in description. Assuming in the first
place, that this stays because how two devices can be basically
identical (same compatible) if they have different programming
interface?

Best regards,
Krzysztof

