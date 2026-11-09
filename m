Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794253567;
	b=U/o/0rxoOnh3TjXG/troXNI9qhpwwTUZn1WfWSniDKHBdAQazaiLJzgclrbdjVT4ZWTi
	 eqqdtKPUtVYt1WvBCC/v7qlesRDSdG1v+h0uiyb7Evr0uuHBUQk9F6eCmrHmCcc6lzJuu
	 /geozixhalKVM1U4z30lmyksg8ZJ+Qu0pSTfKN1UYP7faamWrPAitYKm3vr90iSANrdgT
	 MqiGZcj3y6LYF3GLh5eKd+AdkCZ0EiipC/l7H2Q7nHFuY+SqYlrh3Z6OPCwoWZj2A7KNF
	 37xlbvwO3z0r/nudVSUA7Rku5VMZg8tdeRW8PTt7DmoTR6BWdfiuKbEbboT+ztKrO4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=iOArzfF7wNe46tx1BE66G31FeLK1fkOr8F1BKZ5Pz78=;
	b=n5nyjqEs1tAgwqNey8BiNTmgtsI07qxwclks53US4dpPLrl2dSaUr39Xt1+iYLSVNOBO
	 g1hdYrc7Ui1A7/MJaas8IEPt5FPgW0Ar0eGA9X4ojd+IIz5P8ukEXfkfqcgjz7GoTz8Cq
	 4orH4KAu2vxIsSyhAAOTwK0g2ajFuYcu4x1xugVdcf7Zoyy52HQ1MMgaWHlZhsy6xQra+
	 k+cYVcNcMoZD1vS5BQT3gJAzUNQ9VhQdRx7oz102LmnkCLU9v00wkxRdNK+xDav5HfSZY
	 aiSZjXMQFv0IiZeyLoETM12+zLiyWZxpPJOs2v636LTCr0YtuZxTNOya6c0KeYDEz+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Pm9JCe6h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADBC606A32A
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 19:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ADBC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Pm9JCe6h
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4682977f9aso159126866b.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 11:46:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794253566; cv=none;
        d=google.com; s=arc-20260327;
        b=XnWy2Wk1Bo6LpW7oFAuk3ZjHxqRhugRuYiZjB3Idm00inqGV/GDYX5L4ggKvTwQ0Sv
         tghtLQ23BpbL7xEA1OUj17x2Ac7VTpDV9imjzpYFRXAdp+G3+KtUENlWRmuGSAPRzmv4
         A67hgLydPcSsw5Lj2vmyJw02ss+4V+AFCrPidEqRy5HisMAiiIkmDLDFRTTKJ60qqJwO
         QafxKPKa9dSDEouiPcMCFbGHribvbh6swNIwSii4/maQ4YqMwWXUF2Lf58qvTui4UnMV
         szm01dvXdCtlB2iTnajDFs8RtfAl0WvPLDdwlMYN/z1nUsavbpMLJZcX+DhGxgwnh4Dv
         ga/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iOArzfF7wNe46tx1BE66G31FeLK1fkOr8F1BKZ5Pz78=;
        fh=FNetVJa7K4MYOSQ4gBQlsJ3/dPfHoNdpttK2LTvPMI8=;
        b=ioYLihYot5M8TnQZTL8cHsWfCS6e5n5LolzsaCDY5P+urt2/9eXPZAHuMimfrjtD4J
         dy9dA1PvE9v8Ngr8rzei7GKfzOLXkBXI1brc2pAKzP/7jKPuSwkPGWtw/Yf8vl4Js3Y0
         ZdkJoqz90Un65NArQXIBft2tifER6U+keGJTMKwb8kikcxf3FbzA1TM/K3diGKLvreHL
         tuxO5CI52+rH5MRsoqrHV5IGLnpZwxgWkquhat79Np+AGIhXra2sPEJyRVE9km1Mj3Ef
         ine06eqiX+bTINme03OhymoQKuGT5Rb0sTCZewQETPZ0aWPedghrPoBWzC/3X3gJbGpN
         HSuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794253566; x=1794858366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iOArzfF7wNe46tx1BE66G31FeLK1fkOr8F1BKZ5Pz78=;
        b=Pm9JCe6hrPVGrO2xDSZJWLVIhH3J0+mcxGAYvFMk2DFM0ZHUx03KkC0cEv/3IjxXND
         eZOQbXyQiFneqqRZLDkftAGH9oiDqBN7ob4S6jiuI+wE82k/kcKGphEO5PdiOQ4YImwr
         5VNEvqdRvqcbGenyy0d3N0YBo0a0GX5vIDKuiiGSSzkwlYO8v0xXsMnPhPsgsetEjlww
         yAVG4+PkSS43HSduO3LaOKyAsUHHOcGjT1fmbuaO5T14ranz/G47LCT1e6xjA6Q9ytVU
         IUhEPyVotJ0oW3lL+ikjEYqT/+N9XD+oy17B2/l6qCPex25kWUX3Mc6srIW/JRWQ9ynq
         WrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253566; x=1794858366;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iOArzfF7wNe46tx1BE66G31FeLK1fkOr8F1BKZ5Pz78=;
        b=pf6hVey/WBNuzagcWt3WStGk6BRvRWESfQbm36fanCX8k8xxjGrU+YDDq6KqJlK8nn
         gduBarcPu3cSXnHfgvHi+ZzMdF+a33YELGcw8VvVGEjSBNmz2BevHfNpVFMd1jtk1nEQ
         rqRhEErynj/kHmJJd4rJ/PnQ+Ri4KuQd2E+7p4wcbVRWLz2Rasj7MEkMiyBj+QYyCHgR
         9IRwAPvBAEHWgXtwzOZcHMh3j5sbvCJ6g5UcsBr6Ry8kr14GHkBMR7AMcm+u/R7eVJn9
         ugP3+jtb9TSBHCGf+v1yOBMox1OWvsqxKlYM5rYQKJnfGTV3svtRdgNbgpLQYeXvmXx8
         1YbA==
X-Gm-Message-State: APuU4Z95C7kj+iISgdlUTaQC54HVrdRY3nQhNJpYCgtD2/OfagZiy6rV
	WJZNdrAr1ZvCTGneFBEDVYqzF11tKjWdHX8PbVJevybo9GvFAsbvlBSTkhuqwVN2u0uArZ808pU
	SVEhYx7nfofvuXBkvrPeoqQHWJCED4UIrt1bTwG5E
X-Gm-Gg: AYBFou2x5aF4QpiCOBd641leD1nbiIMesmhyocXKkC661UVdrzFWJm6y+UvIqjqSXsR
	Kgc/loUN3dOrkCBo+dpuU374ZjkEjUQ+B6XQprVOVWAB1o6taDlaZZMdpTVUhtvpBMLe76uxWUU
	kVYlLC2GwWxNoLp8vOUEztOCt3Em505xyAzfefaE/7FIqRdGcUwzzft86akHJr6m3eoYjK0aSss
	A0PlGUKMRpF9HDLyfSpKcWy/FXewm0JRLzJcuu9+JrfyI9HO4SanpUZo1DdPrPyF8Dq/CHS3HBA
	FfVSkaTRz6a1kwU595tskdm5BlvqHN5b/EwtQbwfM4Y/YnEN1S3J857Ef0ecPPz+XkVtHbVP+mk
	Qow8RcBa9vt7+2EjCdh3Ti5GwRiq3sQ+XuZFdLEQf1NKq2uQdmr7WIB8OaHRplrFaNyM=
X-Received: by 2002:a17:907:3e20:b0:c41:64c1:cc2d with SMTP id
 a640c23a62f3a-c50491bd62emr32238066b.2.1794253565000; Mon, 09 Nov 2026
 11:46:05 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109100437.331423-1-amaan.cheval@gmail.com> <20261109100437.331423-2-amaan.cheval@gmail.com>
In-Reply-To: <20261109100437.331423-2-amaan.cheval@gmail.com>
From: Joshua Washington <joshwash@google.com>
Date: Mon, 9 Nov 2026 11:45:53 -0800
X-Gm-Features: AclHuK-f_6xX0FRybZe2n9V_Z8dkntQqvMXacQrG_VwUeSpjRAkA9EO6aNAi2BM
Message-ID: <CALuQH+Uee+=2NyhCXVmmESwXxSqDYKY3Foj70KM2qY6g5UsOXw@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] gve: refuse XDP on queue formats without XDP support
To: Amaan Cheval <amaan.cheval@gmail.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	bcf@google.com, jordanrhee@google.com, przemyslaw.kitszel@intel.com, 
	maciej.fijalkowski@intel.com, pkaligineedi@google.com, maolson@google.com, 
	csully@google.com, willemb@google.com, yangchun@google.com, npl@google.com, 
	awogbemila@google.com, shailend@google.com, nktgrg@google.com, 
	maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 2:05=E2=80=AFAM Amaan Cheval <amaan.cheval@gmail.com=
> wrote:
>
> Commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
> RDA") enabled XDP on DQO-RDA by dropping the queue_format check from
> verify_xdp_configuration(), which until then refused every format but
> GQI-QPL. Nothing replaced it: gve_set_netdev_xdp_features() advertises
> no XDP features for DQO-QPL and gve_xdp_xmit() rejects it, but the core
> only checks that ndo_bpf exists, so a native XDP program, and an AF_XDP
> socket on top of it, can still be attached on a queue format the driver
> does not support.
>
> The DQO-QPL RX path was never written for that. Its page accounting
> assumes the driver keeps a reference of its own across every handoff:
> gve_xdp_done_dqo() passes the buffer to xdp_do_redirect() and then
> recycles it with gve_reuse_buffer(), so a redirect target that releases
> the buffer synchronously, such as an AF_XDP socket in copy mode, can
> drop the page's last reference when pagecnt_bias runs out. The page is
> then freed while it is still DMA-mapped and registered in the QPL, and
> the driver posts it back to the device.
>
> Refuse XDP setup in gve_verify_xdp_configuration() whenever the driver
> advertises no XDP features for the current queue format, which today
> means DQO-QPL. A zero-copy XSK pool bind is already refused by the core
> for the same reason, and a copy-mode bind never reaches the driver and
> is harmless without a program.
>
> Fixes: d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ RDA=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
Reviewed-by: Joshua Washington <joshwash@google.com>

> ---
> v5:
>  - Check dev->xdp_features instead of queue_format, and reword the
>    subject and message around that (Joshua).
> v4: https://lore.kernel.org/netdev/20261106114551.212675-2-amaan.cheval@g=
mail.com/
>
>  drivers/net/ethernet/google/gve/gve_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 2437cd8ba633..fe560f5c5408 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct net=
_device *dev,
>         struct gve_priv *priv =3D netdev_priv(dev);
>         u16 max_xdp_mtu;
>
> +       if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC)) {
> +               NL_SET_ERR_MSG_MOD(extack,
> +                                  "XDP is not supported on this queue fo=
rmat.");
> +               return -EOPNOTSUPP;
> +       }
> +
>         if (dev->features & NETIF_F_GRO_HW) {
>                 NL_SET_ERR_MSG_MOD(extack,
>                                    "XDP is not supported when HW-GRO is o=
n.");
> --
> 2.47.3
>

Thanks!
