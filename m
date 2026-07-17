Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D00430C141
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301036; cv=pass; b=lrAMdTx5aozo9+tOohHC5wmXm/ZYYFKnel8ZRIi84+qSlU44DXRpYqRSXgOHF7nIVHcaBYAc0dQFpTlNlId7jMBCVlr4qrUu1mj43xDdVW9SNBIZeQikr30++bIAfVgFcDv2qkE3vRWvf6wIZukJh1I6ppZyi21vhXFPAjC5HOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301036; c=relaxed/simple;
	bh=wcCGQlsNXlrMToOsubdjJB0NNkuBzzYb4QD7vXreeOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0A8gIiilwdQ8ZRWZGezjPuQBgNoSlMRKOib32yfSF/1cXchZuvu4pFuKFtEPvBfo9H0XNdh7TYvFM+wTqMuKziW9a3ND5C0DRUOHc/ADPtPMBPvFYtltmvqZEJ7sC8ucPAGdDnVcPmf2tx+2/05Ikmty5xwhD/l2NeF5xRBZVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAKx31UJ; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAKx31UJ"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-848761b5897so4400658b3a.3
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 08:10:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784301034; cv=none;
        d=google.com; s=arc-20260327;
        b=hPEe1EFU1Lq8MzdsrXGSVeuAv9QtckGQ7KJy9iOdEoDrXLthy6g1v2ABVakyK4314n
         Q+3D1kZwzohp39+BIwIswVJ5MAXpmHnyGGsQ9f+K8/ssLTDn1Ora4SXekaPqfXM9uVHc
         qCoWSYog+szdLi6DGGACAz7qd/612eXJUJDzADmGws/kUZJqZKRpCW40mLx++gNXHBgL
         pkzrsFaNlc6uDAP41yGBtf0YSN38XU2dSm3pkJaGFBDQ1cjHAJHBVn76tY3BZZ+NnfwD
         LYn8csk9LU5iOrvv2zblKUl0L1uqsIp9430G6qHhzvCEDYB1g003iTy5j5/5om/CxuR0
         ldlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a8KKiUSAAAfYNoQY2TKOOy84qt0EoQc90vAlN/nOFgs=;
        fh=kihpSId+Wi/tWHXQneholzpuYd7/w1TUYSxEwAiSxk4=;
        b=h2l/dlXmPOiyGO/oHfxI8BcPai7RXCKuDlKeMfDTwBTssDhhdvsYE+AcAQC92NRUKy
         +GBHAAd4NbF52WkAvfCDudVLJBZusdRacPDFqmcZy3Okq7KpeaJzU8M/PMOgpp+sIz5n
         7n4kvoRAswr16c8NfPphX9UM9mCEYz5t6MNkWM0uMlLJHfaGdOSzAjrh04gum2uf0e86
         FXGfjMf35bYZQbweOBwXBM+sc8Hqga9t4SUP+lUYBO6aimngY16VebNpoFLhTP1rDXf4
         z4M9Qbjg8v83rzAgLhIK3Lz5ZpCKKQtfHfqnBeh4MV0tNcwNRaOKeEAwKelLgSV852fa
         jL4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784301034; x=1784905834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a8KKiUSAAAfYNoQY2TKOOy84qt0EoQc90vAlN/nOFgs=;
        b=dAKx31UJ3TJ7jS6spkZLQZnw0x6ZK0fUMb26MURFCVgMs7cm2SCqDOaScMaq6IpTBd
         MQKf+g6b9hdZfZLDxcfLVC1QAI8uHixbJC669PcWbGYxwUACgx88SnynurcSx35zQAXK
         9CK2lXKgwab2DYJGUtiGgoXMmovlJZFpKDAJe2xP0yB00LBMPnEOp1cPGzcggeaADeed
         JcBYCRq+ST8Px6mShSAwC+dinvlhy0FPDaZK7sz3DeZOxzgWKjZe2syc4NHIC9Gvu/h7
         FJUkTVYFpKpUonEnsdhaaZzuPTfPLdzGu0CteI3Z/kX10Z4O/00nGSKx2w94n0MXpbpQ
         Uo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784301034; x=1784905834;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a8KKiUSAAAfYNoQY2TKOOy84qt0EoQc90vAlN/nOFgs=;
        b=X7dkicOBY4VtBBeZUrtYa6iLoGemme18GH1EnMLESEK8RM6oB1/r+J06HZc1i/prWj
         xPSzUFJLp4Sh5To+rcrn0R03E4QisCQUlsTs1kHSFShHjMPh/W1+z56VfJV++9UHMUTK
         LI4EsGvTRfb5eOp142D1YisW8QuBMcJsiD15cosYsaDkpqSsB1loH99s59Yup9AmLYiF
         0OsJqYmplNRvhWr2cIjDFcAFn96HvXFZy152M4gffUgan6aMwK+KKRw9k29E33To4dKz
         5xi6QXGmwTuG8Mkgn8l2XjRVp/WBNp6boKQpRWncT+HEbHK0G7tqHefHw4Q/3PlGLZlK
         5lWQ==
X-Forwarded-Encrypted: i=1; AHgh+RoAu1nhQx9aJEghfYlzN9zRXL0HuHtQO4vHSMgBisuCTProcqq8n63M2OIuHW7f5dwtaYJHScA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK6fJznG/aP0eg2Qzy5CDqe1PFYuoj7u06NCNJeLkhp66KsNR7
	sGgUQsHhVN9yyXc6bv8wam0OJPJwhNrFYszQ6H8ETue9IABGDQgo6xGP576eCHSG9AIe8n/OmG2
	6/HWXVIlz+bj0oOYi3AFPGtxUEd1e/ws=
X-Gm-Gg: AfdE7cmOflf+YzyrlJ/YCCDWi61U2hdi11M/mIKFMOSo0Sh+4MHnPrEf5AZuAlLR69V
	Sxp+MKnqLYmg6Z0X9plJEZuK+3ypfoe27mW80n6d+9xF4yFZA8LUpOlprnVyxBC3SjaYy+WsjM2
	+K6/rRNes7VNMeoGrNnEIGTqXAkdH7ylBTqibrtqvtba++29PhxNNAlX2zx68QgdWyQgDBLFkys
	gfzcRRF2UMpyRbTwMhDDwQKv4OLKd7eveAjqM4mizonmRy8+PD4bbDPvyszrcC+gunFCaivcZU+
	MxlV0k0dHY/eM++VluCKwxHJ8cCpQUm4ik321LEtggp/wfYBrPEaxz1McajgOr+zNbrk+2Uqyg=
	=
X-Received: by 2002:a05:6a00:2e07:b0:848:44ae:47c1 with SMTP id
 d2e1a72fcca58-84c295457abmr3092687b3a.78.1784301033652; Fri, 17 Jul 2026
 08:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH0PR11MB5902DBD696C30DB0A2308A49F0C72@PH0PR11MB5902.namprd11.prod.outlook.com>
 <20260717082048.948262-1-l1138897701@163.com>
In-Reply-To: <20260717082048.948262-1-l1138897701@163.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 17 Jul 2026 11:10:21 -0400
X-Gm-Features: AUfX_myqCK9tbAXuT_FWShGbILOMX3z2J31bgyB2pvDKMDN7OZwMZXzfFa5un8w
Message-ID: <CADvbK_dHFt6cceHQ5BwPMWbF1j4i8BtYZ4Su067SvMeiiD6Rcw@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: socket: remove unused 'err' parameter from sctp_skb_recv_datagram
To: luoqing <l1138897701@163.com>
Cc: jedrzej.jagielski@intel.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, luoqing@kylinos.cn, marcelo.leitner@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 4:21=E2=80=AFAM luoqing <l1138897701@163.com> wrote=
:
>
> From: luoqing <luoqing@kylinos.cn>
>
> The 'err' parameter in sctp_skb_recv_datagram() is never used by any
> of its callers. Both sctp_recvmsg() and sctp_ulpevent_read_nxtinfo()
> pass the address of a local variable but never check its value after
> the function returns, rendering the parameter completely useless.
>
> Remove the unused parameter to simplify the function signature and
> eliminate dead code.
>
> Signed-off-by: luoqing <luoqing@kylinos.cn>
> ---
>  include/net/sctp/sctp.h |  2 +-
>  net/sctp/socket.c       | 10 +++-------
>  net/sctp/ulpevent.c     |  3 +--
>  3 files changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
> index d50c27812504..b86d50d6b146 100644
> --- a/include/net/sctp/sctp.h
> +++ b/include/net/sctp/sctp.h
> @@ -97,7 +97,7 @@ void sctp_sock_rfree(struct sk_buff *skb);
>
>  extern struct percpu_counter sctp_sockets_allocated;
>  int sctp_asconf_mgmt(struct sctp_sock *, struct sctp_sockaddr_entry *);
> -struct sk_buff *sctp_skb_recv_datagram(struct sock *, int, int *);
> +struct sk_buff *sctp_skb_recv_datagram(struct sock *sk, int flags);
>
>  typedef int (*sctp_callback_t)(struct sctp_endpoint *, struct sctp_trans=
port *, void *);
>  void sctp_transport_walk_start(struct rhashtable_iter *iter);
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index c7b9e325ec1c..3804382d78e0 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -2123,7 +2123,7 @@ static int sctp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
>                 goto out;
>         }
>
> -       skb =3D sctp_skb_recv_datagram(sk, flags, &err);
> +       skb =3D sctp_skb_recv_datagram(sk, flags);
>         if (!skb)
>                 goto out;
>
> @@ -9082,7 +9082,7 @@ static int sctp_wait_for_packet(struct sock *sk, in=
t *err, long *timeo_p)
>   * Note: This is pretty much the same routine as in core/datagram.c
>   * with a few changes to make lksctp work.
>   */
> -struct sk_buff *sctp_skb_recv_datagram(struct sock *sk, int flags, int *=
err)
> +struct sk_buff *sctp_skb_recv_datagram(struct sock *sk, int flags)
>  {
>         int error;
>         struct sk_buff *skb;
> @@ -9120,17 +9120,13 @@ struct sk_buff *sctp_skb_recv_datagram(struct soc=
k *sk, int flags, int *err)
>                 if (sk->sk_shutdown & RCV_SHUTDOWN)
>                         break;
>
> -
>                 /* User doesn't want to wait.  */
>                 error =3D -EAGAIN;
>                 if (!timeo)
>                         goto no_packet;
> -       } while (sctp_wait_for_packet(sk, err, &timeo) =3D=3D 0);
> -
> -       return NULL;
> +       } while (sctp_wait_for_packet(sk, &error, &timeo) =3D=3D 0);
>
>  no_packet:
> -       *err =3D error;
>         return NULL;
>  }
>
> diff --git a/net/sctp/ulpevent.c b/net/sctp/ulpevent.c
> index 8920ca92a011..8ed51a15c3a4 100644
> --- a/net/sctp/ulpevent.c
> +++ b/net/sctp/ulpevent.c
> @@ -1061,9 +1061,8 @@ void sctp_ulpevent_read_nxtinfo(const struct sctp_u=
lpevent *event,
>                                 struct sock *sk)
>  {
>         struct sk_buff *skb;
> -       int err;
>
> -       skb =3D sctp_skb_recv_datagram(sk, MSG_PEEK | MSG_DONTWAIT, &err)=
;
> +       skb =3D sctp_skb_recv_datagram(sk, MSG_PEEK | MSG_DONTWAIT);
>         if (skb !=3D NULL) {
>                 __sctp_ulpevent_read_nxtinfo(sctp_skb2event(skb),
>                                              msghdr, skb);
> --
> 2.25.1
>
I think it's used at [1] in sctp_recvmsg():

        skb =3D sctp_skb_recv_datagram(sk, flags, &err);
        if (!skb)
                goto out;
...

out:
        release_sock(sk);
        return err;   <------ [1]

Thanks.
