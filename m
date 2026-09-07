Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D72264CA
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776958; cv=pass; b=gafZM417jTaFa2blMlke59yWdUt2wbdgNi4b1Op9rv0BoGfSQsGolG9KECe20Wud14IFEUq50/ncOjrxzwT2BF1m/FTM10YWcAvkATYex44oEa+cOxNol3QTczznaanFeogF6ixwrbEaninwGDLHDaBDaC+GLYylwyCypVwYBLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776958; c=relaxed/simple;
	bh=/pPCcmo1c+POG45z52X2BnuE0gA1n9usXKsFAtkEfko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uM5QrbbbN0MoDmKjBYS9VR/ki1QLC9JPqM2RG24rMUFJwf8iTmKolMSv0dVD2S7+TwKrGLIghf5A7mdDHdvAiwEIlal45g5XBHJP0NgTXWBtrG/Q7ZfbOPzjeXeSCt7L262F0ybBQuq65e8ZrBKnDup8zE1+17fZHBmA5cN6lt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=PsWOR6uc; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="PsWOR6uc"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c207cb16cf5so512637666b.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 03:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788776955; cv=none;
        d=google.com; s=arc-20260327;
        b=hAJif3iQUWBWossNxn9iTpDBIJDXXuYcLP28y1de18LJNih3F7JdalOIJwDzjbrx6H
         9PyQb3LvYUcOmjEeq9xvM5JPWmxNVbyu6xQwRSrW4yDux5fsm13V9VXWrXScgOslajDn
         S6hiqUaxuIFu7eI3rtyr1dzLFn8730qwc402gDyBkO5fQ1dc3wpLzOF/pd/RIBvF3XQH
         BYokaf8VhEIXaP3ChKIGWDS/xkiyUIqtEVO3i1QFCVfmlCCs4Z2ZOyRtymrK4qpiyLwv
         GkLSaQdud5GquO5M6f9sPFqGicH0fmuIIY5Hacvzgv9tTV+nCccwi8LvH7Rs7lraH6H7
         CjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9774GFxLNjPLVY7G1GzEmZBrWX8xiW+2/RWdji5WoSE=;
        fh=hYF3DY9u+RXB623Xvr0jEG9eHf1aosKhhU0z1ykCZjc=;
        b=rkSB9LefwdERcEDT1egL4SPuVxTeoHrcmoWgJXLFLXJ+iZSO0IiKWJVLPHa9mzP/T5
         nx5CEywvuLZ253bKREdLuNlorpLXOe4fpeF8eyqdC/4EQCHgk1xoppdxkiZm6e6BCRDy
         0p2klL1Z3JjoB271MJx7pSddwz4/dK+/Ndcglu3pQzGwIiWfE0/7c5a9YLTt5YB6oUnt
         j2lUGzRbdSTzsRJ2k9pYabEohaGMAeHoBuXWL0m+CDywr1QU/jltbZhb3bn6wSyv60KB
         qNxaE4q0FcG1bfWgKpFWwXqgRfrbfclAewowD8lE/lBlhOA6Cf14Emvfk21wFabocJU9
         dKXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1788776955; x=1789381755; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9774GFxLNjPLVY7G1GzEmZBrWX8xiW+2/RWdji5WoSE=;
        b=PsWOR6ucWs5LNiilAtlGMAErC1D8j4USrRdAR5Ndh9HolAQA27ZvKoBb+NIf8hUjL/
         YZhLgdX8YzmlOLFbD0FH3lppfDuU3JSWwrlpWbCLX/qs9LNqQaAdE7qUC7POycAKqNCM
         cuK7x5WfpYTmtmwE0EOlAiBlFDlrCe89Vmbsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788776955; x=1789381755;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9774GFxLNjPLVY7G1GzEmZBrWX8xiW+2/RWdji5WoSE=;
        b=gceLvfHrnufxRC6aa5tu8NXOY4TSBgPnefF0Yt5D0ED9VKWsqA9vUGwj4d2FZE6iz2
         0TygwA1CX2f7XA4BzepUGq2EAIZbr0p4X4pWY11KKohTrF5Fq4t+Lo9N5VYZIt0CtLdP
         SCrCSdJoVt+WD+eSk8bgEoEG8L4g5069kXDQgsk2nqH1pfLXZJEFGVanKZND01ayG+yi
         eJJ7m7TT+OVZUalmDoWUhfCR9jm4BucI5m4gVXg31Sebz7v53Qu8vvMvLadCv0S/W52s
         6hEP01/W2I56vUlQc34TH7talUYWcXlXs7SVSIF8Bi3h0IKH/4jMc0jFJCbp8y0xD/UC
         keiw==
X-Forwarded-Encrypted: i=1; AKwUvBxM6fQmbMDxIEG4V2CNp/h6IL4OwJzDxZlSaSXODnhRM4ZPpchJXXXEARIqpqw/SGcClvh10VE=@vger.kernel.org
X-Gm-Message-State: AFuF++kTU5yPIgt122bNwgF7PyawBTL5oTSbdwmrvvk9KCDTTebtgNpj
	pj/WVbbu44fC52H0k34RM2yJJFQ7c8ivhFjIy8Dax+lYjvlkgq4OJmgfE3ra+M47+Hc1JjSSLUQ
	CWLeAxu+5r/LCVyv8bD0OyXktMdfLzkNk3+Bthwk9ig==
X-Gm-Gg: AYBFou35e7qpvWab2D7OoUNvTd2nqc+yRZ8tEBLHyHssTDg7wkLg00MlGwBuUh5j1N3
	1kExxCfnWbMRsUFDA6ssgz/lULykfEBR7LZOn/0nF4Oioecm82esKPMAhfo+HaM3hwB/1d7glmQ
	3Hk4bkjJgk+IDenQZ20WGxeLhUTfS8qLpQIy7zvNDR6gfmFygDUEiyg+vVuiUKwCd7ZCkMmxPCG
	Q71E/DzpyHooqFurjPIMeAq5/lkJw5aE5fOrb5facgHp/FDmHFwYN3e6wPKZiFZcTz5KznUbqQS
	uzRuuTlocpm5F3feQQgH7Tz1IH4wTR3SwuferElz3SCvb1gliVqlrCiVVcAYZU6JeGlnSRvJFlw
	=
X-Received: by 2002:a17:907:c705:b0:c25:62db:772b with SMTP id
 a640c23a62f3a-c260c8b141amr822489666b.7.1788776954579; Mon, 07 Sep 2026
 03:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org> <20260831-work-unix-passpidfd-v1-6-70cbfda0c7ba@kernel.org>
In-Reply-To: <20260831-work-unix-passpidfd-v1-6-70cbfda0c7ba@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 7 Sep 2026 12:29:03 +0200
X-Gm-Features: AcwNN1WlWJvrJ2vB2H7lv9qLS355J43HWilCGyv40E-X7Jm5rVAZmAIMZ0pzCnI
Message-ID: <CAJqdLrqS==7gt+bshJ8DzyaqVek_57fqUnT8EFCAboZF1ufcCA@mail.gmail.com>
Subject: Re: [PATCH 06/10] af_unix: record the pid of the connecting thread
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
> The identity of the actual thread that connected to a given socket
> cannot be retrieved.
>
> Add the plumbing to make it possible to retrieve a pidfd for the
> connecting thread. Nothing uses the thread-specific struct pid yet. No
> functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

LGTM

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  net/unix/af_unix.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 335abd23c9bf..d01ee76c8026 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -743,51 +743,47 @@ struct unix_peercred {
>
>  static inline int prepare_peercred(struct unix_peercred *peercred)
>  {
> -       struct pid *pid;
>         int err;
>
> -       pid = task_tgid(current);
> -       err = pidfs_register_pid(pid);
> -       if (likely(!err)) {
> -               peercred->peer_pid[PIDTYPE_TGID] = get_pid(pid);
> -               peercred->peer_cred = get_current_cred();
> +       get_task_pids(peercred->peer_pid, current);
> +       err = pidfs_register_pids(peercred->peer_pid);
> +       if (unlikely(err)) {
> +               put_pids(peercred->peer_pid);
> +               return err;
>         }
> -       return err;
> +
> +       peercred->peer_cred = get_current_cred();
> +       return 0;
>  }
>
>  static void drop_peercred(struct unix_peercred *peercred)
>  {
>         const struct cred *cred = NULL;
> -       struct pid *pid = NULL;
>
>         might_sleep();
>
> -       swap(peercred->peer_pid[PIDTYPE_TGID], pid);
> +       put_pids(peercred->peer_pid);
>         swap(peercred->peer_cred, cred);
> -
> -       put_pid(pid);
>         put_cred(cred);
>  }
>
>  static inline void init_peercred(struct sock *sk,
>                                  const struct unix_peercred *peercred)
>  {
> -       sk->sk_peer_pid[PIDTYPE_TGID] = peercred->peer_pid[PIDTYPE_TGID];
> +       memcpy(sk->sk_peer_pid, peercred->peer_pid, sizeof(sk->sk_peer_pid));
>         sk->sk_peer_cred = peercred->peer_cred;
>  }
>
>  static void update_peercred(struct sock *sk, struct unix_peercred *peercred)
>  {
>         const struct cred *old_cred;
> -       struct pid *old_pid;
>
>         spin_lock(&sk->sk_peer_lock);
> -       old_pid = sk->sk_peer_pid[PIDTYPE_TGID];
> +       swap_pids(sk->sk_peer_pid, peercred->peer_pid);
>         old_cred = sk->sk_peer_cred;
> -       init_peercred(sk, peercred);
> +       sk->sk_peer_cred = peercred->peer_cred;
>         spin_unlock(&sk->sk_peer_lock);
>
> -       peercred->peer_pid[PIDTYPE_TGID] = old_pid;
>         peercred->peer_cred = old_cred;
>  }
>
> @@ -796,7 +792,7 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
>         lockdep_assert_held(&unix_sk(peersk)->lock);
>
>         spin_lock(&sk->sk_peer_lock);
> -       sk->sk_peer_pid[PIDTYPE_TGID] = get_pid(peersk->sk_peer_pid[PIDTYPE_TGID]);
> +       get_pids(sk->sk_peer_pid, peersk->sk_peer_pid);
>         sk->sk_peer_cred = get_cred(peersk->sk_peer_cred);
>         spin_unlock(&sk->sk_peer_lock);
>  }
>
> --
> 2.53.0
>
