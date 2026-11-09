Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228782;
	b=JVVTVCXnYwQbLN34zwss60vvreAegB6R8lhJ66a2ExyYoVaOYQV+HOS4Rsi8rpmcrVvm
	 WSYcnQUBL0HaZqACSFh3vzyyhJVRAxKbtfcCnqlJ3/MG+iT9Li3Iqjyn/jhYrOylNJhRY
	 U3XaiTHgLQL8fnPUso3WGgJKsrMR5IfZS+VRR3BOmGb3f+gOiVVC2xRAFhUpWOufi/gBC
	 9YQd9dESYvkrAg5VCwpyhl+ZCub0cdz6BasAXEiyqv52hDZXHGZ3VlIXSeQ8GjwSJYLc7
	 VCjacJIqg446uUAqJkgfrw/Jc4nCQ2tMxUTBdDxYI+TCP4i5ax9vc5cwHFWDaBmR/Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228782;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pIs2J9micTT/yi1fdIyjBwJhUsXlZCW/u6XJ1gvAbvk=;
	b=L6fzLywuxkEVkgZikx/kgubYQAUm5Mj13YM7QnnkG9+0CkvmpeFqjGVcUXZwNtc0OkdE
	 GJBGocAWxjcolqcT7gdviL7urtKisDNerO7bpl8EesZjyU3SjGEXx7PfzwUlfiQsgiuye
	 qsIoOzzUAiOjfN8Z9mtNKoD2TCda0dxc0kpGalrwQ9MGSP8jB2F57Cr9aUZH+/DtFTFl2
	 TfIpZVFseonyk3sRzNkcLedFgVn4umsOZTk+bS0rhiRKBU9Rqh6PEwMfH0tl7BYqE72b3
	 AwnRj+QJXdN9w4IEIsTGkZHgiF2gUcZ2R2cE9/5lshgHkaMXB1ruIPUN3t5xUhSAyoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m0JEYZ0f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98603606D817;
	Mon,  9 Nov 2026 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m0JEYZ0f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F931F008BC;
	Mon,  9 Nov 2026 12:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794228782;
	bh=pIs2J9micTT/yi1fdIyjBwJhUsXlZCW/u6XJ1gvAbvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m0JEYZ0fh4Nc7lNAi92hzLi5jia3FGYA8xZnmTZRMgh95mtU7u///gpRlN0mUB8Np
	 ZSEGmOR8t6QighLHHqUYSrSNNVbojTzblY1yU1hogQPrPrl6Vw1D5PxK+f5WmJJZxL
	 HCAAK49LpAxxeGNJrHpL3yN9Nz64DwWO3GPjDVt204bLr4RYdBEm6zJfxkIcuiXEHT
	 I6/u3HHfJJsS2081HQQ9dPQHlr3m93celGYGa9VleIJCMT0WOsC3Edie3qEXz1ZMyB
	 t4BMBo8FB03sL0hJIsOYOYmDHsbg8TqMaG41z3mqynrFQLl9ApOYkgrUzgVC44GwIR
	 ZEA2qXuXnxtVw==
Date: Mon, 9 Nov 2026 13:52:58 +0100
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
Subject: Re: [PATCH v2 10/10] arm64: dts: qcom: nord: Add support for TSCSS
 node
Message-ID: <20261109-formidable-outgoing-warthog-e6ab6c@quoll>
References: <20261108-tscss-v2-0-d5f575010427@oss.qualcomm.com>
 <20261108-tscss-v2-10-d5f575010427@oss.qualcomm.com>
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
In-Reply-To: <20261108-tscss-v2-10-d5f575010427@oss.qualcomm.com>

On Sun, Nov 08, 2026 at 06:48:31PM +0530, Imran Shaik wrote:
> Add Timestamp Counter Subsystem (TSCSS) node support on Qualcomm Nord
> SoCs.
> 
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/nord-embedded.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
> index 1ab7d9bc3cfe..1d5f27336f73 100644
> --- a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
> +++ b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
> @@ -736,6 +736,20 @@ pcie_data_inbound: interconnect@1c00000 {
>  		qcom,bcm-voters = <&apps_bcm_voter>;
>  	};
>  
> +	ptp@1c80000 {
> +		compatible = "qcom,nord-tscss";
> +		reg = <0x0 0x01c80000 0x0 0x2000>;
> +		reg-names = "tsc";

And the rest of the devices or entries here? Are you sure you are adding
complete DTS for this device?

Best regards,
Krzysztof

