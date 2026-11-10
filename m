Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291880;
	b=v/ia9qpfDY6wEr1YQCzJkVxp6NQHjd4yVMaKdR4E3kXtgRAEtZgVxaLGOX6kE/cU35E0
	 H3SnAwTr4o1mz5JJgObPqdgLsE52Zj/nBW5kkWAHHhq6Wco1yzf7BjkOtMdjknmYnyO+i
	 xyJz/QvJrk1LbcgZ8co/jWJA/Rk8hQmzgSZTXsFiPlq/A1cCK8UFKsU+QpvSqdw46E6Jl
	 V3NHciSms79UV3neRbL/ucw7rEOzsAyYA///4S47fDmKwfRXIicfGiX7Kw49tZHdOWN7b
	 t646lnZ7uBx66S2dGNdMjTm/fBKj+KXe6jdoazm9AAYAk5nTZhBfJKf10t665ROmG/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=rSbjohGTmaLzv3lN68e6oduMKimMiRNQXkmMYMJQwI4=;
	b=czg0UwPixYSx5O0idMoorWXinRhbW0aJaIFIC5Ym97NsrN9un6zaiJG3QtGo+pdjr1uV
	 RgPPGRcPLegzjv4HafZlkzrJUiWu2QUxT4DVE5Ut462GZde2GQtB26rUYoFuaTJa2YjNn
	 KbjsZxMYlE3tNFEC41eEXmRP2Fpd3Pn/dmAzDDKNsO8n0Gn297I2RCfNyEXBQIi2YrzQ+
	 fWETDIbtDvCBdNB/fEZ83UPiZQ0zUo+fhCpu1OOH3bdnO7s2S96ptLDte6ubJZWyoUGEM
	 Mc0EzR3cXpKibg+JAjRZUWMfsv8xNWMu5hdZ7h9Qanz2plBgNP79U3s2+/I2rHIrmhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OsVrEEOf;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA18606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADA18606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OsVrEEOf
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b0a098dbc7so1453570a91.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 22:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794291879; x=1794896679; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rSbjohGTmaLzv3lN68e6oduMKimMiRNQXkmMYMJQwI4=;
        b=OsVrEEOf3qbgCmIIFPtZwAb0QRzlsa22A2s6PU4uHpcjdo7eQcXO2625gIWkENuukB
         rkAaWMtfE3AsqJ34id1Xapj73d60ZZYVQ+CQVZUkP9eTKE98r5hrcK2JjSW+x7Z1rCT+
         cP8DuQOnk1o6qjvrT2ynmNJOIEcIlXXpWkAWVuZK2tzLpZKO87oqhiDxAH3PdQGsdRum
         TGWSzhDXGavcv52FejiB1S3PtfLJb4NHWZxxlp2dlCz4pSM5W3OissZlLqSoM5X0EAfw
         RtEQJpUpX1WdnoBzmSiqwfMJOoMy+6z2QImBXe5ONZhoAZwi0S6XJ+mXY/fk52PGzYDe
         q7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794291879; x=1794896679;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rSbjohGTmaLzv3lN68e6oduMKimMiRNQXkmMYMJQwI4=;
        b=Ao/4OQmZOJ5gWZ6BT1njTQ8W+kEmBymE0BQJOcQcSVlY9xJ7IekDMQA/cBZCXwDXAG
         651dtor8iFvh7fL2rM7ZrQ/BkL9eygi0YNe2flbrcvv6ii68Qm0uEcY5WNHi+eN1jQ38
         jUb7zSJerNbk52MK3al0AHIS/d3APqAVJouAS/n6VifSrV+s3seIek+mumtIjxSPOWdK
         hrk5OV0J4VANLFMDZTxBadWXfxYDT6lHbhWutuk1pTk/VAumcWMFmz6I7ovrieFnEGuD
         oO72qmP9RLk2hk/WAZ84Irkrx4EuS0/JfuIxA9JHbg9JpKnT/f+37EtPhKEsOAXNJHn2
         Ifvw==
X-Forwarded-Encrypted: i=1; AL+hErGIwOVjkZXQVdD2H0C6hQlNvzlVJBS955UgxmRTFImTcd6oA6Map3aT5ZjlUOSTFYxtllEHq6A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Qkx4ZBSdgrYJdLZKw7CFc9LXwoxsjzjby0DMpeGpqezfpEBlP
	yCCKIf3qoacravUzdQ6TG+6ecpbejyUyqZ30mOR7Xs42yVSYb7DV1iExhB0QH5+s5btGW1Pkxgk
	HKhH65Q==
X-Received: from pjbns14.prod.google.com ([2002:a17:90b:250e:b0:3ad:8673:d3c9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:288a:b0:39e:4c80:f67b
 with SMTP id 98e67ed59e1d1-3b166ca42cbmr1868538a91.26.1794291878869; Mon, 09
 Nov 2026 22:24:38 -0800 (PST)
Date: Tue, 10 Nov 2026 06:24:38 +0000
In-Reply-To: <20261106084300.2029567-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106084300.2029567-1-edumazet@kernel.org>
Message-ID: <avK4i8v3takAhR6s@google.com>
Subject: Re: [PATCH v2 net] tcp: do not resurrect a former listener with SO_ATTACH_REUSEPORT_[CE]BPF
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Fri, 06 Nov 2026 09:42:59 +0100, Eric Dumazet wrote:
> After listen() + shutdown(), a TCP socket is moved to the closed
> section of its reuseport group, while TCP_NEW_SYN_RECV requests
> can still reference it as rsk_listener.
> 
> If SO_ATTACH_REUSEPORT_[CE]BPF is then used on this socket,
> reuseport_attach_prog() calls reuseport_alloc(), which resurrects
> it into the listening section of a new group, even though the
> socket is still in TCP_CLOSE.
> 
> After close(), the socket stays in that group and the pending
> requests keep it allocated. When the final ACK arrives,
> reuseport_migrate_sock() can select this dead socket and
> inet_csk_clone_lock() clones it. With a ULP like espintcp installed
> while in TCP_CLOSE, the child inherits icsk_ulp_data and sk_destruct
> after tcp_cleanup_ulp() cleared icsk_ulp_ops, leading to a
> use-after-free in espintcp_destruct().
> 
> As done in commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions
> between ehash and lhash2."), deny this transition instead of adding
> checks to the fast path.
> 
> Only an unhashed former listener is affected. Applications can still
> attach a reuseport prog to a socket that never listened, or to a
> listener (including one that called listen() again after shutdown()).
> 
> Fixes: 333bb73f620e ("tcp: Keep TCP_CLOSE sockets in the reuseport group.")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks !
