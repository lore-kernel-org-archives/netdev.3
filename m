Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021C3B2D39
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187175; cv=pass; b=h9s/9Yfh70aqYGOdcAYlftHiTbC6VbMKK6AuK/KLjTsQ0tJnRIQosxhS71gnuFrpWdt4U8NVZDWmmt2Vvlcjohk65D22so++l3uljeIceRdKZhSzZlZSlzRHEsY+QokdpEcvmbsDb6L3vz5LeBJYFU3RXn6S6DSPIORQwXt1Q2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187175; c=relaxed/simple;
	bh=+M6PTihgtDtFsZxuw7Q++B8TgW7pGWpmB1Nkhfd5GAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyK/PR1z8hif4StX7ElWs/c7cVfSFZewbztFCOvSi7fI2Yvkni0HilxkjNvGPAt1rdwFKuhK3DX3cXrMe9MaGZybMCvKsJumU6Tg9bxgzsiGdKxP0vysbSY2F7xxjFyxAPgUULHgcMVy3mtAzEtH6cZ70t4iRcwj0KB3v0/xR0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NHCOrwBl; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NHCOrwBl"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca80d708489so215409a12.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 00:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784187174; cv=none;
        d=google.com; s=arc-20260327;
        b=IjxxO71vtUxmY2lX02BSNf2QbB6BBXqUjB/Cy6Iv1uvd8HE7l+Y7PSFRKW61SO7Fg2
         PPyCUfmXF2wa1FTu+naX6GtnTHWE3Ayx/gSZJn3hQeRTkL/BGdDFjx+YNi0BugigqrIL
         sM8K1xmC4fCcloDGdPcEWZx2+k5o7mSEdXKaIanM9+ydsaD0Nlrv6jxsqfSC685uCI8J
         XCL06+78LNHuOaAEMdYP3wDdudLjSmkz1M+m/InxgFFM8r/bx0XuIbYvsDbAEN0zeelB
         +Pe5EXWWbH176TUPWCAOdDae1J/0BHhGHPahrWxigpBhMBEDJFSjfv6qDPtKzM2GQLvc
         7img==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YnuUABR33tj6V2GpcN5Xf/2z11QSbJ0yMB5rIV+79YM=;
        fh=An44O9MgdPuE/aCMAVkEtf50sphM5hPXBZ2Haa50H0A=;
        b=fRal4gfumQi89+Y3QvVkm4h5vN9T+J2i0zMCB/bGNtkgF0HZlVXgLHwwsWQxRPXu5/
         BZCPu93NiYQBt0Cg5jEqrah162I3r/aK6dloJytMbl+NswrwT2RjDIz/+r9w8BO504aw
         yPjmtwj3icxCPB6zZhJHtkdNzVrHqixADI8sp2J604Xgkh0d5jHVyxlOAgZIBQaAikXO
         QY6bfpnA7CvtT0tEWQ0LxdlfIHgaQ29N5dcCJa2e0o9HZYhurAbXMFg9/BV9pTj6+d8r
         nbOZitn2epAqGgqhJD2iYXNWs9QQpLeJzwbuARCnxNW0V22yvgsnJ+/7wQvbqA3FnVcU
         EImg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784187174; x=1784791974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YnuUABR33tj6V2GpcN5Xf/2z11QSbJ0yMB5rIV+79YM=;
        b=NHCOrwBlwYx+lDZfBQx0tU45JhROmk+/2zEg/rB8DginpDCDzrMS23p7gL1j498Hv3
         XoM1vvzoah5ackFYYg0Mu2Za3OcfNW0TXetxlwpmvfSbmuemQk7S0Mca9kH+cLizfrMj
         tOM1tQTE2lAflTB/u2Zj5XdOGQCE9SY7tPn6Q2nMUkOMNNctOwsGvci8FFldKKG+j4eR
         /RrG+N385IdkkHA38Ma5EuQpDfSJOv3SGnYDR3JyHKncYOSmHW5QUaqGLfkpw/G9pwf0
         Ja03ZZJRjwEwZ7/FixFkFiVo1EeJMY7sCNlaKF1d0Louglu7wR3nm2wVWUHzgBqZcNtj
         6ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784187174; x=1784791974;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YnuUABR33tj6V2GpcN5Xf/2z11QSbJ0yMB5rIV+79YM=;
        b=V1kGrW3fo37NlI8WjeUX07refteYxfhKNGmiHvENKyjLiCGdUvcxbd1I453/vGw6nE
         3kRygPLic5P24sjhLeOeA4SxeGTwOkfOI5jgNP/CFbWyN+aE8BlN+4kBcUDs858HtKD8
         u5bUOzcsAcqrEiK61cJajjzvCLJn6m7CWs48R2a9r5DqawXHh18YQhRCkq9yyeTdVo/U
         LfCvqSpovFoodUQYi2OKovBpaE58VCA7cwfhDEFkQjs/EXzcICfj9K560TRRt7VErAhk
         suCpy67jx0mztedYroJPQzzuKU07MXE/lb1F2g9kShama97zZi+BenbLk6JJ2O7tav6d
         WPVQ==
X-Forwarded-Encrypted: i=1; AHgh+RqgzCF7qgzevUV9d3nRlCqfWc9KGrHCy9D9+f3/Ynjh6L78Odkpxpow+NDHTOEBjLmm8zvz3gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVDh60FxZu+2ubHWonEAbVvnv2LUWmgf2biTGFfem6s963SSIz
	U3CI60d2TH+iYwZ0VRvFhGFYQmEq4THI2laON6TPt654QDI2JxH86NoRyLmJAvOZYCSt86gWFy+
	s8g1gk5OERpaVdjTMwv3I8Ff1sjbXVshvo+wmJf6c
X-Gm-Gg: AfdE7clNJxIjqsg5AMAAB0P1QU/4EdNeduXNxQHAaHlsXI98+awoHnsMlSFQ83y6XOx
	PuI8Xs1bRZQ+UmcUBzeooueMOX9d+ldH5mYD3WztgCREn8uYzHwxoniLzte7meStR8YTFNOtzuJ
	e8F1cODoqHOk3wGC6gMkgJchQJnueXTtobKo2LCEngmRrgeDhugxBrKhI0DhDMy5+QE8YbN41ja
	Z1prtRfK1os+NX54aPX/GgpOwwYYIwSRsBBXCU+SgYRQplO5MZE/7vCwKxrUzQRDMhm90GtXskj
	blxUlLsQ4JCFyfb2vAHL59ZxAaUabHSXmBUyUkzsM/DKRRcGaFET/2wykh121DpeSB9CLJHhRXJ
	vlKmKqii+kSo=
X-Received: by 2002:a05:6a21:9d45:b0:3a8:800:bdf4 with SMTP id
 adf61e73a8af0-3c38dbff0d5mr1795996637.33.1784187173025; Thu, 16 Jul 2026
 00:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20d74693ac673ba1db0c0052a7236db777fc5ec5.camel@codeconstruct.com.au>
 <20260716063534.116793-1-heminhong@kylinos.cn>
In-Reply-To: <20260716063534.116793-1-heminhong@kylinos.cn>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 16 Jul 2026 09:32:41 +0200
X-Gm-Features: AUfX_mxCBqkytfR2QC4RIKX1530RTQAOUl2AfZC3ko1rQPVyIFq0xJawyIjphoo
Message-ID: <CAAVpQUDLgW9C_DcrHfWpRB8VN1Y28k+4+ufp_v2A5YPzep9mZg@mail.gmail.com>
Subject: Re: [PATCH net v2] mctp: check register_netdevice_notifier() error in mctp_device_init()
To: Minhong He <heminhong@kylinos.cn>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 8:35=E2=80=AFAM Minhong He <heminhong@kylinos.cn> w=
rote:
>
> mctp_device_init() handles errors from rtnl_af_register() and
> rtnl_register_many(), but ignores the return value of
> register_netdevice_notifier(). If notifier registration fails, init can
> still return success while the module is only partially initialized.
>
> Check the notifier registration error and fail module init early.
>
> Fixes: d51705614f66 ("mctp: Handle error of rtnl_register_module().")

The bug predates the commit:

$ git blame -L:mctp_device_init net/mctp/device.c d51705614f668~



> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---
>  net/mctp/device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/mctp/device.c b/net/mctp/device.c
> index 2c84df674669..822120e860c8 100644
> --- a/net/mctp/device.c
> +++ b/net/mctp/device.c
> @@ -536,7 +536,9 @@ int __init mctp_device_init(void)
>  {
>         int err;
>
> -       register_netdevice_notifier(&mctp_dev_nb);
> +       err =3D register_netdevice_notifier(&mctp_dev_nb);
> +       if (err)
> +               return err;
>
>         err =3D rtnl_af_register(&mctp_af_ops);
>         if (err)
> --
> 2.25.1
>
