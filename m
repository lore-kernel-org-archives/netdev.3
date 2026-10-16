Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A76379ED6
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136557; cv=pass; b=bAojORwt70LV98j24zd6oGqz0yWoT/ER/iJ+hRMGDrVh9XqEJB7s02y7MVJffDKP6d2tgcbPcZ6dNDgXOZH2DPHy53ntdWicnA9odz12GjUwL/1Nfy1e9linfnWmB1xHbCxMNdIx7e12ty0DJk6oLOgdXLgD3TlIWVomIIIwCWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136557; c=relaxed/simple;
	bh=VX0h5Bm2UY47Tt2z8myprdx9WcuYmLn5gM77krDjH6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWf7rNWXHjfs1/EJ1kUgDAe3BqiznOdzmQEZU42tyCJhh9e+FmTKArJaP3Q9mmPuL+ZEeiV58PFmxNQ+lbzw19v+fkICQAk1OKprAT1BO4Fno5YReX8+nH2m82jAH8MjKogK1y8bHrCQDEwc43t6sIe/e49IyTZkHg+02CDkXEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QBzDCDG3; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBzDCDG3"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15354aa70e8so2271251c88.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 00:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792136555; cv=none;
        d=google.com; s=arc-20260327;
        b=r1Axe4wnWOY8Tky01RGEcZ6LDLgQyQHU4ha+clXXaXFZ88YeOBVIp5KgQOigGTL+fg
         RaRLRqHr1DpwuzVp9XREm9OuL/tuys8z2ECEPQB6ygK8DKEfk8KqQBSDc15Wklzym9fg
         C+Me5D4uDyGnDe353ff7QCbI8VF11YLgzVbwsivNQCvnZp2YeLKRbuI+RuLpIPFvGVbc
         LwA4wP/LKjqH8PgF3aBOrTEAQ0bMqj9MZXgfzJR9RcypkTAVXAia++o6mShE21cQ4eSU
         +CO81j8bCFe7N+3dwxnq6OdpmuE8TAktupD2aeODX/AbEPcR4D+f/E3UyJWM4WsNhU6P
         UnzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VX0h5Bm2UY47Tt2z8myprdx9WcuYmLn5gM77krDjH6A=;
        fh=4RK/hUqAsQFP6aQpWRVhEMbJBXi2ityWjIgRouQhUx0=;
        b=G8AX9XHTmylSOFRUvknORWgUZXVfuMiBhmwcw8p6YOQ62kNW0D5AACH0Q2Y4jQY20R
         8gECF0iDKWFV+p6SibqyhOpMymCFySr9MU2ADTLxW85nC/LcMnltBWLym9ZnQQYjHFXG
         HSG/vl3xg01sGfGwE+iIAQHBImPkdVqN25Ng099J5g9/6JcYHQnks2XBCcUee63b/MET
         V9kCsms+hbT3seQ8ZKUQD9dutM8QBlIb4Nkmy41Gc63QjnozYrRHselKgyBqbIdTXNWp
         oPmQPsjoZhI/uO7vhkKKMp/W/R/aMwXTp6BVbSW6t18z2245NdW7tls8scCadL1eLts9
         rn+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792136555; x=1792741355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VX0h5Bm2UY47Tt2z8myprdx9WcuYmLn5gM77krDjH6A=;
        b=QBzDCDG3El9nnvMxpifvH7SBsJiKvYtDrWLShE+su9ih/U+GvGYJ+S6yM+rptayoy9
         C6VzxcQWUCXQldIxfKhu8Xz557igSOD0OJ2A1ZI5yC7/EM1Q2QqeArj+lPCxPER25QOd
         Ux7gvSCopIgoY5BGcUZnFu0KOcOtY+rbSbiJ+SSnq6Vqk5yDY48zrTlExQOkczy+MHze
         IL8VKzhG1nC0UcakoQdsX9PqXVQk+NnNiQ0wrggR3dYTh1RVnt/5mGW+GuO7saQOloED
         /56lrDh+jz78wWtH29orfm3Kziwd7axNYuD8hGZtUk05nrrArxzTTYEcwyyZ8DAmWVW9
         PDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792136555; x=1792741355;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VX0h5Bm2UY47Tt2z8myprdx9WcuYmLn5gM77krDjH6A=;
        b=ayfO5N75w75KSe4yxES+a+qfHxH2+ZwkdvN7TYaCNYIQRPb1UiPiR3XKOnYXBq/psN
         87zWhf55r9OYp7lYtA8+T9IrmtBRC0jLLhsLg3uTgG6J3NzsIWRcMxi6iTLz4x/cej4i
         q0L7nt6kRilfkxbtRt8maEEvlvRyVLlx16sz1Pb24UKYPhrcgDlYvmeyS/u1Hl2bzJFV
         uweiR8dEfOK2dGWGDOz5SsM1uIkUts/g3dfWgfkkY1RQnh7xjsziBv0xzqbaatC89AVY
         EyiLX52ZmJyYfRUQJo9Q49g45pXF/aUC1zV916FjDAkvio9LUMYht5FMY/+qmg4OzcrO
         S8YQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdFhZzSzE+CF9Fyo8z5CbBwaOcshdqls1ClVfphApumKCyALc8b7FfY/04LYtiNrE/i+BUQ18=@vger.kernel.org
X-Gm-Message-State: AFq9FYK61i2ZTz8yaRsmwwQcbR70hRW4o44eTk5z6p1KDdnq6PZwRra4
	Q3AZOUG1Ojj6xPvoZpZuf7mMKizCJhg2znFZLmcaMQBFaNFYsqmNvp7uPEbUtcmDqvweBXvcMwe
	7Y5x1WqH/x65rQGUlFFzTE2+bA/tsMRofgOoInwwb
X-Gm-Gg: AYBFou1msthhbRr2eLzAnor2pJ/xbwkL04TOTo/tHgN3XYgfXkTR93AATLMCTFooBJt
	+qjIKzy62fdtCxfn+XpYXpyuiMgwk+N9CvguH2mq7/p9wLUAnd01qXz5muKLhoaUPmjQ5At4sex
	cfgb6LzPyw6cb9Ei29aOQJa+CZgoqJcEVTh9fq7smbqYNEBFoHtRZHeXqoBRv5ZAsxwUbgOZOPy
	tuClRmR9nBliqf5sdeo0MFoK/CCXnyfRu+P30/OL/QAuBqWOsnsujx1AU7F7hw1iobPQvwuo6P5
	/t7GT/FsjYmCNRoGYN9ulonD7vn2L132/ENcBpZ8yEVYTBa9Ged80Ocf2kpXLyRp8DAKdzSYmTZ
	M2DuyjrVRhK1Ji6P3V7BXzeuy6MxOCcBMpTymPUrUnwhs2TxqKUN+kHfSqeDD3Vl8edo=
X-Received: by 2002:a05:7022:3f0c:b0:151:2e62:fe8d with SMTP id
 a92af1059eb24-16a5dcf817bmr31361642c88.9.1792136554133; Fri, 16 Oct 2026
 00:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015073736.2944215-1-tavip@google.com> <20261015073736.2944215-2-tavip@google.com>
In-Reply-To: <20261015073736.2944215-2-tavip@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 16 Oct 2026 00:42:22 -0700
X-Gm-Features: AclHuK_wCNAhqJf4c__nZlElCjEEiY8MOOLk1kNiLFXSjiYnruSv8DQvpSl-nBM
Message-ID: <CAAVpQUAnURtwVgKmRYXTZBjEyb58mxXkeJoMkh7Mc6+ESb1Sfg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: clamp return value of tcp_wmem_schedule() to non-negative
To: Octavian Purdila <tavip@google.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 12:37=E2=80=AFAM Octavian Purdila <tavip@google.com=
> wrote:
>
> When sk_wmem_schedule(sk, copy) fails under TCP memory pressure and
> sk->sk_wmem_queued already reaches or exceeds sysctl_tcp_wmem[0],
> tcp_wmem_schedule() returns min(copy, sk->sk_forward_alloc).
>
> However, sk->sk_forward_alloc is a signed int that can transiently
> become negative when tcp_collapse() re-packs partially read or high
> payload-to-truesize SKBs in the receive queue and charges newly
> allocated SKBs via sk_mem_charge() before freeing the original SKB.
>
> If tcp_wmem_schedule() returns a negative value, tcp_sendmsg_locked()
> passes that negative copy length to skb_copy_to_page_nocache() ->
> copy_from_iter_full() -> check_copy_size(), where it is converted to an
> unsigned size_t > INT_MAX, triggering a WARN_ON_ONCE(bytes > INT_MAX)
> and returning -EFAULT instead of waiting for memory or returning
> -EAGAIN.
>
> Clamp the return value of tcp_wmem_schedule() to [0, copy] so callers
> treat negative sk_forward_alloc as 0 available bytes.
>
> Fixes: 849b425cd091 ("tcp: fix possible freeze in tx path under memory pr=
essure")
> Assisted-by: LLM
> Signed-off-by: Octavian Purdila <tavip@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Basically sk->sk_forward_alloc should not be negative, and
I was able to avoid that by refactoring tcp_collapse(), but it was
a bit invasive for stable and late in rc8, so I'll post it in the next cycl=
e.

$ git diff --stat HEAD~4
 net/ipv4/tcp_input.c | 158 ...
 1 file changed, 109 insertions(+), 49 deletions(-)
