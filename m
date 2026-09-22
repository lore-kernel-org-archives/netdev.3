Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1A35C6B9
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039442; cv=pass; b=IoDTTNYRizK5ghpN2LEDENxgx0OzhzEC0QhzpS9MduGmm0bCWr+0Rgh6S8bUn+xA+hRJ2eF1vcHBsGH7Sy5fBNP7sbEi60oN1X85PlJQYS1S6TkYl83w3Glb3lOJiiKpbv6AMrUyxyXBnOrqVPrwC8wGIrKiDRJnQkMwmMiy4eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039442; c=relaxed/simple;
	bh=rDphcxVK0cLwUUna1tpHZp2v6qK6oFhLgiPUmxWlUKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2k3FpJWo20lh6CIB1NFr1Ule4vZsS3o1XtHchuZGVATFerbnhzXhfIuglQpgzXnDIgS+swUmNDdfiXcYLerDL+Xq3UIEFbbXVY/6a2AbGEP0l1BhZxYsZtSjAUkWqz/iPzdExOBqiabTavnX6mZb+6dak5+xv8g5xCTuTZ5KCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pwdcy2NN; arc=pass smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pwdcy2NN"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-52fb76c9df1so43330601cf.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790039440; cv=none;
        d=google.com; s=arc-20260327;
        b=KPSe6xTJ3gT2dSV2WIF29+0Djql4BkvEVjzvQBkJtACeNi3MHfSSHJr+2plTlfTNBE
         DSaoJflcNo83lb+vCCKXIbjwlMyx3WimOt7in/rbICs/6Yz7SelVlFx11i0Sh9OvMoDI
         8+wMOmHs295JY1PJE8WybrwCWJY+Vtjux/Sa5rEcoBQVKSvjUbv67veVAoBrDqdgLLbs
         j+ew36N9ULpCXStN8rO4X3SMkEgM/9C8kzo/itRb3D/Osrykqb3REqCSH3h3jejbD7JV
         I/Xhy+OAGAjNb3RRUbn2jmC0PeY23+ZSZL4zxyDJplEkneH/ngcjGA/CxypLvtDzjSvZ
         alQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u6Z2U4vAuJb/VjzAk0+RtK9FDIXwMhOB79JAT2yh+ek=;
        fh=hx176JtkjuCDvRvS4mDOskXJyA/klcnZVJZiMrWcvk8=;
        b=f+VmDD7qk/DzbiMrraLgTOUk7s9buqfeOw5Zhwf8zOq1eY3GM/ApcyK75C/wQjrqJl
         t1ZpgQCNeF2Vma6m3JMJtW6gCEb3X8axOJ3UA2MqevVTIqMI4JpztzoCeNZZfJgSqs+m
         sdQbImYXmEt03XXXBj++iOrvXwpiarRsWBL4e8ySmIA8taE4KuWMAZOg0EHr5sH5F9PR
         BrN921FFu0YvvV4Z2tfZBIjGOo5R0L1mcRZKPts2AfJdaXgS+57nyBEKcdF7lOzc9O7R
         tuyTDjXeRKRKsZRB4DeYtaZaHWbMRCxUBx0KK2+IanqT1ZTpo7V8mUekZGekpeMf3zkp
         MX/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790039440; x=1790644240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u6Z2U4vAuJb/VjzAk0+RtK9FDIXwMhOB79JAT2yh+ek=;
        b=Pwdcy2NNDsW68Ziqg7g4ty/PdMAiuuHbk/aIZAm6lGfMCPaFAtMh+U0mlB1CLqDdRV
         W6MgrQYDcRCm+uvFXHNVE5iXZbLUzUkQQITRAeu+ZromRa9bO2Cu5+jPqGmIMc3fs9cV
         f3f0vr6CPkQeFtlnyhKRUjDzg/TPdffJo8NMCAeRoYd/bXMBqh6NXjg9ShOkiZS9Iyb2
         LFDaKICi8PC5x6qK90BcIUstjzncpvf/P6Jm1Rbdh8IWwlDL5HoCTmDfTUy3FA33XPvd
         oT9K6jAIJpz3hF6049rnJUNLS1gGDoByMrLue2SYByZzHwXU60k0jcnEZjovkUCq2Mki
         WjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039440; x=1790644240;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u6Z2U4vAuJb/VjzAk0+RtK9FDIXwMhOB79JAT2yh+ek=;
        b=19sUg5nNVSyWtqmBF18oGFUR+XteWT1ZZIr0ssk5g5jkilxCMKJk9i67Mkh4Ed6ZYc
         XZeaW+j7rS/MkhT0FTef7SxejLUbWwnCMOPGOVA3u/OjW/xZMSodeC6NttFWrw5EtBzV
         lyGlb353Ak/S2C1MnCzeuJJ/Eog2Noc9Tn6q6KUEbS50I99chy++md+QYT9ymMkSTPbX
         02kHYFz25MDIfTAxdzzIdx1xYX3xcTKs/WdbET+SO+j5wXwIx9uxS2Xq4PahMjdTpuas
         tV2pnj2RMK5uVfdtMrpxL30uRQ+IAFt/NyO9S+wRrEiKPw7M/TPkQeb4wDFD+aLejG0U
         uAcg==
X-Forwarded-Encrypted: i=1; AKwUvBzQk5nUDneaecj0es9tktHpT+z9MXbULKviSMlEaJq8jnBD+sF+Tik3ZURddpXsVsuu6laOeKM=@vger.kernel.org
X-Gm-Message-State: AFuF++mdISqjFLXQ8KRyPi6cQNd1apMn3AiNgBdoXk+SkJ15O2XMY/Oi
	tXW+bf6Mvj3uOJuiy3lRIKOFPYVuS8G+MT/ghJ43Z8Ijoo18vc7DFInRL/ApjTAKTGqwaePCsd3
	CdIHOdvWi/Xy5sQYiD3E5quUNHhtbKpnI447CFgJJ
X-Gm-Gg: AYBFou2OH65Y5HKbFvpR4QGNU0I4q/+q0g76RjN75MFobW8k3ON4e+QMXFBgJVSmqqz
	WPEgGsIjUYJXleHO5J2xgVnRILypFvb2whbQ1fHuZyb6egxQdUTY+8Vw+couvRACU7Y2O/ScT8v
	+gFZFoUQZcHWYJvk2/r31NJlezTM7tw9ssxGez+XVoWNm1hfj6bdOP7DJS+clltXlyVE3w1V4Wl
	Q4uIA9Rss9UdY+PSZ05GQTYeVsRtblWe0HfrKhnqKpz3M26kctZIwBv1UTZI1j0LMlmxoH0Q/CZ
	Vn6CdxOkWBm5t1OR+9Tql1MjXPP25ZqebcmIOO5Hb21hUlE0Z45IghPh2taDJOmiO30m8qpcbdG
	0EXd6QOkG1jS8tS4OPYUbURHJcG6gCvc2jyVsGVhp7iLeeXhk8kZBxH4Eohbct3gNSlLuBQ==
X-Received: by 2002:a05:622a:2287:b0:52e:8ef:5960 with SMTP id
 d75a77b69052e-532d8e32ebfmr30057471cf.33.1790039439462; Mon, 21 Sep 2026
 18:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914164400.2738350-1-edumazet@google.com>
In-Reply-To: <20260914164400.2738350-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Sep 2026 03:10:27 +0200
X-Gm-Features: AcwNN1XENI3C6DJEuWKSVfu123kER72zrEHAvPUuiU4gn9CTQlz-0sfrY4BfkQw
Message-ID: <CANn89i+HYuqNO_ifR7XgpZO89r9ZRWk8MOVzezmDff5KfLMp7g@mail.gmail.com>
Subject: Re: [PATCH] dlm: fix send buffer backpressure handling
To: Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, gfs2@lists.linux.dev, 
	Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 6:44=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> lowcomms.c tests and clears SOCKWQ_ASYNC_NOSPACE in con->sock->flags,
> but this bit has not been stored there for ten years.
>
> Commit 9cd3e072b0be ("net: rename SOCK_ASYNC_NOSPACE and
> SOCK_ASYNC_WAITDATA") mechanically renamed the two dlm users, then
> commit ceb5d58b2170 ("net: fix sock_wake_async() rcu protection") moved
> the bit from socket->flags to the RCU protected socket_wq->flags, where
> it is reachable only through sk_set_bit() and sk_clear_bit(), and is
> only maintained for sockets having SOCK_FASYNC set.  dlm uses kernel
> sockets, which never have SOCK_FASYNC set, and never sets the bit
> itself, so the test in send_to_sock() has been false ever since.
>
> The consequence is that when sock_sendmsg() returns -EAGAIN because the
> socket send buffer is full, dlm no longer sets CF_APP_LIMITED, does not
> increment sk_write_pending, and does not return DLM_IO_END to wait for
> lowcomms_write_space().  It returns DLM_IO_RESCHED instead, and
> process_send_sockets() immediately requeues the send work.  A connection
> to a peer that is slow to drain thus keeps cycling through
> sock_sendmsg() and -EAGAIN, burning CPU, instead of sleeping until TCP
> reports that space is available again.
>
> Test SOCK_NOSPACE instead.  This is the bit that lives in socket->flags,
> that TCP sets whenever sendmsg() returns -EAGAIN for lack of send buffer
> space (tcp_sendmsg_locked() and sk_stream_wait_memory()), and that
> lowcomms_write_space() already clears.  This restores the semantics dlm
> had before the bit moved.
>
> Also remove the clear_bit() of SOCKWQ_ASYNC_NOSPACE from
> lowcomms_write_space(), for the same reason.
>
> SCTP connections are deliberately left as they are.  SCTP does not set
> SOCK_NOSPACE, and it never calls sk->sk_write_space(): sctp_wfree() ends
> up in sctp_wake_up_waiters(), which calls sctp_write_space() directly.
> lowcomms_write_space() is thus never invoked for an SCTP connection, and
> the test added here stays false, so send_to_sock() keeps returning
> DLM_IO_RESCHED as it does today.  This is the only safe behavior, as
> returning DLM_IO_END would wait for a callback that never comes.
>
> Fixes: ceb5d58b2170 ("net: fix sock_wake_async() rcu protection")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  fs/dlm/lowcomms.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 2aff1c7c17de..abe9ae4c643f 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -522,10 +522,8 @@ static void lowcomms_write_space(struct sock *sk)
>         clear_bit(SOCK_NOSPACE, &con->sock->flags);
>
>         spin_lock_bh(&con->writequeue_lock);
> -       if (test_and_clear_bit(CF_APP_LIMITED, &con->flags)) {
> +       if (test_and_clear_bit(CF_APP_LIMITED, &con->flags))
>                 con->sock->sk->sk_write_pending--;
> -               clear_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags);
> -       }
>
>         lowcomms_queue_swork(con);
>         spin_unlock_bh(&con->writequeue_lock);
> @@ -1391,7 +1389,7 @@ static int send_to_sock(struct connection *con)
>         if (ret =3D=3D -EAGAIN || ret =3D=3D 0) {
>                 lock_sock(con->sock->sk);
>                 spin_lock_bh(&con->writequeue_lock);
> -               if (test_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags) &&
> +               if (test_bit(SOCK_NOSPACE, &con->sock->flags) &&
>                     !test_and_set_bit(CF_APP_LIMITED, &con->flags)) {
>                         /* Notify TCP that we're limited by the
>                          * application window size.
> --
> 2.55.0.1007.g17ff1f9808-goog
>

Gentle ping ?

I have an ongoing series for net-next removing one cache line miss in
TCP sendmsg() and ACK processing,
blocked by this patch.

If you prefer, I can insert this patch into my net-next series.

Thanks.
