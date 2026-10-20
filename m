Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792535891;
	b=yPMEPoyapgXQvj310oOnrsen8BOZSli6H0/g3cAWn44PqU7ZVD+NChyozEWHm9QtTuyk
	 1uRuRtsrHJ21y8qO2K2VvL1EnYyfeGm2SFdCV3XR9tXnfQBEPZ0bn+0givB0LdgkH6uDx
	 BUXKH+tlAeb8nil4OcQwJTLW4KFm4ss4ZQLjBtjXiMo3kvVSq1U6QoLkjxl0UkVv5YV5E
	 753eJMejqjhU0EjzGt7SOzioeqX2UbYs7fQFvOBEHn2+Jv2zKI75vcdS20gzw/tOl7IdO
	 N6YPbahRXbNcPPn6lCLvt23qdQncsdj6oKkljBQquwzxRA4CmQhWUK7FueNzehvyJ9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792535891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=TLtnvNpQNgeDJo1fgrIbFUzYRY9b2V2srLedu3XuhAE=;
	b=UVQwFhvIO1S1vUnxjRZ9ZVE3AkQOLtwuuzvJcm1nFH0LYi9lUMFNQUo7EDva3Vm26NQY
	 4/7vL1BrJ/Ua0hhZLy5h0gxAveJY39nbtPgCamkTUoFy8nKx1RAKgD/NvU7GZGHZ9ipJE
	 yFZNpYtKQ0OG7BNdT4tFSHfa4wyhvhENsAxfS84K/UqMWRLF0QW7HqvXTyj8w1NzHqZ8o
	 CXM+SsKTz3eE71CyBzYm/MtNCOLZ4cRgcInp1lP0+ku+vl2ObAhWrMpKlE9v2ZHjmbpC0
	 wH2MbK1mIFEpWMDhhWi6T5WhUEE0IjrExALAbjbXs3HSstOICBLM+HCw2Twhuny3TNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WJB45SwR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C685606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 22:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C685606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WJB45SwR
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b3f7763d88so63700a12.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:38:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792535889; cv=none;
        d=google.com; s=arc-20260327;
        b=VfPiXNhMnbDoq8dSK9RYV2SnC0A5ylb699u/CkglkQASp4AcgNH9KeW4kMOX1Dg3uz
         aossOrNn/J9SCGD1RQbLP77sUEMnbHqSbgyJjYdRWLUJClgiitLrKoNP2BOM6rifsm3T
         crXKNGrRNEKmCOzjKg6jmYDRUERJEoBTeKQ6fyICEWg+AB1hzuhVLwcP5chFHvWTP5ri
         W1NaAjGLVvffRVDRLVxuUiWtzUoI8ab1QBWkraI/qBOB1qoPkTbSAhj62fb6JHNdU90g
         nin/qr3eeH8Qw8akCrNssJmdV0E8aH8py21elp+GR3IY6IqH16Z810BPvKsqonFJuzSO
         q0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TLtnvNpQNgeDJo1fgrIbFUzYRY9b2V2srLedu3XuhAE=;
        fh=UPBE1RkchjPyKWxHGNQY4asQ7F3Jw1KxvwqV1gCCelI=;
        b=Q8fHjC6PbAJxENT0pimPzCuy00fh7WF/1jj15JoS5UCGIPB7L8R1j2dZ25rG48t2fC
         V5ydiKIh0j40GzPRbjhkS5E0Gaw4a1EFqgBYrK2lnRIcMI66OPY1GIl3iwi2Ys6fGLc5
         PR9GS83lRQHdis1hTrK0uLusJ2NslPYVhLeuyGMhihEpFd5qRmvxEOef/51sNM74dOGV
         F4gfuUWY8nwGewyXOtga2ic3cElwygp93sxXQf8966mWh1foenrwVFY3XwluOcUTjkLb
         1yJ6vWmhgFgmmsfK4dI88Tw9OnSdm5OJ+SuW1M5tJYLvtA2MgbBm/3P/eRpGQtz5yuym
         1o0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792535889; x=1793140689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TLtnvNpQNgeDJo1fgrIbFUzYRY9b2V2srLedu3XuhAE=;
        b=WJB45SwRHe2VKaU3d/Vr+/IHsPa6KuoYUIvC95e+N0nJ/Zk72QhmK8+kH3+9epY7Z5
         UBnl9OUuTmBOqJAnDz2bx4akTEUu63tsNUhRjbpoEwtvNdKc/YnUR8m5O5Vrfo9T6Uig
         BDKgz2EYmEe3a0enk2AgU4QcrvwzdwcFjEbJ4u+PHRoJTtNekiKRA6tvFWbQ7+mPfrff
         JetkSEfqBFy9bpD+Zgcherr8e6ftOvHpiTdl0h/Ds3YPCc6ke7wKQjNk72/dQBB48r+R
         zQIDtRAWX39k8FAWFC8ehZJ5h6QzyAusEdMQ2qMWaIAvD/QuODSUdZzvJoC0wsNv3PBu
         yKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792535889; x=1793140689;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TLtnvNpQNgeDJo1fgrIbFUzYRY9b2V2srLedu3XuhAE=;
        b=o0VGF4NZAgNWyyJAIN0gwgBLM3dpPUkmTJmok9H8fj3vkmgU5jgSx3ihHBM/o4/nuS
         2jw47fgY5KuR8OjdmzwFiZY4lfvERnRALOt6c39YwF6w4jTq+s0J+T6cE9NEAmw236Ks
         Rv/ZFHh9abOM6z3YO5GTaOt3IYAc7YSxZqdFgTM3IIpRisEvZOtdp9CsDGvLsX7JeFMf
         FtO5QdrGLyHeBaXFNkRVnl+V9YQ0XW/EvCI5J6UlVuV+rIgJBysneuBciuN5CXUEvJJd
         bCd8Bbj0npEU2BmlzGw5JIJa+jb6tbFw/eGw8hwT0wEi25xY9ECAPZUTPYJ5ycRxdnyt
         kSxQ==
X-Gm-Message-State: AFq9FYKNFeEfVJEsD5Jurt3ZYfUyNQRmP9pFIcarddjWO58ZDVepVbDP
	LT41zB+TFvnlo/kYdLdvyWDXry7CGqpsyxzqU+Ip+/O10nYeEq3pBpK1Mv2/dxRLQbzKKxAkjo+
	8QbW4kdmUMTxrbUgybxWFtRQ47RpyZrBeV1WQ
X-Gm-Gg: AYBFou2J7JwOvTkzEmtUXg5Q1QtACdmtl2S/QCIXpd6S5QbVOMXNN+ITM7Jh4S30Rwa
	b9ES52jEmRP1WKrlcv7qi6WaPG9uSqHvq9ihwshAEm5sqcihUcGxgVz+7yxzpAEnoFjAxVv/DBV
	MxPaCWe+2nTg34BDrV0acNPBHhxFhuis3ArmcOXPImAOGGPTr3MvChzAKh9l9v68Vg4s2I/T6oA
	8QDNssZUrYikrQ+rqFMFv6gvEAizwjgnXo/wQOZPfYEr0cFeMfpytp8e/if0n6JkjOJ3nxjHBaX
	Wfh5T+1TguceVFCTlf2IY9WGPr75MKUWp96g7XcoEhZx8nKr/vpWPSQbJftNZrJC/cc7TudVili
	sl7MZ6eKm/TH8XjOTPDHwSlmvKuP3rKQQlb1dXxvthtuKdXPbDAQojm7f1DGTGIugOsXnlDLNBY
	w1APBbWTdKKrFm/AupgJAD9g/lSTh3BbWj33PodeZ+WRs3lnoKUG4XYZ99YtylnY7BmtOW9iAWp
	+bj/coDQPgGvnqoNMJri7qpER0TUdug0grY+TtIu9VxTa+7lQ==
X-Received: by 2002:a05:6402:4018:b0:6ac:62c2:bd35 with SMTP id
 4fb4d7f45d1cf-6b408ea5bb6mr75290a12.13.1792535888632; Tue, 20 Oct 2026
 15:38:08 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020223002.1749284-1-rosenp@gmail.com> <179253561146.3290.7437858872851210199@kernel.org>
In-Reply-To: <179253561146.3290.7437858872851210199@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 20 Oct 2026 15:37:57 -0700
X-Gm-Features: AclHuK9SSZzO39ohnmmvK6xYVSjvLP-OkhM9UD2eXH3736I82s6zox-rYqEtSkQ
Message-ID: <CAKxU2N9cQjHtoKBLkoOjFQzbz9xzmMQ_UxvXB7g6yvVxK_YKwg@mail.gmail.com>
Subject: Re: [PATCH net] net: emac: release DT PHY resources on teardown
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Christian Lamparter <chunkeey@googlemail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 3:33=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
LLM
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
