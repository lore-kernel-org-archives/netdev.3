Received: from mail-ua2-f27.google.com (mail-ua2-f27.google.com [74.125.226.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4408E4AF663
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003400; cv=pass; b=YZE22wzDdQ8kbkLiEF0oT7HWFMZiPUg+v5Rpuea4tF/P4762qX3RD1RmOZ29/DZ85tq/7j7T6IyYF2kDgohKm4GBQ4YyAebGaxzZDaVwXc0U8nC/oy/r7AZoRDrrAiCPxMX9qgq+CQi9zmt+gRQJTqGy42+JT7hPxLGQ0JdKHCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003400; c=relaxed/simple;
	bh=RRnt92cNZkan/7gjLZgpWKhsYasr+rG4EuXp94q+O0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n61EISjfNLu4F5fPg05ol6SOn1tdzqh39CGWy3yqWBVGTzJyJFrABKCY7x/pKoC9gmla2ScTjIRA86PdTb1jj0HxyH4LVzFmbb2BK/5wHXKzoe5YCcTL7E+4CCkpO6CTNwOl5QWwZDde5gz+UwFVUawzskxR71ZRe+xZ4C+Vk3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p7ejU3T9; arc=pass smtp.client-ip=74.125.226.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7ejU3T9"
Received: by mail-ua2-f27.google.com with SMTP id a1e0cc1a2514c-97e7c7bac31so1684202241.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:09:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790003397; cv=none;
        d=google.com; s=arc-20260327;
        b=d4o2ZZtCWiJtMzEB00vB8K4hHufD+xzBDqMeKrqixynRipSWP9ybg3lieDH4j3lz0s
         0X8R05Mj7W/hw4Ec+2IVpK9deontVklMfxGzSCVkHhPvQbr6IS03reBoip8WM+WWJwMZ
         Anh73lg7AHqVyqLx78fH13XrsP2bk7XDGWlCd3L6dXz/XL/QhlSiPFHhb6IB8xIGyBjp
         YE4qcQnsqe2OeZ001m2CZZk1NrFGLnyzD75cAKAY6YPkNUmFvMALJRKR3Z/dWJq6HatB
         RyfYNG9O2vPCCWDuoGRiU3s38Mzt6Fy9UUXg4hx/lYZkDnOIOI8IzFUb8wFCVyur24YQ
         yp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g1DBiA0IyE2Ft5pvUMescJhhLqoAG9H5I9OM90H7dNs=;
        fh=NNE39/M83MyB27XC1skB4Jb5MVXupNxsmVqNtBUv6bo=;
        b=kUP3fXSyahO8e7qoL3/WRxX95w+E2L36blKA2/lEyHLZmVhnBRU8NRMcegbWPJCWTb
         C5KK7Ww8bxdNUdEpsebPgpw+iTdwkfZPejL57pzGHpjSTGnKRbCrtCtGQhw//9KiYus4
         5B42HLQ45UXfMnfW1Hs1toSaYsaClUhMe6HaMa+UUZU+56TkSUM1R16VrztZBwi63k0s
         EUiVzn1F7ps2ecxgz8wx1gD0TRVwrwvyEVBkeH5TejwnJAeyOC5DocVURnbsl/K4+lbW
         lupBGrXuJsmiuAvdGpEcJ2yYvEBkQqKelcF7LdR7IfMs137at2+PL7MwIpijBuw6his6
         SnsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790003397; x=1790608197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g1DBiA0IyE2Ft5pvUMescJhhLqoAG9H5I9OM90H7dNs=;
        b=p7ejU3T9zk/yJq0i+ywQG2DcNQFEZSiDraIlntCr+rtmLcG4bf6m5qinkJMa2ZNie7
         8ai/rMVCKfMMbaxXNHryj8iHP4VCTzNNwF33qjx6yeo+sqHjl6qI8ZqatabAmc3HSUdj
         cwxQHifLkcBVB2O5kYiYJzdNEWrnWLyvipqpAnzqnneKR1ARP7l1cMGd6pKWEUy36bG3
         kI0LqdkrjKDcp6IZ3vqbWp4daSYbVODOaatr+bHivw37RHoAqGhsMZcsOR/5PCKV92l4
         bTvYyVCiLG42qRdZS7HfbzfH3qapCjqxGkC7lbEP2H0VmPWI2a5BAVDogPChvpleNviC
         RpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790003397; x=1790608197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g1DBiA0IyE2Ft5pvUMescJhhLqoAG9H5I9OM90H7dNs=;
        b=wZbrWZ6uMTKUv7dlDu6wWmzoHwKyvQU67t1DqkQcyGllUXSJ+cYnO1orMoAV+a5uDB
         yX5bWliRkqO5ZAWrWAADWp5NM2RLxkd0DtU1GZSMo97CH7HUSLj6lhRsP2Rye76WW47h
         nr222ODmhZjqw3ZIbfn2VG9XX8fZaY8p0JUJpeRgZ2tPNKaOG4YCRLVnZHTo2kxV3wAQ
         qLqTX4fMXcR7lJw2KlAq2IHoVYhBxjtxYuo1VxfFitMQWMIxSBVw8tmovIaJo3TlMwqb
         49YvI4A7V4i7WX94IpAJ2EncBTpAZZOpkZeuUCaxyjc2Rl7XVefukPYAcogOtfKBYTlV
         qk4A==
X-Forwarded-Encrypted: i=1; AKwUvBysyyUr7rkQ5bRSf+Tzt0hLC5YMAir+6jQdVbH0aAaL9TfMtJN/YSBOxxhyUzZUIwoSAhxO47c=@vger.kernel.org
X-Gm-Message-State: AFuF++m3UiIxdp8+QABr6QWXi/QmkiXZICG5j1CphNz48js1cgzs9jNd
	DKHZM3opY/ROarebW4n1L0nrfQ0tMQoq36jFZtQrBN0uwPiU64afU48IKGbsiG7vIJ/sHNNEXYM
	Ftk3BVcribY2q7HXfN+rgt/REbGfCFGo=
X-Gm-Gg: AYBFou0WwdFHt01kUvsD9U2w8ki94pcuvm42lfV+lrASCYiU5GJgeiaZDZx8TNe5wcF
	RtbfYA0TtVvSxxQmytoKkEtaMm0dU8Ex7YaMv36EPfYO8gXOF9GSfLhpI+t+q9V+5v/G0GCB5PP
	gcL96ox60wmppT1qo/+QdQZtHEoPjTQ34egkjGlMToqDcRiPfgkXTOtv+LVvwOsmvm3n/j3JG6r
	j41j1Ch3uedt3GbPg/UNUkrI8TfRWAgnytHo5C5wE9wEKo099jlpVEIdnzkTMlsv8f6iqNLBw1K
	UHEv1s06Z8OszFhAej3yEPXRE8uwL9YuK4WcvFV4RB4HmMwx/2C4fz3LO51dzntk6gTdH3dm4Ig
	C1U41k6LB+0iK84wT2xDeZG/j6zqFFQixzWGjFVrvoKoRfDtylaaq+70JVcHw8WLAlUiVMh9MPF
	+ZwatDRNxfo4sGGr9PqfHNe/xEJZvWM8X0TzX9WmfkLJxBWnkF8cnw/4g=
X-Received: by 2002:a05:6102:148c:b0:7a7:198a:c2b5 with SMTP id
 ada2fe7eead31-7a7198ad369mr3357929137.29.1790003396967; Mon, 21 Sep 2026
 08:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920-submit-h616-emac1-v1-v4-0-8347dfe2eb7d@gmail.com> <475799c2-7eaf-45ed-a6cb-80c2c2c556e7@bootlin.com>
In-Reply-To: <475799c2-7eaf-45ed-a6cb-80c2c2c556e7@bootlin.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 21 Sep 2026 09:09:45 -0600
X-Gm-Features: AcwNN1VLNx3dtquO69cswaFe7FbqPEaN3LW5P0JUb4jisnZv9ewZXpukHo1wT2U
Message-ID: <CADvTj4qdVGDXGyXHmCGpb+ztvXs2kS3_joaCZkM0dq_sYvHscw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/6] net: stmmac: add Allwinner H616 EMAC1 support
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Christian Marangi <ansuelsmth@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, "Alastair D'Silva" <alastair@d-silva.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 5:54=E2=80=AFAM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hi James,
>
> On 9/20/26 21:45, James Hilliard wrote:
> > The H616 secondary EMAC supports RMII at 10/100 Mbps and uses a separat=
e
> > system-control clock register at offset 0x34. Add its binding and a
> > sun8i stmmac variant using that register. A distinct compatible without
> > an older fallback prevents the driver from using EMAC0's clock register=
.
> >
> > EMAC1 connects internally to the co-packaged AC200 or AC300 EPHY and ha=
s
> > no external PHY pins. Leave PHY initialization to the PHY driver instea=
d
> > of using the H3 internal-PHY controls. The RMII-only variant does not
> > expose the RGMII clock-delay properties.
> >
> > First fix failed MTU-change reopening and hardware-resume cleanup in th=
e
> > stmmac core so the interface is closed without repeating NAPI shutdown
> > or resource teardown. Allow phylink to stop a suspended instance withou=
t
> > restarting its link. Then move the MAC software reset from probe to the
> > DMA reset callback, after PHY initialization. This lets the MAC and its
> > MDIO bus remain registered when the PHY driver or one of its suppliers
> > is not ready yet. Clear DMA and interrupt state even if the reset times
> > out. Keep the separate H3 MDIO-mux reset sequence unchanged.
> >
> > The AC200/AC300 EPHY driver and package bindings are already in
> > net-next. This series separates the H616 EMAC1 MAC driver and binding
> > support from the earlier combined series. PWM, MFD and device-tree
> > enablement are being handled separately.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> > Changes in v4:
> > - Add a prerequisite stmmac core fix closing the interface after a fail=
ed
> >   MTU-change reopen without repeating DMA, IRQ or NAPI teardown.
> > - Close the interface after failed hardware resume, and let phylink
> >   finish shutdown directly from its suspended state.
>
> [...]
> > ---
> > James Hilliard (6):
> >       net: phylink: allow stopping a suspended instance
> >       net: stmmac: close the interface after a failed MTU reopen
> >       net: stmmac: close the interface after failed hardware resume
>
> These new patches belong to net, don't mix the fixes and the glue code :)
>
> The glue can land without these, no ?

Should be able to.

>
> Maxime
>
