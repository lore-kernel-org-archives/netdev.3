Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17EB47DD48
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395224; cv=pass; b=A7NTATvQZnXhgbWr/u6Mm05lscDhUuByIGt8uzeKetsCi6dE9HoJRMio+kkNOs2BqctV9XoYbAhwgDxs1APMcHPE63JzqgHdt4n90zlegs0eWVuaiPHZmiVFCnSCAvE+/3mKPr/oyozoNI/Y7NmPVcQDFC8UW/zNIzHqQ1jJmJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395224; c=relaxed/simple;
	bh=MC56LfzMCt6fRP9BGhVtIAMB79iWC8di+yYNzRqau0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peTvaSQYKe2EFlWUYadOPFV4Oe/Pybr5FtMrk+EFXE6l6+oejTSteiKCBljL4IVqN0MHaSOXeMybCXf5V55T2dK3mXvzUTCUE7Hl/pJg7hHlDy55kWR0laVf4Hii8tvi/HNomrAxaZzuSP+DdPSQEyEjBL3SYLNFhbnnPFUJGrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXte80Yd; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXte80Yd"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e2254dso254675b3a.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789395222; cv=none;
        d=google.com; s=arc-20260327;
        b=LpCzp++3DKwjej8D53qRNz/G6AC7qwDLSUNvEBY0d+F2zAC3Ydw7rhZSA0kWuk2t6j
         wAZWIbgnw+pbIujLL/Jtc00vhetV6QThUxB2N1gXJ9UAZf8FcUYoGHd61JlUWN7dJFVt
         lNhtZnT//tfi1i7Z3DjapS3AJsw+5dDMgENwJiuCfZ/LBAkDw90a9aILusq3ySU5WABo
         48nxapivRxi0rOqsW5XtPgQ/uyQWn4OEiTYpfdl5Dnd/c9sxgYUF1P0YcDc3m2vxS0/1
         AaOLcskIOoHE4aTl+8APZmC8omjy5JBduS0q7WurnczPYBYzZ7RLVEExW4OXBDmY6fz9
         gRSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RiYN36uVRN3S+33iMVULloRHEVKnum5eOFw9VkWTBRk=;
        fh=AHMQGqa4UsrMZs3IWT94hrt1QPLYRG6gzCtCjfJFwZg=;
        b=QxQauaBrShMpfo+9yP1d4aMZJh3mrUbM+b3GoNDI0JspJA6AZRvi0Gn8rIQssVl1vX
         y4VdNYjemm3Y3RKbi7TXh9L7zIepuuaetfq7nGNPuUtiGrkFM6GkbD1nUICYcrP7awdH
         iaxe0KhEgxWIkbQmsvkMRPFKs13Q8M1bXEgGrqEJrivKIaRkT/WdbQraa9zfY7OFlkbO
         ybtzAaMsMr9cBVZ1ClkQpCVkSeoKSJJMCIvqfytGcXXWD5uMDo3+4TR70YIRC+Z7rJ5q
         atQ3GTFc8tBAwfYl2leNxl7y6eG5TSW0EuaPXzHEozNalpgpkAZnMxS5piNXrrUm68J6
         3TLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789395222; x=1790000022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RiYN36uVRN3S+33iMVULloRHEVKnum5eOFw9VkWTBRk=;
        b=SXte80YdEHZ3OPCjGDoakf31K+yp+wdg+qCiVQ7q90Mm+AtReQYjnYrlHgrI9tN/QZ
         FRkAU0om1GMBDJAbnIyqHZl+UU5vnWPvTBxIQRDg4FukHTw5mDhsalRkMoUsl06kLQ2p
         a6PpAGaID7QBtNJa+3cJ2Snj0Fxa0h4NsX5rWHORNN32u0bx9OcYfQkC6z54XQz3q640
         v1mgXr/7NJv2aPH9uP87sXOhkG9LrCzOcxQiBsJ1AsZMfPmdiyWOKDBFgEjlBmvz+8b6
         DbDh4labc9HBfqG3/baHbBInsZNFFTDkPV8xXSYowhaG4NL7eWIxZ3NiKqpLbttToUD9
         z3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789395222; x=1790000022;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RiYN36uVRN3S+33iMVULloRHEVKnum5eOFw9VkWTBRk=;
        b=SXOgeT+5QgPKEUzVqVAD85knz1qOzsLBaE9ptu+wK2rbfkmReIEINaOB/mjbH4J65U
         jLgq27sY94w0uGbXEN6qmsz2QPEuJdv9s8JQUM3VJC6nGSok+uNR1QLy2USL3/W4NAJ8
         T5VYDKSryI+bFsNzHDPnsueVyMk79Ihgvd2N6gl/nPmtCANbOPoLvxx9peIP/E3HWvYM
         ozcIiBMNOWoJd2VVZgwS9O/OJHM6X4zOG4+w/VsAVP/yNwj7Be9+3jzMHXkoJX+Czmlm
         pMlBxS1413kboRccnZFB08seaHrSO5XuzuYIOmWRgnZGc25y+kAVEyxFG/3Z5t2f8XpT
         QV5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzVdTM6Xz6+33A7ybohq5eKjYCldUVKqmG3u2mpchbCVzckNjvFLPv7Po7/1txXqTCT81iYnpU=@vger.kernel.org
X-Gm-Message-State: AFuF++lKjRhwqJTUDtmPbpq1DIEuZG//UQ/l0FxgedXH/hCoVlouIbek
	/LYmUzqIzYVk6bAmLAjVPZ5ieGZej459ytpF2Gw62S3kfdShQhZ5WHhRES0HyoBEqJayh41frfj
	HJFhhVFWSHpibJhsvg0Qa3dm/qMtWjlU=
X-Gm-Gg: AYBFou3ejhi+qUwEhdE0DBEgpf6UY3nKlQq3RA3BsU8x+2YPk0e8PLPnhjaoJK3JTL/
	5GiDrZHUO3b6qe3nqynEwoF3hzk6SGO5ZuGvHVococp+gnjnkUvv9FHCJNm9sG3faoi8xRfUpRY
	nLZ0fyG7UCTOYTtRXnL5CRdgo6JEJ8UU+oo+sh/3d0juPUIpW1Qexmwp1oyORxWj7fD+s6pTOug
	i3lJWa6iHxR8EIVSIhCGaLa3clykcEcKjuDvH5LCfnIcAAbuIzE4LKDWIVcrYnFF8fDw2NRtp96
	TRTZdZa5J4WPB0y1BQoyp/yiH2vvXwIhd8Si/yVNruDz6FUDtN+RqXzdgGPZ/1spwIcIevA365f
	fxBBG5jIfv5BI4bed7LYLCq306pZzxX1+m5m8jfH0FERnunG3GWPMvA==
X-Received: by 2002:a05:6a00:98e:b0:869:4ab2:8e with SMTP id
 d2e1a72fcca58-86f93cc125emr3520459b3a.7.1789395222076; Mon, 14 Sep 2026
 07:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911090039.75646-1-juny24602@gmail.com>
In-Reply-To: <20260911090039.75646-1-juny24602@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 14 Sep 2026 10:13:30 -0400
X-Gm-Features: AcwNN1Vj8GzyWsGKCy4gSL-vBNjPpWPKXvnEtKLMrlOakSBuY2Unq606Yu3xBrE
Message-ID: <CADvbK_f=S-2waid_92PbOCh-LWjU5oiZT+__xWfttVeTHEPQTg@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: keep the association alive across the
 sendmsg connect wait
To: Jun Yang <juny24602@gmail.com>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	Jun Yang <junvyyang@tencent.com>, stable@vger.kernel.org, 
	TencentOS Corvus AI <corvus@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 5:00=E2=80=AFAM Jun Yang <juny24602@gmail.com> wrot=
e:
>
> From: Jun Yang <junvyyang@tencent.com>
>
> sctp_wait_for_connect() drops the socket lock while it sleeps.  An
> out-of-the-blue ABORT can then be processed from the socket backlog and
> unlink the association.  If a concurrent shutdown(fd, SHUT_RD)
> sets RCV_SHUTDOWN, the waiter breaks with err =3D=3D 0.  Its final put ca=
n
> then free the association.  sctp_sendmsg_to_asoc() consequently continues
> with a dangling pointer.
>
> An earlier version moved the asoc->base.dead check ahead of the
> RCV_SHUTDOWN break in sctp_wait_for_connect().  That changes behavior for
> the connect() caller of the shared wait helper and reportedly breaks SCTP
> selftests.
>
> Keep the change local to the vulnerable sendmsg caller instead.  Hold an
> extra association reference across sctp_wait_for_connect(), sample
> base.dead while the socket lock is still held, and only then drop the ext=
ra
> reference.  Reject either a wait error or a dead association with the
> existing -ESRCH result.  The extra reference prevents the waiter's
> final put from freeing the object before the check, while the socket lock
> prevents a new teardown between the check and the following send path.
>
> Fixes: 668c9beb9020 ("sctp: implement assign_number for sctp_stream_inter=
leave")
> Cc: stable@vger.kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Assisted-by: tencentos-corvus-ai:hy4-preview
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
> v2:
> - Leave sctp_wait_for_connect() unchanged to preserve connect() semantics=
.
> - Hold and validate the association in the sendmsg-only caller.
> - Run the in-tree SCTP VRF selftest and the original reproducer.
>
>  net/sctp/socket.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index c7b9e325e..09fd6b951 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -1842,9 +1842,14 @@ static int sctp_sendmsg_to_asoc(struct sctp_associ=
ation *asoc,
>                         goto err;
>
>                 if (asoc->ep->intl_enable) {
> +                       bool dead;
> +
>                         timeo =3D sock_sndtimeo(sk, 0);
> +                       sctp_association_hold(asoc);
>                         err =3D sctp_wait_for_connect(asoc, &timeo);
> -                       if (err) {
> +                       dead =3D asoc->base.dead;
> +                       sctp_association_put(asoc);
> +                       if (err || dead) {
>                                 err =3D -ESRCH;
>                                 goto err;
>                         }
Adding another asoc hold doesn't look nice. Could you try fixing it by
adding sk->sk_shutdown & RCV_SHUTDOWN to this error check, like:

                        err =3D sctp_wait_for_connect(asoc, &timeo);
                        if (err || sk->sk_shutdown & RCV_SHUTDOWN) {
                                err =3D -ESRCH;
                                goto err;
                        }

Thanks.
