Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A5D3DCDBB
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168898; cv=pass; b=RBINuMFvCgJO9nJQIbC1c787S0KtQMtYR6zZufzQtYa+Ur2XQTodzOAInyoMr2/3Zaa9XP6+3KQy9snGMEjprNsqxS02oI3X5OxFCiKlwkAfpFOvl5kHz4RpakNI4HP/ssahSw78qQt2p+i98CCDB7ef9THvCZxuAPpi9mEiz54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168898; c=relaxed/simple;
	bh=U9ebD4L8ITu2kaaAEQ6ddZIE2aJmclvAiH+k7ulDCFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZm59gZR/y8ZRvEinHESoxyKbq9UXx1/iPv91QUOocnRHPiP9RGHsH4Du+vbQXvRWzfduwH4tHHoeln0izStjHERDE9DYiPgAQgPLTKPwz349BrqS0RV/He6XWPMhEbZXLCajkrQArRgcp6zP/SGxSMafQRAdAApxypV6zb4EEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H06YN6Mv; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H06YN6Mv"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-861feb6d61bso11821287b3.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 02:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788168893; cv=none;
        d=google.com; s=arc-20260327;
        b=faiVTT78XIFC7r0bwAgLDaB/aUw43uQWipQ90tIdpYEOAtUxWO2899ITVY+S5jMKyL
         36yV5A5r83U9b2dzfdMdWUGU2DGoomhaI/RPD+xvJstEs2Bmf66wmFVsg2ZfQ1NjNPe5
         d3uftZnYUKmDk0+7/srLFwgKEoJoTXCmMcq9qWQf53/JWc9Ph7buTgsYxQcRBgsbhR/f
         NFt+/LIJPIARugGpza4kBI5WVO+2qeII/eEoY2b+/IJ49Z5vH4rbYmXFAOUj4fhRXZHQ
         w7INnXTAp/70w/U4+7Bjxb6fFVQWVinTe3A/IzHP5Yz6JF2rDShlKUQabadSNybR77WZ
         Dcrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U9ebD4L8ITu2kaaAEQ6ddZIE2aJmclvAiH+k7ulDCFs=;
        fh=Ku33+IsVsjx6atH9cO+23PKzVggkkWT+Y+rgiXWWRbc=;
        b=c1mrVib5xHTHlUXCsy9tWzkeVMUXxVAyEshOIOpr3PfdKvT+5bEEURq9Rx3dyBPVSt
         nzqx7W/LJrvKj2CYAQTyOKj4suA8bps7E8OVFY3llLQXYlktUMFx046vRqPGaYLRonuS
         N9Ll6LDV5J0vw1/mE7N1zeDYc73E76oL+kt90Zw7QNmrZYHxuauQxn7BBWqjj13NKL94
         yysrjbcyWJ0C/D/J6h+rV1vO1JUjaIIKw1GRE8xqJQlGTkIXedzDCfY3IbhJZAU00kMZ
         Wah2nNV5KnhlFQUy8le0Xkls2oohYYA6uWcC5yz/rUrwyhw2CwgCVCByzQdRrtP2hNF0
         Kw7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788168893; x=1788773693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U9ebD4L8ITu2kaaAEQ6ddZIE2aJmclvAiH+k7ulDCFs=;
        b=H06YN6MvRIFECWkQwykHDVqQFQnID9wF8P/0OQ91bQj0tBeEwOz56AK/n0kstsi54x
         o1FrlvRUCil7178fs8oYtiU23Ve9N6UkKr1Ev/xStCcsKgUno+qkoZAYBBeqQlwACJP5
         HhTH+R/mZxg6R4rIBC2nz3pvC9JPyEZmtNmQELXVMPR3385/q4YLLVP5S7Z5ZWF/2Uj9
         inNtM/eOpeS+54yUNBdVOJvXcE/wtKlGtjlMc6UWV08Y3+CqMWXlIs+lTw4OJkw1TwEU
         1IpGnyvd4UTV7iTpRZx3/glr1QLiGBUqUogva9G0ZHnSzlr29yXP/uAS9qYy1OjUTAuZ
         Gg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788168893; x=1788773693;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U9ebD4L8ITu2kaaAEQ6ddZIE2aJmclvAiH+k7ulDCFs=;
        b=SwtEt98+EuAvudCF0XuxLhEByhtY3EVAbjGZIRRKlnC48XB0TQuaHnzrS7TVBOeVBm
         0aG3tQ7SYb47RrWeS92kQuWI7NskIxWWsgwUcqDUidmR7slI+B6eGohyv/IOI3gEGzSK
         1GC0kEVOWaXitl0MyHemCiie/TEjR8+dQUo9olF2p9jIkUnC6yriHf0sqMbpNpoy4TgA
         dYuTuO+kbzkFwa66b6ZwoMSJX1NZSPhWnh+hmcb7lD1LGIv4u/f+5d97oG07TUH/kGNv
         QEhxry2Qbo+EC3O7HS7pueqHaKjyc3IQHbGRpuI3eqVE9DeSm5NfU1ImkIKXui6+XaB7
         qpSw==
X-Forwarded-Encrypted: i=1; AKwUvByIYrE1tzvvU+KmsNgxeOGRm2sn/OV7CLNAENCAHeSDJRlmn+OCpR2Z52kja0+GbANSrYosUSE=@vger.kernel.org
X-Gm-Message-State: AFuF++n3hTcDe2tLook8keUe1DHvm7Ybh4y3cx1J/2xKSqeOdyczZG6+
	g2t71TVPnbT658+OZOaOHdsqs+tnQ1+74x0d16aNMB5eFzs4u7u1404TzEWChaSfRc24ov75gxp
	GQ00bDoM8S3rWcBSUDNe/IGf6F3eiTWM=
X-Gm-Gg: AYBFou2/KfRqXagEq5f3Z2OVMV49n6v//NqiuTwjIIvG9iB8CySPR6Udfxh6qbcI7td
	wEwUwAPfhIxwiZNed+yEX2Zs9Rogo2OAnjC+aE4C9TcMoXBN+D+/KN+6VvQw5M18NDt44gYUXYR
	JaxKJ7FwpwXl2WDAuuAARdhLl91hJZIu8FR9hic2vrvwAjxnlbX1YL5T2jkYzvIyOhogotibSBW
	6kA1Leyj/Eeyz3oNyKlMlictPejfrYUh5j09jgjkNlIQhn2MTb/3xWCZ+V3fe6iJR/pLG4xqUde
	jkjyvqKzkDSf0W4KeeWpMpV0HvMJtXvSJhtdj0SXE03B0QWszK3V7xpqfCqlNboaRxJrzXJN3Wj
	ckQUbcve3I8Ax+W2rAFSvBbstnPg6xEy0sbx1AZBDTb6hTN1ZOyQCp7wlXBvT39GCyWB8VJFXHe
	VSH0j220We
X-Received: by 2002:a05:690c:498f:b0:7db:ccda:a409 with SMTP id
 00721157ae682-8678bd7cd25mr5510017b3.9.1788168893210; Mon, 31 Aug 2026
 02:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831085217.391-1-strst.gs@gmail.com>
In-Reply-To: <20260831085217.391-1-strst.gs@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 31 Aug 2026 11:34:41 +0200
X-Gm-Features: AcwNN1VrKttLpgKWhAB8iBZiZxt-vHxYzhIUcbdaTqqJW999xYNsjruBpoWd7VA
Message-ID: <CAOiHx=md28_BmsDOsNDp0XbUpfih=P+-+aDYb6tiWPJTCu1drg@mail.gmail.com>
Subject: Re: [PATCH net v3 0/2] net: dsa: b53: fix 8021q uppers on standalone ports
To: Semih Baskan <strst.gs@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 31, 2026 at 10:52=E2=80=AFAM Semih Baskan <strst.gs@gmail.com> =
wrote:
>
> Since v5.15, a standalone port on a bcm5301x b53 switch cannot receive
> its own tagged traffic: the switch VID lookup is always active, an 8021q
> upper's VID never reaches the VLAN table, and a tagged frame with a
> missing VID is forwarded only toward the IMP0 management port, which the
> in-tree bcm5301x topology leaves disabled, so it never reaches the CPU.
> The common victim is a VLAN-tagged PPPoE WAN, where the PADI goes out
> and the tagged PADO never reaches the CPU.

I really don't agree with the framing here. The subject essentially
claims that uppers don't work in general, but that is not true at all.
They don't work for devices with a *broken* device tree configuration.

So this is a work-around for broken configuration.

Also this is an incomplete fix, because it still won't work 100%, and
there is no way to fix this from within the driver, the device tree
needs to be fixed. E.g. with the (assumed) disabled EAP mode on
stand-alone ports, you will have the issue that the switch will drop
any frames with destination MACs that match a learned entry on a
bridged port.

I really think we should just fix up the in-tree device trees and then
complain loudly about the broken configuration on probe in case there
are out of tree device trees with the broken configuration. I mean it
was broken since v5.15 and wasn't noticed until recently, so it
doesn't seem affect many users.

Best regards,
Jonas
