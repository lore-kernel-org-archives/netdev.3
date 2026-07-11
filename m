Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3DF2773DE
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783781299; cv=pass; b=HSK3xVkLAANDMup28pBQ6safUxm7ueOM5nSrrTeqpu2Crb2HK5GJFv/0Jl2dj+ylnR7cNCU9/Wt9mXJ/FWNC/+1YbQSeAAkbDan+B4ber52OdNX9zWFdmMrO6XwO/cLGxPFM96dQZSK/DIdyIpahm8XITttlP9OmYRAUhSykxzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783781299; c=relaxed/simple;
	bh=VxZ9pQIdVZFEcjEUjOj8fgbegIGQ668FDg9L9964ljw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vx9xq9XGjiKDoHtd24kb+nBfvLPiOLx0/WyxBvAOo8BTw8UCDhtdamzn54zF7KlibXYNtJgT1JKpXDMYNRHnL2CS8y43tMiz5Mzp7LsOO9OfzLcukA8qz2f5l3AJR47nlde2CKCq9VQFVUXJ4NOGzYt0jehKYjip9wXcGuR+WPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTOJxGtB; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTOJxGtB"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e6128bd9b3so995295a34.1
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 07:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783781297; cv=none;
        d=google.com; s=arc-20260327;
        b=CDsy/78r7e1YY7RLKqX7wSy0UjkUysKZnetQOhliQu620qI2ovFpycyYYute3ujEWP
         ac7U6ZlNhZJJsRV/a1BHfMUuM+68plrK6R1kgkpdqn8UOhWMq5hUZPzxTy26yuIeR0hh
         G4OTAcsua6x4cFY+kQEdpT1SBIYJ7IU93zncYftnadbvIqLjMPK+HGRYqMVq9d9sJL++
         reK0g2017xEOlcH4PQCk/3FDR6dSDndh9gq1TeaAD11cIlbdkLNQmkpnGrnYZ5OoR7Uf
         kZVcVKSl13sdTPG0sLr/qFGBuItgyCjHFeNBh56eGDx73/VMUOauPjYReZgI1c0VcmTM
         rlSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NXOfAJdA6dAABLwMAmKO4eZ3zb/qix0+yYcwFmKQ9pM=;
        fh=7c4kAgKq5uCnyjSgs+4DaBjNYqKnwW7vEX/1WcMCGqM=;
        b=TIh0lt8kcDfpLbisml6YpYW+0zUCQ9OjQFJON/+1ROYoX3jQosMIdIfiMSm4cIQzt4
         NRsi5FI5o1g03ffif70tDIbCM7PQPTTSp6aK6G2EbCXLCWMvSlhWEbJY8vDAUpr/st6t
         DBpB9ZoGhYEkDPxMmIha8nAsBnYOitB6cPZ7Io1VIoF8GXCA26ZgNoEyfsMCbU0TkRlm
         5Kw+fefsPTNZZb9th9qHYO9yWqijRNNlNal0Mu/1TOORKTSgOhi02xI8rBVolmHueYfN
         /WiIRTenP6IdrMS16VgDhXX1p2fheQGjl1gzUEaw3BEnPpv338DIF61S5Me1Wd7sOe+h
         b1ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783781297; x=1784386097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NXOfAJdA6dAABLwMAmKO4eZ3zb/qix0+yYcwFmKQ9pM=;
        b=TTOJxGtBAZlF+fgw47fLFseIbFoNVnNaM1/xkSXZWwbtYVwcN2kJFD/rTyJi3kAQeA
         KuAwUfuzhpbUFRK+yIXuxx8uLiIbcfhFH8m5iYmWOW+ZWTpcCrzafkRQKauJeLZIpK0+
         m48pR0b5if0R48JPi6s+JW9zuGF4U2RjOAq35ba2VV9HCsadG9dotlXX138E3q0RHxpo
         21wk8y/cG69JKwjIqsMuG8URbQnrQe1nnecRBKLA7TMQZ3XXKXJK1WmnT9mE+C12dIb1
         mC+5gsv3KutuQqVD25zn1GLTix52lwQWnlcSo+4Bjd7vXGqXM7bBmWp0mjyb/ewkOc5D
         bbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783781297; x=1784386097;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NXOfAJdA6dAABLwMAmKO4eZ3zb/qix0+yYcwFmKQ9pM=;
        b=PwdOr56d2RF4/3QI9jscdh4EuS0G/dm6xPhsd5YCmA0e9bPk5Dnkd5PqjLXqM1KiZi
         x7yF5V4Yc3AB2oC773nB1/Xerts87bjVDb1M3eAv8uiaxrA6qI+cQch7S6IBuSL/um1S
         MN3BugOIJcrR1Jyc8MIv7iDpNKDOWXEKeaTkLd6MeOX6XYYINS7OuZsRHFskocU8aWNc
         aqfUNP30DuqK+K8K/NIE4EosedU0XdLAkR3zXfsjyZ6BUXK/oZRtl9uUvYOc4oOWw7aW
         ccTwoaghIOvUfz2+laBp6eaKg6xgPc+MKdWPY01B4Gd5ffwNPrrmWmFprpKNVu4ABPcX
         crpg==
X-Forwarded-Encrypted: i=1; AFNElJ9XvE82TO6FHUC/3XysxZtmTkfH98LP3a07Bf6zd43pCWllrifT1DjckSgH8jYAk4ILfyix0LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Ib+RqQJiHlXoslKcXIlk8dfdn4vDDTSKu/95YIdE/qqNG2E1
	NkCpxDzsfZ06paeUtkCXA0KxUtBJ8vPrmWtPh1NUlxtAee3PDjDn4Bkpp0/DVTGPQEBOk0b3pP7
	pwr/7cXGXt479rKLzU9Byiq9CoNuZ/7s=
X-Gm-Gg: AfdE7ckVLJ+VjGX4CM+ReCOAPBRU4xGVYoSHqBqTsT0IpWoH6ABHWMh5HV9zJvxqMHm
	LlwbVJpxd0wrudH7V7qowrQLO3TTepfHR6SB9MJB2zJpPu0xrSvhOgx01AE2SDUPtYwAXbt/m1e
	NXgOiVjIDXXR0xtQc1p7RA2ebiM7w+RfQ+5fE4gjR22bij9zzo/f+Ld2gnNOyy4NOK3gsnAwxbv
	V0vjUi6H4mGKcdTPI05AWO+rDs1MZI3qPLnMh0+pl0s5891146CRlSeqS1LeoDyYGwnAWMEdg==
X-Received: by 2002:a05:6808:2507:b0:4a4:d2b:8e7a with SMTP id
 5614622812f47-4a42af3bfbcmr2013409b6e.35.1783781297127; Sat, 11 Jul 2026
 07:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707193243.3448201-1-michael.bommarito@gmail.com>
In-Reply-To: <20260707193243.3448201-1-michael.bommarito@gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 11 Jul 2026 23:48:05 +0900
X-Gm-Features: AUfX_mz1kJT7VLTslFlvwVfcq18p8JTgGyLPLjMg-ZLwVzYiBPTnbLwT5nZoBto
Message-ID: <CAMArcTUnwZQEb=-7Gn5+ELY_nFKGPn-yCq3BnzOM7p+Rsu7h4w@mail.gmail.com>
Subject: Re: [PATCH net v4 0/2] amt: fix use-after-free of the skb head across pulls
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 4:32=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> Several AMT receive and transmit paths cache a pointer into the skb head
> and then call a helper that can reallocate that head before the cached
> pointer is used again, so the later access reads or writes freed memory.
>
> v3 addressed only the source-address reads in a subset of the handlers
> and described amt_membership_query_handler() and
> amt_multicast_data_handler() as unaffected.  As the review pointed out,
> that was incomplete: those handlers keep stale eth_hdr() and AMT-header
> pointers across later pulls, the record loops in the IGMPv3 and MLDv2
> report handlers read the record count and the group record across the
> *_mc_may_pull() calls, and amt_update_handler() and amt_dev_xmit() read
> the destination address after further pulls.
>
> Patch 1 walks every AMT path and, for each pointer used after a
> reallocating call, either snapshots the value before the first pull or
> re-derives the pointer after the last one.  This uses the re-derive
> approach rather than the per-value snapshot of v3, because the write
> sites cannot be expressed as a snapshot and re-derivation is already the
> idiom used elsewhere in the file.
>
> Patch 2 is a smaller, separable hardening change: the three handlers
> that rewrite the ethernet header do so in place without making the head
> private, which corrupts a cloned skb (for example one held by a packet
> tap).  It adds skb_cow_head() before the rewrite, split out so the
> use-after-free fix is not held up by discussion of the clone case.
>
> Both patches build cleanly (x86_64, CONFIG_AMT=3Dm, W=3D1) and are
> checkpatch --strict clean.
>
> Changes since v3:
>  - Rework from the per-value source-address snapshot to re-deriving the
>    header pointers after the last reallocating pull, and cover every
>    affected handler (amt_dev_xmit, amt_multicast_data_handler,
>    amt_membership_query_handler, the IGMPv3 and MLDv2 record loops, and
>    the remaining reads in amt_update_handler), not just the
>    source-address reads.
>  - Correct the v3 commit-message claim that the query and multicast-data
>    handlers were unaffected.
>  - Add patch 2 (skb_cow_head() before the L2 rewrite).
>  - Drop the v2 Acked-by from Taehee Yoo: this series is materially larger
>    than what was acked.
>
> v3: https://lore.kernel.org/all/20260626111917.802243-1-michael.bommarito=
@gmail.com/
> v2: https://lore.kernel.org/all/20260617123443.3586930-1-michael.bommarit=
o@gmail.com/
>

Hi Michael,

Thanks a lot for this work!

Sashiko flagged one more issue, please take a look:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260707193243.3448201-=
1-michael.bommarito%40gmail.com

Also, please remove the unnecessary comments in the patch.
AI-generated code tends to include too many comments.

One more thing: please follow the reverse Christmas tree order
(longest to shortest) for local variable declarations.

Thanks,
Taehee

> Michael Bommarito (2):
>   amt: re-read skb header pointers after every pull
>   amt: make the head writable before rewriting the L2 header
>
>  drivers/net/amt.c | 117 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 96 insertions(+), 21 deletions(-)
>
>
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
> --
> 2.53.0
>
