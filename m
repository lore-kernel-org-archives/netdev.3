Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D4A45038
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752644; cv=pass; b=e9qWGit7uZyAesFOWkWPe8AWIfHDj0ToXrsa79tzEohR02ip7V54fr2R48CZhtYLqi+RfSrKdhZj9/ruIiNdjaIvwXVpQV1eounZn+F5b+fSClO6BAiZa2ru7ww0MwhaaVSTzR8vta7Ea5Joc5cj04fkCloe6Oob719NaQdl0u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752644; c=relaxed/simple;
	bh=MVFLkleWnWpFnYthcLE1wkkKr60fbd1HYCcUyDnHcck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mo0WYmIYNacK7BcYvzwBCU7LzEgC6DkNx+kPcNFEWCGLeJeiJjKPGjdFddJFEEBQ9mYGRPj9F/0GcDVTDdKt+CyQx0NqkZKGdQVlt1BZrwV1pRJ9i3bKI7krQgsfk2g5PuOGZD+mjzRBfwVEDXRScNG3YHv3ltPL9Mmtmhup4r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=piDR+Q0W; arc=pass smtp.client-ip=74.125.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piDR+Q0W"
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a75ff20a6eso20360881fa.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 00:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790752640; cv=none;
        d=google.com; s=arc-20260327;
        b=lYy1cuCbp53AF5v8teJC2B9hYV4uV/howLclsal2uszKjNhTv1/7JkaaxccYkttzix
         wjDA1CFrRSH59jPhpCpwmEm3yZbV9/LaK/RB4Z7XyX1rmncE6oA3tfQlHrTRuBOdJWgL
         0PTAvYP60vm5s7znAow9IxBF8r/qy1VLVRvUUk5wvanBdeg+ID6eIEO67NapRXk4UEHP
         5NznE2cIFNNCFqy27rDxWrSKKEpYv5LhXGKSzC5CXMp9pzEcIOf7jh2FXimifTyyVdKW
         WLBc6zNYj8/7/tN2kiPt7Fb2uS8EEBG0AslKn0L9kZEqwN06K3Y1BMGaTA5oeRdQdhfe
         hoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ea8nXYm0xabYrwi/85CAYe7b5DVLlU9SgUWviAoGpxY=;
        fh=lY1cg3xd6JCB6La+IPz6S6xBgJOAVIPIiCqtI4AKMt0=;
        b=PwhiPztYoiwJ8wLotxQMpz9RRMhlg71uUt9Qi7+Us+MkmU8tAgHwtwFUov89zznFtI
         l1delL++OvbLhFkeY0BYOp7meZaoYIf1uglVg/NJb5eYJbqZWdRCgj9CAN5w0A1BQQ8U
         QooM+hzBfxFP3eAmsJGJ3swnlq69cQAS2M9cKx4V2mAwQU/stCSkRzTgd7FBsntSa8oB
         ulPyD4eJqi3EWNudzCzjWIwyoUDB/1GtjFpGEiS0/TES6A6UIymZKjWIxA5eqjrABJG+
         z0/4uH10A6F00EPPKRnSSFvNyVh2z/YeNGpzuVbeKZBi1Dl+xa7BnmVLASynnfc9iD6r
         r9BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752640; x=1791357440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ea8nXYm0xabYrwi/85CAYe7b5DVLlU9SgUWviAoGpxY=;
        b=piDR+Q0WAPh9IYlTLNJ6jz+C/ECnT+Hro5ROp1yD8f3X4LfCHlKkrc8/yF1eAYohzX
         cWHtWAFbMt9mzBQIzKpYwarFm4td3dKV/qYDlNFjo/rwCrfyl6PNkcP15ytNgMsibK96
         OVFsyUVT9CIMeb907FhDjdJVkGyLkuMzTcwgeyZfH/50oMv4KU58pAfywIKl/hVFqfZA
         UJLREMAG4zUerQpEfeYdMreCUvCo20VYaJR5bG0W5CWKdcZIJN74c03YvAQQ6yWArTjv
         5CTDH7tlYZa5ktMOywKxv9+rF8GD3k6PcAR3+XXUtCfuOm4wfvY1l25nbHpG8Lg8ywlO
         +7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752640; x=1791357440;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ea8nXYm0xabYrwi/85CAYe7b5DVLlU9SgUWviAoGpxY=;
        b=lfW6xEiyjRliUGUqCCvRwJL3S4Ed1X3Ma+m0J8NNkrkj+833kOxcADMM1fuUBiKTV2
         LSGnibP7HXy9Jgcym3OlDtsu+qDev/JSc+y8ZCQmDOmCZtQH5qeEh+mdWjtmh8zbICYb
         bImtKjzwSUh2ZUWlp9vbvlBvK9NMudxUfymeh+FQnhj6q+aUsLEkPjVXIDsr0V5Fj9Vg
         HsOQkA1FBDmEy1GqjZtyYBXpLrBS5vsUY1FKbuEtIi+znAUrEfJG+nrQ8EU/TdYtYMnR
         9LYi0W34hVwUecVauaQRDhfKdqnu2r0Ej883hCOEVkN+6jfNxIgwvDjUFVZPvgL5ufH4
         AM8g==
X-Gm-Message-State: AFq9FYL6OOmjBKlWfLlllAjKTSzwmaNQzr5x5CcZcoctgPSxQvrs31Ck
	yROjAZbCcxy3mMqoqIxGH9WIq2UMz8nq395ILeeGM4bfD2zalP5qSKuoQdbQzTvx4iuo4y6byGt
	Gp9uX3VU7LecBM6IgZCQB1FlojJ9TvT8=
X-Gm-Gg: AYBFou1iFctg2QNthHHW3AoJlQQwRNUJQ4MYjLgD3G7DOcD4I+3nXjr4mrLFx4l5FJm
	ZPMIcQEJ2l1ftx5bJ468qT7nauxwLkFDTvT0PeHXn8dBDc4aP81x/WnwTuHkrmeM9qOS0HL7igh
	VTyrcOte3Y58j8uX3+tWqU9y3Gcj/JEB842OOE73nV3+ZQlwo94ynvhtkzTChoRYypb7qRwYLxR
	B/DN4g4vyko3C6DJ3ehEGoXdI9tbI4jO9JAV2hU94FFWU4c9/r2acbor5fwCA2bkZ62m/sTh9OA
	v5sA/nfxF9lh3uq7a2z1CyTiyMuMsQoRrvwEVoIL2RZ+X1KW81wCGA==
X-Received: by 2002:a05:651c:1547:b0:3a5:ba1e:8b05 with SMTP id
 38308e7fff4ca-3a77913af41mr1881391fa.1.1790752639889; Wed, 30 Sep 2026
 00:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924135052.185129-1-maimon.sagi@gmail.com> <a3275288-1eae-463e-ba9f-dbb2d715d1b4@redhat.com>
In-Reply-To: <a3275288-1eae-463e-ba9f-dbb2d715d1b4@redhat.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Wed, 30 Sep 2026 10:16:52 +0300
X-Gm-Features: AclHuK-kag_H1kMGoxdUxezLS-VrTRKTJfJccb_2uUMkHaUSNrTcAhEimC6uRNY
Message-ID: <CAMuE1bHcd7LGW2VOa15hhWwc7otgtw30FmtcBsujwcoJvpQFvQ@mail.gmail.com>
Subject: Re: [PATCH net v3] net: axienet: bound TX completion cleanup by the
 NAPI budget
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, radhey.shyam.pandey@amd.com, michal.simek@amd.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, robert.hancock@calian.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 4:22=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/24/26 15:50, Sagi Maimon wrote:
> > axienet_tx_poll() passes lp->tx_bd_num to axienet_free_tx_chain() as
> > @nr_bds, and @budget is only forwarded to napi_consume_skb() as its
> > bulk-free hint.  Nothing limits the cleanup loop to the NAPI budget, so
> > the number of packets returned is bounded by the TX ring size rather
> > than by the budget, and the poll can report more work than it was
> > given:
> >
> >    eth0: NAPI poll function axienet_tx_poll+0x0/0x180 [xilinx_emac]
> >          returned 96, exceeding its budget of 64.
> >
> > Returning more than the budget breaks the NAPI contract.  It also makes
> > the "packets < budget" test in axienet_tx_poll() false, so
> > napi_complete_done() is skipped and TX completion interrupts are not
> > re-enabled on that pass.  NAPI reschedules the poll, so this recovers,
> > but the accounting is wrong either way.
> >
> > In steady state fewer descriptors complete per poll than the budget
> > allows, which is why this is rarely observed.  Triggering it needs more
> > than @budget completions outstanding at once - for example when TX
> > completion interrupts have not been taken for a while and a full ring i=
s
> > reclaimed in one go.
> >
> > Stop the loop once the budget is spent.
>
> Napi can process as much TX descriptor as available, even above `budget`
> see:
>
> https://elixir.bootlin.com/linux/v7.2.8/source/Documentation/networking/n=
api.rst#L68
>
> The solution would be capping axienet_tx_poll() return value to `budget`.

Agreed, and v4 does exactly that: the ring is still reclaimed in full,
and axienet_tx_poll() returns min(packets, budget), which also gives 0
for netpoll's budget of 0.  It is posted as "net: axienet: cap the TX
poll return value at the NAPI budget".

Thanks,
Sagi

pw-bot: cr

>
> /P
>
