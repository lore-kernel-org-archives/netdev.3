Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180675;
	b=fCQGC+XXocIOIWvuJ2ZV5M4k1OnY/OluwRvSSjaU2PSCP7O5W5n7cjDT1eVQ1rvj2bQY
	 KNVTJnt0zUQL7RcRKok6f/X2ZBJQen1//mNvt/W+OiFubfmWXoV68LKwMHxhM/26PEBnc
	 gbXnyPco4X5c56vbP1Hr/bbHk8LRJZbO9plJBQv7m6Q2oa4BkGTh0cp0f8JJmxHWUPIZ5
	 CAZqbkd2jSoxvUdH6iSQM0zgJN9i1ISohxhtwJ4Iqbi4SUteja/epJYSIq1aMF7OVSpoo
	 UJm8H2wjhGO659QLxoTWn95QLVyu84XAOkHzDp4ygPltsPfHN5heZzWZFVfDSE3QX0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180675;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Received:Received:From:In-Reply-To:
	 MIME-Version:References:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=LrdgbXUa6z0Y+LQlvYe3uBNAKemA2wKtujkxyMRCSf4=;
	b=3dUXcNQr1czBF3b7/8/KDkbx1i7O2bH27rlbZ+6cPc9WwHBIxGz8wn5HMtc1gZYpc8AK
	 HOX4Qnwt2ExPT6EThWs33V2LdDU/KBELkwNfdXJtKNEYiDThmCCmV86O27cVPoXJzxl5h
	 tRFGjHzr7m+P2hW5xqy1iJ6BMD64lbiOxp+4kLq2jCrE/Y9xtsOhR2QKpF3EMythCr9SA
	 1bKVrNWT8x89+i7EsPG7cRRzmx3XaGsSjReCv7BKA5e55Rp3yec/ZHLEAA2QoDWJurERJ
	 fMY5845COZkRS9X4uzXXEVztqyiGvOVzTnWaDTy21v2rkh8mURB6vEwoYU3mITmesSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9Zptmwz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237A2606A31C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9Zptmwz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33A31F031E6
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793180674;
	bh=LrdgbXUa6z0Y+LQlvYe3uBNAKemA2wKtujkxyMRCSf4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=g9ZptmwzRLs6hFP0ri5PGG/VdS21dkgEUq8MSMOGFMv+llZiFjwZy03nLL6K3RGAE
	 gFWRcjZRVQrIH+G9u41eBqWdRVDsLz+tHZ8K9AfxrletJ8ME5ty0y8BWzJXxAzSmN6
	 C4JY9zJGxt6RKUbQdVqcazolhOePgXfyANE3znaARC6qT8qZY79qpHmGkgDcoLqkaZ
	 CTuEXRS1euNXuQXCCI6N80PByHWzSWR/r/LzzuZIYNb8PXb9G9CU28p0lT/ZFj7ro8
	 eURUyetIdDg4KR+dOp9FLDVxWtZdwCubP6YXIIxy8yUqrS9NIjfpYGjgABhwoKxWLN
	 VHpQp6IoCIbjQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a98f260f85so6094311fa.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 02:44:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwv6ozRR9cbWXmv82pDafU0mhThpIhPjYqEqfrsxJoEpFtmDAYI6cuNwDubzyW7IrSWedXE5S0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuMULdtN4TcrixHJHSf9C1gk3LWGcFGAtTQRb9XRzg42BmrxHn
	WYKW1qp4BuPRZCLcFrweBb0y3od2xLTBZ6K8AJZNp5I4V87phb5Rv8Dkr2mvSz395va508X+u8D
	Rdp4SIBnjqtYwc82ROq+wipChccmwmpm8pSfF3A4phQ==
X-Received: by 2002:a2e:a986:0:b0:3a9:7711:1cd7 with SMTP id
 38308e7fff4ca-3ac9cfae41fmr4295071fa.23.1793180673415; Wed, 28 Oct 2026
 02:44:33 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 02:44:31 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 02:44:31 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261026-b4-pdm_clk_gp_mnd_v2-v2-0-ff8e4bc8d567@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026-b4-pdm_clk_gp_mnd_v2-v2-0-ff8e4bc8d567@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 02:44:31 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeK=BV6WEQNVC5wXo8giAgnrjtdROswXF8Py3BMDLZa2A@mail.gmail.com>
X-Gm-Features: AclHuK-TgPLK5QfzM7dwlPZli1UwVXLAoH6m3aWG7qnH8A2NWOyXFwaC5rx4nH0
Message-ID: <CAMRc=MeK=BV6WEQNVC5wXo8giAgnrjtdROswXF8Py3BMDLZa2A@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] clk: qcom: Add PDM GP_MN fractional clock
 divider driver and DT support
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>, 
	Imran Shaik <imran.shaik@oss.qualcomm.com>, 
	Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	netdev@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 12:29:26 +0100, Taniya Das
<taniya.das@oss.qualcomm.com> said:
> The Peripheral Web PDM block on several Qualcomm SoCs contains a GP_MN
> fractional divider that generates a clock output from the PDM XO4 clock.
> The output can be routed to a dedicated GPIO pin for use as an external
> reference clock.
>
> This series adds the binding, a runtime PM-aware GP_MN divider driver,
> and the GCC, pinctrl, and DT support needed on QCS615, QCS8300, SA8775P,
> and SC7280. GP_MN controller nodes are disabled by default so boards must
> explicitly opt in before the output pin is muxed.
>
> Changes in v2:
> - Add SoC-specific compatible strings with a qcom,sc7280-gp-mnd
>   fallback, map the 0x1000-byte register region, and document the PDM
>   source rates. [#Konrad Dybcio]
> - Use runtime PM and pm_clk for AHB register-access clock management,
>   rely on the pinctrl core's default-state selection, and generate the
>   output-clock name. [#Dmitry Baryshkov]
> - Enforce valid GP_MN duty-cycle constraints and report high-phase duty
>   cycles through the common clock framework.
> - Add and register configurable PDM XO4 divider clocks and their public
>   IDs for all supported SoCs, allowing the source rate to be configured.
> - Split the pinctrl changes by SoC, retain Reviewed-by tags, and combine
>   each SoC's pin state and controller node into one DTS patch.
>   [#Konrad Dybcio]
> - Correct the SC7280 output to gpio60 and disable every GP_MN controller
>   node by default. Add QCS615 support as well. [#Luca Weiss]
> - Link[v1]: https://lore.kernel.org/lkml/20260602-pdm_clk_gp_mnd_v1-v1-0-1522662b6c53@oss.qualcomm.com/
>
> The series is organized as follows:
>
>   1. DT binding for the PDM GP_MN divider
>   2. GCC PDM XO4 divider clock IDs
>   3. PDM GP_MN divider driver
>   4. GCC PDM XO4 divider clocks
>   5-8. GP_MN pin mux support for QCS8300, SA8775P, SC7280, and QCS615
>   9-12. GP_MN DT support for QCS8300, SA8775P, SC7280, and QCS615
>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

What is the merging strategy?

Bart
