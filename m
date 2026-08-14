Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969325393E
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 05:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786686469; cv=pass; b=a6d3gu9IE5vx+GbGCZ2PG0z+DgV8WjfHSIC87bDyw9lxU6MMTkoy7LChk4WOPOXYh0hfTqPEV7SzJoFI92CK8quGja3xhcCj8p4vUZ6sbYsdCW6cw3KDheHtro6EgaGyYKvJ12kIjCvKV5+k0mO1VVkpdmf5lFia8/KVSLg/kek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786686469; c=relaxed/simple;
	bh=Q3DZXpt7Wqmn+g9Yq2uq7Rk6Si7/GyOqNxdewq73hHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zw6iY9x1wnwngH/tif6fF8RWGCLrre/MEY4MlJzrC3rJ8CjruQhVzOR90CTUBvDUIgWyPMqnGZEMZ/MGz2bJH2PiJoksqzExdVhv7oXEJI0X/fqL8n1R2Q6zhVzZiwd51f4q3goIZCkIMQFyNjZylxja3zcwwpX5SxCe1EBWJUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JVyqntf0; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JVyqntf0"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c04bf4711so6935341cf.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 22:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786686467; cv=none;
        d=google.com; s=arc-20260327;
        b=kf9n/btLAPQf4/AkVC8izJ107VIZ5BgKNDenzt10n4fr9U15iH/v/vq+GXRQ7NHM76
         erBPYDCjQfaLWaYkGBgP7xSZ/Bex5WWWMKGkwSNRFcXKRG6wzQF4GkQV4rmV9mesA1kU
         dCC/G6oTgyO6Q4NggL0ZV/UPV9TzhpXR/yluMZ0Cit9GHeLGXxR5CDN2vInuyxPW07rq
         HAwC7TyEMhfBbBJbCQ+FQIGZVHjHhuRA1H1CWabOQ17nWas5i6NbgVta7dXkfHy/xTGL
         13cWjNBkD0J0gENtUzqxsYCFKJj2ccoppIND987Zq4CVQO67PF5dxTsDPEJkFHd+tdg3
         9V3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q3DZXpt7Wqmn+g9Yq2uq7Rk6Si7/GyOqNxdewq73hHw=;
        fh=TJCMtTfNZ1EisSprX/G2yK0GLdeTKtuysdNWSSUWYFw=;
        b=m6Y3NM4QrgPh9uM8mcYF90Mfa6NZhskVt6hsjNtnRPoLY5G8AT76ar5Xj5IE1XeFbj
         Jk+GFJdpAt2GJ8Fxu5zwZU/VPE3/xYjWcdMUW0XvK6dDmEhBDfhJbbpsvMb9QwaQ6Vxx
         Me0pYEBVvmLVoUuP0VNiBNHf7cOmhZ/frK+XkYUSXpwNa/vatNJYiImiZnSie6aYOUpn
         rPSXtCa0L18Rdy1cKZ1l399n+/38l5lrmcs/nX/9ik8Eao8tXg3m7Fi1tVsQhZD4MeXG
         4r0JOCN4LRKibYDd7d9gmUkLD9VSM5iRaMMJZX7qoQUVyyiGOVKkRMMwWEv8lnwbdNCm
         j1lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786686467; x=1787291267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q3DZXpt7Wqmn+g9Yq2uq7Rk6Si7/GyOqNxdewq73hHw=;
        b=JVyqntf0rfCrg0ug2a5DzGxJUdgPuSuXLz5VwA0p7kp5I7js90QwX+BipF0+DzkHxm
         0oPBNZF9kiUW4EpS/FhWpYxYsMe9vxDCvsRrKFznilrGTdvNpv7sxEl2ssNtxoxIGEhw
         N7W0IuOYL/vq/QRpR77nvw/ESSs2uugO5H9N4P3bbOBphpXWbDgCAbs59W4VBcY2iAOj
         6voTwwEehgYHsZylWh0FSiVab7w5o1HwyqlbqrWRcMSgYsvzA7MiPsPyDTX8jqybjJMZ
         4scJ2oO5MOhjUQAtkjuiUG+4995Ausv61wjO2Dg1BD7icN2O4lCq/LMjJIMle5T0GpiC
         QgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786686467; x=1787291267;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q3DZXpt7Wqmn+g9Yq2uq7Rk6Si7/GyOqNxdewq73hHw=;
        b=TDjT/ObcFedcg7u0S/XtqlmxLer3gDXd3Fbdj1gi/uI6BLkP0W4vhwub7A3kC7y9qB
         wQTF+2Yjo5n+uV3hdFlM303LhzDzGcP6rGQx5SgJWgTZxShEi7DzcvioAGkOCp4A0uhw
         B9E6BvDi0OQVT0F8HQ01BQ4j2DKN+SrykkGGLX8vKxq0cBzmw6KF1u+tIT4XcffB3NjW
         VLaEc+2CzfATX7KMfDAV3kLfUuK+wodanmQbOzZxobs6QssMl3P1gJv/+OlX/wKGw4SV
         gqgb9DVrnF/mz6zOWLol7FZdKa1AtwJ1sK9ArigAHI6IOX7z4z5kCK1YQafw2rh4wRCs
         jHJQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYRNFnkUi5Y78HB9rIZ5vwq4iRs4pX3Uz9hIdRSQ+yPohWh1znJe7feI+1U3/NSCkzJBQLmHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXZ3FL/Omgwzzax/hGWMZrzAT39wyL1Fxp7XmYKbJhXwFbhIy0
	kSfRofcYL+9EekFw/TigIC3D57ejioWbuEn3oMOo3l5Dkysv21btyjTlEwAiOFd/nLY6RmfyuCC
	oYW4XVmfjZtLNf4wuvwfaGQZ42ulxwE0pkxN8Efm0
X-Gm-Gg: AR+sD132Txvy/i2qB6vfBr6PFcuHH8bDQHgl0n21etCX7gqTIygoPoZpUfP6+qOvFnJ
	8vMfWdEjOTwtvLdhbGWENhiiEXWdu2Ldw3i/MTgbUFPVzCnc4a6Ck+i1DpPVvE2NJg97/JJZYFd
	Xot+I/HcNsrgyXL0a9Rb4CA9Hw9/p5fxCUEdtEIlSW2pAZmc28NxVdAbJLUPe38R4b/pyarPp3Q
	jZxf/f8oQxr3ip4Gjj90//07TPSO77Bia4XDr3mC+rpcyxIDDGXDm4AAPjFVSi4N5fdaTx7dN97
	v2qROs62xxg/D/ZSWQtSuJFszSYLe13TPdIBUP1qerlqCHLXP+dReeAgdSpg1Hvaj24suk6Z8Ut
	onAkQ7v1K+IozHbRVDlsB13lgcVFjpOXwStGxqzgt0nqS0rijjXKQGlJeElczyL3JOYz4zLzNUE
	+ckr/lA7TRF5YX4UE=
X-Received: by 2002:ac8:7d94:0:b0:51a:8bc9:2915 with SMTP id
 d75a77b69052e-52d852fe442mr38026061cf.8.1786686465526; Thu, 13 Aug 2026
 22:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812205946.356185-1-edumazet@google.com> <20260812205946.356185-3-edumazet@google.com>
In-Reply-To: <20260812205946.356185-3-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Aug 2026 07:47:34 +0200
X-Gm-Features: AUfX_mwsiFHHMSzPZL3uHy9wsSW1RnWIhnr2EB_DvI0cYm-57C4vJHBZK7dNa_c
Message-ID: <CANn89iJC=J+twdHJ6oJCQmc1sked4uv17N+46j3jTnGxg3b9Dg@mail.gmail.com>
Subject: Re: [PATCH net 2/2] inetpeer: randomize RB-tree node comparison using SipHash
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Michael Blunt <michaelbblunt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 10:59=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> The inetpeer rate limiting system stores peer entries in a Red-Black tree
> keyed deterministically on the remote IP address. Because tree lookups wa=
lk
> the RB-tree using standard lexicographical comparisons (inetpeer_addr_cmp=
),
> an off-path adversary can predict the exact topology of the tree and the
> sequence of nodes traversed during lookups (the gc_stack candidate list).
>
> By combining deterministic tree traversal with aggressive garbage collect=
ion
> (triggered when tree size exceeds inet_peer_threshold), an attacker can
> selectively force the eviction of targeted inet_peer nodes. When an evict=
ed
> node is subsequently re-created upon receiving a new packet, its rate-lim=
iting
> token bucket (rate_tokens, rate_last) is reset to full capacity. This cre=
ates
> a side-channel primitive allowing off-path attackers to bypass IP-keyed I=
CMP
> rate limits and infer open UDP ports (similar to SAD DNS style attacks).
>
> Mitigate this by randomizing the RB-tree node comparison logic using SipH=
ash
> with a secret boot-time key (inetpeer_hash_key). Nodes are ordered in the=
 tree
> by SipHash(addr, key) rather than raw IP addresses. Because the secret ke=
y is
> unknown to external entities, the tree layout and lookup traversal paths =
are
> unpredictable to off-path adversaries, breaking the deterministic evictio=
n
> gadget.
>
> Cache the computed 64-bit SipHash (hash) in struct inet_peer and compute =
the
> target hash (dhash) once at the beginning of inet_getpeer() to avoid reco=
mputing
> SipHash at every step of the RB-tree walk.
>
> Fixes: b145425f269a ("inetpeer: remove AVL implementation in favor of RB =
tree")
> Reported-by: Michael Blunt <michaelbblunt@gmail.com>
> Suggested-by: Michael Blunt <michaelbblunt@gmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

I will send a V2 to address sashiko's feedback (
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260812205946.356185-1=
-edumazet%40google.com
)

pw-bot: cr
