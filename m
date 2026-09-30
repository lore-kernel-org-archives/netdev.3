Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A183A248F57
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758826; cv=none; b=qTyMyEghtwZD6B+n8Mg2ngapWQzNoD081S0aON8+KDTdLS5EpkPO/JJ5UQEh2mfg01pGdW62+Fz/ZQeZV7a6FdOrjY4yUZw4Hi072gjPiVChT/tHTPTEwMDhhuEwNOnIEykzZocSuuQ5sdvlOmpcLVIjr7x3RwoGCd3szZkTrUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758826; c=relaxed/simple;
	bh=sSFfq8V5j1UFF+Q6OTJv1JVOc53BRRub9YqpWkEgZVc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Tlmzr7mQeoKCRwlJ0goZRaZ5pbt5qjA8EqWJth/mimAKnSWyffduc9ohjQDrh2V8Tw+TEEfXZ9JmFLOQiWuTzXdAjqeeQiUu6mB6laGSkbzCdQQpFjGR2ZEvIVxNiOGvG7powJQqQOk+UczQFCqcHtQRqXwCTxgq3m8RamQHJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sR1IdwwV; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sR1IdwwV"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7d1403bbaso556750a12.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790758825; x=1791363625; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sSFfq8V5j1UFF+Q6OTJv1JVOc53BRRub9YqpWkEgZVc=;
        b=sR1IdwwVgduFIv7qpHpwmu1NFvO0x7IDDr0QfkZ8/xYXZI1+crJiGrRgwqxCiFUx1e
         +40IlZ2oTgXuFWqusG4Azk233/zi0rIRjJT72udcQakiVKeCH9DHz3wmQNaEkB67OcRd
         y/yxcbmxKKBPS5TFmEv3TlygkG1HYCZmnXwP7fcSWPXZLOvLzuT6iS+eVS4j0CWmxAQB
         OybMfKIrQiaUhHz1LMuxnOVItnveRYWKfcyE7tHdRzpkYIpDy7rcMWJJDsv9b14u9S6P
         vNJQ6jl536g1u8eA3ub8NTOwrIwj7wOReV+3TtV/lxpyRKt35MdpkLU4kcNrDnG2WCvl
         RtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790758825; x=1791363625;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sSFfq8V5j1UFF+Q6OTJv1JVOc53BRRub9YqpWkEgZVc=;
        b=102f21WjVOrHhvk1UG4LZdEwFl1cBjkyZRzdnJmVUFx48F3Rx36o4A19sIg9xi2XTk
         np0JEEi53eD6AOWrwFD2wMxd/86UP6elPCJbrFIqAQhssKadup26vBBFWDEBcQAS5B4B
         MH4/VPXqxTVx2fEruA3AM3eblV1mTBPI26YkvAnK/tdlMkJ8ZVpN+X81d3WHqiCw3Xd3
         tEh4e8ZYE/rLVjdH/4cffeFl+shvhgH77bPcplGFxGl5oMTZ1q+uKJUosevQbjQqNnMI
         0XVDJPwcP1ufCdFX4I5696vbHx3eGfG5nHXSxzYyUutjV44t9labtpYJ8wzmloNl3VMC
         Wzzw==
X-Forwarded-Encrypted: i=1; AKwUvBxw/qK5B5Pfz50UETtHp1mw+Umz14kySGJr/fXApGgvDK6o9+R8GOs2l/Zz366mVE5OfF156kg=@vger.kernel.org
X-Gm-Message-State: AFuF++l8xJ62icToeguquqVA3OqYl5XROnQjnbbERJGBkY01vuv+ywu8
	P+5vD7/aNF8rT17BAgi0/Ot3STzHaomNW/rXP/aGlPrwk1ylJKqkgOVv
X-Gm-Gg: AYBFou1KkQ8x6pa4nMaDRsIjvTCYr5tj/tEGXfX9HEkA6kOU/PuVWJNB1/AeQwW3yY+
	jz6EKsx3JNS9itrQsEkE1wc+BA20JVxxKRAO1Uqefy1lSNdwaxITuUwhXS4Ap0ii77NbUpYwI9a
	GDBCiFuWGTCBeP7X2LnDyXIC7Nrk8GSOAu9TA/QnHegkDJ5B7bXVc9gnzaheuC+doYDAaVQfI8I
	pGl2t2Jo+ilIYDCKqsIl4uuw/u3A5pngBteUEkEGp3qRvieUPONA9tmaERRWDW5bAB29xYu8p9d
	oqdtoYqiMhSooodphykBOYq870Qtv3mHqFWfrL3wQnYqznaS5ITSAj2p6gGfr+jPTGXAXCnTmk3
	Qg0mJHlaSe5M89rUAY2LgBTNSAZCrEDAPRiVUnGHZTfpieiXGpheqmgzTiNZmMKSv5dib/4Nv0A
	kxqZuESi0DB2lmHKuZ7I/xU2Wx4O+J3D6qJ+VAS1cnzTd2fdG1LU2/29c4eLoJNGw2I6MXeRqca
	RTsh/lFVQyppbzUveCPlWRGyugkgoYX/XsSlzQjpBKzLSJcNDEotqYQp5X1nLnB0PpxilbdpS7c
	bNQt1YOo4704KBU=
X-Received: by 2002:a05:6a20:e290:b0:3dd:85a8:4c5a with SMTP id adf61e73a8af0-3de9e6ef037mr777228637.33.1790758824705;
        Wed, 30 Sep 2026 02:00:24 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7dab424e8sm492238a12.32.2026.09.30.02.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 02:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 09:00:23 +0000
Message-Id: <DLSJ0UIY3DSY.3JWS6CS3TX0IP@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>, "Daniel Zahka"
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
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com> <20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com> <DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> <87fqyypp67.fsf@cloudflare.com> <DLNZU9RYL0GW.CHHAJ4R62R9M@gmail.com> <20260925121849.2ac5150b@kernel.org> <DLONQQN0RB03.1NVWVFHGRRWV4@gmail.com> <20260925132004.171b751e@kernel.org> <DLOOI89GKM5B.W4XPBNJUXRV1@gmail.com> <87jyo5bcgs.fsf@cloudflare.com> <DLR2ZT65RKF3.3KZ8O8P4VKTI2@gmail.com> <87ecebbxy5.fsf@cloudflare.com>
In-Reply-To: <87ecebbxy5.fsf@cloudflare.com>

On Tue Sep 29, 2026 at 8:32 PM UTC, Jakub Sitnicki wrote:
> Everything pushed to:
>
> https://github.com/jsitnicki/skb-metadata-bench/tree/main/profile

looks like you had lockdep on, so all the data and conclusions
likely do not correlate to production.
Pls fix and remeasure everything.

