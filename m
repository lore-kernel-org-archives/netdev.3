Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465780;
	b=h1mCPVOGtH6qFfzqWx3+Knm6zvONUxIztVRn59v3l4UUOMgFnBJfp9zt+kanbOSdFug5
	 /KwFTbp70NCKLPtxRa/H+Mt4fVwOhJMnM9S4OfpchrKZWURs6WI5PR6X8b0T9gG+ZiAAt
	 c60SSem6dkAujI+4AooDECGjxUhqzf0U68Iv0FTL9yObPR+AaEUQItzj0qqkba5NTbH3b
	 VZ39GC9kOKiqnaB5yVfZAnvjU6Cxinsh7J38uOEIJSHKchtvEciPZzL2xuH5XvC0JTO5+
	 +AgB5AI5DWaVGxWX2dZaRY3qcAttOZAdWZGbMPZ+aiQwvCNUU5RJ7mVlCAeNeMwDeYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465780;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ve17lLZjmHFU7QkEK3uFrRJlrH3bqy8ujTXSTOq1L2E=;
	b=CiRyUDyPUZlzjnSZHFemYrg62IzTUJIJUXQQ5lg3UOKjb2ioF2xTXnr2VuKSUMvGUKM1
	 yHyI9FsiVJhXRjVXumHXMo5dI9Uw+KLegjynRGlkeCYt77y4qToVE+o0JNE2ox9EK/kHR
	 TViz1E4RgQ4Vf4tvF6TPJ9MVU19sp6btLPagJT4RhNMP81vR1Du6n4PGvhzTbtjmf6IR3
	 ueePpXUzZlCmIgnzQegZ8i0rccrsuHwbGrSWEmiTg/D3bEy4TGiLmSI9KhMVD3EQmX8kR
	 0yeH/nvdvzwMFxe3SU+8/qc3nWvJn59PlH2FURGnuB1ejPzLXMdUP26fiaIKLFwy0Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQAz7e2V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6170D606A33B;
	Tue, 20 Oct 2026 03:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQAz7e2V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011F31F000CB;
	Tue, 20 Oct 2026 03:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792465779;
	bh=Ve17lLZjmHFU7QkEK3uFrRJlrH3bqy8ujTXSTOq1L2E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KQAz7e2V3PQA3JBzvBgMs4fjiDS+tXq3Hr4EphjWWNY0HgyBOC9GxT9bI4qW/kLEH
	 PqeNurGjKuY99pNbDjfqPCnsm0yYjCdmZPeoIUL53fieNeRcBng44S9NMfyQwCe3yp
	 JvVVN7TN9zlbL8gxOF0DhnbRb8PBSTytaphtxe0SaBnVooFTSnakbVEpyuBTCS2Czx
	 I8Xhot/eFPARk7MKi/zIYFsf1mv5DI5jfY+t16XI2IXkqOZutNl0fJPFh0l74nROfk
	 fP8Wa5c2qqpEbXwy3r072ZhRwvQkNdt1CTdlZu6W3XTjKrA6mxWHQFtv8FPIxg4/4G
	 mQMpeiV600vRA==
Subject: Re: [PATCH net-next v14 02/12] dt-bindings: dpll: add SiTime SiT95316
 clock generator
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 03:09:38 +0000
Message-ID: <179246577843.3135.4737368277316143256@kernel.org>
In-Reply-To: <20261016005823.13690-3-arouhi@sitime.com>
References: <20261016005823.13690-3-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The shared DPLL pin property `supported-frequencies-hz` now
  uses two incompatible cell widths, depending on the device.

--

dt-bindings: dpll: add SiTime SiT95316 clock generator

This adds a devicetree binding for the SiTime SiT95316/SiT95317 clock
generators. They are I2C-controlled DPLL providers with four PLLs, up to
eight inputs and up to twelve outputs. The XO is given either as a clock
or as clock-frequency, and the supplies are named after their pins.

> diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml
> new file mode 100644
> index 0000000000000..9a8163d121f24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml

[ ... ]

> +            input-pins {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                /* IN0P and IN0N: pair 0 runs single-ended */
> +                pin@0 {
> +                    reg = <0>;
> +                    label = "clkin0";
> +                    connection-type = "ext";
> +                    supported-frequencies-hz = <10000000>;

[Severity: Medium]
Should this entry, and the other supported-frequencies-hz entries in this
example, use /bits/ 64 like the existing binding for this shared property?

The property comes from dpll-pin.yaml, which gives it no explicit width:

  supported-frequencies-hz:
    description: List of supported frequencies for this pin, expressed in Hz.

The only other user, microchip,zl30731.yaml, always writes it as 64-bit
cells:

  supported-frequencies-hz = /bits/ 64 <10000 10000000>;

Its driver also reads it as u64:

drivers/dpll/zl3073x/prop.c:zl3073x_pin_props_get() {
    ...
	num_freqs = fwnode_property_count_u64(props->fwnode,
					      "supported-frequencies-hz");
	if (num_freqs <= 0) {
		num_freqs = 0;
    ...
}

This example uses 32-bit cells. The SiT9531x driver later in the series
reads u32 on purpose in sit9531x_pin_props_get():

	/* A -hz property is 32-bit; no rate of this part needs more. */
	num_freqs = fwnode_property_count_u32(props->fwnode, "supported-frequencies-hz");

So the driver in this series and this example agree with each other. The
shared property, though, would now be encoded differently depending on the
device.

Suppose a SiT95316/7 board DT uses the existing /bits/ 64 form, for
example /bits/ 64 <10000000>. Wouldn't sit9531x_pin_props_get() read that
as two u32 values, [0, 10000000]? For an input, curr_freq = freqs[0] would
then be 0, and the wired rate would never reach sitdev->ref[index].freq.

The reverse case is also a problem. A reader that follows the u64
convention, such as zl3073x or a future shared DPLL fwnode helper, would
fail the element count on the 4-byte SiT encoding and silently skip the
property.

It is not clear whether dt_binding_check would reject the 64-bit form
under the maxItems: 1 constraint in input-pins. That depends on how
dtschema decodes -hz properties.

Could the binding and driver use the same 64-bit encoding as
microchip,zl30731? Alternatively, could dpll-pin.yaml define a single
width for this property?

> +                };

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016005823.13690-1-arouhi%40sitime.com
