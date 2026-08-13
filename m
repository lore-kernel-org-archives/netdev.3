Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2FE38B7C3
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 05:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786598003; cv=pass; b=iyM9yS2nlNcEVGV2E6b8KLNB9LiNXfmKiEt25K9ql19OyzD6s+7lZtF/2MWK64llU+Z0DWBDTJ4RGnjSglML4dUYztMSFvkAYlXNiSAqZ+5MBNK7jkR2jsW2izdi4gvcmkGQtdHVpkdVvXiKoVBxC8Z2dQAdK0zmRHFHYX1Pmvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786598003; c=relaxed/simple;
	bh=jH269NUkneYji055jp93VCBiUHSr7s+k4kmOaLhCHds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyPaZ5/9myKgdi7x7IU/3Y3s/V7BNo1P9ZxzHmj6+mF1hKqETACPT1xzvR5TCCGwsCoPVTFbyiZoRU1P+D1oSaqrDYHVf0bJ9I6nSOE4zpfanJgt4Sn+UKuyhEgqzOAc4JPQL1ulKr7JGimHBK+PMDIXc2JMb7rAv4FoTcMrG0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQKPAb+G; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQKPAb+G"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e5c9211d2so23794085a.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 22:13:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786597986; cv=none;
        d=google.com; s=arc-20260327;
        b=Lj0pojRsspow7cjyg3giN25/xOcwr+40lwm574rOjnGZF/uiqADF1D86pX6dax4IQ8
         AVrKpW9OmiQZwQC9Ne1ZZAuZylHenXI3tgr+eQd1hd2/8wea2dXqx0QtYXaO+Acg64Xa
         fupGEpF2yxmRgiQmKJAAx0q8ZopaIIjuIb4Ln1Tq94lmL6ydgJlC1RLpWXDlasp0Ybac
         ykuWX+N4jytszCcqtXDgEEBFG9EKd1aUVewCnOOobqOjnPGxaWn+rWgANBGZiSmJnyDG
         wbH7XOiMfcegoCZaZbU3MR3PtywWrB813liAn8vKzRE/enWuVRsco8r5pgS0KTNjoZLh
         eLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uEtieVc9WSJ5PDHBcvuJibcDLApd92WXRwOLQpfbWq4=;
        fh=zw2Tf0vMtu3hAEFoJbDfCjU/V/Fceeopbv+cwPpkdHc=;
        b=kv5X3Zp8z07USQH+K+kjf+VPfD8a18eE2WRtp1tv/Q/i3lebHS5IPGPZcCRRbF/tfl
         7LWmP88ZhxwQNCaoTxDGS1rk/X42MnyCT0b0PQ/XiBTUTHoKtoLttB637cRQOqhWHNce
         gf5YPRzJVm5xQfviwep8uYnqLsLdCjFrl6c2mObJDlUQ0Tvx35ZDSGtQCPoBd2f8KCCR
         oAJBcNyKJVtA+OfxFeII6ZLLJsR2slqBfFLApnNmDX09Me/19q25gOQVkticVC92GrLx
         uN1dsyLayttlJ813zHOhczT7MgjD2zsIZ83aV5nTH+3irD/H8wNbZuvd0oIxOWnz+Fax
         OO3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786597986; x=1787202786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uEtieVc9WSJ5PDHBcvuJibcDLApd92WXRwOLQpfbWq4=;
        b=eQKPAb+GVppOHChuW44mb7eGSzBl88RR4yOq6j3EbmiuUbu1PDF6YuIBEYfKcetBC2
         lTSqkGCsyw+cdiWg006WsKvwQ0FZSBgMnLeNXsgcwUJyfA3TEXFOR5XFK+v/9lt7PgN4
         zld4ukdhz5/KTRNzQHO0K07do4fa6ePZ4GQWoDQkPSWPat/gi6LdgnHcvpGr4lnSex8P
         EzDWssQ2YxZS/GhRLSLPsyr3k2byP0ZxkZ5hY2ll7GfzJo5yqloB4T6Q4GVMp4xUip3Z
         HHU6I0yc7AwgnnXk/cTBW9y7uN1OC1PBdY8/Dk3CkLyf7WvxqwBTEDb7ut3N19yfGA2H
         YKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786597986; x=1787202786;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uEtieVc9WSJ5PDHBcvuJibcDLApd92WXRwOLQpfbWq4=;
        b=H9ea9+kpxjdwSVbXJhVfz+44kiEJg9eOySGO8PR4DrOAsq7KQ+ADQLG+0C2aquS6CY
         DEkxDiFBhersOT9xCM5dOmgqLnXoZsk1adX7x1zQmC5St8PFH5oSyOD3xCkha7Qsn81y
         X4JUqH6no8vWkOvMsuMFpnD2uW/u9L/MCV7VTjkcKkNbpgshuDCU8lfjHenVMqRR7o+d
         M4q+9bidOXt4+MKFFdl3ur0obgD1/eLgDHZxSGRVLsKd+J9vHhDkvdtXkcZpV3YIP8Al
         Tx7PAEaBIhkheQdjh7KxofHwajfv+KfNQGKNDCDuzoB3PLYPN/4VAldi5VlqRWRITNRg
         GxIw==
X-Gm-Message-State: AOJu0YxsXNLJW6Ue+VFx6LaF7DEDCMQMtJSV/Naj/p4w0nHw519nysBd
	q7NkHktcmhp2lr4bRXLIDFGYcIiSI7jisBJvj/IthqT4rfyvd5o2RNHPuxJWQ5LY7fXx9UV9i+Y
	lXNAmIgfvEcAlgFT8eML0itKnX8hcJOt+2vzjEi5athIT0ktu4eqX21S33CQ=
X-Gm-Gg: AR+sD102Y8T1Qzd9r0x1gtdaWOSMEGUzMTy6lTjM7x1Do3OBCLXwB83kmiDFYdlOAUP
	WQx9HXFqOcgj1nSPkqeOOSqCnSsLzRqkfuAsxewBsmhYOTq0/thDZNemf66WiX2TKtjrsyisZYk
	9zX/4ffs6tdwANWO+eof2ahfqLKO60+0kejAyV9I4WM9/UvCZeoMMKzuEVpmjJJ2G9dZXNnUKSM
	xvqRjtTgPDasY38b++y579i5Y266j8hozBW+OP9A7mMY9Xk8C7glVbRWXngvRcyI1s2GaYVcCzT
	VVIXX8DlzmOTKEh7HS7xcpvt7y2jEpfF9mzUYbNdEiJhXjWeB5eu9Yi+w+orDCw0Cvhf4U62j5Z
	Q8/APdD+mpH/UXUzWc+Z0tpwq56orQJMLbYHk5d3nf/H5Wa9FF/PCm6cnfhzPov+iyI7/i9AnAv
	ezAOQi5imTwJCRmyI=
X-Received: by 2002:a05:620a:19a1:b0:930:a718:bafb with SMTP id
 af79cd13be357-936bf8e9556mr236573185a.10.1786597985288; Wed, 12 Aug 2026
 22:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813020529.3506539-1-willemdebruijn.kernel@gmail.com> <20260813020529.3506539-3-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260813020529.3506539-3-willemdebruijn.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Aug 2026 07:12:53 +0200
X-Gm-Features: AUfX_my654oSCj8Jvfk9t6nV5AAv0jJoyfpxZTmlGpim3EaNPCSGd_HPp2788oY
Message-ID: <CANn89iK6O7ujR9zCJzd04MNLQoDi3mA+HWsR-hgQWYzLS3gZfw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/6] net_sched: sch_fq: clear past skb->tstamp
 if offloading pacing
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 4:05=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> When hardware offload is enabled, FQ will forward packets to the
> netdevice for pacing. The device has to test that skb->tstamp is
> in the future.
>
> Avoid this cost for packets whose txtime has already passed, by
> clearing skb->tstamp.
>
> Also clear slightly into the future, for EDT timestamps that are
> so close to now that they fall within a reasonable normal Tx
> latency. This slack is set to 400 nsec.
>
> Also disable timer drift logic when offload is enabled, because
> time_next_packet can exceed now causing a negative value.
>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
>
> ---

> @@ -828,11 +837,16 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch=
)
>                  * f->time_next_packet was set when prior packet was sent=
,
>                  * and current time (@now) can be too late by tens of us.
>                  */
> -               if (f->time_next_packet)
> +               if (f->time_next_packet && f->time_next_packet < now)
>                         len -=3D min(len/2, now - f->time_next_packet);

IMO this part deserves a patch on its own.

Using a variable adds no cost (compiler will generate the same code),
but helps to understand what is going on?

commit e51f3936aba0e5887cf5884b18ffa769dcb38523
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Jul 1 08:33:38 2026 +0000

    net_sched: sch_fq: fix pacing delay underflow with pacing offload

    When pacing offload is enabled (q->offload_horizon > 0),
    FQ can dequeue packets early (now < f->time_next_packet).

    In this case, the drift calculation (now - f->time_next_packet)
    underflows to a large unsigned value.

    min(len/2, now - f->time_next_packet) then evaluates to len/2,
    incorrectly halving the pacing delay for the next packet.

    Fix this by only applying drift compensation when now > f->time_next_pa=
cket.

    This bug was triggered when flow_max_rate was set on the qdisc
    or for non EDT packets (packets with a zero skb->tstamp).

    Fixes: f26080d47007 ("net_sched: sch_fq: add the ability to offload pac=
ing")
    Reported-by: Willem de Bruijn <willemb@google.com>
    Signed-off-by: Eric Dumazet <edumazet@google.com>

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 7cae082a984721215b17fea2d094095155580dcb..f2a65a7a928d5838547285921ce=
0b42c99a96ef4
100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -828,8 +828,12 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
                 * f->time_next_packet was set when prior packet was sent,
                 * and current time (@now) can be too late by tens of us.
                 */
-               if (f->time_next_packet)
-                       len -=3D min(len/2, now - f->time_next_packet);
+               if (f->time_next_packet) {
+                       s64 drift =3D now - f->time_next_packet;
+
+                       if (drift > 0)
+                               len -=3D min_t(u64, len/2, drift);
+               }
                f->time_next_packet =3D now + len;
        }
 out:
