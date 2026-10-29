Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793282131;
	b=aY5l3nYwzFlMJduOsawFWpKQEMbChj6+f0c1y9ZPXoBbROTndv+ZeSfMKjl9qnSlDcgi
	 9HySyKmYlpMaak74YOXtcigVMtqZ5mjSqZ/fqC6TRZVv2LWAPZHy4qwoth7JXBJn/8n5J
	 UZUudpklh7pSZwNP9axT4Z8mL9y3Axx3r3lkFMOpwgfQ9BbJq+6ldu+9oTTpcWh812Zor
	 0ceZUjEqDe6JO7NBCEoMs4hKb4LKnUdlJ8hUSaJo/xBLXNRK5dgf1oyB5w7ANtontmSzC
	 C1PEq/dRTnhQV6szrFawn+9cOGkJQyGqbIn7bz+ROJV6T8Dks/99ulNxk9eqPzX8vEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=LOkDxFfKQ22+zC08HSr87rorXATfktqVfXDKvyMR2PM=;
	b=DBbQ2Hv0Y99NLuxZW55oi5sINkCtzvP5jKPCBuX4kry0CioeLr1r03+05XOeNK0RoEsI
	 3ybqzkaC6NNqRDhk1hNvBXsf6s8Z9UO4MNtYpglOXNizNf0cgQ9NGK5FcPqXB3imb+lYB
	 knLownV4Sl4T0n2s1zX4apq+Ggo6okuf/O4bIf7haGwOlA4jXMP/MGT4Tl+H4RqwvkUqt
	 MT7QxSbtKbb6qzpYYVkQ4ffMkGwYLx99pbrb0C48NlOcFUxbvfm7LkkRqyVxNoZxlkl5J
	 aa3EqKWX9FK42QuGLOmLa1RKYPICYvXiG/WzIcVFwF2YcpRmLD6orhxNe6VgrPDC+1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XGgxo2bz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9185606A336
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9185606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XGgxo2bz
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso1135010a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 06:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793282128; cv=none;
        d=google.com; s=arc-20260327;
        b=iFPGENC+5E8TGE1KYOCM7bAAf5qYzMxbEJhlQlpc2QcTgOByHyceIxmlp/6omOUnDX
         TOpBYtkTvvxCzk4OIyzmnqnkd+dzz0CUBnfYQ9ZXrN1ZGBzzCYMQ+taTnfQ3qK+aMCdo
         xc3LIR9dqK5xpbrafi+y0CU22p0CAg+8udwFhEIx9iAb/41b8CXvrzRbmgO7o6ATHM7I
         M3KcWeiK498qrLnFt5+5z1Kv01YifiCRcu5uzz7GOu0fA0XyrA7OFpEJW+4jLms3e6WZ
         jwgJFbtZSbmfwTQADSzvc3fRFi8nOmyhOEZ/ApRiCkgbX8kBERvp7TemWdI67Q08KgkP
         ulNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LOkDxFfKQ22+zC08HSr87rorXATfktqVfXDKvyMR2PM=;
        fh=u4+MTxvAQ1m9MiioWSZueSvPpMJY5wx5MRqC2By3Nig=;
        b=jmO7/nnJF7+ACVq0tRRsopcRBz6pv/rRoDxVAKWZksUaN3Lp4oLhdm+6fsxI+LYwE+
         5/gIS6shFNKoIXE23NXzd67iRooHKJDnBNfxeKFHQESDYrQRkjm4whSLXgplj7VRq6q5
         SeSVumY9idZg7XFpgdhmcP4rrLbod2pbNpIZW9H9PV+ahhN0RhAALtvqL+1q/QpYkq61
         kHIq5t8dcarl8RH+5cFqX1G4KWQqvNVlIQc4pxxiznF1up8RIXTjvSeVMi69CxPQwGNN
         TBRxXu7aAU6MvDs34I/NGXtyUI6f8pLBYVorniZlXwhE4bUirkG89S7JtCzy84t0GG2Z
         Ndkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793282128; x=1793886928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LOkDxFfKQ22+zC08HSr87rorXATfktqVfXDKvyMR2PM=;
        b=XGgxo2bzPESNJHJj81my6LbAb+llfrYuPn4f1O/RqicgPYqYE4W1n5faJUWGcWshDl
         fmEoBCnVHMUIfG4P9nVCKK/WGE81mxzrnh1RiycRm0MKvSdx5q+5ox6pSQWgHCfadGZ5
         I39Ww7Bi8vBcr7MC/jWzWTTyHGKU7x5dy4FFsZp0mRG847VuLXu8LpDLcqowv8NyJ/Kw
         257yYxHetFdAX+rh00go80ltLQv0jFB6icf8ODp5eHgqWYdU1cxXX0UPBrh3UmjetmjX
         1hFf8NDiVDIl+AEPnlKitF5h+BHd5r8Bv3yNJ/VU2iX0HpptoJ0CYYtYT6OyqTjyYcPJ
         nCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793282128; x=1793886928;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LOkDxFfKQ22+zC08HSr87rorXATfktqVfXDKvyMR2PM=;
        b=kyuKhYNOOCWbfQZr9hq1e2h8y68HCp1fN3IBhoY+AkLlG9ZQc9Q7HaMkHIxV23xuaG
         mtw9PNh+2luHHPbCs4Voq8s3EEMCfCrQ+HoOnzulgSbXhdPYn5Q6lD/SKqORSd8jS2gC
         zTjyRucFOz9ZoY7FhqZMD9P8tUbclB5padUGdRbNA/NaXZRvmKhbJmohFuQGk9TJE1MS
         2vUk+3D/mCTvFxL+OzW5Fzjpxr+2yNFha3mfEbivmP6qo5uHvflud7PFtCmV0Gg2ZPeT
         xH8Sx4ULlJzjgJa9tlrZZ2YOvTtPaJp2XPVf2akX8duAc/xrVIAhZf2X+SuixDhpwwGO
         E/xw==
X-Gm-Message-State: AFq9FYLQ1oA0s7KAJP9eeFWypEMGk7WM+nsCD0mf1t8Uo4MW+pggg/Z7
	Fj2M70NmRUOUQ3TOTSdwz4r96rZZKiYn+nqu6bDCZaa0VCYssJoEAoIgNqxlcmA7R9FOl15lSoK
	9OvXl+MIDZXpHiJ+JN+i3l/HI50iduOcd3to03Uw0slAal5tK91WbRw==
X-Gm-Gg: AYBFou3IGg+bGn1eVv5Fy8wNgehTZcnqcfxMd8UIEMf4xHSZrIWjurfB5F0I+9XFimg
	+733ZEJ35Sp+KPZRA9MGGUmH0uVDRTGM73ubbQ/JdRQnxJ7YGe6ovzEo8tzpUfvnjwXhjkQi1kW
	q1hkDTOsP/WxhtfvSWv79XxAPsFI0NO8mE4PaPBzP4kUvIHwqhfGxxRxEqVtQLv1/8ySeg5ShsJ
	xP2AVR6V9piOwLX082KR71x0nR5TXx4xENLApVpLw0tpaAETfEngLnin4NjjyI3FcJz4ba9Rpih
	Rcy7STLE9BUrgwccAX9NMzPz06o1Gap0CbukVAeR0xPHuTAFZBVH+ZmfDUn/anZyfSxkv+P5riJ
	aI0EiEoXu/Y6DbAlvK/RVepT1XICGHVqRHLKPPfn1WFWHXvFOW3rnCAtOKG+234cID8gE
X-Received: by 2002:a05:6402:42ca:b0:6b4:1916:9674 with SMTP id
 4fb4d7f45d1cf-6b4b0b1cf55mr2093149a12.5.1793282127811; Thu, 29 Oct 2026
 06:55:27 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029033942.3644-1-q.h.hack.winter@gmail.com>
In-Reply-To: <20261029033942.3644-1-q.h.hack.winter@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 29 Oct 2026 09:55:11 -0400
X-Gm-Features: AclHuK-Y0w0OjCWYkE0zaN1q75YJI0QAcartxP4tkuLM1kIc_ZsbNlbuifypUG8
Message-ID: <CAHC9VhRQ8E7zysipt3Kt44oC9m-eUc78mR5ipR3YQOwuBXAV5g@mail.gmail.com>
Subject: Re: [PATCH net v4] cipso: fix optlen corruption in cipso_v4_delopt()
To: Qihang <q.h.hack.winter@gmail.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	=?UTF-8?B?THVjYXMgRHVwcsOpLS1SYWJpbm92aWNp?= <omniameasunt@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 11:39=E2=80=AFPM Qihang <q.h.hack.winter@gmail.com>=
 wrote:
>
> cipso_v4_delopt() recomputes the option length by walking the option
> buffer after the CIPSO option has been moved out.  The walk then reads
> the stale bytes at the tail of the buffer as option data, and a crafted
> setsockopt(IP_OPTIONS) buffer can make it treat one of them as an option
> length, increasing opt->opt.optlen beyond the valid option data.
>
> The corrupted length stays on the socket and is later used as the copy
> length by getsockopt(IP_OPTIONS) and by the udp/raw/ping sendmsg paths,
> where it exceeds the size of the buffers they copy into.
>
> Compute the new length from the intact options before the move and
> subtract the CIPSO length, and fill the padding with IPOPT_END.
>
> Assisted-by: LLM
> Fixes: 014ab19a69c32 ("selinux: Set socket NetLabel based on connection e=
ndpoint")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
> ---
> v4:
>  - rebased onto net (fcc00b15cb21a)
>  - reworded the impact paragraph only, no functional change
>  - first public posting (v1-v3 were reviewed privately)
>
>  net/ipv4/cipso_ipv4.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Thanks!

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
