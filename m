Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BED1E51E0
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300480; cv=pass; b=tCJtIwhdoKvjayigOB77/Dwcn4HF2YhHMD7hvZlEcijyOFIABZ/ynBuNxhgX6/QCJkmEFdXb9DbDOg9iKSmOCqdWY+NHt1ZWB3Bz0gok0KFlUEFYjha/356uXcp5Fjalw37Avi8UViCGz/4fl+i/EShHRivbJSTpfhbBxvVHA5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300480; c=relaxed/simple;
	bh=EkG1bxatn03zKIN7M3Vbx6z4AVQ88IDTFkdJVDxKZ18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQnD95dBp9KGn6YrdgxH2ZKQKQBYgRMT22wZ7Z80LsE0Bov5k9irRZvubrpJ9Oa4HxdozGDieIfwRX44nYYY1sV6ma+wfXi/lCM0xXOldUMUIBE8g+kAMgrQl/7ypAs3mIms5OSHPCDdJhpU/W0oFRVgOO4eXc6ich26MG8bU88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qWjdQyiN; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWjdQyiN"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8484f229529so3328225b3a.2
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 08:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784300478; cv=none;
        d=google.com; s=arc-20260327;
        b=DYZqLqacwasYzRmNecTmDhIGFwQCTDu39uvx01RWdGOwgzkAyWQIyeo0aQLYXXp9Or
         RDVHKibZbaBiGLGwFmTPwkYWqtHvUJkQCqbzfAMhxO5qqcNicvZvZmgbYTKR+jL56FnP
         p9Y+qI31ufTkXK89iGTG04C95weExbStdV9LazjY5ecx/zNwxSqcnFx0SsN7qiz6f7hu
         W1YPv4vppA3cJe+0OzknNY/3f7znx4J02XY7k9uswyF0rMe104yD2iHoQ8Shh7c4A8Px
         ZDmKwrNs6Z9O6g0aBlNnvVV8KMkuEth93R2gY7WBmbsw2vl30u6Ttk0t7CQkogzcih12
         losw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kn9JGcmwjXESSDo9043jlkisjjlqhE7Oa6B40ZDHtWo=;
        fh=lA4ha2y0b2QFviJI59z3bGsw8YlbLbUg20KXlpLjvWI=;
        b=fB7MCKhalaPVFyAnhLkyNxrXOOm5+ktdnJB2bjvG+yYsc7JPiTL8MwrlrAs4lHVI0U
         MH52O5aP0bXMTBhc0JoEZPXsspkbEe62I0dXZDMyM+FB8zITfVEGxmI72WgGZfw7QgrD
         S1uBOF4wi+2pzBXt9RXzrPWsdHk16SNZnfo7QbTqwj02hNzwCx3R3iunNMcIE8uJjc48
         4NyF8MRoG5fA+Xbmzacd9PoilF/b2PeCO/tDgwmniP12MG4BUHW1LusDLqttSguKAhSi
         yhBjC7d4psyFegUd2UnXn2BNL4vN9ts/WViOPXhThwoSS0N/xxarksptNmGbXua7TLWm
         Hqiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300478; x=1784905278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kn9JGcmwjXESSDo9043jlkisjjlqhE7Oa6B40ZDHtWo=;
        b=qWjdQyiNdK9zl4ziC1bcwx14ff9qFSwcB23vT5768NTntx2vYzXsia9sZEQ+KOx7yO
         acgkvVkD7o1Gq+1wxgrdmUtBHSVKjCvc4OWrtXn/k2pmhwSsJtS//ssMaXFEaTSeswrt
         ElmWStj+8VTHrmr6kZKN3MpXOOTyFSyfvU743iepXzLpTvAklCMYYG/QkxqdoKJsrA3q
         YtBZG+L8H3taJIrO169xZK3ZsnOY+xsoyEXVDsGVZKK0gaHfMlKhZg2Md++eVHL0NuPv
         j6OugTbCt/PFMLtp6ucL5cOWlvAEjOm8fQZjZJ1jnOuUqDBY3W7GwaO1X5bWNozihzau
         42Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300478; x=1784905278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kn9JGcmwjXESSDo9043jlkisjjlqhE7Oa6B40ZDHtWo=;
        b=Xjt10bW5/bEQrRGWba1AqN+OTHTqj2rIk4PJOfLmA+MgEpKpZceQnXzSJrQt2tIUXl
         mCrXzJf6tIbJiOSkf9rHxs1th2bC8NhnHLtBVMHDQrlieefDsz5Zy+qz8dPYE80l4C5K
         3h24zIB4A10QPQIAr0H4IwMgJC/hzMfrbSGNT4Yc+AhVYnt3AFHvSolpghKsalV/oT6K
         48st5KCf/v2p95sXuRMTxz+TQaGtcGt+H2/5QsRkcNb6u0cP6z7JnZT2Myc49n6Av7wi
         zk5hJcySTUmMIaNqJMK5lDwQNEe3PjJKGHzTZDwLjUqbDKeTpWRhts6CXLogofDDy+nI
         bxTg==
X-Forwarded-Encrypted: i=1; AHgh+RoC/vtylrsZTtT1nmZKPYkdnH0BSAz6vtcndtOS0iNTq1c4SXVD/CxRa+0yg4n1t2srRnZetKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWemAE0V2EqDFFBvWPTL+rfiLp05vuFKehXXbt/mWykhgiD00C
	FFs7sm5t6hw23XCJc/Jmbmxbyu87AX3e/dVR47FYRTD8n+VQQC6IXpBhDd2joyB+NwlybazOHQv
	elEn/tJ8JzXAgVEOHukxC9CRckd6sncU=
X-Gm-Gg: AfdE7ckF/e3ob3/9wWjAliY0XfhwRLt5F2Xf0rzUDZzs88Mk7mERdx6MVHyiNmWA0S+
	e333oZ+9eZNeolZC55v01hgXmBkTq/t15oTwSsZRwsB8ToWES14Od/KBuChrbNs6oJuwxSDXK3k
	rcZnkliJf6uRYXkGJwDJYBb6h9rYuO0EGiboTDfCpjEiXoNLrTrQzILWGu+3fHFrKnYIbucX7wz
	byHlMhdktsX5L3q9b3adaiDSeXue8hNaqmWrWmuYU0qYXQqG/4qGNURLwaLlfNRmtxeByEa70yq
	qSkq8m/srDK18E99TsIUrD0v4i7VfoujaM4QvAyNb6uzMXyon4Upb2R/MNXbFGs=
X-Received: by 2002:a05:6a00:c96:b0:848:4080:afe8 with SMTP id
 d2e1a72fcca58-84c292736e8mr3337468b3a.22.1784300476797; Fri, 17 Jul 2026
 08:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716100407.1490724-1-l1138897701@163.com> <20260716100407.1490724-2-l1138897701@163.com>
In-Reply-To: <20260716100407.1490724-2-l1138897701@163.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 17 Jul 2026 11:01:03 -0400
X-Gm-Features: AUfX_mwQBr_0uroSgnb1cleNIWGMZc0ijXUtBVwhjK2_z4LEEEFBBUYjA1Elz0c
Message-ID: <CADvbK_fxLnyyx7kuuHr3_Vu9Wp9AenxAZYM7rO5kDwR=eXjd3w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: sctp: auth: Fix safety issue when skb_clone
 fails in auth_chunk handling
To: luoqing <l1138897701@163.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luoqing@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 6:05=E2=80=AFAM luoqing <l1138897701@163.com> wrote=
:
>
> From: luoqing <luoqing@kylinos.cn>
>
> When processing AUTH + COOKIE-ECHO packets, if skb_clone fails due to
> memory pressure, chunk->auth_chunk is set to NULL but chunk->auth is
> still set to 1. This causes sctp_auth_chunk_verify to skip the AUTH
> validation (since auth_chunk is NULL), allowing unauthenticated
> COOKIE-ECHO packets to be accepted.
>
> Fix this by only setting chunk->auth =3D 1 when skb_clone succeeds.
>
> Fixes: 59d8d4434f429b ("sctp: delay the authentication for the duplicated=
 cookie-echo chunk")
>
> Signed-off-by: luoqing <luoqing@kylinos.cn>
> ---
>  net/sctp/associola.c   | 3 ++-
>  net/sctp/endpointola.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> index 62d3cc155809..e54068305396 100644
> --- a/net/sctp/associola.c
> +++ b/net/sctp/associola.c
> @@ -999,7 +999,8 @@ static void sctp_assoc_bh_rcv(struct work_struct *wor=
k)
>                         if (next_hdr->type =3D=3D SCTP_CID_COOKIE_ECHO) {
>                                 chunk->auth_chunk =3D skb_clone(chunk->sk=
b,
>                                                               GFP_ATOMIC)=
;
> -                               chunk->auth =3D 1;
> +                               if (chunk->auth_chunk)
> +                                       chunk->auth =3D 1;
>                                 continue;
>                         }
>                 }
> diff --git a/net/sctp/endpointola.c b/net/sctp/endpointola.c
> index dfb1719275db..3419748c66bc 100644
> --- a/net/sctp/endpointola.c
> +++ b/net/sctp/endpointola.c
> @@ -368,7 +368,8 @@ static void sctp_endpoint_bh_rcv(struct work_struct *=
work)
>                         if (next_hdr->type =3D=3D SCTP_CID_COOKIE_ECHO) {
>                                 chunk->auth_chunk =3D skb_clone(chunk->sk=
b,
>                                                                 GFP_ATOMI=
C);
> -                               chunk->auth =3D 1;
> +                               if (chunk->auth_chunk)
> +                                       chunk->auth =3D 1;
>                                 continue;
>                         }
>                 }
> --
> 2.25.1
>
The patch does not fully address the issues reported by Sashiko in the
following two cases (I will interpret them below):

1. [sashiko-gemini]:

When skb_clone() fails, chunk->auth_chunk is set to NULL and chunk->auth
remains 0. In this case, the chunk will be dropped/skipped in
sctp_assoc_bh_rcv() by the following check:

        if (sctp_auth_recv_cid(subtype.chunk, asoc) && !chunk->auth)
                continue;

This works as expected because the chunk is skipped. However, in
sctp_endpoint_bh_rcv(), asoc is NULL for new connections, so the above
condition is always false. As a result, the COOKIE-ECHO chunk can still be
processed with chunk->auth_chunk =3D=3D NULL.

2. [sashiko-claude]:

When the association requires authentication for the COOKIE-ECHO chunk, but
the packet does not contain an AUTH chunk, skb_clone() is never called and
chunk->auth_chunk remains NULL. Since the new association is also NULL in
sctp_endpoint_bh_rcv(), the check above cannot catch this case either. The
COOKIE-ECHO chunk will still be processed with chunk->auth_chunk =3D=3D NUL=
L.

A better fix would be:

Add a check in sctp_auth_chunk_verify() at the point where the COOKIE-ECHO
chunk is actually being processed:


        if (!chunk->auth_chunk)
                return !sctp_auth_recv_cid(chunk->chunk_hdr->type, asoc);

This ensures that if chunk->auth_chunk is missing while authentication is
required for the COOKIE-ECHO chunk, the verification fails and the chunk is
dropped. Otherwise, when authentication is not required, processing can
continue normally.

Please give it a try.

Thanks.
