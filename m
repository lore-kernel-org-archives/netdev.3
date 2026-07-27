Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7655380FF2;
	Mon, 27 Jul 2026 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167614; cv=none; b=FQrIxrYk5k1wRyE1r6QHb4jOaAgcFwM0scdcdVqiZiIsQvFqNfHV//DztduVw4B4s08/3dhVdRZoJGXd2JdGq3zbPqKy2UGysesFkhV4zN5blmm7mCHzpX8e2OiM1zj2bhICKJPtYrn6l7Zeq/S2zjIngJAs6IdvPgzsx5AZyU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167614; c=relaxed/simple;
	bh=BcCPkK4hTFThjU3Ze6VDhi9hazq6jntcPlRoHkyB83Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UA04gfLv6yRWtXXC5V6vEhoBOJyslbMJJduOO7jK6LyasQIu02qgqhFQ06dz5ENfq3XYSZu3lEt1HWn/r4d29YwNK2DlJECl3iygse7wORYnKq6rW6d430Jb5Ugg2GvWjQFtFMxIECkx8LssJ1sIIH/mMiiRVEVxRKGqQsxRiR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNpv1/Rm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNpv1/Rm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7597C1F000E9;
	Mon, 27 Jul 2026 15:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785167613;
	bh=vooLpsP6WqWmrXibOxTMRGe2i7VSYPphSqzRAhGlhks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WNpv1/Rmlpg2ONZR50hrsDLPFaFi32HPhkDmFrPlaXRjo99YCPokBXDh/+kWgaZPW
	 iqw1QoawoL4sqcrk9SEYN3+O5Q7a+tU5u2WUsL45u2y7yYiPCbc2YZrCmWCNVwi9fA
	 3HhkDHkE2D5zRoVmHDpWiGD1RTaSCdwMWf8qRxwOU4G/8kj21LWzo5evu70g+8Arus
	 qo3JLRshI6JNxbs+qhcKgbKHbv3TvO9vQ+6VT6CAX6zaLNts4h7z7znu+SqIcNm4iJ
	 BI1afGZb5fP/xBCtPBqg3GGw86D30Ia0nAI9SXvWMjzrUAB45H/YUtO57lIfwluNgy
	 IRBx35SUAIcQA==
Message-ID: <c2a7c6fe-60bb-49b7-b877-20fbf948b5de@kernel.org>
Date: Mon, 27 Jul 2026 17:53:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] ptp: qcom: Add PTP driver for the Qualcomm TSC
 hardware
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
 <20260727-tscss-v1-3-beed14e72510@oss.qualcomm.com>
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
In-Reply-To: <20260727-tscss-v1-3-beed14e72510@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/07/2026 16:10, Imran Shaik wrote:
> Add a PTP Hardware Clock driver for the Qualcomm Timestamp Counter (TSC)
> hardware found on Qualcomm Lemans and QDU1000 SoCs. The TSC is a free
> running hardware counter used for time synchronization, clocked by an AHB
> configuration clock and a global counter clock, with the counter resolution
> varying across SoCs.
> 
> Co-developed-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
>  drivers/ptp/Kconfig        |  10 ++
>  drivers/ptp/Makefile       |   1 +
>  drivers/ptp/ptp_qcom_tsc.c | 413 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 424 insertions(+)
> 
> diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
> index b93640ca08b7286fd4298519a17d1daf19056498..d3ceb1ee01a505cdd0bd056649d245308fc9f140 100644
> --- a/drivers/ptp/Kconfig
> +++ b/drivers/ptp/Kconfig
> @@ -263,4 +263,14 @@ config PTP_NETC_V4_TIMER
>  	  synchronization. It also supports periodic output signal (e.g. PPS)
>  	  and external trigger timestamping.
>  
> +config PTP_QCOM_TSC
> +	tristate "Qualcomm TSC as PTP clock"

Missing depensd on ARCH_QCOM

> +	depends on COMMON_CLK && PTP_1588_CLOCK
> +	help
> +	  This driver adds support for using the Qualcomm Timestamp Counter
> +	  Subsystem (TSCSS) as a PTP clock.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called ptp_qcom_tsc.
> +
>  endmenu

...

> +
> +static const struct of_device_id qcom_tsc_of_match[] = {
> +	{ .compatible = "qcom,lemans-tscss", .data = &qcom_tsc_lemans },
> +	{ .compatible = "qcom,qdu1000-tscss", .data = &qcom_tsc_qdu1000 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, qcom_tsc_of_match);
> +
> +static void qcom_ptp_tsc_remove(struct platform_device *pdev)

Completely broken order of ID table, remove() and probe(). Remove ALWAYS
follows probe. Table is next to them. Please look at other drivers.

> +{
> +	struct qcom_tsc *tsc = platform_get_drvdata(pdev);
> +
> +	if (tsc && tsc->ptp) {
> +		ptp_clock_unregister(tsc->ptp);
> +		tsc->ptp = NULL;
> +	}
> +}
> +
> +static int qcom_ptp_tsc_probe(struct platform_device *pdev)
> +{
> +	const struct qcom_tsc_soc_data *soc;
> +	struct qcom_tsc *tsc;
> +	struct resource *r_mem;
> +	int ret;
> +
> +	soc = of_device_get_match_data(&pdev->dev);
> +	if (!soc)
> +		return -ENODEV;
> +
> +	tsc = devm_kzalloc(&pdev->dev, sizeof(*tsc), GFP_KERNEL);
> +	if (!tsc)
> +		return -ENOMEM;
> +
> +	tsc->dev = &pdev->dev;
> +	tsc->soc = soc;
> +
> +	ret = devm_mutex_init(&pdev->dev, &tsc->lock);
> +	if (ret)
> +		return ret;
> +
> +	r_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "tsc");
> +	if (!r_mem) {
> +		dev_err(&pdev->dev, "no IO resource defined\n");
> +		return -ENXIO;
> +	}
> +
> +	tsc->base = devm_ioremap_resource(&pdev->dev, r_mem);
> +	if (IS_ERR(tsc->base))
> +		return PTR_ERR(tsc->base);
> +
> +	tsc->ahb_clk = devm_clk_get_enabled(&pdev->dev, "ahb");
> +	if (IS_ERR(tsc->ahb_clk))
> +		return PTR_ERR(tsc->ahb_clk);
> +
> +	tsc->cntr_clk = devm_clk_get_enabled(&pdev->dev, "cntr");
> +	if (IS_ERR(tsc->cntr_clk))
> +		return PTR_ERR(tsc->cntr_clk);
> +
> +	/* ETU clock is optional, only required when the ETU block is used */
> +	tsc->etu_clk = devm_clk_get_optional_enabled(&pdev->dev, "etu");
> +	if (IS_ERR(tsc->etu_clk))
> +		return PTR_ERR(tsc->etu_clk);
> +
> +	tsc->ptp_info = qcom_ptp_info;
> +
> +	tsc->ptp = ptp_clock_register(&tsc->ptp_info, &pdev->dev);
> +	if (IS_ERR(tsc->ptp)) {
> +		ret = PTR_ERR(tsc->ptp);
> +		dev_err(&pdev->dev, "Failed to register ptp clock\n");
> +		return ret;

Why aren't you using dev_err_probe?

> +	}
> +
> +	platform_set_drvdata(pdev, tsc);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver qcom_ptp_tsc_driver = {
> +	.probe  = qcom_ptp_tsc_probe,
> +	.remove = qcom_ptp_tsc_remove,
> +	.driver = {
> +		.name = "qcom_ptp_tsc",
> +		.of_match_table = qcom_tsc_of_match,
> +	},
> +};
> +module_platform_driver(qcom_ptp_tsc_driver);
> +
> +MODULE_DESCRIPTION("PTP QCOM TSC driver");
> +MODULE_LICENSE("GPL");
> 


Best regards,
Krzysztof
