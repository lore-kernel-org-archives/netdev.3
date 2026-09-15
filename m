Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632632FD7B1
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789510877; cv=pass; b=r2p/3CLIHLc9JYx2lyd8txHu39yKAWErb0UNf4Qx3WdpHRbl3WwIxOvrgQk+qGiSct+CkqJKuTrzkQ6CJLiFauOHXI1WUQQGSEf2EKVgqSBvmsSTO0cVOnJNIohOLd9JLj8tios/MNIaxguukK9bmjsW2O0ZCOBaMQeYrK0Ew8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789510877; c=relaxed/simple;
	bh=IjnUrzj7hbyIIa9+BFev+ex0I9ppXbS8nuIlMZtPHiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YaBfx4MGxnH6lWuGoDUdOPf/t1iZF0QUF+9UsU9NV90MGUEHcW9Q/1gCq1BzWdkllzosdnQpHyhFt8zbTyxg7xWSlQXCLIF1YQdEF19nvtGsJ7uIfRv1o6HDJ1YFQ5+kwzmPwOdXYUY/BGTlHA31pk1eouCXZDXEdWsdDyNWobo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hoUeI4O1; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hoUeI4O1"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb766bfd8so2091051cf.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 15:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789510875; cv=none;
        d=google.com; s=arc-20260327;
        b=rgKgSPA75LZc26BAhCovex7ntX2OYgxRNSmip9Gy2//NZ5Ucb70tEi0DvHWVHd0KPY
         7trQewQAgeuUkpFcNPH9+vhKUd7hTW1dN8mr22EV9zPpDEoUAH9Kj+bLHQB+Rz4vMXkE
         1u0CGvOT5+VYj9g2eKARXsfBt5gW080suqLfrqhcwaEo6eU2LKT/VLOtbqqlPobNHxHl
         8yXeZMZF2MlIhpJTWgRZXXU24TmCzFcJeQbAkaX6nxT9Z0TZC1iQeOIS3VInHGw2S1SJ
         Zqn4X+MxwLBORLYVholVJv/tJmUXtIW19VXI7onElmmeJtE6vXF2KnH/b83R0aspcA5s
         0JQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IjnUrzj7hbyIIa9+BFev+ex0I9ppXbS8nuIlMZtPHiM=;
        fh=oZz5lmj7cApYr7DJxXRFmyznJI5ve6xBU9AA1ylJ1YY=;
        b=FmF08/6gsvpy5AtWoNfmR+PnYRGroGhSzZnGlgMTIgROuiZMMiL7FmvsC5bvfii/8P
         Pxfmb+t9kmgnHwh1VjaRZS1v0fwL3Ksa+n5WGujHSPdp6jejXT7Qs18D6E2kaKEIzwXF
         /oJ/zlFE63lYXy/3VoCUXJgkjcrxQiyX0hkOt62xF/YgHMNClPCpRGMvoNzkl24nH1ZT
         ++EMviCyBUBW72LqFvc5EeZaCkZ44km2F6TVVnZVp9fzLnaDNKO19skYS0PuiJy6Rwld
         o0CURf7qUCDnorQekNzwn5ekI0P4BSxy8plUVDY6wokek5UR7xxxYvpEXM8sD9BIrReC
         8L2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789510875; x=1790115675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IjnUrzj7hbyIIa9+BFev+ex0I9ppXbS8nuIlMZtPHiM=;
        b=hoUeI4O1kn5KNuQwlLojWi8ipwvhEpSGaNSOqc40e2w3KpyRL3a4jKzwx+bzD1kPlS
         60L1hXEiWf/TOLreK7LD33hM8YNPF7n2Tt98zoAwsWB/P2vZL/r8VmKWeWZSVFiDkcVG
         Q85TnP8mlIsXRFoE80qjj0S9KzMvQ/l+3ipxkbBevljp86NtaNEQWXvb2UeC0izbeAgX
         PKDswOZMORifYYz0t/42V96FDN5S63GFHBh4H9jg6CYGWTnHmmOPElzjPfSz2JiDGpa6
         xg0Y9SXCDtvVMtTVkSv9q950lC9Iu/8iGUnhLyuLo1qPxn3b3i1JUorpkXccQfDcfs4L
         yOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789510875; x=1790115675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IjnUrzj7hbyIIa9+BFev+ex0I9ppXbS8nuIlMZtPHiM=;
        b=tDsXfp/5PQRANcFQQKZzcKDxPn+NzLmYuJTrFlJxRAR1yO1WyQviPrJWm9gLG097n3
         KVIgwerdUUwVeGCk3moj1NHHEaTEno6wELyAzQg3eobc70bb9/kfXkjgEhadAHx1j0dI
         YbEl0Sopn9qE00PgAT1xU9qtU1ykyNRFXvzGqwipYl1HTSWpLXk2JqbMlXhINI/GMDSY
         oD01YaIPxSwmYBuXfM1yc3x5ZA005dOtaqEDx/JmXa4L6I3itzv7/aKkxjoT4N0mTKv2
         viqAZpPcR6xAolfIYpc34TElfIGpIm1Ks5JzEDFLjB3hc+YFKeH27iYqZzP2qSZ4v9KY
         T/Tg==
X-Gm-Message-State: AFuF++lT21tzmSkG76D6y+Azk920JEE9IJ0Nq16SmMOWEWqPuYqEnvQj
	B9eZA772Y09wCRpOBPlUdX9kA4KTJZjH1BvMdsYMNoWTyCp8KWjwQHXPyKN+H8ol3xuHj3mfJyx
	5iPKY1EWaJxDkbP06XtuAiHXziUOPWaUflF2ul2uW
X-Gm-Gg: AYBFou3ymMrBFT4ral62hGA8CkagmT6XxcYzakOgB0DdmhehbnnI1iWyVYF5Ib+pd84
	J/Q0SJyARLsU1KyloHy3m9BYFi4vx27HWeX80hm9dBXbYSFOALzP4039NhC9bda/2RY8ZsTBLEa
	Es5m5n+bnS8QgRtOzvZeuu/pEGvBhAXCRM8x9t17Jm/skJif8sjylaYt5dHJBO90IwzohESTDwR
	1vib3zuWkB18ObgmqyZ4hyMUaTyWOfToKqVUcV1KYXRrKNw/i4g88Wg54Paqor0+WJBQvAEOLp9
	2BHtRlw64Q8D8GWeex9LWNeSbjDxZYOqpcDhqWf0Af0JzYaHs2U1525bUXnREYJ9QiKlxn2uqXH
	2tT+Qxac+XqRqmweMEZZMa7+a5b+rz5pPdKZRnvJfnsAWj+ixciJkLbWGQjQgEuyxmOwixTK9l2
	7/YSYZHLtOlfLmnNsJuSa6
X-Received: by 2002:ac8:5cd6:0:b0:52d:9db2:791e with SMTP id
 d75a77b69052e-5327ee25b03mr6113791cf.21.1789510874600; Tue, 15 Sep 2026
 15:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915214450.2882680-1-dw@davidwei.uk>
In-Reply-To: <20260915214450.2882680-1-dw@davidwei.uk>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Sep 2026 15:21:03 -0700
X-Gm-Features: AcwNN1XnBKVEQccBT58z4hZUIf3Gg8bW0evm3MpqpKetenUFkqGMKN8mTLHj254
Message-ID: <CANn89iLkkiXvjWzH=_iGNV-_n8aAUSiCVuwy1VPYb6BKZO-rew@mail.gmail.com>
Subject: Re: [PATCH net] tcp: initialize skb tx timestamp key before cloning
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 2:44=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> tcp_tx_timestamp() can select skbs from the rtx queue when all the
> copied data has been sent in tcp_sendmsg_locked(). These skbs may be
> already cloned, sharing the same shinfo, and handed off into the lower
> tx layers.
>
> tcp_tx_timestamp() sets tx_flags before setting skb tskey, racing with
> any reader of both. It is possible to observe a valid tx_flag, but an
> uninitialized tskey, which produces a large underflow after subtracting
> the socket tskey.
>
> Initialize skb tskey just before cloning while its shinfo is still
> private. In tcp_tx_timestamp(), if it selects a cloned skb from the rtx
> queue from the current tcp_sendmsg_locked() call (i.e. tx_flags and
> txstamp_ack are 0) and the pre-init skb tskey matches, then tx_flags can
> be set safely.
>
> If the skb is not shared, coming from the write queue, then both tskey
> and tx_flags are set, as before.
>
> Fixes: 838eb9687691 ("tcp: tcp_tx_timestamp() must look at the rtx queue"=
)
> Assisted-by: LLM
> Signed-off-by: David Wei <dw@davidwei.uk>

pw-bot: cr

Sorry, this patch significantly hurts TCP performance and has many bugs.

I am sure your LLM can find a cheaper solution if you ask it to try harder.

Some hints if needed:

First idea:

1) In tcp_tx_timestamp():

Keep shinfo / tcb accesses inside if (unlikely(tsflags)) so normal
traffic pays zero cost.
When falling back to skb =3D skb_rb_last(&sk->tcp_rtx_queue):
Verify TCP_SKB_CB(skb)->end_seq =3D=3D tp->write_seq and
!tcp_has_tx_tstamp(skb). If either fails, do not touch skb.
Always write shinfo->tskey before sock_tx_timestamp(sk, sockc,
&shinfo->tx_flags) (and do the same in
bpf_sock_ops_enable_tx_tstamp()).
If pre-initializing shinfo->tskey in __tcp_transmit_skb() before
skb_clone(oskb, gfp_mask) (which already dirties shinfo->dataref in
the same cache line), guard it with !tcp_has_tx_tstamp(oskb) and use
TCP_SKB_CB(oskb)->end_seq - 1 (or seq + len - 1), without the bogus if
(shinfo->tskey !=3D tskey) check in tcp_tx_timestamp().

2) In tcp_sendmsg_locked() (to preserve TX_SCHED / TX_SOFTWARE /
TX_HARDWARE on non-blocking partial sends):

Before calling tcp_push_one() / __tcp_push_pending_frames() at the end
of the loop (when skb->len >=3D size_goal), check if
(!sk_stream_memory_free(sk)) goto wait_for_space;.
At wait_for_space:, only call tcp_push() if timeo !=3D 0 (since when
!timeo, sk_stream_wait_memory() immediately returns -EAGAIN and out:
will run tcp_tx_timestamp() before tcp_push()).

Second idea:

We can solve this cleanly and minimally by:

Reordering the writes in tcp_tx_timestamp() (and
bpf_sock_ops_enable_tx_tstamp()) so shinfo->tskey is written first via
WRITE_ONCE(), followed by publishing shinfo->tx_flags via
smp_store_release() in __sock_tx_timestamp().

Guarding tcp_rtx_queue fallback with if (skb &&
tcp_has_tx_tstamp(skb)) return; so we never overwrite tskey on an
in-flight cloned skb that already has active timestamp flags.

Performing a symmetric smp_load_acquire() on
skb_shinfo(orig_skb)->tx_flags in __skb_tstamp_tx() (and
skb_complete_tx_timestamp()) before reading tskey.
This avoids touching __tcp_transmit_skb() or the tcp_sendmsg_locked()
loop, adds zero overhead to the TX fastpath (skb_tx_timestamp()
remains a relaxed check), and compiles to plain MOVs on x86 while
providing proper release-acquire ordering (stlrb/ldarb) on ARM64.
