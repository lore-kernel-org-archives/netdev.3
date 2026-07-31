Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660B5220F2A
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 04:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785470741; cv=pass; b=DsJ+PahlqX9I4Rb67XnZB9bWwlrDaztEg4+EMedSzul918jdGCBbLtp+a2N50L+npQxK0BxjGQNx0xtU1udwzEwMhnjc6q7AtdZZvPFfnYB9F4BCYvU4d5zBKWUi0RxXP6BOvUzdP3WYlive10hwf1jefEExmfeHY88D5BIW5PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785470741; c=relaxed/simple;
	bh=W/DP8nyeZG2kVW7RqHDotMJPdLEgWmSBN4/pvi4zkEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HG5e5bKMoyZuYmPk+wuwu7jdudXMXXzt0x8WELgfgRF5wjB7L+ujH3405/gUyFEZcXCjORbkhL/OpBuWA4UxRjTUv8gw5kcP1xiO2mNVkjUn39mepkFQzLvZrEPEP5Evi7Vma7HKSreljzm9nA510p6gX+sscr4ucMABT94Ujwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=q2j5T3BZ; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="q2j5T3BZ"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b2a3166398so454622e87.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 21:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785470738; cv=none;
        d=google.com; s=arc-20260327;
        b=j2BnLlHqlHskZlVa3lPpC0uKmahucnz9Pf/3IRPTsAck1s0pbJIHZ8cjQd8WbT/L6c
         9Jntep3CS5pEagOnILUPlPxK4yibgHxS/VGaW8yL7UyfG83cN6F5fMfZkJFncMf8AJTj
         tkozJMbcw2uwevI1SHTQ8mAp2qk7qgW+FonPD2y8XtEMtUPuxGL2ksSQPWYH+NrnOQz+
         AeVnmMfPENXw7y1jckzxJpJXLp+DLCOBuFXCJz5SNURpwIlPoAUar4/gDgPydMaRYTWl
         WTggNklpdOnlU7xy8OEXfep49F0X0DmZGMuEy2dJ5mG1SfLamZr3H1i2ttR/JrnrUBU1
         MrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3nZ7Rhqd0trlKYrhTL6fvWDdlYdGagNMQskwAf3SqK8=;
        fh=2Y0DLdn7bBZoeZEo447Wwdyr0LTTQ5ee8gjL/pgwj5c=;
        b=NCursxevWUU1R1m3q/Q8aL2dFpMPG460vplfQzMcxmk5XUHNec0QPOcv2lN4u1Fgkb
         reFFc26/6+ktO4Cn8TvldfTTnKsBJNqw/Y+0mY0pvfHWCiRY9RygQ9i/HYDaXmU0RLz4
         VgfwyFUN1UvgGziSNetiWlfaTuBlNhmtgqCPMuWYOfxILMf7B0jci0icXA/7KiWTZAMR
         1kX637AvnV9vOruDexzL9hMFtRjADFao3FK7K5NIl5Sku3UaGI9OLCExU1kmza2/cEC6
         zCGDityY+U8XS0OUOIDUqBH/dzIElVDjxBhvSVM0xtCIJyB3Koz0BvSNLIEZ2kZNJTD6
         q4iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785470738; x=1786075538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3nZ7Rhqd0trlKYrhTL6fvWDdlYdGagNMQskwAf3SqK8=;
        b=q2j5T3BZPiQSmu5xX/O1029drfg8NmuKtgqVUG+oAFDAhxqDv5gna5xtdTHs6VrpHY
         SQv5FtXQsoN+2cY3GV5xy1GhXxRg/63o+jSVw2nTQDvhwwy+0XT3VcKwyqpFoAxZuWJ6
         uOjkVlgRgaSv3OgNwc20XeLeZqeSqkXfDRmxQvikBDXWTIRfo0LFtqnlHWUH80mK/R0G
         dXAfNW/pq80JvswNpx2WKpeYHOJYE+Y5ITYg4nkUKE/1PauHZGJr9eFx/KoxV03d+Rnl
         TnZxOgw+omTdZtzTVoIBrC5z/C4x7MQnnAa3KfS3qVqj9YNQH+CDuz5lWVIs7EN0yHFB
         tM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785470738; x=1786075538;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3nZ7Rhqd0trlKYrhTL6fvWDdlYdGagNMQskwAf3SqK8=;
        b=Rl/2sDQNR+wVU/nDhxk+ltgGw2bfd4ob9q4mjFoH0JpTm8fuSKawSqbuyO0drhoxRo
         KcWRnmRzM/ZOLIwcgCyAHychy2NHt/OW1bu6uIxpg1mV+N6/8J9CahAyAIucn2CH/hUB
         4YWWtMRloGrx9qu36iYCRntrV1ug4h9cPzY8r2zw44Yj/B7M2AjqwzzjOwyoHSX+Nxn8
         6in5pqU7c4bMOaC4S54wG01lxfsyoPAgndGfndbBEg+SCUFISWnCs/H6f23U9o3E5nyU
         gmSc+N1vXGScDjXqdcm7qEys94TCfBCiJ2UJWSZdl17ZhzUj1/iJm7aAmzY3vblN6vvW
         xjiw==
X-Gm-Message-State: AOJu0YwbY5h8OJ4T+i2/LlI5eF0g+KOnDlesjz7bsZrDSWspLKh1tfev
	QuA3JZlKTg+ke+mbQAHJ4HwZJYwA/6jnWaLzTzolEnp0RNzSCdtFzoFu57hZNlPH5BsButp4sZ3
	asHJ13Yblp+AXm97fCiKYNOX70ZcrXVOEXonww9XJ+Mk=
X-Gm-Gg: AR+sD10SaPudkpuqdzPLDy5eWQAkL2oOkQx1lB1zVs7bzZhz/2WohXwWjYvfMOBvfO2
	Kj5Qh6WGHFeDQMUXijuRrPG3CqsGwBDBpfFe1UqfU4HDvmZlHJO7IfN0qO+KQhvd+UnFyznc2w7
	0RnKDRL0wc34sQ4/EsagJ7b6DtHR71+uQc29roaVdP0GvYL1fqkoXg/g1OZ1/x6WYTc//ic2VUq
	sE3eoaRzL09gk8SACv/newAG2J0jmq4YWh/egk5++8V+C20mJFWfFw7HBz7CXr9lqBbwwtSQdAL
	hIfA/LsYzQIzqe9QX00u2QmfBpUt3TyhHm0IORc/UAQ=
X-Received: by 2002:a05:6512:a93:b0:5b2:991f:90d1 with SMTP id
 2adb3069b0e04-5b2e1fd958bmr105657e87.26.1785470738201; Thu, 30 Jul 2026
 21:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785307984.git.zihanx@nebusec.ai> <CAAVpQUCLAk3qwGuxg1nHeRR5XX6jFt-9PF+Qq+1TZZTEA+DTmQ@mail.gmail.com>
In-Reply-To: <CAAVpQUCLAk3qwGuxg1nHeRR5XX6jFt-9PF+Qq+1TZZTEA+DTmQ@mail.gmail.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Fri, 31 Jul 2026 12:05:21 +0800
X-Gm-Features: AUfX_mzAcO9QUPykONdIfLhA8d9j5DrtJFIr_wKiKimWlmDmswDlCNGtOWEDsSc
Message-ID: <CAANe3eSbNtS1eGjuX4aFa_-p5FKU9esvT652g5eywKL3=Zt74w@mail.gmail.com>
Subject: Re: [PATCH net 0/2] tcp: diag: fix unbounded bucket lock hold in diag
 dump paths
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, dsahern@kernel.org, kees@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, fw@strlen.de, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 3:58=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Wed, Jul 29, 2026 at 1:29=E2=80=AFPM Zihan Xi <zihanx@nebusec.ai> wrot=
e:
> >
> > Hi Linux kernel maintainers,
> >
> > We found and validated a issue in net/ipv4/tcp_diag.c and
> > net/mptcp/mptcp_diag.c. The bug is reachable by a
> > non-root user via user and net namespace.
> > We've tested it, and it should not affect any other functionality.
> >
> > We will provide detailed information about the bug
> > in this email, along with a PoC to trigger it.
> >
> > ---- details below ----
> >
> > Bug details:
> >
> > inet_diag TCP dumps currently execute attacker-controlled
> > INET_DIAG_REQ_BYTECODE programs while still holding the listener,
> > bind, or ehash bucket locks in tcp_diag_dump(). If the bucket is
> > heavily populated and the bytecode is a large reject-all filter, the
> > dump path can spend an unbounded amount of time under the same bucket
> > lock while walking attacker-arranged sockets.
> >
> > The reproduced listener case places 131072 SO_REUSEPORT listeners onto
> > one colliding listener bucket
>
> This sounds very unlikely to happen.
>
> If you cannot trust your users, you should audit them
> properly (e.g. limit # of FDs, use BPF LSM, etc).
>
>
> [...]
> > ----BEGIN crash log----
> > [   18.495442] watchdog: BUG: soft lockup - CPU#0 stuck for 3s! [poc:10=
34]
> [...]
> > [   18.495449] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS unknown 2/2/2022
>
> It seems the soft lockup timeout was deliberately set to be short to
> trigger a splat, but 3s on QEMU should be much shorter on a real
> machine and it should not be a problem.

Hi,

Thanks for the feedback.

The 131072-listener setup is only a concentrated reproducer for the lock
scope issue. It is not meant to suggest that this exact population pattern
is common in normal deployments.

The issue we are trying to fix is that time spent under the bucket lock
can be amplified by bucket population together with inet_diag bytecode
cost, because the bytecode is currently evaluated while the bucket lock is
still held.

So the concern is not tied to one specific listener count or to the exact
watchdog threshold used in our local setup. The soft lockup report was
only used to make the long bucket-locked section visible in a small QEMU
environment.

The fix targets that locking property directly: keep the bucket-locked
section limited to socket collection and taking references, and move
bytecode/filter/fill work out of the critical section. This way, the batch
limit applies to raw bucket traversal itself, instead of allowing
additional work to accumulate while the lock is held.

Best regards,
Zihan
