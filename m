Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF52C21D8
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345429; cv=pass; b=M9Pac0+s+nO92f6E9sITT1S4h2puLfNohvx7LUrurDHS4zxdJgdH4+WkkL1oMPi809Le9iWWIQzxIFJIb6OMSweU2LPnpQd61rEmWVhQMMHK0mbwKpwMH+XbgH0+nXboXJ81H4g3bsn8Ve8kDRVAp5VgWVaQZvfhNLiry9RvIxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345429; c=relaxed/simple;
	bh=OhmbSmdM0u9DdOQrpt0cd9CMwSU+7fo2RA//JQhrP5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mu0Le2PQxezpWq2frwgE4+Bael7AOX8pjJ9GexL2in3TEdivmsUbPMNE1do0lnv5PlofF4ihOUFIMQ2ZDSk62Oo5l05cE20Pj0b95WFMGBByxVHePC1XW+4HIxbprZnaqp9QaXrsp2OBtgvhQX+q0o2Vbac0BPYBbcmLFItde04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIchv2Af; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIchv2Af"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso95185b3a.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 10:17:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785345428; cv=none;
        d=google.com; s=arc-20260327;
        b=WWiUcxuFIq/N0TiZ+2MZnNmEI3TAazT+uiOJpy42UKJA9hGHAWDiD7NbwUPS6rV3yj
         MKDZaBHgJC/nqvJDkXNZQTSbwZfzqJhKxk0lM78m1GTrWROfugaLqey8mZrLnNssQBzE
         qayuVL4GDTyIBzmlT7sdjW/wqs+SIRbpbOhrHdA68AIttGQqyGtBtCUsxhgLvJ4hwMsK
         NT7mzXkABHGFJ7todtvoraDbTfjNChN8dFJAv289ojoSnMx/dBPCWAtYNW+Q2z065OG+
         sdGQodnQeTFdOzmXM8ppQ6RQNPIqj+e1uGNnVPNXWQlIP3hI0bxNnAg4nEWnHV5HEY/G
         3REQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=THkS45SRNxVl9I20kniMraMAUjrTFAmlyl7h5NEZIog=;
        fh=ygEkiqqxlxo1JI2Jldj29rFfS7cMo/FABL2jpS7C4+4=;
        b=F2ynwCIiInFDIfEoI2IU7NASQNiDHyOKrhyXFIp+6y9+XmL9iGBjQ7ojh6bDpY6vyx
         0ZOij0kztLN4srwdfgdQlpVDvzXyOTzXH+hciyG2dLoYB2GZcY3syIro1nyR7U6zRizv
         5aGkii7427CRp5PS4kdGy1VLrAvg8PUk16A/NVxzdoMzq20ziqAG7ag3SQVerV5Q2GgR
         iKUVRrd90jNti2645vverUNpdi337HFoc7BsIcx3Cb1AcMKETxiR6Z7irEbWlH+0ay/c
         kh8tEwWTdhX1b0w4faBB7ulcJEoeyjCdxVGR9NReQ+iYOghk+Q+Z1XXPgRjaDBP+w4vw
         juUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785345428; x=1785950228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=THkS45SRNxVl9I20kniMraMAUjrTFAmlyl7h5NEZIog=;
        b=BIchv2Afs+jkdWlV1UgVEkPeSgbhL3Rd8Eqs/fi4kBZkelKQ04NMg2NWABZ4Hiyl3N
         xadmvaqq9KL03mCuEwyMJoYht37zLohmLPqawc294OLsqy2TCNuLjUGogYLfh96faua3
         lfh8ISf24SdGJ+3mSbzV8qwv/1k9V7DE6rMKaJVs7KJwAl/zMfoANLou5btDQTIgvytr
         RbNYltwmjSmGN8G/kS/LHAV28MR4Tz6cJ9qc9QidZ1RRDTAQdQkJ1Jl3o6qMZiHUiluN
         VbN9dIs+3CkZtQhNsJcwjoqNZ08U0QDDaD6evwrAPYnxSqxu4ZPiA0WMdp4555z2O07O
         uqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785345428; x=1785950228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THkS45SRNxVl9I20kniMraMAUjrTFAmlyl7h5NEZIog=;
        b=tM8y/2v0lGxKBHxvpZQKAqg9Q4Yt7cykjktTbyo0g+e2baFp7r7UzgoCv+SmtFiajR
         63R66sz10jx2m3TCxjz0S0wivwTiwBj3iD9WIBSlFGigIBieV4KJMIZynXaPdk/exV1V
         EvFNxXtTt/IinuAhKWqJkjUuFTWANKUvLE6+L5pR8xhWORD8quEdbrIAShpRPA3upnsg
         M1DldRaayn0KxoDz8yHxH7cnWzIwI4B/nSHltqru96jDswCj8IlFQ8eWuxKmbN/JBbwI
         796IA5zAN5a+KUo2NqZXa7HpsU/6k274jYFo0s2CDe8XpjvDbwjMaYUT07dqUkh+hqz4
         709A==
X-Gm-Message-State: AOJu0Yymi7LSXHZYfmGZ0R0spSaAQKgl3A3A1152kyfcfHtRSnaMwm4S
	q9rrN1uUwTrfR9lAWEBRalaa3oU6ullYSqOpXX1/o50EdLkT7RFVvWIiNvhEQsj7LV2JtVH6X3k
	K8VV6Ysz1FCX1E9kI/KXhV+pUiVA82Dw=
X-Gm-Gg: AR+sD1037o5Y7lBRPEXLbitnsfTb+dsDC35gZTxH5dPFSwZi1pEYVusUioqjCo2Lr37
	dv1SeHxwAqiyPUADrOSKoLbWrJnqPmSH6h/XBhNPgRrGFny9+R3ZEiQLAMOXgBcEdqrX7MfO/ZE
	JTh+xzwcaaf62vN7NTZlC1qjJ81P09FRmpnNEyEzLYYElwNs0DOSQgb9VrezQz2KPWJiO4nvku4
	UHTrUnseh0LJ+cxk+m4js4nuAU9TwZjVH0Ji7Vm3L0WQsZT23ieFoMk91pTwjuoiNLfVioojZZ8
	XCjj4+c/IZY1biMHPANMICZUnFXAQuE+AuhH4gtiC1THAVzXBsBVT/SBkwIDlqK9DL119CEjv1x
	ZrTriljYTc4tL3B00cTyRP98Q6raoRmMfWbLo4jhqdVfq
X-Received: by 2002:a05:6a00:240a:b0:836:6f2e:bb6d with SMTP id
 d2e1a72fcca58-84ea7980b0bmr3344957b3a.14.1785345427563; Wed, 29 Jul 2026
 10:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729160028.54546-1-baul.lee@xbow.com>
In-Reply-To: <20260729160028.54546-1-baul.lee@xbow.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 29 Jul 2026 13:16:54 -0400
X-Gm-Features: AUfX_mycAA4GRHZLpXxPNLNWzWds11yaKRsmLmnwj2-pURl4kFY9e09gLFpPNa0
Message-ID: <CADvbK_cCCaE3BiGb9cUE1SM8BwJ-vJn+ezRiO1h538OeHyPutA@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: keep chunk->transport in step with the list
 it is queued on
To: Baul Lee <baul.lee@xbow.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 12:00=E2=80=AFPM Baul Lee <baul.lee@xbow.com> wrote=
:
>
> __sctp_outq_flush_rtx() moves a gap-acked chunk onto another transport's
> transmitted list without updating chunk->transport:
>
>         if (chunk->tsn_gap_acked) {
>                 list_move_tail(&chunk->transmitted_list,
>                                &transport->transmitted);
>                 continue;
>         }
>
> The chunk then sits on a live transport's list while chunk->transport sti=
ll
> names a different one.  If that transport is removed - sctp_assoc_rm_peer=
()
> from an ASCONF Delete-IP - sctp_transport_free() RCU-frees it and the chu=
nk
> is left with a dangling pointer.  sctp_assoc_rm_peer() scrubs
> peer->transmitted and asoc->outqueue.out_chunk_list, but the chunk is on
> neither.
>
> The pointer is not followed while tsn_gap_acked is set.  A SACK that
> reneges on the TSN clears the flag, and the next SACK reaches
>
>         tchunk->transport->flight_size -=3D sctp_data_size(tchunk);
>
> inside the freed transport.  KASAN reports a slab-use-after-free read in
> sctp_check_transmitted(), freed from sctp_assoc_rm_peer().  Both the
> removal and the SACKs come from the association peer.
>
> Set chunk->transport at the move.  The ordinary resend path needs nothing=
:
> it reaches its list_move_tail() only after sctp_packet_append_chunk()
> returned SCTP_XMIT_OK, and __sctp_packet_append_chunk() has rebound the
> chunk by then.
>
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---
> v3:
>  - drop the redundant assignment on the ordinary resend path (Xin Long)
>  - trim the commit message
>
> v2:
>  - fix the root cause in __sctp_outq_flush_rtx() rather than scrubbing th=
e
>    retransmit queue in sctp_assoc_rm_peer(), which cannot see chunks alre=
ady
>    migrated onto another transport's list
>  - correct the Fixes tag
>
> Link to v1: https://lore.kernel.org/netdev/20260726060453.42730-1-baul.le=
e@xbow.com/
> Link to v2: https://lore.kernel.org/netdev/20260729124929.5885-1-baul.lee=
@xbow.com/
>
>  net/sctp/outqueue.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
> index f6b8c13dafa4..e92fb9da4647 100644
> --- a/net/sctp/outqueue.c
> +++ b/net/sctp/outqueue.c
> @@ -650,6 +650,7 @@ static int __sctp_outq_flush_rtx(struct sctp_outq *q,=
 struct sctp_packet *pkt,
>                 if (chunk->tsn_gap_acked) {
>                         list_move_tail(&chunk->transmitted_list,
>                                        &transport->transmitted);
> +                       chunk->transport =3D transport;
>                         continue;
>                 }
>
> --
> 2.53.0
>
Acked-by: Xin Long <lucien.xin@gmail.com>
