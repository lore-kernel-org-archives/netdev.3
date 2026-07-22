Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D5136728F
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 01:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784684486; cv=pass; b=QgNDvLJ5948/1ZPZ6tyzY9iDs7FC7SWU/OoOBUpKM2/Ximt7mInXxYt9f+lE1hiUWoMuQ4pOOMkemy4t1BBTkl73J4py1/d0wZa0yTdiwr+MeDX+LWV3AIpNyyjCfKuTZ7VTIxA4FnoiJDpY+S4gi0ecNt+R24o/0IXCael9LuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784684486; c=relaxed/simple;
	bh=DWxPhpip8/IhJUCrYuBF587HHqHJ+ze9RCPGCXyBJFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6hHfxJHW1nWZIgHbAY4FdiiYTyBBfjIlbemWDWRzHi+8KuYem4eZh630/Oqv3fHHTqvb++7D8FkVsw1OEBuxdTHCVdURwI/4zGkDEH3I0XiQcXYF06QD7OI+o0zcYerNAANBoLZfZvGsMbrXSwdYo1JcQyjaGs1U424BSUwsxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmX1kIMm; arc=pass smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmX1kIMm"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-492046a3313so5754159b6e.2
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 18:41:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784684484; cv=none;
        d=google.com; s=arc-20260327;
        b=Gxz1ITQEWDL1HGJ+PZ2mtL3V76Rod0brBIeyixHqQwzWn7YO7P/sdT3aNNaYFpqX8F
         YrcA1wMqufRbYWmSS5OdgGg9onj0hXA83NkwW4/nTgWMQeZadxUYW4fuXIR/SuzYKq4I
         LXLlGVPmQge3ci9bwqRsanz5VpyVv9cL98qYkNMNnqsmRaY00fT5qluq++Ggjytdhmm0
         NLGNV9ZNqKxsTRGNz0MeLuEN8Zga5J+SOeDupfcW95vgDWkYA9T037Mp/x1oGPRo3N3r
         GPPhHaz4Q/LNN6IBnzVJzXLe+ygIvELa2k049lGZzE/bCvA1abk+2lLFNGk4OrYEE3Ov
         WDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/6tG8pW58EXYQv+xaW8V/Ta1mDthHjYfoPQUWvI5+Dc=;
        fh=yU0TSWdc8iURG76UwEFfhEdr4Q7+Xc/7pSSJQvjVCgk=;
        b=G4nvYl1a2lIyAU9ZxpVNpumEXQax4o4D8HxWjY5up02ATf3KvXQWaWdvFTeP3/900s
         PAkGDMgpC/SBModouHD1x5p3vhIp76JILGsBdFWHuDkWUhi87k/Z+tj5T5/nAzZAdw7K
         0YneSYTATpt0JBoT/p2K3UO+xt0PnFWCvFlOqRc+TUWhBXwvw2WGWTixyLD1CcWtMb4Y
         LY56j5RHQWyvGa12ftdo7DRrlGkDd3100+6XNsHZaNQ2Mgyig+0nucXSgljLqZfzg/LS
         327Aj15djaDKwabqiCiULJb13yBfL+/JPxPINbc0VBRYJEAONj847+q0a8SvXSA7xm9f
         iY3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784684484; x=1785289284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/6tG8pW58EXYQv+xaW8V/Ta1mDthHjYfoPQUWvI5+Dc=;
        b=TmX1kIMmz9G6cs/5AVf+J+JDieDwilfo6Tzho0r0e/yFMj+S9LXrRpvnFsQKAG30Oi
         NpMMx1Q8ALL4ghU34unyWfMsn5kbWZUE0GAyWqp51g0KrT56TcsQlion/sQ1jKL9g8y2
         yG80v5qMHv5+5whbcarSrIzZtgo0DzwRWzdFBkJxmHxcPuDdIaepCsnZDEYzyezb4OHZ
         fbQq3Qo1+oGapwFn7ovrDqB8BNV9TCq5bvO+x23GvPkQ13FpcLJ5wAcFNBIU6goBHmHS
         zwRybbkZAtOfqD6HxIn4S1EV4Qzc7XNYpbGi7uj1PsKyxYZC3uOvaZ+kyAXzEM3Ftcm6
         AC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784684484; x=1785289284;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/6tG8pW58EXYQv+xaW8V/Ta1mDthHjYfoPQUWvI5+Dc=;
        b=CaE7TJjybknxZWKcid8ycZTgv07WyGkf5IimSf5Wi5coyzsYYwSmqHCBO6iIqmvhA5
         tOlMC2EFq3dp2cEOi1X0xkPGJREWsPs/L7p7DeP30FQm/GZKFywCGTCJqzHJ3AyJBWwA
         ZXAgGS/0iJp9jxSvLR8NQykSAbwmK4eH4o770GuW6rRdzsAyhyJqJkHCi7oIcNWlaaXP
         9pOEQnBKUoGQzdUmhvBPwFWDv9GL88OIwXyExeT3UumZgwIfTN+e1Zno6JnmiQWBlgOh
         +zFv6vyVfBe3n93WHt9vX607ZyrqzwoqvMVWGmD/P5TBeDHWn82UAn/WApXFpW6VQjff
         GHkw==
X-Forwarded-Encrypted: i=1; AHgh+RpPIYDX+fMKYpVSnYjixmOpky442GEk7FN8zFbEW48kOiKR2kTeQB7jsoBoHIY+xNYVx5i4+kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP8KU+aFnYHVnH0vhAQvhoIQw8YAPePJrM1rzLMo959bIYFytp
	1LHMpLtgI+4OMW9xk89R/PxTXyn2ns9bIMNBM3bUNnCBdbl816BJTbXRVhTJ9jA+x0A0BdSh99t
	lzmuKIP3++EtQgoygLmhtuMCo067CdBo=
X-Gm-Gg: AR+sD13sTxdH1Zyk5foKM3HRXI9jccAjrFsq6JUG4QwJ7Z1SLkdpqBkwbwwLxTEezJy
	1aiqqx/mE7cz62feREQX1d39B7aWFDT7PTGiqtCsTNSMEJguXWH1U96/IT9YiilyU4dV5s5XDio
	oVGBD+KBdayVtZhJx4zfoaVpvW8asT1OzknNFtZivqo+Qc5JvMwATrLR8ig/HOFZzqtIC7ncyZv
	/Q3ZnJtRRvMUQ/YE7+rSbwli2hIlYkh9rM67zlQRnQJ2tTk27Vl2YupVUhTF9k3LcHYnvM94YY=
X-Received: by 2002:a05:6808:444b:b0:497:d87b:6dc5 with SMTP id
 5614622812f47-4a4d040a332mr11933838b6e.40.1784684484107; Tue, 21 Jul 2026
 18:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711151934.2955226-1-michael.bommarito@gmail.com>
In-Reply-To: <20260711151934.2955226-1-michael.bommarito@gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 22 Jul 2026 10:41:12 +0900
X-Gm-Features: AUfX_mxWWMQMtiNSGG4NLkJRK3sinO54dggm_u1hLdb_MQnV5pUGd6DXB7U-D5w
Message-ID: <CAMArcTWnP5-Os9YOv+Z3j2ob40P4crT=L6cnrM8Gbr2wcxRSZg@mail.gmail.com>
Subject: Re: [PATCH net v5 0/2] amt: fix use-after-free of the skb head across pulls
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 12, 2026 at 12:19=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>

Hi Michael,
Thanks a lot for your patience during the long review.

> Several AMT receive and transmit paths cache a pointer into the skb head
> and then call a helper that can reallocate that head before the cached
> pointer is used again, so the later access reads or writes freed memory.
>
> Patch 1 walks every AMT path and, for each pointer used after a
> reallocating call, either snapshots the value before the first pull or
> re-derives the pointer after the last one.
>
> Patch 2 is a smaller, separable hardening change: the three handlers
> that rewrite the ethernet header do so in place without making the head
> private, which corrupts a cloned skb (for example one held by a packet
> tap).  It adds skb_cow_head() before the rewrite, split out so the
> use-after-free fix is not held up by discussion of the clone case.
>
> Both patches build cleanly (x86_64, CONFIG_AMT, W=3D1) and are
> checkpatch --strict clean.
>
> Changes since v4:
>  - amt_update_handler(): also snapshot amtmu->nonce and
>    amtmu->response_mac before iptunnel_pull_header(), which can
>    reallocate the head for a GSO cloned skb; the tunnel-match loop read
>    both fields through the stale amtmu.  This is the same class as the
>    query handler's response_mac snapshot and was the one remaining site
>    the v4 fix missed.
>  - Remove the explanatory comments added in v4; the reason for each
>    snapshot/re-derive is described in the commit message instead.
>  - Order the local variable declarations longest-to-shortest in the
>    handlers that gained locals (amt_membership_query_handler and
>    amt_update_handler).
>
> v4: https://lore.kernel.org/all/20260707193243.3448201-1-michael.bommarit=
o@gmail.com/
> v3: https://lore.kernel.org/all/20260626111917.802243-1-michael.bommarito=
@gmail.com/
> v2: https://lore.kernel.org/all/20260617123443.3586930-1-michael.bommarit=
o@gmail.com/
>
> Michael Bommarito (2):
>   amt: re-read skb header pointers after every pull
>   amt: make the head writable before rewriting the L2 header
>

LGTM for the series.

Reviewed-by: Taehee Yoo <ap420073@gmail.com>

Thanks a lot!
Taehee Yoo

>  drivers/net/amt.c | 87 ++++++++++++++++++++++++++++++++++++++++---------=
------
>  1 file changed, 63 insertions(+), 24 deletions(-)
>
>
> base-commit: 2c7c88a412aa6d09cd04b414211b4ef8553b5309
> --
> 2.53.0
