Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1803BE168
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000093; cv=pass; b=JqLNdf9REgacJYW5vn33zPLAZ2kb1kzai9ADogeLlPWW0Y3fxEWHOqXMAE171fdNM3b/A5/ZV2hYlIsGhy9HoisQcJV9wdoct5OwSG1LjjxmZKBK6XfR+ISh6+kQJWceuoS9XFO4u+Dw7VKqvTdK1opBRiWCdEddVrpUto48plY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000093; c=relaxed/simple;
	bh=4zt5jyZW6qLEmymqr6lbsWEB9Oh7ETJPK3ZySvB9Lfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRCq1cHd0vhAzMkgO/qxL7UDqegxIy/0aSZd3pyRitKHCLjtn3P31NDedy7TwQsj16rFmFysitx28sE4LOqQp9z7XLVp9D/qtxenpppepd+NHtM20bxOf9xyo3Av1AIe5HiBg84NouRmxM+eVAlSgbR+YZfFO/fMtiKgdMGREpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBsTaV63; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBsTaV63"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8487214ad2bso5249035b3a.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 13:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787000091; cv=none;
        d=google.com; s=arc-20260327;
        b=UJMU+y2bmSfdDxc1TXB/tyjlGPBpMKdXtdIoyIRAmDJaE4MCzsQGWlDxKuNgWO9+b6
         OtyE7n9p8wbxQwV+/R6hjzA9e+sARGISQdFR7H0L+FMCkaAUGEKc/8POMWM7W2Gz18hK
         XdNeNsXFZM/XqIJIY4KBgXNn/e9sCgX0du8Z4jaUonltt+VZpVEYV/JqiwChlI2hjSeI
         sBniVWB34L+UmTRYgGIkrwqovi3eNUIwxfwFMrxVlQyhVCWYqGGD1M4l4/lY/pFkN0ne
         yEIT2xXLkJqJWvoNzLoZoR6RsiDt67fS/8x4Dx+2dhBvgaYPaC/T4EhUOx4q/ugvaEGA
         /4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TZzvkyfzcnxRFEfgSgwbrJFbE3ozE/bmeORKlNaSn9Q=;
        fh=bk1vZdQTQK/NBwooGIN6vGuRDuXIPnNogefRvmjJmHU=;
        b=QxukpSPik7rtXJKhCEtP0BLqkBBt/oUPTFpDns6drDR7dAgIrkA3yPpQlvJB2t4Bgp
         jICXInDqYxoaWukKl29WS1T9fixDMn5Gkc9zivcbwSu3hh3htNfeZVW0eMsJHZ1NQyoq
         ri7T+KLrkfBr8heGmrz7KKbC/76IKHaWlP2fLYhLQzyvjdGV/eNLDcM19jQXSFc1xVRh
         zn3xPEc0a5nwZnv4f9RmkvxAUWdt7PdwgElgHfcttzrW6Dz2yhaAyPJ1p9Peu9JFV/vZ
         +jI8CrEZz0qRQ0LO226NshmZoHHd/NbLv5a5wzzEV/lNdHE8uxU/ewqP58lwZFuOjT2J
         AavQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787000091; x=1787604891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TZzvkyfzcnxRFEfgSgwbrJFbE3ozE/bmeORKlNaSn9Q=;
        b=dBsTaV63zVdIFsaEf+kB3CdlhRwvunbkEst2jS/In+H8yKtj3FR6d6jOdO7rYlGquw
         5fJdxNfYPfuk5Yg7Pbwyru9sWXao2bBuE8OSf1OB30jDsin6vpRGnpXQQ4NR/a6Xl2vO
         /TrhnxHulvU8ChYV59JiH3gwns8GpqSD9ZkYzKvtDGeBasA0caOU10pAwn9QqV2tRKK+
         wURWtJxSn2zgTx8yFgQBMHpvj27tlCXMSHdyEjfBjCUrIln+qAcmEnm0hBOcBWRUdqVP
         60TUL99CmuhObb3Ss4GCeSE00LfqQSvhUaqQi7bBQhqJog0gs2zbKg6tf9JW9JTIH4ht
         HrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787000091; x=1787604891;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TZzvkyfzcnxRFEfgSgwbrJFbE3ozE/bmeORKlNaSn9Q=;
        b=cXHzydPpWCdUyL6Kfz98OwZWhJWwv6YLQzOE9iGw7nIM4vtjqrIgggJDxSX9oL3vxu
         R3RA8nnuOJzV30MEPiluGb+gYRNdYJGrEX6GcooLam/DWWpVUUjUjV05qq7eyJULLK9u
         YLs6ixmeYOkqheVWBCXoWEpTTjOgbaluet0sD78PotvX40fPB87MERQQEcyOv6PLI5bo
         JshYrCXDKTuPUNSGPv1DCizfijVMTyKTbsc+3sJSr8Yl5JvvndSey+hPIpdTSDFrwncO
         M90HTpu/O/gWiglaBwXVgzGLdb8T49h6eENnE1ggUUvmpTjL5WiiNgNshXAUvqu2SvJJ
         Qxwg==
X-Forwarded-Encrypted: i=1; AHgh+RoWDF6uk9/aWbHKt4Hm5SwENwLHTg32PjKS/A6C3olfb6gHC1qUkKm24+VvbqadHbOdwes5RnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf5pdhN3XQZ3qVvwCeVY2+6ZqJwnh6qANkhq70rrzhbLLF1dz2
	omRaA9pG0S05KqTenkoXVDIxqI3BOriGOcbZ/WPB82kc/mSzxWqv202uduYyOZWe1OyeUbTWTZI
	D462nCBXNJEp8LzgZmPYIBcXPTxrCpyo=
X-Gm-Gg: AR+sD136jPQLVkL7tpFkuD37Trh0ErJilEfKTVEGPlv/zyyxSxPZGURFSTbBkN+xcqy
	ID17VHfBrJOkg+QtKUyXqEO4E5JbANgFz+59ynYaWdlgMHbBYx3znBOoZUD1UINAQlmvIBmmx30
	BehhQeDnXunOAbNr/g4RXteqrzlc5OG3r/TX8w5TQuctTqMaz/Pq+nb3pbRvgAN9otzAhV6D6bM
	rG8gk0eR7u+y75Vh+lIZOkV1q/fU+WDXwycXwcJxusdFNKq5gvNsOcvfI7rMyjsMKg6V6IMwxux
	hDAVGn6GR6bCTFh5KEyXIPCMGqKDYNybLuYm/x/F+zYtQeT0G9ofMbw8bJVmaGdX0DhMAGWVHD8
	hbxPh1lCuzobojgMMjj0gvl/YV5+owc6Vwig2z5Z3Ujg=
X-Received: by 2002:a05:6a00:338f:b0:848:4424:2b8e with SMTP id
 d2e1a72fcca58-84fddf9258fmr28183545b3a.3.1787000091116; Mon, 17 Aug 2026
 13:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <an-YYtoqw1QpTXUL@v4bel>
In-Reply-To: <an-YYtoqw1QpTXUL@v4bel>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 17 Aug 2026 16:54:39 -0400
X-Gm-Features: AcwNN1Wa_-XbpcJpjQ1aDnUYAmjLOxacmUIvkiau5yGSOhYY4ESNLzUUiYe5h0I
Message-ID: <CADvbK_egNorDqoGeHb_wOZ6wVxQ_f_1jFJ5uNvXu93-KAd3rXQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: stop processing a packet once its association
 is deleted
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 6:36=E2=80=AFPM Hyunwoo Kim <imv4bel@gmail.com> wro=
te:
>
> sctp_endpoint_bh_rcv() looks the association up only when chunk->asoc is
> NULL, and caches the result in chunk->asoc and chunk->transport without
> taking a reference.
>
> A packet that matches no association is handed to the endpoint, so a peer
> can bundle COOKIE ECHO, SHUTDOWN and SHUTDOWN ACK in one packet. The
> COOKIE ECHO creates the association, the SHUTDOWN chunk caches it, and
> with the outqueue empty the SHUTDOWN ACK reaches sctp_sf_do_9_2_final(),
> so the association and its transports are freed.
>
> The endpoint loop has no counterpart to the asoc->base.dead check in
> sctp_assoc_bh_rcv(). The next chunk writes to last_time_heard in the free=
d
> transport and is then passed to sctp_do_sm() with the freed association.
> The transport is freed through RCU, so this needs the packet to come off
> the socket backlog, where the loop runs in task context.
>
> The endpoint loop cannot do the same check: it holds no reference on the
> association, so reading asoc->base.dead would itself be a use-after-free.
> Mark the packet for discard in the command interpreter, just before it
> deletes the association. That is also before sctp_inq_free() releases the
> chunk on the association receive path.
>
> sctp_sf_do_5_2_4_dupcook() issues SCTP_CMD_DELETE_TCB for the temporary
> association, while the one the packet belongs to stays alive. A restartin=
g
> peer can bundle DATA behind its COOKIE ECHO, so compare against
> chunk->asoc and leave that case alone.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/sctp/sm_sideeffect.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
> index 424f10a6fdba9b..94716406d602ce 100644
> --- a/net/sctp/sm_sideeffect.c
> +++ b/net/sctp/sm_sideeffect.c
> @@ -1332,6 +1332,10 @@ static int sctp_cmd_interpreter(enum sctp_event_ty=
pe event_type,
>                                 sctp_outq_uncork(&asoc->outqueue, gfp);
>                                 local_cork =3D 0;
>                         }
> +                       /* No chunk left in this packet may use this asoc=
. */
> +                       if (event_type =3D=3D SCTP_EVENT_T_CHUNK &&
> +                           chunk->asoc =3D=3D asoc)
> +                               chunk->pdiscard =3D 1;
>                         /* Delete the current association.  */
>                         sctp_cmd_delete_tcb(commands, asoc);
>                         asoc =3D NULL;
> --
> 2.43.0
>

Acked-by: Xin Long <lucien.xin@gmail.com>

Note: I don't think the pre-existing issue reported in sashiko-gemini [1]
can be reproduced, as the SCTP GSO packet can never bundle a chunk after
SHUTDOWN_ACK.

[1] https://sashiko.dev/#/patchset/an-YYtoqw1QpTXUL%40v4bel
