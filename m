Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794577741;
	b=Q+4H/kw+fCmIg6dLxVcXB63vAP9sL83ifPf8W39PMI8p7RgcldP7dBCyvkoQhnP6Pwng
	 ocIr8q7xxJ8M45C59o+USzCxnPF5Fngr0moG3hvCrBREC4Bn1RLPYCiQAfTk08iXzcw2N
	 CHbq7MnsJ3m/4yhNWr6SFAEOAbCSuPo1ostXRBCRBuo5RBmQfyJB2w4tRKIF2hTy+FDhW
	 vEvffJAkZeeW08JwiSHLRQn0CF7AlaVFhDz//toEAmoxubHGd2U71OavDuWM3pV9/eg/X
	 MSd1qfSxCJvxFb0KQEmHqHpfXpCg7VqLWaeZxQEReE3VZv80lVtWI8rLzyA5GNPxIwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1bhPViXt1pRD/+G0cozJg3X1gM1h4MG3wea7XTuXsrc=;
	b=R52fuOLhIpw+comtT4BEOMrwP6XbKtwYCBPucQO+gl4yvnq7ZHg80VR5OUYJvs+WygJY
	 dbdHMd5LTvM7TQIrCZbJCFmi2K/36Inv+LQa1X4HOw7YZeAmwc/X0RcwG3pQf65k6xykd
	 gyjh1+dqBqQFHXttI6HBOZSA58PtPpKQ8fpKNkE2987LxzepRU7dZM5paH4XgtY2PCSwY
	 uOjfVb2jCPBaX9hRY5r1oSeqh2SqXL/ZDV078/pww32LU1AqFaYho0XdjYSvVBPHBy1JO
	 fYa691UELwn8GJMb8xKyvmGsAwHJ+tb6UEh46O8dHCzMwdXOq0za8hFDRfdYeXYcekQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDaBJi6E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230B1606A336
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 230B1606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDaBJi6E
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a0673d9bd2so1120872b3a.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 05:49:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794577739; cv=none;
        d=google.com; s=arc-20260327;
        b=P22ifpF4qV3m/CGbqoiCQUAHYEEChg2n1JkpJV8fmY29Ag1qEWSuZMHWVlP9kzyPbD
         QjLiOcQvqah+uPhrTZkYK4fEsW8EeVvfUy32W4dmGfYqzGCO6MSQ2oZFe/e3nYZKOewE
         5Rq5O9JAe5Mip4UdfsLaQSmnggruUznU7nz1JkRTyVCCw7ckJBBveyRgYuemy3VP2fi6
         M3Uh83/vKpCtMhWgpXHoXgLnNdtpql6Grsr6Uhl4uYJfklgmWmitSnHEiG1+yjMV1hmY
         ki9T3q+SjH4oOC//lieWqBE4+Xet7GABC9SVpX8acPu7pTU/gwBHmi+wkbw4aTARfshC
         qVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1bhPViXt1pRD/+G0cozJg3X1gM1h4MG3wea7XTuXsrc=;
        fh=2gwJAY0GkT5IUI1X6Et2jXWJJQwj2Xi7H2HZBlq5Yvk=;
        b=hQq7hs5AWnpxSe5PYbvsGhagdE53V8NIATfhDMc6WW+Hg5iBDfpbvJs+fsqk+IDOuv
         skZq+nnWarVbzMEBppvXBzrl0r96nGUYs+z9vTfULAAz/GNBZiBPPYtXkS+EY4I+vlbb
         9lelQ4XLvjXMXPFlYqtyqa0CkHWfPGIAGAtwJbM6vTXfHG1R1viOkiYHoDDRDPgQ2YWH
         Gpe3MmoAflP5iCxnBsT5yV9fZBD1qsJ9+kH5GbS841Pfw+nYI5gP1KT0KBqZaz5lqPN9
         fOiDlkLbzsvEaDGbBeMi7gNClKtZWxGvTeu9mwdS4YZ0zUkwjWaVe8OMbpngXa9KJbU8
         r+2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794577739; x=1795182539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1bhPViXt1pRD/+G0cozJg3X1gM1h4MG3wea7XTuXsrc=;
        b=IDaBJi6EnzYWBbfLMiIPr0Hr9fUbFucDOD5m0rjktHtv4g65mORdut5ERKbwL3+WdB
         Ebh98AmvbnRMDB5UNnyQWh0hqd6x9Lv/vmnaDNCw0JqxFBUeoDpXKz4lTndlo/XHrvpi
         N/I7ww+bA3R+GVpMMfkFGheCSAaZ/BG1iIfgs8r+xIG0umJ8Q2Mmh1VpTOBS07jjZqTz
         nAJgyVzCIyaklyNxiek0OKHskIrA+FjsbNJgYwzHgxK7+Wl8x/c1WAVZPZpkcAVL+/sS
         xZLCb4uuHJ40hxymUgOM3U1c328PfYaV0Nj9Q5mB0ZEffdzBeJ/uyt01pd2SwV5StXSr
         l6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577739; x=1795182539;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1bhPViXt1pRD/+G0cozJg3X1gM1h4MG3wea7XTuXsrc=;
        b=eeQoNcrZwoiX9PhXRpKicn8brkN3NNQF5MaCm9eGwGNMnI75/zN7OEPVM2kv6R4bso
         SkmW1WodySUozqu7A9SHP9LyRHrgp+5Orqz72bEPWvYxFB/byedxtnegmkyzOgVjdlVn
         WrxZlP/72JVF4VG7MjSWhWROpRdWlXwPexoBGUri9jhgfqOXHysH6yxNJpAOEB2ve180
         t/N2SvUjAcaVyLfNzpOGDd+7spVhJgtZ4TxM+FCuQeY4wWNlOzLyNsmWeOHcmjblU9rP
         buVd2DhSLw+HqDRzR+i/YtV8J55zuWSggfXlvYpXkdZLPbwbn23qabjAwFWbDELpWskB
         hLGg==
X-Forwarded-Encrypted: i=1; AL+hErGeMp2f7Fo0NpoVDc9i8K5Owvar3utDB/IaauWS5ajkz78512xTHPkCaSGQrss9tB6U6K/JLew=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mOn3eulG+Vw1PmDVV1peQw3+jgTq8+6tlfMRbU5/b/FOs0o51
	3OzIMPjyYyCvgve9n7I1Qlb6XGFSI4FhuKl0QFjYPawRxJGuD7ckPmP+N1c9KSyYpPQye6e3cDM
	xxr/CD7xh8M84DYGjjiMXr6uaz7oNVJiUmW0tBrs=
X-Gm-Gg: AYBFou08vtOlYcw4/y7G7fI0hA8ghpjqjSYb0n3oyYSJYm5oRw5YvVOAALz2eUcXjwM
	051Zq3aerX6lEt5949Qn02KoMjOXsCxA3vct/m70MDezLrhsem0pkA5ivxxRbPPQ5+CLhDiZDBf
	n9R5b643KwtO9rNReXtniP9s1kCYZsgJyPKD6odkc0lWOC8POIyEkXkwqsRtTaAhPkXqBdxbKkT
	Hor4tk+A+Lu05Q8F0WEUwZdG/BcPuZfikJC42E5VB9v527XYHsp4i9PmujyqI7JoHtGS81ese8q
	Osj+4KNGeoE1dwXG7dkLHOtz9ran4s28EJNPFEuowgX+nOImub4SLW3yFUKpNLM8Ubk+ldpZJOG
	iyBKO6aWVuT8gvzliWRwa2381bhKyVRwnyZxPtWRpd4W79KNCcpTXmsD7v81eW+u93sXMNXM1OM
	tfXN9JUmPkLXrq8xjxz/eQ94dXA5847v1jJQNPUITS9XAkALDs1L5ZYEPB
X-Received: by 2002:a05:6a00:893:b0:8bb:1b05:dd39 with SMTP id
 d2e1a72fcca58-8beb58bcc45mr2934303b3a.11.1794577739414; Fri, 13 Nov 2026
 05:48:59 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112172149.27355-1-yves.bieri@theori.io>
In-Reply-To: <20261112172149.27355-1-yves.bieri@theori.io>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 13 Nov 2026 08:48:47 -0500
X-Gm-Features: AclHuK8PfN4ou0sIEU-hFGhRyxEEh94jLa5NJ3yVhQe-fdSo_K9CA5s6bPZ98fo
Message-ID: <CADvbK_cetnuX7=VDEh9hE4db3BdYWr9es28jVorMXOQsTfrxGQ@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: do not free a new asoc peeled off while
 sendmsg slept
To: Yves Bieri <yves.bieri@theori.io>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 12:21=E2=80=AFPM Yves Bieri <yves.bieri@theori.io> =
wrote:
>
> When sctp_sendmsg() creates a new association and sending on it fails
> with anything but -ESRCH, it frees the association. The send can
> sleep in sctp_wait_for_sndbuf(), which releases the socket lock, and
> meanwhile another thread can peel the new association off to a new
> socket. The wait then returns -EPIPE, and sctp_sendmsg() frees an
> association that now belongs to the peeled-off socket, without holding
> that socket's lock.
>
> If the peeled-off socket frees the association first, e.g. on close(),
> sctp_sendmsg() frees it a second time. Otherwise a syscall running
> concurrently on the peeled-off socket can use it after sctp_sendmsg()
> freed it. Both are reachable by an unprivileged user. The double free
> on net with KASAN:
>
>   BUG: KASAN: double-free in sctp_tsnmap_free+0x5c/0x80
>    sctp_association_free+0x1eb/0x750
>    sctp_sendmsg+0x15ff/0x2020
>   Freed by task 836:
>    sctp_association_free+0x1eb/0x750
>    sctp_primitive_ABORT+0x85/0xe0
>    sctp_close+0x22a/0x8d0
>
> Commit dfcb9f4f99f1 ("sctp: deny peeloff operation on asocs with threads
> sleeping on it") fixed this double free by denying the peeloff.
> Commit cea0cc80a677 ("sctp: use the right sk after waking up from
> wait_buf sleep") replaced that check, and commit a0ff660058b8 ("sctp:
> return error if the asoc has been peeled off in sctp_wait_for_sndbuf")
> reverted it to return -EPIPE, without restoring the check.
>
> Fix this by holding a reference on the new association while sending
> on it, and by freeing it on error only if this socket still owns it.
> asoc->base.sk only changes in sctp_sock_migrate(), which runs with this
> socket locked, so the ownership check is stable. The reference keeps
> the check safe if the new owner frees the association meanwhile.
> Userspace still gets -EPIPE, and the association stays with the socket
> it was peeled off to.
>
> This was found by Xint Code, an AI code review agent, and reproduced as
> an unprivileged user on net with KASAN (trace above), without modifying
> the kernel or using error injection. With this patch the sender gets
> -EPIPE and the association keeps working on the peeled-off socket.
> Without a peeloff, a failed send that created the association (EAGAIN,
> EINTR) still frees it, and a peer ABORT while the sender sleeps still
> frees it exactly once. The SCTP selftest sctp_vrf.sh passes. The
> reproducer is available on request.
>
> Fixes: a0ff660058b8 ("sctp: return error if the asoc has been peeled off =
in sctp_wait_for_sndbuf")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yves Bieri <yves.bieri@theori.io>
> ---
> v2:
>   - move the hold to right after the association is created (Xin Long)
> v1: https://lore.kernel.org/netdev/20261110224233.82977-1-yves.bieri@theo=
ri.io/
>
> Tested on net at b71c101bbb98.
>
> The fix and this message were drafted with Claude, and reviewed and
> tested by me.
>
>  net/sctp/socket.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index b5a57f6..6ed184e 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -2063,6 +2063,11 @@ static int sctp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t msg_len)
>
>                         asoc =3D transport->asoc;
>                         new =3D true;
> +                       /* sctp_sendmsg_to_asoc() may release the socket =
lock,
> +                        * and the new asoc can be peeled off meanwhile. =
 Hold
> +                        * it, and free it on error only if sk still owns=
 it.
> +                        */
> +                       sctp_association_hold(asoc);
>                 }
>
>                 if (!sctp_style(sk, TCP) && !(sflags & SCTP_ADDR_OVER))
> @@ -2084,8 +2089,11 @@ static int sctp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t msg_len)
>
>         /* Send msg to the asoc */
>         err =3D sctp_sendmsg_to_asoc(asoc, msg, msg_len, transport, sinfo=
);
> -       if (err < 0 && err !=3D -ESRCH && new)
> -               sctp_association_free(asoc);
> +       if (new) {
> +               if (err < 0 && err !=3D -ESRCH && asoc->base.sk =3D=3D sk=
)
> +                       sctp_association_free(asoc);
> +               sctp_association_put(asoc);
> +       }
>
>  out_unlock:
>         release_sock(sk);
>
> base-commit: b71c101bbb9814d163c00234d43c41f0a17907d4
> --
> 2.43.0

Acked-by: Xin Long <lucien.xin@gmail.com>
