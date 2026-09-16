Received: from mail-pj2-f18.google.com (mail-pj2-f18.google.com [74.125.227.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4E376A08
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579420; cv=none; b=U+vHspXEMYPjm7ARDoEGCs0hh/3lJBkSISDK0rCHof7tvGUX0cmJigm28nvSy4Lt+H5YPVKFkdMq2qgkeBOoL5MNj51dOxKVg5BNHxeBIqgHmLGjkboIq6Hj5tJn8crLAKYQSQ6WniEo1uPJRUMqMStPYPJT5mcv6ZU/Sgnwy7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579420; c=relaxed/simple;
	bh=2r/ur1vHQQ7hUa5k+c+J4cgWoSYzzgQ7+aJxr497qD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aznXeijNtSOvUR/RqgaOv8aDoY+ya1bOEsprakhCagwErrVkmHU/DXEcqBA29Thi4XhSMbr7/1wDX4IKYCKRpxDygJbxs7B42Ms/cq/pznKYwbRVd9k9mD8mMWKafONlX8Jv0jBSng5FlOCZjOFyN8L3M91P5dc+jnDiku/E37Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=qTWE9AMH; arc=none smtp.client-ip=74.125.227.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="qTWE9AMH"
Received: by mail-pj2-f18.google.com with SMTP id d9443c01a7336-2db22383fe8so8441495ad.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1789579417; x=1790184217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mrxKqPcjgQ5tUNDYvVuvcLSiDIZVjPZraogbQhp09P4=;
        b=qTWE9AMHz0bedGjuA186VAWjh7XDkVGBzwbAFjGkOAMzCuJdyyGkntcYjOlB/vXlKI
         cnCBAXcxmgv5gB1cNUJ2T626pyhOdEBxCHcOBjoL9N57wDR2aVdKglRoiEgWbbN2GS4E
         8GGDT610NkN4eCyMR1zqKNSdyPzqH6zHAqasTJV33w2NgQADIDQuhgvpD+eQDeLAMSLs
         FkfjkvCH4PPEFrnzTURk0t3OE6P8DYFzM2vFDZknbN4/3PGnVHwWd9MMPVFAWaL12pM6
         gxoLFEODIfkKlhhfOhnQLsuz5EIQs9Lf2ZWACFWcOLnPNtMzlX6oTK7CW7aOCV1TBQzc
         vY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789579417; x=1790184217;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mrxKqPcjgQ5tUNDYvVuvcLSiDIZVjPZraogbQhp09P4=;
        b=EG9oflUnHS+HJhOu0Eipgc7vMXL/Ym/n9ZixDI5Ob6ef6FvKVFSF7FPqetQDljSPFe
         mMmGeR+/5sIrwlZhmizKYcmbR3nlGMptYqRXhAH52qvS09DU1i4/DIVZUc3td5eRnn3c
         XoRrSuEX8oSLKQaki2rLkogKWfPFv6SUMKr6yTK/XTQLBb3FMPuNplro61K54ih3EwD7
         Ylv4SkZ3nx+qCpbK3PA94AqKnkKIjAsvPI6jJlra9wURvOixU+lG4KIoM+PJkAji8ksz
         rNkmv1cisyS8xuAn+4kb/5V47lh5+05g+ec4tiRJuvuX3g5Yd7sFKCgwZqGHUzvVF+5F
         Z9Mg==
X-Gm-Message-State: AFuF++nHoJYO+EwnawLlHvzsJOlntwaOXpCxr1isTwUuMuejQt7H8urO
	/33ZT/YL3AgB+wTU153Wjuwc4l81RmBxiSBlaEsS/PSjn5WwA5j/LtlsHtls+598F20=
X-Gm-Gg: AYBFou2svQaXAggQmYNfrpvHdtV7pYtUfxhLHvQrYIRE462IqlSG6lihP+i0kHXTj7N
	lTCVASJSh1aY+j0xJMWv1ZA1VPssIGV5++/Y5XsVpajJHgk8sMJ1OAeh4B2eraVf8BwFEQTo61C
	AGOUnhUyu9UA243mlHpUafHmefWbhgiMHvFNhT1dUlz9jzP9zoAbUMwNQoegi6AjTRzMVoXgeBU
	UIJgJx+l2SUPSme+GassAgveY8EXxUaQYKfFXiVbeyGkO/hoZ8BnIBDBXmJ0dBeQyXpNCWhr4pj
	nFi7FbOofTlMqIiTsuutzgndEC+ArEXpPIC5Cr7T7lBHVGQF8UaeOng755Ns/NHtQCukmkw2xkl
	piBOseZlDUcN4CCvpimHqbxwwCHZWWPjwFS6XjafRisai1Vqoj9ntqQW07qRrNO7jJcdN0+yfRv
	UKrHFiTDAx1g0JAsgJJKRSizq38va1hQR7KkeIySN9PoWNL2kLCJnf3GmtH+jxbndgypX24dEdL
	g30sYbaTcsXwjw5cvTvZzTsdQbKg1sdXW02je/BmiKxPRYPH4uLQfDWo02BnI+57Zb266DE
X-Received: by 2002:a17:903:9ce:b0:2c9:e9db:8167 with SMTP id d9443c01a7336-2dd8e00347bmr76211565ad.7.1789579417229;
        Wed, 16 Sep 2026 10:23:37 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::6:fa0c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89ee0a56sm15181545ad.50.2026.09.16.10.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 10:23:36 -0700 (PDT)
Message-ID: <5eaa3be7-1615-4f8b-81e1-449db0e986ef@davidwei.uk>
Date: Wed, 16 Sep 2026 10:23:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: initialize skb tx timestamp key before cloning
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>
References: <20260915214450.2882680-1-dw@davidwei.uk>
 <CANn89iLkkiXvjWzH=_iGNV-_n8aAUSiCVuwy1VPYb6BKZO-rew@mail.gmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CANn89iLkkiXvjWzH=_iGNV-_n8aAUSiCVuwy1VPYb6BKZO-rew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-09-15 15:21, Eric Dumazet wrote:
> On Tue, Sep 15, 2026 at 2:44 PM David Wei <dw@davidwei.uk> wrote:
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
>> Initialize skb tskey just before cloning while its shinfo is still
>> private. In tcp_tx_timestamp(), if it selects a cloned skb from the rtx
>> queue from the current tcp_sendmsg_locked() call (i.e. tx_flags and
>> txstamp_ack are 0) and the pre-init skb tskey matches, then tx_flags can
>> be set safely.
>>
>> If the skb is not shared, coming from the write queue, then both tskey
>> and tx_flags are set, as before.
>>
>> Fixes: 838eb9687691 ("tcp: tcp_tx_timestamp() must look at the rtx queue")
>> Assisted-by: LLM
>> Signed-off-by: David Wei <dw@davidwei.uk>
> 
> pw-bot: cr
> 
> Sorry, this patch significantly hurts TCP performance and has many bugs.
> 
> I am sure your LLM can find a cheaper solution if you ask it to try harder.

This wasn't a yolo patch straight from an LLM, I tried quite hard to
reason with the bug and possible solutions. Maybe that's the problem -
the LLM is actually smarter than me :)

> 
> Some hints if needed:
> 
> First idea:
> 
> 1) In tcp_tx_timestamp():
> 
> Keep shinfo / tcb accesses inside if (unlikely(tsflags)) so normal
> traffic pays zero cost.
> When falling back to skb = skb_rb_last(&sk->tcp_rtx_queue):
> Verify TCP_SKB_CB(skb)->end_seq == tp->write_seq and
> !tcp_has_tx_tstamp(skb). If either fails, do not touch skb.
> Always write shinfo->tskey before sock_tx_timestamp(sk, sockc,
> &shinfo->tx_flags) (and do the same in
> bpf_sock_ops_enable_tx_tstamp()).
> If pre-initializing shinfo->tskey in __tcp_transmit_skb() before
> skb_clone(oskb, gfp_mask) (which already dirties shinfo->dataref in
> the same cache line), guard it with !tcp_has_tx_tstamp(oskb) and use
> TCP_SKB_CB(oskb)->end_seq - 1 (or seq + len - 1), without the bogus if
> (shinfo->tskey != tskey) check in tcp_tx_timestamp().
> 
> 2) In tcp_sendmsg_locked() (to preserve TX_SCHED / TX_SOFTWARE /
> TX_HARDWARE on non-blocking partial sends):
> 
> Before calling tcp_push_one() / __tcp_push_pending_frames() at the end
> of the loop (when skb->len >= size_goal), check if
> (!sk_stream_memory_free(sk)) goto wait_for_space;.
> At wait_for_space:, only call tcp_push() if timeo != 0 (since when
> !timeo, sk_stream_wait_memory() immediately returns -EAGAIN and out:
> will run tcp_tx_timestamp() before tcp_push()).
> 
> Second idea:
> 
> We can solve this cleanly and minimally by:
> 
> Reordering the writes in tcp_tx_timestamp() (and
> bpf_sock_ops_enable_tx_tstamp()) so shinfo->tskey is written first via
> WRITE_ONCE(), followed by publishing shinfo->tx_flags via
> smp_store_release() in __sock_tx_timestamp().

I did think about this solution. I still don't fully grasp the memory
model and how READ/WRITE_ONCE and acquire-release works, so I wasn't
entirely sure if it was sufficient.

There could be situations where the skb is pushed early, and the lower
layers copy the shinfo e.g. GSO and COW. I don't have experience with
this code, so I find it hard to evaluate plausible paths that LLMs
suggest.

That's why I opted for the pre-set tskey before clone approach in this
RFC. I didn't think this would affect perf that badly, but yeah it is a
really hot function.

I believe I can make the GSO path work with acquire-release. For COW, do
you think it is actually relevant?

> 
> Guarding tcp_rtx_queue fallback with if (skb &&
> tcp_has_tx_tstamp(skb)) return; so we never overwrite tskey on an
> in-flight cloned skb that already has active timestamp flags.
> 
> Performing a symmetric smp_load_acquire() on
> skb_shinfo(orig_skb)->tx_flags in __skb_tstamp_tx() (and
> skb_complete_tx_timestamp()) before reading tskey.
> This avoids touching __tcp_transmit_skb() or the tcp_sendmsg_locked()
> loop, adds zero overhead to the TX fastpath (skb_tx_timestamp()
> remains a relaxed check), and compiles to plain MOVs on x86 while
> providing proper release-acquire ordering (stlrb/ldarb) on ARM64.
