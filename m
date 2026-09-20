Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143A07081A;
	Sun, 20 Sep 2026 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789900618; cv=none; b=ZFql7Z0fK58xZ6aw2ugQU9byD6ZpLU3Rj4bseF7XA5clnxeohKpJr9xX9iw7nMfxy/cse/1zGRGgKZlwbJaRWhac8YWLI9vcuMpJnXQ6IOe+ISvDQImD901MOyVfBi0s7I3e2EvzEaed0CMzhDc+EMMr0IB2QvSt3JjW2McDfUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789900618; c=relaxed/simple;
	bh=Mu2Xq2oc+nZYhHCtht+DDI2OtS8nOnLUb3Wl/cJ49Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApEEWG8KQF1MYSl6OHaG0T6hthONu7JbkfqvQPbUT+nQReMqf1bDUEa9fo7vvh+A4U1pRLMFxq789MCdyVnyYZWaiV4jQAricwjgo/htl6BdPiL5awl1g3yoc9PN/tFWEijL1PUpHmhWZTwydMTuZhd0onVk2SKuqNZHHDvGzLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVB3QWAW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVB3QWAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DC01F000FF;
	Sun, 20 Sep 2026 10:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789900616;
	bh=+JvvR+833DTwKxMI0yGo5Km7b+q6jrbPieOQJjm9WdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XVB3QWAWeHSWty9N9NfnGztEK11smGpvr51GRR6IQDo+wuYchxklJFuRWNtK9uK2z
	 KdDWJkz9JiGbOR5BARDDeTAXkzAI23ZT3JElyZzgRon0a7YuyWa8Uj+Cg4cnqDgogF
	 H4vQlKe6MHJFJM5JPZ8JPXiNSFJowMenUk4MHIJ3lBS3SsIg/UVYQ2eFO1YPhXFCit
	 2o/RkmW17bObb9Ld5l0c3GgZjlUrs3huQKDRMYMNa7/QXukEltNHiVPbY7zOq9LNk8
	 or6jMwuiYLWg3gyRtq2Unxuy0YIB2EuDsVcBDM3dDsgUMUmGsQNtnsYhRyPYbyhWwN
	 Ey5letHfGw2qQ==
Date: Sun, 20 Sep 2026 12:36:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Cc: Stephan Gerhold <stephan@gerhold.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: qcom,bam-dmux: Add
 memory-region and qcom,vmid properties
Message-ID: <20260920-humongous-raven-of-charisma-bb99ed@quoll>
References: <20260920-qcom-bam-dmux-vmid-ext-v2-0-ef5ca2178378@oss.qualcomm.com>
 <20260920-qcom-bam-dmux-vmid-ext-v2-1-ef5ca2178378@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920-qcom-bam-dmux-vmid-ext-v2-1-ef5ca2178378@oss.qualcomm.com>

On Sun, Sep 20, 2026 at 08:32:29AM +0530, Vishnu Santhosh wrote:
> Some Qualcomm SoCs, such as Shikra, run the modem in a separate security
> domain with restricted access to system memory. BAM-DMUX DMA mappings

Then this is specific to Shikra and should come with its compatible plus
constraints per variant.

> must therefore be constrained to a designated region that can be shared
> with the modem.
> 
> Add an optional memory-region property to reference a restricted DMA
> pool used for BAM-DMUX mappings, and a qcom,vmid property to identify the
> remote execution environment that is granted access to the pool through
> SCM.
> 
> Require memory-region whenever qcom,vmid is specified.
> 
> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/net/qcom,bam-dmux.yaml     | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> index 33746c238513d72366bc52359fb10f275475b331..5351269b0ab72ede808ae47b55d57580af209038 100644
> --- a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> @@ -72,6 +72,24 @@ properties:
>        - const: tx
>        - const: rx
>  
> +  memory-region:
> +    maxItems: 1
> +    description:
> +      Phandle to a reserved-memory node compatible with restricted-dma-pool.
> +      The BAM-DMUX device uses the pool for DMA mappings.
> +
> +  qcom,vmid:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1

Drop

> +    maxItems: 1
> +    items:
> +      minimum: 1
> +      maximum: 63
> +    description:
> +      VMID of the remote execution environment that is granted access to the
> +      restricted DMA pool through SCM. The local execution environment is
> +      retained automatically and must not be specified.
> +
>  required:
>    - compatible
>    - interrupts
> @@ -81,12 +99,29 @@ required:
>    - dmas
>    - dma-names
>  
> +dependencies:
> +  qcom,vmid: [ memory-region ]
> +
>  additionalProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/firmware/qcom,scm.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
>  
> +    reserved-memory {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +
> +        bam_dmux_pool: restricted-dma-pool {
> +            compatible = "restricted-dma-pool";
> +            size = <0x40000>;
> +            alignment = <0x40000>;
> +            alloc-ranges = <0x80000000 0x80000000>;
> +        };
> +    };

This wasn't here before. Drop.

Best regards,
Krzysztof

