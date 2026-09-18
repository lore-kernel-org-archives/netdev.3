Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4525208B1
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789759101; cv=pass; b=s1qaUt3blztIybHh5uPFGAWGcNsaS/zJRsoLhARGG0vufXVWLb23Fu+8BX8l5zMmIRgfeOoNmCdKGD3xaoLkEbjV1TmFw/Wt7zyUk/7hcJ1V1NSnD0KpqGZ0Cv+WZSItRwVB32qoWwPmhbWtxR5PY0DOyFgReeZkWzIV8l3CdUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789759101; c=relaxed/simple;
	bh=d+XJY6IjEfDw6B+KKS046I9YvRYsBRFL5fcv5i6AeZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/WPJeN6VZJa3DpOFOlE4k+HniZ2al/EmBSBm6zpGlCBbWcvJvhow6AJXoJ+FgbISpWSXikFkE0d6pEA2spzFY4D9U5xcuXybyFS0bXxaWk2op4CjIN65uOagfPJgV8yl8UMmFC/RXIP9341b8avRsBM3Z/vwEhn1kv/NFESCBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2Pw+oiv; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2Pw+oiv"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8631d0023daso876383b3a.2
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 12:18:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789759097; cv=none;
        d=google.com; s=arc-20260327;
        b=EiU0EfUVRjq2IVeqNAbeKtTDxYcvEs6fxet1WtpJle36HauTbaqBRa7JpkJ+UFU4iq
         je0bdkZfrcP9zF8LRTIfo3GCb3B7tYM9GP0l6mS22uYhcq8+b18PsH9Ag5LS+KLmlsey
         8oNuxwEUj2o2GPCaP1ULjTxtaV5rOSBrpQ9qCMnab7w70L2pwtOMew+zryG0YZyNZ3NY
         6FDg1GFuzst/3QuxADtqjr9o5DmH72jGZdAblGCvJEKUH9zXOlVqJeL1OoylxrYdPjSY
         6MiY8Yg7nO4iZXkWuaEso4NQS5/bh03xfoauW7+9We9Cq1VqbFyhPauqlkIqMxiEq/1E
         40xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2troVCYCbvQMPjyP8m9Thskq3hQDCRWw6lGuoi8DN70=;
        fh=cBj6qfg1mIVt+Ea5OPvYzIYHZHDGETutcb69hUwA0j4=;
        b=pnrkhMbmCITxOfHXJunF6oZHR2kYF37kdhk1xYBgSrDbl5gGNUJaC0lcd9MPvGyCk7
         0lfdvqGILO8U/IGzVRm6FDShqIFlty+ZtMEqZ9MxAqi9WVZ7TTATS5JxPESuUHqW06/2
         CZHiDvkqQh31WBDnRSNXeCOoiLsK/KeK2kROjHOVw1qouD0SznWQVlkv0KhqMopCQvqI
         fUmYJqcSJXsCAU03mvvBfZevITmoO4HEvIq+Y5julaV3ZChvCy9QC4be9gMvZvQ1gqgZ
         NJLtWkwnLHembatC9q2UzzlK7BkXthAWAwHpsUa5Exr0NkdFk6KWNAabsMQwyADXEGC4
         yVZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789759097; x=1790363897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2troVCYCbvQMPjyP8m9Thskq3hQDCRWw6lGuoi8DN70=;
        b=i2Pw+oivlDpwZA9WTvtnw+0/1M/n7/s5NjSEjRRbghCeabioGNa59ZCrMZ7Mbv1Je0
         FgXKpuS1E2A1LyIfN/QdEIKFh6qVX7VmE2GCllCGWkqqBZcqEZbOg9fX0dZ1PSAvkz5n
         Om0U0sJOmZoWDnY9nV6RJxQlxCgPj7jeKJwcmOpgajwi2LfynleHOOw5NCfBLATqTrNH
         e39v8RySMTRWQcEF04tDvUmhA++WWH/eYWHOmTs1I/6iKR3haHNE9qE9LWSm8n1zzXVq
         RoUis+EGa7GW0t1IvGlNCghW7Ssl9si39ErvYThos18K21NQdlMcydlxhoxlXxiQlncd
         2uIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789759097; x=1790363897;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2troVCYCbvQMPjyP8m9Thskq3hQDCRWw6lGuoi8DN70=;
        b=zuwhhMoWsej2N7ZTU1hSkV8Nzk5bUhtyRRpt365u6dOlZsn5B7ge1k206vIoNjj6sT
         oV62OftOi4r/GcdbmUOCNE89SoqBzQW0zOScw/jj9G3vwuzIlfFb/d8kxm73xyPaPi55
         5r4xl5NKXAYcHN2bQ3Pcy7GNHNXjwsML5PX4x8rmmVuV0++eZI7+gq+VESBOO3DrYaxv
         WZgapaBl70MrNQJDcLK6UGgtfJA4Mr5WW253d6lZdEnVX1EzE/YmMZoVQVavVFOyaNAS
         DwVGPG7JlzDWBQZ9A1EY+9HK+iTY9pPQchCrAxT/m5mNni0gPP0bXljc4IXNRoF5AizL
         lT5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzBvhHSFLi/msHo6Uav+bzL8a4+fCO3lS1KSI3zMgvrJ2EfFp7t9PrzfJ5JMg81YaG6wQ0hfHo=@vger.kernel.org
X-Gm-Message-State: AFuF++k3s/6rDP9TJZscvfvQabM8wdXRY+xlyZVzFz+Xyx1MMrJdm+Up
	Kia9wD5U4hVO0jFdidPmsAe5RHUyaiCAvOHKGNnSzXPnW7dpH2/jXBcAP1E0FfYx/8zVgkgkM8M
	Avrhpg8p+GD8Np3AwOjCjlRirp70AMbo=
X-Gm-Gg: AYBFou2hQx7PVVn/xNo54KcWWWuBG7DXESjcsRSdKTh2BRqw3AaN9O+k1zcnyUyAZj7
	xntYgEaHGADORW5Xilw1E9Py1OHcNIt+6wUWMq6sIhIKnMNFPROdrHbmB0mmOI+s2QLc5FV1qKh
	yGR8QMpz8mgku1B68d5MB6PLS3aSvnCt7TwkYXicFcO9fReSR0ic17RTqrc/NEwe0HXK3Zl6zZl
	NQWhWBp+gZnOgYhT3vkH9TeNeX3xARb6YstpTZAE8PshVvGZIZZ4FRV5JHMtjMmdYq50qKkZwfG
	66sDn6Bjh35gNWAeq5lzTHS6u8xXUXWZ80fBec5r0v/x9fZ0dBy824q/FVOfYTASx1SKz04tl6T
	+2tsBuzKAauhccwSM9wFfweVL3zF7QgmWjTM9HFM7XQAHhPWfGKMAqN1i
X-Received: by 2002:a05:6a21:a382:b0:3d3:ad3c:49aa with SMTP id
 adf61e73a8af0-3dd8c5161d0mr8117225637.24.1789759097369; Fri, 18 Sep 2026
 12:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915095017.942213-1-sunyiqixm@gmail.com>
In-Reply-To: <20260915095017.942213-1-sunyiqixm@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 18 Sep 2026 15:18:05 -0400
X-Gm-Features: AcwNN1X66cAUN51FSkageQ3G0yykNkwaD2lYLObSNsrm0QVEPTOJRupGwVR0DZU
Message-ID: <CADvbK_f2oTzRA4x5+5QsTkKeXAmodgD3Noypi7sULf3-7MKQPA@mail.gmail.com>
Subject: Re: [PATCH v3 net] sctp: avoid livelock while updating retransmit path
To: Yiqi Sun <sunyiqixm@gmail.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, sunyiqixm@hotmai.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 5:51=E2=80=AFAM Yiqi Sun <sunyiqixm@gmail.com> wrot=
e:
>
> sctp_assoc_update_retran_path() can loop forever when every remaining
> transport, including retran_path, is SCTP_UNCONFIRMED: the state check
> runs before the wraparound test, so the loop cannot observe that it has
> completed a full pass.
>
> Fix this by considering a transport only when it is not UNCONFIRMED,
> then checking whether the walk has returned to retran_path. This makes
> the full-pass termination independent of the transport state while
> preserving the existing fallback selection semantics.
>
> Also restore the NULL guard around the retran_path assignment. In the
> all-UNCONFIRMED case there is no eligible replacement transport, and
> installing NULL would leave later retransmit-path users and the debug
> print with a NULL path.
>
> Fixes: 4c47af4d5eb2 ("net: sctp: rework multihoming retransmission path s=
election to rfc4960")
> Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
> ---
> Changes in v3:
> - Post as a new, independent thread.
> - Drop quoted review discussion and the reproducer attachment claim from
>   the commit message.
> - Link to v2: https://lore.kernel.org/r/20260902025206.phbpyxmpf4zrtdpx@s=
unyiqi-llm-kernel/
> ---
>  net/sctp/associola.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> index c0512c827d0f..4521be3bd85a 100644
> --- a/net/sctp/associola.c
> +++ b/net/sctp/associola.c
> @@ -1289,18 +1289,19 @@ void sctp_assoc_update_retran_path(struct sctp_as=
sociation *asoc)
>                 /* Manually skip the head element. */
>                 if (&trans->transports =3D=3D &asoc->peer.transport_addr_=
list)
>                         continue;
> -               if (trans->state =3D=3D SCTP_UNCONFIRMED)
> -                       continue;
> -               trans_next =3D sctp_trans_elect_best(trans, trans_next);
> -               /* Active is good enough for immediate return. */
> -               if (trans_next->state =3D=3D SCTP_ACTIVE)
> -                       break;
> +               if (trans->state !=3D SCTP_UNCONFIRMED) {
> +                       trans_next =3D sctp_trans_elect_best(trans, trans=
_next);
> +                       /* Active is good enough for immediate return. */
> +                       if (trans_next->state =3D=3D SCTP_ACTIVE)
> +                               break;
> +               }
>                 /* We've reached the end, time to update path. */
>                 if (trans =3D=3D asoc->peer.retran_path)
>                         break;
>         }
>
> -       asoc->peer.retran_path =3D trans_next;
> +       if (trans_next)
> +               asoc->peer.retran_path =3D trans_next;
>
>         pr_debug("%s: association:%p updated new path to addr:%pISpc\n",
>                  __func__, asoc, &asoc->peer.retran_path->ipaddr.sa);
> --
> 2.34.1
>
Acked-by: Xin Long <lucien.xin@gmail.com>
