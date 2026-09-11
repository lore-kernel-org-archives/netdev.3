Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF458225A38
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086350; cv=pass; b=g5hsB0MAZv+rM0Vtv36ZTJWEaFzZndvsNEOklzO7KhZkYw236I3YM73EB6J1ZzjQm5nQTk/R+DzZ/wdX8lhEXqllVzbPB8UjkAEpUlapSP3Bf/wMzc7PJoH16yYyfvBmUhJAgv3xETJMI0de+1kSQqCVtbmEp6lxXpahHUxDby0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086350; c=relaxed/simple;
	bh=uCOZ0LrS3n3H3n+rg4kATp9ASsY5FD80qLKYusb39A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pjhx5gyCUqrFOz2i7f40PUijnZTsD43+VhelatjcVpEFVLhJ6hbSFn0HgsU3hl67tSNWquX9uBWvh4TIUnZqyDky3URk/5sm4YJN02uB1jtCMok6/xfhC6HnU91erJ7v+3zzXeTA/9lkodRSfre+7yQY0Lf7NwzkqQx/VpkQWsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWzOrb13; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWzOrb13"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-86265451beeso217787b3a.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 17:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789086347; cv=none;
        d=google.com; s=arc-20260327;
        b=IGYV5pqpDpKQ/KWTL02RBpa6tLr4ixUb5QYYF9gqeWSMemdosHAqCvcNk9yBwHODW7
         RFoJpslFKQDTGDIIvej3xOW0OK/liSmXdU5pZD9MYc7b1+Z5JWnyvzJnwgzc2+zP7PMp
         wPQ6olIc/GQzSiXxslshayYmUDE0o91INevkY6LY4KCQNiDj8IB0KSFr5HJv1vP06cbn
         j6NxF0ybQvUdnpkg/UJusMGLLNOoI1Jdp09MXZapPgNE+ism0KYzHGHxjRQ8BKG8uniJ
         ShguCnXrVO86sItUk66W4t1Iyfc7CVXNg1COD8Y01KL1P3n3kePxFMI3EeZPhKCIaH02
         9VGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6cY2czYH1vDPyw0bwgbm9H8oNJcDXC0fpW3vN39yQ0g=;
        fh=SXNtp3oOHJCWikFhnSebYCU8Xcey4rm6C0jv4/I/5GU=;
        b=j/wqwV1srWvD2X6PX/Wu1assy7+7casIKTiNGMtTmHKZXKXdJ6sSQx8e96rdoxcoi1
         jgvU8tWANaGt7JZp9cOr4ieXKIQqzkjheFXDzPZ2ahwsgqSSeT3yYM4UWCfwYQca6pzo
         mjgEmdCcOldpWFwQXnt6bdg9EyiZMsT4n5Rbi0lUnlqJXittjZ8SOiXqcCiwk+jPGdPS
         ns5th7syguTAptICfrCtxVYhuaJZWUZOceWkmBwj33iY217xyo/Cnnjbbqz8cikBGsyz
         o8M4nnMtpUh1TUmiQ5CitKuZ0nPxM9nm2w4aI06BWTZruXwbm4IetOIIutPIusd+r7FF
         dBpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789086347; x=1789691147; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6cY2czYH1vDPyw0bwgbm9H8oNJcDXC0fpW3vN39yQ0g=;
        b=kWzOrb13cmbYUWa5sQN7/F2vv/IT8LFBB5CXPspowCrhWl+5HIhEb8oU9lGqPLFdYG
         X/1vNU6Bo0seVZYkhzo56Dk6Jb30GDAbOA+d7uU6cxUXISlqk7bEtOCrTwFtBUXQ0lso
         yXNj8tV2J8LcLDMz78xWVpUrBzqTlZdWvlk2hz1EX/bZafmiEJDRGnB10M1aN2WpCe7i
         4rwKYBavbaVeiaYahDigksBmVSjjOFwkD298+FoFstnxn3Q/r5umklVz+TJrKYEHOm7n
         6Pk2nqxaFcnLUC7exsJtjqQ9rbsIWn//PfC4u3CLiZk5azYSyYL82NLa8xoF6hjgfkTQ
         fd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789086347; x=1789691147;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cY2czYH1vDPyw0bwgbm9H8oNJcDXC0fpW3vN39yQ0g=;
        b=p2ocf41FuDE1Equ4lofRRjleiFQq9jkyAuVLyJiata4H25Z8Y47ZogqpqvLciq4Kc0
         V9DMDu0bgquJ2OLq6XoVDF5NJ798DBh1uoL7w12Hjb1CK61yjOb9BZNSRAql6ImBnHx3
         Bf98Fg2A93tCyBaMOhVHiqArQNJXKK/vqX5N/kv7LdsKY3xC/2U5sQAiCe6yNrLimWp4
         OBUUAhGVtxy+EgUrhn899FWA3h/hhVs7qtdbSj/BuvR2COE96YJAD6ZOVz0uvWXxRlhT
         yRXdvXLOZhPbgXLfT9TouCEnSpq+sQrhIhRB/TGvKqltK0AAT/wVQJhg3+UezFt4jfxB
         j3qg==
X-Forwarded-Encrypted: i=1; AKwUvBwyxoQkSHmoIv3ye5V+7YnBnCjssdyX452hcon7kiSQjxg3wNPoy4LI+K1zHr6VmFNbolt3M38=@vger.kernel.org
X-Gm-Message-State: AFuF++muEjXYPU1ry0oKe2UvE+K4I9bdI2Nh4Zji74sc1ehGuCbwzCbY
	O5RXCbqS8gHDmndgU4glPZVv6PScV30NLpAoD82RkS4/pl4zH5xpoc28MUwbL07h5EUMdHZUA9Z
	MmnqDVBG2Kb/KyMHXUr943clZ+PJMkBI=
X-Gm-Gg: AYBFou2BLIgvBt6U2cL+t/kShVUtliWA+DfbS2u8UT9kHikEUs5D1x+fogkrQaYwASR
	EUkaXDwLuU4oH6S0ehp0rMD6hLKalVw0A4HrXH/lXRpN8Z9pg2S7BYElZJ1PAdDIjBxZVWCZnRJ
	eH0DwR9Q6Vlc6NdhxTmOd5VBlUlCA9vNh8knfk3APw/YEQ4NUR8O8YrsYX8hqWnoDlruGtKoWuE
	FvIpXOSP0IDBjqx5ZnaOS7YV1Uxhm3E+UekDLZg5OuXE9Tu9pYT6Fk7+lDimqb98gxVN46GBk4F
	0PrH7HcBUGFYFhyS8+gHyjkanQN0YdUYYlXqFrhJJWXy3bFnz/9LV/JN/8M+q5uacFd27sngqc6
	OE7lBscg3hFAUAxZKPBDZ3czkKIfKZGzAm+4T1TMmjTzgUCL672jwYXqMZvCgHG3f6g==
X-Received: by 2002:a05:6a00:3a27:b0:869:9298:ba50 with SMTP id
 d2e1a72fcca58-86b2aad0ec4mr2473923b3a.0.1789086347093; Thu, 10 Sep 2026
 17:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvbK_dFoagLs1c4b-3aFqsbDueu3VO0t-8S93+6GgevuoRBLQ@mail.gmail.com>
 <20260902025206.phbpyxmpf4zrtdpx@sunyiqi-llm-kernel>
In-Reply-To: <20260902025206.phbpyxmpf4zrtdpx@sunyiqi-llm-kernel>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 10 Sep 2026 20:25:35 -0400
X-Gm-Features: AcwNN1XUuVVtdAD4rJUmZCOIjcTX3a30cN5AS0GEJXKtJi13ZMB16vRmNezrcKU
Message-ID: <CADvbK_e-7_aLVKYUr1hogQLJJPGEOCG_HqrTE2+6TFC3Mg=Egw@mail.gmail.com>
Subject: Re: [PATCH v2 net] sctp: avoid livelock while updating retransmit path
To: Yiqi Sun <sunyiqixm@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	marcelo.leitner@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 10:53=E2=80=AFPM Yiqi Sun <sunyiqixm@gmail.com> wrot=
e:
>
> On Thu, Aug 27, 2026 at 3:50 AM, Xin Long wrote:
> > After removing the continue, I think you can keep using
> > if (trans =3D=3D asoc->peer.retran_path) here without 'last' needed.
>
> Yes. The v1 'last' variable was redundant once the SCTP_UNCONFIRMED
> path no longer uses continue. Drop it in this revision and retain the
> original wraparound comparison after the candidate-selection block.
>
> The reproducer is attached.
>
> sctp_assoc_update_retran_path() walks the association transport list
> from the current retransmit path's successor and stops once it reaches
> the current retransmit path again. However, the loop skips transports in
> SCTP_UNCONFIRMED state before checking for the wraparound condition.
>
> This makes the loop non-terminating when the association contains only
> UNCONFIRMED transports at that point and asoc->peer.retran_path is also
> UNCONFIRMED. One way to reach that state is through ASCONF wildcard
> DEL-IP processing after an unconfirmed address is selected as the
> primary transport. sctp_assoc_del_nonprimary_peers() then removes the
> other transports one by one; when removing the current retran_path,
> sctp_assoc_rm_peer() calls sctp_assoc_update_retran_path() before
> unlinking it. If the remaining candidate and the current retran_path are
> both UNCONFIRMED, the loop repeatedly continues before it can observe
> that it has completed a full pass.
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
> Changes in v2:
> - Drop the redundant 'last' variable as suggested by Xin Long.
> - Link to v1: https://lore.kernel.org/r/20260827075006.3979566-1-sunyiqix=
m@gmail.com/
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

Hi Yiqi,

Could you repost the patch in a separate thread without including
the discussion below in the commit message?


    On Thu, Aug 27, 2026 at 3:50 AM, Xin Long wrote:
    > After removing the continue, I think you can keep using
    > if (trans =3D=3D asoc->peer.retran_path) here without 'last' needed.

    Yes. The v1 'last' variable was redundant once the SCTP_UNCONFIRMED
    path no longer uses continue. Drop it in this revision and retain the
    original wraparound comparison after the candidate-selection block.

Thanks.
