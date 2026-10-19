Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565B125392A;
	Mon, 19 Oct 2026 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392948; cv=none; b=ZErdc6AAQ6LtmXtwveAkTtZHDrsMbAcgLaUMUwZsPMzEsWK4w7f0sQ2AyxiISsFELCEVaxKE77IdapSHua24GmZha50Vvp//ez5MDG+Oy3QXv9REs7Xu8uQm7+IotNucGPMjVF3WHQH91IDTfUgEL4O/Olh1BBDzdcYsYMJIfJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392948; c=relaxed/simple;
	bh=nVPR/wVfw88sj38qQgKSyYoONX1twjU6nqbBIWBVGTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtlkqgEr4lGx2aDgvLC7cL3ahbvUJpbE/vLME2x45Q/x7gr4ZKX2m2fH6C1z0aNAGK+c7uGgp+Dc5LUVC6NOkPfsuF0FGrDBWV8y7GyIgU5y+jbAk72nLICDaO7q/b0UpL2kN0fGPQ6KNySqGNhoPGBS3cDi3AO65B5WfJn0SNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgB1giYD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgB1giYD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADCB1F000C4;
	Mon, 19 Oct 2026 06:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392947;
	bh=1K8qIit/bBE/r3ctFbU5AiNYL7DN74LzCmsZIKix1go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YgB1giYDu4H1Vw5Mu7creBaShHjfY4tCXT2ctTHX++UE04vpMdu1+UEfiKIc86AUq
	 xtcFTFmLzEZ0bVBW9dmA30qXXdw5csN09ke4DjGleSaSfls0SBIL9mEWABecjsjzQM
	 OPNCrVW5GFmWRzEkBRt1VPEP83Tt+V4N96u9WXKk6K4bayL5r+dC12xj1Y7HPNhj16
	 bfA/PsKba+aY0cgRNDEG9RzZin+c6sohNox19L7ZBvBXiH+8DIMhOOEFUN/HlP+y6N
	 1J9Q0gbOmx6+FHVX2/A7QMN9Dr8s0d8CVZKXTMDqlGbDCPII3LNIqQzoinuLtmtdV+
	 /zY+NPbNihyhg==
Date: Mon, 19 Oct 2026 08:55:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Til Kaiser <mail@tk154.de>
Cc: netdev@vger.kernel.org, jie.luo@oss.qualcomm.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, linux-kernel@vger.kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, quic_leiwei@quicinc.com, 
	quic_suruchia@quicinc.com, quic_pavir@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH net 2/2] dt-bindings: net: qcom,ipq9574-ppe: Apply PPE
 constraints to all switch ports
Message-ID: <20261019-pristine-brainy-guppy-eb2af2@quoll>
References: <20261016150140.929729-1-mail@tk154.de>
 <20261016150140.929729-3-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016150140.929729-3-mail@tk154.de>

On Fri, Oct 16, 2026 at 05:01:40PM +0200, Til Kaiser wrote:
> The generic ethernet-switch schema accepts both ports and ethernet-ports
> containers and both port and ethernet-port child nodes. The PPE binding
> only applies its port constraints to ethernet-port nodes with addresses
> matching [1-6]+ inside ethernet-ports.
> 
> As a result, ethernet-port@7 with reg = <7> is accepted without the PPE
> port ID limit. The alternative container and child naming forms also
> bypass the required PPE clocks and resets.
> 
> Match the same container and child node patterns as ethernet-switch.yaml
> so that every accepted switch port receives the PPE constraints. Keep
> the valid port IDs constrained by reg.
> 
> Fixes: 1898fc572118 ("dt-bindings: net: Add PPE for Qualcomm IPQ9574 SoC")

Nothing to be fixed here, really, drop.

> Signed-off-by: Til Kaiser <mail@tk154.de>
> ---
>  Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
> index 6d0b21a10732..a5e8aab500ed 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
> @@ -173,9 +173,10 @@ properties:
>        - interrupts
>        - interrupt-names
>  
> -  ethernet-ports:
> +patternProperties:
> +  "^(ethernet-)?ports$":

Why are you reverting the review? The name is ethernet-ports.

>      patternProperties:
> -      "^ethernet-port@[1-6]+$":
> +      "^(ethernet-)?port@[0-9a-f]+$":

Same here.

Best regards,
Krzysztof

