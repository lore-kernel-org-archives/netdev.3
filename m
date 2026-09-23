Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F335C4854E6
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159090; cv=pass; b=kPKCHnk2bHUBiQpwQRw7/e4z7UIbXNHbgncWAxOipeM2OTK6RmptxiAZhMKypZwz2aAEhjjvrnZ256Xy4MPI6EwY3G4VJjpGZXMPKFsKPHHE18RP4nrqV84xfQ5fCwmF/v2ZbcTs5L4mRO+jwvkZHIzajbp9C6s4wK6vIzWA/o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159090; c=relaxed/simple;
	bh=YU9M6lNB1ZyLCMAXQr0VzfJfxQQzH5Vll7bn07q18eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zos+Cq/HijTGgt60r+Tusu/z5A3pziLDwH0mwwvtyqa/cCHg+LU0uQvne6ydAiXJkAlSp3lgi+ij43UPdzp34Lv1Mewarz1BUuKbKkTgz2ASLfI63sb2SxLJwFdCAYr7kHAjmnYCcdGiwbnxTOZkWl6yXBsqmDMFLyA0Ln5npwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BGKrGhm5; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BGKrGhm5"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-53122c5bbb4so8770311cf.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 03:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790159073; cv=none;
        d=google.com; s=arc-20260327;
        b=WwJSctUvVyz1bI7qGA64wGDqIQqO8GcXWEfOELOFTCfv7AWUMTBxzoSTGkcT4yvCNN
         mAwTjhKK6QFg8QHTVJJTnu83MFNbVUgH929WNd+PR5alYHfLRDF//cJ1f+i0yGXwkEw/
         DTsT5ID+eDVljIgb36Q8pif6GBiiiFPYQW3fkhmasbfKEHCTvyASnEBgRefn9Vp8hblU
         utsvW4FKW0WEq29U1fHb1R0fILIQA4XfjvqkxLPRz4llTszlmyhCciwir0QZ6en34jGD
         0bqLpkF6pVwutSgOzSq+nld/GkpxeU+kXGn33/zppMu5PUk7podi0N0szVHKRA8uh/FT
         75fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3/9GamQb14FQdww9YB29iD9TGuTQWlceV4HeR/O69Gg=;
        fh=e7ClpZAt7LjWHn7o5jM5EAaNBX/vjHhJsYSjusddMq8=;
        b=rRYp0qmAVL/Tpn+57moZi+IK7x1JW9zyuXxvXJ9YDDY/zz4SE5BMMSKJyAd9tNVqeq
         ddMeKlte5f+dGhakVR5TiEhZeo7Kqh2n4y/FGmg9pffb0kPV/jqsPASDdjera4xGEHax
         t6qZB92jnOmSR6nEkN+KWaB4ofGYjZ2ZeCGFwM0gE1l5+h97h4IsPg8Q7/ElbID6HS7k
         fUbuTVIMk4n65exYFyUPtoSswpUxcxEQQsQoT3WmqrMB2Z5JC9QgXeD3UL+ZtoQpPJBw
         gpor2vFD6YNb+LsaomOYs1S4ytuTLejxCusmrMsUvp5mO6Fk0hPlqr04P3Ha3TW+gZ4y
         plng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790159073; x=1790763873; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3/9GamQb14FQdww9YB29iD9TGuTQWlceV4HeR/O69Gg=;
        b=BGKrGhm5Eln2f+cvu3+JF2ww7UueTjhQD/lklIcyZkC8FTHn+uPirB4X/hWxhqVmTP
         baUaSszRiASLwa8tb/bA7jMxTwqcoEwcYNLffDa1D7vcOzpjt10s9Itj3TgAvY6SgcjS
         vQYnR5IXHZAkaUjjKIS4bL66N08V7nhyDcnC5CVifFqkBKrHYQ5GrWyFaMBH2EoN7rBM
         C/AQDOliW9YzpSA8PevAoI3tI9TLvRQYfLhfgDBH1p+boVLl4ddE+2ofS/pYOEP9ssVH
         n7zVxjmDMFfbGnjPF1zpMryj6cEKh3DhkDcxoZWwwcEgJuhYXnMwL2byst7BbOskZtSg
         Ay0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790159073; x=1790763873;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3/9GamQb14FQdww9YB29iD9TGuTQWlceV4HeR/O69Gg=;
        b=tXPAGms9qRv/PCocSUWq0lRhvuIvaecP6k4rf5rQoB6v0SOsmcySLzOwHzydMpNw+T
         n/q4d1tvcHH2CxyMcizsG2nydxjb8Z7E9U04fvw1YbBmKciLvJN8ivYXNyvwWM0qiVag
         35M3AFrLU5a9HkcjuDF498+cO4b4ic92QZY2XkTPXGBRWsmaTFFtm2+N/n7GWsqIvy1t
         ht5q1VvlTA2JIYe5q945cE8Q8NugDPxKLs8M6YUmnu3LrOP5zTWOVG2FqJatNsebt9oC
         X2WsKVNtb446PPF1QemwSpw37yetowb8RFsKeugO39LICxAq0sOIfm4JkpwdSA8hKWCr
         H86w==
X-Gm-Message-State: AFuF++kPw287kXlKvhvlkmUAQ4Xzokdac09YDbVzU3qR1dpKeBd+y5Ia
	E7FC2CFNDE5ed+ZPgsAGn3+jna9gF+W/4UGpFX8wn72GWI+kMin5xu/0MLfgrrrgPUkgmY0WB+1
	50jDGDqZhw6nRy12Bc11G608HsQDrhj28whzUmGgz
X-Gm-Gg: AYBFou1wsyckSIm2QM5LOFmlJ3t+3s+u4iMI3GvjhCC9xKDKIOsmaFDNW2lxt26GFQy
	mFWx8NB2ecFYfag8jlfRNOrllUUUcek/CAQFRcsDddzRzn58fmUzHHKHeyGmOdWItwebcNqLC3v
	B89PK2jqCjHtxrVkfEtsvSXNhAWcmeBL30NL3tmT3OJ0YLS7MaY9wbl9u2bRCQ9wIdGqBWno17i
	MazK97nc9O3Q1R1tzkaIM/rzm+Yr57KPRkhLCZUBdT2Cw6yoRZpHp8F+Nf3NBRs9EBmKjbTy7wR
	dqn6cHs5ILyBEKfajHQLZyoqyP2mkcRtiyz7fomaad+BEi5E+OEF0gZepjy3YC97FE3JJWHJIHf
	Fntt1tNOh/yRfC+/1nTy/Jss3nx9CRM+QAC7ZEEpiTxOkehzxNQCRvpDxlPOJ3TCcGu6XosiFeh
	xoTOE=
X-Received: by 2002:a05:622a:4016:b0:52f:c0f4:8 with SMTP id
 d75a77b69052e-532eadccdf0mr33028271cf.40.1790159072657; Wed, 23 Sep 2026
 03:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923060547.118748-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260923060547.118748-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Sep 2026 12:24:21 +0200
X-Gm-Features: AcwNN1VNbaaMdh7EQrEDuWI6gfonqDQtcuBO60MQ7CxDiug3yN7KPVmA2XQ4Yz0
Message-ID: <CANn89iKHH1s+kXqBXVKmDxmELU0fL-SwU4N8qHRUJjaNECMt_g@mail.gmail.com>
Subject: Re: [PATCH net 1/2] udp: fix auto-selected port colliding with an
 existing SO_REUSEPORT socket
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Tom Herbert <therbert@google.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 8:06=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> Observed with two independent servers in the same process:
>
>   fd1 =3D socket(AF_INET, SOCK_DGRAM, 0);
>   setsockopt(fd1, SOL_SOCKET, SO_REUSEPORT, ...);
>   bind(fd1, port 0);          /* got 40000 */
>
>   fd2 =3D socket(AF_INET, SOCK_DGRAM, 0);
>   setsockopt(fd2, SOL_SOCKET, SO_REUSEPORT, ...);
>   bind(fd2, port 0);          /* got 40000 as well */
>
> Both sockets end up on the same port and join the same reuseport
> group, so each of them takes part of the other's datagrams. TCP does
> not do this.
>
> udp_lib_lport_inuse() keeps the reuseport rule when it scans for a
> free port: a socket with the same uid and SO_REUSEPORT set is not a
> conflict, so its port is never marked in the bitmap and the scan can
> hand it out again. That rule only makes sense when the user asks for
> a specific port.
>
> TCP fixed the same thing in commit 0643ee4fd1b7 ("inet: Fix get port
> to handle zero port number with soreuseport set"): reuseport is only
> honoured for an explicit port, not during a port scan.
>
> Do the same for UDP. Mark compatible reuseport sockets in the bitmap
> during a scan and only skip them when checking a specific port. Using
> bitmap to tell the two modes apart is not explicit, but
> udp_lib_lport_inuse() already does that for the port match itself.
>
> Note that this still collides when both sockets also have SO_REUSEADDR
> set: udp_lib_lport_inuse() skips such a pair before it reaches the
> reuseport check, so the port is never marked either. That is not a
> common setup and is left as is here.
>
> Fixes: ba418fa357a7 ("soreuseport: UDP/IPv4 implementation")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/ipv4/udp.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index b3887c42adfd..61cb1e3f5d93 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -147,11 +147,10 @@ static int udp_lib_lport_inuse(struct net *net, __u=
16 num,
>                     (!sk2->sk_bound_dev_if || !sk->sk_bound_dev_if ||
>                      sk2->sk_bound_dev_if =3D=3D sk->sk_bound_dev_if) &&
>                     inet_rcv_saddr_equal(sk, sk2, true)) {
> -                       if (sk2->sk_reuseport && sk->sk_reuseport &&
> +                       if (!bitmap && sk2->sk_reuseport && sk->sk_reusep=
ort &&
>                             !rcu_access_pointer(sk->sk_reuseport_cb) &&
>                             uid_eq(uid, sk_uid(sk2))) {
> -                               if (!bitmap)
> -                                       return 0;
> +                               return 0;
>                         } else {
>                                 if (!bitmap)
>                                         return 1;
> --
> 2.43.0
>

The fix is right and matches what TCP does in inet_csk_find_open_port(),
but it only covers one of the three cases where UDP's scan differs from TCP=
's.

On an unpatched kernel, binding 8 sockets to port 0 inside an 8-port
IP_LOCAL_PORT_RANGE:

udp SO_REUSEPORT 7 distinct ports, 9th bind succeeds udp SO_REUSEADDR
7 distinct ports,
9th bind succeeds udp REUSEADDR+REUSEPORT 6 distinct ports, 9th bind succee=
ds

(TCP gets 8 distinct and EADDRINUSE in all three.) Your patch only
fixes the first one;
the SO_REUSEADDR cases bail out of the conflict test before the reuseport c=
heck
so the bitmap is never marked. SO_REUSEADDR on its own is pretty common for=
 UDP,
so I don't think we should leave it.

TCP handles all three because inet_csk_find_open_port() passes relax=3Dfals=
e,
which disables both relaxations.

Please add a comment on top of the loop saying that @bitmap means "scanning=
",
since it is not obvious =E2=80=94 or use !num, which is equivalent here sin=
ce
udp_lib_get_port()
passes snum =3D=3D 0 on the scan path.

Please also extend patch 2 to cover SO_REUSEADDR and SO_REUSEADDR|SO_REUSEP=
ORT;
the helper refactor is already there, just make the bool a flags argument.

Given this is a 13 year old bind() behaviour change and the collision
window is tiny
with the default ephemeral range, net-next seems like the better target.

Perhaps a good candidate for "Cc: stable+noautosel@kernel.org # lets
not break applications..."



diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index bb8cfc62cb00431faefd0371a9de9346b9bb..8628b723ec946eed6337209f62f683b=
a4252
100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -143,21 +143,18 @@ static int udp_lib_lport_inuse(struct net *net, __u16=
 num,
                if (net_eq(sock_net(sk2), net) &&
                    sk2 !=3D sk &&
                    (bitmap || udp_sk(sk2)->udp_port_hash =3D=3D num) &&
-                   (!sk2->sk_reuse || !sk->sk_reuse) &&
+                   (bitmap || !sk2->sk_reuse || !sk->sk_reuse) &&
                    (!sk2->sk_bound_dev_if || !sk->sk_bound_dev_if ||
                     sk2->sk_bound_dev_if =3D=3D sk->sk_bound_dev_if) &&
                    inet_rcv_saddr_equal(sk, sk2, true)) {
-                       if (sk2->sk_reuseport && sk->sk_reuseport &&
-                           !rcu_access_pointer(sk->sk_reuseport_cb) &&
-                           uid_eq(uid, sk_uid(sk2))) {
-                               if (!bitmap)
+                       if (!bitmap) {
+                               if (sk2->sk_reuseport && sk->sk_reuseport &=
&
+                                   !rcu_access_pointer(sk->sk_reuseport_cb=
) &&
+                                   uid_eq(uid, sk_uid(sk2)))
                                        return 0;
-                       } else {
-                               if (!bitmap)
-                                       return 1;
-                               __set_bit(udp_sk(sk2)->udp_port_hash >> log=
,
-                                         bitmap);
+                               return 1;
                        }
+                       __set_bit(udp_sk(sk2)->udp_port_hash >> log, bitmap=
);
                }
        }
        return 0;
