Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC84368D71
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 22:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785881417; cv=pass; b=h1iZnsKH/AV3r4yGklaJLWDr2wqbaWuCd1mrD1UE0/XGuLTGtsdXh5hGh9xIli2sYmlmMj/1+qoQXdYRFCF1UAqj/szV3bhtyp5nssD6c5UVpV5KlJq/gHg+prk3eY9gkm2QXzYFb9YG4HH3lnWiGFR7QIG7ixVwTEZeU1Ub26A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785881417; c=relaxed/simple;
	bh=7X5cSaIboniyv0K9SwBjXLnvxPS6WGXW/hc2d3Q4Zig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6YJkLiw+oj3fYEQ3PZNSvFXT0kALy5SxAJYhEwFM695g8y8/m/WXNvVocgpbaSEy0ZsyvXRHT4/XSAYxXcyHWIjfAwKn3JpJWFPR8ZPuEvFUsS3An52esZZj0WYZZK4ZllgwNqfw6/m6PN2Huv2OrKV+jbAz+RIOxHyidaPfVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bher2DFi; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bher2DFi"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8487088510aso387577b3a.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 15:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785881416; cv=none;
        d=google.com; s=arc-20260327;
        b=neFFXnXveGJ/+fnx+Cgvk2P+3lk0ih2wyn7izIKLZ6rU/1PCUF83KYQOyZrkdsaNvM
         Tj0VV/U8SaRXO1nZbWLiZP5ldeYSE7ZqddSOLExOrt4EA2bir2nMwCk8CLhJA/6PCZVZ
         u8sXd9Nkh/mPO4q9Y1l0ODv9xRa5pSpKmckbdLJLiaPyEQXLVf9a/AQqoT7BC4LyyoRU
         BbqumJaAm7Y0mVUB9ezasB5WwrSUNLvq20n5zG4UAYnaB35gkHmJ/bOaXSnj3bcH5XW4
         vKyXdw4cOIv+SmsXxwBDL8rzXm5qWk0XoXz/hKfSeRLoKY0/8nxxDakc2YUDxWubPd3u
         YkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MEsur95lzysG65UeFCPO1I0QCJo39klMfTJllaEhaIw=;
        fh=VbYL8Cq6A/7xcGC77AtyR6hOsfTVYZtp+IjRGItlbgg=;
        b=Hj+Kjf4vaYcJJB05nRcP29b0nwU7qcimthy+eKbYuhmL2PIO6bzlO/K10zJUd1EPNn
         knJ0xiwRkSn/gfdRHfEbOuBz+y5BHPuTEo72dyk0RPXnPwnYLIlTlc4XKwd7VPbZ4hdI
         VLYRiUZkGGdCe4mputMhTuJYsnIOYw8SfPa4UyhfDQzC0/NMgBw0stcS6xrTq1lGUStM
         hUKH3258nZMq8O8JSRMeiZxKO49cC+0tF/SvO02EjjjqJuW1iNH44fUntQ78FzAPcZiL
         bZ+QoTZdc/cyZCONfQySjtHzJMb/Nnkb1LiEVGDDvj+YG/pfebFrx2Q15J3Jp2wiNZSU
         siAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785881416; x=1786486216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MEsur95lzysG65UeFCPO1I0QCJo39klMfTJllaEhaIw=;
        b=bher2DFioxtrGJJ8dFbFICZjcFp/z+BMYay933VbMlU27cnXyebB5JBdGq9W96Efns
         ExJLlWb9CJ91ytfujdPAnrzdQSEHk7Hpc1FwvLS9lZ2yn/qoHMvh2IWh7hflYpJlfW/K
         n0MnlraL94m5ngTdoHgxQy3xj9VO6eQFOV41vVmSGOX9FExOhf3nXvutYe/UVP/ddSSW
         /NogScA9RZjoycWPl/zKgfhQDJoPEZLsjJFqR4x1S781qeDv3zQ62dTuODPjx1EGVIJv
         Yu0qJlZAtUcQfMmuF0Sh4UE9YCYcBRWEiy6iEntnh5rfd1M5PHU7+JTqoE3XQGvymNqK
         O32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785881416; x=1786486216;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MEsur95lzysG65UeFCPO1I0QCJo39klMfTJllaEhaIw=;
        b=GQFgOhklCdaJw3KT2ZL/oAptuoLGAu48+P4/UeWPEiNkI7e86xeWtATlnU+NWAYhtC
         H/L8ABBuCiqHBlSmeWfyLd3MZg+TDrB2g2u8Tb9MHKPcLzzCD2i7w/FHkn2i3GybBbia
         kQ8sTyp999BwxRKA8SCbI/o6HTMaWPo4ciqVWSvVEcM7OKlYGSfN2y9m29xz7WRkQRPZ
         TWmPb5gZD19GFv/hNdrvLB56HOSaGunDSGfLK8vU5FwZp3rvaUXNucJKAn829qOQ/uBI
         u+0tOSJTIigZS96CTCIeWwq28GfUWCQSvECs8KeFixoT8H8DAmzpfZIJTXqAC9sc028e
         0tjw==
X-Forwarded-Encrypted: i=1; AHgh+RoE9jV6C1rqnvBUgfqNKoEre08RmcWfpq6JQyGB9WdxxVZexaHQNauVCPtkwvRaj2jVcH056cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtI0iiZQsXS1z8dbzgkvTsN4HsNF6gNwzQ8sgM1fBWSQeUdyyB
	muyY1sbJG0ALcQIZ0n+aok3sy+5hALVcrjGv57wBxMDlAHcYKadG1CLKUHFiwKDdWS2SFI4mdmh
	l0wVVXhkLhfppL9JIrWRmm1kooEbK9Po=
X-Gm-Gg: AR+sD11LDoj/jbnpUWt5gSPvB2EHP4ao8VdaxmIAF12tLv0NB4TQLsp2V9MD0PDI6VL
	TPrg+bveNFMJsl+qXpxkAtXoY2BA4zZmF76i1Tk5SHd+9hohdSdhx0v/PTGsC6pN3WumfO4Tz/R
	wIsLoQ6NanwTyp/sc4Pu7NlcdFQ+x//QsvSxjc8anzZc7r1xX0TjZiKX0lKKbMdtXUIHBl77gyX
	/XrNEYjIjM4aHat7Buvh5ssoTowt6DHH4wn7ALe7iO6pKckKmIEcDGQfEagKKDyTTsZRbw2S3e/
	zbdxPRffPtK9I48EbtSvAWk1iT2sjqwZoaIEUrM0GczL59LBdd45LxjxV1gkftcaKiwtwG0D+4/
	EoRcFrYKC88K3JPtOpw8q2T+Sc0rSpDTCB4v9MYbfyfA=
X-Received: by 2002:a05:6a00:2c9:b0:848:5ed6:9d27 with SMTP id
 d2e1a72fcca58-84f2e12c9f4mr1932259b3a.36.1785881415967; Tue, 04 Aug 2026
 15:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804084310.818056-1-l1138897701@163.com>
In-Reply-To: <20260804084310.818056-1-l1138897701@163.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 4 Aug 2026 18:10:04 -0400
X-Gm-Features: AUfX_myk3fRliFcAY6f6ydLKWG57MHJVOOKE5vhJtiNaQeP_eu-slQ7PjG3Bu-g
Message-ID: <CADvbK_daHZ4vizDt4fiMT=rTDwhT=AJdKK5qe8v_jaLNAYBqxQ@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: fix use-after-free in timeout event handling
To: luoqing <l1138897701@163.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 4:44=E2=80=AFAM luoqing <l1138897701@163.com> wrote:
>
> From: Qing Luo <luoqing@kylinos.cn>
>
> sctp_do_sm() in sctp_generate_timeout_event() may process an
> SCTP_CMD_ASSOC_FAILED command, which calls sctp_association_free() and
> drops the last reference, freeing the association and its socket while
> the timer callback is still running. The callback then dereferences the
> freed sk and asoc, a use-after-free.
>
I don't understand how this happened.

If the timer callback is still running, the asoc refcnt must be held until =
the
callback completes, and sctp_association_destroy() is not supposed to
put the refcnt any running timer holds.

Can you share the PoC and the call trace if any?

Thanks.

> Hold an extra reference on the association at the start of the callback
> so both it and its socket stay alive until we are done, and release it
> at out_unlock along with the timer's reference. Also only set sk->sk_err
> while the association is still alive.
>
> Assisted-by: LLM
> Signed-off-by: Qing Luo <luoqing@kylinos.cn>
> ---
>  net/sctp/sm_sideeffect.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
> index 424f10a6fdba..f384c2faf1c4 100644
> --- a/net/sctp/sm_sideeffect.c
> +++ b/net/sctp/sm_sideeffect.c
> @@ -275,6 +275,12 @@ static void sctp_generate_timeout_event(struct sctp_=
association *asoc,
>         int error =3D 0;
>
>         bh_lock_sock(sk);
> +
> +       /* Take an extra ref to keep asoc alive through sctp_do_sm().
> +        * The timer already holds one ref; we'll release both at out_unl=
ock.
> +        */
> +       sctp_association_hold(asoc);
> +
>         if (sock_owned_by_user(sk)) {
>                 pr_debug("%s: sock is busy: timer %d\n", __func__,
>                          timeout_type);
> @@ -296,13 +302,13 @@ static void sctp_generate_timeout_event(struct sctp=
_association *asoc,
>                            SCTP_ST_TIMEOUT(timeout_type),
>                            asoc->state, asoc->ep, asoc,
>                            (void *)timeout_type, GFP_ATOMIC);
> -
> -       if (error)
> +       if (!asoc->base.dead && error)
>                 sk->sk_err =3D -error;
>
>  out_unlock:
>         bh_unlock_sock(sk);
> -       sctp_association_put(asoc);
> +       sctp_association_put(asoc);     /* release timer's ref */
> +       sctp_association_put(asoc);     /* release our extra ref */
>  }
>
>  static void sctp_generate_t1_cookie_event(struct timer_list *t)
> --
> 2.25.1
>
