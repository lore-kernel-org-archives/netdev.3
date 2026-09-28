Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346FB4EB87E
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612053; cv=none; b=TOYB52WvZWLc9NNzLK6VY+6aRvFjtP5NOOJI5mNx80kP4uRdY3dfQttxqC+fCZWNkfdFmEidhXQSJaEBwQYp5aQp/RoYGmX9s5qj7rsFaBmxYw2vkWCeCBs/6q1tLZoSj7pbxNw3pH1oczAa8Fe6SgvcltOPnVKplv2Cv2S5aWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612053; c=relaxed/simple;
	bh=0mNiBoZ+EjTYD7duzkXnrvojGRhNpWwj6eK4k43UdIg=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=nxOaHo2gjgbCNnZeyAXBqKUf665Hpgyksddt0FdYZPa5t3hl1dvcO5BXUYunp9LXjWakZoQbRH4DC+6ilUnpAmxPbtiNvIQ0ESxEdRhI5e2JCasoXU1m1PfLFVnC0/bvBuPgEJhiu9O3DpcpAl5BRi6+7u76zzuZ1miqTo5gLfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVrbvnSu; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVrbvnSu"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d93ff61046so16885555ad.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612047; x=1791216847; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0mNiBoZ+EjTYD7duzkXnrvojGRhNpWwj6eK4k43UdIg=;
        b=VVrbvnSuaJz2ZwHKMfTDbeWKgGXlU+SRNnvIJADJjM5ZCLiBQUYVygyAhCJbAqdWSV
         vuomXrcTbVzHgRzEAWTIoP3CFv30oTmNyVkjT7oTsLd13PlpzPqIvKYymFB+NrD7UqEM
         AM3oHV5JBdB0jWQRZE/DcfrTBlSb6otB5azjhbORu1ncBEMfjiIsmepG4nS7e/WXNsf9
         r9zSmzrVlIFU3aqLgnd3ox49iyY3K061EvfEFpYc8FO2JIKJfeMsiP7c2Y+NDsDH63ih
         G/9WlONkPQsbWSvgGo03OIc0AXlqu2bhDmRyV1l9Qwmo+G0Ta0cal3qQpR/B9oJqEhhN
         quuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612047; x=1791216847;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0mNiBoZ+EjTYD7duzkXnrvojGRhNpWwj6eK4k43UdIg=;
        b=susqSVk0yeGIksfwTVU5H0Ue4rNsQ/HqVyvwfAvgygyymCGnI7MAuPhxYoeDluHdzL
         txi5tXBzt3UCE6wN9Qbx/AiPny5UE7DAPSjbn90ck/BsMi/E0sxPEIqdkUVj6JIcz7zq
         +Zb3PuntAaD+GGLP/jbd/vFJEAJgZ82m92sVwSIkAGsl6/n2F29ERvJd8jpuAmGATzHt
         Fw0mYo+6WrYfMUpilCOdQtMve3ib0N8qvqACVDhTLVZETPYwMJGNW/eYl8TlbADEGFEt
         20Zqn/vhr+XeDQP/VxhXtie5CitYEWOdFme8R0LICl5ETfS3rdSddf+gaL1pLsEq3tqr
         rCzw==
X-Forwarded-Encrypted: i=1; AKwUvBwH43tHM58v+5MNzlwoBJgX3nVCDUSkE2Ch7q5GOd54JZuM0wsMNiqtxFeDho1lrSSLMrFysqE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyq5c6VH/b441Ri3Bty0Q4kDfgkGqLb1GF2KGYyU+PLND/5hdN
	2iMV+BKCwyYqeangwg1+VxR+u6Yta8Nso9LShxOO76u0mwXIeCWVmOZD
X-Gm-Gg: AYBFou0UALISMgdltPilGE7NELhqQm7TQAoynGYEmvVADKv0b/M/RctMI3vhHJ7s45p
	hnLucwZS7xdQqnuRmjSk/QWC+OYyeZ3z72KodJEjpzyyzVMX0hn/msZ/B9Jme2/MG8RIGGofMkt
	f/CcUeyWi+EmUgUqBYXJ1H1YGacvWVv1LICQYsHu4YFXgU8ZkvRaxpExN2jZ0XBt7GiJ1mvtWYF
	JyiicVXe6qKkgdTaRHg/Z4lnWQ6MuCjCUJqDG2hvqas+i6mwr9oU2X4zEjL6RetAwwp9zEFGiBD
	PQ8c2eDjN6p5bi5hHqaABpL70gdG+rBi0MiSAbSDRksG4vya13y/0qRuonLjj6rlspbB6PQi1Bn
	iZBwQ6P6Ku/vvzOcRhf+eWjSNftZR45KoYTZz5qULAbJP2Wgmecqmxkx9Ib5p1qzo2goWvy9R5p
	+xwhsSK+lY9HcHdL0eeyfCjYzVLhYHaTbo+gH6uHxPa4x1SsLPA6x7c1mTqrsUedYhMn28/HoeG
	jRhQ3jH2+cSkUo7mWEK/agTrGsNy/CpHQkiG0DXxA1S3VSnmRHq0LE2MFsENEE0xtC/ghNqlTT1
	WRE=
X-Received: by 2002:a17:902:ef4c:b0:2dd:ad74:ac20 with SMTP id d9443c01a7336-2df7dea7d02mr104273185ad.27.1790612046704;
        Mon, 28 Sep 2026 09:14:06 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913dfea3sm43852325ad.14.2026.09.28.09.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 09:14:05 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 16:14:04 +0000
Message-Id: <DLR2ZT65RKF3.3KZ8O8P4VKTI2@gmail.com>
Subject: Re: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
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
In-Reply-To: <87jyo5bcgs.fsf@cloudflare.com>
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com> <20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com> <DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> <87fqyypp67.fsf@cloudflare.com> <DLNZU9RYL0GW.CHHAJ4R62R9M@gmail.com> <20260925121849.2ac5150b@kernel.org> <DLONQQN0RB03.1NVWVFHGRRWV4@gmail.com> <20260925132004.171b751e@kernel.org> <DLOOI89GKM5B.W4XPBNJUXRV1@gmail.com> <87jyo5bcgs.fsf@cloudflare.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 28, 2026 at 05:52 PM Jakub Sitnicki <jakub@cloudflare.com> wrote:
> The correct results - as in reproducible and with lower variance - are
> the other way around - BPF skb ext is cheaper CPU-wise than gated skb
> tracepoints. Please see:
>
> https://patch.msgid.link/20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com

I don't think these numbers measure the mechanism either.
cpustats.py divides busy by ncpus, so +16.4 and +6.6 are the mean
over 6 cpus, while 146k pps is the total of 3 flows.
So it's 6.7 usec vs 2.7 usec per packet and not 1125 ns vs 450 ns.
That's a lot for one kmem_cache_alloc/free and a 16 byte copy.

Pls share perf report for both and rerun.

