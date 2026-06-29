Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E3319852
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741483; cv=none; b=Lnv+0esm7PbJIrRWltuc0MkTk5fQcZ7CF1LxfmT5/ukhMv04X8N9EgwvfvPzE//bXxrEQpkgul1YohWMQD9F5Ne7EB0GlBOlxQfipfi+0TQ/qZslD9zizCUDuYe7EVpHghPGqy5xg7tyRX5k8msHCgypNK7tXmzchaQaQ44ahBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741483; c=relaxed/simple;
	bh=UvkvBBzeyeMqgudY2G6gDFJg27JiOFKpvozKSRN3iE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9zYEQ5Y/hFhFwWPYRwl2C56oAZAbHZjs4Q4/U3HUcxb1jb4NjTc7R5jqe2PNCti/DZl/OJ2YDyRpN+NFP/tWsRbFny2p3LaR94o+W88UOQm6JpKIlfbZtfi7FX3fYn7jvgp+VD2uaWQ49HrJo8zq3+Wtk+C39Jr8IKXaF+DPXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51bfb91795eso7410751cf.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 06:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782741481; x=1783346281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDPhNjOsxEQ0DHLYZPQfDHuBKCTUhxYTzus1J/5tEMc=;
        b=jMzWEpT1OMxVCyGhTbUnXICOklGWxGWj7EMH8MhGDNZMYlMAoYY1VGnUdw16777mG7
         RQWLhpB4iSENtfRyzVfSqXnPbvSn21RRDK9TGGBL2rTgfibS31NSjAwKe9flZ/zTxM3w
         KYqtwpFkdIpX4ffEeqnV1IbWeSoux+Vuo4yvqNVWb2/Ajw84YCvd3GVIokFOBd3hbyoN
         PHNWJADiocRNZyp2kskLY8OA6suECbANkgxOcPpbYfPCkWciuu06fV0jlKHSUybqlf8H
         4uXKUab4H7xaLVz8VXjUw8eYx5+kUkgh3jONw90tYrvLPpEbsj8Mlquwf2/F0H9NTIv2
         FTlw==
X-Forwarded-Encrypted: i=1; AFNElJ/18VLS1AtSvTcJeQLWsEOjpQ83VaWYD8LHsfwdST1rio6POXmLQsYThZfXgaD+TXXFrJcQeTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2WQXKHJbubv5FqmhgJ9buR0LApoId33cBQwSnjvc0N5Xpvx3O
	Y1VkcmXd6D0/2E50FSXbjYFN/NqNa7oYaf8tFLZnkNQ5KyVbCFpz12ydff3S/TaE
X-Gm-Gg: AfdE7clww2y1MnEmwO+l90QLm6v+wYUUzJvw/z0QGC1XQ7kVVmkWfpKcwDpO6VkP5hX
	oc+0+ff/sjg3WTqpV2HSVB+KtZ4qLyKsbKzcgy7vE3dEwJPahILHleiM+1Itc65fWpMJaF99Y3r
	CGJd4AluXS9L9ybYsj1BQ4gDhRbgcpERWyN4XoWEU4k1/iCw/RzPQIf9TDPoOWDqSkFplTy+Teb
	zZcMWemPg/9Jp3JggtnhgYm4jjMFkni3hNm88kjeqwrk+jysEWE6w9okq5KKsNQzQJCX21Wmn2a
	8igNlAjREIR2SHwBS9qPywfqdn+J+LfipuLX4I49rWal7x3eQzsuI9XsCG9ZEPxSJwNJhu6KEuK
	AiFQOxEAsOykMSUDMeoCFUVEqyLj/Ob3I43b4QgavRZma6BKReM+MLn+siyupHkbsn9I3mkr0Qz
	D7YMHjFwTh51GohpjqxfJDFMjIRWWpnpi8c5I8kySe2WpGVkRjIPYniw==
X-Received: by 2002:a05:622a:2446:b0:51b:9878:8242 with SMTP id d75a77b69052e-51c0c96fe80mr10782951cf.6.1782741480999;
        Mon, 29 Jun 2026 06:58:00 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f0fd31f327sm14173266d6.2.2026.06.29.06.58.00
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 06:58:00 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9159951f05aso428009685a.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 06:58:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9wX+RyAmWt8m/4w+eeu7Fjz884HcPZ3BqVE+n6J6WZfqzzBo4BIuijfDwIX6x1Xpz5QGYq1rg=@vger.kernel.org
X-Received: by 2002:a05:6102:c93:b0:739:86da:7777 with SMTP id
 ada2fe7eead31-739fa951f6emr430364137.27.1782741103904; Mon, 29 Jun 2026
 06:51:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-qcom-sa8255p-emac-v11-0-1b7fb95b51f9@oss.qualcomm.com> <20260629-qcom-sa8255p-emac-v11-1-1b7fb95b51f9@oss.qualcomm.com>
In-Reply-To: <20260629-qcom-sa8255p-emac-v11-1-1b7fb95b51f9@oss.qualcomm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jun 2026 15:51:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXen+E-Ai51aWBa_KV9W8Fz2cQPpT-FG_kQ7akhrrYa_A@mail.gmail.com>
X-Gm-Features: AVVi8CdHRRLXddfc63bNJYLQ9RF__6zMi6ngPMxYGYM87lHlKy_8kZoakyQBXrY
Message-ID: <CAMuHMdXen+E-Ai51aWBa_KV9W8Fz2cQPpT-FG_kQ7akhrrYa_A@mail.gmail.com>
Subject: Re: [PATCH net-next v11 1/7] dt-bindings: phy: document the serdes
 PHY on sa8255p
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Shawn Guo <shawnguo@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com, 
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>, Romain Gantois <romain.gantois@bootlin.com>, 
	Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	Christophe Roullier <christophe.roullier@foss.st.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Radu Rendec <rrendec@redhat.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Drew Fustini <dfustini@tenstorrent.com>, 
	linux-sunxi@lists.linux.dev, linux-amlogic@lists.infradead.org, 
	linux-mips@vger.kernel.org, imx@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Bartosz,

Thanks for your patch!

On Mon, 29 Jun 2026 at 13:29, Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
> Describe the SGMII/SerDes PHY present on the Qualcomm sa8255p platforms.
> This is essentially the same hardware as sa8775p rev3 but the PHY is
> managed by firmware over SCMI.

So why can't it be reuse the DT bindings, and be compatible with
qcom,sa8775p-dwmac-sgmii-phy?

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,sa8255p-dwmac-sgmii-phy.yaml

> +  power-domains:
> +    maxItems: 1
> +
> +  power-domain-names:
> +    items:
> +      - const: serdes

> +examples:
> +  - |
> +    phy@8901000 {
> +        compatible = "qcom,sa8255p-dwmac-sgmii-phy";
> +        reg = <0x08901000 0xe10>;
> +        #phy-cells = <0>;
> +        power-domains = <&scmi7_dvfs 0>;
> +        power-domain-names = "serdes";

Ah, this uses power-domains, while the existing bindings for
qcom,sa8775p-dwmac-sgmii-phy use a clock.
I guess the clock is the correct hardware description?

Adding to my list of examples for backing a hardware-to-SCMI remapping
driver...

> +    };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
