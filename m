Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97C3509F09
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542039; cv=pass; b=ZAyFPWHU1WDhPVcFloR/VoV6bnUrQoiobR497W+kaEReswYfRJPm4gNcB/9N2HL8xjoTAEKl3oSjMKZr2l1VfSrHI8o+GlZDFVIlfbad7/wKJpmqpIiOYsydT+WW28Q1xig1EfNn4L1ttKw0iDhJclIwxFyn2Q0TQZAhPMrimHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542039; c=relaxed/simple;
	bh=gI9dUQ8wiv5lv2x0pFlCP4x8bszPw6o3peECtO1JUEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ln4aOvxkzJ7pJ4ASmY483hvJ2VLvPD5h8lGxoLnnLxoOgAh3Hc4pzexxUo0kJLoZl+ibDuMkhJepaK06Gr6zetNgy4t4l06Z5Hw9PsCmYUvpfe9szgzR/tSWGX0aAiZzG2dKCgX2je7swVDyribdOdpqYb2v/rJ8XcKPq+2emjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmjFENGP; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmjFENGP"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4af81963f35so765744b6e.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 10:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788542036; cv=none;
        d=google.com; s=arc-20260327;
        b=TfNKxG3rI+ecO/ugizc3eYk5z6rPgYHBAV5FHL1VEde572wiRFqhI6CoDN60vXx6gL
         edftQg09f05hqmj6Seiow0SaBA2pE5qAitZuRcb7ND41tMbUsBomnI5SbndOra+Qygul
         YfiRHlPh8ungN12CsNK1y1G6IXrdE1Q1WpWkoTINrrKlOIZsX/juEKTPKVDEi9W1oEnP
         lTRCBaJF+F5ifJW4ZAVU1CIJCh7JTqGdyamw0MBxdESvcBeeHgRJOJ9mfhXogs6ttVK9
         8NgNnPQRaGANNLtNTYLVN/vs79dGyDqmjSFeDXPpctBj24Qvjz57ZU+oNucGy0DPSjRP
         P7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2gGWC58DN3Hv47prtJd6tW+JLQXqnPK3pzZLxlOZTUk=;
        fh=k1FHLqBoZHelardxCpISWeyyAYyIkEtEqzKCOndMoVI=;
        b=egMN6eDTInBZm8AycksDkHivVv3X+ZxfyqbaRYk32E52tPDERYF2awvT2wq+2Yzhde
         qWyhjnMjfxxaMTW+Xhp/9VvFN9zFh0MEFOMoH55zmINlmSFIuRsGHkAQXFkkadJicGVA
         fDleqQRV/IyRamJyszrNKX2Y8w62JPp5hnRzp3U3g0Cd/5JHsjNK+g+B3L/4dOuxp8UU
         tCQvHBfy6kyL1XlflzXXJ4IhSb4/A+wRygc2u5RAtqL+XyNsHznRP/7kl7C+Vy42sW9V
         yTbZGXMqB3IpurHfAAOl6i0cQEV+pNiQ3djYtxLGSfsbKIi4ufsQ2+da0Gt4FMfuFwhi
         TSSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788542036; x=1789146836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2gGWC58DN3Hv47prtJd6tW+JLQXqnPK3pzZLxlOZTUk=;
        b=cmjFENGP5SyGxdQBNSitTV8gGxIrh74w5lPUOHaTx9ul8oX2t18of6hDyTWfgI1Wcb
         arNLfeiVNtK73LOcsUUGAwyKlz/JtxtLiWAz1p84miRF9CC9vmSfpZ6Tot0jGYWVIg9G
         /dUdINDRi6nGdz8QDQoWGy71ltABzbJuU1X9o+zZTmM1io2bjRoz8QYMh4nWNYuOd6An
         vT7n8SjWJkNa8Vkn5i1hqpsIwYxpweQLPXrhaWlDIZWNT9gk8GnL5kvEQl2ptEyWjMDC
         UyuCmlm4dbDH5QwOvA71KKyRYHGpYJT8rJUSQFS8BvPtrbOXLSOqArpONZmWvYxS3R3b
         OKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788542036; x=1789146836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2gGWC58DN3Hv47prtJd6tW+JLQXqnPK3pzZLxlOZTUk=;
        b=V05ZTwzabdjJ0rd8hnWo/kYR1q15Wxhomqr1JiW21503fBITYqmdrqhw4DP6G5luKz
         tqRW//xM1wGs8boqpWQcg2SR1gmeg+Wtb18xtKmG3XgudN6tjUtt7J5Mg2TcdpP03p10
         4Kw+6LEd52CrbhvpkgPztaGtuqVOT/4KLMhntn8Q5mQPrvy/JisJJr5ptYKnl0YJzh0l
         NI/IXYKDYg9JjxvmSmEQbGlgFglfbFvRn1iGahAfAXEo6lz1dLAsDxMoj48j85Bk0CQK
         WiyR75KBdn3T/F+SUF0XVgB0CQdM/9roO2tfFSA7jjHZfwxWWGjUAE7aPzq6eiJU3S7S
         +IAg==
X-Forwarded-Encrypted: i=1; AKwUvBzAXxNmSIDoG2MADtYd+GyILGavfvE4gk1xNpq4t2jcp9pR9sDQVy662FPb4i4LK8Sxx66JfvY=@vger.kernel.org
X-Gm-Message-State: AFuF++nIuNLGjzvTVn2wn2oSlxeBWCI9iQEVzRntYCEilD5LPVFTLcPu
	k96fKTy1ywnSZBsSNKdVmIw7bUAAUuaU1opKshZHyyxQK3QgK02SvdWvqXl5AcR3CsbVDzKWtfF
	0pqGtrN1AtKuLvbMg2CYQJDNcxknReJs=
X-Gm-Gg: AYBFou2XqeTgngALdgABXMgzowU2QzrCNRVEMJnMqZ9uQMP8KjjpVPwhkbkfniEEypU
	xxnJcT2RNarRVQ6kLoIOebeNvbTkZVYjci9xGftURc+pw2Hi3h0bR38IgPB3BmP7rx5QP6OeT/k
	X1hk5cvZHVZBKA48xx3XX80F77nUcrLiyIGyXWbwgaPrEfvZNxVOREaJpQeoe+rKNFcKeDQBuzH
	w9QpWw58QZKeNky3/iAWM7852UNy0M48x7nRMRuQAwwoeodKIrOAxv5Q59y3tg9A/nK5NkhhWE+
	2ocFgItvfaPr6Qt9wfLpAOV1IL6iYYL7hcrlAyA32ctzFLQkEkKLfDkqNYxyOpgbFGA1zoV2tOl
	2ahhMZvDD09aeTOU=
X-Received: by 2002:a05:6820:290b:b0:6b1:39b1:80ee with SMTP id
 006d021491bc7-6b6fe796fd6mr6700868eaf.24.1788542036124; Fri, 04 Sep 2026
 10:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com> <20260904095416.1692962-3-kyle.switch@motor-comm.com>
In-Reply-To: <20260904095416.1692962-3-kyle.switch@motor-comm.com>
From: David Yang <mmyangfl@gmail.com>
Date: Sat, 5 Sep 2026 01:13:16 +0800
X-Gm-Features: AcwNN1V_U66OwBJ7SqL1p4UY054Vk-Dy0fNkexu0AJl1AbJXTOiGV0jcR-p9lFU
Message-ID: <CAAXyoMNLk4ApuaxxznrPReftf0TNaQEBVF0n4gmuryJxLYdvTw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/6] net: dsa: motorcomm: relocate MIB polling
 initialization to dsa_setup()
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com, 
	jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 5:54=E2=80=AFPM Kyle Switch <kyle.switch@motor-comm.=
com> wrote:
>
> Move MIB polling start from probe() to dsa_setup() so that it can
> be conditionally enabled based on the actual switch family support,
> avoiding attempts to enable it on unsupported switch families.
>
> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
> ---
>  drivers/net/dsa/motorcomm/chip.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

I didn't see this patch being used afterwards (and patch 6 seems missing).

I'm not against the patch, but if you don't use it, please post it in
another series.
