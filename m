Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228586;
	b=39MiwY8XJnMeB3MySU4H/FI+XHqhi6jP7G9ZkNcau5aRvl2MYu4YNY2IyOLOogzTys3E
	 4In/CDb/QjhBj46o0zVg7poSlKSuKQjqYr2llBb6tYoaaSYfg0lt9XnHQovw2qkrqf9Lr
	 8QeC0hSoK8N24RrHZvl39jOQ9GINPIh1woNko8+hTrcEQz3ehMCeCc/buuhfzPodWzObR
	 hO1NL/XKKimYraFvyLcagnrBv61d0cFn7Nfa2Ap2bPAAemGPwrqSlJHNu8tJrokzFKluy
	 Ew8UxQ1hcV2gteiY59DULVsMwmC7IvUBRp4HOsLhJEvQ4t8NDGW64BLTauLcQSWZkWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228586;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8nZAwGS6CTOwltNNT7HN871xA3eXVwrJJClB1UtUFo4=;
	b=K6hNsKj8cdsddMUsLu3PP6S//uEyDv3UJ3OcLNtI1uiirDA5SRdSzlZBOn6CN6E1TouW
	 hxqVMWYej7h/5lYZ1Oa67JYF6+amU7L9CquRw1QBn7r0CTjc8pnm0Aim7NsuVa8tp07f/
	 Z54vZN7+YiRO61NNwzn0+QamswmVpCBwbNak/MNfL05tQ5rIWUTxhxtN2B1G6T9lbexu3
	 Yr6IVz+c+ZHAtjNWWS+QeCUAJMZtW/NpFk7DAg6/Hs+zyi5mJ/G+ILz1EvBhn4M4g/pNs
	 xi6zaeZuAouy0aH/34RygqSUyrbgtStyAZ0l615zlOm8Bc23MDsRQR1SYXqolMbj2ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MghTQEz6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E6E606A31C;
	Mon,  9 Nov 2026 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MghTQEz6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642181F0089F;
	Mon,  9 Nov 2026 12:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794228585;
	bh=8nZAwGS6CTOwltNNT7HN871xA3eXVwrJJClB1UtUFo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MghTQEz6ajvzzXgmguo/lZbT+yNbG6uoT28c7pwFQK74+sPfgG3vGrltHSZRLD+nx
	 L3bnGKjrRedF/NvATnUY+v+WvzExTi4AjtiHZTFdhy4OXNUKSWIyJeg/jbzWj4Xxxj
	 e/2h4v7qLNZggAMUz0TW/J/GeD3l9NTeQoRzCpBT/Vd+OMilOKTDB9N9/+Lhy8W2fg
	 K39Z3P/hpLJhU0s2e1WuV/7jbzanAwWjDnCALeQ8N7wv93iJbnHeTsYnHp6Xu1QW9n
	 VwNWmkjD1Q81R7puY7Ivhf28SWnq98KaRlN456lMdWUF/5hEas+79hTWApcGuqqk5g
	 b8F37gANJF24Q==
Date: Mon, 9 Nov 2026 13:49:41 +0100
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
Subject: Re: [PATCH v2 02/10] dt-bindings: ptp: Document TSCSS hardware on
 Qualcomm QDU1000 SoC
Message-ID: <20261109-sticky-caiman-of-research-65e9a4@quoll>
References: <20261108-tscss-v2-0-d5f575010427@oss.qualcomm.com>
 <20261108-tscss-v2-2-d5f575010427@oss.qualcomm.com>
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
In-Reply-To: <20261108-tscss-v2-2-d5f575010427@oss.qualcomm.com>

On Sun, Nov 08, 2026 at 06:48:23PM +0530, Imran Shaik wrote:
> Add Devicetree bindings for the Timestamp Counter Subsystem (TSCSS) found
> on Qualcomm QDU1000 SoC.
> 
> TSCSS is a time synchronization subsystem composed of two main blocks:
> Timestamp Counter (TSC) and Event Timestamp Unit (ETU). The TSC block
> provides a continuously running counter used for timekeeping, while the
> ETU captures timestamps for external hardware event triggers.
> 
> Co-developed-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
>  .../bindings/ptp/qcom,qdu1000-tscss.yaml           | 170 +++++++++++++++++++++
>  1 file changed, 170 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ptp/qcom,qdu1000-tscss.yaml b/Documentation/devicetree/bindings/ptp/qcom,qdu1000-tscss.yaml
> new file mode 100644
> index 000000000000..52a063ec4b78
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ptp/qcom,qdu1000-tscss.yaml
> @@ -0,0 +1,170 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ptp/qcom,qdu1000-tscss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Timestamp Counter Subsystem (TSCSS) on Qualcomm QDU1000 SoC
> +
> +maintainers:
> +  - Imran Shaik <imran.shaik@oss.qualcomm.com>
> +  - Taniya Das <taniya.das@oss.qualcomm.com>
> +
> +description: |
> +  Qualcomm TSCSS is a time synchronization subsystem composed of two main
> +  blocks - the Timestamp Counter (TSC) and the Event Timestamp Unit (ETU).
> +
> +  The TSC block is a timestamp generator that maintains a running counter used
> +  for system timekeeping, and is functional with just the AHB and counter
> +  clocks.
> +  The ETU block captures TSC timestamps for external hardware events. Each
> +  ETU slice binds a slice number to an external event selector, and
> +  generates its own interrupt when that event is triggered.
> +
> +properties:
> +  compatible:
> +    const: qcom,qdu1000-tscss

I failed to spot the difference against your binding at patch #1. How do
they differ?

Best regards,
Krzysztof

