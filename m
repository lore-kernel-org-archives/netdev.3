Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21151479881
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800232; cv=pass; b=HnNgsunOlFH6WlKUX5/WE6vDjRPmN09szRpnuT6hphzq7cuq5LbGhuXySK2qjxaR0opNnAI0pAEjRwP4RMjCC1djnCgvyWi7R45uuQYxZKhEBCQH1cCf9jr+vGE6kZJDQ/66RamXlQwPn/gZjEp+BEXlnDK2HdJjNeckMoAfdVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800232; c=relaxed/simple;
	bh=G8k5XV1SWWAdy+RGfAj3dXa4DNUX8KUBtzKy/T8o1zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtZnDZmAlzcP7RXTJr3O6r70SijGP58G5m4NhcbaNASI88Wy0ZmQq7AHhSszcwnixWLLWEeHefkafkB0IldF4SDO4blaKyoV1XnDgQUebr/wAOV7THzca6sYmxtXGvv+UzigDPEpbUOtbdfP3QsgFs7nIH15C0zbBEFooQQHvmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H18oGY2r; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H18oGY2r"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-8805988a200so3795827b3a.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790800230; cv=none;
        d=google.com; s=arc-20260327;
        b=HxhOgj23Sq0uW4/g68d2g9l8xQkYkIs+W+NGRVkrsXt1iwHsp5VAai5hCjKcUvO9xw
         5mzYaMCz6bLLPd/jY8YIyY9uD3hf2d0ClDnTRU2E12S+rNtcpsJ2QXzSHcJLwNZV+WuK
         cTQX2EJH6wskRlzQgp74H/1xqjlPRpVW1BGMX41wBkO22BAN7HCbTUGSUDAa5oI3OryK
         kNAVlymqYko6FP2KI4dPPU9rThpbRmlO6U8qONI+MFzEbFut9pDlrWvlnUGzm09FWMlB
         LvlCFxr38IjHpDh4b4malCMJ7xxo9dCzd6ozGvueblz3Jxlm2ep0zmA/DZizRsbIEA6D
         vAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CjbSFyqOnw6JPYqmCBCI/LQ67eLhGfYCrMua/TXCkJg=;
        fh=MQ2GFJrnECiPHr7pLI51UPvP3dVDdYhQqhSFsZDJt5o=;
        b=Y7FsuZprth9tLhRLDsU/3wq4iY23U+lWjmDsE0pvOqBL8NLjKK19YhGoTMNGRetzZ0
         oM3QxP4cG+JuR6dN3FDo0mFJOtO+gW8kLXsE3ZI+FkjATt2p7bqaL1TrmH3qi8l5KX1L
         HnyHVKpO1xu6hyKXxuppKO2yI44hxmNXonExHGbanrJFn5y3gZ5wOsXneOSZtwFYvPTY
         17B9runN65lL+wCxKhiHyr8uiZwyehP8VREmN0mLGnTXW2Y4tfHyrpQ0UQ0k/K4SW0OK
         92cD18Py6xGZl5gdywu5aBHYHzOUg1FeMxxH91Dbcdqnd0zpOb2o3D0D1Dp1fdUt0Xli
         I3VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790800230; x=1791405030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CjbSFyqOnw6JPYqmCBCI/LQ67eLhGfYCrMua/TXCkJg=;
        b=H18oGY2rxPaodBLCo9ETzXF3R2XFiNFXK98UaHZfb0IKrJYX1zkxKMjVHJbQg+emd6
         0YJf442E3GigFVZMI3MT5D34zVNRRsUpWo9B7KNi017F2dYP1e/QnKfWiG9AGLeYf8sZ
         zIIGb6CfQ5FsYiXdPCy1K0JLK9rsZWrx3t0sPE7Tyc7Bjps3I7aSCjBaYhyMCMMQs58f
         j/xST5BdqXp5kghHqS9xwPZp8V5CsUD7lJzq3mzA7xK1oQ+FpVmo326jqhgCMeyWpprM
         ErgnI81MOLSaiZ/OvEI0hg6TrLLK1jG+3dlb/XQJiz6pzyvRnLrk6kl5wUNukTyApxkP
         r5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790800230; x=1791405030;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CjbSFyqOnw6JPYqmCBCI/LQ67eLhGfYCrMua/TXCkJg=;
        b=RZDof3WJpXfLlQqm8T0An9vCcNwUukLtfGH6esTUtsS5J9tq9vM530H+heO2Ngq69D
         647+6394qWonrLFfhCS5GxYLS20uAiISExAS7na6ynsdQzzY6XO9iG3Ipy0YO9aPRR+v
         LuAqcejspQvvumhgYycLOAyKqIn/jGpmv0Vp1ThIptQ6XHw6TID0HgIEhi37Kx1dWkFb
         BtKrtbZi7UyBr1PY7UlU+m7snK7JtZZOUYK8PVZLh/gL5413fxI522LgTisr43rwrYg/
         3KytasVtef1p617/tDkjkmARL8xOvvWI1MGbDKcYYtbT+vQxZmDm7cjvjsdNv49Eyh3x
         Nxlw==
X-Forwarded-Encrypted: i=1; AKwUvBweh+ljKDlY/e8CcKQWTBj6RlF4ZHrwQ01V9yjqy3LUxCEQ6mdYVAl7FSC7U/qasnnWiWko354=@vger.kernel.org
X-Gm-Message-State: AFuF++mhvw/FU2Lvpe9SH9pWl6UuEPPjOo6TO5MDC1mRhawD/41D97ri
	67WNndSB4CQPeWxzERs6Dqg8dlwW/fTIijVRJk9HokAPRnULSaBo5OaTPQmAOyE7DtJEudySzjd
	Z9EFGPQ4ed/xURqWAjwsgk1sdasKqmi4=
X-Gm-Gg: AYBFou1HrhYIy+3l3x+ONiNIYQrWY2AT7rP7srLUaQWTAR8f9Gil8Ds7TY2gnBrHSZq
	1dbxxj7XZgJUMkQ/J/JdNiAOMgrDbV4u99bxFmJVj8/0TTGE7ZcWVjDFs1X+BQ7lJ2gSPz46Lbu
	fsxvagT0atHCmn11d8Mhi8Gm4YxcMdw0hvH0wUphm6ONi3Jzr+Tp4LnJEU55y7ckQNA6PhiBR7w
	MKAhI2b9M5yjkfQWpLTxdw/Cwfk1Gtz+AFeRRe3SNNJQ9xhE9jm/bq6AI1OB1ZPL9BXKEM1OBLv
	ewjMXHkoOZle2V+FMUxelXyQSoIiXg0bvIwMeJD1fLIkxEvCVzod7gWW+7hNd6K8K6X6VlMkYbt
	Br8IbHh9BkP3GyohrKahvQbJsy53/ly9ddcQCMmlIFOZ0sfl6tRGTWV29N8deiPSL
X-Received: by 2002:a05:6a00:14c2:b0:880:8fe8:a3ea with SMTP id
 d2e1a72fcca58-8874be0d724mr2061194b3a.45.1790800230179; Wed, 30 Sep 2026
 13:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926095606.68601-1-juny24602@gmail.com>
In-Reply-To: <20260926095606.68601-1-juny24602@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 30 Sep 2026 16:30:18 -0400
X-Gm-Features: AclHuK_OSjgLkfBVMNxA26PGQ3HWO34j9O67roB4yluK7AQb7eV-UK8ZIUS6bCo
Message-ID: <CADvbK_fU6+=ea87yFXk5HxT4-MQLuejH38Bq4wruP+2KfqY-vw@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: check RCV_SHUTDOWN after the sendmsg connect wait
To: Jun Yang <juny24602@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	Jun Yang <junvyyang@tencent.com>, stable@vger.kernel.org, 
	TencentOS Corvus AI <corvus@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 5:56=E2=80=AFAM Jun Yang <juny24602@gmail.com> wrot=
e:
>
> From: Jun Yang <junvyyang@tencent.com>
>
> sctp_wait_for_connect() drops the socket lock while it sleeps. An
> out-of-the-blue ABORT can then be processed from the socket backlog and
> unlink the association. If a concurrent shutdown(fd, SHUT_RD) sets
> RCV_SHUTDOWN, the waiter breaks with err =3D=3D 0 before checking
> asoc->base.dead. Its final sctp_association_put() can then free the
> association, leaving sctp_sendmsg_to_asoc() to continue with a dangling
> pointer.
>
> Check RCV_SHUTDOWN along with the wait error in sctp_sendmsg_to_asoc()
> before using the association again. The check only accesses the socket,
> so it needs no additional association reference. Return the existing
> -ESRCH so that sctp_sendmsg() skips freeing a new association that may
> already have been destroyed.
>
> Keep sctp_wait_for_connect() unchanged to preserve its behavior for the
> connect() caller.
>
> Fixes: 668c9beb9020 ("sctp: implement assign_number for sctp_stream_inter=
leave")
> Cc: stable@vger.kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Assisted-by: tencentos-corvus-ai:hy4-preview
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
> v3:
> - Check RCV_SHUTDOWN after the sendmsg connect wait, as suggested by
>   Xin Long, instead of taking an extra association reference and checking
>   asoc->base.dead.
> - Keep the shared wait helper unchanged and retain the -ESRCH error path.
> - Link to v2: https://lore.kernel.org/all/20260911090039.75646-1-juny2460=
2@gmail.com/
> - Review: https://lore.kernel.org/all/CADvbK_f=3DS-2waid_92PbOCh-LWjU5oiZ=
T+__xWfttVeTHEPQTg@mail.gmail.com/
>
> v2:
> - Leave sctp_wait_for_connect() unchanged to preserve connect() semantics=
.
> - Hold and validate the association in the sendmsg-only caller.
>
>  net/sctp/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index c7b9e325ec1c..4652fd90d9a6 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -1844,7 +1844,7 @@ static int sctp_sendmsg_to_asoc(struct sctp_associa=
tion *asoc,
>                 if (asoc->ep->intl_enable) {
>                         timeo =3D sock_sndtimeo(sk, 0);
>                         err =3D sctp_wait_for_connect(asoc, &timeo);
> -                       if (err) {
> +                       if (err || sk->sk_shutdown & RCV_SHUTDOWN) {
>                                 err =3D -ESRCH;
>                                 goto err;
>                         }
> --
> 2.54.0 (Apple Git-157)

Acked-by: Xin Long <lucien.xin@gmail.com>
