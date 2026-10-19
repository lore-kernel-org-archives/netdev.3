Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C44360ED6
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792378844; cv=pass; b=Vad9mGXEZ0VU95T+tqPZsHqxL5wIwykG+W7xMYPGJUvVxzLrj9apG+p0pnp8cH2Aaiu8Fc8oBFL1XM7+U7KgjC9wdFXKEwak6P3Zzh9DF+KQm11JBTiAY42dLZKFIhjEMmcenavCmokWOOI36WZTvREjZkIYGWtPQgkaNi6DNVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792378844; c=relaxed/simple;
	bh=+xNsUs3eGIHajBdGM33Tm+gbSb32AlDiJkdtXoaQq8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/24RrgsvdICq/Ij6F0tlq9A9+alJlLCZn9vjsDF/P0aUTiirvqJ2JzrYMv4o4LGIJNHoznUwIM1coRtg32cG8wxWRQQc+uPdsZh+3PzYTm94af2OQNaNZQd68I1QR+VXfVw4SpI2G8FIjm8TzR9bo9kIQ9+gTt6bCKx5FEXLRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+qwC1Gy; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+qwC1Gy"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b2232d8ef5so2316896a12.3
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 20:00:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792378841; cv=none;
        d=google.com; s=arc-20260327;
        b=iZjsyAlWJ/qvkJ2TkRv1WTxzci49T3dv1S4fj/GSISmcZSxCTYzrSxk85pdDh6L6Ki
         fSdrmtm2+tjlxjSklc416c268Fo+yrlg3dBDF0a9K7EQTRS7Q/MExaNYmddtcmMsbJDo
         OJiyR68J3+MdkI11inuj+J9QTf4myNXPjEy6pvDYHbQ1MDba3sBmenBMytT/VrM+kD9p
         4zJE5gjxPBZieUQolSloHh06SJKAaJfigbjIZKaDcSv1V2TLSYZXu4E8L3T6j2VjYHo5
         CiUJeUub7SXpv1XmLgfLdNcBZES1zNxoqspPtTi4mNzeIwe2TPIjwyw0f/orCLFmamBj
         T/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uRs0G98QztzlnE+h6YsSA8pblIG/6flAT+WC3eNIoig=;
        fh=NOJCrXTTkDlAPq3ff2QduMF7NErT4b86Q926OfUrj3M=;
        b=L/TnEZv7g2EGpZEjVu1BeaTXQECTk7RXaUqHLDGpsyROvg/HXkEtbBanPEAVAbLfZm
         XXwUBs13Q7D/wuVhej1dmpibATfKFriAOwESeqo+MH+ICruqNFNLjAVPa4o7T05LwJyT
         Myg1AbXqnaLNxxk1U3VRAfiJan2PsG+ffui5Sik6izz9ScDYj8Nea7qdmGTYCC+yZs/O
         lDsciaIO49szuZukXjEISIN3Y9UQ31H5EVIW5AJP7M3BLETXA6oW371hpKB+/gbXKk+z
         KRpnDRQzF4VJX6m8wJuAhmNpiOciyFZpUzfHs45uDeo9C1U9za8NX8O6whCB7737vDcM
         Bvxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792378841; x=1792983641; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uRs0G98QztzlnE+h6YsSA8pblIG/6flAT+WC3eNIoig=;
        b=h+qwC1Gyg1Yeuo0XHq60QZDAl3Y1sGdD+Rtu6eqSHx2jqn+SX+yoU6bc2/s6qr6Qzo
         hFJR4uVMU/vnBjZzCYqaQYAQH+ajNcjfz4NWYco7vmWJelSFCqNpVkBsUs8zHshx9AfW
         22Zd8oqCbX5aCt6le6oeLUUpigNhwpwDAcLeTrV2fIZWYFqECysAmSBpXYkcwy2sAL9i
         2TJvR0hZkZTXrGiuJ31a9MqwsTJP1i+qfVV/po6iwwawGxUVMsTVkOT9vn9Ej51Lf422
         DxK/V4XUCDjSmjfKB2phVA5DscdGcvulVsFMmKuG3wFAbLWsVbeu5TIjp6eci5+bgMf5
         /mEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792378841; x=1792983641;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uRs0G98QztzlnE+h6YsSA8pblIG/6flAT+WC3eNIoig=;
        b=dqxARG6TDhhzI21lhtlrZJB78yfBGyAYZN2ebOlC8RF+TFLOwWqS/j4CENCADaC4QU
         YEbU61Xgx0XAfyU7913klYCySPLfEQFf0AmkhgJBegmPKIhDCeJ6jVCqpUKjMwz+2h0X
         7chCWIYoKt+lcdpotsYnmbwmWFN6Ole4JcL3vfQ7EW8zgjyyLKXUPho5vO2U6q6RdX8U
         BzybuyFNgR8S4rL24A0a7SGNaka+M3WQYc//vRScFF2DmWaLs0UPeiy9sNo2MKIv0chE
         wDcql1m9e+T9nzTJLubc+R5SSiQcx6NihVRqjFVShCrSTyfZazkyw1EEffgTOYK683VR
         eqkg==
X-Forwarded-Encrypted: i=1; AKwUvByigSPK/+3smeNGiCkZ7o9uibBRuD9ZAoGXFsWK78HC+9Op9sQrBb1bWU+0OQRvdvVxIN70QS0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJq6VJ8YurdMcvPramG+uJfm/oPgR9sGSffvGiGr97MOl/JNkDB
	9eRQJ/P4EFSPx+VDZ9odM3z77j3D/YzFR94E5ll2TZ9iy11XokPd2tUmFu4xjwTLN/UEXrMBNgz
	2IlNQ8JgiJ4+Mu/5ZqRPOB4o+qMeGYgQ=
X-Gm-Gg: AYBFou1TW12DUi/oa/zrQdsOFNlXozzbPM9+sp8Oeq5Q756odmFplAK3zDqyVjmf/4x
	tj/6vJflBgI64VYBlNNV3Q3lmJUYl6Ow4SotNEHWnQFqzKGk+j1UgkYIe7fekmY8xN7AsJ6OpZ1
	TwJIUsjB2ML5338Jvcf+85Bog4G7n+Zh7z0PSS/DQuxr59EtNqUsw9Ynh9vGed63M2GmKo1AA4F
	hjadna9G8VAFfqawqWspkFu5RGUTLDEj6wx247E3LrhxSYDZLcgI/5VJfoLFepAMMEKuQcdkPpb
	gg681c9p0aRAYUE4y/xKtDK0F9KN3o5XGbeEmCCrR9FwAiiYFtGXX2uHM8Vhq9lT6uRnqn0DFjy
	GCiSOyiFqYjg=
X-Received: by 2002:a17:907:9617:b0:c40:3a99:3f96 with SMTP id
 a640c23a62f3a-c419d9314d3mr411996366b.10.1792378840978; Sun, 18 Oct 2026
 20:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002115850.962676-1-o.rempel@pengutronix.de> <20261002115850.962676-3-o.rempel@pengutronix.de>
In-Reply-To: <20261002115850.962676-3-o.rempel@pengutronix.de>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 19 Oct 2026 00:00:28 -0300
X-Gm-Features: AclHuK_U7udrZyUvnHnnOTPCDsZnVnkfDFkPSmosXztYTXcTGB0CZ9Wc4bXtYqI
Message-ID: <CAJq09z47LERHFg0KSC+XB5s+iBxRPvdffJzJ8Ka+_i8vN-pKBQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/8] net: ieee8021q: add pcp_to_tt()
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> Add a helper that maps an IEEE 802.1Q Priority Code Point (PCP) to the
> corresponding 802.1Q traffic type, complementing the existing
> ietf_dscp_to_ieee8021q_tt().
>
> It is very nearly an identity map, except that PCP 0 (Best Effort) and
> PCP 1 (Background) are swapped: per 802.1Q-2022 (Annex I, Table I-2)
> Background is a lower priority than Best Effort even though it carries
> the higher PCP value. PCP 2..7 map straight through to the matching
> traffic type, and values above 7 are rejected with -EINVAL. This decodes
> the 8P0D encoding (Table I-7), where every PCP value is a priority and
> none carries drop eligibility.
>
> Drivers that classify ingress traffic by PCP need this to map into a
> priority-ordered internal space without misordering Best Effort and
> Background. The first consumer, the realtek rtl8365mb DSA driver, lands
> later in this series.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  include/net/ieee8021q.h      | 10 +++++++--
>  net/core/ieee8021q_helpers.c | 41 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/ieee8021q.h b/include/net/ieee8021q.h
> index 8bfe903dd3d0..d24e4036577b 100644
> --- a/include/net/ieee8021q.h
> +++ b/include/net/ieee8021q.h
> @@ -10,8 +10,8 @@
>   * enum ieee8021q_traffic_type - 802.1Q traffic type priority values (802.1Q-2022)
>   *
>   * @IEEE8021Q_TT_BK: Background
> - * @IEEE8021Q_TT_BE: Best Effort (default). According to 802.1Q-2022, BE is 0
> - * but has higher priority than BK which is 1.
> + * @IEEE8021Q_TT_BE: Best Effort (default). According to 802.1Q-2022 (Annex I,
> + * Table I-2), BE is 0 but has higher priority than BK which is 1.
>   * @IEEE8021Q_TT_EE: Excellent Effort
>   * @IEEE8021Q_TT_CA: Critical Applications
>   * @IEEE8021Q_TT_VI: Video, < 100 ms latency and jitter
> @@ -38,6 +38,7 @@ enum ieee8021q_traffic_type {
>  #if IS_ENABLED(CONFIG_NET_IEEE8021Q_HELPERS)
>
>  int ietf_dscp_to_ieee8021q_tt(u8 dscp);
> +int ieee8021q_pcp_to_tt(u8 pcp);
>  int ieee8021q_tt_to_tc(enum ieee8021q_traffic_type tt, unsigned int num_queues);
>
>  #else
> @@ -47,6 +48,11 @@ static inline int ietf_dscp_to_ieee8021q_tt(u8 dscp)
>         return -EOPNOTSUPP;
>  }
>
> +static inline int ieee8021q_pcp_to_tt(u8 pcp)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  static inline int ieee8021q_tt_to_tc(enum ieee8021q_traffic_type tt,
>                                      unsigned int num_queues)
>  {
> diff --git a/net/core/ieee8021q_helpers.c b/net/core/ieee8021q_helpers.c
> index bbacdfff9b4c..a5bd5e039b47 100644
> --- a/net/core/ieee8021q_helpers.c
> +++ b/net/core/ieee8021q_helpers.c
> @@ -222,3 +222,44 @@ int ietf_dscp_to_ieee8021q_tt(u8 dscp)
>         return SIMPLE_IETF_DSCP_TO_IEEE8021Q_TT(dscp);
>  }
>  EXPORT_SYMBOL_GPL(ietf_dscp_to_ieee8021q_tt);
> +
> +/**
> + * ieee8021q_pcp_to_tt - Map an IEEE 802.1Q PCP to a traffic type
> + * @pcp: IEEE 802.1Q Priority Code Point value
> + *
> + * Decode @pcp to its IEEE 802.1Q traffic type per Table I-7 ("Priority Code
> + * Point decoding") for the 8P0D encoding, where all eight PCP values are
> + * priorities and none carries drop eligibility. It is nearly the identity,
> + * except PCP 0 (Best Effort) and PCP 1 (Background) map to swapped traffic
> + * types: Background is lower priority than Best Effort despite the higher PCP
> + * value (Table I-2: BE = priority 0, BK = priority 1).
> + *
> + * The 7P1D/6P2D/5P3D encodings, whose lower PCP values carry drop eligibility,
> + * are the other rows of Table I-7 and are not decoded here.
> + *
> + * Return: the traffic type, or a negative value on error.
> + */
> +int ieee8021q_pcp_to_tt(u8 pcp)
> +{
> +       switch (pcp) {
> +       case 0:
> +               return IEEE8021Q_TT_BE;
> +       case 1:
> +               return IEEE8021Q_TT_BK;
> +       case 2:
> +               return IEEE8021Q_TT_EE;
> +       case 3:
> +               return IEEE8021Q_TT_CA;
> +       case 4:
> +               return IEEE8021Q_TT_VI;
> +       case 5:
> +               return IEEE8021Q_TT_VO;
> +       case 6:
> +               return IEEE8021Q_TT_IC;
> +       case 7:
> +               return IEEE8021Q_TT_NC;
> +       }
> +
> +       return -EINVAL;

Would it be cleaner to use a lookup table here instead of the switch
statement? It saves quite a few lines (not tested):

static const u8 ieee8021q_pcp_to_tt_map[] = {
  [0] = IEEE8021Q_TT_BE,
  [1] = IEEE8021Q_TT_BK,
  [2] = IEEE8021Q_TT_EE,
  [3] = IEEE8021Q_TT_CA,
  [4] = IEEE8021Q_TT_VI,
  [5] = IEEE8021Q_TT_VO,
  [6] = IEEE8021Q_TT_IC,
  [7] = IEEE8021Q_TT_NC,
};

int ieee8021q_pcp_to_tt(u8 pcp)
{
  if (pcp >= ARRAY_SIZE(ieee8021q_pcp_to_tt_map))
    return -EINVAL;

  return ieee8021q_pcp_to_tt_map[pcp];
}

Best regards,
Luiz
