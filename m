Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228736;
	b=K6/g4rgFmVlrbLPd/iKx3BAKNVS9LkqP4/JCL6AnU44WLbXdy3TdPIOX6PXiPTepPZDj
	 bYBhYdifL2jMDtQ0W27b1wKicBrnHLcE0T66+3tcqwtWLjKWoEIuOIoFr6FIQLXpzb/kh
	 tTFjyq4KHPFroZHK/D7dO3P40h0rOEZEE9EdzINPoMDKiigFhdBDNkAdFll0sUAojnd+U
	 gNdhzF+c3UjsV4im5EG6BhtzK4HrGlub7HXfezIC8vuCcg+wRrXuRA2HBpelUvKA+jFSp
	 ClrXAr1LQTDH4wVum7SN9YOX5cludGV2qwHm7fhCpe2en/fEeMfG5zqCu9180I5p48w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228736;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=I0qeZdg4ZJNAF2cuumqrSRtgG2tXJPz73PjmplXC9NA=;
	b=RNjadNZ86VtVI+J3Igfle99vBQfgXS9aTBQxhBsTL8enNLnUa5L9IQZEiFGUcTEbmCFh
	 ox59gVLwDWO8Qmu5XOOMieUAA8K8FunNXjPYQn1pmO1yCHNdMWW1JwxXJte/tA/wsPk1K
	 rIgE8qCBTd1vSSamS8rPZr8Y3wJLY0JftGeigq3vpw1SkY1Ivh2VswyWGL7mA3hL+zCKL
	 2jOszH+D9lcE+2HvZ0wQI3eVhqRLnQ2iXKYw5g9v+YA3QrrnXcVxaLmq7EBMD5fQQtMgd
	 FSMacPMyHXraKhB6Q2U+ZwsxCQzZ+dqNtNqwdkPveyAc8jsqDLHOb5pGKLliqv4CK7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTZvlaPr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF67606A323;
	Mon,  9 Nov 2026 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTZvlaPr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7AB1F0089F;
	Mon,  9 Nov 2026 12:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794228735;
	bh=I0qeZdg4ZJNAF2cuumqrSRtgG2tXJPz73PjmplXC9NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hTZvlaPrhFiMl0FB9UipgZ/Ko6xf+GhpXI4VoFBIixTaPWfM1m1jnrSIC+/AklzM6
	 2lRphjdsVs46tP6ACqNnhbR5VB6gc+4mFC1BOKSinqMX+YRUScglipv+TntmUlNqRo
	 lbDp19Z7TpmnX0nxGI07EiIASXjmidS/GnwRDKB5q/Lcna8Jhh9kQx4kZ8ooWbUs+s
	 orzGGwx2XwbnS17tR0Br9jalHRtg2kfRvq0RGptbcEzJOs7OvD8+9jpMeCyodMGI/7
	 2AXlia6ZDI7Vtly6h8geQb91Arm7KlKrCuCHs7EBNxJWGYF7nMRFl260VHGN+9Igqt
	 c1h1s3IS1r9mg==
Date: Mon, 9 Nov 2026 13:52:12 +0100
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
Subject: Re: [PATCH v2 06/10] arm64: dts: qcom: lemans: Add support for TSCSS
 node
Message-ID: <20261109-enigmatic-solid-sambar-ada2bd@quoll>
References: <20261108-tscss-v2-0-d5f575010427@oss.qualcomm.com>
 <20261108-tscss-v2-6-d5f575010427@oss.qualcomm.com>
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
In-Reply-To: <20261108-tscss-v2-6-d5f575010427@oss.qualcomm.com>

On Sun, Nov 08, 2026 at 06:48:27PM +0530, Imran Shaik wrote:
> Add Timestamp Counter Subsystem (TSCSS) node support on Qualcomm Lemans
> SoCs.
> 
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> index 1fdb72fa5518..4c76c820cacb 100644
> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> @@ -3022,6 +3022,18 @@ pcie1_phy: phy@1c14000 {
>  			status = "disabled";
>  		};
>  
> +		ptp@1c80000 {
> +			compatible = "qcom,sa8775p-tscss";
> +			reg = <0x0 0x01c80000 0x0 0x2000>;

Where is the rest of PTP devices? Your binding clearly said there are
PTP with one and with two address spaces.

Best regards,
Krzysztof

