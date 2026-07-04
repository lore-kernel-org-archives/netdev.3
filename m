Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194EF33C51D
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 01:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783129597; cv=pass; b=coferP8V9Caa7moMZL2xsa1U+LROWke08mRE25lNhfJ5NISCE2Pdjt1/SKSRjXQ/apzmn8oIAbgRGI8eJoSV59CkSs6FuXG2HMLwKPdmJZljTnVQi6qYBKctiOnNtf8ddDYWDDbRwuuQMCmfQyIJ6U+G42Y43Y99CNiQDzQdu/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783129597; c=relaxed/simple;
	bh=U+qGK5MjawjgwtTJjBHTt+Flr9aONnZub9He/eYH6LA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKM/08vQas0slmLeyFrJCcWpbhzofjbuQXKJjO2Qca+FTEyF245cD7TEsOv1pouTrYqkBS0Xnbfa0zWi/hJ6QMHfcURfvqtY9MmAYnbVpNnJ66VIwRPLKnZNbQkAwCVnQOv9ptRI54hsURH7yR69ipNXC87BfnrRjzB//bvur+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=junQqYkC; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="junQqYkC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cac59f8b64so11429075ad.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 18:46:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783129594; cv=none;
        d=google.com; s=arc-20260327;
        b=VbFnIqs+Vl/Kdixdo+4M6yfnDZc6S1G8eLjgXiwszIOxgmYmOofV2b3+N0EbudwHgg
         79fXKJREfcj1t0taTNkcqVKrUk8cJWGwtvi4ArtnvOAMXGPcObZTRzzyG6BAUFM5vCSl
         dVPnRRhEmHM/0WX0BQgdUqch9AB5q8yIwygQTJUZ/5W9d03QlPCSwOFVr2IYxvxemDv+
         eBHC6UDCFF6y2KzmS/tlcUfES8O/yHNF8p/W3wL5dU0KOkKJ1feUpkyDB2btOCyUcNpv
         EkKKanms48ZOyb5HGX40w83LAn8LENmgextKKQzkHbNDObJgKgGeC9f+0WO7641jpBfj
         qMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OcpY4WJ6GwM2ej5g/SmfwoTPc6u8g8skrNTUakBxWU8=;
        fh=mVq4BLOg+hGkvNcnu2JX9cQFJxa5F/1PGP2QF5S6tCw=;
        b=CP08XECKqASRjeVjWoTXJWa0ZeUWF9dKvfrsZXwgJKJmZhmbbAXEKu+kSMnO0Sp+iA
         jWv33UuT0aultLgrZrO51jYUOBJek8/MB+a/EIVnTpgAn+wGwOzB75n/hyE/ojoZ2wB+
         ZK/TMVypwEY26QQ6Rf2uzLhT2tmqkpBQewEEwNBrnUCpEILgi+r+ZnxmqqobzkUql2B3
         1QknqBNhcq0a3Xi0+gCIDVMstDx73uEfQGH3IH8MPfMlzUuetwXR/zqvK2xf8PQYzr0o
         BVwnnnKS6mHtqyU1if1B5YfVL5fqrGvR0iNG0+bCY0y7+PR9llNQliyUheHYf5f613Wb
         g2Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783129594; x=1783734394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcpY4WJ6GwM2ej5g/SmfwoTPc6u8g8skrNTUakBxWU8=;
        b=junQqYkCoLGIRnLl0P6FmyWhYzMHkWbdbotxGeldnUREwddx5gbTqNDd0apO88yTcd
         TJFbIG17+ZgAiBfpygaJqg6WLbVP1261HK3ufiqDlxqalKN/bbWwb/9TmOZy23gX+zcH
         har08CbhlkqEmfxtJ7kNfBJ8kKinAWMLoO2HeM5NjlnH9OpVAFHjspA19I1HTNHB4Z2a
         23MXFMnaDA7dz5U7notp8xoEbQhQ/DQhmCrRpQKye1fZpD6+8LBcClUqyMSN/9IU7ZW8
         gDxSZUIGhLFDBpVbQpPKuC0rE0Fk6hqZi5xrGtn7mPDB9Gzrr+iyrHKsm8F/nSUD4aox
         MNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783129594; x=1783734394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OcpY4WJ6GwM2ej5g/SmfwoTPc6u8g8skrNTUakBxWU8=;
        b=FifW/2gnEDVXBfkaxdnCZsMCZf5AzbK7Ln/gsBGwfLxD1RSmqNPopcb4N+DSwedeYC
         lFsW4qy1RE7KofL6S1NxKup8LPk9tWY00/jCaYDQ5NPXLJ4wzTNBN1tiatcHEBNAbxT+
         SQQBr4yZxJuNnzlqmcly1pKzV7er4UBUAWEdBN0IMoaPMoZ3M2c+9WI0X/+/6cxJ1LtA
         dIUVkeWVm9gD+rlTkxj69FumYHwbApuAMOgDR5DvxvgNyWdfqThPIRLHgNLvSfpOQvHk
         IiBFvr/pqwx2aCh4em6PThVgP9ztfIXWIx7+m4h+y0tvLt5hLJKMJxyr0I1tG0Do5Oe/
         tFIg==
X-Forwarded-Encrypted: i=1; AHgh+RqcZzn5gr4jtV8fjwJz3kf2J+Bsk09RowZQg6Uc/lFK0in+4h1aUl58syXcGphsdGZbvLf3ZgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFrxUWQ/6zjr2Fj8DF9a4uTXnrlia5yENnYHl4VEGsPhjtEJfI
	WzhGjG2GsfuF58VxBixivTXntHkpCOKpiwGAH7mn1b/uclyQvWnqiCglrY3w7fdw5aM7FzXLewt
	SDwIp63fzPXPYf5NeXq+LGD9mRfnLBfjnlgI5oA7l
X-Gm-Gg: AfdE7cmMFYuf6wjquzbQVP6NTDaEBqXpQxoRsAwPB3IUtlG4KUpFmML4jZ7FMh+MM6T
	zmP6Xp9kJZuQaPDT+JTtLe3zybH2x0ok1OmB3iStccUOpK6eac+HIq/jOTcYUd7yrce3AiNG727
	sDi/k73g4zVB7+dbnjXl3UAvyt0xDlIQx/johxiOgXTxn+R1jjn4coQL1cKxd+pw1WItWZrg/AE
	SyzQKSoRQjVAj50LT8LEPzyMO0DwX6i4eRGCJ0GbhuAS6Lu4L7I5W9AbU9Oefjmpocl8JsOrz3f
	djg9kHw32gNUUGTUyElVz2Dpx2nQEtOzNodQBcvANcF2YfUA6VfLcn/SYYAU3mTVTodSCRV5ZcH
	h0E7NbX/l+5MU+1IpNy2HZguM+TGcszrHD7OnL6Qk
X-Received: by 2002:a17:902:f546:b0:2ca:3df2:919a with SMTP id
 d9443c01a7336-2cbb9ec4ebfmr14082885ad.33.1783129593207; Fri, 03 Jul 2026
 18:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703081416.2583118-1-John.Ericson@Obsidian.Systems> <20260703081416.2583118-3-John.Ericson@Obsidian.Systems>
In-Reply-To: <20260703081416.2583118-3-John.Ericson@Obsidian.Systems>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 3 Jul 2026 18:46:21 -0700
X-Gm-Features: AVVi8CcRbbqpU2rHLUwjNHh_m262QeOOgbH1PDJGpXN6hTgHv8KX5C8DwoJd8Jo
Message-ID: <CAAVpQUDvHQp+Y6+y0b8_Oec3nf1o3FLDRtjJCN=ys0wu02Kp4w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] af_unix: Clean up error handling in unix_listen()
To: John Ericson <John.Ericson@obsidian.systems>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, John Ericson <mail@johnericson.me>, 
	Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	David Rheinsberg <david@readahead.eu>, Cong Wang <cwang@multikernel.io>, 
	Sergei Zimmerman <sergei@zimmerman.foo>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 1:15=E2=80=AFAM John Ericson
<John.Ericson@obsidian.systems> wrote:
>
> From: John Ericson <mail@johnericson.me>
>
> To avoid the sort of bug that was just fixed going forward, switch to a
> style where `err =3D -E...;` instead happens right before the `goto`.
> (`err =3D other_function(...);` is not changed.) Then there is no
> spooky-action-at-a-distance between the `err` initialization and the
> `goto`, something which is easier to slip by code review.

Sorry, I meant posting this separately to net-next.git after the
patch 1 is merged to net.git and lands net-next.git.

Also could you remove markdown `` ?


>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: John Ericson <mail@johnericson.me>
> ---
>  net/unix/af_unix.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 10ed9421e43a..7878b27bbaf8 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -813,19 +813,22 @@ static int unix_listen(struct socket *sock, int bac=
klog)
>         struct unix_sock *u =3D unix_sk(sk);
>         struct unix_peercred peercred =3D {};
>
> -       err =3D -EOPNOTSUPP;
> -       if (sock->type !=3D SOCK_STREAM && sock->type !=3D SOCK_SEQPACKET=
)
> +       if (sock->type !=3D SOCK_STREAM && sock->type !=3D SOCK_SEQPACKET=
) {
> +               err =3D -EOPNOTSUPP;
>                 goto out;       /* Only stream/seqpacket sockets accept *=
/
> -       err =3D -EINVAL;
> -       if (!READ_ONCE(u->addr))
> +       }
> +       if (!READ_ONCE(u->addr)) {
> +               err =3D -EINVAL;
>                 goto out;       /* No listens on an unbound socket */
> +       }
>         err =3D prepare_peercred(&peercred);
>         if (err)
>                 goto out;
>         unix_state_lock(sk);
> -       err =3D -EINVAL;
> -       if (sk->sk_state !=3D TCP_CLOSE && sk->sk_state !=3D TCP_LISTEN)
> +       if (sk->sk_state !=3D TCP_CLOSE && sk->sk_state !=3D TCP_LISTEN) =
{
> +               err =3D -EINVAL;
>                 goto out_unlock;
> +       }
>         if (backlog > sk->sk_max_ack_backlog)
>                 wake_up_interruptible_all(&u->peer_wait);
>         sk->sk_max_ack_backlog  =3D backlog;
> --
> 2.54.0
>
