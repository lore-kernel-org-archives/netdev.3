Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126863;
	b=BMMRAmOGCF8J3jyuFJpIZ5QgWANKg4MWE+IZRTFUEnc3z4mHBX7YjZUbsQFQQwYYLkRU
	 XvjimbWZcgtle1tqLbPUJV6woq3dBoxMBSoW9s2H8cT4Ak+EeS0iiHYAAczvDLNvnThM2
	 GVKrAsTn+1vk8bfRYN/T87KFV3xjQawWSZ14UWfhXSRLQHAdGTfTmH5R5VuvicgEtwVXF
	 zt423x1ATdyAaxQOStPPdjUZ6HN65oxFCCGof12A5XyBe0ObdooGbgLpdwXIIRmiaFYcg
	 IOQY/fZGwsapy/qZgZWAwe9Z0f7+o5iyopfcNqaAdKevSu4ncGTuMyqdOR2rrnmUnig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126863;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0qhzg2EwORmkMVCDp5YuggGXSTQZPJfFE6qUzVOGdyU=;
	b=XmtGhT7LnHBP2rdlW8VbUbbcYLgK9WbOHgESSGM8eZtgWHdsZer0/BUbzV6yOGvl5MMI
	 qI2ysTXAX3Z9WA13Bhx6XEj1FRd+JQEYe0gBq6OCxcuacEN+nzpTCnN98UwspMKMlnIVA
	 kIOH8Tgz3hSaNaY3wZ1r+euVFdNLS96GbYeTn2vqYdB5PeHpaTO2wTXjiOsW95EC1U9Oq
	 nEaYqDH5VdAt/uP3MACr4c5+jjWc9oaqwQ0TLBCnouB7u9zdzBelmhpA/MPNm0ew8f0ua
	 qOBUN0hqTu20Kp0OrO5jBxlYZK3AFBbIF6wI3qZaDx/nkGtVI+XWLut6SmW/nuIa+hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojAow+ie;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0662606A31A;
	Tue, 27 Oct 2026 18:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojAow+ie
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B1B1F01825;
	Tue, 27 Oct 2026 18:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793126862;
	bh=0qhzg2EwORmkMVCDp5YuggGXSTQZPJfFE6qUzVOGdyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ojAow+ieUh/EOpAg3bYdgQjiHFFB3Qxr6m6PsLche8O/YCbSm/53/GKM3HMZuaI9x
	 Em3yk3GzQTeL1WGR/FoQfwQ49+TUqHSpD4woTE5INztRADnwNu12e1FgTwmC6bkq1w
	 1tPtfE1L7nKhqK+cZlM6VPzVR+OeuQSVUTcDi26D38rDTHOauDmqo7JRU3UluWlo6I
	 XzZWMcCI0M8j8qtel1MSkuO44ewrsjn0bAG2z360ZthvoFVdSUKOLFaAcGmYE1x2Cl
	 tH40ofNtWkFz/3iRjGSXe5je0anY/dsvu1ib7saTEIvwT77nw74u32qGCdC0gsPPnY
	 PRebnwj+FHp3A==
Date: Tue, 27 Oct 2026 19:47:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey <ajit.pandey@oss.qualcomm.com>, 
	Imran Shaik <imran.shaik@oss.qualcomm.com>, Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 01/12] dt-bindings: clock: qcom: Add bindings for PDM
 GP_MN clock divider
Message-ID: <20261027-inescapable-rough-viper-6cd56d@quoll>
References: <20261026-b4-pdm_clk_gp_mnd_v2-v2-0-ff8e4bc8d567@oss.qualcomm.com>
 <20261026-b4-pdm_clk_gp_mnd_v2-v2-1-ff8e4bc8d567@oss.qualcomm.com>
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
In-Reply-To: <20261026-b4-pdm_clk_gp_mnd_v2-v2-1-ff8e4bc8d567@oss.qualcomm.com>

On Mon, Oct 26, 2026 at 04:59:27PM +0530, Taniya Das wrote:
> Add device tree bindings for the Qualcomm Peripheral Web's PDM GP_MN
> clock divider. The hardware generates a fractional output frequency
> from a fixed input clock (typically TCXO4) using the relation
> Fout = Fin * (M / N), with duty cycle controlled by a separate D
> register. The clock output is routed over a gpio controlled pin.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/clock/qcom,clk-gp-mnd.yaml | 98 ++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,clk-gp-mnd.yaml b/Documentation/devicetree/bindings/clock/qcom,clk-gp-mnd.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..8141f392c5d70acfc42cf1ff4b1722e1eff23afa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,clk-gp-mnd.yaml

Use fallback as filename, so qcom,sc7280-gp-mnd.yaml

> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,clk-gp-mnd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Peripheral Web's PDM GP_MN Clock Divider
> +
> +maintainers:
> +  - Taniya Das <taniya.das@oss.qualcomm.com>
> +
> +description: |
> +  The Peripheral Web's PDM GP_MN clock divider receives an input clock
> +  (TCXO4) with frequency Fin and generates an output clock with
> +  frequency Fout = Fin * (M / N) and a duty cycle controlled by D
> +  and routed over a gpio pin.
> +
> +  The divider is configured using three registers:
> +
> +  - GP_MN_CLK_MDIV: holds the M value.
> +  - GP_MN_CLK_NDIV: holds the ones complement of (N - M).
> +  - GP_MN_CLK_DUTY: holds the D value.
> +
> +  For every N input clock cycles the GP_MN produces M output clock
> +  cycles. D is the number of native clock cycles in which the GP_MN
> +  output is low, counted over 2^13 native clock cycles.
> +
> +  Hardware constraints:
> +
> +    M <= 511
> +    N <= 8191
> +    N > 2 * M
> +    M < D < (N - M)
> +    M and N must be coprime (no common divisor)
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: qcom,sc7280-gp-mnd
> +      - items:
> +          - enum:
> +              - qcom,sa8775p-gp-mnd
> +              - qcom,qcs8300-gp-mnd
> +              - qcom,qcs615-gp-mnd
> +          - const: qcom,sc7280-gp-mnd
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: PDM XO4 source clock
> +      - description: PDM AHB bus clock for register access
> +
> +  clock-names:
> +    items:
> +      - const: pdm_clk

pdm

> +      - const: ahb_clk

ahb

> +
> +  '#clock-cells':
> +    const: 0
> +
> +  assigned-clocks:
> +    maxItems: 1
> +    description: Parent clock phandle used to set the input frequency.
> +
> +  assigned-clock-rates:
> +    maxItems: 1
> +    description: |
> +      Rate for the parent clock in Hz.
> +      Supported rates: 19200000, 9600000, 6400000, 4800000.

Neither assigned-clocks nor assigned-clock-rates should be needed.
Parent clock is outside of scope of this binding.


> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +  - assigned-clocks
> +  - assigned-clock-rates

And these two should not be required, either.

Best regards,
Krzysztof

