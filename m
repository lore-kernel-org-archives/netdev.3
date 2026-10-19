Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEC63D8914
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792379299; cv=pass; b=Rn62q89GCPJJWVIXPPngQCftWpY92E+A57DD0Rqgt5ycJWjn/TwXG3bEo7zhipBsIQuf4oLtW6TZk3vOH00MZLRahJ3ibdjNAlxFp4voCNiZj79WSFVEcCVXmhXJF0PcW6PGNvbcmZ391sf6PAYEpncOi79E3nlrmaEsK0pl5BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792379299; c=relaxed/simple;
	bh=nCTg2yEQ0LNZyao3mm+6GhqTmbPvZfn6W+wLrwSGvv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeUH42L3h7mGtorlF5+Xs5QRlFtE0ebV8vmteO9n5YAVDlyz58J2srlRcLW/aa9yoGK2Nw/IQmt+oRKj4slMWOkVGSZ2Cwmcg0dPgBI6r9Ywk8rRCSnLP60mQbLyVOV0y0kCQw0Xtqd2/iigucLxpFy0wm1RoU9FX2qGFGSOkgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXKWtPiQ; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXKWtPiQ"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c434376dbebso127637166b.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 20:08:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792379293; cv=none;
        d=google.com; s=arc-20260327;
        b=fLlgjH+JIs7sKGkCRhAvSeUu564Ls6PZbFEMtx1z5eT6qT+qS8CXtoWhzzQiD2DIAl
         gfFK/MJGXM7+fteY7C37Ifmb5ZwiCAABlNwIGvubK9cZF+xm47IkV7xSWN145euo8kK9
         aHjLwl+1wgBEG8KFXM/I5PZ0WGjcURlHqr6uNG/AO8Vjz7pPdl2MS45bz4r+vJgXgohy
         4qmK/hTVjBmr3RKVt8u83IVzwEbAqQBPHDQiz3qryiC12Zt18fys+5eEByZk8iM9uBT1
         51YU1iISQOe/ZfeAx2X56o+bx7Br+s9UNq3r+/8tGFSRKlkqR5uCp6fo22yOLcmZrYSr
         ZzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hKRDlsDlYO9+73nMSkDl9EUQQZlY2MbgYvZNCnDwk34=;
        fh=DwSpmXD7Tcdip/LHov2K4oH+f+te64C5T6VBCMmJbCs=;
        b=MBqfXx4vg4kE/vNdY6Yqi0bPISw4GpaJdmoufjhz+ML70mJ+pvhiADAIhORCQi2cd8
         Y7iwMT6l8+Ked+vd02x4Sr4ZTLC6J4mWft5XeNO1Dq+3nK4ac6kn8ihQz9xGVLw9Fg+O
         ul8SMzc0plafAaa+UR5yotEXydJYtJJRFwHSszWNsHVeDFGBTt8LGIOrP/ZyrvwXgCMM
         oHoBSmfLuRysx71XdMXMOtQrGCe+IN9TdV/F/MrUFGX3GgSu7tKKZ/d0QmTeqbNF0uDF
         wXqzZ7c7utu47uJiMamoOdIsXmM96uLqW3TiKj6STvPwR+sb4ps3b9wtq5RNyrSon3bA
         a3sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792379293; x=1792984093; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hKRDlsDlYO9+73nMSkDl9EUQQZlY2MbgYvZNCnDwk34=;
        b=oXKWtPiQLOlJ3WbWmea0qPP3AYoedzEoMR2aEYmYe7+fJxAjLOXebc08Jl82XXgAAw
         ewPviWHz1tGVlO+PT5yALt2PNSwTfCLLROeUpdrf6FtyykWzsQUZ2NxQgKEAAzPFhXJG
         ZZNxocV1DzAI/WX9kW30Mcd07ZkQEoWtAbOkW4jFj5fOqjyRfJuW9NNtDA440jyt0vJb
         DQyD9ZID2sl5RZpX3cQQSRH2NshD6qq8Erj5t0qbOq86BtTO6vzMzgGbbJhEIHSBl8rS
         IhO7pUwkFp9qeDSsxJDdgDTsIpob9tk1qvVx8o5A8n6GUnJuAcHppW3KcEPQckF94yKM
         Cpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792379293; x=1792984093;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hKRDlsDlYO9+73nMSkDl9EUQQZlY2MbgYvZNCnDwk34=;
        b=g24j0O+4aOMkimPRT/Xt8MpH5I+yqnqLU3SzuE8lbNAzsywcUlsP9WicsNS+4zXFlt
         55+WElo3hXE7HwyovogUmJGHbsLa7QSxogxXlgzRHv8Ppkh/AuUBvOlkoKJSnA5MN9A1
         ZjliXzZoBnQLb/MXS6VnmxC2+/grwdvhayDaEGD3qv5FYH5i4El7gHBkED1aiPyvtWsO
         H7T2AVjEoXjw4ca1XVVrlSBZdj0iJRD+8wDaSo23/6bPfs25v+jeR0ISj9Fd0ZpZwP9p
         SPlPcgkzCrSO1gPzZsDKWGPU0X2xcv5g+ctJe4ikXsUfX2uP6fJ3wC3UpR5RNNImtqfA
         vy/g==
X-Forwarded-Encrypted: i=1; AKwUvByRkvoj2UhaeUiLs/6MEzr+eJKldpYDa3k7vhZefsw/zEsIQaEAO5GqznFDLuNsEPgnq27OEBY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzf+dp04GPQIGsaRyxpW5flUJfGJ16hEaA/qn3oc7BfwiyB6dc
	IheTRtbbOJLZDTjKO5h9vtcstV96pUC0llwwqCBLlEHDYuO6/NeZmiwb1e3idZnczyqx3dRuyXL
	cIx1Mpf1aTCOMIyr+tSlzd5VM08aWVY4=
X-Gm-Gg: AYBFou3lnEL31TgKLAUr14Vq2Xo2ZPO+8J7lDr3JwOjG1BApSbpleOGHGVizYn0hqk9
	9LGN0cCyfQjQ43hbTSJR1Dx4vLynhmMJ/jTYGCBOOHWPsRAy+9LwlNUN/FNuFHQKcgmAgUKiq62
	IgFRdN65onxs5EoHvWWV9ncDehvVHoTmjjltYp7diDL1XYbsJTGhQIvNEqxwiIDN5keVqe6YK0v
	udv9Nf+ApAOJ4/K8LbTbq2R9Vx+EcgupBSOEbodIF4MGvp6VtEqVypD9JS/RcgA1B/rvc1/PmgS
	JBgT1axd49InXdejbvTuF2XsklyDcFFnwOxo++GefTfMDCItII1X8bMSV+wUWThCy8d6EuGkdRf
	rKfjPy/T1oaI=
X-Received: by 2002:a17:906:1009:20b0:c42:bc58:f21 with SMTP id
 a640c23a62f3a-c42bc5810ccmr164486466b.15.1792379292960; Sun, 18 Oct 2026
 20:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002115850.962676-1-o.rempel@pengutronix.de> <20261002115850.962676-4-o.rempel@pengutronix.de>
In-Reply-To: <20261002115850.962676-4-o.rempel@pengutronix.de>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 19 Oct 2026 00:07:58 -0300
X-Gm-Features: AclHuK9qqhhKzBJuYmeDL3jwm5xPymgETCO67Uh4ZsDvV4-HZrLD0w6CHv10108
Message-ID: <CAJq09z7GXHesthJby4e_63Sse4+ue5=kpHr9jtraKjDzpuAZMA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 3/8] net: ieee8021q: clarify the tt_to_tc()
 traffic-class mapping
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> Document that the tt_to_tc() traffic-class numbers are the pre-computed
> composition of Table I-2 (traffic type -> priority) with Table 8-5
> (priority -> traffic class). Note that Table 8-5 is the mapping for
> implementations without the credit-based shaper, so the helper's scope
> is clear; credit-based-shaper implementations use Table 34-1/34-2
> instead.
>
> The existing kdoc cited Annex I Table I-1 as the mapping basis, but
> Table I-1 only partitions traffic types into classes; it does not assign
> the class numbers.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Looks good to me. Please just make sure `make htmldocs` builds cleanly
without warnings and renders the ASCII diagram properly.

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

> ---
>  net/core/ieee8021q_helpers.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/net/core/ieee8021q_helpers.c b/net/core/ieee8021q_helpers.c
> index a5bd5e039b47..520d86d592eb 100644
> --- a/net/core/ieee8021q_helpers.c
> +++ b/net/core/ieee8021q_helpers.c
> @@ -12,10 +12,10 @@
>         compiletime_assert(ARRAY_SIZE(tbl) == IEEE8021Q_TT_MAX, \
>                            #tbl " size mismatch")
>
> -/* The following arrays map Traffic Types (TT) to traffic classes (TC) for
> - * different number of queues as shown in the example provided by
> - * IEEE 802.1Q-2022 in Annex I "I.3 Traffic type to traffic class mapping" and
> - * Table I-1 "Traffic type to traffic class mapping".
> +/* The following arrays map a traffic type (TT) to a traffic class (TC) for
> + * each supported number of queues. The mapping is the traffic-type -> priority
> + * -> traffic-class composition documented in the ieee8021q_tt_to_tc() kdoc
> + * below, reduced for the given number of queues.
>   */
>  static const u8 ieee8021q_8queue_tt_tc_map[] = {
>         [IEEE8021Q_TT_BK] = 0,
> @@ -84,17 +84,21 @@ static const u8 ieee8021q_1queue_tt_tc_map[] = {
>  };
>
>  /**
> - * ieee8021q_tt_to_tc - Map IEEE 802.1Q Traffic Type to Traffic Class
> - * @tt: IEEE 802.1Q Traffic Type
> - * @num_queues: Number of queues
> + * ieee8021q_tt_to_tc - Map an IEEE 802.1Q traffic type to a traffic class
> + * @tt: IEEE 802.1Q traffic type
> + * @num_queues: number of traffic classes (queues) available, 1..8
>   *
> - * This function maps an IEEE 802.1Q Traffic Type to a Traffic Class (TC) based
> - * on the number of queues configured on the NIC. The mapping is based on the
> - * example provided by IEEE 802.1Q-2022 in Annex I "I.3 Traffic type to traffic
> - * class mapping" and Table I-1 "Traffic type to traffic class mapping".
> + * Return the traffic-class number for @tt. It is the pre-computed composition
> + * of two IEEE 802.1Q-2022 mappings:
>   *
> - * Return: Traffic Class corresponding to the given Traffic Type or negative
> - * value in case of error.
> + *   traffic type --[Table I-2]--> priority --[Table 8-5]--> traffic class
> + *
> + * Table 8-5 is the priority-to-traffic-class mapping for implementations that
> + * do NOT support the credit-based shaper (8.6.8.2). Credit-based-shaper
> + * implementations use a different mapping (Table 34-1 for SR classes A and B,
> + * or Table 34-2 for SR class B only), which this helper does not implement.
> + *
> + * Return: the traffic class, or a negative value on error.
>   */
>  int ieee8021q_tt_to_tc(enum ieee8021q_traffic_type tt, unsigned int num_queues)
>  {
> --
> 2.47.3
>
