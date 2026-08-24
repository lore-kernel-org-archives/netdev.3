Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D83A2576
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560254; cv=none; b=TN83j1qK/wyPkYKwmtKc/Ps4LE8tfQuyZITol/LSmBu1bvzf/v0Plk4s2RkslFY4iXqEJky1FYrwfLzxS56lGIhNWgjXmSbcpAETKsit5USwWs1tIUBjFpGgnSv2yopwpLmzlku2Up4VCgK1Vg/hUtlCLmfWPhxy084rVWMl07c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560254; c=relaxed/simple;
	bh=NtQOIzywrQYZKh4TH1+rGY8JS9R261fEuDoFEh7TB+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmvfVumBf8h1a45x64ut38XnlKPRMCirgLU2S+g5HeOkH2ExPbBp/6L9ebTwfyAFC4bjNPlNqwKKSMKCcXaJJgMCLxreu83AO/XnR8qvqGwlu7tsjubsScAFhOo5ryo939QPQ94SiOWHikUOJmMbOF+Pka4xuAiZkMWeWJX7vII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csepg2Lj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csepg2Lj"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f7872abb6so1723339f8f.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 01:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787560251; x=1788165051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kOkT3X+8KY9WWJ0TJEDnmjUbILoTSgAuXbLKWjGkcEs=;
        b=csepg2LjDxDlBk/5bqGJQC1GA7vzgMQIqyRMBNGTEr8rMoK0Hlb9ojSP02404jRqpI
         gZdKGIM52wVIoRMpGETPwuwo7dHRig1Mtl4EZn+2UhNt9r9W5qxd4pzGZiSQO0chxE92
         HDKDHo8aGudypZRdQcazRT8UsGCT/2YJAYDQBymI/109BDCAcNPpqnQxcBeett5qMeOE
         p0UxFTljvL7Rm9vih5lT8msHZkCWhheoZ1wu1fyGd5NxWuNWBHldNkVlsYLpHu7yg0Gq
         /LrPmsEhhkol6XwaALlre4JGIjE1LTKcIbswe8pXDrheJQIctO54h1ppI1HbtLNJ+zjO
         DznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787560251; x=1788165051;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kOkT3X+8KY9WWJ0TJEDnmjUbILoTSgAuXbLKWjGkcEs=;
        b=E7Spi/TzENklJWMvjdpQVrCtQp3nwRPt4Viaf8HUcCylCOt7eTY13BdwMhmu4OImzG
         LVL9rDO8GN947AuNV3Dc80AZY4oOZqgutEozuqQiCjTX4sa9D3iUuNNdmD2BYuBrslWR
         ohRnynDD8U1Te/cBT0Q0QIdV9kyA4VFE6on2juWBKxpASQ54VIxJA3p5bGrqCpIVRIq7
         uKG49rRTvz2Atxa9HtH7867miojU946MsdWtTpCyv4B0lsMNW138x0mLc16uzuQOIi5+
         v744OFAeDJDekDPbPQuQzjkco1c/9HazJ5knG8BSb4MR4h3bHrcLM5ee/cIkjA1aJYCR
         xllQ==
X-Forwarded-Encrypted: i=1; AHgh+RoOWgfv7WcQCZOLRLrpslFGmlitQpF0xiRUrHPpCC5J0thBwXqHCJ1aaLhB4/OfN4Tcz/rtVtc=@vger.kernel.org
X-Gm-Message-State: AFuF++nZshvRjAoxU1bEAQ1GTw5cjMUi9TwEuzE0b/PT7G4WUvQjotWd
	hutrdew/D04El05z9tIHb5ieIcwU/gRV30QrhJ4w2LmKqoFo2Leycpl+
X-Gm-Gg: AR+sD13LdguekS1NWt7/EC4Ng+uIsrAWZMIZn37TTqTDPjmbyusiRuV4sHSxX7GII/n
	0e3EAWBwJDeop2Ey6xb2zrw5U4BTu1EHLx7HG3CCQ2xkf3K8J+IYFpR/rZaXYi7V+2Qvq3jsCgb
	suYfRSUY2Oy/GRrB2ap3dHgFM4ZVKC3/r3glllck5yz7wXjOqSWateMOJ2iT7aK7o6qO0qfn6bg
	oozGKq5cRh8IuNgSNTqxZhSKq5DI3aoAl6W7XtoEdTNRjWWdd800RGEE6aG87+NL8wbwiY1yXRx
	2I0QseMIDTZDhMilK9PU+toDQ6nmY67QWRAAUui1OzwWxGGqHBMzXC1wOCszl1dk+7cM+tV2cT4
	IZvL+8TeEzMOyNjfZk2AlgVvHgY7nRK/eioLDwHZ3sKGH+PRCrDy/c3aIYSGc7aqFuZXfoB4ntD
	rhv1M46aLwb87vH0rjizp9idC5udPhAU1439owWb4CHN1p/SBc8FNDhlu0lXABYxL4I5TQlkiHt
	JP9WCUkyX3WTVBc2B/XaHg88NIkhOiVH9iC
X-Received: by 2002:a05:6000:1884:b0:47f:9557:8d77 with SMTP id ffacd0b85a97d-482c0b97893mr30928360f8f.10.1787560249259;
        Mon, 24 Aug 2026 01:30:49 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9b855cdsm7224725f8f.16.2026.08.24.01.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:30:46 -0700 (PDT)
Date: Mon, 24 Aug 2026 09:30:44 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ncardwell@google.com, dsahern@kernel.org,
 idosch@nvidia.com, kuniyu@google.com, horms@kernel.org, willemb@google.com,
 andrew+netdev@lunn.ch, kees@kernel.org, jiayuan.chen@linux.dev,
 kerneljasonxing@gmail.com, ij@kernel.org, martin.lau@kernel.org,
 shakeel.butt@linux.dev, matttbe@kernel.org, martineau@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/8] net: fixes for requests completing on a
 socket that no longer listens
Message-ID: <20260824093044.595dd0fc@pumpkin>
In-Reply-To: <20260824033331.1084971-1-imv4bel@gmail.com>
References: <20260824033331.1084971-1-imv4bel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 12:32:44 +0900
Hyunwoo Kim <imv4bel@gmail.com> wrote:

> connect(AF_UNSPEC) and listen() move a socket back and forth between
> listener and active session. IPV6_ADDRFORM on top of that turns an
> AF_INET6 socket into an AF_INET one.

Is it even valid to call connect() after listen()?

David

> 
> Two things follow. One is that what the socket had before the change is
> left behind: requests still in the ehash, and parent fields a child
> inherits. The other is that the socket is used while it is changing.
> tcp_check_req() does not hold the listener lock, and tcp_v{4,6}_rcv()
> reads sk_state twice without it on the listener path.
> 
> Patch 2 is neither. After a reuseport migration the listener that counted
> a request and the listener the count is decremented on are not the same.
> It goes with patch 3 because patch 3 needs it. Nothing ever resets that
> count, so patch 3 on its own has a check that can be bypassed.
> 
> Patches 2, 6, 7 and 8 are new in v2.
> 
> Hyunwoo Kim (8):
>   tcp: fix use-after-free of the listener's ipv6_pinfo after
>     IPV6_ADDRFORM
>   tcp: fix imbalanced icsk_accept_queue count in tcp_check_req()
>   ipv6: fix request socket use-after-free after IPV6_ADDRFORM
>   net: fix out-of-bounds write in sk_clone() racing with IPV6_ADDRFORM
>   tcp: do not inherit out_of_order_queue from parent
>   tcp: fix use-after-free in the lockless listener path
>   net: clear sk_tsq_flags in sk_clone()
>   tcp: do not inherit retransmit state from parent
> 
>  include/net/tcp.h        |  2 ++
>  net/core/sock.c          |  3 +-
>  net/ipv4/tcp_input.c     | 64 +++++++++++++++++++++++-----------------
>  net/ipv4/tcp_ipv4.c      | 52 ++++++++++++++++++++++++++++++--
>  net/ipv4/tcp_minisocks.c |  9 +++++-
>  net/ipv6/af_inet6.c      |  4 +++
>  net/ipv6/ipv6_sockglue.c | 15 ++++++++++
>  net/ipv6/tcp_ipv6.c      | 44 +++++++++++++++++++++++++--
>  8 files changed, 160 insertions(+), 33 deletions(-)
> 

