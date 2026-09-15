Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B236643F4C3
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502654; cv=pass; b=TnRTBf/sH9SsugHTFK9jvgm51Ivgj0k+qFgmWPW2fvXW7Qi12SaJIbGEFVnEPAKUXqGi8zEvaGxMIqtcUzL3b4Dopxarrtd7Zw00+mcO3F5REVWM7aQq+EsWRYNeX0ZatsNv8fFXBMNysEMYS59QLOHhlIPORB7I6MKlEFTxfjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502654; c=relaxed/simple;
	bh=67tAq1qJhAYCAKyoVSg1Qc+3onHjSmhgjfysUABNfB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nx52HN+06aA5zCUQBE6/P/7qLo8BMVD1EEmdAYSz552Qkpq/usLmalSfCd2Urh5GnFpTyZr5vL9WhzycA67VrDgNu9JgpaurkCpyussxnf0/MZuFwoio7k8zT49JmoE+te+QSv7l986n+IaPs455fDLBg46OD4aGLmUR49Xcus8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJuatJKy; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJuatJKy"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so1182035e9.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 13:04:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789502649; cv=none;
        d=google.com; s=arc-20260327;
        b=dz51BVciGk3Ys9V3Hwy2/sdbustPjSWDaWEpKCn0JZ8KNEO133v6naMiNGaYkpLW3F
         EzdfrIj+nWtx8v/2hMPpBxIUGEAFf+2wn85NoASaJdsH2vA8XZRf+BYNTJuqEMUD8IzZ
         bY+2Y1MBsSVRrWG6Fez2/SPVOQn3Kq1DDrowM5cB6CKybouZ1dZYDhY2ZGCxUbiiheDC
         o2U9olj/OsYfDMMFGsSUpy1e2XM/v19texFj/T+GFjE0k/QlxXz1xqIAT1QncEdTI5Q2
         p9SljnvfPGLWGiLfu8kXKFxJCuGKEca8R6CpOR4rEVkz4vDFh304fXr1jIfeaYt7R54r
         8sog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VbWmhOGlJLhxr01yrGYucTT6Sp4rdowe8PfmPHelJMU=;
        fh=F9kqzJKnojEx03px/HCqqaUPnEeCpuDudu395CX7H00=;
        b=VYucaSScNx2MSvScbpWWc+xSwu3T5ARIDKWF8z22V2Ko0CD76Wtz6mv7bDYtD+gkTs
         snnoFZrgg1HjsAA1ASK2Md/2lAJrorwgK++ugFUeIFqAq0+uIIgbgUSdoUqZxsmh53Bs
         PZoHZgdO1N2HEvkrywgcJEKuhhTO4FXN5MJQ3u85TTv7BI4xemCadD2sm7geO/8tBCAI
         gd+4MiRIc744YSIbJg36SYp+1QhFINvuVJuvxUE3VvUT5/iHVwjfV7LmvydBocGfEIrv
         1Ne+QM4/J1dMrylwym7z+rlAcw+McMCSNPGWmisKorFb1KCpGR4Irz438pmUTD+PnZJY
         VnMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789502649; x=1790107449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VbWmhOGlJLhxr01yrGYucTT6Sp4rdowe8PfmPHelJMU=;
        b=nJuatJKyLYsQ+Q+dYlM9q7v38jxcSKQ3AXVTq7p4t4H+1BAZwsLVfJjQUYaXIRueoy
         mdW3iK0EXcioFKKEGxpx7fo3c57yWDzGKGeHdw00u3RtckvWatA6stl7nqpmvcq0hFvV
         xeRMtnEAwsCdrfN3VhfcnhCY35jOq+tY1h2BWmvNd4p4UlYrpU/BMlCrsUS1nrRmunc3
         SCXvi2Y9KzkmIm+S9sq9etWjLXATTjVZQ7xTjOUmsOPpzhHWNkl4M9moc2O1HRtawZMX
         aAC7ebxYXgQt6heYplL/hPl+feIjZ4z/HtBEwMSwMeUrwFB8alSdKWTDHS2lnBn9M41z
         qlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789502649; x=1790107449;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VbWmhOGlJLhxr01yrGYucTT6Sp4rdowe8PfmPHelJMU=;
        b=1bwmDHhmqCfrh2hOpZUJm3+6/hcty1+l1SJk0xhixCKcSJHlAOu3I0VOoXnAr2r644
         9u7kUKC+8046L5E/CDq5Aan1fHYncQkxlIKBTG4lpvLSazK8DgTXKEhAzih5RMYrSs2F
         i1vrWoWGiqica3oB9F5Q9RKNY6fMH1UNydFf8rCcizraB2XV9v5uqggyO7UXJZ5zLIFt
         zT61wmtExCD90nnkI0MJ15TbWVg90bx+h+E+ambTBIkxTxe/Xxy24TJQVDQ8ZVbDZ+tf
         orb/cl5uEB2TeY3bJ9bcGDAYBlGpPu+DyS2u1p8GRpTJxS6VUYiaPUaY+nOULqAof2Xn
         6Ttg==
X-Forwarded-Encrypted: i=1; AKwUvBzyfES9xbt48NRYyu8h2URRpVH0wCo2fsZUlA4+RBtIAhNDi22xyE9NQB/P77FBoMhcGdEUxiU=@vger.kernel.org
X-Gm-Message-State: AFuF++l0smRBvqHC4dqAhL1R3TN55SauSCSpojLjweG3HRR/ly0Blhtu
	bypJHzjJVIfhMwZ/QMM2daat3i0vMcDtTS7Muh9lqzvfjWe4HRqxufV77KsOKEg8Eg9U6QhU0Vx
	r3cnNznD5m8otvAElqIVXzArzAelR9Ls=
X-Gm-Gg: AYBFou2LDme25bmaQ5ifSPuLW8YMKFwVEbYdpgYd2rbPRD2z1SdwWKstgxaHDOg3h65
	PciiS6w0YRWnPMaHZWrQSBnhjAD4gE9wvv5p0LGgzLB+YX7k3hzgkne9l+3TpSzZh6SYU4PDKh2
	yKRaa6XKj3opcslzI9HR28gp+ZmP25yjPccFqtLZ38pu0FVpYNBKfeHoDPNFYyx+vM/HZ1vHgjS
	pnO4ZSiTT03atMQTYopCwPtRFqkSQaFTKopsKl464PSrAE2kRfdOPKK02Bo6+njvJ/JgWt6SysE
	tYmcZgDEHmdxiI41Um+MoivQcvm7XJd9hK/EKOozYNqAFTgx0RGoARL60RZ10uXNL+r4NgpJB3W
	HPseBuz8y+KrI0N6SRkv4rGVru24scim7XwHFRjb2qPk=
X-Received: by 2002:a05:600c:8b23:b0:49d:1d6a:4cfb with SMTP id
 5b1f17b1804b1-49e8222d175mr32905135e9.1.1789502648344; Tue, 15 Sep 2026
 13:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-rzn1-miic-fix-array-v5-1-b7173fd5b97d@reliablecontrols.com>
In-Reply-To: <20260915-rzn1-miic-fix-array-v5-1-b7173fd5b97d@reliablecontrols.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 15 Sep 2026 21:03:40 +0100
X-Gm-Features: AcwNN1W_W8KYsdZp3NjvMcl83DNtuo32RgFL8XJ_q1dWoFykhtUqHGE8Zf0GyvY
Message-ID: <CA+V-a8sdrexKiRE_Mev=qRjRdbnx7GoPhsDGeAi0Gpmw5QbaHQ@mail.gmail.com>
Subject: Re: [PATCH net v5] net: pcs: rzn1-miic: Fix config array initialization
To: khendry@reliablecontrols.com
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 6:54=E2=80=AFPM Kyle Hendry via B4 Relay
<devnull+khendry.reliablecontrols.com@kernel.org> wrote:
>
> From: Kyle Hendry <khendry@reliablecontrols.com>
>
> Fix memset parameters to initialize the entire DT value array
>
> Fixes: f39e968dc168a7bd ("net: pcs: rzn1-miic: Move configuration data to=
 SoC-specific struct")
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
> ---
> Fix issues when populating dt_val array from device tree values
>
> Changes in v5:
>  * Target memset patch for net
>  * Drop port number validation patch for later submission to net-next
>
> Changes in v4: https://lore.kernel.org/r/20260914-rzn1-miic-fix-array-v4-=
0-069112feec86@reliablecontrols.com
>  * Fix lines longer than 80 char
>  * Add of_node_put() before returning
>
> Changes in v3: https://lore.kernel.org/r/20260902-rzn1-miic-fix-array-v3-=
0-3f7dccffaf5a@reliablecontrols.com
>  * Make invalid port number return error
>  * Update commit tags
>
> Changes in v2: https://lore.kernel.org/r/20260901-rzn1-miic-fix-array-v2-=
0-3e907049e770@reliablecontrols.com
>  * Use a more correct array size in memset
>  * Ensure that write to dt_val is in range
>
> Link to v1: https://lore.kernel.org/r/20260813-rzn1-miic-fix-array-v1-1-b=
58cafcc917e@reliablecontrols.com
> ---
>  drivers/net/pcs/pcs-rzn1-miic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-m=
iic.c
> index 2b72fa98ddf1..cb74861e823c 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -683,7 +683,8 @@ static int miic_parse_dt(struct miic *miic, u32 *mode=
_cfg)
>         if (!dt_val)
>                 return -ENOMEM;
>
> -       memset(dt_val, MIIC_MODCTRL_CONF_NONE, sizeof(*dt_val));
> +       memset(dt_val, MIIC_MODCTRL_CONF_NONE,
> +              sizeof(*dt_val) * miic->of_data->conf_conv_count);
>
>         if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf)=
 =3D=3D 0)
>                 dt_val[0] =3D conf;
>
> ---
> base-commit: 83a945a529d6e002dd7339c532288a931f463dba
> change-id: 20260813-rzn1-miic-fix-array-e6ae4452c017
>
> Best regards,
> --
> Kyle Hendry <khendry@reliablecontrols.com>
>
>
>
