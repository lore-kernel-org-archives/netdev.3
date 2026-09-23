Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F4E47AF66
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200018; cv=pass; b=p9wHu+m6jYCFJIR30pr9le1ot30nxUivZatWizJ2uZqAvdbyibK4Djg6gmDIlhBMmcWBwWlGzj9IQAh24XKuKcYNJ6naPYBi46XPPOXeOg7G+ROp6RWl+hC6s5+GN06USugMRLY5/28PnRUo+7mCMyGoEPQC3RBlarXa0EIpFGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200018; c=relaxed/simple;
	bh=yxlLjlxEYje9gyNjL3O9/Z0ckFDrmPMnutRBVnPIg0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyD3kLLN04MsSXboca64B8SJWCdlVRIned8C6r1T0N8BWd5VYnYE7ZTx6WiIVG5k2qmDdjfg+Wa1j6zOPMmjDJjekghoRijz1hf/CfWlTzvOTC3epz/inIBAo0YLHNj4n9TUgSKNCbDXr3OtBxH3LsrHeef+2KX9xg7weiRO7u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRygZBtb; arc=pass smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRygZBtb"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144e32aaa1cso901678c88.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790200012; cv=none;
        d=google.com; s=arc-20260327;
        b=beXakW+i1DapxnkXvcHngeTtzV4c2n35IGJasGQKU2lpJUY8hDi2MluoChYV8ENlcx
         AW+w9eo0qNXZXg/Cc57E1mZFfNRt+qDQbPhp5ErxUr4rpvFL825KwQGjNELonf9xpcsp
         +P8NLmldaahYiMksYcs9RcYbn4dX2mK6SYrKCE0CHUEyKfPJ4+/WfW0OoAWbt+0Xr/jt
         4vZj6mbk5Q3IBd5qqtFJRtUXCUp7R7BaPgRRoOObE1RUwhZa0E4T3seCfbjFeYkzRE/D
         lNDMShmqfDTjrXL+0qRohMZMJNBYnetoXfMq7O0D3asW2URBOH8zSlMNCKVyAxGjsI/4
         xOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R/JHzgKbPIRgIKe3d1dNX3GOh2sidTHBM5B4emfM1ak=;
        fh=u/WVklh7+rMiCAkjJhvDSEUdQ4JOIYLnhcDhHzQFvvg=;
        b=W+NqGtTynYxq2mRopQPsICTElY8whb00Rssr4L3wxu+k+HYCLGMKmGjunQbd3xbGaE
         mbrB8spVW5Qgr9+zuQ5p8GjswXA5Mw6Ge3s4kmNJhDbZ5mjoZZFf1D4xf5Lvzf6LPvCI
         wmNeZc4iTs8q4FwPnMl4pcQvqT4a++ekQ41sTqGRs0OvEjSjpw97LX3AeKa6+Di0AJiM
         +2X5274obmsVlaj/P0wDifA+f92ijAm2kK+ruLxbMdeMX/RrHgt+kma/ksjR5vWt+Kb9
         LFSEbdrzgNZd5DMvoPoBC5onqpMKjATg6cz7MDxI+Jbl3AG2KjPHrBPqAWoiZ0A8YQJP
         a2kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790200012; x=1790804812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R/JHzgKbPIRgIKe3d1dNX3GOh2sidTHBM5B4emfM1ak=;
        b=NRygZBtbRvqB1gjWiwzFweqOjPd97NVy+ZM7CUqxSbrm3Q7OuUMgsJfDzdVPuLeI9R
         GDdUv+h4I6Ml9sOyts57zO/wbAG5yI9V+DqICLlFcpUmzMdTU5R+WjqXU2/vmLecZYlV
         a3YcWMsIenUMbuzhkiejlVWt8NVDrTs4zTqHnoznEzOJ4x7XRXHf7MLsmuw4T6CTn2ra
         LwxEvqSGQEjPpVsWRxBcNiEwoPyqehrkhQFBg8f0byp6BWoFM3pFcfR7h1YfmyXMredU
         6ZTWGvhxAnN9QrtvyPVaNPzBPsbdYQWA5/hSWVFH6sgbq1mwOmg6O/0z3VTTjzyGAleR
         HBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200012; x=1790804812;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R/JHzgKbPIRgIKe3d1dNX3GOh2sidTHBM5B4emfM1ak=;
        b=VZJqhCRCgTdAjkT6Ode8McPpWpsDN5K5brKZR0Ps6j+ReupsO7YCZpwo9eiuOGjwJY
         YG0sBviY4WW80m2InK7quo6LiF2QbyRiWiAnjoyaiEEWYJezxHq1guzsTwJSslacbhrW
         iLh0ovW7LTOnBCIKbaX2yOEC7V4vft1Z2tagz8YJiFCgyPvhKY24eJzPeRAAklZ+VBnE
         FkdVLofCZ8UC1XVkTVWcB3Rkqp9/8lYYNZLMtIAxzDEiXltl0e9zjA4BmADrzSQOdO8r
         h0S9kNWNaEkV6uqUEyoAp4zmWxiArC1weXVVEAf4y/yQaiNOoTZpb7j/I6Y75YP4zfBW
         J8uA==
X-Forwarded-Encrypted: i=1; AKwUvBz4W8Rz7qNuEKUu5Di3zK49Z94dcNflWImpYNkUt5Zcx0/FkBOthKRhNmExNaxJoy9tWtQEUUU=@vger.kernel.org
X-Gm-Message-State: AFuF++lCHOoM0Ar8ObbH5YOsf01o3AEIV3Q19uXw3ZfUpHKCos2UAE1S
	V50FJnRS68LrDrGKAeUJKtdPuEnqETxhNjG5kk/0LwBR86UMtybehE25sngzvV/z1UNWEwFTV/l
	6aQ2klSRrC8r8rbHx7pR21lWcWZNd6XcovKWAU8fQ
X-Gm-Gg: AYBFou1cmq+1QrWbXzokZk0NiVstjZKZmTi3yC3n6nf9rUuC44Wf1XErZjwUxJNqBa+
	T5jHa6H6mttn06JvyibwB+5mfWzLlf7x4nldQTLTHO3kRGGTbvW7l8tSx9YUErp6oST4uTHCD0+
	FRIVRj3ZUMkADMRYdb9vPRlSA0U5pqiMNIk/v1VxtibM19Bx0SOyrYzdKnO1bWqqQS3nCwD81tN
	DvBbRtUVN+tjsKKHuhLZF9J4+EC28jjqEwyn2ylroN1LebrfNOLnwChaEDNTjTCpiYaAf5ha4gf
	Vqsw5GSU4STe7IzqLaAxVA9Q2v8uUD+ggV1Kq7ePEZK5SJObsLaRj3RQHUjgpCTvgXCC/g1HNq8
	MLZ6bHDwGWnFUbN8yygeKe/RnbQZXPFbLneEhJPXhqnNvXP6SGx4ScDrP3m0f3IusADJN2Xnrr8
	JgaOW5tH4HoajlYRJM5LU8nQ==
X-Received: by 2002:a05:7022:ec84:b0:144:f8a3:2eb8 with SMTP id
 a92af1059eb24-14503f0014fmr479906c88.9.1790200010885; Wed, 23 Sep 2026
 14:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com> <20260922122721.3568295-2-edumazet@google.com>
In-Reply-To: <20260922122721.3568295-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 23 Sep 2026 14:46:39 -0700
X-Gm-Features: AcwNN1WVwgUo-bragsI4MDRSzZd0xxrtae8n4KtGMXLllwPDYR9tuk8b5Jj8gpQ
Message-ID: <CAAVpQUDG9bi1FLL3aNmR1d8c9qT78MocK0dEhnUaxR3BQJKZQQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] dlm: fix send buffer backpressure handling
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, stable@vger.kernel.org, 
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 5:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
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
> Cc: Alexander Aring <aahringo@redhat.com>
> Cc: David Teigland <teigland@redhat.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
