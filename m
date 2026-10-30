Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361721;
	b=3NIB1FyKOSqJ2+1OOxh5YOj4zZrVzD3j87ctjFd+ZA1O/Q63o0s/6lVzScZhjZ/oQoUI
	 7spi0pZqUv1PB7yDrK4cF6ZldDTwc2kJworhLBr52eydIoSdUmP5jwQzDwMfUL0idWvdh
	 pVNwKtTvVA1+YPNVFxF42jlJx0KEc79me4oyfwgkKd1k1yuwU064rHMRdw7Mu5oXWCo9w
	 HBcm2bnz8yBmNPb9nYBxxMFDPiLHyrFJRBGYbGhszFc4TlajzL1Oo8VtxZIl0MdDeZM+Q
	 K2es+Q5rqSEZFl4M8NeOt+9Yb2SIwk73Xv/lsfeATj5xnrxF1mRDfSvw6hlqlaMGMgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=eotohAuTIxTgrdX2GkJnACy0BcJ9VGXmEHUch3gw/Wk=;
	b=F1I/JbGxAmmXmj03PjTJWqJXyv/zbMuRtXyaGMOuVoIKWGS6QW3dknjg9O/uh+L6PHyk
	 gHvBS+7XizINnIoiqHdj+d+w8AtfXTdEpR7+h8QQJt54EAvWrM6mVlSXpYL1UBrqnUAtW
	 znRIjnGu18pk4StEnpcuAJ7TzZuqnaK2PYphZ+mod/ZMurK7Q7F09YorxOxwtsTeZuejD
	 BtwApXuQiKhXEwXHx25HGyLXKEylePhYiNYVrg14zWfZ+BKyjiUu0gsJ6wuvKfw8+FZ+h
	 F1wDflI9pwiK58CiK8nDDqQexLhOVD9B9YGbI4S9OxioCEI5/uXM5WceNO2U+5miVHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=O04swbkT;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9095B606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 12:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9095B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=O04swbkT
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso91652466b.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 05:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793361719; x=1793966519; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eotohAuTIxTgrdX2GkJnACy0BcJ9VGXmEHUch3gw/Wk=;
        b=O04swbkThTGDeGx5khwvzewY4a5ByAgXASfltMMP5FzsS0MCCDUb3yxBTt7MKWJ3+W
         PyQF0ie/ewr5GhK4wX0xU/qCb8XFhR2K+NizO+2iBmY9iWwFX/auSnls223PYVDWsNys
         41xFtMeJHfvYMqLllH87zNsSLX7XKBQ4B1YKNqbTgBuIi45jipf26xjUt9mTmpwfd/ka
         Sfghl8Au1QFM9OkN9Wy/vOEuIcjfD7yGh2AiBqAu+NYMKin7EmwmZ0betImJN9+JEqG2
         ctPGK/5TzYXRj1hxSd2L8udUMZ/fspK5CaZElwCMXXCjptho3ju0b5GFDad3qHrs4s0L
         Uy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361719; x=1793966519;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eotohAuTIxTgrdX2GkJnACy0BcJ9VGXmEHUch3gw/Wk=;
        b=LtPxmCrsqR4o4nobvMtYmQ3pXgGpaYVa+7BaxWsV6vQQp7vtz+9AHTE0LyjIG0LIFW
         Ff+zhiF4ifwcgac7LSna1s+DWR0eDx+TgMHr4MPqFkIe+z/RxxrCtX/HjUdEM0lbFmga
         0YDpInJc+yeCgjQz1GDLupY5euh9cOE7pGZdSdfD3gmTQ54BryjPZRJORQxjPf7dmY0R
         8aZbLSvUbYwIztbaRCH5H5uaRjt7MDLEIP1j5+k12IiXOrRdlcDKVH2ji2t1ca0Ok+ec
         b63PUuVQInkpK28AVk0bjO/tDEoxnkp7rkzRW5rkBRAZXe8L+R5NHrLJLtWi81IV9Yyu
         qxWA==
X-Forwarded-Encrypted: i=1; AKwUvBzixHPmrONp6CqHmli5XEUhtit70CqHlygNVio9pvLOfuGZ+W6mpeqBS6cJ0hG1IEYQ2/cV6+Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDtommu0Q/xs8nOt+joS5Sfj7k4PJihlvP5TfvYcEb48nlb3hz
	XzMB7+ZBxrQW0KKU3P6fm5vna9wq/EBm0+iC4sJL847XVno7gbfBnWHsmc9Dh+bH5R0=
X-Gm-Gg: AYBFou0rc/UJTY/apJJjibVleg7K28M2TdqDycLjW7pD2OVIwfD/shb3kIyp8lBlNmR
	Q/gVcmCqpxGtv+PwPwT2b3XpaBFEXMjTICG4260bFk+U0YOSUEYzpgzFVFHiOe7wCdhyPR4Cw2l
	pV/j+4hY3255O0hp89+uFoHbnw39d6jWZOaMnXSBeELzCqgyRjDvhpiQzwzAWg3QnFa3cxOISUk
	qQ/6HvtgsKWZNdvGlHavqk7vL6uALeulIYqWWYJvk/haa42O0f+z9FUwkOfyl/44AKGJP1ysQ19
	8gfpj+TdFiO8uqiRAZW57UgFlshIknrsHyyK11jyVZJ5QuTxwUTx0wqlYc09onUdBDIFUfuoxDv
	SxIY6oWXKffvdTutN8RaOGDtWgkyjdwtViZgfTBGormCpngyb0WWlO53EGnSJtMqILrUT7j8AfY
	TfEGlVYazP+pbWvJKStSvSbuvRHjU3R08YG8B8fLVz4uWOVdEpUC/dyKi3xlMYBtfgRbdc3sW/R
	kQuW8zYSxScamNAORvSkDj6C5rYlxPQSKdv6z72onS2zV9TEliv/E1IoglfHOIuZXtr4NJgeagm
	1VehbkCTCQiZrIicrzmNJDptXhbOWg05TYIPoQ==
X-Received: by 2002:a17:906:9f92:b0:c29:4915:83cb with SMTP id a640c23a62f3a-c4ca7ab09dbmr187592466b.39.1793361718960;
        Fri, 30 Oct 2026 05:01:58 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:491b:1300:7cff:6795:2d76:e9de])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe0fd97sm58702466b.47.2026.10.30.05.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:01:58 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next 0/2] Fix psock update-side data races on
 sk->sk_prot and progs
Date: Fri, 30 Oct 2026 13:01:52 +0100
Message-Id: <20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADCH5GoC/zWMSwqEMBAFryJvbSBpRwWvIi78dLRdZCRREcS7G
 2dwWVRRJwJ74YAqOeF5lyBfF8GkCfqpdSMrGSKDNBVGZ1p1i1WOj1XZgQzRJ2/L0iDmi2crx29
 V463Q/E3Yupn79Tnhum7LtvLYdgAAAA==
X-Change-ID: 20261030-bpf-next-fd212245a771
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.16.0

Follow up to the thread at [1]. See individual patches for details.

[1] https://lore.kernel.org/bpf/20261022054811.35008-1-phx0fer@gmail.com/

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Jakub Sitnicki (2):
      selftests/bpf: Cover concurrent sockmap update and delete
      bpf, sockmap: Fix psock update-side data races on sk->sk_prot and progs

 net/core/sock_map.c                                | 22 ++++---
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 77 ++++++++++++++++++++++
 2 files changed, 90 insertions(+), 9 deletions(-)

