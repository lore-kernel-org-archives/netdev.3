Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7764E8DEF
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790365900; cv=none; b=pABhMG/fbPhqMqm3ULNlqodf+WqLmCpvSMNNxsjO9Uii9Tg+gsJCmaTQitGR8jCXIBj2DSt2umYJZ5DoYFzrGhsa4+x4YlX28OxjWUpseny9Umqor5EYBog6jLfC7JpfQiKLQ8jYgXLbWngKqpEnl4S38Djf98+MTVQi2d/2uNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790365900; c=relaxed/simple;
	bh=Y6XLez4bx8jf7oVVRkIynG6FSaoMuruJLTjDxk8GpOQ=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=EFHxBiASb6R1Q37B5MzQZK5wdRpi5MfO9z/mUQfG00j53QzvkPjlgIdhwzK7WN0ZSRYKwDGTWr7jLDlOipEldKknPRtTVHZ/oYNxUuNtt+w83XsoGmqHGIoFGthoMqCuCFQXTcU2DFJp776imUfnZGouIlbPpqM5/dqGBXEl3tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qiiwvOi6; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiiwvOi6"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469f20513so710369b3a.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790365898; x=1790970698; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y6XLez4bx8jf7oVVRkIynG6FSaoMuruJLTjDxk8GpOQ=;
        b=qiiwvOi6jzS0NI+LPVGohZWQ6BcYCCmp+UkqYgUZJ2b46W5j1uJJAyQQp79O7q+qlN
         MqaTAcgUVWRAAxINyW/uEXFgMg/Taw8z+C4kdaMiboI1AhBwotmJV0PaelCCLUaySJs+
         c7ya/xUtbI6W+jf3jSpDGdI6rfyGupCelQ4XD4nmlOCQFXcFilKDPBRDbJzF6M8EwYK1
         8zPaR8JDmlxQb3o3UYOUpWYGOED8kZhpFKDm3s96ihTrCKo5wcg0pEoCPJDmoBs0q40F
         p+oQda2rq8HL3FDxXCjQSrmT/A8Kac+qOFF2F9AM+g0WAilWm24myagMQFhnHSo6AgV8
         Snlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790365898; x=1790970698;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y6XLez4bx8jf7oVVRkIynG6FSaoMuruJLTjDxk8GpOQ=;
        b=WioWAOkvmrcm7dTQpDftGMnufAzfQlq77nbQJlmdO5xcIf6CJz4yf6Ex4aRercygpa
         RkriJCQFUgVNqDtkfzZAWnR5dgzfVxZvh/l0/G6KYqjv7l7KQdG5Sz/mbHMnAPFeaIgr
         qDFyvADw3mWZFp5x+Q7hRcKzzNHxquUKfzMkwHDog5znqJIrSJF4O+UKi0xVjlGVc7yV
         9GGX0hbFjUU63Hgrh3epKmtQ4b2/lLXHwWIYh7c8eoT6k+gz47SBsxEQfy6rUd7cp0lD
         lV+JbW20SIbmpxz10W87WcIWLuNNUqrpEOnILO4msbW4DwQ9YO9BoRkrd404R83sB8li
         Q0Jw==
X-Forwarded-Encrypted: i=1; AKwUvBxLkYzsYMpeyil7zystYCfsnJz3li90w+PML67RQo9O+J6X4drjrbBS4N9PwSZKsF1yi0nl5A0=@vger.kernel.org
X-Gm-Message-State: AFuF++may2niEc3x0kcQzcQErxx4T2DpcZvJ1GVOzGEJwwDad+amdinU
	9NVmPDaZDana7ABC/buzvNQPk0eVU3Ixt8hMgiJxW5anDlgNEBPat3cv
X-Gm-Gg: AYBFou2qg7aMJorvqgdcFG/K0mFgHRcMqmPpe/WXQnypswkccgM01BLILHYG1jWbai6
	dNx18rM+RizmGZEG+wYJTD+zAr6Cg0gRGO3L/5zyIZHkczH0O7MkerPzJpM2p6wkBiSdoL5ghCC
	M+UtGmbiXz9oWZQyWPIBhQ/rAU57Plamy/7WAZ7hnTxHl2AOMtDenhRgJTsKj8H8lz4pySsJU2B
	w3joz2qyB2wRQN3aWY8BDzSkJQT4yLbpIxsWGTzBIlPfU53Snz9IoXxBpaLvigw/UnmP6dvMd3A
	+UUhyXXJdh+mQae52+Pq73QZcskZBEloHq5bCc+Q/Z3CsKjMsFuchcJGwr2NpuUQriiC7kWttIc
	AB4CVtRKJbweCDmHEOe5ncXVr/LAonzyzcc88eiE0YQisxfkri4NU0JhKqEaMEJ/3+xzNAX1nUs
	h8s96zhrdSM501kD0mo0VO0ZCNkZ9r1FBlpcqsijYccW+a5wHXV6rR7v0HPvBmg24pBqz4i2AI3
	Wqbu1Yn/uq/Cn+CGrRnWyXkBQ9wDo4c9HBSWybFtYw/C9Ajdd99UnbDldloGN9+Je916WLFgEV9
	9rc=
X-Received: by 2002:a05:6a00:7599:b0:880:47cb:ef05 with SMTP id d2e1a72fcca58-88047cbf251mr1668896b3a.46.1790365898275;
        Fri, 25 Sep 2026 12:51:38 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea19030bsm1668470b3a.11.2026.09.25.12.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 12:51:37 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 19:51:37 +0000
Message-Id: <DLONQQN0RB03.1NVWVFHGRRWV4@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Jakub Sitnicki" <jakub@cloudflare.com>, "Daniel Zahka"
 <daniel.zahka@gmail.com>, <netdev@vger.kernel.org>, "Kuniyuki Iwashima"
 <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, <bpf@vger.kernel.org>,
 <kernel-team@cloudflare.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Simon Horman"
 <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, "Florian Westphal"
 <fw@strlen.de>, "Jack Wang" <163wangjack@gmail.com>
Subject: Re: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
In-Reply-To: <20260925121849.2ac5150b@kernel.org>
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com> <20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com> <DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> <87fqyypp67.fsf@cloudflare.com> <DLNZU9RYL0GW.CHHAJ4R62R9M@gmail.com> <20260925121849.2ac5150b@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 25, 2026 at 12:18 PM Jakub Kicinski <kuba@kernel.org> wrote:
> Instead of improving the existing infra we're adding more BPF-specific
> glue and another bit to the skb. Matter of perspective I suppose :/

skb_ext version needs a bit too. SKB_EXT_BPF is the 8th id, so it takes
the last bit of u8 active_extensions.
skbuff_ext_cache object is sized for all ids, so it also grows by
BPF_SKB_EXT_SIZE for xfrm, mptcp, psp whether bpf is used or not.

As I said earlier skb_ext is fine from bpf pov. If it can be made as
cheap as bit + tracepoint I don't mind it at all.
Which part of skb_ext would you improve?
