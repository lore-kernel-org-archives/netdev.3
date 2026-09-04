Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65863B71B2
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536893; cv=pass; b=t/uXqeSNM2AJdkEBvQSD3M3m/xw7b4g0AyFZTsh1iKDMv1O/0cf706T1IsOXkGPnAJWJwCKxrJgB8VIq6R4C0FddpIfwk+sOrfgq+sv+HhStYTFEiIsByp60hKv3q2YBCGZJH5t16FCTFgpG1ZxkYvZ5gy1qMWM3Mtt4ElqWL80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536893; c=relaxed/simple;
	bh=fkgmLk7TSusFljKb5mNVGBWmuOfZ68VmTXa0yt0WmTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaOuB+lKckj76JanlVQqaNjNeDJ9tx+3ijemDTGd51q7U9LGB9CNYW0/dlqWd/QGZDtDQUkmBtvYIkyzr/EDHAwpOw890BIyDblTYn4+MfF3jgB3o679qMpNDDMXxm9d4iHu1U087f7ikSMY4jIiwpp26EUrOkmjs+yHyMGobl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ol+kOGwb; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ol+kOGwb"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52eaeddc837so10997001cf.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 08:48:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788536890; cv=none;
        d=google.com; s=arc-20260327;
        b=m4s4pXv7rcXrCGqwBFlr7dY5OylcU0FcwjxZWFzGrOBfUt5IFMVEzAPpA4H94xhAiv
         zVuUjasfrut9mt5GTU52WgimNR348q+RzaYPRa8meptUJ8OuTxz4iG+LhIiNEI92b0dh
         YB2Ee93B1efjYG8kmDbpYlaGuVeUsGn6zf5T+JHah0rLX6VY80+58Vv+vLVS4HQsjkoo
         2yuwxwqwxNhyxoPwaV4MzFjVGJk7W9yY9va5O2L+5en54ugTV87rD9YKwC12CXrq4966
         LykaHUdNBJvA849tZiaGCdPXkKnFPMhMhVG8MtUyg8rstbKrX4WgW8GxUscZTfS/Se9D
         sOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bfiN6yz4NWjPVAo55cK10Jczdybpen++qz7Sb8+85g0=;
        fh=gP3BncD35VmbeJ/NIQLILTrsMnrBMtYY0xd2Q1a0oh8=;
        b=JBjFuNh0Ue5uBK21KXCnPCrxyy5SSSoQbqg2hX0D5xPCKZQl6QykB7YJyRFyI6s24w
         hJXKn/0IhUTICeRc0W+PgSTM4oxf5Vw84AJ6IDausYe/eN8GDAC9oRkBvQ3yniyUpSZf
         jiU4xZL+G8fohxv/5K+PeF+l3A+sTEX8mHxoQ/0ugV3GxSNvZ1EXHYTFSuRKMb65NT9C
         SQjNQPXiCIPFga1zuePm8WgdiMaHNerkn4aLYDSgT7OFuRZ3KxAN37epOYcM4Jq2F0Hl
         NSx6qxYweCXsfZ2o+FgRODpDCl8OiOB0EeyrDWaTdduMMWKtH83C25k+ygNFm1CMDkaC
         ceaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788536890; x=1789141690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bfiN6yz4NWjPVAo55cK10Jczdybpen++qz7Sb8+85g0=;
        b=ol+kOGwb+Ezfp+yg+sF97mQozal7WfsVMAgn/qvhQ2kQ6aiIA8wmfQpvdVnKC9HA47
         i1t1yDb1jjnIhI0T7LldeaW0CvmrjgcOX+F2MR9tgyzmsIL8PIyPxqNWzY4w+L2WiNb4
         OjjoxfiFO405XUu73lge6k1cx30lKog1FcEX9/6NYl+Y7yjf+fZI/k2stgDo5icQEYsu
         q2/fXiCJtxICZyiKAqr7nll26szi+mpf8cidRGLLHXr0Hmw1bUEYhBpaCxP5tHvpfZ2o
         3iEbVZleaImJboUq6HOxVr4ZiqG3h5+2qpYhEARz8+iPe6sf9MxP0Tgfz8uDPHVVTUTo
         dNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536890; x=1789141690;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfiN6yz4NWjPVAo55cK10Jczdybpen++qz7Sb8+85g0=;
        b=OrSFfHDyDxnvbQmsoteypS3xaO+H1JYHj6DcUqbCoBTLto7IWJKhVwV3jdneVriFLF
         pCg0uQo/VADY3UJh7FWbkNI07kSK/i4S2M8pBTro0tRl4ggrDkgcMgJZEqa+pHtu2Kuc
         43C+g/oOTy59LVohAv1FMiGmR0Wzd/Kqy5Nb2ox1noTT7hFs6syuewu8+u7h6SyUAv5Q
         Vrlje+9vD2bXwZEMNQ6qT4+drm5tL7370IOdEUin8pO1L4I9wf4cnn/qpRwMjcfWRKrU
         cfpOmHcKLQ1uFdYK0U4K4gHoIp71wqz2LjzY9OvM64sCGtuhtZG2tpHVem5+GSTU1zyu
         l8tw==
X-Forwarded-Encrypted: i=1; AKwUvBz/o4BhLQC5PjHUX6Ir7UL/gK64C4jSaRUljtcNyV0ayhYoFxSNnMz2bSDHbJqz31x1DzNmNPQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lTXqcuxhebtMoHkOr/IvEErIkUyto+ZwVbvFphtRvc3Ekq6TdJ
	1Dt/vQJtXQBfoGT4sxd+P5DSm+gYQ0o3oGhNIFOcOBlv1S6r5nf6BdAhht1pVkDmoSJzUvWeoYA
	SVeHBUfes+XGT79DPeitSUz/QHEsuaI91ESu+IRCm
X-Gm-Gg: AYBFou2iuhP3KcU0qz7d61LSqwjtHlaNCofd2tR43GMs7J+7G8OTry5IKY8LvOHbMSt
	ToP5d2seWgyh/jKsC4bqx0Am4IiBfiI/YG/HrJOSBxcSRZAi4+t95isO6Lp1uf13bO9ZncyVKpA
	fRmy3ThEYApibCsZGyLNmSrmXzx6YhEKJytdNcBN1P/H2OaVCbjbwKHBBfUWi+HKgUGjCPQ3Ifm
	qfZ1AIOe1eeeXd2zHFRn+a7IyJpiYLnTfvjJ5QZftSuPaZx3UNerUCzlG5+WRsRgaBqr4wNXwlu
	7qWlXmnyNuO3O6nyJV9TsGeGS/i89gSfPMwrtC5ITg+DFjjtcWQx0CS1Fs3SAVfLM2nBRtGg1tw
	8QzeYYeEk7JOcunzmUxQa0mIcZh5Njz4MDhRm2w1o7DZ2jysvWKDBNxcisA==
X-Received: by 2002:ac8:5945:0:b0:530:42d4:4c9a with SMTP id
 d75a77b69052e-53054a34924mr69388931cf.44.1788536889636; Fri, 04 Sep 2026
 08:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904144636.3443342-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260904144636.3443342-1-maoyixie.tju@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Sep 2026 17:47:57 +0200
X-Gm-Features: AcwNN1UCRx-BhO87n2SxGRB6ALivWRgeLz2pUjsHm8KdlVoypTzmG8EH1Vlq018
Message-ID: <CANn89iJRG6UbnYX2xo1ZJR4k=Jr+PQEb48qELK9gpKp2QATKyg@mail.gmail.com>
Subject: Re: [PATCH net] netlink: render SCM_CREDENTIALS pid in the receiver's
 pid namespace
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com, 
	horms@kernel.org, alexander@mihalicyn.com, brauner@kernel.org, 
	adobriyan@openvz.org, akpm@linux-foundation.org, leitao@debian.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 4:46=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com> w=
rote:
>
> __scm_recv_common() translates uid and gid into the reader's user
> namespace but copies the pid as is. AF_UNIX gets away with that because
> unix_skb_to_scm() re-renders the pid with pid_vnr() at recvmsg time.
> netlink_sendmsg() renders it in the sender's namespace and stores a bare
> u32, so a reader in another pid namespace sees a number from a namespace
> it is not in. The sender chooses that number. An unprivileged sender in a
> child namespace made the receiver see pid 300.
>
> Carry the sender's struct pid in NETLINK_CB and hand it to scm_set_cred()
> in netlink_recvmsg(), the way af_unix does. netlink_skb_set_owner_r()
> takes the reference and netlink_skb_destructor() drops it. A reader in a
> namespace the sender has no pid in now gets 0, like AF_UNIX.
>
> I found this with a CodeQL checker. I used Claude to help write the
> reproducers. The ones that reproduce the bug run unprivileged and need no
> kernel changes. Tested on net with KASAN and lockdep, no reports. The tre=
e
> has no netlink SCM selftest.
>
> Fixes: b488893a390e ("pid namespaces: changes to show virtual ids to user=
")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5 codeql
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  include/linux/netlink.h  |  9 +++++++++
>  net/netlink/af_netlink.c | 30 ++++++++++++++++++++++++++++--
>  2 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/netlink.h b/include/linux/netlink.h
> index 882e9c1b6c1dcc..26266754e27c14 100644
> --- a/include/linux/netlink.h
> +++ b/include/linux/netlink.h
> @@ -30,6 +30,15 @@ struct netlink_skb_parms {
>         struct sock             *sk;
>         bool                    nsid_is_set;
>         int                     nsid;
> +       /*
> +        * Sender's struct pid.  netlink_sendmsg() stores a borrowed poin=
ter
> +        * taken from its own scm_cookie.  netlink_skb_set_owner_r() take=
s a
> +        * reference when it takes ownership of the skb for a receiver, a=
nd
> +        * netlink_skb_destructor() drops that reference.  A clone starts=
 out
> +        * borrowing again, because __skb_clone() clears both skb->sk and
> +        * skb->destructor.  NULL for a kernel generated skb.
> +        */
> +       struct pid              *pid;
>  };
>
>  #define NETLINK_CB(skb)                (*(struct netlink_skb_parms*)&((s=
kb)->cb))
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index e6b1d9758c9c92..170d90d472a0db 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -379,13 +379,24 @@ static void netlink_skb_destructor(struct sk_buff *=
skb)
>
>                 skb->head =3D NULL;
>         }
> -       if (skb->sk !=3D NULL)
> +       if (skb->sk) {
> +               /*
> +                * The reference is held for as long as skb->sk is set, t=
aken
> +                * in netlink_skb_set_owner_r() and dropped here.  The po=
inter
> +                * is left in place: do_one_broadcast() orphans an skb on=
e
> +                * listener owned and hands it to the next, which takes i=
ts
> +                * own reference, and the sender's scm_cookie keeps the p=
id
> +                * alive across the whole broadcast.
> +                */
> +               put_pid(NETLINK_CB(skb).pid);

I really have a bad feeling about this dance and these assumptions,
maybe this is just me.

Please include a dedicated selftest in tools/testing/selftests/net/
exercising SO_PASSCRED / SCM_CREDENTIALS
over netlink across PID namespaces to demonstrate the issue and
validate the proposed changes.

Thanks.

>                 sock_rfree(skb);
> +       }
>  }
>
>  static void netlink_skb_set_owner_r(struct sk_buff *skb, struct sock *sk=
)
>  {
>         WARN_ON(skb->sk !=3D NULL);
> +       NETLINK_CB(skb).pid =3D get_pid(NETLINK_CB(skb).pid);
>         skb->sk =3D sk;
>         skb->destructor =3D netlink_skb_destructor;
>         sk_mem_charge(sk, skb->truesize);
> @@ -1880,6 +1891,13 @@ static int netlink_sendmsg(struct socket *sock, st=
ruct msghdr *msg, size_t len)
>         NETLINK_CB(skb).dst_group =3D dst_group;
>         NETLINK_CB(skb).creds   =3D scm.creds;
>         NETLINK_CB(skb).flags   =3D netlink_skb_flags;
> +       /*
> +        * Borrowed here.  scm_destroy() below drops the scm_cookie's own
> +        * reference, and every delivery in between is synchronous, so th=
e
> +        * pointer stays valid until netlink_skb_set_owner_r() takes a
> +        * reference of its own.
> +        */
> +       NETLINK_CB(skb).pid     =3D scm.pid;
>
>         err =3D -EFAULT;
>         if (memcpy_from_msg(skb_put(skb, len), msg, len)) {
> @@ -1971,7 +1989,15 @@ static int netlink_recvmsg(struct socket *sock, st=
ruct msghdr *msg, size_t len,
>                 netlink_cmsg_listen_all_nsid(sk, msg, skb);
>
>         memset(&scm, 0, sizeof(scm));
> -       scm.creds =3D *NETLINK_CREDS(skb);
> +       /*
> +        * Render the sender's pid in the reader's pid namespace, the way
> +        * unix_skb_to_scm() does through scm_set_cred().  A NULL pid giv=
es 0,
> +        * so a control block that lost its reference reports "unknown" r=
ather
> +        * than the sender's own untranslated number.  scm_recv() below d=
rops
> +        * the reference taken here on both of its paths.
> +        */
> +       scm_set_cred(&scm, NETLINK_CB(skb).pid, NETLINK_CREDS(skb)->uid,
> +                    NETLINK_CREDS(skb)->gid);
>         if (flags & MSG_TRUNC)
>                 copied =3D data_skb->len;
>
> --
> 2.34.1
>
