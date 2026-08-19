Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52783BADA7
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151155; cv=pass; b=iXM+xA1fI6rmkkFzMvlS8o9vgXLf8StXNwa5j6pfMIo0Iwqwsh7oUJPOQ9kFECMF4c7WPAg9C8Eohg194QmBqGE0EWQipvq7Xk/lGOvrtY8wVd1B1CkXYVV1Sq6HSoldE7o6fPvkGFUDwAeJqVz0cGB9Zhn9QcGjNn23dVS98xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151155; c=relaxed/simple;
	bh=xX7tul4hXcBSX9qG+ACteaG47P6VqHGByp7AxU87r8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlHztQdUi0bbd4Q1HIU8iIhi3SIm66sEOafgwA/xgknxPWbEk7tvFKG4k0aTocZzg9FLE4HhAxRRJWius3dOuhitNdX/lsXa4THTsui0k+HTYU7o1v3jazaD98MaC4p58z1leeQ8Ow8idOM/MpSK6pmyydbg0LOEb9T+YGDjrc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=onvjW9PB; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="onvjW9PB"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9309d4ea213so98668985a.1
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 07:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787151153; cv=none;
        d=google.com; s=arc-20260327;
        b=cl/t0w37lORsOdBWAQT2edUeWqRBeiOaBJ2qYfztI82r4UtewHiYK9ZF2aHPB09nHD
         yyKW1GRB4N5dR5+k05Ez6A0BbBESKR1ivAivSQJMplOj0y74yRuYozX6JzU1kxhULPFq
         bqInx7+8AuPZk0k6n6Gf68oG1sVlTLovirrUqzv7I2vQhozkQfP1sPZvJPEe/7Iu3FAq
         sSqEf9Gz/1ndWn1FNzel5Y21g3+M8e+I6u56h0ztqPKvjWfti9og9Y5CMeELyBamPULZ
         GXJzkjjxlb7r78N/uIr1sfECEsV0KLFOFwPdoUaa3S41rGMGUOBhLgO27JBOU07KM8go
         aaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e37xg4Cf7pXUssRAo8BCWvtHI0TL4IZrMsLP0V2hG2U=;
        fh=X8BDq2/KK+aalG3nUimw3vzOLwCn/tnGxVtO1Bv9toQ=;
        b=MKFl4xutXGn/5D79SHKoZZiWUWyEXg6Z+WxUsga+wVd/KmRfxaUyeiT6AW/kkohsUb
         PP7s8xB9VMWBtwAcUl0EhVKm4UxVyd44O+0cbt+ZcwE99npnFe1rwCxcSoggmO/42yfL
         YR9/3VlwBxoSSV6m4mQDo6fOEuEYaV9NyDF8aXTZ5u0LnjriPIXIabfDdeuR57SFaIMB
         no9UpOpAa6XWIrQjTIAMXuCws8HXk7ATfpr7nHTX2Cukicy/t7nuxIlbJBly2dSG8AiC
         9DiJkgjqr6JmRcR1ESEPH1Wm/s+07WNk3BdFvmC1h9wyMahXCSeWARhUc6I5uXrpIo4I
         TYsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787151153; x=1787755953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e37xg4Cf7pXUssRAo8BCWvtHI0TL4IZrMsLP0V2hG2U=;
        b=onvjW9PB+M5i2qKiHeNsPahJm71GMHX1c/eZTw8hOwAOnOd+eRY9JqjOIgxMBkK3zj
         5S5hKGPLAJEUCKcb3Q4flK5AlDOr+L/VL5mGoGYs58RTCzMidt7+1Fg4vSO7uMnDKXJb
         LjsefYdMLoFF73HImE2RQKxQBmADumlsJ1/QY6i4f+Y0+roDJoCkwYL0QL4CwV56rq6s
         5To0LajqWJJ1N7QIWimbOcNLiXo25YE4vfgNbU13V837UocfWXUDIdXH6qY+2cFFDadE
         zIJhoVF2gGqaO2YPW9TFhVdTWO8a3ZoNjJoE3TF0mhGtDo7MM90Twa9Chcjx7XoCsp6V
         qy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787151153; x=1787755953;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e37xg4Cf7pXUssRAo8BCWvtHI0TL4IZrMsLP0V2hG2U=;
        b=ja8LY7FsEOY+GGgHQrqbUywjDNrh1PnUlTD3568xWhey0uiPofp/kBRbUPvv8gaSux
         KihUrPeq23ae7ujJ5utgQfB8esQEJ4qymgKfE1jyGm+61vSPaJwzlH+wZQS3B9YFU+FP
         +slFGjHwrpt12I1YuGtuLhKaNnzaQS19zNkK5NtTjLZFlayKvEUvFC73pyizE0LHmVZL
         wPXvsrkkDDAbUHf0SbYbFu4DmbQF6uuSIZt1pCay8G8spTsdNLqnXrvx+wkrp3lXyep0
         nlQGknWTEysDcBNwnaot6gpvU1V3bmZoNqLqKh5fGjVRzGWEN3Yl9rq1da7xJSHsT8FE
         jN+w==
X-Gm-Message-State: AOJu0YzJ0Ngb97evtbKCDwZkIth1XhFmIGigtob3IUdSnSr/qGVrY6Fd
	BP0XzEpqJrvNcxXiXb9v6suB/j/xtNfdZsX1dSV9pGOskePltqm3sijgcpW5FgZJjHkHr9bqQkh
	sDvyeDRwVDMNjbpUdZqPPHFBcsasxq2KvEd/BOUd7VvnhiTjzTFG9F50s
X-Gm-Gg: AR+sD112XvBr8Qt/CrzXYXBgCoVxj0XUeS3tqTOF0PtZV24YPwBYmyrNyeLflR34C9u
	yovJAeq3G0zmn7eEv0WLo6TJjlQWFf1Sp+QaTeepHBOW6L2VD+tFQkGjDQUn1WLUu5swXBHZGfL
	AudZ14COnZPFLDZ/vd3PL5vS+J6palNQaEvzvVFQ+TNdGAZtMml66ftgpkhs7WAvWz7pubIMPoi
	SNi5SK6bhUw1K9sd43EKEtF20npupeRQjJoxZX5GQ00IjcFGBCro4qU18SnegyM7tHhWTegao9N
	HsQhI3oVa3NIN3xDWF9W8qifgG0CTd3ayOkGdX92k5xiiJW+Tw3HPRBi5o0CN8wR3go1xcLfzb0
	oiOvEV92xzS00zIZmg8+ysgGTFtRB7T0OEyobRE7YHd7gnRsFxmxxzsqTJYsCThInBIYW0Igc3v
	7d48kNFhNS7YC+Abs=
X-Received: by 2002:a05:620a:1a0b:b0:936:9b1f:d3fa with SMTP id
 af79cd13be357-9371e65b207mr508702885a.43.1787151151775; Wed, 19 Aug 2026
 07:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143213.57401-1-jhs@mojatatu.com>
In-Reply-To: <20260819143213.57401-1-jhs@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Aug 2026 16:52:18 +0200
X-Gm-Features: AcwNN1Xp6InSXOSnLzrSDbazyiPc2lWYJwdnLOyeKjlzuUXiTDsmBqpqmz7lAM4
Message-ID: <CANn89iLM1JT7xeANTFYOxaOKuz1qSmM4yugRDg4y=uFwP7bdEw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: bound qdisc_pkt_len to prevent qdisc
 soft lockup
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 4:33=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> qdisc_get_stab() accepts a user-supplied size table, and
> __qdisc_calculate_pkt_len() amplifies qdisc_pkt_len() through the
> overhead, the size-table data (u16), and size_log (up to
> STAB_SIZE_LOG_MAX).  A crafted stab can therefore set qdisc_pkt_len()
> to ~1 GiB for an ordinary skb.  Per-flow deficit schedulers such as
> DRR and ETS replenish one quantum per loop iteration; with a tiny
> quantum (1) they spin billions of times under the qdisc lock,
> producing a soft lockup / RCU stall.
>
> Cap the final qdisc_pkt_len() to GSO_MAX_SIZE so the size-table
> amplification cannot drive deficit schedulers into an unbounded loop.
> A legitimate size table (e.g. qfq's overhead 999999999, which is
> handled by dropping) is still accepted.
>
> Conditions to recreate the bug:
> - CONFIG_NET_SCHED=3Dy, CONFIG_NET_SCH_DRR=3Dy (or CONFIG_NET_SCH_ETS=3Dy=
).
> - Attach a DRR (or ETS) root qdisc with a crafted TCA_STAB that
>   amplifies qdisc_pkt_len to ~1 GiB (e.g. size_log=3D15, data=3D[32768]).
> - Add a class with a tiny quantum of 1 and send one small packet; the
>   deficit loop spins billions of times under the qdisc lock and trips
>   the softlockup detector (panic with kernel.softlockup_panic=3D1).
> - Reachable as root or from an unprivileged user in a fresh user+net
>   namespace (unshare -Urn) with namespace-local CAP_NET_ADMIN.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
> v1 -> v2
>
> 1. Sigh. The v1 overhead cap broke the existing qfq tdc test 5993, caught=
 by
>    running the whole tdc.sh instead of affected qdiscs reported reported =
by
>    poc. That test legitimately uses stab overhead 999999999 qfq and expec=
ts
>    the qdisc to be accepted (exit 0) with packets dropped.
>
> 2. Better Fix: cap the final qdisc_pkt_len() to GSO_MAX_SIZE(524280) in
>    __qdisc_calculate_pkt_len() per sashikos[1][2] suggestions
>
> 3. Given existence of tdc 5993 we dont need the tdc test created earlier
>    since the essence of that test is covered in tdc 5993.
>
> [1] https://sashiko.dev/#/patchset/20260818101735.16655-1-jhs@mojatatu.co=
m
> [2] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101735.16=
655-1-jhs@mojatatu.com
> ---
>  net/sched/sch_api.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 65b35528d125..ad4f117ff55a 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -610,8 +610,11 @@ void __qdisc_calculate_pkt_len(struct sk_buff *skb,
>
>         pkt_len <<=3D stab->szopts.size_log;
>  out:
> -       if (unlikely(pkt_len < 1))
> -               pkt_len =3D 1;
> +       /* A size table can inflate qdisc_pkt_len() beyond any real packe=
t
> +        * (via overhead, the data table, or size_log); cap it so deficit
> +        * schedulers such as DRR/ETS terminate their refill loops.
> +        */
> +       pkt_len =3D clamp_t(int, pkt_len, 1, GSO_MAX_SIZE);

Yeah, although it is a bit strange to mention GSO_MAX_SIZE in a function wh=
ich
does not take care of GSO packets.
