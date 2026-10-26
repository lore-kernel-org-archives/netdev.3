Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793039490;
	b=UbwHnCo+ewniDRjmkFvYmaOYZMEW8f+MifC62aW8uoC8ZgxSiXAmR0rV0TyKe78Ix+oW
	 twyaOy031rNgx3QbGGg3bPyT4QZ+hFptiing40kGNNW1SabUb2ju+rHB16isjK6V+afEu
	 Ni+BTkBTN5h+QF/bJcH2tuR1Fhcnfk42oyi1hGDTlULJ62Hd6hIPSrq3itbRnlhs/PJW4
	 JnNurg25WVYK20lho1J2sWGsfhgKp97Fax0CbU5NSdhRgeX+ffqSTD7EpbQ7lDWK2IXTx
	 0pGScR8rdifCvnyvvA9gqVDhsXAVodyJX0GkobI7k8lc718giFCdgu262UoYQPywoNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=0gAsj6qI++VbCo88r6Ynjuj61Kc1LdhSuLSo7guQzmE=;
	b=CCBrasXwU7G31wADMhjuFIC1ze9eyJITNBlGcbTdkgPAlyP0oR/i7CEfCZuimZyp/9mI
	 dPQTXrun7DGsvrVC+H96BSISwQWw1YXWISogyMNvHYXzijuXngw8C9GWUKR89qZQRUBov
	 0b+QtR5bA8LxZMaGrKNkT3F+wn58jTPjzoIHCH0RvMxad7wg/0JRYDyWchvPCZ3bTpvLd
	 M4k480dWlpHuh0Z1+/WaeVKHLySZrLg+42o7pmkcyiJlHw7rW4H1Hbzc6m88J254ocAO0
	 Lp/OkSsd5rvgyZfsIyPx5kyP6t5kKMLuHD5IV+uzJICzudreMB48Xr1boOQaPQNgPsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="g7H/vLy+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C15606A322
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 18:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98C15606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g7H/vLy+
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ac8a2ac52bso3295347b3.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:31:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793039488; cv=none;
        d=google.com; s=arc-20260327;
        b=UU+uF7ZUfKBJlocD1rcJlE/wFhF/JnQUVZ7XZCcIi5S6fUq2q6uBog5OiXs17pLmPz
         b9nyy3cte1L+VswDi2HaKsO4lDp6ySdVdwVMNCPy3wnV5uQvCHCvAndHcJ1g9Uysm4z8
         +tL7m+Zpm9/TGrLlz+347L4LP5P8JjvvTlDQBSq1OCQlURn/aUuP43RMryQnCzTJfzHu
         STbsrCLV7ttwZkqa3IaJdjITBW3gdgJ0mJKLtue17+09yMN5Fa7IBt+xY9/P6D3l95ZR
         IZXupSe6fq/vVbs8xLclBIBUx04h/jnaeFe1QwecPjuicEpHexwYP04y4zcyCRk9rTQu
         i9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0gAsj6qI++VbCo88r6Ynjuj61Kc1LdhSuLSo7guQzmE=;
        fh=4YApLZLZ6P6ZlOnGbCWol4pCQu9aMUwIZwAOKLw5t4E=;
        b=NeU5rQO3yT7VrOWGM1U9yArDXHZKmioDG4JCKREkjEh4UJA2oUp/kVqVpxJoESk8h8
         leYUiPTHfngW2glEMPvrBvlglPGMG6+EaLdtLkuE741dfIRCR35L2yyyvHwfF2CB+r7q
         KnyadQym3duE9Fu89X7z0n/ymO/2yAkbROqlppL/RsVab8vlHUblhDYXdV4V+nvNmDie
         HAaUK98wy4EYCK8aI8cV5jtk1XnN92pXSRNvNPEY/zB1jcLqOibnK4v4a8JHVqs6SHhK
         Tv1QXsVdAprKleuhvkQlO+4OTb9Rkvz7vvPkGbgHJUZqmN7frHykP3/lRfjN5sEv69aZ
         c9Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793039488; x=1793644288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0gAsj6qI++VbCo88r6Ynjuj61Kc1LdhSuLSo7guQzmE=;
        b=g7H/vLy+7ZmS+8WfdfCRzhIcqUzV9z254lfIfe0rQNmRKB8jITgDiANJUD+DBV6moO
         XmbH+kAbspDlY6liPkx9u1CG5wOQW/3w9p67CzyMW+TY5LDbnxCA8rGI6F0rZu+Eo2rV
         C1mmztc9qN/RPcKwkB3cWXK2QVNS45cF4uDXWqV8iSwHfZDlCbYWj6CksX0s6uaVD3m7
         fCfOFbEhlk48e3xfkwNMSNxmZIOVGsCVuXHM/HOGN98cyKwow7WuzU1mRsdxmRutsUHH
         LxoRfH+xg8HNmoTCDGshmFzWvdttNxqeozpYikGKk+7oyFaj5xjE4PqnkkGMlCgozR5J
         XIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039488; x=1793644288;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0gAsj6qI++VbCo88r6Ynjuj61Kc1LdhSuLSo7guQzmE=;
        b=O4WxF8Y8SdGIP0utQCialGcrQw0p+jMWq4xVuZPpfeUVpXkPVsy79pNUETx92KJp+n
         OGTukYukDH6ECuS3DXZ8NZVWNY0odTS7/DfGKNYj0h4FeDh2XiQ06exiQ320+DXL7Lmo
         jZtEVmE1Wpw9YWDuQXzZ0fHC+bxjnJFL85WQRO/H2bPt7SN4+4twkeeCWxFD3l7GiDZW
         1wEqJx0GfOkrREnxS+5ObM7GGrzzf2wJaJtNM0Ka9SEY6c5wVoewwmX4QkJJjvtYdUKl
         8VsmDQOU+OFLlcQlb0T136sEpNUP9WP3nMrtrTDB9M5PEqtmfylZqs5dlA3VNzC8hPFa
         rh9g==
X-Gm-Message-State: AFq9FYIvwibZiIlBmHT0y6TlK1uM2ID5+R9S1MmNRI6GTtA4Szp7FoVX
	dhooxIlVkeNnw4NoFhtuUnoeWpfSimAHUykcwWQWjoEsR4XAIcb7CTHH7M4Al3z1F3zKv9Z8Ugi
	C+jxv49JGDbi6qhL/kDo6RycuwaifW98=
X-Gm-Gg: AYBFou3ZVyb8POvBFdIU8PgRSZd+e9RzmysdPtpeW/9nrO2v8aMiBEKvNuW8enDWs/J
	flpy1p+jVFROWEmpzfsV65sIaTbH8+iaC43TSJtiedd8wFqffPYejTHBX/0glwOtJPBLZRqQZhu
	/BXzo7ibCJM9IlPVbp05coorQUnFWRpRzc2hpPGMMvxOw0l7aU7HYIhm2woxwgu1FkonkXSsPYu
	cds/Hg1F1asok3xD4icSqFSLFJ0AGTDcGSsuc2khE7j6/+fM5JzNunhMMbfit1bUwTOP6M4bGKU
	pwgsHDIMTqL4y+u7yyvLfI0ejrpOIM2qBxenCDOL73ezTVvyBKA/aCEiDZ0It9gUiMs8ZVHdHM8
	E2whV+RQQ9VLCEb+fhhCDOFOZpRBTYKxFxvlj/Xq0I/ejLvHm2qmOYBvbpCM7Rr+GzAmpaCqEK2
	ljIyesqNFdTqfWTD5tDlh/HWzYkqVcKZUphNbR1Wp6naLtR/fHHr18QODpCSSNDs1HVx+hkUlFq
	fTX
X-Received: by 2002:a05:690c:f8f:b0:8b0:cf3d:7b10 with SMTP id
 00721157ae682-8b19c9a0081mr3613457b3.28.1793039488379; Mon, 26 Oct 2026
 11:31:28 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022211104.2091128-1-florian.fainelli@broadcom.com> <20261022211104.2091128-3-florian.fainelli@broadcom.com>
In-Reply-To: <20261022211104.2091128-3-florian.fainelli@broadcom.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 26 Oct 2026 19:31:16 +0100
X-Gm-Features: AclHuK8Zffk1z4S4WDnZNvZlsHkwBOv-M-RtH0jRYwO8NEDBODWkjFIQ0giSyGw
Message-ID: <CAOiHx=nXKnzqB+-BvYg7rgxpLq9p2JP2xk8JchK-3+fqzpG7nw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net: dsa: b53: restore the NSP IMP port 2 Gbps mode
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 22, 2026 at 11:11=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> The Northstar Plus IMP port uses the switch's proprietary 2 Gbps mode for
> its internal link to the AMAC.  Its fixed-link description reports 1 Gbps=
,
> so applying that speed clears PORT_OVERRIDE_SPEED_2000M and leaves the tw=
o
> ends of the internal link configured at different speeds.

Sounds like the devicetrees are wrong. Shouldn't that fixed-link
description be updated to be 2 Gbps then? ;p

> Force the 2 Gbps mode and flow control for BCM5301x and NSP CPU ports.  T=
he
> mismatch caused switch output queue discards on both copper and SerDes
> ports, with one discard for every TCP retransmission.  With both ends
> restored to their high-speed modes, iperf3 reports no retransmissions.
>
> Fixes: b6a8a5477fe9 ("net: dsa: b53: fix resetting speed and pause on for=
ced link")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/dsa/b53/b53_common.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_c=
ommon.c
> index 0880310c9ce3..1f4964c28fc5 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -1663,9 +1663,13 @@ static void b53_phylink_mac_link_up(struct phylink=
_config *config,
>         }
>
>         if (mode =3D=3D MLO_AN_FIXED) {
> -               /* Force flow control on BCM5301x's CPU port */
> -               if (is5301x(dev) && dsa_is_cpu_port(ds, port))
> -                       tx_pause =3D rx_pause =3D true;
> +               /* Force flow control on BCM5301x and NSP CPU ports */

The comment is now outdated, and is missing the forced 2G mode.

> +               if ((is5301x(dev) || dev->chip_id =3D=3D BCM58XX_DEVICE_I=
D) &&
> +                   dsa_is_cpu_port(ds, port)) {
> +                       tx_pause =3D true;
> +                       rx_pause =3D true;
> +                       speed =3D 2000;
> +               }
>
>                 b53_force_port_config(dev, port, speed, duplex,
>                                       tx_pause, rx_pause);
> --
> 2.34.1
>

Best regards,
Jonas
