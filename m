Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792716266;
	b=MLk+zfH/PkrUrRy06JHo6tylO8mN4sYUoGtMChB91CKdcibbZCfuq7fieIZePfOd/LXq
	 0vZGGjdNHc9n8uQNUPz9+R9A6RbzOz9WW+/AAeDsogdYPkJH+iz8GEd4E1Bj0jVSRoWvK
	 AaUqL2vtPpgyKiK69QCTzUBDTYyD3mdBJ0wWxfN0nApYFe5zQtw7IvVECa6auGwCFtCWd
	 oL3rKlNZDVtmGYgiKS5fwTK8kwSu3a4k1irSrswd1DrEP/9/QJn0oPmEosj9WUv0hcgOb
	 ZAlwSXMLh6vOJTQFBBYXO50yBP3xxd0CG4gEtL+LbdPF+S87KCYtr6R3ICs9EKzeWYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792716266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jfhyo87AY7L5DeyPwopI2784pYBnvPIRPDiBBG8hjuE=;
	b=t2ObZDxjezBwFuUji23WlqeB5704st/qUML6P0wiakhe4caGcIZyYmjsA9bzajTKa26A
	 Kq+upyECkDxawfehY/bnk159PpbhU1qdnraLsMwxph3GFM1lFLCEnfkRNiGtGj+aWprrl
	 ReelYUeT8IIp++rCbzOqNM66ryZBh3jYkENREZuJmzgGzWKBNlDU//dWtSFV/GlMTrhrA
	 22E1y64ZxmSCddMyz2bLzZ6V1pUvk0J7gnn7bfO8fCgVFMzPO38cdx6r9bTff+nh88igG
	 IZ3Ow7kKYr/7k0AGC6Q1lImi6xcE0WZKZkVmdFN7QFV65WMmgHDkdeYyadB0nHMuNWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="bBvJBLv/";
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1AD606A319
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 00:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B1AD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=bBvJBLv/
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-9178aabd30dso4129316d6.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792716265; x=1793321065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jfhyo87AY7L5DeyPwopI2784pYBnvPIRPDiBBG8hjuE=;
        b=bBvJBLv/e+ahVwqWQ2kIUSUi5CG5hRc1cP2R7M598nhfmTjUBmro9sBK6TYZo2F4MU
         sJsnGjLPFQhpEaySiDfN5eRNhM576S4BD8RLT9mnN6JzohW9rOpxC0w429g5328xd2wS
         52XIs2o8HoL5I2rKlfOmmn4yuEiDqMTs4LVq+pqyo9surZ1uMtJEt08EK5Mi6j7nUeH4
         8pG6tPaii5fBq0LI/KMye8kw7mOsSXD5GPdLLhgcdlnxydIq4138UMgKIvd0VoQPuajU
         uLeEbmwOYaMo+7bZZ8MWNcZX/pxX+TDf3NMIlhu0Q5TdxDczO+TaCbQfNDZ+UIJuCbJ1
         YvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792716265; x=1793321065;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jfhyo87AY7L5DeyPwopI2784pYBnvPIRPDiBBG8hjuE=;
        b=ZsLB75nEBO64fUv8/YSVzfAEiFKtgKuGTwRAUyFdUYVqsda618jz3BAxL3kQ15TmHb
         nAaVlhJ5clgrRWw9l1Scr3fZXZuM17y+lH+LScS9Byc7cpo7Ga0oJh/NDAPusLzaswd6
         hV5u54Z74TMCjHaRbHRt1CeMxp2aC3ycmMIfFOVNGKAQvDOtdk0OvoanaMH4GV930sxn
         o3Gp21jLjLjHIxsCKQImKozJ69uWqHjmMuc6gCiHkdvSNeiWQ3r78cNgqcCtuMw1cYRe
         kgd5hnbb6BlB3Y07MyeYY6mqDnwruk/N8XDe1Q+piX/yuq8k86CDoXSgiHEx8w3jdk56
         yrYw==
X-Forwarded-Encrypted: i=1; AKwUvBxEFh4AT0TynJJzQGX4UyuKVS2ExuyKSo6duzeSyKdYBVOEdFrAbhU3Irbv7s+Rg7M6xyW9U1c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeJL+NOHOpTl59DnRBtToyNS09Hf5veL0qN0w2AP/y+g1ikfSi
	ZzGFmFFEYBCIPO3BgZGGuE132z3M0nnZ9v5HFANS7G4WOM8DXP7/d8I8/31fUU2jlHo=
X-Gm-Gg: AYBFou1sCC9K70ylmvcaSsW5GxsPY3B9kRm6nQASsT5QXHANWcdaKllLMWBf64PN7Tv
	wQ4AcHS6rSjB3jRX4uJgoD84x4Wxoq/4FKVVy/UEEpPlslQJsoJCoF79Oblue8dsVNnolpyguRn
	AOcliJKBip3ZH29rPUxR6gQv4mIbv4YVM8v88DmqEXiq8zBcsC8Wqk2xauj6uYtovc+3D66ongc
	Ag3oHSbKD7n3eaGgRk2l1TA9ZCykpiAI8DqsofMAvs0pX28N84R/mISW4hI9qlp0AAhECMTkhli
	4i3dngAQIZ/uWw6Jj5vXxsUyulNw7/tgcmHLCphzLnNVDD+P/HwHFDwCQU//W1AMZok6Ppoiiad
	z7KJucWDQA4uR9OCcQzMbwVhsvl1o2W6d1vFKUBAw04+rYemTEDTfuo0QXnL4gH/PlctSgXVMlz
	j2wokaUPEwGbcFMx3rkdF1GrXA8sUGWcHPt4MVYSx6AiXuOLA4M4JN4zPU2+4SiwldXHpALhrPx
	pjwSXhzlyNw5jQUXHvOcNjFrkmGC7xVvOObungxDRYp2ZUAhMSkufqGixLeF+TMIkSMfa5FhhEP
	jyqYqmzrpqlDwmJkTg==
X-Received: by 2002:a05:620a:6188:b0:93e:a8c5:132f with SMTP id af79cd13be357-93f6f788f5cmr211153385a.29.1792716265323;
        Thu, 22 Oct 2026 17:44:25 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f70e81a80sm54979785a.1.2026.10.22.17.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:44:24 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 Mina Almasry <almasrymina@google.com>,
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org,
 xen-devel@lists.xenproject.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v2 11/15] net: skbuff: refuse to segment a nested frag_list
Date: Thu, 22 Oct 2026 19:58:29 +0000
Message-ID: <179269910950894.2.12425346173477603662@toxicpanda.com>
In-Reply-To: <willemdebruijn.kernel.11bad1f39601b@gmail.com>
References: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
 <20261021-b4-skbuff-bug-on-followups-v2-11-2aa780a03524@toxicpanda.com>
 <willemdebruijn.kernel.11bad1f39601b@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, Oct 21, 2026 at 09:47:15PM -0400, Willem de Bruijn wrote:
> This patch became quite a bit more complex because of my request.
> More than I anticipated.
>
> Are you sure this first block is needed?

No, it isn't.  I took it out and ran three KUnit cases with a nested
frag_list under GSO_BY_FRAGS: a linear first member with the nested
bytes counted in its len, the same without them counted, and a paged
first member.  They all still get -EINVAL, from the check in the clone
branch or the one in the frag walk.

> this test for list_skb != NULL is new. Previously this code already
> tested skb_headlen(list_skb) without it. Likely not needed for
> anything new in this patch?

Same answer, the cases above pass without it too.  With every member
checked as it's taken, list_skb can only run out if head_skb->len is
wrong for some other reason, which isn't what this patch is about.

So done this way the patch comes down to the check you suggested in the
frag walk, plus skb_has_frag_list(list_skb) added to the existing
headlen check in the clone branch.  The second one is needed: with only
the frag walk check, the frag_list_nested KUnit case still hits a NULL
pointer dereference in skb_segment(), because the linear member is
cloned, list_skb becomes NULL, and the next pass reads its headlen.

The other option is to go back to the single walk up front from v1.
It's an extra pass over the frag_list, but it's one check in one place.
The difference in behaviour is without SG: there a nested frag_list
whose member doesn't match gso_size goes through the copy path, which
recurses, and a KUnit case for that gets correctly sized segments
today.  The in-walk checks leave that alone and the up front walk would
refuse it.  Nothing in the tree builds a nested frag_list either way.

I lean towards the walk up front for v3 because it's simpler to read.
Would you be ok with that, or do you prefer the two in-walk checks?

net-next is closed, so I'll resend the whole series once it reopens.

Thanks,
Josef
