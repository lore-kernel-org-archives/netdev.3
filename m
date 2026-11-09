Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794217146;
	b=RhLpVtS5m/2kakwbh/uhgONw4eu3Rg4nhRePiNGEXCMZMB78qCZqMgRObX+73B4SeJuf
	 uE0cOukFoNn2CvniD2lqgiq8MmCmCRjQpXkmq8wmf3HzVU1m2VMOvhtEh3DIgO0Vg4xX6
	 6bvRsX9qUb81zbcgOO2jUWuzZNf0YczBE3xhhzBVvvFbsHFk0VR1Rf+8sZwwT0iHZDGGN
	 AZ5WCI9g90uFqj9pO20OLHW0c5yV1m36miw2yF2AOmvSJqDdWZc1dA7mP4i1RIhF65J0t
	 j2Y1bDtm8CyDmehe6h/25WF2YcpsFZDHNfAzvmcQ/VYXEPhGwMG01O9KKT1JCl6CWsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Bt2kTkjGKfcd8zMvx1shHZytI48P75SXp34GvUI4/fg=;
	b=QHyx/rWyimbrN0WZp/M0ornY0t8BsK/+nMO76VsH/KC9OI9azjGginX+Fyr6uCHDSRXs
	 v6a8yrSgTIetfmlvxMVpKz3Z/Ans8NFZtuCNFK6GRNzLPQw72xTqumm1iUMfyPneXgRlx
	 lXxt8i/IM3ZgM2U3lWl7m74hFcWWNX1pRG6A9YENczH1oWbbYg+86yuhgrta9OWRgNZmJ
	 w43jGaR356ckd+Tg9ct36n0pzXi3xpr35/cXZeZLNlufdPH9eRJZ248XZJWoJziOOOSvI
	 CDdHskRFLQHuVVDZRUIhpnDBpenkQyiMC6ij9rkiiqAlzNmHP0Zf762kIuZl95yKaxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Ez/Z55b0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084F6606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 09:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 084F6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ez/Z55b0
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-483d290f398so365005fac.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 01:39:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794217145; cv=none;
        d=google.com; s=arc-20260327;
        b=Ski20wfHP7Xp4tNf0itUrxu9iTnBkkkqk/X7K/e1788MVn+lAvwlMXUPupxgwYsxMw
         NECrEdpZM+NbRzMWH/rvtvX2D+o9K7BB++YMMmHF0VAhUGh46pz073+M41Bjj2CziFBl
         dHD+HpCulI0BmOhkshgfzxdKmiUQVwgKTCG3jT/Dz9dH1Q3E7qONFfm2OlK+fyyyfXfb
         +6PUrmksQMElME2j1YVRiYW/AXBVm+9Z6BuAppRSj1fo08PSju9AdwCTfKhuAXwYZMkF
         aQdqSn+w8iXvy2SjGTsvoJaFhSlJfyD8i1S8jJ1WohqIZi8nt7FbInPzO3q/yrh1R5JO
         8hWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bt2kTkjGKfcd8zMvx1shHZytI48P75SXp34GvUI4/fg=;
        fh=vUIVsb692bL7iFV/YXcaUNmIAbH5pBPSkcA2U4E3XsA=;
        b=ZIgEYFQIu2rJtl+JQO0B4MnTgPNydZsB1pJt0POjNvoUQ6eBFJzpylXoa22rXPtbpG
         pNmIWV0+l8jYZ+SpkiahqZvf57k8Ok8BUDNwXxt+Nl2ksOrF9E9a3taZYsAmC+9oUUqg
         xP3gBMt+Ds/X43K20OTHHm8b/a41yjEd1dcLr9F9RwKgdl61UOILYUfmh2+ZAip2hKiX
         tngfFVKhxM3B2XEwX0NWmrPVn7GlnRtVte7w5ykudBfj7lG3M3TTMyQh92IeihMpBqKq
         RNQnNbRWhCPSyZHVpO24yVPmGeTlnuNd0Lzt9ZD+yQmRYN9cKCE73rdaST3YZQQ5Lmxf
         bLmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794217145; x=1794821945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bt2kTkjGKfcd8zMvx1shHZytI48P75SXp34GvUI4/fg=;
        b=Ez/Z55b0uswFCCrOov466Vti5izMG1v2RfIprz1liD212lvlAPN/9oxAdWhDg8/HNo
         hRWSJkAfaoWCJV9ylz1pMAI4Im1eai8Bz2J7SNqnmNttW4mOzZXW/RNk5dwQcwPU18q2
         75/965pmobYanJrT/00PyCd01etzF7VJNN5PdoYALtWwGKJ7yf4bGFy01E6aOM4G9vJX
         PWCB2pPCGQ5kmudjm2rrRMbIBGZ3X/Q+hh0qoTWNhHgH3sg2OKQ1J9mkXdeR0soyUnUT
         oK4d4EoG2w6Fti24nb/9i+6XfjKQSiMsQJZ2EKY2yg41a89atwJ6KA/NBWy/R6jeI/mN
         9zLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794217145; x=1794821945;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bt2kTkjGKfcd8zMvx1shHZytI48P75SXp34GvUI4/fg=;
        b=0MfHdMltoOWyNz1dKdys6V34pYMnCIm2YmszF0GTCQw/GXVKPoFdP2bI86CPVcz1EB
         aG8UaBB7JlwGfCxlwGt24iZHKo3cqr55wcA6MPyYqJJvOoi/ZueXnA8U6ZqUk/q8y7UY
         loQEeuxjiZKxZOZotigZHqXnoRHZUaztQIQy8DJrKX3qGPtumcbvKik+7J4bnAd5SYC4
         WClUGGma2wziayBrgtYKYFHQmJPUdUjaws0GYKMa8sD+YMsr2A/ErJBfQ1LB1pCksDpr
         SeV6+zfn3L0ks1AfiNUjUClRGWtKpWKN7B8VIeQmINpvKL4iCK/fNysvCuZeKmrrPXRt
         xEtg==
X-Gm-Message-State: APuU4Z+0/dV0CW29IHZINZSFgXesFb29Ftbnu/ABVfJKCwe0ZeOASU8K
	GjmNm/EhwmqnhCZhjHhou80ZMF2REzzKAe3jNyJnzLk6YBMeTkbulbd5mm7pfNyOtT+AJ1DLrco
	3PfHq+roKkFbmtmBFb53c41e0fjYd/Dw=
X-Gm-Gg: AYBFou0Ts/eL5mu+P3tT3gT0P2cUKuaWGWtj0ESSHp6lplMs7IWNkjK9Yht6IEEID1y
	y2vSjABDXQfx0WfiBo8oIVKb4o+fEvNCkVUo95+o3r0qI7UC0zlogZp7maOjJGwwsEVKMZqvA8r
	A6GM2UwLQ+EUeotyhTQu4CPm4gHNclcLlqdyuZRBxf5bLkuf/PTabiyhUDLbz2lTk80z3FmSsaX
	+WTQA0jMPNt7dGc743QSNncmH11/3Dyp7zk3D9AtZerog05skEGMaDNOxkVCsEr1+AjRy8qPx9V
	qrCRmrLguEDs6vYiEBIzCUvrmgK5ZsebdxBA0XMi2a1UyTb2ME4kOagE+ALtjD9fo5cP37P9y1m
	Y4DwZUYty5lY9uJznrHr2HhfHDDL0X4WnCNQtRUIZkRnKMCTd+XGTZTAJ7gD+007KKWmZEarXM6
	9rhdOqs3BR3jhllw==
X-Received: by 2002:a05:6871:b09:b0:499:c554:b635 with SMTP id
 586e51a60fabf-4adec9a0521mr1832827fac.28.1794217144641; Mon, 09 Nov 2026
 01:39:04 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106114551.212675-1-amaan.cheval@gmail.com>
 <20261106114551.212675-2-amaan.cheval@gmail.com> <CALuQH+VtASWP=w9ibTJ7ioYxWrS5sgi9yCZMVK0D831_A-zusw@mail.gmail.com>
In-Reply-To: <CALuQH+VtASWP=w9ibTJ7ioYxWrS5sgi9yCZMVK0D831_A-zusw@mail.gmail.com>
From: Amaan Cheval <amaan.cheval@gmail.com>
Date: Mon, 9 Nov 2026 15:08:53 +0530
X-Gm-Features: AclHuK8ZY94zA-0byUQ__DrC9NeVtoJKfHv6SKapSVwO8ABChRUHJeGPjboSxYY
Message-ID: <CAG+wEg3VCFnPMkkXVLBNgSNra2YBSZAM-Q--AEQvA597z7X5MA@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] gve: block XDP on the DQO-QPL queue format
To: Joshua Washington <joshwash@google.com>
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

On Sat, Nov 7, 2026 at 8:43=E2=80=AFAM Joshua Washington <joshwash@google.c=
om> wrote:
>
> On Fri, Nov 6, 2026 at 3:46=E2=80=AFAM Amaan Cheval <amaan.cheval@gmail.c=
om> wrote:
> >
> > Commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
> > RDA") enabled XDP on DQO-RDA by dropping the queue_format check from
> > verify_xdp_configuration(), which until then refused every format but
> > GQI-QPL. Nothing replaced it for DQO-QPL: gve_set_netdev_xdp_features()
> > advertises no XDP features there and gve_xdp_xmit() rejects it, but the
> > core only checks that ndo_bpf exists, so a native XDP program, and an
> > AF_XDP socket on top of it, can still be attached on DQO-QPL.
> >
> > The DQO-QPL RX path was never written for that. Its page accounting
> > assumes the driver keeps a reference of its own across every handoff:
> > gve_xdp_done_dqo() passes the buffer to xdp_do_redirect() and then
> > recycles it with gve_reuse_buffer(), so a redirect target that releases
> > the buffer synchronously, such as an AF_XDP socket in copy mode, can
> > drop the page's last reference when pagecnt_bias runs out. The page is
> > then freed while it is still DMA-mapped and registered in the QPL, and
> > the driver posts it back to the device.
> >
> > Refuse XDP program setup on DQO-QPL in gve_verify_xdp_configuration(),
> > matching the features the driver advertises. A zero-copy XSK pool bind
> > is already refused by the core for the same reason, and a copy-mode
> > bind never reaches the driver and is harmless without a program.
> >
> > Fixes: d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ R=
DA")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve_main.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 2437cd8ba633..4e9e692a0ed0 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct n=
et_device *dev,
> >         struct gve_priv *priv =3D netdev_priv(dev);
> >         u16 max_xdp_mtu;
> >
> > +       if (priv->queue_format =3D=3D GVE_DQO_QPL_FORMAT) {
>
> Thanks for implementing this!
>
> Minor suggestion: Can we check based on dev->xdp_features
> (NETDEV_XDP_ACT_BASIC) instead?

Thank you, yes, I'll respin.

>
> > +               NL_SET_ERR_MSG_MOD(extack,
> > +                                  "XDP is not supported in DQO QPL que=
ue format.");
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> >         if (dev->features & NETIF_F_GRO_HW) {
> >                 NL_SET_ERR_MSG_MOD(extack,
> >                                    "XDP is not supported when HW-GRO is=
 on.");
> > --
> > 2.47.3
> >
