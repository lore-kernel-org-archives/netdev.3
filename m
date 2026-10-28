Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217526;
	b=Ps02kFQcRaurLxoon+EMsn2bSi3ZMUxpU3t0G3Kq5zD6t213kPPpwFJwi7i31JycagGH
	 Yq3XDUXYyUOVTt0Nyy50qC0vPFIW+mkeBNW2fjAq7HsGcFxnHYxX3Vjvx+A7CeIwDfRis
	 d7B6TNgYp2bNrpnKbzPh8Y2lkjXfa5V7yevXEXleoIOWttglRa1lkGd13Ykh8dZcXKmTJ
	 5RqKm5q9daxgSrx72UWEsMCSTyJV9ZJQUdyVQ0K7QUVqBQNY7mbi1m7HqVCjF9Jheq8GG
	 5T/PP80wN5RDoUWtCl+SrZqDrAmW/ECR0PneKKUvLg+cqiqxlCmPdP/LS/N5aCg9nvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=kJhf16MbM9soZ6ruo6c0VZZt1I0hrLqHS0qPHU/5q0c=;
	b=VxJDNaL4v6qewSM7KCqccLYgOXI9lHSrECHc4aGGRnwj55Llaqv1eLvb9FuzWvQqC3iK
	 ghF5eDo7MO4VJWyFsN+2nt3lRQmGP4udxFCOTDI7updGcwd/7U6G6HS5qBk9568RRDoRw
	 y2YABunNBrYSYqACHX+/im7RBnOHb2QXhEx1I7WXsXsfRYUccWYWtY7uTvEg2jiuuo1Yu
	 55Ct/tBElqMnyyysPIR3uJ0ua30xlKst7FJMA0zwm4hwhJu7d/Nsyt/1rhhJySSuZ1BX/
	 dRHlCcvrOGxWSYZM0sVnzwargRv3S0jfZBvruqmzlSW4EJdOFwDqD7SrqpWpBNRIxdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="LS/YmdLf";
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F80F606A31C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 19:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F80F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LS/YmdLf
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ac0ae43900so1220434a91.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 12:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793217526; x=1793822326; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kJhf16MbM9soZ6ruo6c0VZZt1I0hrLqHS0qPHU/5q0c=;
        b=LS/YmdLfKh+nsHdFMOUjepWWEoE1SvFHC3ffi7spYQoM+PWGzGlhXe/grjV8OJQfMe
         RoApIezJFmNP9Pcyk2UC9VhEXAWPjJEatF4OCnlaJiB9NbuFVdpjNtYs0RYmC8uEi3vc
         04ltG2le+AHKpBRRs0VBQthplAE6DkhMyEV6tIp/JtEWPB2Gc4iEL44g8B7lsWAzWhN7
         DFRnDL8yLsDn3YJD78YA5F09Ak1CNsCUpwmYPrz/8WDA8EAWw7X+hjEf3enSTCblfIof
         8FBGNFN9ZIVRogN3QIB3lHp+gFNBSKd10Q8l+VrQcyfJxpA7sVMCuBkmOk8K+Q37PPNZ
         YvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793217526; x=1793822326;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kJhf16MbM9soZ6ruo6c0VZZt1I0hrLqHS0qPHU/5q0c=;
        b=TYij2ZJSi19ADSjBFfeJ2Ia1ARU1j6UrFhdcbx1TGRkQIrQPKGKX/1DhgsfHuPbCB2
         Ua6uyoxbo12XBNklseJ0pouoRtpljPaHk3DcHe1JIipz2qGTuizAmRKJNQjIeAyBwi4t
         w25N9bBwjYva2mXii9XfYIuj6A2+SKRZUASWVKsHDHaR/w81S040ge4/vr1sB+I8YcGZ
         PGyD0fYor2UQGIzvrDsBZ2GcFlElisIjpVDspRuN1nv2nFu4WEJ/xV9BkZQ4ylCyOkw+
         cuolc5SgQSxyrmZzhv9NbAwHZEPe5BzjEzxfmS3W7V4Pcd6PCBUb5aEX3ACT45RPZala
         wp7w==
X-Forwarded-Encrypted: i=1; AKwUvBxNOVjj3qos9Lkj97ESxwkvm72VigcR1tpf3GNKDDZ8Y55ofdPEkug9VycLFS/xh6/nBkAeGEs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnCkP2C+lLwGME8nuPQerTMKjcAyIBkAV788tkR8PpO0Bw/NnJ
	qG1ZULde2yVTUBKrQw5WlEGQf0Tx3x8nN73jY1pCDQ1ebaJVtImj9Oe9ffKsA6NpzbrkGlqyj46
	AxYSMxg==
X-Received: from pjbpq9.prod.google.com ([2002:a17:90b:3d89:b0:3ac:3bb4:e960])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3905:b0:3ab:c370:3684
 with SMTP id 98e67ed59e1d1-3ae581185a4mr2144869a91.30.1793217525670; Wed, 28
 Oct 2026 12:58:45 -0700 (PDT)
Date: Wed, 28 Oct 2026 19:58:45 +0000
In-Reply-To: <20261028154101.2153360-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028154101.2153360-1-edumazet@kernel.org>
Message-ID: <auJTqGfwLIskvZkr@google.com>
Subject: Re: [PATCH net] tcp: initialize mapped children before route lookup
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, 28 Oct 2026 16:41:01 +0100, Eric Dumazet wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> IPv4 passive opens on a dual-stack listener go through
> tcp_v4_syn_recv_sock() with tcp_v6_mapped_child_init() as the optional
> initializer. The callback currently runs after the output route lookup.
> If that lookup fails, tcp_done() destroys a clone whose pinet6 and
> ipv6_fl_list still refer to the listener's state.
> 
> With the flowlabel list head in inet_sock, fl6_free_socklist() walks
> the clone's list and RCU-frees its nodes without unlinking them from the
> live listener. Subsequent flowlabel operations can use or free the nodes
> again. Commit 858d2a4f67ff ("tcp: fix potential race in
> tcp_v6_syn_recv_sock()") moved the initializer before ehash insertion,
> but did not cover this error path.
> 
> Invoke the existing initializer after the IPv4 fields it consumes have
> been set, but before route lookup can fail. It needs neither the
> destination nor sk_setup_caps(), and all later disposal paths remain
> covered.
> 
> Fixes: 1c17f4373d4d ("ipv6: Move ipv6_fl_list from ipv6_pinfo to inet_sock.")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!
