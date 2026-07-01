Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D900841B36D
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902351; cv=none; b=QcClyuTPOcWKVfxd5SY6HmS04ln5XEk98T9Dxn1pA3J0TdG6dwoN9XUm69O+nX98XRCh7CD77vndVz09t+WgDnGjhdw3wilgwbYSLsZWi7B0w7ljTry5IKmXqOIG004GqZ/1VUmRLmzDLtoJ0YJP7/3DsG+P8yMrNseaChHdz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902351; c=relaxed/simple;
	bh=b9vuwMyD1HJfB1Gx1jfRWFDVOFEuo0lYXOfJPkGdUSI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rt2JSHWi5oCsZiiK3UmQKBiqiuOgnZeAjSqSoqiRh3f8ZD96izfB/6Xq98l9AEe6/PEy2fc03LcZ7SOh0CiIbfpS1jDxRgGpuY4twEdf0gfqY0sK2059vF8OOaWX2z4KRU9GqxhCTsHr5pcWb2xSXPllwWGXTv/onaIV/ws/Cfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvmIMQlp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvmIMQlp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC7A1F0155B
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782902348;
	bh=q4Mw1ewD/jb3yXkm243uxaRWKqoUXL01sdFnsTQHgvY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=CvmIMQlpDPun8oKUF6snfTgD5R960tQ39+Ad7gri+Glzo8M3xcUmIR/X/ChVXo/NM
	 LoBkt8GTKKxOJnKW8icgGzjR+KTlrxKeiu1OZOpzSQ9BahiOOvwcXZ6Uz2w8/KYIqt
	 5VJj7HSvLi0ub+uEPGKsvoJQROh/cFbWhe+FazUqVutSc5DVw944YTwxbbd7aZB3z4
	 2JWwgkQM538t/UZSdLP8CHDFRFmJw/hlH1T3TwFf1xJSvK8HsTtarZ2Y0umGA0QNZc
	 v4REPnfaTuzUCQABmQV4nHd2lj6bZ8npdl9tiDVtlygmu9uuzv8Jy9bVpHCYrzBRSQ
	 +5m7bRYHZ8lOA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aebba706b3so448605e87.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 03:39:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RopmK/mCcCj0QOcfrQneHrhxrclk1Wx12r9HBYhSiujeuekkZC1WoXPkTP8Rm40URwY3y8WXYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQXG3GCZTfoLfw1XPEk9qnwVdrZNMhHXN3EcWlzZVTPYbDrnuW
	8x8rRS3+UgLwKT8WdmTJB498sCSwp0J53QiJf6W3kTi1rSFhcI/Pv9/15NuF7prWnPz2ew2TX0J
	oLG90/dfVmhstpK5aiCKwFbDJdmXZL92+KGupFVfrPA==
X-Received: by 2002:ac2:568a:0:b0:5ae:9fb4:6740 with SMTP id
 2adb3069b0e04-5aec742dcbemr246886e87.46.1782902347033; Wed, 01 Jul 2026
 03:39:07 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 05:39:04 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 05:39:04 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAMRc=MfgAB8bc6PD-6jw_KR0uNBfH+PO2XtCeL1SUF2nCiT0xg@mail.gmail.com>
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
 <akOZFIowVvprnAMf@vaman> <CAMRc=MfgAB8bc6PD-6jw_KR0uNBfH+PO2XtCeL1SUF2nCiT0xg@mail.gmail.com>
Date: Wed, 1 Jul 2026 05:39:04 -0500
X-Gmail-Original-Message-ID: <CAMRc=MfA3OuuUUb063hAaN-0Byt=ToEf+uLtcR2DoqED6dZ+Nw@mail.gmail.com>
X-Gm-Features: AVVi8CdM4YB1YNAKK21RhumfGngKAr8KUFWynreeOPd7b_5_r_J6FsxJ2sTmC58
Message-ID: <CAMRc=MfA3OuuUUb063hAaN-0Byt=ToEf+uLtcR2DoqED6dZ+Nw@mail.gmail.com>
Subject: Re: [PATCH net-next v11 1/7] dt-bindings: phy: document the serdes
 PHY on sa8255p
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Bjorn Andersson <andersson@kernel.org>, 
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jun 2026 15:44:16 +0200, Bartosz Golaszewski <brgl@kernel.org> said:
> On Tue, 30 Jun 2026 12:23:16 +0200, Vinod Koul <vkoul@kernel.org> said:
>> On 29-06-26, 16:51, Geert Uytterhoeven wrote:
>>> > Russell King asked me to put the PHY logic for SCMI pm domains into the PHY
>>> > driver instead of the MAC driver where it was previously. Instead of cramming
>>> > both HLOS and firmware handling into the same driver, I figured it makes more
>>> > sense to have a dedicated, cleaner driver as the two share very little code (if
>>> > any).
>>>
>>> I think you are mixing up DT bindings and driver implementation?
>>
>> Should the bindings change if we have different driver and firmware
>> implementations? Isn't binding supposed to be agnostic of
>> implementations..?
>>
>
> The way sa8255p implements SCMI is with SMC exclusively but - since even base
> support is not yet upstream -  maybe it would be possible to expose SCMI clocks
> like some platforms do and reuse the same binding.
>
> Would it make sense?
>
> Bart
>

Scratch that. The firmware on sa8255p does not expose SCMI clock protocol, we
can only use devfs with this PHY so it's either the same binding document with
different properties depending on compatible or two separate bindings. I prefer
the latter because it's cleaner.

Bartosz
