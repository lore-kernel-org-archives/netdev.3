Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792605278;
	b=YFs32Uv3XK/cu7/NpB1cV6AliroeZmjqgIZjkkQPB37t1aoJVe4LsFrxEz+eJ6Q7TUEK
	 UI7zq4Kgwyi25t7ZyUKkNW5lW4FEmCIZIn0THrGlvPcT0TqNHootH0Bqrgl1XQ746L222
	 Uqu3lYgvzrqqfF0WZgGJnE8XKIJ/nFk5DWE3N5KP/4gjcGBsRR8ISudfLAPH4avBpRWKQ
	 9eEBd00Tgy5erGEnwnYWcTuTjP0v3VWklVP8H8aNCJaCRd9TvKg1IypVRRHKJxZrLawL+
	 400k68qGYldkDFuPQJJYZhiFlhwwmFOZkbH2EbkBIA1kL+hjPBSJYtLgjnOLu5+azPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=bnSgzKVlIwUx1mAdgm8G7itOWlMwTusQYmRJS/QwgdQ=;
	b=KEd5R6enzddIBprbELmwfDxTyBOxer9VTKmnr2FXqKYgtYefQGkzLtHMhcZNRXA+sC9S
	 /aYY+zW99qQzkjVZdIDNuUdHqF7RIB60ELEmCcOluZZv//iqL/3mXKf8UdB/BGHXru0oy
	 gJ9olG/hSSVtOIr9BPusa8gP2sbLgjOgA+CQmmQP8IRw1dKBwPNUblw8mR29G9SNu85pN
	 a2hytCcqiz0pVqRtTq1fipNg/ylRGVAnebeBZtNSoUmeF5iOpISCAT96u7I/wpjYjjMA3
	 9PPv9DnfKreT4ibMyi3UPSZeMGlv4RYnB//Tu5+fuIQgARMnyQ1BFuW0psExisoxk7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="YspD/xZY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F804606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 17:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F804606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YspD/xZY
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so5955ad.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:54:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792605276; cv=none;
        d=google.com; s=arc-20260327;
        b=THYwKnlE5Xsuofx9OvAhWFYkAXQjshkUsCmGhzthL606QoOkh5jAbLpMUvZMddlgKp
         grgOHhdUQH5/k/Dv3/oWOuGzpSqe8XdG51J+shKv93Qz+92pPHupbP2KAfv+2w9Zo2ja
         iORuz8VKJNFzsneYvhiDO0RVx/dUvqASZBRU23q1aaIUjIRN5BR4cQsco5V56u2LHFLB
         sUx4BZhvINJhbCT/lIiA7Crr4oGNNUICJYCRNy+DhpXeupkPhOYnYGcKv1uouCont/yx
         bencr4ZwWuu0Lt3kqHexLiWwcYrLgK2GM8UmNv4fq8wpJxP4mKuc+jCvciRWRbj5siAQ
         9hvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bnSgzKVlIwUx1mAdgm8G7itOWlMwTusQYmRJS/QwgdQ=;
        fh=7HcmNX/Fobk8P/1eV7QyKKHThKaumdL3DaD3WV7eNm8=;
        b=Dxuy+FVDITDCTztMV3ZSM4W3zsQdQ1HkWAVwb+LIOJthG7yy25WnMNgtR0P+4Dif2S
         YS2ONehxBYBZ3RCG1zme86dy4ihnlqqZf4imxtZtIqImZnFS8nkUFl400rKhlAQZgYYj
         1bCZ4YA7GFwReaICkPPRcyXt3IacKXghke4MLrsXHQjmS5MVpo4nk+e45Kq1h5+y8yGx
         u6W61U7y+lmdHmIsRXiBeAahrrur56rs/V7E+y1JcWbvXh6837jgn/XkG2aGrYD+Dncr
         c34w4KWDiCzTuIMohnh104yg7aefpGo56SDjlVR39KaBHyGoJfDPm5FHhJVe64m7ppLf
         CSMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792605276; x=1793210076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bnSgzKVlIwUx1mAdgm8G7itOWlMwTusQYmRJS/QwgdQ=;
        b=YspD/xZY44fFV+FFHSZjF/1RlmBvUNuSfWoWWuFHud6JXIClp37+f+OlnoJN1eKOFv
         MQwoRZ1P9DqC2Qp2kHPovo9qAd0TufADjD0onPwpW7vRQHd7e4lfy43i9RbNf9+IekNM
         zlMvCbl+Gs+EP66/kfLB2hUtRPMo0cNKL27WtWxfeIRVgl1aztbKh+i3BhpMc8WkQmRQ
         OU8c6q+GZActMQnlEzInHLDDUC/nt438pE2N47e+HQN3Bbw84i7dNsQh0+pxRanzfcRC
         8HL2Vby3lni04TIOBHrddKZ7sdcx8H6SsjQP1K0p1tG5Sribwas8GMu1gQZTpsDxi+xT
         rVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605276; x=1793210076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bnSgzKVlIwUx1mAdgm8G7itOWlMwTusQYmRJS/QwgdQ=;
        b=K2+OyMMTVjJsKYskY3YcjVCs2/GkNwSjltcoMVLnfqohpGyU40FrJED5FfO704pUeE
         fhPfq9L4BH15iOfwPbkUTc4mqRXZ9dI5rLPQYvkJ9/gL/SyvHzRjlXKNTWPZCZVmHnGt
         tIx7AZzUpv9pIH+rjc50g9zzY0RFIvF+8i1y4GHl87mg0wFBjs/nYSirYaD+C1+JUUSb
         DxZHWw3jSxURiuzgwMpemHtfnCFF36UwvC4tUEouQTMHFpknA+j3grtk+AXrohY8UQYm
         Xm7u0Rpg3TOw4iTWB5BkGaWCo4byuQAnb2u6Qjc81tr8vVuQD0S1YhwIBiSK9/Q4cEHs
         AC8A==
X-Gm-Message-State: AFq9FYJ426O+uyS+Bo3uB3PPPB4B72R7A/LAtMSzXQifyK3kjec8pauf
	O1TxCr8AhTzi//1MQx5/xyXjch+tYCyok/K0S6nzFiDjxs9KPtH8cY9IImMMd/HU6xxx7LCBu2m
	pzDlOFRmYEusT79bjJNZZJK8SvU2zxOLGTu5tOk/Sin8N8vLrzUBRkQWq65I=
X-Gm-Gg: AYBFou3igu1upouO/e7azibGQxKvmlDTbbRsw33nBT+GDDDwqRPSdXYlmK2rvUZft7w
	x6I1S8lx7Jh9atbKpzA4uF6CDqtZT+UcLhd9kOVi1yTsS4e5Rm9UqocB3SsNQv67mC033vPpaNg
	MLA+OAlELF4JSEhuZbiEaXOyvwUUV3dFwi2L0c/exCXtsRD4wQ1P0lLM4v6pc2AtIrVaNBU57eA
	gPV9NChWCvhazI4+/nJXuXRwfNdtLAZ8k7rvmC1TmKq6190kagXH79cQdj72hyy90aIz1hZMAwZ
	WLHA2WzDoykHCw3hKjxWm3wpaHJVd7jIQ5wV6K4QzmvJhhacr1f5jpPw8uBTJ7A2jSd+JdnioJr
	ZHsm/yvddBv6vyna/VSvRk+kvfc5/c1DJ3Rmk+pzf9JnCiiquhbfWD0zm5ElZui8Ila1S86eu0b
	6fiej/bJFeYPWtJ3IQ4HWUFpZIrmsk3ytbsqtq
X-Received: by 2002:a17:903:1c9:b0:2e6:f400:5655 with SMTP id
 d9443c01a7336-2ea1ad93c36mr12625325ad.3.1792605275821; Wed, 21 Oct 2026
 10:54:35 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <AS8P251MB0001135AF3233180DC42DCD1C8672@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
In-Reply-To: <AS8P251MB0001135AF3233180DC42DCD1C8672@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Wed, 21 Oct 2026 10:54:24 -0700
X-Gm-Features: AclHuK8DF4cNZdOlsLxmOPiqNQYOfIZsIcUlIaWsQRwFpFNtX7VrcLCvRlNCrbM
Message-ID: <CAEAWyHeByLa9ONLzb+NiaavjVSpuNHbEgM_u9uzyVGV3w2zaHw@mail.gmail.com>
Subject: Re: [PATCH net] gve: fix out-of-bounds read in gve_get_flow_rule_entry()
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: netdev@vger.kernel.org, Joshua Washington <joshwash@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 3:33=E2=80=AFPM Aamir Ahmed <elb12345@hotmail.co.uk=
> wrote:
>
> gve_get_flow_rule_entry() checks the requested location against the
> first and last cached rules, but rules_cache_num can be 0 while
> rules_cache_synced is true: GVE_FLOW_RULE_QUERY_RULES returns the rules
> from the requested location onwards, so a request past the last
> installed rule - or any request when no rules are installed - returns
> zero rules, which the driver accepts and marks as synced.
>
> The next query evaluates rules_cache[*cache_num - 1] with
> *cache_num =3D=3D 0. The zero-initialised cache does not trip the earlier
> comparison, *cache_num - 1 wraps to 0xFFFFFFFF in u32, and the read
> faults about 352 GiB past the cache. ETHTOOL_GRXCLSRULE needs no
> capability, so an unprivileged user can trigger it:
>
>     BUG: unable to handle page fault for address: ff240996c4c64fa8
>     #PF: supervisor read access in kernel mode
>     RIP: gve_get_flow_rule_entry+0xd4/0x110 [gve]
>
> Treat an empty cache as a cache miss and re-query.
>
> Fixes: 6f3bc487565d ("gve: Add flow steering ethtool support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>

Thanks for the patch!
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

> ---
> Reproducer available on request.
>
>  drivers/net/ethernet/google/gve/gve_flow_rule.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_flow_rule.c b/drivers/ne=
t/ethernet/google/gve/gve_flow_rule.c
> index 2c80cda..db8b9a3 100644
> --- a/drivers/net/ethernet/google/gve/gve_flow_rule.c
> +++ b/drivers/net/ethernet/google/gve/gve_flow_rule.c
> @@ -206,6 +206,7 @@ int gve_get_flow_rule_entry(struct gve_priv *priv, st=
ruct ethtool_rxnfc *cmd)
>                 return -EOPNOTSUPP;
>
>         if (!priv->flow_rules_cache.rules_cache_synced ||
> +           !*cache_num ||
>             fsp->location < be32_to_cpu(rules_cache[0].location) ||
>             fsp->location > be32_to_cpu(rules_cache[*cache_num - 1].locat=
ion)) {
>                 err =3D gve_adminq_query_flow_rules(priv, GVE_FLOW_RULE_Q=
UERY_RULES, fsp->location);
> --
> 2.55.0
>
