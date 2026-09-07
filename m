Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28605411F93
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765002; cv=pass; b=VdJBIPp575peQEIQBWz8l8t8DhfJvYDJtDYbhdrCnvfwjwhTzDkcrPKxMTm3ft43im/RDEHCkyfpZubmahBtq6Ebh/eu9b8psT1kkBF/kCYMZhAvUIfmkj5D36YRrwxWbCq7h8KYNJHMUBw3H8pv2255/3kuCkH13wv9g4nVSyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765002; c=relaxed/simple;
	bh=bY8T7KF0qJSw0FCfp2fmHHR9P2/vJUU2JRlv2EGdr60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMqKUSE7iysHwtELSqpsgeBRBIRlFoCjr3X+YwjdR7nluVvrZucU9zgGatkHW76mjN8W1hCd/Ad7hOeWWv+GwuJ5doZg3cZq6HtcamzM43GJWNrgU8l/hjEslhUxL1VW1Sx2bFjUu3E2eZ3iGRdEgng9DJ2nSHjz3ILZxBGTqtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DNDwjwAb; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DNDwjwAb"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c0006ea8eso46626641cf.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788765000; cv=none;
        d=google.com; s=arc-20260327;
        b=B151+feFM/qhpu+tpZ63bdVfcVBaLmFcu7cy9HhNPZiZyDlueOkSo58vFJAM8tjHAT
         ez5oXaaPhrT9nJ410k2BWk7YiYF4d03pomAoYOJ45ptco5lQ+T5Oi54cG2V7voe8niAa
         teALTESCM9faALfZH84vvIeEfP0Nshlxl1mNqohUdpXJ9uWeVwpG/V6w7VwkvKv2MKIm
         v6zGwurDPND+wrGjp9iDN7kvjecu/XAYt0+rSY9/67vS9iuCDYkpluNdMHKr7Xr+eSaF
         QE5/mYUQcbj4XwQe5OwqupwjKtKzGAIVfZ9jl8OsPirSjFO3IHP4N0Rp34SfIlNphGL5
         9qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bY8T7KF0qJSw0FCfp2fmHHR9P2/vJUU2JRlv2EGdr60=;
        fh=efSqhjLFJ0pSgKgz+OVycKOK1Cn7ny6ZThkPbAW1Fds=;
        b=F8cnvqD6IqQef9x+bnm42wT2aO5ar43ieoPxU00zOPjFfx6pQn/FtAl66/cdcJdAtw
         MdaviKFpL1m5hdYxBJTCU3Yef7acPqW0wz+ZmiMw4oFQGOpJejVWvqAySB7D2aMO5HmH
         hiQ0qKo0Q53wVV/ZfNXVYIr+SGzDB5Qf6sOoWkHn128u/IanF4q1Lj1MPcXMUbh+9geB
         LBhjGDkHh1WL8UuS9jkmyLmIBUODbmGkFGkw1Wc9oB4qK5Qzp1S2WOHtM3v0YZ9EgNbG
         +ibWfk+JsOMi1C2LjSQEnDNaHqvE14W2CGb2ntJGf7LTeQiR/KgQ871Eda53odQ5oXHm
         A4Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788765000; x=1789369800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bY8T7KF0qJSw0FCfp2fmHHR9P2/vJUU2JRlv2EGdr60=;
        b=DNDwjwAbwLxb/vjqZoJ6266SI9OFz+CRF20kRsRaVJQF1iCzpn8hwIZOEdh5VxTZFm
         ue2qn5tjAgvNzIU5F2Tl+JsqdGB56h/wwC536s3/ZAf8++l17XanvmPxS5xttFqpnAYL
         FXScekSslo0iG7S03As+qjFZgLjY5YNAgYRQsiKi1ATQuka7TktN/3BcmwsKodS3fnMx
         DqeiaIIGei+5KOcvV7E7SEPPFPcsTchO7kXhI7DeOJmWO3tNqIv9IHa6UhXF9UeerPC3
         nHkXebvBvxJl+4sN5kw60OfI02aCZvsHc4eXW7Vi04ALTrk6PsVOKCF7C+s7pQ7D0xZ4
         kinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788765000; x=1789369800;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bY8T7KF0qJSw0FCfp2fmHHR9P2/vJUU2JRlv2EGdr60=;
        b=THdZ/aP5HYfCBDUG1liQOUrBhHt0cEqDlUdaj4uJudIvUZtczCWTz28pnzxoCaO25V
         pZldVX7ECRXBWBj59y7fys56uREeqY33ynGJ9jk+203wx7HG0veqQbqXgt/QM08Rzj3S
         kiiR9dmUw8gPM/8WKLXSZlv4VkSOmMtWKOlHZ5SZnbvifcooD9RPiCXo7nzlE1+uEitJ
         O3MSmNXe6714IZkTPUVjR41Clgt7aVIlaN8c9jsprxeaeLCTn4RWTQo3Na4yQUffDX5L
         tDBo0nbo2efyJJRuhT8vQblMm4Fi0MjNAI72cA4MwLJ3a7UBxaJajZjPNknX3iOzv1uu
         hnFw==
X-Gm-Message-State: AFuF++mP72BXNc3jDhiICyUmMBMsXny/lOD3wA5RSNrac5kFuHpNkukl
	ByUnVpoJVfZBOZg80TmHpGl9HuIUaJkgec3/GYYKVUSe0eI6tCuLx3efywI93tcRZYEmwonPCS7
	Gsa65zKUIWsQB4g8ue/rkObx/qvrGlS4qi2WaxF1I
X-Gm-Gg: AYBFou0N00TCcrHzNi8BPAng0SwDS8OW2iJ7HInHWuBX/0WF0bYjy7wHVDHXDHc+Aqj
	RE60EPFWEsQWzJLG2CsxEQH/kuofhWG+bcsuJnCpR9NN5dPaU/9UOkyRQ2dQKvMnqUlATv7YgW1
	SbQSqf6469cjZWcZymIysv9Ti+I+wOtsL17EFbVzsPcSuQpCg/5SLcyGs1XXbHzIUCaIbj7IkiX
	OhGWtlk9XqsvDKbOrVs/4NxgsWVjfJYUNpIMVUb8WRdMazsDK7ZEzEH+1+6XEwmeO5CIG6J+pRV
	AjEnJy2IdWHBmZUlv5cn8BHRFqqMqucspK2kCXkQlqP/j+QSN4YOea77MnAw/iXlQKBKoPVnwG+
	DVvUwOuZiigDpaYF7T8c+DbVpXaueFj3aO2gdCzHZX71lU5vTbiSGJxOBGHqYCVukaFWB
X-Received: by 2002:a05:622a:1f98:b0:530:31c8:a302 with SMTP id
 d75a77b69052e-5305495da66mr256081741cf.23.1788764999462; Mon, 07 Sep 2026
 00:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788248601.git.zihanx@nebusec.ai> <db1f34ca8461c7b0dc5ec504ea1b99c24b909e34.1788248601.git.zihanx@nebusec.ai>
In-Reply-To: <db1f34ca8461c7b0dc5ec504ea1b99c24b909e34.1788248601.git.zihanx@nebusec.ai>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 09:09:47 +0200
X-Gm-Features: AcwNN1UdIl3PlzbDUGiFbT4WHqVNX_a67HKQKn1qGUPRwr6NlLZpE3hbS-2nlZ4
Message-ID: <CANn89iKzChGpDLsJ6iKRsMvHKdW6r_9xvkQv9g6bTy_-Pt8xOw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] mptcp: diag: bound listener bucket lock hold
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Guillaume Nault <gnault@redhat.com>, Florian Westphal <fw@strlen.de>, 
	stable@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 2:54=E2=80=AFPM Zihan Xi <zihanx@nebusec.ai> wrote:
>
> MPTCP listener diag dumping reuses sk_diag_dump(), which executes
> inet_diag_bc_sk() before filling the netlink reply. The listener walk in
> mptcp_diag_dump_listeners() currently performs that work while holding th=
e
> listener bucket lock.
>
> The time spent under the listener bucket lock can therefore grow with the
> number of sockets visited and with per-socket dump work. The resume state
> also requires later batches to revisit the bucket prefix.
>
> Fix this by collecting only referenced listener sockets while holding the
> bucket lock. After dropping it, re-check the listener properties, obtain
> the parent MPTCP socket reference, and call sk_diag_dump(). Keep a
> referenced cursor so later batches resume after the previous listener
> instead of rescanning the bucket head. Validate a cursor against the
> current listener bucket and TCP_LISTEN state before resuming from it.
> After dropping the lock, read icsk_ulp_data with rcu_dereference().
>
> Fixes: 4fa39b701ce9 ("mptcp: listen diag dump support")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

pw-bot: rejected

Please limit the complexity of filters.

Anyone needing complex filters will implement them in user space.
