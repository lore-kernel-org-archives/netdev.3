Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFA23C5DD4
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774938; cv=pass; b=WU5DJZ067gh/ym8HcHnWUJXVZT+Q0AXTjpq5xu3gwtL6aYTzx5wMu+3GAKbJw59FabVz+a/gUJVvcxBSglWuQFjyROlcoSlDlA4f0zfqJYdL8pBmxVv+iLNmGyn+GOkDWM+mNs6miIdlPN4edX9Z3PkvWuB57mqJ23oPdmp2K/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774938; c=relaxed/simple;
	bh=QMq/3wt6gqw+Gsc9uIo3bo3qvi85hMrqTTGnYwngynM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llVXrc0MG8QIooNGDrmhF41rmSVD69zPSBcMKO6kzDazU1RcqJrv9FxMz3bsaxOZ9OCNT4aAfU3DgszXt2TKWiGai7AATB2kT7JCl8duFPYsZrDeywmm6vrjWmFcmZkgID+09WT0effGaG6kSIkkubQK4taHfoQStrBbIHUkvLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=MYgEmecE; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="MYgEmecE"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c262bc686d9so296072566b.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 02:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788774935; cv=none;
        d=google.com; s=arc-20260327;
        b=pr0yOtm645jzTvHAWRyB2TrnsvA4SzILkTdMz5AIrs6Vm3lRccjwjROri2XOz/S4R1
         fMUOrzTaY22mVMtWLM9RFKkaLGPtPnLnzk3PDQyYmaZB0gR4i8Sej5TGnm2g5pRTDGH9
         CcpR/f2YylO+TOdFDFRKOD8qxEy5dnd1hjsO12OK7cntN34S0dMhP05KgMBWUyWlaSrW
         bdvfZT/1zWa6IiOLsqTRFdMSOGG29H1Ygu5MPnK07frtfsaVtjWPfT9b9I8ebxHqmw6H
         Y4xSKrKMRFiKLExpHcEe4wjXcilexU/PwxvGZdiHbaxKH/y+twzkjQb+lcC9mXxDZguc
         UDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jEmqdy7P1JtEe/4sIlPPVfS6r5YyiIUkbZDzj02rKPM=;
        fh=tkY81S4O/e659Fc9kQ+jdu6Q7c1RJ14EEO5KZVpb2A4=;
        b=nKYKuQJgC0Qzq499O8KXsND7sGfpoiStYAMiX0NspkumTwWhkj5qrRAc6zr/R2ysyO
         Oy++fSCtVpXmoaZJ52Gf25R3EAYLkGO/oY6sdrytv0s1a91MpvDParos6qFxXk1JNT9h
         CIYj9rC3bavqowyTCiurzBr5Mb3BJDYSMkYB7FAfVl09blt71C5fyFv9qeiRv8YVk+ER
         LZ9A+JNDuDk8kgSbdl4eQAbgoh1AO4b7TwmLTjaQf+8aKiRReqI0hspYSqxtuGKdeaAE
         UPZ3/N0W9oC/ZECiwBGrUMq0HuxmJEgzZJXHowZClFjPi4n9q+rabE942XbQDlMNJaih
         QvUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1788774935; x=1789379735; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jEmqdy7P1JtEe/4sIlPPVfS6r5YyiIUkbZDzj02rKPM=;
        b=MYgEmecEwL8ZaJK2nSZO7N5BTZEtcQySZb/OZgdTiArJVQLT0dPqr+2GpXqLpecX3v
         H9fy4tbMuGZ8nOP8iqjfvP8TCwPEg0t6+SyyIesYy8u7DRFoOCruPhwWorQBn/FhrZPQ
         XkCHuqJcHmJuEBWQfEF7ql1+cKgFONGtxoFCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774935; x=1789379735;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jEmqdy7P1JtEe/4sIlPPVfS6r5YyiIUkbZDzj02rKPM=;
        b=DYsBFJ5qy5IbTlVbrOMtroLEv8eNv9fUcHOy6ZY0F0mFE3pPm5K8TLf/aY0JhiFf4c
         z1BtfH4UlZPG0LhwmUN/wmspCC1XqXkXDdFMBxipJp4z1hWH3pFLulKgyunsXAc7T7qj
         dwPOAlMcXym8JwV2GmIHDHqYPifdYLdNS5/WeDsjl7lEVU14rdNl/TeHyJ5l+yg95hJu
         mXlK4+PNQvb0H88NN1mGgAUNtxDvck5qbM9nmvSxkK79G+oxqC+ehcern+DzJV9rwcxV
         B/sm+7iIwN3am5pAFwEC1yizD4T+R71CT0GPxqBuJhDaDHCtsRTtWKWkAokGZ286mrGS
         /5tw==
X-Forwarded-Encrypted: i=1; AKwUvBw2wp9MyRJNxIZe8uiDLkEuosOyeRaSmKWb51KHndVHDSWt2jXXJIZXf2VCO5goDXPBmSdhjUI=@vger.kernel.org
X-Gm-Message-State: AFuF++l9ka1XLcaMYnMyGywxDAWPxCQNRQKhVX/+yG2Y4q5QYFCS0V5C
	amAG+tUuHQ4mhpdOeGnl+0syUWneWRAc8bDhdhA7ZhVB43c4l4MvCqpCEz/vY/1m0wABLFB8sf7
	bM5C7a37WtlnGRTm3XRXAHzXOGQIuB32M1Y7w4MMP9g==
X-Gm-Gg: AYBFou1947CvN869guVWtUEoHF+XY/mQjoG96PJe0+fehFRdOsXJrTcSjICVI3VQfwJ
	TZOmb9xerqd+0plGBm6TVbwShkXfBT8bwM26U2W7nrw/CKaoqin15HrFSewftT/x8JGhtbu3cQd
	bu/XgPZiyb4OPjlhjGqJS9WeeSnOK6u9r8uRpOsyTAVQFHTR4Eg75/4JwRa2SIvIVvPdGhHpDJK
	m/boF1QGIUZ3GVzctqeHR7GZm72yrJrRV7Yr/dgaRkAWMlWas8CNCjuu7VKSHs4xDLGT/nun3Wc
	wWS2SsGazg3DZz4Y5NgIzZA6GVRz0fWZyGN4PcJuPGiO5xyDiaQQbReTTIlSfip7Azisj8ZVL+0
	=
X-Received: by 2002:a17:906:4fc7:b0:c25:8bf0:36ef with SMTP id
 a640c23a62f3a-c260c987f6bmr826311266b.14.1788774934516; Mon, 07 Sep 2026
 02:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org> <20260831-work-unix-passpidfd-v1-2-70cbfda0c7ba@kernel.org>
In-Reply-To: <20260831-work-unix-passpidfd-v1-2-70cbfda0c7ba@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 7 Sep 2026 11:55:23 +0200
X-Gm-Features: AcwNN1WsTyP8--pMd2iX9H-j2E4UJYkittYgJSq5id6vWYQXtW8MRT3JzKNcglo
Message-ID: <CAJqdLrooAYAcgzug=+idiPfqsZ0HGaqi29STuw7uzDh7eEB1xQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] af_unix: record the pid of the sending thread
To: Christian Brauner <brauner@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Mo., 31. Aug. 2026 um 13:21 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Currently only the struct pid of the thread-group leader is recorded.
> The identity of the actual thread that sent the message or is connected
> to a given socket cannot be retrieved.
>
> Add the plumbing to make it possible to retrieve a pidfd for the sender.
> Nothing uses the thread-specific struct pid yet. No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
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
> +       DECLARE_PIDS(pid, PIDTYPE_TGID);        /* Skb credentials by pid type */
>         struct scm_fp_list      *fp;            /* Passed files         */
>         struct scm_creds        creds;          /* Skb credentials      */
>  #ifdef CONFIG_SECURITY_NETWORK
> @@ -69,7 +69,7 @@ static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_co
>  static __inline__ void scm_set_cred(struct scm_cookie *scm,
>                                     struct pid *pid, kuid_t uid, kgid_t gid)
>  {
> -       scm->pid = get_pid(pid);
> +       scm->pid[PIDTYPE_TGID] = get_pid(pid);
>         scm->creds.pid = pid_vnr(pid);
>         scm->creds.uid = uid;
>         scm->creds.gid = gid;
> @@ -77,8 +77,7 @@ static __inline__ void scm_set_cred(struct scm_cookie *scm,
>
>  static __inline__ void scm_destroy_cred(struct scm_cookie *scm)
>  {
> -       put_pid(scm->pid);
> -       scm->pid = NULL;
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
>  static inline int scm_replace_pid(struct scm_cookie *scm, struct pid *pid)
>  {
> +       struct pid *thread_pid;
>         int err;
>
>         /* drop all previous references */
> @@ -158,7 +159,18 @@ static inline int scm_replace_pid(struct scm_cookie *scm, struct pid *pid)
>         if (unlikely(err))
>                 return err;
>
> -       scm->pid = pid;
> +       /* A sender naming its own thread-group sends from the current thread. */
> +       if (pid == task_tgid(current))
> +               thread_pid = task_pid(current);
> +       else
> +               thread_pid = pid;

Hi Christian,

The patch looks good to me, but this spot raised some doubts for me.

If scm_replace_pid() is called with pid == task_tgid(current) then all
good, because we
get scm->pid[PIDTYPE_TGID] == pid and  scm->pid[PIDTYPE_PID] ==
task_pid(current). All good.

If scm_replace_pid() is supplied with pid that has a type PIDTYPE_TGID, then:
- scm->pid[PIDTYPE_TGID] == pid. Good.
- scm->pid[PIDTYPE_PID] = pid. Doesn't looks correct, shoudn't we do
something like:
{
        struct task_struct *task;

        rcu_read_lock();
        task = pid_task(pid, PIDTYPE_TGID);
        thread_pid = task_pid(task);
        rcu_read_unlock();
}

to get a correct thread_pid for both cases here?

Kind regards,
Alex

> +
> +       err = pidfs_register_pid(thread_pid);
> +       if (unlikely(err))
> +               return err;
> +
> +       scm->pid[PIDTYPE_TGID] = pid;
> +       scm->pid[PIDTYPE_PID] = get_pid(thread_pid);
>         scm->creds.pid = pid_vnr(pid);
>         return 0;
>  }
> @@ -207,7 +219,8 @@ int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
>                         if (err)
>                                 goto error;
>
> -                       if (!p->pid || pid_vnr(p->pid) != creds.pid) {
> +                       if (!p->pid[PIDTYPE_TGID] ||
> +                           pid_vnr(p->pid[PIDTYPE_TGID]) != creds.pid) {
>                                 struct pid *pid;
>                                 err = -ESRCH;
>                                 pid = find_get_pid(creds.pid);
> @@ -504,10 +517,10 @@ static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
>                 return;
>         }
>
> -       if (!scm->pid)
> +       if (!scm->pid[PIDTYPE_TGID])
>                 return;
>
> -       pidfd = pidfd_prepare(scm->pid, PIDFD_STALE, &pidfd_file);
> +       pidfd = pidfd_prepare(scm->pid[PIDTYPE_TGID], PIDFD_STALE, &pidfd_file);
>
>         if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
>                 if (pidfd_file) {
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 13f9926bf205..011af84e3626 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1973,7 +1973,7 @@ static void unix_destruct_scm(struct sk_buff *skb)
>  {
>         struct scm_cookie scm = {};
>
> -       swap(scm.pid, UNIXCB(skb).pid);
> +       swap_pids(scm.pid, UNIXCB(skb).pid);
>
>         if (UNIXCB(skb).fp)
>                 unix_detach_fds(&scm, skb);
> @@ -1991,7 +1991,7 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
>  {
>         int err = 0;
>
> -       UNIXCB(skb).pid = get_pid(scm->pid);
> +       get_pids(UNIXCB(skb).pid, scm->pid);
>         UNIXCB(skb).uid = scm->creds.uid;
>         UNIXCB(skb).gid = scm->creds.gid;
>         UNIXCB(skb).fp = NULL;
> @@ -2005,7 +2005,10 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
>
>  static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *scm)
>  {
> -       scm_set_cred(scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
> +       get_pids(scm->pid, UNIXCB(skb).pid);
> +       scm->creds.pid = pid_vnr(scm->pid[PIDTYPE_TGID]);
> +       scm->creds.uid = UNIXCB(skb).uid;
> +       scm->creds.gid = UNIXCB(skb).gid;
>         unix_set_secdata(scm, skb);
>  }
>
> @@ -2025,20 +2028,20 @@ static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *scm)
>  static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
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
> -               pid = task_tgid(current);
> -               err = pidfs_register_pid(pid);
> -               if (unlikely(err))
> +               get_task_pids(UNIXCB(skb).pid, current);
> +               err = pidfs_register_pids(UNIXCB(skb).pid);
> +               if (unlikely(err)) {
> +                       put_pids(UNIXCB(skb).pid);
>                         return err;
> +               }
>
> -               UNIXCB(skb).pid = get_pid(pid);
>                 current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
>         }
>
> @@ -2048,7 +2051,7 @@ static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
>  static bool unix_skb_scm_eq(struct sk_buff *skb,
>                             struct scm_cookie *scm)
>  {
> -       return UNIXCB(skb).pid == scm->pid &&
> +       return UNIXCB(skb).pid[PIDTYPE_TGID] == scm->pid[PIDTYPE_TGID] &&
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
> -       struct pid              *pid;           /* skb credentials      */
> +       DECLARE_PIDS(pid, PIDTYPE_TGID);        /* skb credentials by pid type */
>         kuid_t                  uid;
>         kgid_t                  gid;
>         struct scm_fp_list      *fp;            /* Passed files         */
>
> --
> 2.53.0
>
