Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792763562;
	b=1sG7fYqpPi6P2w6/U9KU6oJiZWYHPRlG7hGjx/6o/IrY0/I88S+VuT2aw2FoNbmva74c
	 RZKfXLMWK2HgK39L+PZ8gxP2svfRYQb3CCeoZXqxaW7X+V239/sEulNpslIGd+9UHZe8g
	 8XuzxA4ku2YohYrrmOgm2s2GIGCYelk5N1KK0ITKrQQQDgCTIKII+T4x3dCYOe5VKYuo1
	 MDurQud6R51ZAhU0Ul34+Wbpx7lNxmtZotYxXt/58EeS6IUjZGL5WsckcXNOqY/gxLWs1
	 B+bKnZ7vTcmpo+A2OLpTGc+HSWhvtsKhJtMpJWChvcL/ljSwrw4GUNqs67q3IPRn5AA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7xX2gKagSUBvZ+dsAi1NUa1T9ybCAiN1NSx6inwuTp4=;
	b=QTssfDTG/J6lj1ofdiAa3uCQEI+1cC1NFBCyRHpTHzZQqxOGZnMow1CLciOsdJyDU0qT
	 F+Rq9BqWFkwHy9pJQeNOWVOk0Al/Bpwbjvs5VyoQF2vqEenEAjFaCgbyU4xwLspc+4Foc
	 CjBioFSDP9hM8E12P62n9lorrntsFPscqcpfNYBsbkwVp6kkDp9Tay9gAxgsMgMFkEpG2
	 k+EN+kJ1v4luMOAaSNuY0fq3OznTRpBHI3UKQlXOl3xdyWB7w5/eCIhzBxvx810JpotRW
	 Qb7C2tjD3NrgQpYJCQwHHtm0Kgj20vH+xq518jWYsvJUaTQiNzaSKjw0Drtxwje11Wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LfMYFW09;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87030606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87030606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LfMYFW09
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-194d0c31715so11267c88.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 06:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792763561; cv=none;
        d=google.com; s=arc-20260327;
        b=EXABY2GiLvgQGAYV9TLIVT5boG6eiRYWwWw6SjYkQwWVDcJ9oDkP+D8tCx+LSHiYRM
         OjMOL3XsQFK6S71Ahv3V533CI6FG9uXhd4q+JCcyfeRmXEZBAGDpM/l5duea1O3KAaZd
         h6hGpO6MfiBJ+bUcFFU20YKawwmCWjk9BlkKP8LAt6qZ2t4l3yH273Vv3Q3U5oWyILi1
         upC3O3bDwCJeJQhrmwqA0bZkE6Ubw7jzrVOlj5OOwOvqQW1ZLD52fFYzOFIHaxVZIcGd
         AXkoMf0T2Gy+HE9cvc6INCAuXYZgUEIyxrAGhsmhiPTw0+BZHJBKuEV1qv4GrdmmpFAi
         Rpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7xX2gKagSUBvZ+dsAi1NUa1T9ybCAiN1NSx6inwuTp4=;
        fh=naNMH2EC/qDX8Jdqo9bRcDzz2inCC1WiGDaMWQ8pcJQ=;
        b=m670p4Iudp/kJtiwU3kNmvtMvpBVAwICo7f6QghuMC5iT4TSYDB2B7H74+dezNvNqK
         7NcUs3sQdmHVfazCsW+1GH873ojUVLzrXJEq7YJRU+xpttTWQLm4dfKV9fFw1+vx+HVA
         9P9KLJ3R+BjQHDkSwfh5hYl+7obcNGyM5m+uAVg58VI5ybFf8ldUSTrF8hKhfpP2zd0h
         Y06npxqJz42z/Y6qIgRWfNv08NcUqyxTe2dzKVy6fDwwGzdkPIrrfqb73ULPlPTvfA57
         3JVrzB9sV4r/vJXrczDKtq0tG78zAZVFI8wX1ZCZQCLu3wPXsx2wWoLoaeJzmT5Mbee+
         zPKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792763561; x=1793368361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7xX2gKagSUBvZ+dsAi1NUa1T9ybCAiN1NSx6inwuTp4=;
        b=LfMYFW09luOm7OeIOEGm3qow8ir86Elri9HfvcXK8mz9kwmzlFFdhtoxVKRitH3wAw
         kXl4aG812i/5cTrXWND3b4yeeIdLLaQqtsQQQ0EttOC025FKQKZd8yn9nlNP0HRUu/8X
         2ckGxVXebJ9s/vDQVxec7HxFV7dUcmzaXSoOVevp6ibEcRT8Ld7k/6EH1BZ1syW4ufjL
         ySwiG61cAw7cMf2vplOVKPukn/7gjXJPloqForrrgN/8VGVUXNjGCmJInelZSfiT31w9
         Xe5FDFM/d4jaMR2L0O+uoFzWJS5M8fRzuezuTCCMbt0iCxX2rLH1EqWrO0fik6Wmji+M
         xU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792763561; x=1793368361;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xX2gKagSUBvZ+dsAi1NUa1T9ybCAiN1NSx6inwuTp4=;
        b=ghH9HNTCa3WVceivF0OQqbJUpreOUjjFtYFBS3eQx7oY9XIcgFP7i9wTJbRreK3ac+
         xaUuOwCnVkSq7s5PQBCWuadoDU3EhRCiU8ZHQdYY9zkA3WtGgzE0DDXGa2+0lKophKpB
         QXjwjxshDD+OYH5ZSnipgKvHU8wT+URWqkhM0VDfI3fq7nW3jfuq7Z9vczNsy2lBrn59
         b/B0Amsko9iBQ2UIxsdYubAIPfbDZl1IGIdnR2moh9A6TsFeCCVnSR4n9/EBhU3eW/8J
         8cU3szLSXi9kWmZmo+Iri6w+5OOXB6h/N++N3IvIiHEZkrLX8Mn2JuHbC5WbYgew8zHc
         kjfQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1BaWE3hkTiiAiob1G/mtQasYSJ6PD86kbODVvlaQh/CiMiALZxZJqC9Bc58p/WLOJijSiAx0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGNocdIk5QE8cKYTNFkwCwIoma4IgEw+mvo9ypHWf1l9eUjIVo
	rYjWDF9dclzhD2/TSD5JGP/yCVKkC+4WFMt6mBe6tuXNESF4he8ucEnfWzNe2vmrakDZHN1YOE0
	CoZVbAcYweC79UUroy2W53289fAqVH6/KVJoTyjHE
X-Gm-Gg: AYBFou2m4MtMbLH2QGKs3PJnWOkB5ECsfg3Ingm4YMlU7VF6zm7VhcCjXloPQTCFDGB
	xZkhSTq7uk2sgu2Qt2G8OJAOfPGZ/TaUdD65DVEmcg8IMC6kfHN+++7fDVK+xTM5iJ5DBSx+BFz
	T4XoFDkPgd7jzkFJVBeu7Pe1dtmyVeM0POkdWpxNIAdFuyLRe/g4v/CytsO3EIhFq9ToIPu0V8d
	qmQgKmj8tAKB/ddZ56IEBWPeRNIOPJjhDNDofyu+65fSqjO+I6GjbQdU/5WKmCaQIuzpD/0njGs
	Q1WediSb2P/jPsg0/MfZUUFD62PyGTEwNebf5Bhg0yUAaCbCeUWdej+qbyHjlvoPDa8V3ZzI5g0
	Wm52kIoisKBHrIgMoAzXXVCq/AZXxfW1E74/tN+J6eXLXR0oln08ZvC03XFs=
X-Received: by 2002:a05:701b:4286:20b0:139:90c3:391b with SMTP id
 a92af1059eb24-195aab5d822mr340982c88.1.1792763560566; Fri, 23 Oct 2026
 06:52:40 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019210604.2433620-1-lrizzo@google.com> <20261019210604.2433620-2-lrizzo@google.com>
 <90e0df20-126a-4429-83a7-77f95234cdd1@intel.com>
In-Reply-To: <90e0df20-126a-4429-83a7-77f95234cdd1@intel.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 23 Oct 2026 15:52:03 +0200
X-Gm-Features: AclHuK8IMAai5WBO8HJ4NB1eQHErdtx-3lINsiz265g3x7G0go6ka2kn-9-9jcE
Message-ID: <CAMOZA0+pLt6rsoc1RRO3-TB7SNSUVbEAnMOitDrqygciVvUu+Q@mail.gmail.com>
Subject: Re: [PATCH iwl-next v2 1/2] libeth: add libeth_rx_alloc_gfp() to
 specify allocation flags
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Brian Vazquez <brianvv@google.com>, Joshua Hay <joshua.a.hay@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 3:35=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Luigi Rizzo <lrizzo@google.com>
> Date: Mon, 19 Oct 2026 21:06:03 +0000
>
> > libeth_rx_alloc() calls page_pool_dev_alloc_netmem(), which always
> > allocates with GFP_ATOMIC | __GFP_NOWARN. Drivers also use it to fill
> > their Rx rings at open or on queue reconfiguration, which runs in
> > process context before the queues' NAPI is enabled. There, the caller
> > may sleep and GFP_ATOMIC is needlessly restrictive: it can neither
> > reclaim nor compact, while the initial fill can allocate tens of
> > thousands of buffers across all queues.
> >
> > Add libeth_rx_alloc_gfp(), which takes a gfp_t parameter and passes
> > gfp | __GFP_NOWARN to page_pool_alloc_netmem(), and make
> > libeth_rx_alloc() its GFP_ATOMIC wrapper.
>
> If you'd really like to go ahead (I'm still not really convinced, even

To be clear, GFP_ATOMIC is not a problem right now, but it becomes
a problem if we try to back the buffers with 2MB pages as in DMA_PMD,
and those 2MB pages may not be available without sleeping.

> with "O(100k)" which is not that realistic),

On a large system, which is definitely the target for a 200G NIC that uses =
idpf,
we can easily get there and above.
The system I am testing now uses 4096 slots per queue, 32 queues,
meaning 128K entries at initialization. Under load, the pool has grown
to 197K entries.

Ok for the style changes, will resend an updated version

cheers
luigi
