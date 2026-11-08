Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794126243;
	b=TX/nKTvuD18LtSJDGoWYE5ieSaDQTypzF6gwbPv6BPIgiCo4uuqXJjyZ/gmCE0NSFM4d
	 JzlwglhIqwt7NyH16enajDDVUdCYH7r51XJ1Sot3VbxzylFyXnUlparq1hsUjSSfwn8mF
	 zVjeeSMC+9sfX3I8CT+bnaibCiFphLDPIS+Jmzyyvq00jQnLqbO/CSSHVp133FHdrdZSm
	 OgwYW2trithI1YM0G3rZLatncvxJ/4rGODrVURqJ3WToxH4pGizmIZgokK1AZ4Tk3YW3S
	 OpCWPDYHYrOowLwVtq61TqPPMf6El13c0SSNN2w008m0KFwA0GR4HrkOvjjC3I9WfSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794126243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=qHVWSqA22IRi0IWfM3WN+vs5MdfzayNNwpdec0UidNM=;
	b=n64JvWlrh1x0Pst8sllXumFnZyHqfVvFfA2h3u9tcr+9CLFUiPvhPqTwJn2gaxwvDcZR
	 EvA3aAXwymx3NrlON7niu2WJNYhO/OxIdZuZimOVLQeLXbC/9ObEElo96omRzFGkZAhmB
	 pMOvag/OgiLM1rYggabPRv0R7+XRrF8oTQF0K69+MeNVKcYEAKOi3L7zEAz1ZdD9aljmq
	 RpqikjtB+pBkcvgLHtVJBeqWEK2r2TChg6HHhAvERqSgqLPabBwyCmCiss1FhRjmx1BwV
	 bPJp0CCiF5ppCEagS1JEsRjloabbZouch6Gf6ax4St8CEMEQTqAZkLny/DXBb7qAhJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Pg/txO38";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13680606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 08:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13680606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pg/txO38
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-372bdb942dbso174734eec.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 00:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794126242; x=1794731042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qHVWSqA22IRi0IWfM3WN+vs5MdfzayNNwpdec0UidNM=;
        b=Pg/txO38QDBLU/kPMmr0doFaKJhLaG0yfEYjP5FcS60APBa1d9UfSoGEaxKhDhWGb+
         ZBzTOOtubBCVZ88C2475nlvpkl89C9dYbsVr0xCqzbv5i5RN86X0ld0KCQ/kIajDNym2
         F0IvTqAEx5FDPP9iZr/xBZf2jtcxWyycBhiNAGhfTC89lbaUjwT49mKjqtguLwuiVCO7
         g1x2+wiHuA1e1ObRrE3qyPKbpMCQx3zuOAYeeVfJ5P9HlISecgd+3GfbI0H20uJA3Iuf
         WdGQinPOhtMOqaLDZHfS/FOjRqAWseeAfJ60GNeTIYu8iCDn7VVXqscbU7JTkhWJVeaU
         9KfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794126242; x=1794731042;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qHVWSqA22IRi0IWfM3WN+vs5MdfzayNNwpdec0UidNM=;
        b=CugCUB2vx3n+TBeuPhNwV+hkTOT5iEB86qosU2WrhRYOqwqRRAyTWxd7+GBy9FbTSO
         SO2Eb0UfPT+DGdAijWdGsEIoNXrH3ke1oLe11/Rd7GxMHvcx7Zpv7XQxnP5xHh3q2BzV
         scigL6L0wEmyuLH5JZi1QBpXLMx2fsgwGR5aV6H/5SLfTtcKz4XTbiP2HOpMqVwQmdQ6
         EQ0EM+K3pn90NHwfgvjYF49mlccf9Jr89EaboNuC+0t8adDFS1Yc8JP2XUNgDz2N3zbr
         ihq6WYdTrQAMYrQKjTaRkK3qKr3QBZ0ki1BDubCuvKJESA23xiJ1uLPgvw7Xhit8Hkv0
         90pw==
X-Gm-Message-State: APuU4Z9WpSLZEoscK0/Bkw0SoxqlddaT3mkB4grh11uMU8lmPqw3FUts
	PIzrV1cw1quVm8VI3Nr+YW/SMc/6v8RzFKwsFW9UYsYw7uvPnHvUhmaY
X-Gm-Gg: AYBFou0z3lSIsgLtI8JWxL2hGFGe/i3k3JVFUbeHrECIs0dAE12Kf4N+lX6KiakGIbL
	yLZtUi1vWABAyZBejVqpZu6pHqmALznmNqF3+h+9aXso7TSVAMbeZs8l+KwdKXT4fL+pS2Zi8Sz
	xGPCVam1DWQEK/bKGyBoU2woheVuNiQJ2W+V+12Y6vT+vmoGjevC15e721/WKZMnuMxPwU8IpJt
	24bUaEivDTtGsEZhLisP+uSB/lMO5fLSASSlYmAPSOZA4HvP6kqsldg/dfKeRgeraSPJcOJDwhs
	nbNOr8H8XawmR3bb/ib1qIiXJbbq7mWVl3tOfydiulrIBlBKmKs5i5bnXDYpE4w8aE/uc2DcaEl
	g0npF6RLjBYNKIC88vliSdVrLmx811UbolS/NN/ZXGtZtVMDQZ2RTyOhFvLOUc/omUfWi7q11eb
	SqFYNmOHMiT5gauLWdz/a1RmJNfGX+SChfpTlFux++TkmdA5LxA4eS7Qqh4M0rlJn8t9Z0N3dQw
	1G5DFKwkquP4v7PdRy9KT/tJUr8/PkWlBF9z24uUZfvDF5AyRJKMSQY/wGhOUeg/0tvHsopnkxe
	Guh4c7RHOqZU4144ujGld3mDvNl7
X-Received: by 2002:a05:701b:260d:b0:1a7:99b9:2eb9 with SMTP id a92af1059eb24-1b39feb35dcmr1247987c88.27.1794126242051;
        Sun, 08 Nov 2026 00:24:02 -0800 (PST)
Received: from gmail.com ([2a03:2880:9ff:66::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3731487edsm4577292c88.2.2026.11.08.00.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 00:24:01 -0800 (PST)
Date: Sun, 8 Nov 2026 00:24:00 -0800
From: Narcisa Vasile <narcisav.kernel@gmail.com>
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	willemb@google.com, mst@redhat.com, jasowangio@gmail.com,
	eperezma@redhat.com, willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: add a KUnit test for the
 alloc_skb_with_frags() tail split
Message-ID: <avAxoDhRA/qgo7oM@gmail.com>
References: <20261108100617.23840-1-yanhaishuang@cmss.chinamobile.com>
 <20261108100617.23840-3-yanhaishuang@cmss.chinamobile.com>
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
Content-Disposition: inline
In-Reply-To: <20261108100617.23840-3-yanhaishuang@cmss.chinamobile.com>

On Sun, Nov 08, 2026 at 07:06:17PM +0900, Haishuang Yan wrote:
> Allocate MAX_SKB_FRAGS - 2 full chunks of PAGE_ALLOC_COSTLY_ORDER plus
> a 7 page tail. Rounding the tail down to 4 + 2 + 1 pages would need
> one frag more than MAX_SKB_FRAGS, which made the allocation fail with
> -ENOBUFS before the previous patch.
> 
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
> ---
>  net/core/net_test.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/net/core/net_test.c b/net/core/net_test.c

Thanks, I tried it locally.
Reviewed-by: Narcisa Vasile <narcisav.kernel@gmail.com>
