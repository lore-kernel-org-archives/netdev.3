Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF06948FF7E;
	Mon, 12 Oct 2026 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810217; cv=none; b=SR6oe55NRkgze2LjorUqIyh8hYCP0MSCr+KjVereTxlcn3qQ/I0KnUACLdJBirfyBypSA34jD3DsU6/+ARQ4f8BJW667Kzo4zPl80CcnnqKna8X+A8wXR7JMsZG7gTVFjrtykk2BPSYvLxYbr5liiPmBSCWuG2gCtys7VZmuthc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810217; c=relaxed/simple;
	bh=9m9FDT/XAVBD8xFJdg2tGVfkZE1F7olLizYFK4racgs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QkDdGg3uHnkeXokawYnFFHZe+JeNtVtr4Yur6b0FQ842dCLoJQSpNCJHN3U0YOBkrQnpjpIbAiCB4Bv3iXeLn8uUwoQbmfCp1YZIQhP/a5euY2soY8bDkl40Dh6Myg1/EBBSmxPX8+eWrTLa5sf1NeN/uyI4x/gfOvIdavlBHIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jh4eiosm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh4eiosm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107E21F0089E;
	Mon, 12 Oct 2026 13:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810215;
	bh=2NDpL4UKIHVdBUlG165h+cOcK8hjaR7et0RQGC29TDQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jh4eiosmXzjEi1kA4EH9tBXN1zGpgHs08rRWhFnF5nil5MO/ciuy/GvBXUWUMzWXU
	 8+euWdmntW+4ID0PBcJIq2yR4Iohe7Kgezai++Zd2NjQZ7wYOr8pW4TZ0BZENdP/Io
	 SLlofAO15pkYTCSYIM9oY85Du34KLeGxytru13MYHpFL+SG0CbLeedxxslunK7keU+
	 m6PNYrMCsGQ6NQ+jZxMqHOEJ0e4cJQ7j3pfbYG1+IoAbI3DqHy/pnhecwIMD1am8dO
	 KPOF5KQ/AVl/UCLAiajwLnilDdhiKHyU/8lGKk+nkdmzVZgJbY67TdUZKIn8Tsq2v4
	 HjxyrrvuKxS6w==
Subject: Re: [PATCH net-next v2 04/11] docs: networking: Document IPQ5424 as a
 supported SoC
From: netdev-bot+sashiko@kernel.org
To: jie.luo@oss.qualcomm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, quic_leiwei@quicinc.com, quic_suruchia@quicinc.com,
 quic_pavir@quicinc.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com
Date: Mon, 12 Oct 2026 13:03:33 +0000
Message-ID: <179181021361.434549.206782627257843642@kernel.org>
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-4-8c7b057e2c43@oss.qualcomm.com>
References: <20261011-qcom_ipq5424_ppe-v2-4-8c7b057e2c43@oss.qualcomm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This finding is not valid; I'm keeping it here only because it is
  marked requires_validation=true.

--

docs: networking: Document IPQ5424 as a supported SoC

This commit adds IPQ5424 to the list of supported SoCs in the Qualcomm PPE
driver documentation. It also describes how the two SoCs differ: IPQ9574
runs at 353 MHz with 6 front panel ports plus the EDMA and EIP FIFOs, and
IPQ5424 runs at 375 MHz with 3 front panel ports and only the EDMA FIFO.

> diff --git a/Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst b/Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst
> index 4ab299a28969..04c48cec66d5 100644
> --- a/Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst
> +++ b/Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst
> @@ -167,6 +167,14 @@ PPE Driver Supported SoCs
>  The PPE driver supports the following IPQ SoC:
>  
>  - IPQ9574
> +    The PPE runs at a clock rate of 353 MHz. The switch core has 6 front panel
> +    ports (port1 to port6) and two FIFO interfaces: the EDMA FIFO (port0) for
> +    the host CPU communication and the EIP FIFO (port7) for the EIP engine.
> +- IPQ5424
> +    The PPE reuses the same switch core as IPQ9574 and runs at a clock rate of
> +    375 MHz. It supports 3 front panel ports (port1 to port3) with MAC0 to MAC2,

[Severity: Low]
This isn't a bug, but this patch documents IPQ5424 one patch before the
driver supports it.

At this commit, qcom_ppe_of_match in drivers/net/ethernet/qualcomm/ppe/ppe.c
only matches "qcom,ipq9574-ppe". The clock rate and port count are still the
fixed IPQ9574 values (353 MHz, 8 ports), and ppe_icc_data covers only
IPQ9574.

The next patch, "net: ethernet: qualcomm: ppe: Add platform support for
IPQ5424", adds the missing pieces:

    #define IPQ5424_PPE_CLK_RATE	375000000
    ...
    .ppe_rate = IPQ5424_PPE_CLK_RATE,
    .num_ports = IPQ5424_PPE_PORT_MAX,
    .icc_paths = ipq5424_ppe_icc_data,
    ...
    { .compatible = "qcom,ipq5424-ppe", .data = &ipq5424_data },

By the end of the series, the driver matches this documentation. There is
no effect on build or runtime.

Would it make sense to move this docs patch after the platform support
patch, so the supported SoC list is accurate at every commit?

> +    and only the EDMA FIFO interface (port0) for the host CPU communication. The
> +    EIP FIFO and port4 to port6 are not available.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43%40oss.qualcomm.com
