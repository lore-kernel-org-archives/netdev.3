Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE323ED3CE
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 03:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827199; cv=pass; b=uYp1d2Jq64+g3lLun04yTj6Kvj6Fs0I6XgTqIiLpl4TDMLy5w6fK6OB2X0sr82XuwHL1SE0N4nfe5PwwVV5vMY7AA66Dud86hAe9o+vfvtpuYEiboxRCAVCmNlbDo/ZoUBmIAueqWaMb0nv7/2+H0T00owyv1COp0zVsxV6TPWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827199; c=relaxed/simple;
	bh=JfjhtWAX/5PoHBlGE27TqtOtdtC4PuPBWAxjmTiuq7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbLaNNjegkf+uRE5QGFqxmQtjWwF2KYHVSRm+m/E6E2GJoLRNviOPPdUIhpKnvFPEwLXQzofSzGbK21/pi1bkFmxKA88zseb7BcTQurvxB+n4syB9Wl51WfWFl+n+/b1u8z99vpAMkxD9wQnh/D0Ec3JGCUj1bCcZGvpXwnI+Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwtaXyA8; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwtaXyA8"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1450541ab18so6657717c88.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 20:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790827195; cv=none;
        d=google.com; s=arc-20260327;
        b=MVZHQoyJAMr/GYx/HQAQpFYnkriJ2tyonI+SaB44nfD88OqaBs1z/Sd2TTpVBcJVEe
         WXwRUNQDyrigpi3EED7TeIRIwjCjaAoZxpK6jQBqiRZ46BFdmgQXXnXzOsT08qgZmxjL
         UUDYmILBpsjly0pTD+y4a1tm5O1/aiAIfxduB6WZIEa0mZqAnDZ0pTlhjv6bQ+G4tmu0
         p1V9KU1yJ+Nz5b3ZK7ECZawrzsjgj2xTdhwq1mXo1x12O+6sAvjh6637PACDKvotJdKx
         YPeWfcjXYlbSBAQttqR3bqd0VO2k4Lf9PvqBnLGz/kQ8JYr7yrvkuaURFyTC7udYY0i/
         Ro2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ywwb2zJHaIFNjSQOhqCmHZmRwQwtwKhmlrvLgQ+t+Tg=;
        fh=Xw/eskD8H0hPe+1nArgvzdjkQW9xa77jTaWHX86inec=;
        b=LcPu8rrwHXhb1+PP9EQ2S4zV+bZ1yl42cV/msoYT2md87i+WRBybOZqBcpN5yOAw9r
         SzfPfquNw1xbOY9JQixZ8+gSKDLuO5UkXIaX8hv/X0lU631Eq3QES4NEenbYMVjbQic9
         aggCYcrIMjtpEqroNsgga0iXLSgaq0ChYC4JCnEXTv1/HANd9JXKJaBpvqctlnZNuLUu
         A7Hmpgk06+pp8Sw2Zl9O4CyiMb9Z4kxJPNWUGKmSxfH67CJ10DXmv6CBmsMJxW8y/wog
         OD/AwZEcBVz6xeuMHQ9jOfP4KNTuJCdMPOCWsAcptRZ/dEYY2XjP84u2NLYeRFyUtVel
         JgYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790827195; x=1791431995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ywwb2zJHaIFNjSQOhqCmHZmRwQwtwKhmlrvLgQ+t+Tg=;
        b=cwtaXyA8+DEpkP3kx8faRD87R2av2SFFcHmzcAihOwIC4826BafRF0YWeM23RUv+t3
         R1BJgFJrogeHKrG+ctyAS762llUZCEVUokwkOn8k/R1D0iqZ4Z2IQBVEm6bUYtOtBXqv
         nlux+OEJOIvjP/E6FKO8H2RBrShnWXLiz3CDqruvXgagFFN06GlplMsCmiEf8SeE4576
         SYGkB1fVhPEuHTo8AJAPjVsUFApK1/FnJopsmEqULz0pWV50u60mHuhVqgqIc9lgcRUz
         Y6b8vJlMnTGaj5Damldl7h88xpBABJ7C/TAmjC4WfrMhYSpBNVy6mt4HkjHzmI0lUjTo
         w1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790827195; x=1791431995;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ywwb2zJHaIFNjSQOhqCmHZmRwQwtwKhmlrvLgQ+t+Tg=;
        b=vzory5Xh31RJ9u7BAtTDyQcSJQ9D9mCQxW/klsj3wd/OPqU+YDzTtSSZimfxIsf7yL
         Xum22FiZpPUPOwZwaKAsWrt8s4dmrNwAixxowzj4x6TSpwORIY8NvhkcvNJiP8xFfQe8
         gRAQCikpbIjmMgc/L+NL+wDyKppmpVM6Y5BlNz5lpu490ctc4pSiIvTg/vmjAvYpwJ1b
         A66VY2LHJzu/Ini1Hn4Zk8R5faMHmyDhLfiLDxsdMd0JFiYpWMDQ6QdFEEH8b4s86I0H
         cwWtmuUeK7mu4y8dNMm0FBYZypFPtX9aE1j+LfhBQVhvQSx85wP0oFO8LG5B8crqall8
         e2Zg==
X-Forwarded-Encrypted: i=1; AKwUvBwYBDvQePpORV2QanvRmE9aDBReqgwLbMThqkJDfQDF1SCR6DDXbSdF2R/nMT1LKr3NW5IZER4=@vger.kernel.org
X-Gm-Message-State: AFuF++njPF54PgiRowY6zki+6Wg7lgfhEhVi81eRRughHzeP2xqe7+cs
	vOINF9eRR8s4d7KlolqVExLmMhlQ/r3xY5uPz8pajVPZ+/w6tuEjDsM9AuJodmuL9eKRzi9YaKR
	yTgFxhjRaXbARju7qjUMS0Ayq72ZQDDoOmowPfush
X-Gm-Gg: AYBFou3DcKKo4aaB0BPo3jd9zoyPMCxJrehQEr9qvT+Zs7veyZse85Vw3h4Cwc31GKc
	ZQQwjcFd3sSy5GexrykX5WwaAmoboUosUlCYblbxpBXCLdHjs5F5JPuryE2M7nm17v/CCKbB5Cp
	9g49HoLtbpaSXPwJ8SuX8ufGGl2ZbBUqfA+NHl2wZlock6tOWIc8hFHF+qiSfgWp1oLE8yHqod3
	my2rtbawbsQgB5fQkLD8h23iwvgaHmghaYzbvaIYwB36BgjiDXNTff0JM6Q7+crG8PpYLs91mWU
	GXCSnFzAFmwp8ng85HPLcYCv5nMJaJnqu+CuvTVDk+oSi/+h+H91AFugedk3zoBSYUhLa2NI/Ln
	Oz7nu+1/OAn47jLX/H9wBHcQAsVuNU24nYzZnwXTTRUBRU8F3VQIC9KGoVutI1EEfsDg=
X-Received: by 2002:a05:701b:4511:10b0:149:f2b3:ef78 with SMTP id
 a92af1059eb24-14d3348e2femr3016102c88.32.1790827194314; Wed, 30 Sep 2026
 20:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com> <20260928-work-unix-passpidfd-v3-2-532018a91b21@amutable.com>
In-Reply-To: <20260928-work-unix-passpidfd-v3-2-532018a91b21@amutable.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 30 Sep 2026 20:59:42 -0700
X-Gm-Features: AclHuK-Ya3wsqs8meD2kLmWdhIUvmp-Bq6013K1cUrm-VFKKFzhmNEX86QW6AHM
Message-ID: <CAAVpQUD3XomEde8kR2m1776rPwkJwp_qHraAiWbdrWk6Y+=RaQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] af_unix: record the pid of the sending thread
To: Andrew Halaney <andrew@amutable.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:27=E2=80=AFAM Andrew Halaney <andrew@amutable.com=
> wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> Currently only the struct pid of the thread-group leader is recorded.
> The identity of the actual thread that sent the message or is connected
> to a given socket cannot be retrieved.
>
> Add the plumbing to make it possible to retrieve a pidfd for the sender.
> Nothing uses the thread-specific struct pid yet. No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>
> ---
>  include/net/scm.h  |  7 +++----
>  net/core/scm.c     | 21 +++++++++++++++++----
>  net/unix/af_unix.c | 23 +++++++++++++----------
>  net/unix/af_unix.h |  3 ++-
>  4 files changed, 35 insertions(+), 19 deletions(-)
>
> diff --git a/include/net/scm.h b/include/net/scm.h
> index 86ae6bc109ec..aa7d15c5fc27 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -42,7 +42,7 @@ struct scm_fp_list {
>  };
>
>  struct scm_cookie {
> -       struct pid              *pid;           /* Skb credentials */
> +       DECLARE_PIDS(pid, PIDTYPE_TGID);        /* Skb credentials by pid=
 type */
>         struct scm_fp_list      *fp;            /* Passed files         *=
/
>         struct scm_creds        creds;          /* Skb credentials      *=
/
>  #ifdef CONFIG_SECURITY_NETWORK
> @@ -69,7 +69,7 @@ static __inline__ void unix_get_peersec_dgram(struct so=
cket *sock, struct scm_co
>  static __inline__ void scm_set_cred(struct scm_cookie *scm,
>                                     struct pid *pid, kuid_t uid, kgid_t g=
id)
>  {
> -       scm->pid =3D get_pid(pid);
> +       scm->pid[PIDTYPE_TGID] =3D get_pid(pid);
>         scm->creds.pid =3D pid_vnr(pid);
>         scm->creds.uid =3D uid;
>         scm->creds.gid =3D gid;
> @@ -77,8 +77,7 @@ static __inline__ void scm_set_cred(struct scm_cookie *=
scm,
>
>  static __inline__ void scm_destroy_cred(struct scm_cookie *scm)
>  {
> -       put_pid(scm->pid);
> -       scm->pid =3D NULL;
> +       put_pids(scm->pid);
>  }
>
>  static __inline__ void scm_destroy(struct scm_cookie *scm)
> diff --git a/net/core/scm.c b/net/core/scm.c
> index f0d44ecdb11f..9b9e119c353a 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -149,6 +149,7 @@ EXPORT_SYMBOL(__scm_destroy);
>
>  static inline int scm_replace_pid(struct scm_cookie *scm, struct pid *pi=
d)
>  {
> +       struct pid *thread_pid;
>         int err;
>
>         /* drop all previous references */
> @@ -158,7 +159,18 @@ static inline int scm_replace_pid(struct scm_cookie =
*scm, struct pid *pid)
>         if (unlikely(err))
>                 return err;
>
> -       scm->pid =3D pid;
> +       /* A sender naming its own thread-group sends from the current th=
read. */
> +       if (pid =3D=3D task_tgid(current))
> +               thread_pid =3D task_pid(current);
> +       else
> +               thread_pid =3D pid;
> +
> +       err =3D pidfs_register_pid(thread_pid);
> +       if (unlikely(err))
> +               return err;
> +
> +       scm->pid[PIDTYPE_TGID] =3D pid;
> +       scm->pid[PIDTYPE_PID] =3D get_pid(thread_pid);
>         scm->creds.pid =3D pid_vnr(pid);
>         return 0;
>  }
> @@ -207,7 +219,8 @@ int __scm_send(struct socket *sock, struct msghdr *ms=
g, struct scm_cookie *p)
>                         if (err)
>                                 goto error;
>
> -                       if (!p->pid || pid_vnr(p->pid) !=3D creds.pid) {
> +                       if (!p->pid[PIDTYPE_TGID] ||
> +                           pid_vnr(p->pid[PIDTYPE_TGID]) !=3D creds.pid)=
 {
>                                 struct pid *pid;
>                                 err =3D -ESRCH;
>                                 pid =3D find_get_pid(creds.pid);
> @@ -504,10 +517,10 @@ static void scm_pidfd_recv(struct msghdr *msg, stru=
ct scm_cookie *scm)
>                 return;
>         }
>
> -       if (!scm->pid)
> +       if (!scm->pid[PIDTYPE_TGID])
>                 return;
>
> -       pidfd =3D pidfd_prepare(scm->pid, PIDFD_STALE, &pidfd_file);
> +       pidfd =3D pidfd_prepare(scm->pid[PIDTYPE_TGID], PIDFD_STALE, &pid=
fd_file);
>
>         if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
>                 if (pidfd_file) {
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 42cffeafc8c1..c7d423465859 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1973,7 +1973,7 @@ static void unix_destruct_scm(struct sk_buff *skb)
>  {
>         struct scm_cookie scm =3D {};
>
> -       swap(scm.pid, UNIXCB(skb).pid);
> +       swap_pids(scm.pid, UNIXCB(skb).pid);
>
>         if (UNIXCB(skb).fp)
>                 unix_detach_fds(&scm, skb);
> @@ -1991,7 +1991,7 @@ static int unix_scm_to_skb(struct scm_cookie *scm, =
struct sk_buff *skb, bool sen
>  {
>         int err =3D 0;
>
> -       UNIXCB(skb).pid =3D get_pid(scm->pid);
> +       get_pids(UNIXCB(skb).pid, scm->pid);
>         UNIXCB(skb).uid =3D scm->creds.uid;
>         UNIXCB(skb).gid =3D scm->creds.gid;
>         UNIXCB(skb).fp =3D NULL;
> @@ -2005,7 +2005,10 @@ static int unix_scm_to_skb(struct scm_cookie *scm,=
 struct sk_buff *skb, bool sen
>
>  static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *scm)
>  {
> -       scm_set_cred(scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).g=
id);
> +       get_pids(scm->pid, UNIXCB(skb).pid);

nit: keep scm_set_cred() here and rather move get_pid()
from scm_set_cred() to scm_send().


> +       scm->creds.pid =3D pid_vnr(scm->pid[PIDTYPE_TGID]);
> +       scm->creds.uid =3D UNIXCB(skb).uid;
> +       scm->creds.gid =3D UNIXCB(skb).gid;
>         unix_set_secdata(scm, skb);
>  }
>
> @@ -2025,20 +2028,20 @@ static void unix_skb_to_scm(struct sk_buff *skb, =
struct scm_cookie *scm)
>  static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *=
sk,
>                                 const struct sock *other)
>  {
> -       if (UNIXCB(skb).pid)
> +       if (UNIXCB(skb).pid[PIDTYPE_TGID])
>                 return 0;
>
>         if (unix_may_passcred(sk) || unix_may_passcred(other) ||
>             !other->sk_socket) {
> -               struct pid *pid;
>                 int err;
>
> -               pid =3D task_tgid(current);
> -               err =3D pidfs_register_pid(pid);
> -               if (unlikely(err))
> +               get_task_pids(UNIXCB(skb).pid, current);
> +               err =3D pidfs_register_pids(UNIXCB(skb).pid);
> +               if (unlikely(err)) {
> +                       put_pids(UNIXCB(skb).pid);
>                         return err;
> +               }
>
> -               UNIXCB(skb).pid =3D get_pid(pid);
>                 current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
>         }
>
> @@ -2048,7 +2051,7 @@ static int unix_maybe_add_creds(struct sk_buff *skb=
, const struct sock *sk,
>  static bool unix_skb_scm_eq(struct sk_buff *skb,
>                             struct scm_cookie *scm)
>  {
> -       return UNIXCB(skb).pid =3D=3D scm->pid &&
> +       return UNIXCB(skb).pid[PIDTYPE_TGID] =3D=3D scm->pid[PIDTYPE_TGID=
] &&
>                uid_eq(UNIXCB(skb).uid, scm->creds.uid) &&
>                gid_eq(UNIXCB(skb).gid, scm->creds.gid) &&
>                unix_secdata_eq(scm, skb);
> diff --git a/net/unix/af_unix.h b/net/unix/af_unix.h
> index 8119dbeef3a3..402742895acc 100644
> --- a/net/unix/af_unix.h
> +++ b/net/unix/af_unix.h
> @@ -2,6 +2,7 @@
>  #ifndef __AF_UNIX_H
>  #define __AF_UNIX_H
>
> +#include <linux/pid_types.h>
>  #include <linux/uidgid.h>
>
>  #define UNIX_HASH_MOD  (256 - 1)
> @@ -11,7 +12,7 @@
>  struct sock *unix_peer_get(struct sock *sk);
>
>  struct unix_skb_parms {
> -       struct pid              *pid;           /* skb credentials      *=
/
> +       DECLARE_PIDS(pid, PIDTYPE_TGID);        /* skb credentials by pid=
 type */
>         kuid_t                  uid;
>         kgid_t                  gid;
>         struct scm_fp_list      *fp;            /* Passed files         *=
/
>
> --
> 2.55.0
>
