Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647910;
	b=HI+CJ5N1Jbzieu6XnmtjfW6N8EU/UIFt+8zYGWG/VyBHeLO8xQ08nqUT4iNXgfG2H9WP
	 6G3UHATjhPjytg38LT/2jqJL9l5YHfMOz3NhuaqT+3LgG4wPFmw0oU80X8avc72S81xoi
	 1mWrMvTth9mpV9hfZnAbZIeNHunD/NyDfPQC3idwCIeLl3WpE4WEaH34zs/29XNDEOEND
	 k2845gDYBJgiuR2hLJj62QTIgNH8mxxe6ofzvEfJ/FvrQGtQLsXz/0KAj6bRjgdv9PRya
	 934ofksGBxS6rcDKAQhmaIJsLlobBs9fNU9/IEGv7ChN8IPkhDf1/UNxBbbEUzzXG9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:User-Agent:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=17T5xkmwSXx3rxRgsFuuietPjSf4dCY3suvqmMRm7Q8=;
	b=zmxcI+Ir24L1btVgj12S/81Nbwu+zu///JTQksxZE5L578VPc0ZbcvrkiQvYIHWT4oOR
	 mKopUp9jAfu3+OYuvkqn5ns9bZoiBf/IqcbCEoh/zztGxYjYxLmTphcyhulDsMtPWAwiU
	 j6/GIj2qDzkE/eFXEOK12Vi2T3FxDMiFKjxjjP/UbghC9NiOWmO91XmJqwWXtixadikLA
	 lzXgNmX1HrGhxXle1Dw6JeKMOP6uX/0eKjPUePex5cJnLJg7GOT4BTNY3wdqYbLbWtcQ/
	 N1SF71r9clduL1muwSsZnQKFfuX6N/tzGHj7PkY70G1SeUzJEF+S0eaac3PMQg51S9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GdHSYviw;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32489606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32489606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GdHSYviw
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ea0efd636dso31280475ad.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793647909; x=1794252709; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=17T5xkmwSXx3rxRgsFuuietPjSf4dCY3suvqmMRm7Q8=;
        b=GdHSYviwd1X+v6uswMpn2cvWX+0O3yEy0F0a3vUT4TyQr3cNjOa4dGxmA9qY01O+nM
         fcBPAFXhQdCYYQWMVp0smvus0XCiB22mj41VippG/7buLqH4o6Dg1vOduypdzOxHMxII
         aLdrUCZXth4A6wBn6bjsJ9ER9nwTnIkx8Ic77MtpHrII2fGdzdQ+1hCwQwOvJy7T8A6T
         OGoYbFdx5jF6Z0N77KzK+bEAyaXq6CUB4O23umbcjg4mbFy1a4dDQ4EU/t51L0I/Dxnm
         xF4IkD7t/TiA52979g9R6Mfvqy5v29es/RYZOZMa8V1k19nZ7o+Vu53ExjNw/BxcR+h8
         LT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647909; x=1794252709;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=17T5xkmwSXx3rxRgsFuuietPjSf4dCY3suvqmMRm7Q8=;
        b=AUEbbE/260eFcb/uPZG1FnIRdjXWhVYKWzpvJN6Z83Evj2VvlVmJXA9w7BN8FEv4jx
         BHF0O+gX4U26Qyddkw5iBe3lb4in9GUJHYwPzAdbup3wHe1yRIhlxpePek8LKmGaxLYk
         ZsiYrw7ExqGMNkosNmSllr7H6eMXicMSXR0vLOhI2CMJC2FMheDEjgAPSFWvBcNxteq6
         RiMyGP1XEaKCdNyaH/6kdQhuqsBn3rl4sImHkgZCDWQamtzgT0IOe86z7HHvJrUanAyS
         osb2L8JJ05POUSHt6aQUNNArGRwFiikoRopAS1s7xvPuz19CihV6f1TEc1YqkKPGuQVY
         fjiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKv4sunWmEk7v3vHYofUoENN5BHoykuzvKVQB1j14ebXgYEBHWuOEHL8HYGiPn0vJIUD/dVng=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lWqVWGPCdmJ7bbPUkzV6kK/MYbI56aLBk7VpFDa2x7/UH8AE2
	4kgJ3JxzVj0uEGHaJnTmZk+uyOKXg3bUUkF9/ozMTIJF5mufLaxnDZ9nLPaJ/Q==
X-Gm-Gg: AYBFou1y1gDrycbQD5FZBmAhspWU9TUYbwBAO6vDRXz5YejYWEaIjuWkFYQzpmn6D/y
	HxaiS4uls3DkWKEDStTTB/eQ9noTwoEbiHJ9Z8CIaJ4DV7XzfEm6iYQkQ4oFlf75mHx4y6TO8JG
	77XH6NX0aK4Fo+eegi565USVeYEtnDcNBGBQj9Elw1XPkRXdcLo88Tg63CEW9oIdOuxvA/ma54Z
	ltFy/MRuVZCbsEcTWliMNPKgmq3hfi4eOTUqrnb+qZKix3VlMnd712JjWa47Jzcabn4ajnDbpER
	tcvaU862BMmkdmEJUXkQ54PhSR7N+aQOQiqkeHj78qH8Zf/SVQZGEh94ci5au0H8rcOzDB4qTku
	MKAsExCil2Grh0W28bk2zKJBVhCEdv3efeSzXU9gssxr5FFfGz7yLX3TT7AGBxuiHQdVdqQYOhV
	qfallArOjgQO15ih1sMW07vxTRlM5C9qYnODEtw2VqGy/mYcVUPPQLkL1cH5y0KwTc+z+/wBRwk
	F4nypQtSrndE81Yt7pfdQyX34+MAnXuJNKICX++o1ZburU+SnTJtVYbLSSWHN6gGzTDMkgk7dcq
	CiJUkUKdFEaBfKxcOXxrR9kv46sw7/nEHnJ7yNAdOmnfpzPtHD5cubXuSJomDhFu5bVC
X-Received: by 2002:a17:90b:3c08:b0:3a8:bd51:205b with SMTP id 98e67ed59e1d1-3ae89812f18mr9476854a91.37.1793647909469;
        Mon, 02 Nov 2026 11:31:49 -0800 (PST)
Received: from meli-email.org ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c9928d1sm510981a91.14.2026.11.02.11.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:31:49 -0800 (PST)
Date: Mon, 02 Nov 2026 12:31:17 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mptcp@lists.linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 06/15] bpf, sockmap: Give no progs to a TCP listener
User-Agent: meli/0.9.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-7-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102072112.4160195-7-alexei.starovoitov@gmail.com>
Message-ID: <tnw3l0.2z8ao1ckh4em1@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

On Mon, 02 Nov 2026 00:21, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>From: Chris Mason <mason@kernel.org>
>
>A psock with a verdict prog replaces sk_data_ready and sk_write_space of
>its socket. It saves the old callbacks, and the new callbacks call them.
>sock_map_link() does this to a TCP listener too. Its new sk_data_ready
>cannot read and does not call the old one. Thus it does not wake accept().
>
>sk_clone() copies the new callbacks to each child, but not the psock.
>tcp_bpf_clone() restores only sk_prot. Without a psock the child loses data
>or does not wake its reader. If it gets a psock, the psock saves the copies
>as the old callbacks. Then sk_psock_verdict_data_ready() calls itself until
>the stack overflows. sk_psock_write_space() calls itself too, without end.
>
>Give no progs to a TCP listener, as before the first commit below. A
>listener receives and sends no data. It stays in the map and keeps its own
>callbacks. Add this exception to map_sockmap.rst. A listener no longer gets
>-EBUSY from a second map with progs of the same kind.
>
>Since the second commit below, a socket keeps its psock when TCP unhashes
>it. sock_map_link() does not see the state that the socket gets later. Do
>not depend on TCP to keep such a socket out of TCP_LISTEN. Set both
>callbacks in tcp_bpf_clone() to the TCP defaults.
>
>Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
>Fixes: b8b8315e39ff ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
>Signed-off-by: Chris Mason <mason@kernel.org>
>Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
