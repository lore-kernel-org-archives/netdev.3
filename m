Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E112248880
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 04:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789706142; cv=none; b=E+Di4zCW0BJ4tYFP50OktVe7MTQ9d6/2tprE1aLB3wGJWW2rAP/NSF7UUm6MjCATejB90ZG8wn47L66VsVIIBjiAw+0ws4/onG+uKMoSRO7K3r7AR/efmqytXNz3TUUNHvgdHO6WrHQcwpuNNBeqH6cL0+HL+he6+HqEeu/UUPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789706142; c=relaxed/simple;
	bh=bGRLaDmE0tGe3dzGXjqwaS0i7oukhbkfyXv4P/hl9lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sz3EUWoqQnrBB9EF9zC9icn8qLjJjuD+xtyheZY9jrzDVYIkeMjWtxDlkB8N34+pxOVBQR3d5M3aTDJvdwHfMnPI9IWr3t0GGTdoCvL/1og6aT3KB6UGp4ZTPeIt9YSGUGiTbv96Ujo/QpZvxSpgO5d7X6lpxItqltAJOCEFyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=OE9en6ex; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="OE9en6ex"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so304444a91.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 21:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1789706141; x=1790310941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QuXWbq9lF2IllK6DYKHV1u9ljCegelyzeKlijMgJK7Q=;
        b=OE9en6exVfIqAQIUWihZcZQRdDdMKoCMYfbXftp92HXnlJasiU/E14eF6gRwBjZ+8Q
         N+Tia09SOTpd5VgLUXqnyMkRNxpZNppPtCUi7BgmKPHbRQD3Bp9Ql3/nQvcfzwTqwXzY
         bbU7x9/qSUNcJm8LPLvPxQvwD+IWZl32MU9NTq9eQuQrqrMjancrwCRLHAMq7EMnGC05
         2B/D2RE1GiRXg0wj4nUjbRKVfBldRgx0mHWmwN7p3H4fGjwkVk5+8FicpZ5JZFa3ZoFX
         qKCRipLJIw+RHE7xidHVV51PFO0Jh3PinARK90eHLn1prTj1I4opnJlL8emWybWNQwm2
         XVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789706141; x=1790310941;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QuXWbq9lF2IllK6DYKHV1u9ljCegelyzeKlijMgJK7Q=;
        b=ZHwONlzlAth1QGK6Pcu3lO2Xcr5Sn5YaCsfS2DFrOVGDGXWio+WNq0njERePn3Hs2+
         YB6GSHp0LQmZBCYMAsnHxYWk4vSjt7C696TVMAWA/6DAKj2ZybXsP9sOVW+k8I1BL4FH
         e9m17TTBx7O9ETaY1nnVcbcCQ36MptFLlfuJXJrSszMPGf0/Z1kScb1YF5yKVCIFbxe0
         RvZlz0fJb9Zw+IXjWXNCIUTtE8LDOC9ACe1B+89ZSqJNYX6yuOp+U4f/BNi95RicAFHA
         FmSHj07eAg/eHkOUFiDAwt7bhlbounthX4rixie8CdApsqptw2jro9zzG1MKj9iL1Vza
         Trhw==
X-Gm-Message-State: AFuF++n3mTMiauYwNhCQshcAi9paUiPKXHpcBsVWL8LpITHzOCmhW/xE
	A4DxAPD32yQ7wzGtpfItTG2r0WVjU3u51glro9P0YqvvpdZBgkIO4RsPI+zcQW2+WEA=
X-Gm-Gg: AYBFou2E7cdxeci7phGApGnD1242zuvjdIY+l5zVcRwRoBQWzBu+pP5XcI5BlRQIz/E
	D0qvl9rts/hVKVRVuFONHe68eOWUV2khRt6BuaONVxO5bL8ETbJs6x8xM+crk6Henwq0F5oK0En
	u9/522CidHdMshcIJqhaieKFBeMUFJWATDBqG9auSIXE6i84DiXNuZMfW+hPc1GKp62h6VSY+jk
	YMELjRxycaphFCRG2h690QmsVpDr6UMvCDZcE5Qxcesm2ncFnc6asMGOREAHGm7XeXpCL1TIvW5
	+t0NGpEhEt7xmhH6TVj6QlOxjzuvJN8N9Lij+weqH1ERMpKr6etT1F3+NeHgORpamTG2u1BClo5
	sqKgKNOdkLOQdUUr771oFiTg4C1N9MdA0bjDQVp1BLJSn4/lq2vGwCwTXgeKkWpVsE1nfHkbfeI
	eTOfEGOZ77rm4zifL9OOhLj0tN419OQoqk1jOBESa/PfUk4AFza535Gygz9qL1de9q20xz5TWl4
	7DRM3wg5mSQ2k8kO8PuKP1IFsQZ8VlmBv0Tt6JOBBI=
X-Received: by 2002:a17:90b:2b43:b0:39e:1ff0:331b with SMTP id 98e67ed59e1d1-39e54d37ad0mr3147621a91.2.1789706140902;
        Thu, 17 Sep 2026 21:35:40 -0700 (PDT)
Received: from [192.168.86.26] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5333829asm770181a91.0.2026.09.17.21.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 21:35:40 -0700 (PDT)
Message-ID: <7986f36c-e95a-4083-9bdf-67c59e951b95@davidwei.uk>
Date: Thu, 17 Sep 2026 21:35:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] tcp: prevent stale tx timestamp keys on rtx
 fallback
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>
References: <20260917172050.2191062-1-dw@davidwei.uk>
 <CAL+tcoBpFM6MvZGPDJAH1j6aX8UaRcJLhtGbS_kRX_bQ=J5oMA@mail.gmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAL+tcoBpFM6MvZGPDJAH1j6aX8UaRcJLhtGbS_kRX_bQ=J5oMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-09-17 18:59, Jason Xing wrote:
> On Fri, Sep 18, 2026 at 1:20 AM David Wei <dw@davidwei.uk> wrote:
>>
>> tcp_tx_timestamp() can select skbs from the rtx queue when all the
>> copied data has been sent in tcp_sendmsg_locked(). These skbs may be
>> already cloned, sharing the same shinfo, and handed off into the lower
>> tx layers.
>>
>> tcp_tx_timestamp() sets tx_flags before setting skb tskey, racing with
>> any reader of both. It is possible to observe a valid tx_flag, but an
>> uninitialized tskey, which produces a large underflow after subtracting
>> the socket tskey.
>>
>> Reorder the writes in tcp_tx_timestamp() and
>> bpf_sock_ops_enable_tx_tstamp() to write the tskey first, followed by
>> publishing tx_flags via store-release.
>>
>> Readers perform a symmetric load-acquire on the tx_flags, followed by a
>> relaxed read of tskey.
>>
>> Fixes: 838eb9687691 ("tcp: tcp_tx_timestamp() must look at the rtx queue")
>> Assisted-by: LLM
>> Signed-off-by: David Wei <dw@davidwei.uk>
> 
> Thanks for the work.
> 
> Yesterday I remarked on your V1 at
> https://lore.kernel.org/all/CAL+tcoDMR87sxJftp7T0JX-+NUz8VkXU67M3oNZy8Tk88sDPOA@mail.gmail.com/
> 
> I'm still doubtful if we really need to introduce this much code churn
> just to fix the problem of this best-effort behavior. Even if the
> patch is fixed thoroughly, it's still a best-effort attempt since
> there are a few report points where it misses generating timestamps.
> It has nothing to do with the patch itself, but rather the design of
> net timestamping.

Hi Jason, I saw your response yesterday but it seemed like you were
discussing with Eric and not me. I had this code ready anyway before you
responded, so I sent it should Eric decide to keep 838eb9687691 and
review this approach.

If you decide to revert 838eb9687691, that is fine too and I can abandon
this patch. The main thing for me is to prevent userspace from seeing
underflows, but missing timestamps are okay.

> 
> Thanks,
> Jason
> 
