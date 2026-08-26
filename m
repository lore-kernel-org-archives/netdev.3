Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3D544AB77
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757630; cv=pass; b=SQdCIY79J/odeuxRrxHb/JjwtkuXvAIWNwaE1/CSQeohIBIQ3qLF2UxwNL3kid4I5TTVjFWBtnT/0W7Lso5fqT2lP8yts+ZnrPB5FIYDXaSy9X6c0JO5WZ71IiKM6yud5k3cvocrn0EnFAzPMfkvmBE3n3yrm9mAWAf/IteMF+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757630; c=relaxed/simple;
	bh=sCZYn2GfaCakpfs73hnSx6QFjMiUhnTYTcyWSrJLlxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fS+u/Z74cigC+n9CrKCnIW0dkdHHtdPdTXBeeP4hR8FCko7mTOzcrnCx1FWIq8/z4It/e6zlLdWO3/CunGypByaXSNV2cOvRF4NtXAdfZqa1WYtcOs68CSVjs875uHo9HBsOGH5BBw69YPdlOZNq9XcSCz7U39jfGeOTRjK8wUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HA+Oy/r4; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HA+Oy/r4"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52de50e77ffso10235381cf.2
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 08:20:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787757627; cv=none;
        d=google.com; s=arc-20260327;
        b=RaMX26BsNmplGIYTDrgNdtLyfjzIBQhHZIO+rZcpJ7612g47aCbdfmp8BSYIsfDFqh
         RokVkdxiNbIPJvGHHUKKO2rszKwHn6qCUqf9ys9sw0TVCtkPh7TeUDO0sUbkeHFpdH05
         MjR/fWXcS7Ed+7KSXwwKSuHZFtsiZWo/nlHvZUIj0fx3/BEYlmxBPs9brwvSF3FMfvxv
         VyoK7CzI0x1qZfAyCTi909DjRF2sqdCXKvppy+yTVI8cmzMpkHBQteRViicXqWndPahs
         aOO+wm60z3CBeW+hITN3YkyvaVsCmoAvGMjbQTn4bhKBd7gktMBsDYYyc5lwMj6GLTSB
         6l4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SfCiydN0Xlj7GfJ4cH4asf0TucQSK91D8eGGF7AZl/s=;
        fh=thUfcEwzc9XSLXaq/DZZh2Zm+o1U8RGXvmsIYtbOlyI=;
        b=XN7Jk0TJGkqEDx7Yt9CvoG2TMm5HMqXN4IyvC8x2I97JhyP9b0hbRFBgEFHoVbgWXf
         rwCJZ/K6O39Eh3EUF/9g+CR2nCrMx5K41yiFSIghHrH0rsYd6IlkDr+IgI97oXWE2ctA
         9NJkZ2CM1X4hGnyjGMnClV8WoC6qc/GJmAhRENR+VfAgOTAcSnsECb2dXAEkxCgU9Yo4
         wcpeTgCKyOhrbb8EjkiiUmDlMzjDXBnkesyb2gWaJZFCWcOOyGuSuvVEnNpsjMoPspfg
         dgz64duX0YG+CKVsnOstYZ4Mb+tMxOw/DewF5eqyaoGcczFfL+60YZ1k+pf93+ZYfNIz
         NkKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787757627; x=1788362427; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SfCiydN0Xlj7GfJ4cH4asf0TucQSK91D8eGGF7AZl/s=;
        b=HA+Oy/r4tB99u5/Pk/LDNGXurwOxfLwosOEGLltfzlpNk2DHw3Y67aZM9kn8yX2xT2
         y1L5bziQD8OXna4h49LznHskr2YIuYVBdqhFtlKSX967vxRpov5VFXwImCWwjG0pNU4v
         3bEpIWPiCT0RP3FUjD1v+0t3l44df5mqzpO3yMyKXBxlXKL+J5u44cGtJLC+vaIn98qr
         N29YyzoX1gYz32EbPx5kM7sr0kVzb3SMJ12qPF9TLxkFiKd4pHl+kM+V7NYAye8PHJUH
         KMwvyulW8vwuSTu/PbdtavxaJFIYIjJxcc7LqYbAuDgdRRDjmAOW0TpdV2nVw2UG/9XD
         mtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787757627; x=1788362427;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfCiydN0Xlj7GfJ4cH4asf0TucQSK91D8eGGF7AZl/s=;
        b=ZyxMG7OEwoqfB8seVY6DmKnhM4hfd7Ym5xFYexV6ebu/Ypkgj14gnmfqDewPqTekDr
         oOtIQXSH2rwKlMi2ZWkOqRNNJSF3tH8OIB3sff+BywdVIZPvDvfJsUq/StbGiQOqSIUA
         uB/NdMLejOt6SlICCZqZxE+rnkdcSQii/fqsiO0LcAEiB5BrYpFCYFRsxt2/1MuBI7y/
         L0r2OO7GP1SsnGO8FybZLlvBpwbKIl6jsd+H/C6iACqx7r2bLcAwGElZw16FUkrVwHyq
         NZce0ieAStqaJTpo2uVQO7wfx3KcKRA0z8aPoF5fS5cQxS2mVPyN+qQk4jCK0HuZvqzo
         9sxw==
X-Gm-Message-State: AFuF++me0GyVyKZxEaKFg4TgEVWtxO16uuFL++wUuLi6Ind8x1EnjBHA
	hZ1IMVCRkjVr32G6Za2ZygFAvBMuA9koREELDuFOskH7d284Pv9ysSEK+wHuTi98y/rd+frOLZC
	i4mmE0mzf9buMrwo1mKT0e0VfUhi9KbKWY7W0ujI5
X-Gm-Gg: AR+sD10bCHpc7z2w9ovZjhlQ5BlViREYGBx+Fi8EqX9PNNWOdt/eEK5K5JZ8X7qqAWc
	EbI2+yb1EY0FSSzPNa+Ua6fFvPjwOnOMmVITnsvc4MqEVA6rr6L+LwAc86TNfrdTwNExMgvQi8O
	LnwEEobt8n/LJhwkTOWKm6Mje8PT5Yf1Zjoyu3uTupZLRkBENWkvIC/Vox3lmpFKYVbtesSDpLv
	BHr2KajeplhmKbEpmAJEXCcjHnrm3HGMhMqZHvCI8yxqob852Ei51VPl4ly0FuFlSYT6qsNeSwi
	ohfdLyKK/R1XEVeCSHXuaFF3U8iQIi6LNkgk6Bd3D15Z7fgGCr+V/YK9CT7ysT15P4Q1y5+cPgk
	4tfGJQb+E6qFBXippiAN8WK8OTC7VghBgDtYAqAl5fwmq8LuS/yAXNubqbig=
X-Received: by 2002:ac8:5fc3:0:b0:52d:6c92:b5e1 with SMTP id
 d75a77b69052e-52e423e01d9mr75971011cf.27.1787757626391; Wed, 26 Aug 2026
 08:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826141145.67823-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260826141145.67823-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 17:20:15 +0200
X-Gm-Features: AcwNN1WQYfOEPBxc7l95bDB56B-HoAnly0oktECUAuu-7YHrmEIMuUzsrsZifHk
Message-ID: <CANn89iLWF7qg+VYcao1L_-e1vXSTCKPLw9a855Gr5+gPe_yG2Q@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: fix corruption of urgent data on
 multi-segment retransmit
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Yuchung Cheng <ycheng@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 4:11=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> On the normal xmit path, while in urgent mode we refuse to build a
> multi-segment TSO packet, so every segment gets its own urg_ptr:
>
>         /* tcp_write_xmit() */
>         limit =3D mss_now;
>         if (tso_segs > 1 && !tcp_urg_mode(tp))
>                 limit =3D tcp_mss_split_point(...);
>
> The retransmit path has no such guard. __tcp_retransmit_skb() builds a
> segs > 1 skb and hands it to the GSO layer, which only advances th->seq
> per segment and copies urg_ptr verbatim:
>
>         /* __tcp_retransmit_skb() */
>         len =3D cur_mss * segs;           /* segs > 1, no urg_mode check =
*/
>         ...
>         /* tcp_gso_segment(): bumps seq only, urg_ptr is copied */
>
> urg_ptr is an offset from the segment's own seq, so a copied value points
> at a different place on each segment. The receiver rebuilds the absolute
> urgent seq as seg.seq + urg_ptr, so it walks a moving urgent point instea=
d
> of the one OOB byte:
>
>         seg1  seq 1     urg_ptr 5001 -> urgent @ 5001   (ok)
>         seg2  seq 1001  urg_ptr 5001 -> urgent @ 6001   (wrong, +MSS)
>         seg3  seq 2001  urg_ptr 5001 -> urgent @ 7001   (wrong, +2*MSS)
>
> The real OOB byte is never pointed at, so the receiver stops splicing it
> out and delivers it as normal in-band data, corrupting the stream.
>
> Guard the retransmit length like the xmit path: keep segs =3D 1 while in
> urgent mode.
>
> Fixes: 10d3be569243 ("tcp-tso: do not split TSO packets at retransmit tim=
e")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---

Nice!
So we had a bug for 10 years.
This is a testament to the fact that urgent mode is no longer used as
advised by RFC 6093.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Thanks.
