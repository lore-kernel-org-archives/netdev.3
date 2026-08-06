Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE2F47A89D
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028439; cv=pass; b=IRUY+UQGng04jlvDbVEQBmFy3EOSsKniGkAp+BLRnXRgbRKatCQh3WLa9/5PGy7FteZsHpKbZcEY1RPPTbtFs6LGx1G4Sn0NXSKz+urNsNB8Y6hq+NjXWujHDp3SHroYdJJC4ohS5Zn4aZEoSR+kGh7KPFaURXJuZ8eOUmJFHFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028439; c=relaxed/simple;
	bh=xHWfrtbUKzJn60DpMzTvrgdZeVM3KtRHSI8GmZl6zPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbTw9+pDTSRLfv/Ca/LGlk2fO4oNPlaHPQEkkDFFhig88u0pQcuOnXTA7X8vGgpfSPmr35NP6364PLjTNX3MN1afT8IKJGEEQwCQhitcLzgfIJRHBVn7RpAd3Uj7rDl7io2aPc+kHVsBSvKcl9jqFiQQ6jJTPUp9Fd7Q1mowB2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKSxu1Ra; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKSxu1Ra"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-496b7622a83so19746245e9.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 08:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786028433; cv=none;
        d=google.com; s=arc-20260327;
        b=Er0CqjzGX7Np4wf/Y95oVLSnCKMimVCxQYwYZ4CjJITtp97eQJadArIYxUhpBVdq0F
         F7mK0yLHwtKM7tqXxGYRDt4xjTxzB+ZkgVU+fcv17yaie4qQUepuxHZ3z85SmA9OJQ7e
         w6fKI2XeRpiV31J+mix22Gd9mwpk/HsmZups9pJsZbMjqyl1cWSbSV/iCDnVGj1hAoLt
         O7tsnblttN4QhT7wXv7lev9lUDZeToFQ0nF0OE6sTLR5GRjBEOfpAYjw2riiCUeQ/3vh
         V7p9XTrrT7y/zAcumNcJmJwkIS0d4q2QGE2PIdpwEr4zd1T08G92MMjZpbQ9J6Z1KLMu
         9nsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bLCroHoGf0o5ghe7Jl8U/e3ej3D31Q4DTDci56rDNSM=;
        fh=EOBKHH13a8zcDt+ABgL7pltt5pM4V37daowfZBBKRdc=;
        b=Qhow98z7iNh50t9HZWKwhNlN8EqZeDsCmHjPS57/Trbr9zDnLQR2qlEiKI4Kl8C+m4
         c9mAry8100vne037zPZ2I1nEbxndJzQh2FlyiuJoGOCJk4yS3wCXjxE8vKWnlxmZMKYy
         rCf3MXgdqAkG7U5w6gISX99eWVpTs7IIeeuhVBvFFrOOiDpEgpxh4SA91HfTsYMLuO2E
         IEeJGziY8Z8UGfOk3Iq6AQhbXIuLIbyS/r71HuqRD2LRJMIxk1oEhvu7FptEtYzwfYky
         4oBV7guKjZctEFmKkz/w7V10pySpHbhgexqhBxfP6BVA75WYtXk9vHt/GYt79w8d7tL5
         svCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786028433; x=1786633233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bLCroHoGf0o5ghe7Jl8U/e3ej3D31Q4DTDci56rDNSM=;
        b=BKSxu1Raq6JT3Ik0gqq5iBH5cROw+YPM2+EG5MwCXqCZ2JpqHTJyqFznlT9ikO6dZN
         +d6pDajoVcRTZ5sDWVeZxBRgNaIAieqhHV/yzu4lP+bidE+ORLMqgvrWHhxFcfRF94S9
         +EtudeYin7bNjC2etIxahk/Jx57p6j6g3Wl74oh87FioCifGvjLqxQj1BC3phTOCap1h
         BblC2Qq2UzLABLvhtIzrGkhrxiNdVns9ehxCmfWqiNROy4NS/e0rTfey0Cm2zNxUDlLv
         j2TFzagrmemJ71oo4NRoT/yUweoOCc1b/edb7NuFzXqBC07Ce3Je5RMl3/JLgWa5Gt6l
         krpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786028433; x=1786633233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bLCroHoGf0o5ghe7Jl8U/e3ej3D31Q4DTDci56rDNSM=;
        b=rp9YZpkrndl20pybK5HwhxRehzwTHvt9Pmhl+S76IPKBh0QwnLoH/KqJoQvv95GZj3
         Tg1bCAdQYoEUhc4E+Fa87+EqDsNpXqqLFGwuyecDt7eVWfAzquVaY3cVtF7obT5iBuHn
         H67XL2wIm0JZgFd/rWhp4BCt7ri5Qr6Lh0oUGOmDQq9hgn1Y7B383lxdzC8Fd6xoDCIr
         ZFdmNOGglXGoPMDchRjX38AtJ9eaQdl2sSznX9uCcFEwmpaBZ6ZZZoLgNfr+3Sg+Pe2b
         up07kTK8t0pgZECq21wd3I62O89dB5fGjbP3EdlSFIWf5H7gcu76FmlQzoE+XAwdYpd8
         MTfA==
X-Forwarded-Encrypted: i=1; AHgh+Rry7/p20JMkT8m4NXdpBAjX5VKFVaUchBjcqGSzQwr4U9RUp5HRzj1dbk/+TBlUVR7QsV7W/dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1o4ihuNR9BdTOthWcI7GVRP+8TLDHh7OXHfAyuByLsXOv70KN
	kDnptAeXBzTAvOOcpAQ+cFhuN8HT66kbIAX5gT6ZFPZo/q7udTx/m1v4Dfw8euToMJh3U8iZufY
	JELvFVwo2vRm26QFznlMsLrA0svIbD6Y=
X-Gm-Gg: AR+sD12FFbQdLz6kTaNJIl8HiQcV03acFpAb+C5nEPISgxotXm8Om7np/HwMY5u/Ptq
	++Rw8Yt0S+kLoL5JEApdB1xKYZPDpkF68ztnLDGS0ihEEACNcNvTMU3H64WwRRmUQLMNCoK9GBJ
	gfCJrdJQltqh6qp1nus00DaLTTIqeis1A7/MXSEoRtMdb+rA2UW+ry3jY/P+fMAUZHYCyZWJEm0
	n6ayr1FPnDCxU1R4MM4rlRChj+jmePWHO0ks8H0xSYYSJX8t9W/DXDwMQI7tO3rugVxIjYEz2eV
	18sR31oyPUiNJEHZTAIMt1iCO5+zQBzUHyzI5yH6LX0qJw==
X-Received: by 2002:adf:e005:0:10b0:47f:8b9e:f44e with SMTP id
 ffacd0b85a97d-47fec52828bmr21215134f8f.12.1786028432410; Thu, 06 Aug 2026
 08:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804213917.3413525-1-gyf161023@gmail.com> <905fe2d9-a8c9-4047-82af-6f530d024ba2@linux.ibm.com>
In-Reply-To: <905fe2d9-a8c9-4047-82af-6f530d024ba2@linux.ibm.com>
From: =?UTF-8?B?6auY6YC46aOe?= <gyf161023@gmail.com>
Date: Thu, 6 Aug 2026 11:00:17 -0400
X-Gm-Features: AUfX_myepY0Ow5BHeLBg3UOI6iMPPgT6p_3js1Gm3-IOdv6gZ05ymxdaZ7gYMsQ
Message-ID: <CAB665WCeZ2bTxCduGqKb_xeaoDb1Ty9wJ+vZ2be_jwj5osHYrQ@mail.gmail.com>
Subject: Re: [PATCH] net/smc: fix sock refcount leak in smc_switch_conns()
 error path
To: Hidayathulla Khan I <hidayath@linux.ibm.com>
Cc: "D . Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Karsten Graul <kgraul@linux.ibm.com>, 
	Ursula Braun <ubraun@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hidayath,

Thanks for the fix =E2=80=94 I see yours covers the same issue and was post=
ed
first. Please disregard my duplicate.


Hidayathulla Khan I <hidayath@linux.ibm.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=
=885=E6=97=A5=E5=91=A8=E4=B8=89 02:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Yifei,
>
> Thanks for looking into this.
>
> Yes I have submitted a patch for the same issue.
> https://lore.kernel.org/netdev/20260804082800.498672-1-hidayath@linux.ibm=
.com/
>
> Hidayath
>
> On 05/08/26 3:09 am, Yifei Gao wrote:
> > smc_switch_conns() takes a reference on the socket with sock_hold() bef=
ore
> > dropping conns_lock to prefetch a tx slot. On success the reference is
> > released by the sock_put() after smc_switch_cursor(). When
> > smc_cdc_get_free_slot() fails, however, the function jumps straight to
> > err_out without a sock_put(), leaking the reference and leaving the soc=
ket
> > unreclaimable. During SMC-R link failover with an exhausted backup link
> > this leaks one reference per failing connection switch.
> >
> > Release the reference before jumping to err_out. The err_out label is a=
lso
> > reached from the smc_switch_cursor() failure path, which has already do=
ne
> > its own sock_put(), so the put must stay at the get_free_slot failure s=
ite
> > rather than at the label.
> >
> > Fixes: c6f02ebeea3a ("net/smc: switch connections to alternate link")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Yifei Gao <gyf161023@gmail.com>
> > ---
> >   net/smc/smc_core.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> > index cf6b620fef05..04c6ce608ec7 100644
> > --- a/net/smc/smc_core.c
> > +++ b/net/smc/smc_core.c
> > @@ -1148,8 +1148,10 @@ struct smc_link *smc_switch_conns(struct smc_lin=
k_group *lgr,
> >               read_unlock_bh(&lgr->conns_lock);
> >               /* pre-fetch buffer outside of send_lock, might sleep */
> >               rc =3D smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL,=
 &pend);
> > -             if (rc)
> > +             if (rc) {
> > +                     sock_put(&smc->sk);
> >                       goto err_out;
> > +             }
> >               /* avoid race with smcr_tx_sndbuf_nonempty() */
> >               spin_lock_bh(&conn->send_lock);
> >               smc_switch_link_and_count(conn, to_lnk);
