Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696328;
	b=v84M3FoDJdntlMyqZvkB852r0nALqUQIZNhfhd2752GJ68T77A7d2kC8BIPHczktHPzJ
	 Ba9jRK1HbBfry0tUdbf6VBK1oYGQxfkGgquNuVuiJc7ivpLAqNCoy0euQIRHE4mwk5+wm
	 AN0gCz5OO9prSGnxYgXp1rOlMwXgheCuFq/UHOdMuoTZVD9E+DEhpdulUij6ep5oh3mVK
	 jV0IZG46P83wvOuPy/V5pxLK1mJo1XIyIGtvLpiwsrFD/zcyLLns8+urDDbGVpwTEunmT
	 gaQ5iQvNv/Q+MatdvI/ruyxWVVVwdjNqsTFnULGkbuAQYzp+xOQkS6CAdlovsjBssKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696328;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LzgNMr1WEPxrk7wVEGQEJ28Z4cr4LZ4jISHSxlctT5k=;
	b=xG646+ecu6HmfnF0iIBZV9r4MLdpINGGvcaobb+3DFDnEdOirdZk4IQLziZ02YY2kqcm
	 pMCoZ/heqatdUz/BVePeaE139DcqBLt7mIlq4Ub+Lwb14MOHc4kA3PYW++y8kVxZiJ3f/
	 qPA3Um1HiGx01ujUm8H4t/GX2zy8bHT9b66xo0LDqzYJkDeu/PSWW/1AMxEaSslCFedRz
	 rZcsI3inzxMUBebxaBmK8Jv8w2B+1p7xknp3VmKIe2uExI4ipx5SGY09VbsEpxlwtQsmr
	 aF13htDspEEPxgfRZQ/Q/l/JNwyibwCe9elAw2okOdmiiNJVzhI4dIebD2IErcLxemQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OCTlmN7D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43A0606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OCTlmN7D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808371F00A17
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793696328;
	bh=LzgNMr1WEPxrk7wVEGQEJ28Z4cr4LZ4jISHSxlctT5k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OCTlmN7DFF6UJfANbPxp6DhD000u9+pWIW8SCf8Q8YTPfCSNUrbj3ay3pzhSvjNEt
	 OUi5gq+sDqctbhaabtj0RDJd3qW640SfbmATxJVkpq7NwzTvVKq0uh0uaC3Tni3O6H
	 nqRvLigytRXmQVQvIu9ZHsGPXeMjfxUzPxtzV/boc7RJFIYsSFVGSWrJhdtJS693ph
	 ffzJtadkX3euTmpgtEmk8kbZPcYVkFxzDl+Rowuf0dRn3UOd1DtjyAXmxgMb8LZhxp
	 N4qeDwZ+wiocUP0ELi0s9TyAxNK/rztk2F3jcVwUN/r+1cAJiixXW+yKo7vOCkva75
	 6lGW45x2nbs1w==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-483d290f398so2394901fac.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 00:58:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwdSk7iczOXKnVOFj9AVFf22cX74ZZC0SVXzhDfaRHQVaj5HH5dx2gnJi+as7gzPJziCD2R+Gs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bPnI1/NOeVnWib7A6PohO+pAszWRX3CA8XQw+Iw8/IN2VCnQD
	4FChoOwZ96JPAiFomS8rbOv9Pto3XnZ03Ase2KuhBkVHGAotZzzZAGFZ4LSFg6ffZKp1vvr4jQR
	d7sdiIVbFV1vsrZ90nPtXbz98UdxD3ZM=
X-Received: by 2002:a05:6871:6902:b0:493:3299:f1fb with SMTP id
 586e51a60fabf-4a907847b71mr7647457fac.58.1793696327873; Tue, 03 Nov 2026
 00:58:47 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030120956.3026324-1-edumazet@kernel.org> <acde743a-bf6b-41b1-b9eb-67cbe56fa0be@redhat.com>
In-Reply-To: <acde743a-bf6b-41b1-b9eb-67cbe56fa0be@redhat.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 3 Nov 2026 09:58:36 +0100
X-Gmail-Original-Message-ID: <CAL4WiirKc0vFf=sKzAVLhEcwsgvNh+5LM_-Bo+jM8nis3bmewQ@mail.gmail.com>
X-Gm-Features: AclHuK9sHUBv6k5DxXtQdVUe0U_bWEI1pXf_emxlHM4wtJY0RwRZYgYhWtRh7fM
Message-ID: <CAL4WiirKc0vFf=sKzAVLhEcwsgvNh+5LM_-Bo+jM8nis3bmewQ@mail.gmail.com>
Subject: Re: [PATCH net] soreuseport: annotate data-races around
 reuse->socks[] and num_socks
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 2 nov. 2026 =C3=A0 22:10, Paolo Abeni <pabeni@redhat.com> a =C3=A9c=
rit :
>
> On 10/30/26 13:09, Eric Dumazet wrote:
> > From: Eric Dumazet <edumazet@google.com>
>
> Is this patch a bit old, or something unfathomable just happened ?!? :-P

Patch is indeed old, I did a WIP in almost 2 months ago, while still a Goog=
ler.

>
> Should I reset the author to edumazet@kernel.org while applying?

Yes please, thanks!
