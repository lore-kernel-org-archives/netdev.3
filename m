Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC733A6B7F
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984280; cv=none; b=LLQWX6YOnYkoCZHrjgAf500/EF5RPOf8e3hUaZQUCn9Ml8kC24DE8ircaGfZgwOUQGfE5anSO3WxSVWx6BgEU9sxKK39FXwMhycjS+LrEQJnfYvgABNGIByqMT0k3M36N67/sCVYZWIHfKtDeIwM40EybUVNrvlL64UDj+fa+Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984280; c=relaxed/simple;
	bh=n9yLVv4ONKzRdpCf8VFwTS/MdDc1G1FjImPOjJ/IqKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a98OpXxZqUgrDH0dm1OSoLecORw0C5f8R0rk0N3Z+Wjb5uY2KMF9RWQiBv7fdVNbZnoHExkkDZdvp4bTfmjr76v5uJ6OYu7SXvogmy78Wy6TQ9fwOILGt/aenCJ+/ME86EmHTqI67773pahqXYQGVu1pA/CFIiOePIp4XhTYrJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so15162325ad.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 02:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782984279; x=1783589079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3iqz34neGUxAgVEYrpwzzcpe57aRQt9k5cgKzpkuWc=;
        b=XIDEuowIuoeon7DE0CSiZ8ZuQlAKmO4600JY7zvXaCwgvHKvb2uXp7QHZUO6BZ1WaK
         pYYR99C0IPsEqJlLzzlQOIS7UEE7T7FmeewMGMXhPl8FI7zGClkcOVDlWrxo9Hullqwi
         ZPzRQS8wIOi+/f6+5AbMOV7RctgKqFl7zc+C/N6rcVX9AYRhFiDhyBdYE1u2SEgsWvrx
         X4VNzLA8b2RXHXqkVmyqKpDTXRP2W3tqYxn6RNVB5sEj2TecCJy2Xf7GiD4jc02/5cNc
         3cxijUd/TKarjFonoaVp46yKZjSsX41/Oz0yrvd61EhBZBtpAJ/eRsqOfiZSOcnGSb8X
         Jh5A==
X-Forwarded-Encrypted: i=1; AHgh+RroxMVUpfKeHv7yJ/5tfCMnQbfns4WPznEMciN6KK6o627bPj0SeGx3QrrfFn0YTvZYb9yomQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxckYQlUBGrbmj5OyaKrE2O0o5SBB6cCc1VmELAlHqhUwccIR1P
	MFL2OsVoi+LGjN48SrByCUxt4IiGe3O9wew+wCkOoRRq20OQN1Ca9nNMfdRSFen1cFU=
X-Gm-Gg: AfdE7cnJn3stsGXChazYJNlwy8Qjz7BIlyirX2m+m8nQ+pFmgRb3p/BMm22Lyi8wmYR
	ISQfuzlVAuk4K0nVHTW8k0Vi6D/6f8zwBUimt06eeWldmDePG9bsuL0T5NqtPn34dwofBuIl2n6
	dfbIGEeiheruSe0dZUX6PBGXP3M5a4upfc+djAh4OBP4gIvx5fRVLH2FhIfCJrgPWZbnbZhj1hN
	JixXvel1CSkbHNuIx+sOvcOeiKHsHLT6q2SNT94cN8Y+5Feq7oGlZVYYIArB7Q9uFy89/qNB7Yw
	RT5ePHSExnuX1KOagsE6B5rwy6ZdoUylQIbVI2NezaD+61mFerVSpceM/KXG2tSL73k5hhR1O40
	OdvJxAsc+Qh/zLT2VAwOi0oAl8Nqmjuhsm1Lv5D5Tg2K6vtDEzTVtPoy+H7UMsOe6Ft7GBJePnB
	q3sqM6QlC4b+EgT7T1cCNW+LtY2xu5aWM3T12Q8wd67ls31OC3TQ87Sw==
X-Received: by 2002:a17:902:d48b:b0:2c9:feea:4e50 with SMTP id d9443c01a7336-2ca7e71111emr54816095ad.10.1782984278298;
        Thu, 02 Jul 2026 02:24:38 -0700 (PDT)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com. [209.85.210.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9aa10bacsm10436105ad.82.2026.07.02.02.24.38
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 02:24:38 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8471013fac2so1249391b3a.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 02:24:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Epy6cJkPvmnaVFY8PHnMQUrr3YizxPtNJ+hQIUoYQ7Ejorz4DIMWmiMVRBJiJVucMze8e+uQ=@vger.kernel.org
X-Received: by 2002:a05:6102:1620:b0:62f:46be:8318 with SMTP id
 ada2fe7eead31-73da7681403mr2525301137.6.1782983793184; Thu, 02 Jul 2026
 02:16:33 -0700 (PDT)
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
In-Reply-To: <CAMRc=MfBcOhbj=ETxy2Xz9o_nyzykrEhKAc3jYi6V5_jMZEE3Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Jul 2026 11:16:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXNG=C=XcioQUEN1M7cQgKhO0AxUyg5X+TWb2rQ3-H3fw@mail.gmail.com>
X-Gm-Features: AVVi8Cef5-UyxrfN1fWvFDcXcIwIbwhU7f5lsircbKpxY8MZwCT2oXalNKmt_xQ
Message-ID: <CAMuHMdXNG=C=XcioQUEN1M7cQgKhO0AxUyg5X+TWb2rQ3-H3fw@mail.gmail.com>
Subject: Re: [PATCH net-next v11 1/7] dt-bindings: phy: document the serdes
 PHY on sa8255p
To: Bartosz Golaszewski <brgl@kernel.org>
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Bartosz,

On Thu, 2 Jul 2026 at 11:12, Bartosz Golaszewski <brgl@kernel.org> wrote:
> On Tue, 30 Jun 2026 12:23:16 +0200, Vinod Koul <vkoul@kernel.org> said:
> > On 29-06-26, 16:51, Geert Uytterhoeven wrote:
> >> > Russell King asked me to put the PHY logic for SCMI pm domains into the PHY
> >> > driver instead of the MAC driver where it was previously. Instead of cramming
> >> > both HLOS and firmware handling into the same driver, I figured it makes more
> >> > sense to have a dedicated, cleaner driver as the two share very little code (if
> >> > any).
> >>
> >> I think you are mixing up DT bindings and driver implementation?
> >
> > Should the bindings change if we have different driver and firmware
> > implementations? Isn't binding supposed to be agnostic of
> > implementations..?
>
> I've thought about it some more and I believe this question is philosophical in
> nature.
>
> sa8775p and sa8255p are *the same* hardware. I can flash different firmware on
> the same Lemans Ride board and it becomes one or the other. Yet they are not
> described by the same DTS and the bindings differ as well. I don't see why we
> wouldn't allow the same approach for the this PHY.
>
> We treat it as different HW variant when it's managed by firmware - just like
> we do with the rest of the SoC.

DT describes hardware, not software policy.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
