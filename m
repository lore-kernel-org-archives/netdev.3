Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54761390223
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510698; cv=pass; b=rbfrzy0r0cXDKNybVwAJ7q09D9oBzeLhQrv0CT6DF82BAFJIt3ftC7wc56fGB+JeLYRzVIHUZqqktK5iifVhMkDFk2edR+leKskD50G9nXSP4DnuS6PGQ2E4OnnPSTAhAUIrGB3zt76mlSXbiEWQ0M5FRwyKRKoD4BDCy1t60bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510698; c=relaxed/simple;
	bh=Zct3tA1vd0s2hqzChN6hFnwvudPWbiHeihh3PxhVjYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2fbVJhKlgWRMOxHyYYyd6Q3PTA/34iz5lIGUZVnBQxYg7wsftX6knEFa8OUYEjma0D/sOtUefnX2wr0wIyDQ3ZCMaWtwljdjkXedXKJDt5W23MivuwQiHWG01QI5AK/vj4jLEBaSRSOgq76RvSsM9RywYO4fslWop0pUM1D5hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=G/mQasY0; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="G/mQasY0"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-853f8c34ba4so1028810b3a.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 01:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788510697; cv=none;
        d=google.com; s=arc-20260327;
        b=d4CzOsekdUXui5Tf2vzoAgQpBOkiLpFIVXtHMMzGTGIjV1zGAfMx75KmSJCORoqHmf
         ZBGY5GHgAHJewFpo3suTiXdRUOGZ/r62zMjZJyCtvSFaUZTXYrnPaxSbps6GIw5ffb6z
         bpD0LNYN+C/dnclva3OxkkbUq0Uo6V6WGESexLzaDfLICN8sxV0VJvz6YFBzBowdf8Mv
         FTqMUF9QpodXzfWOqER9BCSyYs63kdaZUUJWSh4jT4RB49maXQ8Ae37iAFC1wx/PbhiF
         shraJxLfJwRl0gVxmspo9w6rXx1qRg91LMB4fBvTNIA6ohyYYzLbH8tCvOO90kTRnZBF
         n/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=707kDHdR/FNIPTJBC69xcl2naZm5MV0ZXXSBtfd5zfg=;
        fh=/qS7pDVx1PdVvAFUzdBqbRDUaeOTJaWGdiQkx73LwTg=;
        b=dydDskNBTgXmcITKEQejnwmmOG1yH7a3mPzfPgxwml0pQf+c6IEpeLqiECOaT6uMB/
         cnxAVpT/Lgf2hYKK0JYzJq4GMvoKmRb9qpbYcbSdK2G3URJXfKjgbhiZf8Mk8pTj/nIr
         U0eaD/LQNK84RDL3UmA/k3R8krfG6t6VQOJ7YK8xYtHpFX7sX/PFOVSKqo8Ls6j1qi+9
         hkfzMrHy7HERyMn8sFyGjstnB54hhHbwnvKXPZKmiuvATzTCRlTwVNK6fif9DwV1Hk83
         BPtnA3PRf8mzYQkv96uiLp6eaWUjIJNw+4Ncz2LGL+7HwAtVxVU3078AuuhEkqf+Fua9
         QhBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788510697; x=1789115497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=707kDHdR/FNIPTJBC69xcl2naZm5MV0ZXXSBtfd5zfg=;
        b=G/mQasY0lkxTaqkd/jFbKxrubAv1G0XGsGNvlMCmBi+0qacc/qrMIsQ6VEi7jZuh1w
         4kWfb1df+/30bthZDhJ2o1ADVPTXE0Le/enfrV24hlCXRqI7rsGLJKGEPMdnDuSffuz7
         qZ9O/Hc/9HvRACOoCOgLAZaAZo+tLxwbJaBpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788510697; x=1789115497;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=707kDHdR/FNIPTJBC69xcl2naZm5MV0ZXXSBtfd5zfg=;
        b=li2DV68pNlFJKcb8rr/8lXFLho/rPUr5mFAXLfmmyqP4WHX3ru3gxD/H6ykM4kq/gY
         tEc16Hz55YFjed4J1E8Jm4X9L8c2mA/FCxFdEpLtySOKAhcmRfz4ZWfXeIUNru9thc3d
         e3ZPju8ncmPKHSjoZrp6xzuZOxnnXtLJOUxCAJ5w7cHIaBq2nRCK2GT9cvRrb3tC2Dua
         RBfEOX2CZn0bYAXNg4BDHqaGTsZQmp1WlW7rNA1mEGDFfVxRVaUm+P6/WPEtEOWxHPq5
         iDBklcx5HxWo+hTjR/tKMSsFOFvOzBepmXX6X+awT2HWXg14dG1x3XrDvao/BFeuUAs+
         r5sQ==
X-Gm-Message-State: AFuF++kmA/0TrH63DopHj9QZDqt54Fiohud14vwPtPCywslRHCIBi95d
	EbQedRMYxMHp6Ep9484wnI7CsmUUElMvs826IdvjZdL+/tAYEmt1u2pc/VJUTQ3q2mzyvgx0IFe
	oGE5Ki1CGrJbWycExnO0hUryFBBMoTZQTwt15GQcJ
X-Gm-Gg: AYBFou3Wa7l9CiT+JxZoym8HIpYMnp2DwZk9KEsE/ItXeRb6GNCEqf+9ue47SkdWk6f
	Cr1epOxUCiotiIyGz9ELmr/BhdaFcrVGwsjqqrEoI/M/gQZb+5NB4jLXacN5MsIZdLGO45Ycy/b
	OUt8s3GoDqJ94wYOwifYzlEEN/HUs1Sjf6/ni9WCpxYyirjEm0dM/GhU2d7IRO3M5vwuemiCxtW
	qO7lBNVupARKdQZAWWzYLGFhB/NS26WWqqgc4oTY52kw3FBgpXvSvaz6OZNn7hTHU6UWIhI/nwJ
	ayiI+eJBrtvtsTLWUlkJPlVdHJLckCr/NEyyDFU7lF/22HLoBu2fce6a7Ah0TG//7laphSv5NmN
	A+NC/GoMaSix7ggBdxiM/3ssnB3InLpAZbA==
X-Received: by 2002:a05:6a00:178f:b0:847:8b11:5966 with SMTP id
 d2e1a72fcca58-8616967ccfdmr5757402b3a.1.1788510696674; Fri, 04 Sep 2026
 01:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-1L5H.v1.20260903184552@mojatatu.com> <CANn89iKFVvFaNcZyGOxmyPbpc6ax49ZqwMWDeBAsH5dav-y-SA@mail.gmail.com>
In-Reply-To: <CANn89iKFVvFaNcZyGOxmyPbpc6ax49ZqwMWDeBAsH5dav-y-SA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 4 Sep 2026 04:31:24 -0400
X-Gm-Features: AcwNN1UO-DsxSwJBEw1u402haO7sGBSEBLy3v4Unf6zC228XqPGtU0z0wn8jRpg
Message-ID: <CAM0EoMn5M__WHkniZLw8GNtHpTresTC2dQuL6brmAzUXH1YUKw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: codel: bound the dropping loop per
 dequeue call
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 8:35=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Sep 3, 2026 at 10:56=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > The CoDel control law schedules the next drop one interval/sqrt(count)
> > after the previous drop, using the configured interval
> > (codel_params.interval). For very small intervals the scheduled step
> > rounds down to zero, so the dropping loop in codel_dequeue() never
> > advances and drains the entire backlog under the qdisc lock in one
> > call - an unprivileged user can trigger a soft lockup this way.
> >
>
> ...
>
> >  static bool codel_should_drop(const struct sk_buff *skb,
> > @@ -156,6 +161,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
> >         struct sk_buff *skb =3D dequeue_func(vars, ctx);
> >         codel_time_t now;
> >         bool drop;
> > +       unsigned int drops =3D 0;
>
> SGTM, note that this line breaks RCT.
>

Grrr.. it was in my brain to fix it, but my fingers didnt get the command ;=
->
If needed, I will send a v2.

> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks for the review - struggled a bit with this one and wasnt 100%
sure it was the right approach.

cheers,
jamal
