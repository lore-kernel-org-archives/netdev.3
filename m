Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D2140097C;
	Mon, 27 Jul 2026 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167495; cv=none; b=biyAVJYvp/4wtNQ9sQq3z6ayNv3RwmVhIqrDAPBhXxV9VMscVF7c0EVKOi5dYl6mP9al8/nci9/jkxIPllvoAFqAEZaU75x62h75ayno8GN0f1ciTUtUMXutSdFSeVIVFiizy0gofzbswfgssUBjlVaCQ5I2QVI9i0ho0wWd1NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167495; c=relaxed/simple;
	bh=DMbk7odlrLbWcT/0B/AuwO8wR/FQjBsTATVbhYryaVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dq34A6wOlGjQ6flJEccqOvoQE6WhMXUb0o0ts/cCNnvnOxaPnnZEsFaJCI8faMGtUOzE7wzVtvuoXnp4cwGBFMw73g075PJB0ugNGHZaXI5Buu7TPDoR5mqKTmnTLoC0wtQStV4WDZeOrEkgFsrAIS4rBbFHmkUkLAv1PIL17Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4OYg1hI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4OYg1hI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B141F000E9;
	Mon, 27 Jul 2026 15:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785167490;
	bh=bId9mau3ViNmF7rLJyY58n1Xss9ciYxqYMK2+cP9dlA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a4OYg1hIf1OcQiP0ScXw1HAV8yQcwu04sjDwLyHiYLaAW05oqtw9jTleS/RMwxYZc
	 60gLPkbokgTy/uzvdRtSfNH2IPUWBwkE0Np8Kf5pIgKvGueF6Jlxm19yBBBZz/Pblo
	 hgfWZiLVLtYmjAlc+BRJb5EV1tTM4R8OVVnb0W1R1QrnkcM/6PWTI6LIvNyY++TiNM
	 FR0YgemqPs9WzMKEo1xFmWo/Goy8dnCx9D/XXvL+Pow1UTLUWpJ0EVQrdE3eAADfpt
	 F8OLH5OOcx5GK/exFRP2VU2NOgipgoTNy+dHDC/BVXZwaLtsZom1P+otBvZKcDTiOY
	 lyHyAsKsyP8Pw==
Message-ID: <184d7977-891b-4d18-983f-7d23a7d9ff83@kernel.org>
Date: Mon, 27 Jul 2026 17:51:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dt-bindings: ptp: Document TSCSS hardware on Qualcomm
 QDU1000 SoC
To: Imran Shaik <imran.shaik@oss.qualcomm.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Taniya Das <taniya.das@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260727-tscss-v1-0-beed14e72510@oss.qualcomm.com>
 <20260727-tscss-v1-2-beed14e72510@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGPBBMBCgA5AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJp2mE8AAoJEBuTQ307QWKbeaIP
 /ihHTkTW4KsN/DQ945JJbyu5tI0J80Wue7QyyLPglyKfhgb5cLLNPpOC8cCIJsc7+W3i2P38
 s2c1cOH6CYGE7E9ur3Vfme8NW2S2I/Z8VC7bZnzyS23wT17LrsdS/qCpx4o8U+pt/xdXDKph
 EGRYrIEmMpUWvyYzyYKGIe25FtaayIIKpq8eZYyFcp2f/sG5IkOW5uZzHPMPdcm87jU7fyuQ
 rAU2vx9r+ulUfQ/q9Z2roC/ode3l7t2pN7BCBCsUDp6JCrUyZrtT1e7EbA0ZRP3aOBNk2P2E
 DQOgJGjGdO5Yx2Y9LFtltu6JbsBJHi1syGRX3AtQYOMc4Y1WGoeZJmMlvKj2ZqqXNkcWi2DS
 IQEWB0uW6CqFsBBIMGDa+6OzdaVO/uAVXWDWml02Men3CILdI1MbVjoh8ECqYUY7OQ+JJvNN
 vnliuq5WM3Ghd3jg/LZZrxXjdIginRHFQCjIJYLKpLZWm1/iDFedcfzqRNYmTtqscdCNHW41
 oT3Z7BmO9xwdjuwBS6nmS6JJwkbf5Ot2QR4pB/DRU7ZwjT1qHe+9r9gF32wXVQatHNGK/VVu
 sfwOnkdxCWkp/qb2gdQRmZh+SedStWshigH6sNfuHBloF/q+hjMRc8b2m326OZdrbSHwY1Sz
 vti8Hn7n8NjdHO9LKB7BIdjkA9DA5WsqOuVCzsFNBFVDXDQBEADNkrQYSREUL4D3Gws46JEo
 Z9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLueMNsWLJBv
 BaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6eiOMheesVS
 5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wAGldWsRxb
 f3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA6z6lBZn0
 WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9YegxWKvX
 XHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt91pFzBSO
 IpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gUBLHFTg2h
 YnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/JoFzZ4B0
 p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu4vXVFBYI
 GmpyNPYzRm0QPwARAQABwsF2BBgBCgAgAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmna
 YUkACgkQG5NDfTtBYptX+BAApg32CkxwNucNEi8WfWA8oKkW0y8YDuY6ORMo9FWNGiT/OTy0
 vyJrLocrpn86zwfjVp+eCrssPYh8eqJfnWqmYv6ACQtHPYzPZQ3mSo8H97Z01oUxITzCxpXm
 ZkLgPIqtDPcC2E3dPM/fVxcyowM8XsaMA9wcsaUYrta8toOq2b9tKcjleKMfMrm0gQ9u7wUc
 QbLkwj6TCLOwucb07GXzLTNF9PZmaDUpKAZjMjmrW+le+SFvQbhamx0rxLWPR0NWntXpbCn+
 +ACch03p/JyTBVktxFsFyCt7pTPE1kEaeuXBTe/a2D9iQvRxRW19LvuO2e59/u1wYUiH/orz
 wbIC2S4dBsPAPihL3ztOU1yE86GPyQtSE0kU+/7snnLt4QGi6PChf3t5gnNjAzjUUovO8rgI
 c+5yN5heq5loYHgK6OQ9OlHzsPHO9e9MOQcKlFycs1pyijFGzDwdNUm/SchK8iWT2QApTx4A
 K9bCVaboTA2T77QYkRcRJYSsO1alGX0ome/hMLD1daXlkrNUp1HWa3K4iytLRXjCSIorWiGs
 n+q3krnpXu3TFkA8qtOFZMdnIiFuiq1yLT8hptsV5xh1TA2nsVvSYiaCr3q4s4BKjS/KrLDb
 qoxzw8ISjdUp4pA85vb6YLCmb39NgidD+7PmAr65lBNveIFynTgsja1rRQ4=
In-Reply-To: <20260727-tscss-v1-2-beed14e72510@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/07/2026 16:10, Imran Shaik wrote:
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
>  .../bindings/ptp/qcom,qdu1000-tscss.yaml           | 187 +++++++++++++++++++++
>  1 file changed, 187 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ptp/qcom,qdu1000-tscss.yaml b/Documentation/devicetree/bindings/ptp/qcom,qdu1000-tscss.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..39387614ef8939b7840df2f0d5640b9e142fb4e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ptp/qcom,qdu1000-tscss.yaml
> @@ -0,0 +1,187 @@
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
> +  blocks - the Time Stamp Counter (TSC) and the Event Timestamp Unit (ETU).
> +
> +  The TSC block is a timestamp generator that maintains a running counter used
> +  for system timekeeping, and is functional with just the AHB and counter
> +  clocks.
> +  The ETU block is optional and captures TSC timestamps for external
> +  hardware events, each ETU slice binding a slice identifier to an external
> +  event selector. Support for the ETU block requires the additional ETU
> +  clock along with the per slice interrupt and slice subnodes.
> +
> +properties:
> +  compatible:
> +    const: qcom,qdu1000-tscss

Why do you create a new file with exactly the same binding?

Anyway, all comments apply.

Best regards,
Krzysztof
