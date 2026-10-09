Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E1414A1E
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550394; cv=pass; b=qvtcnn1wXCRg7pyoUMVlWX6GgagKxkD+zh+8gbbI4pCyI1SQvi2sJxh6diQv7mwe3UQjQYDGUEoGlWkTqO4yaBO2YEIsWZLN3nPsNHsRiAi1Dd50vDU0weuEkHB+FhwpJZvo4zn6d/Ex20rAgH8GfDv64XONvS8pTG4HSVr4Rus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550394; c=relaxed/simple;
	bh=Z82pTd9B92P9L7FdZhm2lYoAuLSq6EAjasYSS9dt8qE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWv6vBqpVSZYHwS4N/etebpf690oH/WrYrVNc3RoNhaoI7W1U9nu+h0oK5PBtVA9D2MSv5xn9nU1CisV0nBNdBmwrG56KJ2IHPZqzsW+kYQAOvx4f+4DSA2JAhlmqxK/hAWIImYlvzZ5f8LOM1+CSjIqxXqHXzAdIuCwZBR8sOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifsh87Ll; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifsh87Ll"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a601ba6870so10707538a12.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 05:53:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791550390; cv=none;
        d=google.com; s=arc-20260327;
        b=GiZRLm6hWx0dV4juCooLr5T6FnV+tQgb1pMoF1zBRw6UenOHaEtkUN2+AE8Dvo+VvG
         B7fmL33+mvaTDxY5mMZktXJOtaewPTmkjWgU6cnb4jkdNKpb5FeWjqLq23Gu19Uiwlc+
         Eql8sV5JchoYboI53yrpTXTZ2zXTgAVoeRG3E+boQG6vutmkw8+5vBbR1wOr0BKpDqlA
         eMi0a0oaWP1bW2p6HIGqhKi9xd9e24z9rY1V4XB5jjunOSf3cEAcqyP16hiNNuLu1B8b
         rFNumRqnt0ROa37qeoWDlSFSKOILfQmD/xmAX7/QaCacQ55hwA4UfI2aUrA8dUbiXfk3
         zhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5vMZXYMYLUNNQlIgyE1yknyh4fPOMVeuczGExkJ8JXE=;
        fh=nwfPKKGykxDvWEU+u2p7vEayhPZH6HAfi/PaEGnLnbo=;
        b=G5KOjsR2zLMFdsvmD44Uc6ywN8szuYv4FW9n4f3PFbbr3hsPGQPRgZwNl05QfcuKJM
         HwAHGX3ooHgY1M2YOLv4aeo7OHbg23s77LA0xMbgJo2R4iWl3D6mbguD64RkcDEzN2dn
         7yA1m4cunPiy3e+k6eKBWifdRccr0F4U6rUjV5JBjE8cK4SDIwHtjP3DVvv6FCeFioRc
         qs9NkLcMHEUipHZUK9lM1T5Ki+f+vg6s+T2HdMJoByJ63gaAVhjk5tvDyJqrq19AMArP
         w4AAuChH6dnfJ1fdjhXYFbEOYnvh9fgKE7Bl6sjP1ZoDHGbdirMa9aHmCZQ+sRj7dZJ3
         PaUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791550390; x=1792155190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5vMZXYMYLUNNQlIgyE1yknyh4fPOMVeuczGExkJ8JXE=;
        b=ifsh87LlCN3wkWRcmDkQ60dk2vICGEyqa/7HAf24ZPWmzJygOFJFEFd/Ap2pale/Y5
         RJ4UR+C34UlrOvZuK6akVfOgLFtZn2Eayw2SxxUc8y1qbDw1luHugqGuinmlChwPOreG
         k2JyIOrrVWP6y/TkPZ5UjBXweBOydjaP7guPO5yWmOUtH1ELuDy4p4r8w0itCSiXAMSe
         jQpaaoju2Wf3qFA8SjG22MjAxWmVXeEL4dL5ANOQv3ICeeMzzJsbheJ0hZLmSnJXfmu7
         goZOzxXb6LwZA2pRrhHqAxHbcdZUNN5vA7wUxbFZKT5SnAiJl216AHAf6nqCO9BZWVid
         Y0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791550390; x=1792155190;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5vMZXYMYLUNNQlIgyE1yknyh4fPOMVeuczGExkJ8JXE=;
        b=cLT6TByp3ue6n2YtycQKpksaryewZJegBuGclzjVtLvy+vH9WcAqxE1YG9FjytRqTn
         52gA+cOXAIjPn/Qoni4b86Py6JKrIWqC2NMJbKtdKyYoZFSmYbaAdfypj37/uLPuTSbE
         UXWFWdgEAsBCppNXgIOX80BTXGVLNgtJMuBOj7s9uCfs16oiiSHTlI3eIraN9A72lSJ3
         nrjKwTPiPgZGBHVGcc9qO6CHeQNkFCF6B4lssftmSxd8av/O4T2uDHZllFnrnGs+c3cZ
         bdI6Ip59A2WfnwoifqsCdOBCakjFQpqvod9Z34XrmuNQFlgsgyLdgICkYQSy1CFQJqc7
         Gb8g==
X-Forwarded-Encrypted: i=1; AKwUvBxWdGaG8MAMxT6vdTK6XEsS+s9IAlkZKu9rE71pite0+gjEre2mx/cz1KtWvBw7xKVmHUnhBP8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAoqdUzjpOxQ38SZ6eoxXKffp/JAzJVIEz/NnoHimNd+ZFLQMy
	CujzI6agrSOR69Q4buk/pZm0/RbU9rT+UT6U9AD8SdFdC9Ob7suYz81AUDJ80EnGXVhNNJgXqw8
	r5ySguYJhuZvn4LKRq3ZhQMwPUb1ckoo=
X-Gm-Gg: AYBFou1mCcwepBWoYW43AdrH2a1DA7qvnEXopoUWrF+SmYfd3OyshtyRp20f5cXQrRL
	ZkG8ouAmDntSZ51h1tvrx0UvAXcBdfNnpVAiz62ITHBLrzl1UtSO8ELgQRbwlsuQGZiGoIEyDPR
	jSjdpFnYflC1P3WhJ88zD5zV1B6sEYgFWLrmlFKvBtmny3AkFE95fabaUtKfiBxB20oumN1SW0H
	iX6zdP0im5+6XPhuPWpiGlgGiWp83ppYUek2q9tfLFx6/2wb8/nUuGdl++dVKETC93KacIqzlpJ
	B3yj2WzoAmz2AkQRz5WNlfYBofXbpLMFADU9tOiia47pv2fD6abG2OKDe7Uqw7YxdMJQ1zzv5M7
	jkVd8yAVHG2G3JmgJGPDCtHjWzWgkdaPh98zz0gehFeo=
X-Received: by 2002:a05:6402:450f:b0:6aa:f2cb:754c with SMTP id
 4fb4d7f45d1cf-6b17c25d3ffmr1597123a12.10.1791550390235; Fri, 09 Oct 2026
 05:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008220433.965791-1-linmag7@gmail.com> <038bffb2-e40d-44bb-b7ce-53e9de32e50d@lunn.ch>
 <CA+=Fv5QvhYd7EqVBYKWVgvf92SLE=FjE8EYcZvUQ7HKdx2kc3Q@mail.gmail.com> <becc8f95-4650-477b-b1c7-cc4952e5e980@lunn.ch>
In-Reply-To: <becc8f95-4650-477b-b1c7-cc4952e5e980@lunn.ch>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 9 Oct 2026 14:52:57 +0200
X-Gm-Features: AclHuK8k--wFHWgEgasHO9Vp771hJjGyFtQegdxLzMtXg-Ear1hkFG0UCoGNSGY
Message-ID: <CA+=Fv5TU1rOUimi8f+e0R4_48ki+X3qzD_+1QPyviTnJz-irvA@mail.gmail.com>
Subject: Re: [PATCH net-next] tg3: normalize inherited M3000 register byte order
To: Andrew Lunn <andrew@lunn.ch>
Cc: pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Oct 9, 2026 at 2:09=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > Is there a legitimate reason you would want the bytes are swapped?
>
> You missed answering this. I'm guessing, but does the hardware offer
> this to make big endian machines more efficient?
>
> Please could you look at the driver and think about what would happen
> on a big endian machine. Is the change still correct?
>
>         Andrew

You're right, my earlier reply missed the underlying question.

That is a plausible reason for providing the hardware swap mode:
it can accommodate big-endian accesses without software byte
swapping. I haven't verified Broadcom's design rationale.

However, Linux tg3 already initializes misc_host_ctrl with WORD_SWAP set
and BYTE_SWAP clear on both little- and big-endian builds, before
this helper runs.

The helper restores that existing setting. Its swab32() compensates
for the device's inherited register state, not CPU endianness.
Subsequent accesses use the normal driver path, and the separate
__BIG_ENDIAN handling for DMA remains unchanged.

That is why I believe the correction is appropriate on either
endianness. The runtime tests were on the M3000 running big-endian
SPARC64.

Regards,
Magnus
