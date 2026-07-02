Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667BC35CB81
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985499; cv=none; b=fUpaEcfGfVBgmkUR7jZd7aw2NYxGzCufgH9G+0czTtRt1r7vFl/1IrPMBb1EH4ssUmSx767xOhMXW4XhRoS7d0Ohhj0ppapTh96u2WkysCaoBcWlANHC9Rt8mpMJyzGAYrp10KpyE7BDHjcuVmu5Mt3zBHP5x7MbLB67N9P0vKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985499; c=relaxed/simple;
	bh=ECZSUW9hSj34SFz4G8bfbFkApIByTwPPDgQgHBlg2lY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umMYXSizRM2JDkPvHnKAoe5VARNdJGTEUPd3BTTBKgBeU9DQ9TLx2l6vxhVAIy6OI1/EJUVbak12CYfmcP+ehnHvf4vmZx2oGjNLNn8JE08PbeLfoyrMsA7VyDc6IratugezQcaHIjIUA/8pPLbxDIejH1oqF+39NRFltuGpn0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CM1pHfbL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CM1pHfbL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5721F01558
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782985498;
	bh=ECZSUW9hSj34SFz4G8bfbFkApIByTwPPDgQgHBlg2lY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=CM1pHfbLgxMYkSotRohphHAwfHiS2Jq6WgdNtLNVx9uS9WhtbtNpBou5sFbv3Zfbs
	 t4EYEkBRrQ2RPOdC3sKXIYU/bXdz1i/2PmuYsFxoCMwyYQGcvrEq342mZyLtAsgOpG
	 w/sfT7k5FjdRPizXj5j9sXzzoLSxaH4bXp0ZuISOJV1Aj9GCea4PDHBExCwb2cLFYk
	 vD2m1iI2wTjiyqshwUVGQuj011ZBWZgfKMQS8l8tVqa50gCgevokuKhUvpXzlG1EZ+
	 4tnuwDISjYXV/puQzCG1Qd5pr3KEdBJbwvMtN8gpQX6Ik/85EwSf3YqBWFGGYzSx4P
	 2QjvHhzDq8Dhw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39b293079d1so15739511fa.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 02:44:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrjHAGRkE4G6x5jS/2Wm3/G5CFFJKy4U7O+xxFK2TwSrZOEjMg5MZBq0TcJhTa5VG4Fjd7iYyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUBNIqe8k7r1Iu8wZS2JkwOxAea1JQ+Y+XTRZxLK31xRNGZcko
	go0VrTMkvFwI0zKO7YJ0uCCF5GsbdVd2Hqe4Rs0I7EmoTywnu9REXjQe7p0Vddl2WeBNjXGl+Tg
	0LSM/nn9b5mRnedUvhcNj9hhM8pRZaXM3r4m8YlbtuA==
X-Received: by 2002:a05:651c:2129:b0:39b:128e:ae5d with SMTP id
 38308e7fff4ca-39b36e539cdmr10506381fa.9.1782985496830; Thu, 02 Jul 2026
 02:44:56 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Jul 2026 04:44:55 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Jul 2026 04:44:55 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAMuHMdXNG=C=XcioQUEN1M7cQgKhO0AxUyg5X+TWb2rQ3-H3fw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-qcom-sa8255p-emac-v11-0-1b7fb95b51f9@oss.qualcomm.com>
 <20260629-qcom-sa8255p-emac-v11-1-1b7fb95b51f9@oss.qualcomm.com>
 <CAMuHMdXen+E-Ai51aWBa_KV9W8Fz2cQPpT-FG_kQ7akhrrYa_A@mail.gmail.com>
 <CAMRc=Me3jaZXiXa1sFXr=8Do4sCd+XN1pKTcWC8-0j78SjCkKA@mail.gmail.com>
 <CAMuHMdVUBgG0EFB16OxHisbxx-sBvDKvBPNZdpyDnmBrnX4ptQ@mail.gmail.com>
 <akOZFIowVvprnAMf@vaman> <CAMRc=MfBcOhbj=ETxy2Xz9o_nyzykrEhKAc3jYi6V5_jMZEE3Q@mail.gmail.com>
 <CAMuHMdXNG=C=XcioQUEN1M7cQgKhO0AxUyg5X+TWb2rQ3-H3fw@mail.gmail.com>
Date: Thu, 2 Jul 2026 04:44:55 -0500
X-Gmail-Original-Message-ID: <CAMRc=MfwB_51OLjX_19eagZ1m3UUM2iHny5rx6besR6+Np_A0g@mail.gmail.com>
X-Gm-Features: AVVi8Cfm4QcPsY-kBu80DyHJVbYDW8Jkdy81l2_sPTIAALqyBLBgGUF_GjAGTTs
Message-ID: <CAMRc=MfwB_51OLjX_19eagZ1m3UUM2iHny5rx6besR6+Np_A0g@mail.gmail.com>
Subject: Re: [PATCH net-next v11 1/7] dt-bindings: phy: document the serdes
 PHY on sa8255p
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com, 
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>, Romain Gantois <romain.gantois@bootlin.com>, 
	Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	Christophe Roullier <christophe.roullier@foss.st.com>, Radu Rendec <rrendec@redhat.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Drew Fustini <dfustini@tenstorrent.com>, 
	linux-sunxi@lists.linux.dev, linux-amlogic@lists.infradead.org, 
	linux-mips@vger.kernel.org, imx@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Jul 2026 11:16:22 +0200, Geert Uytterhoeven
<geert@linux-m68k.org> said:
> Hi Bartosz,
>
> On Thu, 2 Jul 2026 at 11:12, Bartosz Golaszewski <brgl@kernel.org> wrote:
>> On Tue, 30 Jun 2026 12:23:16 +0200, Vinod Koul <vkoul@kernel.org> said:
>> > On 29-06-26, 16:51, Geert Uytterhoeven wrote:
>> >> > Russell King asked me to put the PHY logic for SCMI pm domains into the PHY
>> >> > driver instead of the MAC driver where it was previously. Instead of cramming
>> >> > both HLOS and firmware handling into the same driver, I figured it makes more
>> >> > sense to have a dedicated, cleaner driver as the two share very little code (if
>> >> > any).
>> >>
>> >> I think you are mixing up DT bindings and driver implementation?
>> >
>> > Should the bindings change if we have different driver and firmware
>> > implementations? Isn't binding supposed to be agnostic of
>> > implementations..?
>>
>> I've thought about it some more and I believe this question is philosophical in
>> nature.
>>
>> sa8775p and sa8255p are *the same* hardware. I can flash different firmware on
>> the same Lemans Ride board and it becomes one or the other. Yet they are not
>> described by the same DTS and the bindings differ as well. I don't see why we
>> wouldn't allow the same approach for the this PHY.
>>
>> We treat it as different HW variant when it's managed by firmware - just like
>> we do with the rest of the SoC.
>
> DT describes hardware, not software policy.
>

I'll defer to DT maintainers then for that particular case because it affects
more than just this platform. For instance: Qualcomm Nord[1] is already being
upstreamed with a similar split into common parts and then sources specific to
the SCMI and non-SCMI variants - even though it's the same SoC.

Bartosz

[1] https://lore.kernel.org/all/20260526051300.1669201-1-shengchao.guo@oss.qualcomm.com/
