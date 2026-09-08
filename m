Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0389153CA90
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871041; cv=pass; b=Veb+mIrQzX/bSS0RpJRSkhUR7TBaNPQnhXk+2oUv0JNby8dFfdV2WZ13tA+r0/t6f+QXUDdfgHnnNzCjaXQ7QbYlPiJJZK5xFahStyXlynF7JW+DSNznhCrZOK/Qi+lvdVvftJSxVWjkDGiyHODVyKQq1CNl/2i6NVYFlWDdczo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871041; c=relaxed/simple;
	bh=RAvK+QlZpVZ6hzzt9JA68rH8p3fcTiFrApuxSgWpNy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0Xa9tgRokA9nn8g4EBwoPZgikZUehnziCFClnQrqoqP7R6S2owHOwkEW71evrgOwT6htGtDlf0OPvDW2aLJOeULXXHLRPASkbVE53WdknxIkLBF1UDdUzj9aFDgTe0KfkFzGXNjkPJ2IxNniiwlgrJuNbdDTOW73h11alAnM/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHkKcAQd; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHkKcAQd"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-9103f5b813aso35936756d6.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 05:37:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788871039; cv=none;
        d=google.com; s=arc-20260327;
        b=BJbQnvnrhZYzjfuSv8c2MZoWzlnFpr+BxdOUtc7oXMKNlS4ZEc+nekbDQ1ktZLsWxa
         EM69eoEvGQfoE1B10pnIi9HveCPKqRWdS5CuDhvcjAj77nbycX4QF+HkxlTNcOHXBZWW
         9f3eIC8Lth0I8p2JGoZbZbL8xb1OTsfeGcsuCBXf3WJGxgs5gmRnITVqMsjVGJAF+8cQ
         FIDUtylvNI9658bWkFbz6wY2ZLtZGOxM0nFHJwNsLvNxOdNWonjS/BpahuMHC+RI6kHl
         ISu09thE1OndBNfpRRcVuAibOzr+p3nEqJhVSkaRULA9ZE9YWCcxgEab/Q8nMpGEC55+
         f34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+oK2FpmTBiOTT3eOfoPFZBA9GuXPfUx5dYKLcub9lvI=;
        fh=hydF5Iickic0j8xCIpGRX9ri5niXig+tNdNVnkF3KD8=;
        b=dSv7J28wmHGKrbZugs6fpNfDf6XgtFUOdBocyA1IZ4ec3hQ7HylFEqeTnpFIkRsHLd
         tRWpyAHaK3P7mfC1ZRqRJh2q8RK7IJQcNO1iVu9ktYKtweOYqzNlEcHpazXvC+bjdreg
         oi2vEQiM9Wob2zi8if2bgJH1UR6xSxt2Ec+r5MaUNmVEW5cHQjo15YqBGl+9qqGAx2zm
         PpnALZ2v77Um/TZA4j34GyQe3lx191jEdwzO7GpwtLtcE0Q1YrzuvNYVZR8nhe3GSe5R
         vzqU9gk9oPsGu+3OXqngJGPZzyUUgUCvthOKTgDgglFEg7CPm5EN/ZMHxQCU+UyPoqn2
         TGVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788871039; x=1789475839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+oK2FpmTBiOTT3eOfoPFZBA9GuXPfUx5dYKLcub9lvI=;
        b=UHkKcAQdsPmX1AyeE+NYXqf8xbR2IMxFkScly6T34SfWT8kzrhPW0fhJDTtiCcFbuI
         RADUEIuRrh2n4E9vIvKHec/qRpQpYUiE2ERic1YaXJ8vfY+GEB0GcVkUwOOWpVCIGoPb
         VuqGipH3c3gfXgKqstQg0rAllddIIy3dt8Fo/H+9MTGfLsMvLiGbWjzYcSRFPIA9WxaR
         KF0qDkWxFE8Cu/FP3DU/DNZ+wBYXF60mKPKFEmRb4ZpgUA5GgWxsq3bO/MMWv4Woajav
         8SxvOu3KUiNZ6L7G/QMtDtjJhgbrgtOkda2jmmM7UzajBjAkDA8E2sntB1cYX0OTE4df
         Ydag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788871039; x=1789475839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+oK2FpmTBiOTT3eOfoPFZBA9GuXPfUx5dYKLcub9lvI=;
        b=MUCm4/6lvyrhj7j10NQ9VrQl8reE+h8ApC3pnm04CpOADXBPlwZW56SYkUElG7Cm7P
         H8L4OjEHFau215qwATwqGptnnw+E6q04gQpb2B5N5+0kAjgpiYhk+Gtv5DCZpivN9Mak
         jbC/6N/axX3rELd02afcmf83iIsP2yPX7UvFGEezwLoAwh+o0/b/y7AnPN2NuXbW7VUG
         9ZRjFGmd9SxUDqPxd9ZbLP6a+iuhL86N90IVuZW7muNSbb4rWWFpWIf17wcAocT2jZUa
         mKVihPzrMYGzrAx3tojMXYgFxUuCDbGIBaPbgi4tw3Xm1oqLFXRJfuA0X2ihvfZd0dEE
         Hy8g==
X-Forwarded-Encrypted: i=1; AKwUvBxQVFAJM6QeaWMdoQfD1jAImAIpl82c/tinw+M24BWrN5zzeCSgzSKdX5lPH2LDEkC4aF2/MVE=@vger.kernel.org
X-Gm-Message-State: AFuF++l8iNjgLRCXCBdeupI3V4V0rHWRkqTgAm3YSCa2fk0Hr5XSu+JM
	cCq66DtNqaAqpcn9HSi9NoA105/LuMlWcbzd1azREJ993H2TfrPQr1NeRy3N7XqTS0InJOuGuX4
	AA2GFoUFLk92/H8oGpOlQm6EVuuwdxLc=
X-Gm-Gg: AYBFou08NOQb4wc0xrENPAhF/eCHUsMywdE47K12aHNqZZeGKfqZBa+/do/HkA3dsRh
	QxyfFA4XkDujHlkXfQe6HFx62dXmmLsFqHmYjsiq1/H0sWC9EJ/Onl+OhFp/XJyZWOvapBj3XgY
	asLZuko/CUltP6EbO3f16M1F2yUcSr+gtLm5OszPNueMcq5b79pFy64bn6Ml9YwtgH2JlgHOxnl
	OdKMChxD1VELDovVSWxm8zA5RMjwlAvu3MJE5aGMo/P4h8CNHN1Nioe4w2wHrVtpABmfwWGJIrz
	pirE/dqff1N05AdNGil65b72SGKGBdxVB/Q8UOEHc/Gf4/87smPLcbAH
X-Received: by 2002:ad4:4eac:0:b0:90c:4ddb:e298 with SMTP id
 6a1803df08f44-9103eefcf6bmr338643226d6.6.1788871038641; Tue, 08 Sep 2026
 05:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-ncsi-over-usb-v1-0-6b74d2f1196c@gmail.com> <1db2f8a7-6a17-410e-be1a-e9ac0b91e6d3@lunn.ch>
In-Reply-To: <1db2f8a7-6a17-410e-be1a-e9ac0b91e6d3@lunn.ch>
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Tue, 8 Sep 2026 20:33:55 +0800
X-Gm-Features: AcwNN1WtVvXOykEE_hxcTq7GGNs3AgLO90Qs8ToeolRNdm2gAaEwR31to-VY1MM
Message-ID: <CAGfYmwVUg-Tm42WeEAaG8bKrKp1Tv+08vvJVnmwk8+BeQ1j0Ww@mail.gmail.com>
Subject: Re: [PATCH 0/2] net: add USB CDC Ethernet NCSI support and fix
 unregister UAF
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Oliver Neukum <oliver@neukum.org>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, 
	Paul Fertser <fercerpav@gmail.com>, Simon Horman <horms@kernel.org>, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
	Mik Lin <Mik.Lin@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 2:23=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Sep 07, 2026 at 08:15:54PM +0800, Potin Lai wrote:
> > This series introduces NCSI (Network Controller Sideband Interface)
> > passthrough support for USB CDC Ethernet devices and fixes a
> > use-after-free race condition in the NCSI core unregistration path.
> >
> > In DPU (Data Processing Unit) platforms such as the NVIDIA BlueField
> > series, the Baseboard Management Controller (BMC) communicates with the
> > host or DPU via a dedicated USB CDC Ethernet connection for out-of-band
> > management traffic.
>
> I'm confused with the architecture here. What normally happens is the
> BMC has a standard Ethernet interface which outputs RGMII. That goes
> into what is in effect a little 3 port switch in the host
> interface. That switch allows packets to flow to the host, to the BMC,
> or out the PHY to the medium.
>
> Because the PHY is in effect being shared by two interfaces,
> management of that PHY becomes "Interesting". You don't want either of
> the interfaces setting the PHY down because it would cut the other off
> from the medium.
>
> What is the architecture then USB is used?
>
>      Andrew

Hi Andrew,

Thanks for the review. To clarify the architecture, it looks like this:

[ BMC ] <--(USB)--> [ SMA Controller ] <--(Internal)--> [ Shared NIC (CX9) =
]

1. The USB Interface: Between the BMC and the shared NIC, there is an
   SMA controller. This controller emulates a standard USB CDC Ethernet
   device facing the BMC.

2. Passthrough (Bypass): The SMA controller acts as a transparent bridge.
   It simply passes through both standard network packets and NCSI
   control packets between the BMC's USB interface and the actual
   shared NIC.

3. PHY Management: Because of this architecture, the actual 3-port switch
   logic and the physical PHY management are handled entirely by the
   NIC/SMA hardware firmware on the DPU side.

From the BMC's perspective, it only sees a point-to-point USB CDC Ethernet
device. The BMC driver does not have direct access to manage the shared
PHY's link state.

Best regards,
Potin
