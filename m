Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D5382F23;
	Tue, 21 Jul 2026 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625483; cv=none; b=YExiGxURo1m/bVZVOXwahrEu4rxds5/iZJV8VCGq1Cjm4LOMcfZzsZUfqQ00p9NtXiyUT7PqF0jEjTEqpG0cdSYPT8CNjNihkembjBiViwpmXpm/LId1ojCtRdzyX+m04O4+xoWHp1ocZoXs6dHBQa16p+EbIVOtF6vOflI+R1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625483; c=relaxed/simple;
	bh=+oA2cuF0pgO8hD5DwEmAMQwDYo+aTo7GYRHUS6/36KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/hsNfwJI8TGeyUMP9GyxDIAdIMOvxC3XF4frg76muX2u/0TJwFJXq4vPjOKX+M/+HKDTEp0F0oSKkfgmEh/Qha86xTK5its+YTFX+PMb5BD6X80w4fBTeEHMzAymP3Q2rLLE4uxLtcg0z2i57XXRcSw9f6UHSQjBLuAuqt1yo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRFd9YYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRFd9YYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD131F000E9;
	Tue, 21 Jul 2026 09:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784625482;
	bh=Xt4yV4EitGY1p1/xtPkwZqzWeeR4gGCYF5kEL6DKGIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LRFd9YYOC3TY3CeNGbu261AvGsH1yHX/ZWb1u1U79S3TjITdAhsXpcoz8ZNol/Pf/
	 lfr5zLwTgCGayF/khtE16uKhf7LTTNl9rpHaf65E05zkkRBe+/vC3mop8fOiqAn/Qr
	 Vky2//GIHm3cj2yl+X1oVa/aFSz4sPMvRSOzjWlXjkg0KJ2jWNajz+mCVPst/TjqqY
	 jYV6lJgyaQOxtkQgZxVW79+Zz4efi34jSRicF9L9LUSJfijEV/kkdM9xdYyBH3UMRh
	 H9tBNQRKmKhRIZmrWnJiIqqe9fuY8nBLM5W+jnNHDF6WREC+8+lemPu9GkwVX1JS94
	 VaCiSPm0xa72Q==
Date: Tue, 21 Jul 2026 11:17:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Cc: Stephan Gerhold <stephan@gerhold.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, chris.lew@oss.qualcomm.com, 
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: qcom,bam-dmux: Add
 qcom,shikra-bam-dmux compatible
Message-ID: <20260721-spotted-spicy-skua-cca66e@quoll>
References: <20260714-qcom-bam-dmux-vmid-ext-v1-0-3f29da7cca76@oss.qualcomm.com>
 <20260714-qcom-bam-dmux-vmid-ext-v1-1-3f29da7cca76@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714-qcom-bam-dmux-vmid-ext-v1-1-3f29da7cca76@oss.qualcomm.com>

On Tue, Jul 14, 2026 at 11:02:31AM +0530, Vishnu Santhosh wrote:
> On platforms where the modem DMAs into the BAM-DMUX RX data buffers and
> the XPU enforces per-region access control, each individually
> DMA-mapped RX buffer consumes an XPU resource group. With only ~16
> groups available, the per-buffer mappings exhaust the table and inbound
> transfers fault.
> 
> Add qcom,shikra-bam-dmux as an additional compatible for the Shikra SoC,
> paired with the generic qcom,bam-dmux fallback, so the driver can match
> on it via its of_device_id table.

Drop, redundant. What is not redundant, why you claim it is compatible
but driver code suggests it is not incompatible.

> 
> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> index 33746c238513d72366bc52359fb10f275475b331..27f0fdf285c17d6bfdecd5e59cad09912a5e821b 100644
> --- a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> @@ -22,7 +22,13 @@ description: |
>  
>  properties:
>    compatible:
> -    const: qcom,bam-dmux
> +    oneOf:
> +      - const: qcom,bam-dmux
> +      - items:
> +          - enum:
> +              # Shikra

Please do not write redundant code or commit msgs. Look:

> +              - qcom,shikra-bam-dmux

It has word "shikra". Can qcom,shikra-bam-dmux be anything else than
"Shikra"? Then why adding such comment?

> +          - const: qcom,bam-dmux

Anyway, the generic compatible was added to cover all possible use
cases, right? So why it is not generic enough here? One more example of
generic compatibles failure.

Best regards,
Krzysztof

