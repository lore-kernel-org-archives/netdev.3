Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD253453A3E
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336434; cv=pass; b=ptlOfAYVZfdKt6CwI3crj2nMvIdS4h8TghJbv6KXjTi2RyoMuXsh1kfbVK81jvcJfEnnPDZDZnoPM8J/4KxhHCNuCh9mkr8jECL+5wmUcAX27kAU8pPhj514LP+RO40UBv1TyztpdkBzB/ehOHpB+XonZgFJSOymLTrH9p302eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336434; c=relaxed/simple;
	bh=Og4id6Ct8fGABQnVb5LY1NeAnkMXhVQES9jO6xtbdn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hljrHc331me5K3EhyMskNE265LT4UsnHK+JHskRqxorFyRTyqY4Sy6LMmLFeNXwovLbaQmXC51GY8A/SNWaKFiYo3J5Br+Q8R4qwWjBtGoHEcMwNZS6LY1mIh+B52A6QvdbqpGjFEbekMpCmIOvgXS1IwSKwxtpeNuzyTV8kB5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Squ47uon; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Squ47uon"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39f631dbce3so3524381fa.2
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785336427; cv=none;
        d=google.com; s=arc-20260327;
        b=rD/SpjtcDLPeOTTFsrT9R7lavrLPOjDzDV5yBD5VZiYD42Yg2P4NB7HrOjmvxGz7Dx
         SR7oPmYg9wtaAz+XZRSsDvqQGujdf5nu5dxZcu2rpRpxx2HTLgB8J2fhFNEanZCJ/r40
         B1YdXct9RVrsKQ79kXySXDRiLEADsVMTvYaicx0PzOMiL36Ah/CEma91F2II7xjsHOch
         BDr21M6rpreY2BJc735D+GsMal/gb4YXegcQZs1kF8URTdqePEDNeeUDii/iCk3N9rIL
         MEXLY8bwmWiJ+iTXIOy5e8E/mTuAsPuXUkdGIiytZdv4sQgAw0VM0J+CnVS3kluH+9GR
         U2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5rr6sUfFH1UW9C7FptcEoqBA/vnNvFWPYC6UpFpRsz8=;
        fh=6UgC8BH12JnPqBb72xYNtH0lg7NWdVwQUwtNy3Fdm0M=;
        b=Zwj31+ePIEn8ZI5NV+bzNeag2pMuza89METHZITT6CMSZugS43UT4SgyfF4Bp9ixtt
         cMUfErC88C+tJ67T1h7lu/yyvA18FIMhOXsMtnJczyypbbui9YCK/L3YhflV4YeYGzdj
         Smu+yYpw56ZBMJjtEV/OKrT1XvyCW5+udaEaSahpqs5KOlragw1IXi0oepgm6+CY2bEd
         E9+y7rHlQgSvUxyPNpR/WWy6S1c2Gh9QlWXr5zQGUswaH74bC4fIDO0KmniVxslb76X+
         h65lnlvYrXFoHb4puF81jUZt1cIc2e1VOpUx3XNsovDEDYWkTxcocjuf1m6dr24mkF2W
         tzMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785336427; x=1785941227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5rr6sUfFH1UW9C7FptcEoqBA/vnNvFWPYC6UpFpRsz8=;
        b=Squ47uonSOhNZat70I5DpGUxWk1ENDdPOuC26Syoveo7zMQ28khBv3XoI/lQ1509D7
         w83YtuLZ4MS4G8JohONBi1ZzwlPvO0scU7beNGXZ0k4ZToxrYInAIc4m1ni2I//xcYFj
         aJonhG+lfY6J7ySouRfttKNcv67CubFgHrfllxQKdulzepJLvC4cn0bTyt3W3MKgsXpL
         2IUgNwzJzWjrYshAPgx0t/NiGYsaVFWbGIkTdLPYoqwtmeFXpp4PDZtCTGcDmw7mghVk
         Yg0IMHyk3XCjNJWuXXXa7Irotod6S6GlZ6klPB7YvIiBhKnbvq+tGU9IUJqEiNIc/L9S
         tdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336427; x=1785941227;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5rr6sUfFH1UW9C7FptcEoqBA/vnNvFWPYC6UpFpRsz8=;
        b=JLzXRRwZj7ahQjWIAM0/VUbso4+6qXBsYW2kCeAIJ/9rZajfG3xkLLk/rP6VgIiZz8
         s7c3W++3J+fd61aYSPUXTXEAd9eSl8oCRubJEdEnnu+870WnzXRrjyte0WD7jyzjjuP6
         zj28j9a3bcGx64BaSNPy9TOUJUzfoARHnfMH9cIZVpuFDSLIXIGvIxvPs27pWUAxbz1a
         1f2bbZn7U7VECusbeAWWj4wLeVyVM0fORTLDZKo7qNAA0Jr8yObG51xU/uzyJXkfhYeb
         4A0gdy+prnu6f5C5Z3Hdd4El9oghU6EZPPn12InGarnTmSef2V0/0V7z8PGGM3WHLsiH
         I02A==
X-Forwarded-Encrypted: i=1; AHgh+Rpzu9J65vgdcNhJSszxDTKSeUlNHtMW+sVMn+qn/2ztAz+tdKUReGihr3I35xvDjfXEoUM067Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAujYAmcQplIk9ciVaN+/AxJ6mGSNe5FH+J6yUJ3GBJ2AoOjJ
	Qrv3V0K4Ibvj6teR3o5wmLhpvmxEcgF85Gdz13DUOhuwFmhPZh6o1iD7eUdc/+f4X4WPzpxvk2Z
	WEQIJhVAtw4MeuNLdjOe6l3x2HxKeF8EcgQ3G3rad62o=
X-Gm-Gg: AR+sD11Xf/mTk7PS+C1OlrnNhRI+StVd7H3IEOSEFRvGOt8FGnW3ZxSAG13aTnlCwPk
	F4WEJ1wVqeLMQgRt8mCBInhDp/sDuHJT6cUpGwZ38Gz2lE8QEiIAJCj99dzgiUanM7qO1BbpFft
	uhhzIsWFZ0MvchGiwfAVJ5J0GI8Rikl0wW/M9mrUMT+jAGBqSzmji44qneSn8NevLGqFCkDJ5qn
	3Fj25uPwO57pYw/ZA2Pu+HC+OoGWiqMTf66WgcOkSilp0PlNmQGA0eeQHDudX3G+XK6UPlIEPDT
	fGigkQgjWl1ovTLvKhyVpm3tXnJ43BFDGzE9Pr7oQMqnFA==
X-Received: by 2002:a05:6512:6c9:b0:5ae:b78c:da1 with SMTP id
 2adb3069b0e04-5b2d022f821mr1503106e87.28.1785336426875; Wed, 29 Jul 2026
 07:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1784894076.git.zhilinz@nebusec.ai> <5bc7cd71c2d671b305f25497d88ae8a0aa663c08.1784894076.git.zhilinz@nebusec.ai>
 <20260729091227.GA1258429@shredder>
In-Reply-To: <20260729091227.GA1258429@shredder>
From: zhilin zou <zhilinz@nebusec.ai>
Date: Wed, 29 Jul 2026 22:46:53 +0800
X-Gm-Features: AUfX_mwhSaF6s44nrueIldqTckkyEJR3Y9YMJvTLwoXXATeLn41rh26IAR1gAmI
Message-ID: <CANB6i5wBSxrTkBUvK8ehqGN7-oK6m1X29hxMnT7kO-JVpnKpRQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] ipmr: only copy pktinfo to cache reports
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ren Wei <enjou1224z@gmail.com>, netdev@vger.kernel.org, dsahern@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	leone4fernando@gmail.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 5:12=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Tue, Jul 28, 2026 at 12:44:49AM +0800, Ren Wei wrote:
> > From: Zhiling Zou <zhilinz@nebusec.ai>
> >
> > ipmr_cache_report() builds short IGMP reports for mrouted from a packet
> > that may be a synthetic RTM_GETROUTE query. That query skb stores the
> > netlink requester portid in NETLINK_CB(), but the report is delivered t=
o
> > a raw IPv4 socket, whose receive path interprets skb->cb as IPCB().
> >
> > Commit bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP
> > msg") added IP_PKTINFO support by calling ipv4_pktinfo_prepare() on the
> > original packet and then copying the whole control buffer to the report
> > skb. For synthetic route-query packets, this copies NETLINK_CB bytes
>
> It's copying 48 bytes, which is the size of the control block. Please rew=
ord.
>
> > into IPCB and lets a controlled portid corrupt IPCB(skb)->opt. With
> > IP_RECVOPTS or IP_RETOPTS enabled, the raw socket receive path can then
> > copy past the short report packet or overflow the stack option buffer.
> >
> > Keep the IP_PKTINFO support, but initialize the report skb control buff=
er
> > and copy only the pktinfo fields prepared by ipv4_pktinfo_prepare().
>
> This can break IP_RECVOPTS and IP_RETOPTS on the mrouted socket, but
> this was never meant to work (side effect of bb7403655b3c) and therefore
> unlikely to cause any regressions. Please mention this in the commit
> message.
>
> >
> > Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg=
")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: Codex:gpt-5.6-terra
> > Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> > Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> > ---
> >  net/ipv4/ipmr.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> > index 1d9a4ac14fcef..783de5de02ddd 100644
> > --- a/net/ipv4/ipmr.c
> > +++ b/net/ipv4/ipmr.c
> > @@ -1061,6 +1061,7 @@ static int ipmr_cache_report(const struct mr_tabl=
e *mrt,
> > +     struct in_pktinfo *info;
> >       struct sock *mroute_sk;
> >       struct igmphdr *igmp;
> >       struct igmpmsg *msg;
> >       struct sk_buff *skb;
> >       int ret;
> >
> > @@ -1113,7 +1114,10 @@ static int ipmr_cache_report(const struct mr_tab=
le *mrt,
> >               msg->im_vif =3D vifi;
> >               msg->im_vif_hi =3D vifi >> 8;
> >               ipv4_pktinfo_prepare(mroute_sk, pkt, false);
> > -             memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
> > +             info =3D PKTINFO_SKB_CB(skb);
> > +             memset(skb->cb, 0, sizeof(skb->cb));
> > +             info->ipi_ifindex =3D PKTINFO_SKB_CB(pkt)->ipi_ifindex;
> > +             info->ipi_spec_dst =3D PKTINFO_SKB_CB(pkt)->ipi_spec_dst;
> >               /* Add our header.
> >                * Note that code, csum and group fields are cleared.
> >                */
>
> I believe that Sashiko is correct and there is a similar problem with
> the other branch:
>
> https://sashiko.dev/#/patchset/5bc7cd71c2d671b305f25497d88ae8a0aa663c08.1=
784894076.git.zhilinz%40nebusec.ai
>
> This should fix both:
>
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index 1d9a4ac14fce..4827973c6f9c 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -1058,6 +1058,7 @@ static int ipmr_cache_report(const struct mr_table =
*mrt,
>                              struct sk_buff *pkt, vifi_t vifi, int assert=
)
>  {
>         const int ihl =3D ip_hdrlen(pkt);
> +       struct in_pktinfo *info;
>         struct sock *mroute_sk;
>         struct igmphdr *igmp;
>         struct igmpmsg *msg;
> @@ -1112,8 +1113,6 @@ static int ipmr_cache_report(const struct mr_table =
*mrt,
>                 msg =3D (struct igmpmsg *)skb_network_header(skb);
>                 msg->im_vif =3D vifi;
>                 msg->im_vif_hi =3D vifi >> 8;
> -               ipv4_pktinfo_prepare(mroute_sk, pkt, false);
> -               memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
>                 /* Add our header.
>                  * Note that code, csum and group fields are cleared.
>                  */
> @@ -1124,6 +1123,12 @@ static int ipmr_cache_report(const struct mr_table=
 *mrt,
>                 skb->transport_header =3D skb->network_header;
>         }
>
> +       ipv4_pktinfo_prepare(mroute_sk, pkt, false);
> +       memset(skb->cb, 0, sizeof(skb->cb));
> +       info =3D PKTINFO_SKB_CB(skb);
> +       info->ipi_ifindex =3D PKTINFO_SKB_CB(pkt)->ipi_ifindex;
> +       info->ipi_spec_dst =3D PKTINFO_SKB_CB(pkt)->ipi_spec_dst;
> +
>         igmpmsg_netlink_event(mrt, skb);
>
>         /* Deliver to mrouted */

Thanks for the review. I will reword the commit message as suggested,
mention the IP_RECVOPTS/IP_RETOPTS behavior, and send v2 with the fix
moved to the common path so both branches are covered.
