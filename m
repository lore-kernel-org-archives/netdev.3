Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF43347BA7
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389988; cv=pass; b=bnl5iH74xIw3m9Vcvo71YTz/cOZJRupEFs1BSCzkK1eU98F7J6d/vn8XAJsa67ojsN54ZgTIYsW9lhZO+5IA6ZCZVpTXm/JwhD72EC/p6VPD7vAQDA41DkW6zlzoINb/NDQS7NfcwKxmQrnPvMfqubY4HA34x2zhfrtDOsYqc4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389988; c=relaxed/simple;
	bh=N2qIBtM0sLdCexpfaGcv2GMkHMJU1opKnFxcrbr/QEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HONWXQ/HTuDMe9fQFBjbAClihJcLjr06X/nDs7p9XzNyJUsR+wYuVrojfGE5u31FJSf+JpJj0UUOsAlRPgnjgx9fPwhTEPB0a8wX7m+cyZxT28D0bhvEOyU3Rqc7/bELsfRbdD8BT1zg+UnBkoR4od58Sopa0R3rG9kr42IxSGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xh3raajf; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh3raajf"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-671061b015eso3106763d50.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 05:46:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789389985; cv=none;
        d=google.com; s=arc-20260327;
        b=gERTRbZDEN3OrilV++CbvLynE0b3w47zfp/uri+PAbUo2WnbSEfQijNmZPdZoQZLAm
         3Dac3oP5m7N3GIQeVJvGBiqAk23puShYQWRV5xu5tYtZBdprvfFiGaOfgfrpaSmBwDOh
         CZ/aB3FThXvHcD3UigOJlUPbZEnfs4c+3CoSfx0Y1g+nMVr1PKaAkZnNWpqq5Ve2NWHQ
         Qt8ZCal+/rY2+Rq20i2dsgW07csv9ddQqMBoXEt8cO2Xx6sydp+iA0Osqg5zv2P6IuQ3
         x8pNwJXFbTqkj1K2GiP//Dt0aLNUM0PBjFU4lXcpXwKLwUEm7Gi9wpwwafl/Je+OxedK
         zWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xn/KS/zlvPaKN+PIUz9BQzL20m3x8DXtvbHxQt6hAHg=;
        fh=N4AWlQg+e1hqCukLtVQIqx+bw3MfARQkN8Y1AbNlOIM=;
        b=XMny5OfGC+orGRUkACTHTP8ImKmN7iPp1e6tp/GrDT7hUnZNMd1oeRtv+mKNUkab5c
         QN+HaQI+vK7o0ZhBNx1hFiuLCjCO0b89Fj+5c2PmtHsRnmBSxDbyti+EXsWfxHONKrKx
         KDVheHjiQqqYR+wEqY6DlpFVaGFGeJjstQeyeOCtyvNoDhti7/2NwFuyT7PPUiiLnSSM
         +fto3U98z3qgJnApUYSaJSkdp1f43kFSFogpNJPy6cmpro60b0kilYsHD9AlTIiWQtWJ
         DOxf1bQE8kdY1aYhPe0xVOQn0RlUhE2+6ppYZZHtpn5ZSEU9yAP50LxpXE+GLoEqunu/
         myAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789389985; x=1789994785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xn/KS/zlvPaKN+PIUz9BQzL20m3x8DXtvbHxQt6hAHg=;
        b=Xh3raajf9bjc2+DeRM9u9FvRyXSMZqoCbe8ASitzWQaU65NcX5H6qA65lfRhyXyEv5
         stEswQGj7963sHjK0Rn8vZyrF0VQCzZAhGG27XW+8DBPjfWlu3V0m/NjnXcjAWLiZWjS
         i3RdpuyLeuJPw3PzvY7SumFKqHL8xcO1arTt9Xn1LdhLdStSAMNPUg6nTUUctRrALy17
         Fum5fyuYchXbUPx4E7xrNqNjRVBbw8OJnhTcAWSN00HfgZyxzjJ6cpVyLtmCzZwLus3J
         lgoFy4seJ+3ktqtd2g+1rSL6t/petglHC58+RfcXiAznIFuhkYKmiM0N/xaXfp6wYLSA
         XDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789389985; x=1789994785;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xn/KS/zlvPaKN+PIUz9BQzL20m3x8DXtvbHxQt6hAHg=;
        b=Gk8IBEpQYTrf+PW13YC8Go+mbKHlWHXoLTSwjdn5RYSkO+s9UnBeEplIy+3+RR5QT5
         261PeQIH0C1y9HBEoq0pQY06+Qn2KD1Hh77HrUoI6Zv34sHTOC1WqECZi+Ht1YAakWQu
         iT4KJMw2TM41n0fuq1Mn49BKobCJdsyFGmiS5OjLPYLUDQoJWQtU5PIcA8n79MCxQkeQ
         clVoa3wYI9Ody3QRhz0jON/NMzmqTUCTRn1Vh3jWqmPXB36FAuJnvDZLQzjJzYrwjiD4
         bn/Qng3q9VInmH7DryiTRelaRdNorK7Q9t2ynusvPt6Q0sbfrAGuYDjBF4j05QnRC8bC
         gkkA==
X-Forwarded-Encrypted: i=1; AKwUvBxEja5sCsDj1MhKWu/sWAGufnJ82Xd/hmXeuwXNnXoxYz3qlgPbeSZs9KkD0egWx4XYf7Zupzc=@vger.kernel.org
X-Gm-Message-State: AFuF++lKUuY4cpKT0xGwYpHVDxxvaJkt7Fb15MZTU3jIiYYu6LXUHczQ
	rT+JSJmZpPvUuyXEGeBTbA71cBMtV7y7vmCUuQCkBHBWJFM/uwQVi5ov3ouw/0NdYm7kF/6uoaJ
	BXZGNyFBC+gUbhdBhRsml8VQnN5HzQ6c=
X-Gm-Gg: AYBFou1ReD5yU6WInIuy2nxW45gqot7eih+3uWqxsCAHCt1lvVvgP3B/5neM6rRXapc
	prbPPStRlvppz6wJsQ7+XCLqWwZ/mz6MBtaYCb2mhgPVAT0n1QI/uAe0EIHkYuo/5qCq+KlTbZJ
	FZhmNG46/xYLxE6FmOXHgPkgtEad9ld9o1qSaztxjfEnEctEHVFRw6MDdK/4TdSp4Up03FGj0Vy
	SSY7WG6wjM5FGQfw+7gG1Pna3wjDq+zgjt817FkImlS7o4s6UBiKNR4qqcPYkfeJxQHjsc1wyhs
	Y3sFaP4mCtbhJe+YYP0JatZoZ5Pgcx/AjRdGYAOQLFIJ1Yoxzv3I+qoPQQ==
X-Received: by 2002:a05:690e:4553:10b0:66f:d560:32f1 with SMTP id
 956f58d0204a3-6714dff5f14mr316516d50.39.1789389984952; Mon, 14 Sep 2026
 05:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910130140.910-1-yogeshgaur.83@gmail.com> <46807790-6f07-4f0a-b50b-375cc1c9b061@gmail.com>
 <CAG6enPy441a-cyzsP2_WoQ1+4rj6gikWzOrNmX6yXx1mOo-M1Q@mail.gmail.com> <dc33c0ec-ae64-464f-b656-8c55bb17cacd@gmail.com>
In-Reply-To: <dc33c0ec-ae64-464f-b656-8c55bb17cacd@gmail.com>
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
Date: Mon, 14 Sep 2026 18:16:12 +0530
X-Gm-Features: AcwNN1WAJeFjJDU3SPSjkU4yg6mUFLVqkF6KsPpGrqF-BmrTNBaXZbEBF_oOnwk
Message-ID: <CAG6enPzTYjcaV1Y1FECzZ0GGmxC4-YfYwojVOAS2OCgEYcAH3Q@mail.gmail.com>
Subject: Re: [PATCH net v2] r8169: don't enable chip LTR when the platform has
 not enabled LTR
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Javen Xu <javen_xu@realsil.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 6:44=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> On 11.09.2026 15:00, Yogesh Gaur wrote:
> > On Fri, Sep 11, 2026 at 1:03=E2=80=AFAM Heiner Kallweit <hkallweit1@gma=
il.com> wrote:
> >>
> >> On 10.09.2026 15:01, Yogesh Gaur wrote:
> >>> rtl_enable_ltr() programs the MAC to generate LTR messages - ALDPS_LT=
R_EN,
> >>>
> >>
> >> Empty lines, mail formatting issue?
> > Yes, I would correct it in v3.
> >
> >>
> >>> LTR_SNOOP_EN, LTR_OBFF_LOCK_EN, plus LINK_SPEED_CHANGE_EN on
> >>>
> >>> RTL8125/RTL8126/RTL8127 - and rtl_hw_aspm_clkreq_enable() calls it on
> >>>
> >>> every ASPM enable, then goes on to let the chip trigger L1.2.
> >>>
> >>>
> >>>
> >>> The only gate is tp->aspm_manageable, which records that the OS is al=
lowed
> >>>
> >>> to control ASPM. It says nothing about LTR. LTR is a separate PCIe
> >>>
> >>> capability that only works if every device on the path to the root po=
rt
> >>>
> >>> supports it. The PCI core works that out in pci_configure_ltr() and
> >>>
> >>> records the result in pci_dev->ltr_path; per PCIe r6.0 sec 7.5.3.16 a
> >>>
> >>> function must not issue LTR messages while LTR Mechanism Enable is cl=
ear.
> >>>
> >>>
> >>>
> >>> So on a platform whose hierarchy has no LTR path, the driver tells th=
e
> >>>
> >>> chip to start sending LTR messages nothing will honour, and ties ALDP=
S -
> >>>
> >>> the PHY's link-down power saving - to them. A report against RTL8125B
> >>>
> >>> (rev 05, firmware rtl8125b-2_0.0.2) in a mini PC shows the effect: 29=
1
> >>
> >> Did you verify that this is caused by LTR messages, and not by any oth=
er
> >> root cause?
> >>
> >>>
> >>> link down/up transitions in one eight-hour boot, with repeated downsh=
ifts
> >>>
> >>> to 100Mbps, against four transitions at boot and then a stable link o=
n
> >>>
> >>> the kernel before the LTR change.
> >>>
> >>>
> >>>
> >>> Gate the chip's LTR programming on pci_dev->ltr_path. That field live=
s
> >>>
> >>> inside CONFIG_PCIEASPM, and without ASPM support there is nothing her=
e to
> >>>
> >>> enable LTR for, so compile the function out in that configuration.
> >>>
> >>>
> >>>
> >>> Note this does change CONFIG_PCIEASPM=3Dn builds, which used to progr=
am
> >>>
> >>> chip LTR unconditionally: pci_disable_link_state() is a stub that ret=
urns
> >>>
> >>> success there, so tp->aspm_manageable ends up set. The PCI core does =
not
> >>>
> >>> configure LTR in that configuration either.
> >>>
> >>>
> >>>
> >>> Fixes: 9ab94a32af70 ("r8169: enable LTR support")
> >>>
> >>> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2529752
> >>
> >> Did you verify that your patch fixes the reported issue? Or do you
> >> just assume this? Because in the bug comment history I don't see
> >> a statement that issue has been resolved.
> > I don't have a board with me, hence have not verified it. I did a
> > compile check only.
>
> If it's not verified that your patch fixes the reported issue, better
> remove the Closes line.
>
Sure, would remove it in v4.

Thanks.

> >>
> >>> Assisted-by: LLM
> >>>
> >>> Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
> >>>
> >>> ---
> >>>
> >>> v2:
> >>>
> >>>  - Gate on pci_dev->ltr_path instead of reading PCI_EXP_DEVCTL2 direc=
tly,
> >>>
> >>>    and compile rtl_enable_ltr() out for CONFIG_PCIEASPM=3Dn, where th=
at
> >>>
> >>>    field does not exist and there is nothing to enable LTR for.
> >>>
> >>>    Suggested by Heiner Kallweit.
> >>>
> >>>  - Commit message notes the resulting change for CONFIG_PCIEASPM=3Dn =
builds.
> >>>
> >>>  - No change to the RTL8125 register programming itself.
> >>>
> >>>
> >>>
> >>> v1: https://lore.kernel.org/all/20260909110554.1977-1-yogeshgaur.83@g=
mail.com/
> >>>
> >>>
> >>>
> >>>  drivers/net/ethernet/realtek/r8169_main.c | 13 +++++++++++++
> >>>
> >>>  1 file changed, 13 insertions(+)
> >>>
> >>>
> >>>
> >>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/=
ethernet/realtek/r8169_main.c
> >>>
> >>> index ec4fc21fa21f..05f7a44aff01 100644
> >>>
> >>> --- a/drivers/net/ethernet/realtek/r8169_main.c
> >>>
> >>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> >>>
> >>> @@ -3035,8 +3035,16 @@ static void rtl_disable_exit_l1(struct rtl8169=
_private *tp)
> >>>
> >>>       }
> >>>
> >>>  }
> >>>
> >>>
> >>>
> >>> +#ifdef CONFIG_PCIEASPM
> >>>
> >>>  static void rtl_enable_ltr(struct rtl8169_private *tp)
> >>>
> >>>  {
> >>>
> >>> +     /* The chip must not issue LTR messages unless LTR is enabled o=
n the
> >>>
> >>> +      * whole path up to the root port. pci_configure_ltr() works th=
at out
> >>>
> >>> +      * and records the result in pci_dev->ltr_path.
> >>>
> >>> +      */
> >>>
> >>> +     if (!tp->pci_dev->ltr_path)
> >>
> >> Simpler would be:
> >> if (!IS_ENABLED(CONFIG_PCIEASPM) || !tp->pci_dev->ltr_path)
> >>
> > I tried that and it does not build, because ltr_path itself is declared
> > inside the #ifdef:
> >
> >   include/linux/pci.h:443
> >     #ifdef CONFIG_PCIEASPM
> >             struct pcie_link_state  *link_state;
> >             unsigned int    aspm_l0s_support:1;
> >             unsigned int    aspm_l1_support:1;
> >             unsigned int    ltr_path:1;
> >     #endif
> >
> > IS_ENABLED() is a C expression, so the member reference still has to
> > compile even when the left operand is 0:
> >
> >   drivers/net/ethernet/realtek/r8169_main.c: In function 'rtl_enable_lt=
r':
> >   error: 'struct pci_dev' has no member named 'ltr_path'
> >        if (!IS_ENABLED(CONFIG_PCIEASPM) || !tp->pci_dev->ltr_path)
> >
> Right, ofc ..
>
> >> Then you don't need the stub function.
> >>
> > You are right that the stub function should go, though. v3 drops it and
> > keeps a single rtl_enable_ltr() with the guard inline:
> >
> >         static void rtl_enable_ltr(struct rtl8169_private *tp)
> >         {
> >                 /* comment */
> >         #ifdef CONFIG_PCIEASPM
> >                 if (!tp->pci_dev->ltr_path)
> >                         return;
> >         #else
> >                 return;
> >         #endif
>
> LGTM
>
> >>>
> >>> +             return;
> >>>
> >>> +
> >>>
> >>>       switch (tp->mac_version) {
> >>>
> >>>       case RTL_GIGA_MAC_VER_80:
> >>>
> >>>               r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
> >>>
> >>> @@ -3120,6 +3128,11 @@ static void rtl_enable_ltr(struct rtl8169_priv=
ate *tp)
> >>>
> >>>       /* chip can trigger LTR */
> >>>
> >>>       r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0003, LTR_OBFF_LOCK_E=
N);
> >>>
> >>>  }
> >>>
> >>> +#else
> >>>
> >>> +static void rtl_enable_ltr(struct rtl8169_private *tp)
> >>>
> >>> +{
> >>>
> >>> +}
> >>>
> >>> +#endif
> >>>
> >>>
> >>>
> >>>  static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bo=
ol enable)
> >>>
> >>>  {
> >>>
> >>
>
