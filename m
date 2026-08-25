Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A13D331E
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652235; cv=pass; b=VaWzQEnZfzWa6GjuY7/ZJ07TV8bA8hlCXNBaaaEViTzU+qkVO2lNqng34tWWCX+qL3our0kUfJQCeXHVQHIHR/ObOSqCAw/MQNr3Uack5OYrbRj96zFrA3fv8E8bZUYtb0PMR7xdqppfudV+JKU37myZc2rhbkinHUKahRF7wlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652235; c=relaxed/simple;
	bh=FWkt09UbBKIac6SE9n9RsiLu/VCJytuwrYsBhc0fhS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKkM+iD0qkTHBnB9Fb53Z2vRgfFD4sQ6ANosQ+A/aq2uguWEvMFoyP19arceMrSBKb0PI7AornzFUmFSvS5AHxqE5/2JaeX+JzlT8uY6Prc3oFoz215MaFRWKTw77HqAuCZ5glTGFa9xVO3vSneDwjznUSPJsqy4HDLwPl3V4u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OGHL+e/T; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGHL+e/T"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92ed3993c1eso229111985a.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 03:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787652233; cv=none;
        d=google.com; s=arc-20260327;
        b=e6So3k/LvXSBTmDlp1O3wjjID1BORV+deu6eFB7jnY/8LqMEXmWR2VZVX+8YnMBAj/
         U8OBrcSvkjejkzEvFB5+sJK47gKodElIbT1gTt68gSVrp9T+WZSn+S9xAm1sJCwbWxlc
         l+aup8R+bxvZGVBQyGKl2k3yUqYrG0qWJvAhI36L0nks8tZGPzb0QlOhoDQ1d4gLWyq7
         XVgfTtHx2PdeRQdLpXW/z3j5CkJ2zaeHZe7vHJiO0UH8sUuyJYLEqGWD1MhFG4ZXZKsM
         Ofoew+x94nPbe3lykNEKTVUSr6Mb+f+x1xvwwRGJbdwezKTeC4rL1jP5IhLOpVkhGIYb
         izcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FoItutinKhxa4OyXuJYgEukYYBMtDGgceiSaSZ7ODBY=;
        fh=X8BDq2/KK+aalG3nUimw3vzOLwCn/tnGxVtO1Bv9toQ=;
        b=NCBeJojL/G1wD+9fSv8u7hsQPlw4jtwDh4ASpLmI7VR7Xdey7xA9ly0kfGTKgghU0B
         3IpYF5BzgdcTJD3ZutPyj9n7LoX19aQlz1q5BbuJiwudDdlzh/HiNzK+DiNa4VfUtvqS
         xuN3UuS9UEQ7DmDQe/XD4xhktcUBKN9jmBq4Ari3LKQXfCv4Eb5PowRdyt6UE3UduMwW
         Jb8E68jp1mi6iMe+7SR6FQMi7d2zSRei5RDu0IdiWg24fKhDNmWVM15G2M+QPzwrFbWf
         0MSVy+DW0/SklvZLwm4vfkX0mXnXyR4hLMxLMAhLNSwnl4Hck1yRLCEjq854WeNPRz8i
         9Nsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787652233; x=1788257033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FoItutinKhxa4OyXuJYgEukYYBMtDGgceiSaSZ7ODBY=;
        b=OGHL+e/TXSmzNLPz7FPrE9CDshPw2cwQ2Knk461bM6R7zwMTqZhlQr3p/AVHwpPitw
         PAUWPTm/5WtX3lYxaN80vuZ9pnd1qpiHLL4K5pKa9K3bkblVAehnuARk/26NEiFfIx12
         ao1DlZZium/NepP3k2cFWNqjXQ88FI4ReCz06LI31ImA4HlfEFhDAfl5E0jBPX9oBpYm
         9xIN2jcN1OsJItvw2OU3yI3fBGw+OXH9Muct5EZM1A6q0jUeLaS+BDT3FCr7egEIPWg2
         RkSY9qbsDxm0o2KTyrh00QSbACjeiYuRDUI5Az6/IBMYL/qkoSiH6tOoyGcObsiSF426
         M7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787652233; x=1788257033;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FoItutinKhxa4OyXuJYgEukYYBMtDGgceiSaSZ7ODBY=;
        b=Rr0mquWCr3TMNCe0qRIbC+fgByMpBPeAl+wISc1uTZKC+AKgTyp1TEM8jzMQyC837N
         UtjALYbbBeKkh/N8gdPSakh8Zn+yF9Xd5ogKZdfurSrUKXVAxYjAreVTxh1oR33Y9RPP
         BMwgWIdbtRC67TJFqx1Voe63VuAaPpikmwuEOA5wVjKWwDNbXoPzf/AHbhv9hrKNubxz
         n6ZmDatRkIdOTSaeqWvnGX5s2T+k/HH/HXVo63i+UKynltTP0l02+Rf7AKF4o069S5zU
         733yqb2285iCdrAmiERHzHzFXHJUB2CRSOqcQRaVrsdtiqisO+PO/TYwsQdkBmFFzvVo
         A7/w==
X-Gm-Message-State: AFuF++kpCLv1xCMzMFijxBoA3ZPxOqt3BIGBZG3GoJCRK4asw8a+OkMj
	W3bU3GiMqv6MkDdoawjz7aE/kuiJ4y6u8VrXzKlZTt93mE8tGiS0HyBGCc7CkULhIcvSgWGQpfq
	5IQzMKktDBdn3mr9Z4MI59le1Rc11xUJOtoZp/7h9
X-Gm-Gg: AR+sD11RoBtjqQBwQiCUjKfGYyj+W6C6G2gMj6fMi610uN78CTxanOSBg45kO+r1g6t
	i4Od+7ghHH5ZB56MMLUmDLD9OpdHLCwCW9CJjOpzfoOe89/AFKnJe9RbxwiY/sKk09i1crQglp4
	dW9KP5LCw/8OdUYmy9iHi4d9wXthK7cmTZ+jSuUJ1N44eu288r1t3AFLvnsGEgIc1vZyA1dikbA
	pAR7b5P/zxlbi6URj7N+VejAzVE14TSV+utiNWYuQNMYXmINMSTuIhACtX1tq3Dornh5eLFcevZ
	hDPNKYg4mwY+4SNmmSB5FEmi2eYqo5ZJeCN/vHNAXhMIMun1Jopp7xb/Ca+UTUajVI1x4DN62B6
	hAZmnTkcxsbHSQJt9/T3n6RS5TlMkyTr8Ks2lePKMj6JUGZLYWHOifUQc
X-Received: by 2002:a05:620a:2911:b0:92e:fd2c:6a26 with SMTP id
 af79cd13be357-9376fa52bc8mr508483085a.24.1787652232196; Tue, 25 Aug 2026
 03:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822195509.112717-1-jhs@mojatatu.com> <20260822195509.112717-2-jhs@mojatatu.com>
In-Reply-To: <20260822195509.112717-2-jhs@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Aug 2026 12:03:39 +0200
X-Gm-Features: AcwNN1U-T2UVBGOpf4wEx_gJO_Kp1mFyeeAJvr5ZzZXPomIOZJxZG-wpD1QPj9Y
Message-ID: <CANn89iKYg5YzY1QhU7D8mETW6avf4K-yoCwPNGiSrxRhdswbCg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/6] net/sched: fq: add overflow bounds to quantum
 and initial quantum
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 9:55=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> fq_init() computes quantum =3D 2 * psched_mtu() and initial_quantum =3D 1=
0 *
> psched_mtu() with no overflow check. A device with a huge MTU (e.g. dummy
> with max_mtu =3D=3D 0 accepting MTU 2147483634) makes psched_mtu() return
> 0x80000000; the 2 * and 10 * multiplications wrap to 0 in 32-bit
> arithmetic, so q->quantum =3D=3D 0. Then in fq_dequeue() the credit-refil=
l
> loop adds 0 to f->credit (which stays <=3D 0) and goto begin loops
> forever under the qdisc lock, creating a soft lockup.
>
> Clamp psched_mtu() to [1, 1 << 20] before multiplying so the product
> cannot wrap, then cap the result at 1 << 20, matching the bound already
> enforced on TCA_FQ_QUANTUM in fq_change().
>
> Conditions to recreate the bug: a device whose MTU (plus
> hard_header_len) is large enough that 2 * psched_mtu() wraps (e.g. a
> dummy device with max_mtu =3D=3D 0 accepting MTU 2147483634). Requires
> CAP_NET_ADMIN in a user namespace.
>
> Fixes: afe4fd062416 ("pkt_sched: fq: Fair Queue packet scheduler")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/sch_fq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 7cae082a9847..8a071c35b869 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -1222,12 +1222,14 @@ static int fq_init(struct Qdisc *sch, struct nlat=
tr *opt,
>                    struct netlink_ext_ack *extack)
>  {
>         struct fq_sched_data *q =3D qdisc_priv(sch);
> +       u32 mtu;
>         int i, err;
>
>         sch->limit              =3D 10000;
>         q->flow_plimit          =3D 100;
> -       q->quantum              =3D 2 * psched_mtu(qdisc_dev(sch));
> -       q->initial_quantum      =3D 10 * psched_mtu(qdisc_dev(sch));
> +       mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
> +       q->quantum              =3D min_t(u32, 2 * mtu, 1 << 20);
> +       q->initial_quantum      =3D min_t(u32, 10 * mtu, 1 << 20);
>         q->flow_refill_delay    =3D msecs_to_jiffies(40);
>         q->flow_max_rate        =3D ~0UL;
>         q->time_next_delayed_flow =3D ~0ULL;

Note that after FQ qdisc has been created, it can be changed, and
fq_change() and/or iq_range
need to be fixed.
