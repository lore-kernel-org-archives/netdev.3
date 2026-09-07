Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3AE40F730
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809209; cv=pass; b=ZUIaSg5EPNgGk5NxfPndCTXupwdSVcb4aVXlyRh1mjfCMZzd+eI49shd90edXDAGbqNMPyXjh1FAuXqVt6PtddVMFlOQQwtqda3JF1DKLsEwoo+7Nt0+yfWFOJ99KyY3Nkvib2Hoi5fd0eexXhawacFJATYSTkES3fj+lGfOyG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809209; c=relaxed/simple;
	bh=DmILtzqZDzEUGV1I4V8TMYjsJF/IY1peGYXwFN9ey4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwaS+sic3uZF4/SJ475ENnHnCi4yJOq2Nljn8ZSUghqQYpd83To6tbz0AXwvXK+9cCBdh27vsqS9eLAkEtI9WCVt9PM0wXiOc1Ym3LiKSZcY2x0CJHYfPpOnTDYvGIwPh27sMoC0FCwrb8xx9quZd/R7RA541hkfmxNAGj5yMys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fq18f210; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq18f210"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4843e9c5960so3832730f8f.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 12:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788809205; cv=none;
        d=google.com; s=arc-20260327;
        b=H7zUO71NRAoRVrt+0vxejnWk414YeYl8zGkkLrheVa4J2BSR+YbukQwFTxmtB3R1Ku
         r5A12/FGCwY6UVhtZe3XvkVgBbKZg3KSbqhCDROge5B0nkITKn3qBiqoat+hQ0p4qSxe
         PX2jFrOpeddzMLacyRCT1vT49Y3fgj6GBAR+T8MtQrkk+hg89lTaW2/SFDPtR5rZJEYj
         LWB0rXA/SUU8Lv3u/xmNjb5muTWZPM6KCYx8wYrIm1w70rbQRPFeqOejCNwb/qfO0bGs
         gxbqOFDBYn+MnJPigvLE6M6V9SQR4nlbI3sMftkrLcIlGa2JUWhZ2ZC8zB4flDDKNaPN
         05iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kBhKUAdBctYk4OBLe+242bptFLWaOmD7/1s701If7kU=;
        fh=zl7P2MjMxIZZ7zJ1LGkSiGUi1j+f7FS5y0Qk2o1E/xE=;
        b=HP794h7p6g9v+N/LDTSwaZHAeQnM3gOAuzLWjy5C/C40JoYzGUFLnQA0NGTB3XOiVu
         MNSEaL8pva66RWdww3C8nIyriqpGYD/RYzaYK0K5OFBncHTUcin6ieNMos9dccel3FRV
         OyX0GyjYxFaajzPFYJYRi0I7sCqXH9hzCtDLKaWt9sWX5V9LnXCFS3FZX1WEoMZuC0Uw
         LG4INVZG0Q4XmWGEU/HN0QpK+m2bG/CZkwhziRCfDI1uBK/CPBMySzNNJ5kWwcaQPy33
         LGTZc664tCT4IAAoNFK2kifjfFzA7JlbYfJB+3vUs6ukHGMbtQzlTyoY9hLsaW8jh/nF
         +94Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788809205; x=1789414005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kBhKUAdBctYk4OBLe+242bptFLWaOmD7/1s701If7kU=;
        b=fq18f210MM3m80kQ2Uea52OvkX+yulhV+P5OEhS7K4mi8w7ZGBtOLUMGkLknSrA5os
         eJT1JBZ4bGLPhzuoZGRcOmWuYczYzVUfTo8hD2vqbjcJOSiCZJO6BV6q2dI0hUE/xBjA
         QvZMqncGlOfVhpoF0SwiUdarZeRwvjoCZKKhs0PgjZx8dV/3dfOymoHUmtDb8YC6ucAv
         VJiEZR0G7gWK89vgBZTkAMhcB8xCVyLC0iqc7tHNs4VNUGCnwDn6Ybus4tRAJ5QHVsgO
         S11Pf9zpRxtM1k5y9AQQMwUvAGIxX67xQF2OmwpOwzVMtPRUZ/rp160LEIiXdtL0Ylqr
         xLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788809205; x=1789414005;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kBhKUAdBctYk4OBLe+242bptFLWaOmD7/1s701If7kU=;
        b=Joxe5aHJ1SnX5vrSpn09u93ys/GV4DdqTOSryR//7lSbp3Mb6PvahEgGC/rZi/58Vs
         yAKa0tU105DHMVWh98HkWawOJd8oN2Fi9BJS2SOE7JYuBGcb8l2fWTEhPULSd7IS9LvE
         8SACR5gkousgyWcCk/TS3H4xYRVk3eUoa5CWkUxbtgdFi41tR8XvEL+stOiBSJwqi2nB
         rp3s6q6zToR3AhVUhHo7RwVbYO44e6DF5WXbWmeDz72x1ijkxGTBGYYUyJzhfozOgctM
         PudR1QMmG7rtTQEsvPuNTMFll7WYZPWmP8+N78KHnlxRE9ruXC0zRXKNbrGR0a2+LljP
         1R5w==
X-Forwarded-Encrypted: i=1; AKwUvBwLgZ9mPPE0AkfY2ov6BywrqyfAtaEVB2pS+weSD7eVILT0ylshZkI7rNA112y4/Ztx/qXJjAU=@vger.kernel.org
X-Gm-Message-State: AFuF++lFcm+nhZKuMOYuxoaViQ04jFwhMySv51zMteiQW38oZ0jwD2pu
	20o1bmLDHnuV0oxzw0HEgpi46WQ7djr8vif2PYoyMsYxiLo7Axcu84qtO/xGDTTfyliP/WZLsPF
	Ti9rxUktCp3giYinG1gz7bAQifwvC110=
X-Gm-Gg: AYBFou2Zrrb7SRqR2hfQ8tLQfAM1LMJWVeNKQeAmPtrQcRi+tNQh12TbRg9dkES49PT
	lcEfZZ/n2+EWX9ikvP4EIlkZZbHjxsoy/17NdJ4g0TJQaGAIeY1D1OK6WvbNvAAl5GY77FxH5Ja
	pvNLpI+cBTvOx4HgETW42mq+ge7CKfgabevewJwi5uyJkC/kPF/VMnRDwwe2/PPAhbQWLA6IB5y
	o5GhqXdDZoOR9LWeGWc/6bzPJ7bvm+ILNQQk0/SNQsl3CKe7nfjEseMTCONFba4TIvmJebLyN+t
	MiQhvNWiS9g0+FsGYfSPfUbnv8FNeHzYbnTbjbjD5p4Cb2TIzvVcnogpLqLirUvt0spoH4uIqQT
	tXNRpiS3d3OrvGXjHzyIiGjsCQBhap731
X-Received: by 2002:a05:6000:704:b0:485:8c16:5eea with SMTP id
 ffacd0b85a97d-4858c166202mr24838505f8f.36.1788809205349; Mon, 07 Sep 2026
 12:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-rzn1-miic-fix-array-v3-0-3f7dccffaf5a@reliablecontrols.com>
 <20260902-rzn1-miic-fix-array-v3-1-3f7dccffaf5a@reliablecontrols.com>
In-Reply-To: <20260902-rzn1-miic-fix-array-v3-1-3f7dccffaf5a@reliablecontrols.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 7 Sep 2026 20:26:19 +0100
X-Gm-Features: AcwNN1VUA3S6ZAAGYKSTEqV8ikrWj4M6EW9VSx8IWuQuy8lbnm_o-FkNlvIGfjI
Message-ID: <CA+V-a8tqFCB=c0_74=pdOT1ujz6w+SUVLmNVy98qyzd5FrusiA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] net: pcs: rzn1-miic: Fix config array initialization
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

On Wed, Sep 2, 2026 at 7:55=E2=80=AFPM Kyle Hendry via B4 Relay
<devnull+khendry.reliablecontrols.com@kernel.org> wrote:
>
> From: Kyle Hendry <khendry@reliablecontrols.com>
>
> Fix memset parameters to initialize the entire DT value array
>
> Fixes: f39e968dc168a7bd ("net: pcs: rzn1-miic: Move configuration data to=
 SoC-specific struct")
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
> ---
>  drivers/net/pcs/pcs-rzn1-miic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-m=
iic.c
> index 2b72fa98ddf1..c50b65d064fa 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -683,7 +683,7 @@ static int miic_parse_dt(struct miic *miic, u32 *mode=
_cfg)
>         if (!dt_val)
>                 return -ENOMEM;
>
> -       memset(dt_val, MIIC_MODCTRL_CONF_NONE, sizeof(*dt_val));
> +       memset(dt_val, MIIC_MODCTRL_CONF_NONE, sizeof(*dt_val) * miic->of=
_data->conf_conv_count);
>
>         if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf)=
 =3D=3D 0)
>                 dt_val[0] =3D conf;
>
> --
> 2.43.0
>
>
>
