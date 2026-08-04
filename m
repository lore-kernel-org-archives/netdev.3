Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6C3483BC9
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863805; cv=pass; b=Fv7a/UDU7OphSPJB7K1WgiyG2GPgM1Kdx2fu4ck0w+hB1LCgAKCFal30+SJpcCBQQEsLN3uofdXGcMS3nqGRUJ4Zi2e7HzF7UQ0ZpRnzp2BG6bGBwgmc3VKWmnHq07SjDWrJAzr6NXLmArKUgkj+N8wK12jMelT4dxyRp0lf370=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863805; c=relaxed/simple;
	bh=LF7+JYUCMqsJVubyUU/m/CpnjWFFkBdxSn4kk2Z///U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWHFvX7pLriLuxqVOCQ6nXGE8C0UAFuH3o9EcleiReJZdZPZsLXK+BysmDEoK3VwVHMfQWnoLfKw4hVPNNbWwmcOLs7EfaSiIjMR3lrt0DsBZlL5Tt37QGoHjv7T1MMLY1YfAKqMzJ0SRSi+3EofZNqY82IVrB/1SOevFYOpUpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pTPv6qNq; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTPv6qNq"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so45691a91.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 10:16:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785863780; cv=none;
        d=google.com; s=arc-20260327;
        b=cyAH15ojQz2OQb+QIPxOFDTfp2MSeosHEfWahVoQp7JF2WNvPS3MEQqgU3y/NUmJb8
         Mt5I9TsazvlHtcdT6crQEIjLEJFTgyEjcO2m/Fo4BRdL1CK8DsuaMiCTkL43/dirwL62
         h1G3EHnH4cFulvlRXCp7gdClB5YGKVUJHrD10jSiAzc2fGmlxKh0e0UtxpLdNpol2SMX
         SduBpS9IOJ6Vd/P7phL0l2FKIv0QQCtXdLdepSG1Faw7/ygfK6q/ZQib2oO166hQvQEL
         Tx/q5kyHVjHZl0CWkxsXbRIqSbHBdi9riXVq4rwIn343UfAwLuebGbPsA32pfdSfjYZ/
         YflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CBmg3o5zRRlI21PlSNYstLuxWjLbvI4zhMWhzTM4nt4=;
        fh=khuenhUqc7VrpYIDKzqALh2xwJua6YeabbmizRRizTE=;
        b=bMN1oPzi8pWr5gpT0sw5YrNLQann9uFWWc2FO5QDIxglWOwsMXJlqs2Kq3mvbSwmnx
         U0JWRzX31XMzZF21QeWZzUbXWpxLeoaJXTi24poiaUp6RzKjVVPjWIDGKzZh3EI1NwPd
         CsLqkUmnqWhIE4YaaHxEu6M04WKmnCBnNYqT3AXMA8I6rvWOewDYBA5Obuo9ElQiCc6f
         xsEN9HNWZGpgAJNJbIhwB54es5BNi81jx7sK2QoNl+e30NzG7I/AnUdkMCrBn9Mx+2sF
         XEG/FREPmgGW76fyO3p3GBA1SmVZuS+mG3YGlYVC+gGkye4agwBldeFWV6oBkYLaD2OK
         3koA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785863780; x=1786468580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CBmg3o5zRRlI21PlSNYstLuxWjLbvI4zhMWhzTM4nt4=;
        b=pTPv6qNqmMRlGL8AZ/Y/14JeHwhE6waF2n720iVqc3b1cFOvQ6964cKkEjkziOSk6K
         qmKAS2OZ9igfJlbwtuPFO+lBmvIslxLb8iyyZdBYHKHIlRHUZnPPq0mK4wo/vtJx7REH
         yVtaHhJXbWIBEL3CmQtn0TN0w7FL7QMguU8wvel/ZcGGjZMHRSMDIi5y6BL44WCVL/Jd
         Wv4LR4HlEWnzy99BzSTU+ck5SJ2v0Nz9rJjdlsabUs+vKlnc0Ic7briQ88jEpcGa0vzB
         DkiS2x5dfEdvIN+3eSa+TtIQG1Dy3UdKaLHphA8ggYi/Yh+l+RjVXV3E+JlJxesAkZ8W
         6roQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863780; x=1786468580;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CBmg3o5zRRlI21PlSNYstLuxWjLbvI4zhMWhzTM4nt4=;
        b=S1gHckiQ4JlVQJASgXIKVPmfFyCYGqNCeNRZBhGE/QgorTxa/2YZ7qYZHbaBF5uCcq
         /2YH+ibPBt6XtYa34GIgb/bMLm7kTwskrvxVsLtJv/H4bZ1kgY+A8065pIkLdM8y+OrL
         jxWb/cVCAhbWjUvPJzxQI7KkrqzUJqSt29tGwzGKzUbK053N0+mEpJASvpfiTJO/gtfD
         qEDVmnEMqlIusLIpTrPexpvhHjv4xrTSVDzVFu6gsi/JWMVzVMhJKjwRqXxbc3Q8LI9A
         RjGWP6yS0CEjwlscYKrZsF0NswWxdnmZKH61QPa8xvCYemtS+lNzJgLp49Myo5U62xCr
         OaTQ==
X-Forwarded-Encrypted: i=1; AHgh+RrhoeulqpSsYsgGlGK3PYcTHBK3KTrYkFn9tqunlQQYTBKocH6SMpPmVcQ7DbiXTkeyFNtmB6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqCcdE2YekXMN0K0r/aTsR5oHy33CmD9QhOukn5FoZM51B5Ta9
	Ueou0rXV4yJfFEFNbXLyCvSb4vtOMESCYl6LzND6vMUPbyuq8ZGWC5rCJw9d0Ts539VLPOE85rS
	hx5iVN4VCbvZkpH2ciR0gWLtfm1dPl/jFopvwwnEq
X-Gm-Gg: AR+sD10qrfGotKUGxUamJQBf8nqEWoc0QmU5bR8beiFYfbA4grjd+wnsfPCBjynosCf
	8TGqqAnne0w5hcBd3kk0gb0fVr9NITMEsXk9liGDqBzqoYhhC9GtnBl9K+9t10+XTVUHk35J+Nz
	WVCF+ZLJQ0NUB+z6tlfr9SzAZ7vQd/W7WNdoLk8ak39T3ja7zc9yyzJNiqrisMIAPsO/FTackB2
	U2zfE1dVIj0TBbfArP2umJ9dS0AoXLSZiiNRypSkHNjfWEwBJLZXS2qIl+SwhQDTpgwWbKxwDwY
	uRj+RzqkpV5LTqJWYZVlXge+e7IzUVKOUwcpo3+6FbqAThAh3rQezIhbLUh+lHiPH1EU3g+UU6h
	qm5u6hM86Ml01LIvGezzlxeS48UXSzIB+Bp+Ew8/g6tdG7DELxXOrnXW9ExcB/VCm/OoPWWP5Tt
	JjoB/Unn6CfBs=
X-Received: by 2002:a17:90b:55c7:b0:383:f52b:d616 with SMTP id
 98e67ed59e1d1-3903c592495mr527481a91.10.1785863779555; Tue, 04 Aug 2026
 10:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802151212.3294591-1-jkoolstra@xs4all.nl> <20260802151212.3294591-4-jkoolstra@xs4all.nl>
In-Reply-To: <20260802151212.3294591-4-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 4 Aug 2026 10:16:06 -0700
X-Gm-Features: AUfX_mzrlkWRXfGhh9gUJLOiw_c0m3vTxSo6H_tm_VElR2P5S6SMKo8PVaUgFbc
Message-ID: <CAAVpQUCo0r+DDRJ9BT1_2JYmPcsUNnk6aS+oqPvOrO9ruCPUKw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/4] net: af_unix: useful handling of LSM
 denials on SCM_RIGHTS
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: brauner@kernel.org, cyphar@cyphar.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 8:11=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl> =
wrote:
>
> Right now if some LSM such as Smack denies an AF_UNIX socket peer to
> receive an SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
> that point, and MSG_CTRUNC is set on return of recvmsg(). This is
> highly problematic behaviour, because it leaves the receiver
> wondering what happened. As per man page MSG_CTRUNC is supposed to
> indicate that the control buffer was sized too short, but suddenly
> a permission error might result in the exact same flag being set.
> Moreover, the receiver has no chance to determine how many fds got
> originally sent and how many were suppressed.[1]
>
> Add a SO_RIGHTS_NOTRUNC option to UNIX sockets to enable more useful
> handling of LSM denials when receiving SCM_RIGHTS messages: instead of
> truncating the message at the first blocked fd, keep every fd slot
> and store the LSM errno in the blocked slot. The socket option is
> inherited by the child accept() socket if set on the listen() socket.
>
> [1]: https://github.com/uapi-group/kernel-features#useful-handling-of-lsm=
-denials-on-scm_rights
>
> Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  arch/alpha/include/uapi/asm/socket.h  |  2 ++
>  arch/mips/include/uapi/asm/socket.h   |  2 ++
>  arch/parisc/include/uapi/asm/socket.h |  2 ++
>  arch/sparc/include/uapi/asm/socket.h  |  2 ++
>  include/net/af_unix.h                 |  1 +
>  include/net/scm.h                     | 13 +++------
>  include/uapi/asm-generic/socket.h     |  2 ++
>  net/compat.c                          |  4 +--
>  net/core/scm.c                        | 38 +++++++++++++++++++++++----
>  net/unix/af_unix.c                    | 12 ++++++++-
>  10 files changed, 61 insertions(+), 17 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/ua=
pi/asm/socket.h
> index 5ef57f88df6b..946a5fad2691 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -155,6 +155,8 @@
>  #define SO_INQ                 84
>  #define SCM_INQ                        SO_INQ
>
> +#define SO_RIGHTS_NOTRUNC      85
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi=
/asm/socket.h
> index 72fb1b006da9..f1641dde135f 100644
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
> @@ -166,6 +166,8 @@
>  #define SO_INQ                 84
>  #define SCM_INQ                        SO_INQ
>
> +#define SO_RIGHTS_NOTRUNC      85
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/=
uapi/asm/socket.h
> index c16ec36dfee6..f3a3815c7dc2 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -147,6 +147,8 @@
>  #define SO_INQ                 0x4052
>  #define SCM_INQ                        SO_INQ
>
> +#define SO_RIGHTS_NOTRUNC      0x4053
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/ua=
pi/asm/socket.h
> index 71befa109e1c..7907f3b1f0ee 100644
> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
> @@ -148,6 +148,8 @@
>  #define SO_INQ                   0x005d
>  #define SCM_INQ                  SO_INQ
>
> +#define SO_RIGHTS_NOTRUNC        0x005e
> +
>  #if !defined(__KERNEL__)
>
>
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index 34f53dde65ce..bb1b3dee02e8 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -49,6 +49,7 @@ struct unix_sock {
>         struct scm_stat         scm_stat;
>         int                     inq_len;
>         bool                    recvmsg_inq;
> +       bool                    scm_rights_notrunc;
>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>         struct sk_buff          *oob_skb;
>  #endif
> diff --git a/include/net/scm.h b/include/net/scm.h
> index c52519669349..86ae6bc109ec 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -50,8 +50,8 @@ struct scm_cookie {
>  #endif
>  };
>
> -void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
> -void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm);
> +void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool not=
runc);
> +void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm, b=
ool notrunc);
>  int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cooki=
e *scm);
>  void __scm_destroy(struct scm_cookie *scm);
>  struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
> @@ -107,13 +107,8 @@ void scm_recv(struct socket *sock, struct msghdr *ms=
g,
>  void scm_recv_unix(struct socket *sock, struct msghdr *msg,
>                    struct scm_cookie *scm, int flags);
>
> -static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
> -                                 unsigned int flags)
> -{
> -       if (!ufd)
> -               return -EFAULT;
> -       return receive_fd(f, ufd, flags);
> -}
> +int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
> +                   bool notrunc);
>
>  #endif /* __LINUX_NET_SCM_H */
>
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic=
/socket.h
> index 53b5a8c002b1..84ea7b92936e 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -150,6 +150,8 @@
>  #define SO_INQ                 84
>  #define SCM_INQ                        SO_INQ
>
> +#define SO_RIGHTS_NOTRUNC      85
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP32=
__))
> diff --git a/net/compat.c b/net/compat.c
> index d68cf9c3aad5..6bdf4a2c9077 100644
> --- a/net/compat.c
> +++ b/net/compat.c
> @@ -286,7 +286,7 @@ static int scm_max_fds_compat(struct msghdr *msg)
>         return (msg->msg_controllen - sizeof(struct compat_cmsghdr)) / si=
zeof(int);
>  }
>
> -void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
> +void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm, b=
ool notrunc)
>  {
>         struct compat_cmsghdr __user *cm =3D
>                 (struct compat_cmsghdr __user *)msg->msg_control_user;
> @@ -296,7 +296,7 @@ void scm_detach_fds_compat(struct msghdr *msg, struct=
 scm_cookie *scm)
>         int err =3D 0, i;
>
>         for (i =3D 0; i < fdmax; i++) {
> -               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_=
flags);
> +               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_=
flags, notrunc);
>                 if (err < 0)
>                         break;
>         }
> diff --git a/net/core/scm.c b/net/core/scm.c
> index a73b1eb30fd2..f0d44ecdb11f 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -351,7 +351,31 @@ static int scm_max_fds(struct msghdr *msg)
>         return (msg->msg_controllen - sizeof(struct cmsghdr)) / sizeof(in=
t);
>  }
>
> -void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
> +int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
> +                   bool notrunc)
> +{
> +       int error;
> +
> +       if (!ufd)
> +               return -EFAULT;
> +
> +       error =3D security_file_receive(f);
> +       if (error)
> +               return notrunc ? put_user(error, ufd) : error;
> +
> +       FD_PREPARE(fdf, flags, get_file(f));
> +       if (fdf.err)
> +               return fdf.err;
> +
> +       error =3D put_user(fd_prepare_fd(fdf), ufd);
> +       if (error)
> +               return error;
> +
> +       __receive_sock(fd_prepare_file(fdf));
> +       return fd_publish(fdf);
> +}
> +
> +void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool not=
runc)
>  {
>         struct cmsghdr __user *cm =3D
>                 (__force struct cmsghdr __user *)msg->msg_control_user;
> @@ -365,12 +389,12 @@ void scm_detach_fds(struct msghdr *msg, struct scm_=
cookie *scm)
>                 return;
>
>         if (msg->msg_flags & MSG_CMSG_COMPAT) {
> -               scm_detach_fds_compat(msg, scm);
> +               scm_detach_fds_compat(msg, scm, notrunc);
>                 return;
>         }
>
>         for (i =3D 0; i < fdmax; i++) {
> -               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_=
flags);
> +               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_=
flags, notrunc);
>                 if (err < 0)
>                         break;
>         }
> @@ -542,8 +566,12 @@ void scm_recv_unix(struct socket *sock, struct msghd=
r *msg,
>         if (!__scm_recv_common(sock->sk, msg, scm, flags))
>                 return;
>
> -       if (scm->fp)
> -               scm_detach_fds(msg, scm);
> +       if (scm->fp) {
> +               struct unix_sock *u;
> +
> +               u =3D unix_sk(sock->sk);
> +               scm_detach_fds(msg, scm, READ_ONCE(u->scm_rights_notrunc)=
);
> +       }
>
>         if (sock->sk->sk_scm_pidfd)
>                 scm_pidfd_recv(msg, scm);
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 51cbf920130d..03ce23a4ebee 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -922,6 +922,7 @@ static bool unix_custom_sockopt(int optname)
>  {
>         switch (optname) {
>         case SO_INQ:
> +       case SO_RIGHTS_NOTRUNC:
>                 return true;
>         default:
>                 return false;
> @@ -957,6 +958,14 @@ static int unix_setsockopt(struct socket *sock, int =
level, int optname,
>
>                 WRITE_ONCE(u->recvmsg_inq, val);
>                 break;
> +
> +       case SO_RIGHTS_NOTRUNC:
> +               if (val > 1 || val < 0)
> +                       return -EINVAL;
> +
> +               WRITE_ONCE(u->scm_rights_notrunc, val);
> +               break;
> +
>         default:
>                 return -ENOPROTOOPT;
>         }
> @@ -1746,9 +1755,10 @@ static int unix_stream_connect(struct socket *sock=
, struct sockaddr_unsized *uad
>         init_peercred(newsk, &peercred);
>
>         newu =3D unix_sk(newsk);
> +       otheru =3D unix_sk(other);
>         newu->listener =3D other;
> +       newu->scm_rights_notrunc =3D otheru->scm_rights_notrunc;

nit: READ_ONCE() is needed here.



>         RCU_INIT_POINTER(newsk->sk_wq, &newu->peer_wq);
> -       otheru =3D unix_sk(other);
>
>         /* copy address information from listening to new sock
>          *
> --
> 2.55.0
>
