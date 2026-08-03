Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B113403F4
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772650; cv=pass; b=g9l/4nrqQpR4E3EOaaPsf59Ky1fcgKrQwHAyyDD/PMCg8UGeF09j7/B4Id3xFB/F3KTnHTzt0eM3PqQjp+TjUqPU4eH5sXAyFTUth6rsvtCYw7HbVLjCdiesoMdkZxvGBugBsy6ZWdRiNtb/EntXiQcJGq4m5/WUCRZbRQDOlic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772650; c=relaxed/simple;
	bh=fZ8BuOv3ILCmNDbfVHwiSe/Itiuz/HLNsG0RZrH9AfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilcOsyNJ6l9UEd6Uiqt5PZfdIGioT54I7qcFSgcnz3cN2snsDqj2x21Nciq1faDbiPVUiq4v0+H4zOw6NRFVr5EPvYAdYU6GTM2VqY9Q0loSqZ+6Mh315DfvStWxgniSwn+KdW65yyRmNmRSrYxnXTCZCCES3cvjFGSZp52+AWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj9Qjsg6; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj9Qjsg6"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9618b8bdc51so683766241.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 08:57:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785772647; cv=none;
        d=google.com; s=arc-20260327;
        b=A9hewY1f9zPHC7ZWzV2QVmvepKj0IU8rgmEbdse+9XfCi3ixEP1iX0OpzJf0XLcMFU
         RyuE7CMmPoLNOGJU0fOWef1fVWwQGoDmzLDr6pJda5RO3VNF4L5FC71nxJ54dxXqCntS
         gKNefuW/yQYjj8soYMYPims9GAGqLGkr523LdfheSQ/BB/7W4g3NpOeuIO+9XMyxPX9P
         NzqQLfyZBfQXLVwdQ4OQsSPFtyQfdvG2UYlpDtCcYbDbQyqMinDURN+962mr5HcPTyNT
         GFmE3MtetWG5WenKdK1SK7L4XQNliliRST+TMrITy3zS0XbvFcRksH5GH5vCUHmQ++hD
         StKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N0JlmS2gNslt5buGhuv7J6Rqxg7nw4cpe34TAqatS1E=;
        fh=zeALB/kVjwyB8wRUBpp2/mb3CC1+wCxcKympYBFRjiY=;
        b=pN5fki4BOU7XIw3pvH/KdiYQ96skvcz9m5lbSfhLw4b7YPQSAQsSwUCOAF1Y+LzyuG
         1xTXEtlPL5AQUn3DcIm4dqtaeGHARxXVLgPDD/kN1hji1ioXrS+OJ7pC3Ql+k/T+qBNx
         zFvHGYIatudeKNyygiNdkyYEUbAE3Iy4KZjU5FJ31TU8sb0s91Dr61a7H9cb/mNgJDwO
         K5MjGE2ryJ1z7Zyx1ea5n0gtbJR4l1Qw27QaGx16Pqjdmi5m11LeqV2kW6/fnoI25TnZ
         G2ywQ9Xxzv6DIJUVpnm7KmX3k/S/53As/e/nsF3fxUDi1MSdduxL5tfQsQzPLbHrpnHJ
         qYDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785772647; x=1786377447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N0JlmS2gNslt5buGhuv7J6Rqxg7nw4cpe34TAqatS1E=;
        b=Hj9Qjsg6KW1MSz/SX+6kLkXVUgEoGCC/TK3P8TC676mNuOGkpgnHnQSDLqLq14TuXD
         btpWKdByixT/6wnmsGSILoRUi0F7dWjaaTt15PCCBd6+OqzJQWPYIFTE79x5wD+Eu5x1
         IOarCfnRr8a9DqvJ+YpOAXNJTvSVtKAKZQXYw8Rb9S3m8w0CAp0/vV+NO/z4isXVAATV
         CdIe3DgetUYN+XzybdHWFys3Hk7WRw0W0WkdeWvf2oolEbndkvSHS2bN/2uuFTiuLy3c
         tpxEdQ4ecvFjDZ0VnvJkccJhuKm3odKwBXhG6FHKJrZXPkn6MNrkCIixixMfm89MVWF1
         fndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785772647; x=1786377447;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N0JlmS2gNslt5buGhuv7J6Rqxg7nw4cpe34TAqatS1E=;
        b=HuYVlPCrsWxnSx4c66L97jq8kr5iNupfXO1Q8TA3uJnul0XP47p7ejy+30JPjh6icf
         Mzda1Zkk+Q8rLME1jL3fZhQ/TjdMB7oTtBjOiokcRhjaWV6WcS9LIeY2b9v4grdYwug6
         oRM4i1VHugFPeQdY1O5cGoeabyW1x7n85eUZ9CPqtAGS855DIn/KE16HDXq8GxpEYmCP
         KpQrTP2ocTqQZZ9+/R90Uq9wPqII8Ek1NAIBvTxmWQe3O8g+BdaQeDHQs4tWnlcScasK
         DFh4BbswygKKEYiVZbClC46hFtid6l10KKEfXZVcEwtDn4sthMjwFQTBVSiYvUG94VNr
         6VPg==
X-Forwarded-Encrypted: i=1; AHgh+Ro99M0yk2oIOK7N/vdVs7YMrjj5NXjoDCZVblqv4s44ZG8TBGO8u9yX/g0Bcn0dHX8ZQcgE/KA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Mk2gAeA7i3zDHNjGGIRy9lfKHE4rtoJS+I1wdx5sysXaxW4N
	XfCuoWQ17r1ReEOP9g1tpU30CkJKuUBNBWQf6weWtCsfEEsZi9AXp9sKWiKsEuQ2svQ8LJNUJLO
	VwBQrGG8zK0wYs5oW09qkSek1Kc6a+Kw=
X-Gm-Gg: AR+sD10qvzYyO4LNUpVFSJXh0Wd8c6hDbMKFfZEffgWDaWQMuDj2ykAx4p0ymNKxYTS
	rnOeUVsfeXhM/pkxs/eXd1GNEyZkx0WzWGexays9nf0C+g1Ev50MEr5WBs83l0sNGJzfil9fPKy
	uSN0vqQ92WWxfETD+KHurRY7REr7U894+1IWCljs5ikGIR1ipMR+1l7CznWkNgCWMRUBcDi6jAD
	cnrv1Ao6p9Tz3BdBPkNI2AvyIuti6Z1AN3+Q+DXXIZnHSAIrOth2B4cBKd5Wtg5I6PKrNFQBKw/
	i5mXts+zAfVxNYsVtMGK36hROwqEb2uzxBMPjGvO62GQasqvfFDWTUKjG7m21NpTbYgEXqgDzpP
	G8AuqQZMX4XeQYqDa7e42qyht3L4kRuyMBpnHl3e7z9a/wBrBKXp5x0NqmjvC3z3rMLi+N9UnQr
	czHmQWTtslTfrDlCqwhSCy9ny6+WytCuTNHu5w
X-Received: by 2002:a05:6102:3ec1:b0:740:177:f357 with SMTP id
 ada2fe7eead31-75b21b5cddamr7901767137.6.1785772647108; Mon, 03 Aug 2026
 08:57:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com> <aaec8809-8218-4412-a60d-931406dbf287@arm.com>
In-Reply-To: <aaec8809-8218-4412-a60d-931406dbf287@arm.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 3 Aug 2026 09:57:15 -0600
X-Gm-Features: AUfX_myOaFTmy1w_XsU_xICVSFiXSt1enMYBuh0WDNCP9gRZxCQ8cKkbteQKJ94
Message-ID: <CADvTj4qCYjQHOQn1jRTHNNL=xeX6z3Dgc-PLwOBUvX34AU6cuA@mail.gmail.com>
Subject: Re: [PATCH 00/21] net: phy: add X-Powers AC200/AC300 EPHY support
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Maxime Ripard <mripard@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	mfd@lists.linux.dev, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 7:26=E2=80=AFAM Andre Przywara <andre.przywara@arm.c=
om> wrote:
>
> Hi James,
>
> thanks for sending this to the list, but as Andrew already mentioned:
> this is quite a beast, and would need to be broken down.
> Jernej and I created some patches just for the AC200 PHY on the H6,
> which Jernej recently revived, and IIUC, wanted to send to the list.
> This would probably be a more workable route: start easy, then add
> support for more SoCs (H616 depends on the WIP PWM driver) and more
> variants (AC300) later.

Well, I wanted to validate that the overall driver design is suitable for
the H616 which has to support both PHY variants at runtime effectively
since that is the most complex use case, I also don't have a H6 board
to test with myself at the moment. I think being able to see a more
complete implementation like this is helpful as it can better inform how
we can tie the different control interfaces to the link PHY in a way that
works for the more complex H616 case.

> Which also brings me to some attribution questions: If I understand
> correctly, this has been written mostly by some LLM? I think you would
> need at least to disclose that, if not even add an official tag?

Some patches were, sure, my understanding is that it's not required to
explicitly call that out but I can add more info if that helps, this was
tested/validated using a heavily automated hardware in the loop
testbench setup on an AC200 and AC300 variant H616 board.

> Also I wonder how this relates to the patches floating around for a
> while already: https://github.com/jernejsk/linux-1/commits/ac200-v4.
> This branch is relatively new, but the ac200-v3 branch for instance is
> much older.

Yeah, parts of this are loosely based off of some existing patches that
were floating around like those, although it has diverged quite a bit as
well since this series is designed to handle both phy variants.

I guess I should link to some of the earlier work in the cover letter?

> On 8/3/26 07:14, James Hilliard wrote:
> > The Allwinner H616/H618 secondary EMAC is commonly connected to a Fast
> > Ethernet PHY in an X-Powers AC200 or AC300 companion package.  The two
> > packages expose the same link PHY ID and largely compatible link-side
> > registers, but require different control paths before those registers c=
an
> > be accessed: AC200 is initialized through its I2C MFD, while AC300 uses=
 a
> > non-PHY Clause 22 control endpoint.
> >
> > Some H616-family products were shipped with either package under the sa=
me
> > board identity.  For those systems, this series uses a SID NVMEM field =
to
> > select the control provider at run time.  With CONFIG_OF_DYNAMIC, the l=
ink
> > PHY enables only the selected fail-needs-probe provider, so an AC300 bo=
ard
>
> Just to bring that shallow discussion we had on IRC to the list: I
> wonder if this is the right solution? Alternatively I was wondering if
> just patching the DT in U-Boot would simplify things, and also help
> other DT users like *BSD or U-Boot (proper) itself, to not boil the
> ocean, but just allowing them to follow a standard DT description.

This can be used either way, CONFIG_OF_DYNAMIC isn't a hard
dependency with this design, aside from adding CONFIG_OF_DYNAMIC
support for mdio the dynamic enablement of the correct phy control
drivers is relatively simple with this architecture.
