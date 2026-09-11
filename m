Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2330BF70
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 01:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089426; cv=pass; b=W6LoZQXSM5nas3wOtwx3o4QjEO3nlSqhI8RE5rTqGl0+wiKAGRFOODfhxNV8jayB0Tv4M1kXXAjDpJXasLq6Hb7wCe6JNyfW0GZgc9OhBdVpF1HbNotA8qW1p8rss8+Q2+3OV9hBYg5Mryu5kjWC5vuNBI2WS9FqROPE/grxfGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089426; c=relaxed/simple;
	bh=5q+iL/R4cDrY1TpT6uISBmPsAgAumboJPqFJbP2vER4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ce6FiHIMUtY0gXCw5gTsDJSaQ62GDXsly7MklxgsyNuTEIYu3nJhLycfAS4D32Nlneca6S0uR7HPeihsXbZSHlyTXhrJ0b1qpyCKgTVwn4EFUYxqrXnObymjuvrEoBAIm5c/tCYVHMe2Rjy+CiljW4VH5kEyaY8+/k5AYGySqfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HijGppF3; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HijGppF3"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5309d6188e1so5474241cf.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 18:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789089424; cv=none;
        d=google.com; s=arc-20260327;
        b=oRa5OU+24Z6pul1izV1kMPlsxWkhWqH3PCom33EikSGWDC2eliVetYVHx42ENrOU9G
         wGlGUEewvFpByGSctoruwbWNEiVamZYQ2L86aia1UamG+/IS0VWrMfV+2Xxf5nU7rRkX
         6Cz7fNYFqhyRQN6ktYpsJQLWru7hiGNuImnbIKCuG6Jfu891tydC8v/qce6ik29nPltU
         CrOreBhrIDG2PoNRI4yXq9nnS6VwuNn/C3LzEGG3BoF12521DgKLMrNGtNHV667KkzgP
         LUEGBvwXcCJWEy7BqRMwgQ455mZbF4z2GU0mHEhdlOn0fPibuEqu5okh+zW/weKAiDlf
         C04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d5p9NQgPpyH0j9JiAgxiWq3LurVs8yYrQVoiE1QcZUw=;
        fh=u+gWUuOw58g9C8yNn2SwCHCtJK0iAyGbz7OpzrxslvI=;
        b=q2oHvjUbc1Sc75UeiRgIp2ZIHTLzHvcMUIURP12q3IUQ/MgEBJ8p+wWQ3QQi29rkLN
         6g1YIV6TFl5EX5DQyyjeOef3mAgGoKkrddumuQZYdsgy1vyXiHEuIsBnxlAC2dWWXO66
         Endee5QrGgLBwuEcnx0N2bnTVsz3SBqxGFCwPQGfVeAIq0JURQYIjrxweeL9yOq3VZjz
         9ap/3eAowe0I1RP+CrNoQsy08/66mdl629ji+gUj5fZ5SeJZd5sNEvBFpmCiebJpeqGs
         BLrf6jIEjphWJ8v70Age0hTnEL16XiweAooemPal4NqTfzkJrLL9pdYAQQztH1hf5heM
         xteQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789089424; x=1789694224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d5p9NQgPpyH0j9JiAgxiWq3LurVs8yYrQVoiE1QcZUw=;
        b=HijGppF3YqI7mjQm+WRnchhbkLIGAn7xuY3LCkZo8iMrhJ1aQ4elSuEjtahnX4xhaZ
         1o4PGE3JPPQNog2RSzhnr0ZeP+TeGRBy0b8igJr+EByUjDl1S5u5jMiNK/07KSEAYWJ0
         A3W+cGhtl42Z54+D0OEYIvUPwO5VGMTWxyDkC4JasInYOJPE8gJy1TyFw+z8KWkBc2Xr
         gmfEWAG4rDDUKOCGHafU8aql42Fqx+lZ6w50GGKHOD285WXr/mOVPJ0XKWG2AHhSHoXv
         2id6kA0htS1/G1IfTxmv2m3LlCDlhSHd9eeRfJq2YzbXV2TRPYvaGE4MJyZaPMChHPsL
         OWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789089424; x=1789694224;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d5p9NQgPpyH0j9JiAgxiWq3LurVs8yYrQVoiE1QcZUw=;
        b=OZJykKf2yo6KhbtDN8TU9fk4BX9ZPhKGq4ghghtN3CgBXVfvIrtU7O+FJrPREjJ1y1
         61InjA72PlgrX5E5q+wTVI1TPxpW8HQENfVAF1q4CgElxC0kXVY8Wot7+iNr8Jf3AJzk
         twynsM7qxWkXYrbCL/2vrU1suwKSxvjkeoK7b/LwLOIj/M7osM1H9BXE+9FPVWlOB1CF
         iLEKq7ztf40CoRtPo6xi1OHsVVWUvdDoTADcxBAJKN2gdA0g78M/ekYCXa4biru2K6ui
         tZm9ku0TcuUVd16Vprn9pO+1XxH7ulO1tGc2AWeSDIS8sXjS3OuqmNUB5sHWX196f4SA
         rE0g==
X-Forwarded-Encrypted: i=1; AKwUvBwgCQZbEW6ZAHJ1CXZcEXMQKjjjhTpVQkWu38MJqtRzZVQhOb0bGMN/0fADe20uTT+hhuYo6Hs=@vger.kernel.org
X-Gm-Message-State: AFuF++nXoaIp2hJ79TGsfdMGnw/DxbcZ9HaV/ziEmyfdfBLDJDcAOyPv
	UKxYJvA8g0pr9l3jSAXBSH5vFYwkbiuaDFWAWL69sUmdwXPDnCVSvcgqTbw0NOCfePKibfBxYM9
	zIga9srfFsWBqZHo1RMlnjf8zDNSXBvAZo8EugFjd
X-Gm-Gg: AYBFou0+2JomDe/5Q/1bOPFflkR3ksAJQiDNjxngyW34q0bWfzu8mC01lr0OoD80YON
	x/R6zw3ChVeT8M3D3IcEqI9MkPzer2uYODK1rcp24/GvJLaSA1fyurWBsLr0MmrKVbsaIwEq9Kk
	0PPF9IKDc2XRqanQ+S8QETdnzdGlN/Igf1OnzmZMThl8c1GgJOd4zbTES016aN/2HQeVZaoWDMZ
	ZwXxhaBHG8wA8queYFj+5GMEI5luP9gGaLDYtf0U4wOTzLwTPnCZE4I2panxEXEJt8P9b4RcvYz
	rDu0gWwlAD29PP7XYESBcfDi/c49vVMc0r5xyR3B7gbrfgReRDzJTgV0bbwWAvfU92QKVmROXJY
	YB78MKzgAg3/HMy0SKArEmq15ARgX3iTdFXoSdxx5RhK+XOwiP9tMtEegC3zD026O0EBjc/3ZSi
	iYagsijMLcaxkA643F7vwteNfg5BGeWg==
X-Received: by 2002:ac8:6f11:0:b0:52f:64c4:8094 with SMTP id
 d75a77b69052e-530c87226a9mr49908141cf.39.1789089423282; Thu, 10 Sep 2026
 18:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+0ovCgMrVBnn+0d198i0th0bcr0EAwNZ=0juh1ug8DdJX5mPw@mail.gmail.com>
In-Reply-To: <CA+0ovCgMrVBnn+0d198i0th0bcr0EAwNZ=0juh1ug8DdJX5mPw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Sep 2026 18:16:52 -0700
X-Gm-Features: AcwNN1VGil1vFMyCvGxTO0Uen3SBrfMM4J1yekoBWYuH_50vYwcqY9LxSE-7cx4
Message-ID: <CANn89iJg-10Xy_N_h3Et3wTasS_7RMkwxsz3XKmzYc7mLhKa-Q@mail.gmail.com>
Subject: Re: [PATCH] 6lowpan: do not compress headers that are not fully present
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, falemi@asu.edu, 
	Simon Horman <horms@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 1:31=E2=80=AFPM Farhad Alemi <farhad.alemi@berkeley=
.edu> wrote:
>
> lowpan_header_compress() pays for the IPHC header it pushes by first
> calling skb_pull(skb, sizeof(struct ipv6hdr)), but that pull is a no-op
> when skb->len is shorter than an IPv6 header, so the unpaid skb_push() ca=
n
> drive skb->data below skb->head and into skb_under_panic().
> lowpan_nhc_check_compression() has the same missing length check,
> committing to the next-header compression path without requiring the
> nhc->nexthdrlen transport bytes that nhc->compress() reads and
> lowpan_nhc_do_compression() then pulls.  Return -EINVAL from
> lowpan_header_compress() when pskb_may_pull() cannot produce a full IPv6
> header, and return -ENOENT from lowpan_nhc_check_compression() unless the
> IPv6 header plus nhc->nexthdrlen bytes are present, so that the nexthdr
> falls back to its inline encoding.
>
> Closes: https://lore.kernel.org/all/CA+0ovCjTsygN76s2o=3DTZqPqW8v2gBhmRnz=
+q6G-NaB3Cq-YPqQ@mail.gmail.com/
> Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>

Notes in a semi random order.

1) You forgot to tag the net tree in your patch.

2) You forgot the Fixes: tag

Please look at Documentation/process/maintainer-netdev.rst for more details=
.

3) In net/6lowpan/nhc.c, calling pskb_may_pull() inside
lowpan_nhc_check_compression() can reallocate skb->head (via
pskb_expand_head()).
When this happens, the 'hdr' pointer in lowpan_header_compress()
becomes dangling. lowpan_header_compress() continues to dereference
hdr throughout the rest of the function (hdr->nexthdr, hdr->hop_limit,
hdr->saddr, hdr->daddr), leading to a use-after-free.

4) Callers of lowpan_header_compress() do not check its return value.
In net/bluetooth/6lowpan.c (setup_header()) and
net/ieee802154/6lowpan/tx.c (lowpan_header()), the return code of
lowpan_header_compress() is completely ignored. If it returns -EINVAL,
they proceed to transmit the malformed/uncompressed skb anyway.

5) In net/bluetooth/6lowpan.c:setup_header(), there is already an
out-of-bounds read before lowpan_header_compress() is even called:
hdr =3D ipv6_hdr(skb);
...
memcpy(&ipv6_daddr, &hdr->daddr, sizeof(ipv6_daddr));

If skb->len is less than sizeof(struct ipv6hdr), reading hdr->daddr
is already out of bounds. The driver's transmit path (bt_xmit /
setup_header) needs to validate skb length / pskb_may_pull before
touching the IPv6 header, and must check the return value of
lowpan_header_compress().

Thanks.
