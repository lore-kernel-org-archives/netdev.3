Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156434CFCF
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660537; cv=pass; b=c0Buzz0UwQFa1JJrA4DkAhpayl0eX9b+ukL8WwrgWICyUjuUo26i2z5LvCw0CdFROTU22gEhndGcxR3OaUefCJS0f2iXe/vuA80Rr+stcSzeAvublxlAl51OiDTi0hURgSi1TlIrHrRyEYUiq3n8WZsJoBWA3nSRX3MAjVfpAXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660537; c=relaxed/simple;
	bh=CZu//w8nfUqxfRbIfFweHrXIoGfZbN61WXULKZ59AeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBTLo14oToXz/doF4EzZFLz11h9+9NDpxOt0A/Re2Lx15VxBt4SFtJkdZysOYvbLBvy1Bu0oiBUDNhz5/+3nBuD87AXNfcQ0hx5LWNKgk8RJ2PaVjxfAd9kfzx8dyFBtAvBU5ww545M7FMMQR3lH2SIGsHrmzet9BW7bjXOPHkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqWkmY/S; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqWkmY/S"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5ffb61b0babso581109137.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 13:42:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772660532; cv=none;
        d=google.com; s=arc-20240605;
        b=LqiLp0gHoRgMbfi+AQmx5Fbe5vGT6lDpbrIWeG/czKenRgnngupuFVsk419GEoNWCv
         Cy/kbpPhKw++QhmLfzmBjlH/lU6Qi8qgU8FjFnL0r7SqToqafnqUjRAA+risrQv6iWMO
         litBolgJa8cIw5IZQWabmudggahNeNHGo0ue+5GMDMH1fBe1F2TSZDz+N5cODCZx1Wzh
         RqWgJ3XsRRJPr0NW+WReb5aeKcifkG/Cu8MpNRv6puuC54BzwXqWw/S4iWGg4b8DIqeA
         IcZ8Hbmu24ftnuNh32qjv5hMSAmIRQYnVuipXujLPwpw/FIrSOWU1MQd2WKnkpXy5g6/
         OpOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k3W5ct/v2iGUTvV1EtPmndYMgCvTbcZYMCleQX41UhM=;
        fh=yomuuMuLrQgY45l3I1cLbzK7Xia0yxOacepcynhAGTA=;
        b=O7oywlO4i/+H40up/u8dcRjuidwIUGm24VP5IJgh7Cu4uOXCWsQpi37Y54W4GsglSs
         H6y4tRh7UX9CuucmNnfBkyGFR1RCAClZmcj344K7Xn3ESTR2dz8FbMEwCXII2NmSPadR
         4q6wJiajiR/sD0mQF/rkPsdUdTAsxXdM/rnCctnEgt0ZWLxGjKyyLKfDUhkzOLdLs3oF
         OMh1sqIGgZJAmXUA2D7fxo3JBfzYqwuR0862eIFkUUNUwAH+1SlyaaqWwPKfeZgiGgCd
         6i2clPuk0SYsJ6U7pvl28eTAW23TClgqZ18KAeUdUMxbSwV6yPTf+iRBPM4quLdfBZ5Y
         a+BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772660532; x=1773265332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3W5ct/v2iGUTvV1EtPmndYMgCvTbcZYMCleQX41UhM=;
        b=MqWkmY/SugAIMEd+xk1nZLZiRvoT7MLDbquUJ9VQhiZL/rAekO1jHavuClYe3MmjZv
         niRxcLSwDgQRMhFDb6Y3i+IYjOcorWn5zeLLxGjv8JHAkUMy4xYEhDD+wh3/Lb+REhhS
         OxgsRINJ7F800EeHGP3HKAO4aDEnbCubexJVGlHRTUUNAk+9WgpywZPL7VpruPgTe85M
         /DA+95SlhdAaf0xu+E0SI8VQrm3KG47FC+TXe3vnnSZz0EhBrAWoB822z/sA9Uq160z4
         1wE31VOlS6zUGRqYlXWEIR9IATfJEME39a/OMiVBTQLLYnSBK3kipxGXlkZBytPfhgko
         lYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772660532; x=1773265332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k3W5ct/v2iGUTvV1EtPmndYMgCvTbcZYMCleQX41UhM=;
        b=X5Ti5W5WexIDaoDf9DKWf6OgaPHD81jYUZ07ZAjEyclMKUFX+OPo6MeOxFrP7MOk/M
         CGCS1W5B2OnlCUMcHAjnsjQMf/GjAr7Qj9U0X+OsADZTVV7yx/apMNhG/o4lFs8OwF/O
         HrzPptGayYJo/1UQmBa7nCqCkJiH4/di5FQwaj8J2n8KXjUj1SGyFQ5FGlFNkwAHcG/r
         I15ZCTMvsDeVFdwA199y8dLkIR32i+poHtSQ1ebjY+OrNEISTXcudNSUVZ6xp5r/nNRT
         +PXgqFwEH7Uwt7Jr6nv8HKwzET7q+Nsyzv9HEDpUSqO6h0idyu09xDGjudaNlFV+JUkH
         bAtA==
X-Forwarded-Encrypted: i=1; AJvYcCWHORb0xt8I6/x35XuuOLzODjiS5nA68TdFPUjQAAmmlDuVANK0gerQUmkIGkBw/GSDOQ44wlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypoaJ1vEQtxi8ciK8yUSt+FoHXJJBa1AUlrT4UG+NNapAXDDBY
	ItxvI0P4w/XkYeIddWpKicylsU/fmLQgRhiDWMDctM0/pWeOrbizEh05lHgXmaHbKrp+r7H/pc0
	heBXcBHM6LGWeuktLJvSM67yAJHMGeBA=
X-Gm-Gg: ATEYQzw0O7N73THl3zGQSMF2LRRel2XUR4k5B1Dx/e1o7h8eqgF7Qsj4x02sSiO2apb
	8dPC6LmwHCEE9kK/S++WZLQ/tuaL4WbX0+LGkx+28a2rTAix8sQ6TrfM1SDdRBLlmWRyU5PIlJd
	56901tXt4/IlIR/n/JhX/kFN4v6H9OBW7YEudv1TjPhLfTJTgifchUMULnWSunOgv1GNurMR+Ba
	Ex/MDMmn9thLMyPM7Lf+U6SjFfZ6rDAfj7+T15ftI7O8ZN3Z5U3dRBJdOXsYEsMXuYGdtWk8jkn
	aL4GZxZIbRp7TNvLECHZb2OUVUgECA9eOHVJ+noWktKdbaZwQ/R6vml2c3aYUWJU002enmYsW51
	VQ1eMeJiwCRG9urhz2vF9RzVBsWJtJFW9DBa/0eY6gYNkloxQoP0=
X-Received: by 2002:a05:6102:26c6:b0:5ef:b0d3:295f with SMTP id
 ada2fe7eead31-5ffaac4951bmr1696488137.8.1772660532453; Wed, 04 Mar 2026
 13:42:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <91c5313a4c6675fc9f98efbafc92ca162a6e7d66.1771986861.git.lucien.xin@gmail.com>
 <20260303083207.34631-1-pabeni@redhat.com>
In-Reply-To: <20260303083207.34631-1-pabeni@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 4 Mar 2026 16:41:59 -0500
X-Gm-Features: AaiRm50iQw95v8k3Y7-EQTJAv0UA-MtI9QwoadQFdZTYPxQjeDw-BRrDhXRxJ78
Message-ID: <CADvbK_cKefZpb=yCi_yxVWX4ear96LpCb+9W7pXs_thRWCWB2g@mail.gmail.com>
Subject: Re: [net-next,v10,09/15] quic: add congestion control
To: Paolo Abeni <pabeni@redhat.com>
Cc: hepengtao@xiaomi.com, kuba@kernel.org, jlayton@kernel.org, metze@samba.org, 
	davem@davemloft.net, kernel-tls-handshake@lists.linux.dev, horms@kernel.org, 
	hare@suse.de, aahringo@redhat.com, tfanelli@redhat.com, mail@johnericson.me, 
	andrew.gospodarek@broadcom.com, linkinjeon@kernel.org, dhowells@redhat.com, 
	matttbe@kernel.org, xiyou.wangcong@gmail.com, dreibh@simula.no, 
	jbaron@akamai.com, quic@lists.linux.dev, pc@manguebit.com, 
	marc@fiuczynski.com, edumazet@google.com, alibuda@linux.alibaba.com, 
	steved@redhat.com, illiliti@protonmail.com, tom@talpey.com, 
	marcelo.leitner@gmail.com, sd@queasysnail.net, linux-cifs@vger.kernel.org, 
	netdev@vger.kernel.org, mbuhl@openbsd.org, smfrench@gmail.com, 
	chuck.lever@oracle.com, daniel@haxx.se
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 3:32=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> quic: add congestion control
>
> This patch introduces quic_cong for RTT measurement and congestion
> control, implementing a state machine with slow start, congestion
> avoidance, and recovery phases using the New Reno algorithm.
>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
>
> > diff --git a/net/quic/Makefile b/net/quic/Makefile
> > index 1565fb5cef9d..4d4a42c6d565 100644
> > --- a/net/quic/Makefile
> > +++ b/net/quic/Makefile
> > @@ -5,4 +5,5 @@
> >
> >  obj-$(CONFIG_IP_QUIC) +=3D quic.o
> >
> > -quic-y :=3D common.o family.o protocol.o socket.o stream.o connid.o pa=
th.o
> > +quic-y :=3D common.o family.o protocol.o socket.o stream.o connid.o pa=
th.o \
> > +       cong.o
> > diff --git a/net/quic/cong.c b/net/quic/cong.c
> > new file mode 100644
> > index 000000000000..e0f78ecb00e4
> > --- /dev/null
> > +++ b/net/quic/cong.c
>
> [ ... ]
>
> > +static void quic_reno_on_packet_lost(struct quic_cong *cong, u64 time,=
 u32 bytes, s64 number)
> > +{
> > +     if (quic_cong_check_persistent_congestion(cong, time))
> > +             return;
> > +
> > +     switch (cong->state) {
> > +     case QUIC_CONG_SLOW_START:
> > +             pr_debug("%s: slow_start -> recovery, cwnd: %u, ssthresh:=
 %u\n",
> > +                      __func__, cong->window, cong->ssthresh);
> > +             break;
> > +     case QUIC_CONG_RECOVERY_PERIOD:
> > +             return;
> > +     case QUIC_CONG_CONGESTION_AVOIDANCE:
> > +             pr_debug("%s: cong_avoid -> recovery, cwnd: %u, ssthresh:=
 %u\n",
> > +                      __func__, cong->window, cong->ssthresh);
> > +             break;
> > +     default:
> > +             pr_debug("%s: wrong congestion state: %d\n", __func__, co=
ng->state);
> > +             return;
> > +     }
> > +
> > +     cong->recovery_time =3D cong->time;
> > +     cong->state =3D QUIC_CONG_RECOVERY_PERIOD;
> > +     cong->ssthresh =3D max(cong->window >> 1U, cong->min_window);
> > +     cong->window =3D cong->ssthresh;
> > +}
>
> [ ... ]
>
> > +static void quic_reno_on_process_ecn(struct quic_cong *cong)
> > +{
> > +     switch (cong->state) {
> > +     case QUIC_CONG_SLOW_START:
> > +             pr_debug("%s: slow_start -> recovery, cwnd: %u, ssthresh:=
 %u\n",
> > +                      __func__, cong->window, cong->ssthresh);
> > +             break;
> > +     case QUIC_CONG_RECOVERY_PERIOD:
> > +             return;
> > +     case QUIC_CONG_CONGESTION_AVOIDANCE:
> > +             pr_debug("%s: cong_avoid -> recovery, cwnd: %u, ssthresh:=
 %u\n",
> > +                      __func__, cong->window, cong->ssthresh);
> > +             break;
> > +     default:
> > +             pr_debug("%s: wrong congestion state: %d\n", __func__, co=
ng->state);
> > +             return;
> > +     }
> > +
> > +     cong->recovery_time =3D cong->time;
> > +     cong->state =3D QUIC_CONG_RECOVERY_PERIOD;
> > +     cong->ssthresh =3D max(cong->window >> 1U, cong->min_window);
> > +     cong->window =3D cong->ssthresh;
> > +}
>
> This isn't a bug, but these two functions share almost identical logic
> for entering the recovery state. The switch statement has the same three
> cases with identical handling in both functions, and the four-line
> recovery-entry block at the end is exactly the same:
>
>     cong->recovery_time =3D cong->time;
>     cong->state =3D QUIC_CONG_RECOVERY_PERIOD;
>     cong->ssthresh =3D max(cong->window >> 1U, cong->min_window);
>     cong->window =3D cong->ssthresh;
>
> The only difference is quic_reno_on_packet_lost() checks for persistent
> congestion first. Would factoring this shared logic into a helper
> function make future maintenance easier and ensure the recovery path
> stays consistent across both ECN and loss events?
>
I will add a helper quic_reno_handle_packet_lost() for this.

> [ ... ]
>
> > +void quic_cong_set_algo(struct quic_cong *cong, u8 algo)
> > +{
> > +     /* The caller must ensure algo < QUIC_CONG_ALG_MAX. */
> > +     cong->algo =3D algo;
> > +     cong->state =3D QUIC_CONG_SLOW_START;
> > +     cong->ssthresh =3D U32_MAX;
> > +     cong->ops =3D &quic_congs[algo];
> > +     cong->ops->on_init(cong);
> > +}
>
> Should this function validate the algo parameter? The comment says the
> caller must ensure algo is less than QUIC_CONG_ALG_MAX, but there's no
> runtime check. Since QUIC_CONG_ALG_MAX is defined in the UAPI and this
> function is exported in cong.h, could a future caller (for example, a
> setsockopt path accepting user-supplied algorithm choices) pass an
> out-of-range value and cause an out-of-bounds array access into
> quic_congs[]?
>
The callers will do the validation as the comment said, hopefully AI will n=
ot
flag this again.

Thanks.
