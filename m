Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B246E46C4C8
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851112; cv=pass; b=LzMRGerEtvmmDnbLk/My0MlI5Il4WpIRYblWOO7VmcX6bq1KCUWMgx+TEtj8XatavAqFzeYa9UdsIlSRVWLUcPZ2aAf0Im8eV9AoOu5wMqqxVbUmXxV7Y8LtAqACbRCynUEjQKDzOwT6TX2W+ms2EoXim8cbWRRpMvlx9T+D7e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851112; c=relaxed/simple;
	bh=dBUBPexRlyMLsVoGjr+3rtevSBmSG8Ic9FKpcxX/rGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1qq0y2lOKyR08KU7Ggii60SLDaZc2YUw5TucREJbynT+On1TtjQoFKqv6Wn6dMVlVMrgjt1sPyaTViVPj9iWgeOMW9CJadmfK9iaZkR9f2BL1CmNW4bg+lA4a0NGLNWTtuvKkvGrf3XTln/DWzCaDgLuW+Bc3JbWbm8JC57lK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sn4TZopR; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sn4TZopR"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso22654b3a.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 10:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787851110; cv=none;
        d=google.com; s=arc-20260327;
        b=hYNqaPzajHX3yu7LIbdZE3Mm/mWIu/9eeXHV8Z+Ya99MFTn4ObgFtneJM+h8p9EJMM
         7tdCfO9KCfQ3gP7Gv/VLzx9v8IyTGsFRNrsdcohZ/oLtYV1KiED4Xz/ehWE/dSqDUpZF
         76MLyqMz2sPJYuPKcSWGf29c7hbYRRgQSfhyG2yshEi/TVAUiPCqF/WUQ9MhUrDxU+l4
         uUMhb/rQcSOSLI3MA1gkEDUE5NcJtSv69+siVKTTK5Cbl38kkgV/pNTdaJ9RrMVRo+9m
         /lzzzVK8rxRkEyujqcwRxk+OdaqDB8SthT8s2aC5BFOW+xgtVYXzEC0Pechxfhq3x0mg
         aR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YEtozXouVWJGqO6lpvX2FbcKxusT+Eqsv3MS9X7Ic+0=;
        fh=23p2pReGVz4pR0ouj+vQQvgCxeqPHd83Xi+warOUZFY=;
        b=N5JCbOPEiojO6BFVI3eBUZWC4SZr3/Lb+TtThkQhfLwtuynbjJSEzk67dKNYRft1kv
         fLzfNu9TMPRk1yoR63n11XwsbkZB3io8HpcEtwe8FA0urOJVEaDEJ6peyzuPa+FtBMrD
         1SY8yL+ixjVnbxTe3xm1NmKyEe5Hg4PQ+qSLuFQ38VSTQ6xpSXOOTdi5JEmjzWwvWcui
         Pa+0IDhsJqiu3wC3SdjZnxSvJzfl6VznuV/iDOP0iOFs4Rii3ScwDuz7OI6lelLr9FE2
         J4x3Kltfc3f5fWmpF1tJhwGJ4WZgu1cSvC8MSW9U6BeP1Mh6Niknbw3kggvmL8tpSnn3
         pwSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787851110; x=1788455910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YEtozXouVWJGqO6lpvX2FbcKxusT+Eqsv3MS9X7Ic+0=;
        b=Sn4TZopRyCYsnz8ga/aG3HyirHTm6zbi5Gy8J8e+Zw/OLjgMbxi2LgutE5yv4r8uQW
         D+RxU+hsIgDPFC+UCm0z8hJo7vw0wY8brvOTay40wqAovwKzaeGb3UCvRW6vwvTy1fgv
         70Ymzt5j7t07ZvEnvfWr5qO8adsU9V3hSXxaOfKe54DEapdHyXc5x+ApgxdZCJTKv92D
         912OjktLIOsl0zljMbxUbPqV4ivQ5RHe/8iymoNQZbkW+vJaftme+viFFqgTu2sWlpRP
         OIC4Fa3q6nFmsWb/gyY+nibwlfFSdDIJA9kyrlkVJSU06imQ78/5kiymAOr7PAEDAk0f
         SpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787851110; x=1788455910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YEtozXouVWJGqO6lpvX2FbcKxusT+Eqsv3MS9X7Ic+0=;
        b=njsZ4qF8PXLNEX070PuEzBntlnwhW0Jn0Dqlw70tR4V8PQN9vtv5/XLFZrSgCiRxqW
         8f95AmOThJUNDwXn+Cf4zjSTnX8g/AEZ7Sw3LP/ybZSDOaQfkIyJpycb79wMlA3T4xJ+
         M3tOiq6VBfoFaG3V9OmZDOdL5Jv+W9c33qZ/oUybxAwMLM5TzCFeXYTv2rH7FakrOsXk
         tgrnxUlV3kWW15nVWKxqT8+OdH5SIn58fkvn6I2bFp220VGkCG5g4GOmXobBCDIycVAh
         qGhThYojdVjxJSTpILcGiU8n2YSkBMSf+ynpxzCP3P38RrJG4FheSskxUeQwL+eGhvoD
         nyBQ==
X-Forwarded-Encrypted: i=1; AHgh+RrnXnXo8hs+hDBER08PyMSGU2B6xr6g/cohOl/N50LS2uJELBtqUMLGws7lOCnz4AC9UgDcAfg=@vger.kernel.org
X-Gm-Message-State: AFuF++kwDQBwDV03Jce6Dv0n0S7Fkl9nVMeuKTPl1m2ff51exOpZLL6S
	/aj/NfuwF3SGVu23nRqhMHVruxg7QmJCCegYw5S85cQ2/LYbyQtmKonnaw9vxVxg/GKqDlVZOLv
	er5tC2QB+W+H2+g9yY2bZDoJK55y0T7A=
X-Gm-Gg: AR+sD10xpz/uJmJfQAIalv1oUt7MZPw3qhVrawzuab5mz/CCjXE6l5Jn46fVAXT7kqG
	2/kqqkpCU/ammMe5sY+2hDtx9gA/xBreAJxAqXKlB1/+nXVTo7UUy2klZY9ISFsFsEIhQOtbQmh
	m60+qmvXPk2hSmNF4XxmBO3DkBfom1eJcBbhQyslKurj8l+JphqkUsqyytR8ZxY5ndzFW1DdRYt
	lRu+ZqbKbQm5I/1npyfgYUngo54d+x+/oXYm/1sB+lcDu+NIG1qLNAqSV51beXim5z+7jozU2U7
	4JYZ6pbPVdWNNVg1l+m5ZC2+fySjPr7Sx1nd3pW8BrMP57AuxPgjmwXMoViEb51iZNKx8nkzTuw
	uxn0nShjE0r1Bp5WeeuUVm2WN9yiT7iG/SAtm48xMVIQ=
X-Received: by 2002:a05:6a00:929e:b0:854:2071:be08 with SMTP id
 d2e1a72fcca58-854c6b7fa20mr9813220b3a.6.1787851110067; Thu, 27 Aug 2026
 10:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827075006.3979566-1-sunyiqixm@gmail.com>
In-Reply-To: <20260827075006.3979566-1-sunyiqixm@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 27 Aug 2026 13:18:18 -0400
X-Gm-Features: AcwNN1UYlSeUhyVnikOguDNaDeElz5rpDvHHe4_oAp-JS77cqmlR8-ikFEzZv5Y
Message-ID: <CADvbK_dFoagLs1c4b-3aFqsbDueu3VO0t-8S93+6GgevuoRBLQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: avoid livelock while updating retransmit path
To: Yiqi Sun <sunyiqixm@gmail.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 3:50=E2=80=AFAM Yiqi Sun <sunyiqixm@gmail.com> wrot=
e:
>
> sctp_assoc_update_retran_path() walks the association transport list from
> the current retransmit path's successor and stops once it reaches the
> current retransmit path again. However, the loop skips transports in
> SCTP_UNCONFIRMED state before checking for the wraparound condition.
>
> This makes the loop non-terminating when the association contains only
> UNCONFIRMED transports at that point and asoc->peer.retran_path is also
> UNCONFIRMED. One way to reach that state is through ASCONF wildcard
> DEL-IP processing after an unconfirmed address is selected as the
> primary transport. sctp_assoc_del_nonprimary_peers() then removes the
> other transports one by one; when removing the current retran_path,
> sctp_assoc_rm_peer() calls sctp_assoc_update_retran_path() before
> unlinking it. If the remaining candidate and the current retran_path are
> both UNCONFIRMED, the loop repeatedly continues before it can observe
> that it has completed a full pass.
>
> The same reproducer that exercised the bug fixed by commit 9b2854f86f0b
> ("sctp: don't free the ASCONF's own transport in DEL-IP processing") can
> still trigger this CPU stall after that fix is applied. With the UAF
> prevented, the ASCONF processing no longer dereferences the freed
> transport, but it can still reach the retransmit-path update described
> above and spin in the all-UNCONFIRMED case.
Please share the PoC with maintainers.

>
> Fix this by remembering whether the current transport is the original
> retran_path, still considering it as a candidate when it is not
> UNCONFIRMED, and then breaking after the candidate logic. This preserves
> the existing fallback semantics while making the full-pass termination
> independent of the transport state.
>
> Also restore the NULL guard around the retran_path assignment. In the
> all-UNCONFIRMED case there is no eligible replacement transport, and
> installing NULL would leave later retransmit-path users and the debug
> print with a NULL path.
>
> Fixes: 4c47af4d5eb2 ("net: sctp: rework multihoming retransmission path s=
election to rfc4960")
> Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
> ---
>  net/sctp/associola.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> index c0512c827d0f..6f19eb0b01e2 100644
> --- a/net/sctp/associola.c
> +++ b/net/sctp/associola.c
> @@ -1272,6 +1272,7 @@ void sctp_assoc_update_retran_path(struct sctp_asso=
ciation *asoc)
>  {
>         struct sctp_transport *trans =3D asoc->peer.retran_path;
>         struct sctp_transport *trans_next =3D NULL;
> +       bool last =3D false;
>
>         /* We're done as we only have the one and only path. */
>         if (asoc->peer.transport_count =3D=3D 1)
> @@ -1289,18 +1290,20 @@ void sctp_assoc_update_retran_path(struct sctp_as=
sociation *asoc)
>                 /* Manually skip the head element. */
>                 if (&trans->transports =3D=3D &asoc->peer.transport_addr_=
list)
>                         continue;
> -               if (trans->state =3D=3D SCTP_UNCONFIRMED)
> -                       continue;
> -               trans_next =3D sctp_trans_elect_best(trans, trans_next);
> -               /* Active is good enough for immediate return. */
> -               if (trans_next->state =3D=3D SCTP_ACTIVE)
> -                       break;
> +               last =3D trans =3D=3D asoc->peer.retran_path;
> +               if (trans->state !=3D SCTP_UNCONFIRMED) {
> +                       trans_next =3D sctp_trans_elect_best(trans, trans=
_next);
> +                       /* Active is good enough for immediate return. */
> +                       if (trans_next->state =3D=3D SCTP_ACTIVE)
> +                               break;
> +               }
>                 /* We've reached the end, time to update path. */
> -               if (trans =3D=3D asoc->peer.retran_path)
> +               if (last)
>                         break;
After removing the continue, I think you can keep using
if (trans =3D=3D asoc->peer.retran_path) here without 'last' needed.

Thanks.

>         }
>
> -       asoc->peer.retran_path =3D trans_next;
> +       if (trans_next)
> +               asoc->peer.retran_path =3D trans_next;
>
>         pr_debug("%s: association:%p updated new path to addr:%pISpc\n",
>                  __func__, asoc, &asoc->peer.retran_path->ipaddr.sa);
> --
> 2.34.1
>
