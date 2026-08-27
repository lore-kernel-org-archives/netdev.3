Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E5B40F730;
	Thu, 27 Aug 2026 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826717; cv=none; b=FjVfK3siAZcgmbNkA74J8vfk/M+y/5RRWkeJEu9vDTIW00yR0DrZz4og77YeYn1LAqflOI+w0rcCWfdYUpHr7AfeQNEw1hTudR3NNmWmaZeTHO5gvXUR4ow+zcFFTxWoN44pisvO4RSt6dSPJw5ASuES8ZEInzi7hnBmTf8ELd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826717; c=relaxed/simple;
	bh=gTI/2zY28PlksG51O7DVosuqQ8uAwW9c+zVSAfbIE5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvCDZnkmdVNO7SIcet/WHA6BOFbkgtCzyydIw9b6Hp7xHVsEU5RUZ25bQW7Ul/oGlATjW4Tmrxjn9y+7/M5M+BhOTBM2AT0u8dxxYp0xZIKiqQj8ilWBLis1UZX9ImaCDFkUyxP0zulknzo0Ivgo16ubmmvOxEbALdMvkVT3byw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7UZGM82; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7UZGM82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CD61F000E9;
	Thu, 27 Aug 2026 10:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787826714;
	bh=dcHTYbKYT/nJkwAK6jeYRLpi/KgxCeK7/I6NNC8+9io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V7UZGM82RCn78p5P69dazx6jcIHBDkgAi/ENOGOGgrK9P5dVTftJFuMnHQ+061e9w
	 YMRl+JmKi3D2w1ttgg1JBRZSq39q7G0WnlYQnS2nldfYVGSluPpGRZkEGE4ptE0/BL
	 7s/hoTh4HJ2gI3xeL5mSVaRXWzNqX0k1+KnHO7hcyyAewOSjRZ9UsKGwCtMR+CdyuB
	 k/ieseVCyhSYcRGYgp78TljaomORFF3LvVziLZ8UiQUMmWerg/c8J+LyHCxiZMcD8G
	 TbpxP1Qgck2OP4w5jNExH8Ix7PpOuIjDG56nwpp6vr6rqRtXzles3VEnjnHw/3ftzo
	 HloujtBgSiPJA==
Date: Thu, 27 Aug 2026 12:31:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kristian Brox <isyourbrainfoss@proton.me>
Cc: Luca Weiss <luca.weiss@fairphone.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: add
 ST21NFCD NFC
Message-ID: <20260827-strange-sensible-duck-40cfa3@quoll>
References: <20260820-fp5-st21nfcd-v3-v3-0-5ee0a7f44d04@proton.me>
 <20260820-fp5-st21nfcd-v3-v3-3-5ee0a7f44d04@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260820-fp5-st21nfcd-v3-v3-3-5ee0a7f44d04@proton.me>

On Thu, Aug 20, 2026 at 08:56:13PM +0000, Kristian Brox wrote:
> Enable the ST21NFCD on i2c9 (0x08), IRQ TLMM 41, reset TLMM 38
> active-high. Compatible is st,st21nfcd (raw NCI).
> 
> SYS_CLK is LN_BB_CLK2. VPS_IO is L18B (vreg_l18b). ese-present and
> uicc-present follow the public schematic (NFC_SWP1/SWP2: SWP_SE to
> SIM1, SWP_UICC to SIM2). Reader path is tested; SE/HCE is not.
> 
> Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 34 +++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> index 04cb9230d..ef66079a0 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> @@ -908,7 +908,23 @@ redriver_ss_in: endpoint {
>  &i2c9 {
>  	status = "okay";
>  
> -	/* ST21NFC NFC @ 28 */
> +	nfc@8 {
> +		compatible = "st,st21nfcd";
> +		reg = <0x08>;
> +
> +		interrupts-extended = <&tlmm 41 IRQ_TYPE_LEVEL_HIGH>;
> +		reset-gpios = <&tlmm 38 GPIO_ACTIVE_HIGH>;

This must be ACTIVE_LOW and existing driver is just wrong. Driver should
handle old DTS without change, but for the new device correct it to
proper way of handling logical state of GPIO pin (reset as "1" means
asserted, so device is not working).

Best regards,
Krzysztof

