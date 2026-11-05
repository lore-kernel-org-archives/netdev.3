Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793915135;
	b=B4vrxF5CpqTkcAIzCdQtBnlNnLWAOq9vGKyfzHuA3OHnZhkOKVEVSHx0cHLquCEjGOON
	 ka0zIvmh2Bccz1qIrSfmGLY/pBjnsSU2VwTAw5bnFqprvdiuY/4cQ4ycVJ7FQf4vaxFNY
	 u3EPuBR9n+Nz2cXUhLjcVcZ8W7f9BgjeK7p1PXrdoC7En5M63ee96IZLHcpbZmaBS6XUI
	 lAzNIco1sMzuSVDndWEBsjTmMeRbMdGEsyBaoHGVTIUynUS2sRsURdSjZpwWm98oImAyU
	 YT8VTaZk+qUGDrzPnN6TUONObklw0p0c/I540bKIKirsUVoZitdgMzHjqhVM4dcTkNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XBxsnkE+28IA77aH3hjVQr91dZIe4Jf6vjoVBKFAajE=;
	b=GT89QGrkFR47Vh/+1lr/TIU/OY089x214c7H6VxG3FClgwMzXqxtlpsg+ZgjPGu54U7z
	 Q6HoBBz5BuNvgp/ANAtwL7UjQ9c5IzT+N9qApemFkJiooncCN7+Ix4FCtBZzBu7HnhOmS
	 JRscqJT75vyGOWJMn+vH8d0EqtmSbAMINIrqT8Dag2QZqTrb6jF5gOvDZz85YhRbiRvZ/
	 06vpL6kXmzlBateRFwC8KMFwZuP3t+W6PSLSJaxbZvNRaVRJCb4yPQqsYmVZr0O4U4wR7
	 cALZBk8De9YRYn+gRUQWnlZM6RpwNKz164o6Fmj54zyuU52uM0EU1DHkGwaAizNDMBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q46lDsQX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F142606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 21:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F142606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q46lDsQX
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1ae18eb9b69so88988c88.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 13:45:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793915134; cv=none;
        d=google.com; s=arc-20260327;
        b=cqOdqz7lbGs4pe0TdZpsk2BuNLZpCjGabcECSK34WtzHzKRUXviwjOOfnj2QfIx/Kn
         +CtZS6Ucs84h61Y2tpYDbkyV9zH4twqwBuJ2+zjIb8FWufkj3Ra1zBKI/2NNr6ybP2I0
         3DUZ+m5nUhdB4gmxbfZ0ge7J/1UV/WLHsr/QyijEDeTKh0YHEgjeR0nUfnYr8d4XSlWu
         3lljMgw2Rtt2v4kg37RBDJPQXGIAO/fe+7GgPkSDZV4c1sFeRo7HoAYhYXGSSg/hh779
         MuOCpCjptozjf8x6Nd2unEwi9ARASyHvimaK6Rd2cXXpZID9puOYzPTqCVaWZC7H0Dom
         0chg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XBxsnkE+28IA77aH3hjVQr91dZIe4Jf6vjoVBKFAajE=;
        fh=04eiHdDdsDVTBNJyzx+d1q8v6Fw3RmQGr4mnUxOAdG8=;
        b=k091L5/8j6BUKALOv/bLx1A53MxWC9PrL5P2nH71dFYR28NQI1vMcDzbq0qr/xqD1v
         duWcDRFRz11ybagALpSCOaS2z/OBCRC6mTTo89ejwBmYIeA5/R4QSxDSBc0kn8Tiqr9A
         kCXTRj7Y0016cxppfIGOV2crZoTynU0pZv5Q0IlexIETtj76R1zOGd/a19TLLMH0VFrk
         VSjQC6amnd314hhPveOKaiq2Q50ddJnfaLyTNIcB6lyhu7gP7D0fYqoSSRX424aB4RaB
         SDa1H4tS6qAJb/y6bRtyurpQirRvr0PjF8oyw8/yI3hlN7J4m/R0/vWqgKF1Mt3WXfxK
         VUBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793915134; x=1794519934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XBxsnkE+28IA77aH3hjVQr91dZIe4Jf6vjoVBKFAajE=;
        b=Q46lDsQXGSU77cw82k2JP7OtVoz9Bw9mRZ6xNjivQlmW5G+TUgK1jKw8ShiVGzEHe1
         wQGxtmzY0jyarpt7zRrc3oqVxExrw813wKg4JQal20AfXtyUaBx623sahIml/wkYztbH
         qrnXjMq23PAbQtsEzQHPUoxYg8FN25FgItMMj+JLMpu9g+xyeIspA0lK1V53yK9TpbtU
         f5Gvn9bddM+W18JFDdFznYOVC94i6BHsXnsS8m6jIAjr1gv4xkMyWXCFfY++LrTgbq+6
         3dX7rvchqSWsiV0npJDqM81mzNJ+gkpSSPyT40/9Uh6Ery1hKdi9lQclXeoLGDPlhEtV
         1uJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793915134; x=1794519934;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XBxsnkE+28IA77aH3hjVQr91dZIe4Jf6vjoVBKFAajE=;
        b=BuCjC7qoMIPn2lzTL4yP/6fkHW1P+fVtlAyAlWl770zy0SoR5oWDJ1M0PPYahGZrCy
         X+bzgbzF6yk9N0DSJ0J+NLo5++p4NuFg1REpUoLTNzj5T3kQw7aUEJvS1QJtgulY6rFk
         2Pwp7w07j6cj3TU10Gtj6BTwaq3brxDSyflZkhCtIAO/BvjHiA4+2wSR2AcO0t6ICTw/
         V1Wz2OsPKgwD0wO1UGwhPD2PG0hJjcBLZmzmR+V/17aA4Lg9xiqAq1RnOBz0PDWjmW1T
         reg3nUkdHI7VLbV5VuZB5d3I8YJm7lDBbYESgPh5mF9M0wfxRzm+XD4wDjEaoWeDxc8H
         saCg==
X-Forwarded-Encrypted: i=1; AKwUvBxHufR0hGqvsItad9nihY+cr307t2FcdpXRQb+Dx9GxgyHQ2D+CPt9xCVkzgEswGNB2iIEtWrE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Q7HHdwM5UbF6OH9j5dnzVDPUogJ3yYk77jxSX+fD5YBLjmhPm
	dKLLZVpWWcyupLQPLC9GQ5n8dcHu531KU7aJXvBwb7VOd3u70PxJMxQUFRyJd5S4aAw5khypLjM
	Nkd9xOM2MzIyGHrXkE4QgkGVbiUBs1eg4pLvVSXbO
X-Gm-Gg: AYBFou1zUmq0FSUPGC8fhMYjbUE6s5oxqwN4TvyqOL1Gf4gVzn2dPEkWOFcVVRbJjh5
	YXTLCQrDKFqA2PUaXsLy6GRGf5L84EEEo0RmRGyJOnFmkWjqCxCQu9dvjRQB7wE5RDfm+i5w3Fj
	5ZECUFZ31hg0RAFrLrOkJftsYA3MVubobhV7YQdO/rXbRJzLkwJlcur2ab2LniQtzAkkomuc/dl
	vxKq68eG1likGQs45NFZf0v6J7Qo0lhSLPHZDOja2L5WVStuw19O/y/vnBGx3KIsgYt8G25NfdN
	V/eB6i4bDgpL9J5zdpG981C+v57AKtrsCiBtfNkxicLBsnLmQqA7sujukuDPK1YJm6r4dunOMzD
	oieagg0kOvTMovRz0g0mD/3Hl8p+mX23cKmPueIhMqAxY54fXYFwMbDpNb+XxpfWmrtkmfXROGX
	KuViQbDP3rS7QqR3RliFgatvjcxefjVl+lO+6sRgPKNAF7hSI+e7fZYwJnO5NHORYuJabA+vpzq
	V4F99c=
X-Received: by 2002:a05:701b:280c:b0:143:2719:f800 with SMTP id
 a92af1059eb24-1b25d3560ecmr329278c88.40.1793915133384; Thu, 05 Nov 2026
 13:45:33 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105212905.3122712-1-kuniyu@google.com> <179391463924.488859.10033550397120765032@kernel.org>
In-Reply-To: <179391463924.488859.10033550397120765032@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 5 Nov 2026 13:45:21 -0800
X-Gm-Features: AclHuK-FSIWzsC2RANAkff8NCi0MBdgNaAsEE-BbPdRtFxqpjvNXmUgsH7RPBwU
Message-ID: <CAAVpQUCYHbdAdfxckQO=T5L8Y6896SZynJeGFUwP9Hv2dXDpTw@mail.gmail.com>
Subject: Re: [PATCH v1 net] net: Fix memory_allocated leak in __sk_mem_raise_allocated().
To: netdev-bot+sinfo@kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 1:37=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection).

"Found this while converting sk_memcg to obj_cgroup."


> If it was triggered please include
>    the symptoms, like the stack trace or error messages.

"Then, if mem_cgroup_sk_charge() succeeds, sk_prot_mem_limits()
checks are bypassed, and if mem_cgroup_sk_charge() fails,
sk_memory_allocated_sub() is not called, leaking counters."


>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
