Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643911;
	b=WNqpU4NlfAaSQGmnRlfqRO1mmbH4oUQNnN6ai31fp4dLHZxak570PCObbBm5TBREfVQo
	 Bo2ZgKjyvjiSPCSzm/DUTXfWYEHdSWeuWiKU0FAzHCey43m6iVgcPeY0+hti5O7+1dlCe
	 npNSBNcHWsUelH1/LPUWnrgsmyFZYGSF0r3/cAg9H/7EC3v3EF8BwSGqg7FUvdifXXGIk
	 JofwQxbWgFhr85XTJ0ngJZIXyLT7q1vSs+40FoIT89SRLa1tUd/y5dUndm8gxlfWOdBLu
	 HDt4NcxnbMvl3U0CNZqJSm6kQ3EL4B505R7WxImzIkGeumhqdPkPoQGbil5JsevMQ9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Z41mKtHOm7Mi5CS6B12EWoUXhaoVqMrutmZJokfP2gM=;
	b=3TZ9ow6Q8KRFVUniZ29UvcwTKeSRH1jUu5LFKa26RZjLNIr1FAfJ80hW8V+TSSGuK8Wz
	 EW96N3PFSVyyCmlitGlznGFwyaaYIEH5asOL4D/8TLrqWbphtqAu/nUFD3XrTsLaHqQcK
	 Jzy5kb+A0wAmJu9mXMUx/Pc5p8okAmqXyj+sebYKvWVHtZUIPmtTXo2fovi/NSKBGpgH6
	 JfFzxIek+0AuePwppJuLXEOl9hBinzuX6YS7xiqrIobu38UBM0/YDGCg04Ourj8B/GhFX
	 xMwW469opGha0G5lnIdSS1lREDbB5lP5+wFvS862zdbqJ/ibg1YwGaS7jg4kpEy7w6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wRJX0RF8;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60608606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 18:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60608606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wRJX0RF8
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36888ae05e7so1207904eec.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 10:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793643909; x=1794248709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z41mKtHOm7Mi5CS6B12EWoUXhaoVqMrutmZJokfP2gM=;
        b=wRJX0RF8HzOJ5vHpbUCAKfZVjV3IC026OA9dQPQiz8FmPUdyqsaFHt8LcpZ43ExlRJ
         V131kcsJQSQmh60QT+FT7u391++5YsW/YO1DbR+WV8QL6E8eYBo3gGcPwCrAgWVG5rBl
         xPlLnxQ9m5+fvTxjr/g4bwZc0JGUnpU3natXbNrqN3XDX/Q6L7zzd4F6iGzyKrsPQItj
         Xqx1Ed0Gcr6oSkwDipSu2F2AE2yVj9CdZEI/GzDD2emXcMnfxaEAOEUnQ52JLAyxCcTe
         vMadz6FaT/RD/UTS6WJ220Qt5fRzD49ZSypC9hgqQxdy3e/lboRbOgyp1bUDlnQ3/dgj
         PATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793643909; x=1794248709;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z41mKtHOm7Mi5CS6B12EWoUXhaoVqMrutmZJokfP2gM=;
        b=MsMiVeIzCMmxYk+caIGCKFLJmTKNBfBUp3w9T501TtiKtAyA6lN1HkKIrtOXqn2IBv
         28jQfFBlm8xq2yTZ14tPqeFE+mUmWXxrIpMsuvLGyGqxQ6QtIhDw8WSiVfSi8Ka5x1b9
         OKcI5dT1XrXUsZXezzRQhadX8FJEHp48aPVWo0t/pVJcviNdt2XRJ+IQx7TNOjrjGT2H
         3t6AG0ZSnXksZgRNij8orNUnE2JVzJvpMamo3GakDglwjcE9orV9s3mT4XKK1brhE0Sp
         pAd+YQfcvQJdP2t+NyHvdGMNIQbPFcbCXpu86hqIUwFIIWv3aJT0tH51TDtG9DKUNhdq
         6CUA==
X-Gm-Message-State: AFq9FYK+hvRlWliDqxoJ80rl6y2nUBflg+KhlNnBm8t/gG+MwbHHdmUW
	bu0b6t2MFW5XCFn1sPVLshE5NAj1Poe4QJajv75Sn3M7q4+NQyQhEQV0
X-Gm-Gg: AYBFou0zbowuNlKHq/tcQ/4PMQR1PfJ8CqJHQ2/KmPD7KbK9SBLuduQOhv5LEoaCXxg
	fU49IC4r9zECqYQGlvO9TUoltZhRJ/EHkjnuZNaGjJUvtSPDgiTfw9LP/Y7tQ+YklWZFmLFGg1d
	7MJ3xtGPXGMrRGTUdaXhNLpzDFqZ7fiQxQE5mY7M7/HZrkpCYfF8h6uumLsSZdoapbjJXCE1hJ2
	VFsyucDiLlNX0ut0VcIVX27Zd5SFTMt45EV+ibsu1DJAeB57OLIXmNpQJzFVf8IO8Pit0Ho3ZU4
	31QBrHq3X2unJcTzHkwUlZp4Dty8oLuTmK5IqVPyYULKtcSz9GiOjFHQX3i1trJ7GF599V/4ohr
	S9zcPUTNmR0dVBX5IGJlZqCarmFm4nPLq/9nc/E6duXijLIEv2vtJ27jsA5/BJS/U2Fsp0kLyA/
	kd/2eZVdt65xwCm0Qdc1BcfSZWrCyCz+pjsNdmqT+7xeBpogs7XZaPZ8ezyvIzzT0JzYt+z/0Bs
	1GauiftQyybwgG+u0Gf8wKCxgin1e6bVpWyrWVJAh46yB57pxltgsvbGCTdh3zNfwgjXVsl5GZs
	qqhYviHsRm8Ij/xFK+DGutw=
X-Received: by 2002:a05:7022:ef12:b0:14d:ef19:246f with SMTP id a92af1059eb24-1ac5f36d5cbmr18049891c88.45.1793643909092;
        Mon, 02 Nov 2026 10:25:09 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:42::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm46557054c88.6.2026.11.02.10.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:25:08 -0800 (PST)
Date: Mon, 2 Nov 2026 10:25:04 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: netdev@vger.kernel.org, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] selftests/bpf: cover AF_XDP multi-buffer TX
 software checksum
Message-ID: <aujU8-MBZ9LrhFMd@devvm16445.scu0.facebook.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com>
 <20261030023248.78802-3-testwrzwrz@gmail.com>
 <auT51NbSPvKJwgiD@devvm16445.scu0.facebook.com>
 <20261031013143.42509-1-testwrzwrz@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261031013143.42509-1-testwrzwrz@gmail.com>

On 10/31, Rongzheng Wang wrote:
> > Any reason you're not reading the real value from
> > /proc/sys/net/core/max_skb_frags ?
> 
> The test wants to exercise the maximum supported number of frames, but also
> needs to run on every build. CONFIG_MAX_SKB_FRAGS ranges from 17 to 45, so
> using the minimum (17, i.e. 18 frames) gives the largest bound that works
> everywhere. af_xdp.rst documents the same limit:
> 
>   "For copy mode, the maximum supported number of frames in a packet is
>    equal to CONFIG_MAX_SKB_FRAGS + 1."
> 
> xsk checks MAX_SKB_FRAGS directly (net/xdp/xsk.c), not
> net.core.max_skb_frags. I also set net.core.max_skb_frags=4 and ran
> xdp_metadata; it still passes, which confirms xsk does not consume that
> sysctl. Reading it in this test would not tell us the xsk limit, and would
> only reduce coverage if it is lowered.
> 
> CONFIG_MAX_SKB_FRAGS is compile-time and has no userspace interface, so 18
> frames is the portable upper bound. That is why I used 17.

Sure, people can set max_skb_frags to < CONFIG_MAX_SKB_FRAGS, but I
don't think we are gonna do it on our runners. So for the purpose of
this test we can essentially assume CONFIG_MAX_SKB_FRAGS ==
max_skb_frags.

I'm just trying to understand whether on the builds that have
CONFIG_MAX_SKB_FRAGS > 17 we want to exercise all CONFIG_MAX_SKB_FRAGS
or we are ok wit just 17.. But we probably aren't going to bump
CONFIG_MAX_SKB_FRAGS on upstream kernels anytime soon..

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
