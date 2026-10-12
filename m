Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB114A68B1;
	Mon, 12 Oct 2026 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819716; cv=none; b=iFSWUYEYoQio1Edny+qRLAPg/smsAkfqvwqM6+so0VcNB0ibmu/QcUrJ9GL8LnaQ5iBi68nGfJdtpldkWSvb/PaBS5iY6vQYEfQMebvauxFY35ZHhkwd35OiR/VPzbjma4Q5wVP340uGADJB0/2QdNLOsQBYCmNmwoJloANYzhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819716; c=relaxed/simple;
	bh=CvcHpCagw7aiVxZi71wMmvK0LSPx0bhxUYodmC3aIgc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JiBk8a+CI8onwfy/1E14ZtVXbzoEiG1HDr68OQ8j0dqlDKbK4ySFOOD9MPAVuplaxt+nb5ne/ByKEM2Pqm6h6u7CsqJW1TNi4tpd/ZZoRbJVSVmoxJONi59FQNqr5E+/VsJGXUVF8j239KwH10tmVz6841S8w6LmjNQ6Y/qAUso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM4J2rHg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM4J2rHg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0411F0089D;
	Mon, 12 Oct 2026 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819715;
	bh=4nsDm25o7DG9h7olAyIABAQtiGgwDIygOlaQU2Ir5mY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mM4J2rHgntddia5vdn0Z3g1v9UKg7OPewEL0oyjpEMylDkryKhjPQR1HRdsSD3WgY
	 hB4iBYlFYR+8JHQboQo8yGIE6gLP+ukfHUjA4jSM1e77Q2zo/uCLrUWNzMtinV5JIT
	 fV5BbRryCUmpWDN+7KvdKWFZKD+qQEQ+s0o9Vvwjj+lq/a66q+aPVAC1cTNQhZzhzD
	 4xbWErQpAa/Ml8HU1XWSfUuRScke+lOcOwkkjD4hLndRdJw8dUThN6AgWrPci0W+Zs
	 Kd8VEejlOQGMxx/z23mqn7ixzf4A7upXiHFqGNG0EwZ5ywG2KUZcIKtzWQNPJZ1fTa
	 Cl26Di/T+kkSw==
Subject: Re: [PATCH net-next 04/11] docs: networking: Document IPQ5424 as a
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
Date: Mon, 12 Oct 2026 15:41:53 +0000
Message-ID: <179181971340.434549.9619050534779483357@kernel.org>
In-Reply-To: <20261008-qcom_ipq5424_ppe-v1-4-16caf43e44ee@oss.qualcomm.com>
References: <20261008-qcom_ipq5424_ppe-v1-4-16caf43e44ee@oss.qualcomm.com>
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

- [Low] At this commit ("docs: networking: Document IPQ5424 as a
  supported SoC"), ppe.rst lists IPQ5424 as supported by the PPE driver,…

--

docs: networking: Document IPQ5424 as a supported SoC

This commit updates the Qualcomm PPE driver documentation to add IPQ5424
to the list of supported SoCs. It also describes how the PPE hardware
differs between SoCs: clock rate, front panel ports and FIFO interfaces.

> diff --git a/Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst b/Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst
> index 4ab299a28969a..04c48cec66d53 100644
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
> +    and only the EDMA FIFO interface (port0) for the host CPU communication. The
> +    EIP FIFO and port4 to port6 are not available.

[Severity: Low]
This isn't a bug, but should this patch go after the driver patches in the
series? At this commit the driver does not support IPQ5424 yet.

In drivers/net/ethernet/qualcomm/ppe/ppe.c, qcom_ppe_of_match[] still has
only the IPQ9574 compatible:

    { .compatible = "qcom,ipq9574-ppe" },

The clock rate and port count are also fixed to the IPQ9574 values, and
qcom_ppe_probe() applies them unconditionally:

    #define PPE_PORT_MAX		8
    #define PPE_CLK_RATE		353000000
    ...
    ppe_dev->clk_rate = PPE_CLK_RATE;
    ppe_dev->num_ports = PPE_PORT_MAX;

At this commit, ppe_icc_data[] has only the IPQ9574 interconnect paths.
In ppe_config.c, ipq9574_ppe_bm_port_config also still includes the EIP
BM port.

Later patches in the series close this gap:

- "net: ethernet: qualcomm: ppe: Add platform support for IPQ5424" adds
  struct ppe_of_data, IPQ5424_PPE_CLK_RATE (375000000),
  IPQ5424_PPE_PORT_MAX (4), ipq5424_ppe_icc_data and the
  "qcom,ipq5424-ppe" match entry.
- "net: ethernet: qualcomm: ppe: Add IPQ5424 BM buffer configuration"
  adds ipq5424_ppe_bm_port_config.

The ppe.rst text does not change by the end of the series and matches the
final driver. The only concern is that, when bisecting to this commit,
the documentation lists support that does not exist yet.

>  
>  
>  Enabling the Driver

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee%40oss.qualcomm.com
