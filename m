Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195662D0602
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436451; cv=pass; b=mYWZo78xIdsS5e2XbdG70meKY5y9Y1cZ48ACskR3uOoYdkDrku9/qlDnnNPWUGHXdlT+03Noeaft699fS4GflzdCtUTNQCST+Bj5V1q5UdwN2V4NO2voVgEYYyvrW0LRAsrz/C+bdA15xNu5M2XLd5JVTZTXW8kgS74UkaEM3sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436451; c=relaxed/simple;
	bh=FigiyzdMJxDV/p3gb3BMZRQc8vSiaXWGIeQ22KRGqPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNndVKfZFThj2BnL5OTC0YbLJjUPnD65zr1j7fmYnlD5JE/TQWLoNKrJdbU2aJDvetXFx9ph1r3db/HVWXsJmg93g8bTW0yrnzzlYhToOxm/udU4CSqQtqNgEpmf/atii+Cy78W78JC2kXvVzbj/PNavlmJvcMQEYqpPx24DW4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PmDRusRI; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PmDRusRI"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dcbade417so198592a91.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 11:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785436448; cv=none;
        d=google.com; s=arc-20260327;
        b=Dm7NwcKcQpjYA3KBnDgkJDTclYDRVN7kG9y3cwWm9pLR1Px2lwijzHX9KP59xBF98L
         pdhWC9rV/+AYo9ahIYOO+ijRFVSkq45o/xn2M7do7iXnMngSsLeeB/fo3T4ZzZy1UrZm
         KE1sKxzW+IcOOCZfsr0oc/MP7esj8BeZVmdLRX5e/7VLRH3LArQE+0D1pNWtbihsu+sI
         f/0FUy00FbNS21RGZoN8i5+BcMLv9nicHlDFEftfgSvr6TwAOX1nWsdJt/p5/Wobs6Dz
         Kv3tyEW3LfPgHur/bE2TaTuLAe6v14K67L+DlZiFHicAP08dnUxuTyT4YIxNgxJ6vvP+
         Tojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xpABBEYbc7OJOCu1gNnuglL1kew6HbO3Fh7tezC97CA=;
        fh=YHBfOjs/ffAzbozHlHgsQO4UXGXM8Y864yk6b+I05JM=;
        b=sgkm21O2+1o4v4XuzV0cnaDW28sCSnXELglErsL7VoJiJUh2ifrFeCGvO7L10gWzEK
         engVCu+cFTFesFm5j6mlYj77axSTNyRqdBs+5o4kUS+dVegDzwxpahyO8agQTKYdrli/
         PcHL9wiHYEhAfIoI5IcWKg9j1CBL1h56icES09t4kKSZUS5+i2aM1YL/gnXXkfH/C6qk
         5JFcLrlZ47jKxIlUjD5/fbT7zI0edqG2N3sLAUrUPtlEHF6cwqc8Wn27UOfpNvkv3DUC
         e+TRRV2zcZuKUX13oIHS92fBLUQ+uwtADBafupWZf8u/V0C4NHsTmqYRWh8z1qtZjslS
         nc3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785436448; x=1786041248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xpABBEYbc7OJOCu1gNnuglL1kew6HbO3Fh7tezC97CA=;
        b=PmDRusRIqISnUYFKsg7em/CZHyMne9yX9RyDF17qD2WkpZTIyf+/v7uGYYxmpDa+/Z
         KnGnVvrjqas69M6hnGWWiWJqpfQEwpMyIyyhSnJnRqxbwjOQ+TIpJqYww0VlkXZ18Egc
         JrU/qxfoyQMKG0cQ7on73Th4R0ehVuX1jW1rwf+APUVrBMsA6fkXDGuEbxBi2I3mPINp
         euLslviWDXdTX5WriIe7NSQ26qSSa3O31fYHi0d/8AMz4xAxFkUDSqP3SJUtC9hsSqll
         chD4KlgejUJArT8KEZ+c99ipD3goc2y4aUBTZ6VVSV49oH+daKwF2yyXaFf0n0afk0kx
         mS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436448; x=1786041248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xpABBEYbc7OJOCu1gNnuglL1kew6HbO3Fh7tezC97CA=;
        b=lnxHmMmjXsQS65GzUKKScJfaRLzPg9YD+6lSn8+ZlEBirFC0R1fhhXxzORd0zx6NPH
         vJ6YY2+TVGMQ1dUlV65FLWWRB8ZCIgHZLgtCic4c2zuPOG600I9G+wqu38rTcO5gSEOI
         FRwrFKy4QJBkLLolB/yMKDsW6zDOhT3AIjrH4S6YNA/i8RCt8gp80kmzUBJYTQodf1Ar
         2b65gmOWBIGENpvSScWMW8BPpFAZVbBCH0TPV0sysb04INcWnLBHWxZslVZDYuRRGDh3
         lcV6yn72mNJeY/VdzOIKuvlSqaIg/DvGmRMx2296PWyjGQ9+GuUe2wcU9kzrZ2nDN9sg
         BsFA==
X-Gm-Message-State: AOJu0YwvT5Gcxa5mpzS+qRZ1pKgkoUplidhVT+K771Le9XGk88MR3VED
	FqhaphX/F2qS31GyK4PNEHcIR04zRsdFf4DIG1cnp8mk1dRGERn8uHCP0xmnqjKMqfmdeMcm3Ie
	qitA10N8poBXGWZ/zUdo/77nkMmgpGiApZY4pOFMf5iKhhdnTxHKptKPWzi6hkxHc
X-Gm-Gg: AR+sD12fbKCakDYf6FpE2vdDMwfWLJMXCE6Rf2aIIofebOiFhwbpy2dVhnuXM3ITr+O
	nN22iwFRdZnEMac0Pr0Pdh6U/+Gglatnq9xK2i9t/wgl7AtwP/SO8OvGHaoeb2CfijY6wnZvytV
	wPPScrrOuoANPVjfdtsYKcby/HT0k/kM1/BEsTtjiq1W32uTtrTD4qXwA++dQNrojFTE3GRG+XR
	nHrLQAN3pL155SfasEdV3jbbcm4CTIt5givfYXMJG4lhK/w4MIYvl7u92IbB1r99K3Fu3lUr0LU
	bP6Q+GM5hzeylCa33cLV+CAgqCsEfW3VCpfTvyHlklWlJrtPX6Pfic043ZMPPhGsGE5KOn+Anq1
	wROfbKYAiGQ7Rc/j7D0xNioOeCf58MNWlmQOxcS1Mhx5HPMNcIoplzU5dsQ==
X-Received: by 2002:a17:90b:4b83:b0:381:5ab5:b667 with SMTP id
 98e67ed59e1d1-38fa7f4684emr1015752a91.31.1785436447613; Thu, 30 Jul 2026
 11:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADqcGBkVewfYCirbeusDW1xbs+mFs9ditaBX7KzG6NcM=xpm9w@mail.gmail.com>
In-Reply-To: <CADqcGBkVewfYCirbeusDW1xbs+mFs9ditaBX7KzG6NcM=xpm9w@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 30 Jul 2026 20:33:48 +0200
X-Gm-Features: AUfX_my1sxXfhTvcYdafhklnIstiuXQviQlKWKzOcnrIcbHc2OaS8bNG5hUvxUw
Message-ID: <CAAVpQUD84dLmEdXuZf0fNvskHGH=Wb+6f0nRmBY58xnB2xWWMg@mail.gmail.com>
Subject: Re: [PATCH v1] af_unix: fix use-after-free in unix_stream_recv_urg()
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 6:21=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
>
> unix_stream_recv_urg() reads out-of-band (MSG_OOB) data from
> unix_sk(sk)->oob_skb.
> It saves a pointer to oob_skb under sk_receive_queue.lock and state_lock,
> and then drops both locks before invoking state->recv_actor(oob_skb, ...)
> and incrementing UNIXCB(oob_skb).consumed.
>
> Prior to commit 8594d9b85c07 ("af_unix: Don't call skb_get() for OOB skb.=
"),
> the OOB sk_buff held an additional reference count. When that extra refco=
unt
> was removed, oob_skb became a bare pointer into the socket's receive queu=
e
> without any lifetime protection once the receive queue lock is released.
>
> Because unix_release_sock() does not acquire u->iolock during socket clos=
e,
> a concurrent close() on the socket races with unix_stream_recv_urg() as f=
ollows:

How can close() be called for struct file while recv() is still being
called for it ?

Did you trigger the real UAF or is this AI hallucination ?

If former, please provide the repro and the KASAN splat.


>
>   Thread A (recvmsg MSG_OOB)            Thread B (close)
>   --------------------------            ----------------
>   Acquires iolock & queue lock
>   Saves oob_skb =3D u->oob_skb
>   Drops queue lock & state lock
>                                         Acquires state_lock, sets TCP_CLO=
SE
>                                         Sets u->oob_skb =3D NULL (lockles=
sly)
>                                         skb_dequeue() & kfree_skb()
> frees oob_skb
>   recv_actor(oob_skb, ...) -> UAF read
>   UNIXCB(oob_skb).consumed++ -> UAF write
>
> Additionally, unix_release_sock() cleared u->oob_skb with a lockless plai=
n
> assignment. This creates a KCSAN-visible data race against READ_ONCE(u->o=
ob_skb)
> in manage_oob() and unix_stream_poll(), both of which rely on all
> writers updating
> u->oob_skb with WRITE_ONCE() under sk_receive_queue.lock.
>
> Fix the use-after-free by taking an explicit reference via skb_get(oob_sk=
b)
> while holding sk_receive_queue.lock in unix_stream_recv_urg(), and releas=
ing it
> with consume_skb(oob_skb) after the data copy and consumed counter
> update complete.
> This guarantees the sk_buff remains valid even if a concurrent close() de=
queues
> and drops the queue's reference.
>
> Fix the data race in unix_release_sock() by wrapping the u->oob_skb clear=
 in
> sk_receive_queue.lock and using WRITE_ONCE(), matching the locking contra=
ct used
> by all other oob_skb update paths in af_unix.c.
>
> Found by code review of AF_UNIX OOB lifetime management after commit
> 8594d9b85c07,
> and verified with a clean build.
>
> Fixes: 8594d9b85c07 ("af_unix: Don't call skb_get() for OOB skb.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  net/unix/af_unix.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index f7a9d55eee8a..011ea88d57c2 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -689,7 +689,9 @@ static void unix_release_sock(struct sock *sk, int em=
brion)
>         unix_state_unlock(sk);
>
>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> -       u->oob_skb =3D NULL;
> +       spin_lock(&sk->sk_receive_queue.lock);
> +       WRITE_ONCE(u->oob_skb, NULL);
> +       spin_unlock(&sk->sk_receive_queue.lock);
>  #endif
>
>         wake_up_interruptible_all(&u->peer_wait);
> @@ -2773,6 +2775,7 @@ static int unix_stream_recv_urg(struct
> unix_stream_read_state *state)
>         }
>
>         oob_skb =3D u->oob_skb;
> +       skb_get(oob_skb);
>
>         if (!(state->flags & MSG_PEEK)) {
>                 WRITE_ONCE(u->oob_skb, NULL);
> @@ -2793,6 +2796,8 @@ static int unix_stream_recv_urg(struct
> unix_stream_read_state *state)
>         if (!(state->flags & MSG_PEEK))
>                 UNIXCB(oob_skb).consumed +=3D 1;
>
> +       consume_skb(oob_skb);
> +
>         mutex_unlock(&u->iolock);
>
>         consume_skb(read_skb);
> --
> 2.55.0
