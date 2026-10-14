Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA18255D875
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995450; cv=none; b=OqCAaJI+C1OZl+EtyQXJL16+COATv8C0AGrieeG46kQlzoMSYzPIPZAtvzbYMXhL/2zKj6wBJtwzfJTeSlVsj2GgNVKr5J2ufbjxAFz+XJiePex/WisKbC5TzvohOjZAKI3sWK2gQo/cIrIWfiKs7Ozo4eF6TmfafHnaT6kR+nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995450; c=relaxed/simple;
	bh=BrjkRWhyANEzvU2G8fYFBH01XWMhW7Vpygjf58bbTgA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+lQ/TdexS3qSGkklSt4KI8F0itQ68t1Vp8Gp6eoMSOedav1dwQLbrDdUPkg/FzepB4JUonKU5nT1FJdEzcxjwJlBcXwFyHtqfB1JWGcJZvyOU3KOYnY24i22eWQO8lFPEYPkiIxdtm9lQE1H55UYOYqvLMHn7dGvzrUjYBJ/w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I86KcNay; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I86KcNay"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso10485535e9.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791995446; x=1792600246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jlhZ2D8PVaX0+/HQ1rv8ogSvRZujgAeRl9LWjz1EazE=;
        b=I86KcNayWRCZftozOOWWxK91poIAkB5vFmgIEJV7louwmGtzLv2/UGs6AaJ//tcT2+
         nKCEe/p2aWiFkRTRK6r+W4ppgLnG2mv2LdkDIDnkt1zqUBxiYNtmJl9xzzz3jDkdF5eC
         Esl5dunQWf1ZWJfrOkCG3U35nS7NtZ3IIif5JqK5yhn4/QBmJC6puAsbqJWnnJsOMu77
         Q3Cmo66B4stsYqUmw+GSm6Alc6JjbB6g9Os9db56nlsTu1avF3A87TN5E6SU6ycjX9UY
         rmvHw2YEDL+T4lvUX81U0Sd1sN6XsXpcIMmQWO1aDQq8EbyjcBXabohOqNS82/ZlMdzS
         iHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791995446; x=1792600246;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jlhZ2D8PVaX0+/HQ1rv8ogSvRZujgAeRl9LWjz1EazE=;
        b=jV4tQOWqofS/tkR72KWPG3m7UqdUa3ie9VCTZevpq9BOvsooG4BJpSbN/9qIM9fHvO
         s1Fe6kBgvu7iZpf2Pc9OzQjfMaBPuFVA8cP9Fy5xNDOrkzLXYpCCvlCBYFsVJTH23REg
         0X8o82tqScHxJGFYVpyPv5hJwr8MbyU7Bvq5Pw2Kd51uDNwlec9boCxhZMf0E7R0Scdh
         XC5q1DDGJrDOSvHFBSV880VmyDO+/Y8giWpV+WEwIIOJyp1RdpiqeLJxMloA+FMy7S23
         C9pZHEyY3We4UvGlAXJZmTls0hyz9NAN7WHCJ0dmHOYXLRqLXepsEO06lW7mhOEMTm/B
         qmiA==
X-Forwarded-Encrypted: i=1; AKwUvBzL9U3X3N1mKGl8LUGx6ITDTWZGsmLGfnamOyqC/wRXoqEY+fVfCvvxQj8p75AK3Fj8mog+AEQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8OaUscb3FgBcCHarHO6Yi+rAyHMiD5EvXM+ZcFzOn5EFQb4kY
	w1EdcGiS0P6zgRKy22FCXi0QrRS4aNep4Ty8s84KYImZk+dAyM/hZ135
X-Gm-Gg: AYBFou1RZjcdSoFzPugHkanfHAsoUFBPKev6q1JmsfHWKCN5+KnLuNOwsN7LWbNYKR0
	hmGTMSP4Qm5sKXI1F1QTNssjLLig0Qgba7BIfc/BjxP7yoVZV+kmdsYltkrPQZL6gF+7vSFLpr+
	ZMSO5z706Ifm1a87JlO+HT1GpLpKuwvBXE52VghQ+/U14q+PPUa/CsGaoXq/CJDzfF5+F5YzrLj
	NrpVUuFmM4No0iQJlUnoHrJ6ZoStXtjTuOgJ/0DfiRJKAzobsBHFlS7uX0yuhl4hO97UaGzPPkQ
	1eey4MDeELJIe4mCmu+wcVgSBmdVKbmOnljCO2FtuW6HOk97aLNf5/+WNvYVVMuDsCR2HSoMIAR
	YyREIiSAsynOE2QFEuNx1AUdVHwwDKIoarxpMK1Nc+Zlwy7wb9yAZ1uXNYkcobcLZmLi2WPixeF
	DtmzL6iKcsvQFTQvvd60jIaZUayC6csnvZT1UeVkqeClFliMqx3SwE5zUL4wbBvFr7G2CXNup8B
	Q7ivdnD83IdX5R8v3LrMsKg4RIJlh0IdA0=
X-Received: by 2002:a05:600c:a00c:b0:49f:fe90:de63 with SMTP id 5b1f17b1804b1-4a18e4e0a3emr341491645e9.28.1791995445684;
        Wed, 14 Oct 2026 09:30:45 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967affsm11644556f8f.1.2026.10.14.09.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 09:30:44 -0700 (PDT)
Date: Wed, 14 Oct 2026 17:30:42 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
 <anna@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Mina Almasry <almasrymina@google.com>, Kaiyuan Zhang
 <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: skbuff: make skb_copy_and_csum_bits()
 report unreadable frags
Message-ID: <20261014173042.0a74a25d@pumpkin>
In-Reply-To: <179198668564919.2.10323410751655182155@toxicpanda.com>
References: <20261013-b4-skb-segment-nosg-unreadable-v2-1-6c28d8ffa51e@toxicpanda.com>
	<20261014135154.05de968e@pumpkin>
	<179198668564919.2.10323410751655182155@toxicpanda.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2026 14:04:45 +0000
Josef Bacik <josef@toxicpanda.com> wrote:

> On Wed, Oct 14, 2026 at 01:51:54PM +0100, David Laight wrote:
> > Can't you use that fact that the csum function should only return
> > either 0 or ~0 and use the other value to indicate an error.
> >
> > ISTR this coming up before with the 'copy_to/from_user_and_csum' code.  
> 
> skb_copy_and_csum_bits() returns an unfolded __wsum starting from 0, so
> 0 is a valid result today.  It would work if it started from ~0 the way
> csum_and_copy_from_user() does, since that doesn't change the folded
> result and the sum can never come out as 0.

The result can only be 0 if either the length is zero or all the bytes
are zero.
You can probably prove that is never required.
It is likely better to initialise the csum to either 0xffff or ~0.

IIRC both IPv4 and IPv6 complement the checksum before sending it.
For IPv6 a zero is invalid (it means checksum not calculated for IPv4),
I think the best was to achieve that is to initialise the csum to 1
and then add 1 after inverting it.

> But this is one of those "you have to know the behavior of the function
> to use it properly." Explicit errors are always better, it removes
> ambiguity and creates cleaner and less error prone code. I'm happy to
> change it to start with ~0 as well to add the extra protection, but
> explicit errors are always best. Thanks,

Look at all the places ERR_PTR() gets used.
An in-band error indication gives better code and is probably less buggy!

David

> 
> Josef

