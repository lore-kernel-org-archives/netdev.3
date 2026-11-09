Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228755;
	b=O1AxLNBpskTnddUC6PZvFZYsGESmfbxtdGuqjWjhLtdQf2ST3gTly7nMADQ8lJbyO6zk
	 6AuMiWr7KP7L+5ynntTIYZW/C5It9hVT4ecR1hc2O+nbamDb7s+Yduua1F2RahyNkdp4S
	 AT1cjq2vmEd6mUm6z6Xsu7MGjofXpIQxwt+pZria2bUrqp0Je43DpHbRHZkEvanxbo8K+
	 DQ1lC+0kXOe6tBxT+sjBleBpi3LZ9MvHw4uT1pW5icqQ9tsB80TaYXRaPmjtdpYgY/J8o
	 Ymu7n/Nu6CeZAs/fg/GCAztDGZ35dpmAuWmRCbksEQkeN7baNjHa87b2DTeYLIUPByA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228755;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YI9N/fdXq7a0Zsm1FgW04ZVV42KyU9XJRIaiy0dvxCM=;
	b=VGeeUNEBQCstwRae67TcamNl6k13/tjZO3xa7AhDB2FxnGftI4NckQ3ofQXBy38WgXmY
	 nVfAsy+OUAAUftvia3ZnNHoUEtd30G2EOAe5n4sgHEQxKqdjKymMBEjIiM2Kv7UumntXs
	 ZDRLa/8rox6cgDO5jHl1+8+VZcOuBSON+PRyaLZR+2si5GNeQqb3Auhhid+ptFnLjo+5y
	 d8PJmlnRXhD3CMaW8zRejR+SRX080Hc56ZKTbvwPjZXgH/eqZGHVmziayhKlGw/YhCQea
	 pilk8/zNCMJrSSqB/6VHCjal+hhq1wNXjaT0/E/jWYGURB8uy9iNVFj5e5wqslrcWbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1wflv9k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA1606A31C;
	Mon,  9 Nov 2026 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1wflv9k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C1D1F0089F;
	Mon,  9 Nov 2026 12:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794228755;
	bh=YI9N/fdXq7a0Zsm1FgW04ZVV42KyU9XJRIaiy0dvxCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G1wflv9k7HCCOS4x2ck0e/5jb+ys1F8Gf/EvASz10IjlEEGwXjmT1VnFck912zw2u
	 5o06HjYtcpWsIxjqVglV8tuy0cCTDNWXWT3c9dl+ydTTFgmqA4dbjAxLWKtwVkIHLX
	 2RBuAJhSd6FFzmjbnWxd0CA2regc6CLIOiLt9PQKPiyphoqgUVhHChyrRimiSucndM
	 Y1Cg4jEBqnsFATqXFDPLwOvHHlfFiQaUaNkEl4xt7RHXUuqYQ72iDD+WedkOYRh1W5
	 zbhTc0TJ6ulS+RFooAXTrH3/YY4kg47/YG8H/ZvzZUnfL13Vn/HASm3Z5RGMkGJdyh
	 I4/udMR2J/eSQ==
Date: Mon, 9 Nov 2026 13:52:31 +0100
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
Subject: Re: [PATCH v2 08/10] arm64: dts: qcom: qdu1000: Add support for
 TSCSS node
Message-ID: <20261109-loris-of-pleasurable-opposition-4e8f6b@quoll>
References: <20261108-tscss-v2-0-d5f575010427@oss.qualcomm.com>
 <20261108-tscss-v2-8-d5f575010427@oss.qualcomm.com>
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
In-Reply-To: <20261108-tscss-v2-8-d5f575010427@oss.qualcomm.com>

On Sun, Nov 08, 2026 at 06:48:29PM +0530, Imran Shaik wrote:
> Add Timestamp Counter Subsystem (TSCSS) node support on Qualcomm QDU1000
> SoCs.
> 
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> index 3a25b5100836..0f4028c41b2f 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> @@ -877,6 +877,19 @@ system_noc: interconnect@1640000 {
>  			#interconnect-cells = <2>;
>  		};
>  
> +		ptp@1da0000 {
> +			compatible = "qcom,qdu1000-tscss";
> +			reg = <0x0 0x01da0000 0x0 0x2000>;
> +			reg-names = "tsc";

I see only one PTP, what about the rest?

Best regards,
Krzysztof

