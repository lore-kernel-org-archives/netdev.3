Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793548798;
	b=xT8ZqyN26cYLHt9Al6Mc7gMV59DePJQx75W+7l5tksQMO7u/sRpOnHwr4mnAEbRRWWeE
	 M6GkqMPpA1l1sKJIYROSnmiK6lud5A15vpf6HuWa2Jks2HLAwiM95dr8Pq1jH6RfN4Idl
	 YIlEVnI0ji2bkgq+w+GOLqBIoDLrjwc8xNoqqQXd4HUNXxvpwZe585O9vJWXTlAt6a5RV
	 ZH2R77JnWojW9qLdiFfGpTOuzL0GXc6Lf7oYb6qsp1yYNN1Xz0colI9IMdjTvhPc2ge+5
	 /UJvInqfxsaqqwJACfUV8R7cs2n4VR0yZbLIpBiVbSv6RC3xOVbIPcP+YUK6VSRc/eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793548798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=I/3KNWEEu6IZN+CXs23fsbkAyCG4qcqp3COErszDAAU=;
	b=STlHx7j+WK+wbaKMoAeRrfZn1B7YkZueiTNEyjA2R75DAN/t/NJ+NvZ2Yxb5xCMSFYJS
	 dn6x8ChVlJZLlfVguDO7A3ZUaSjcMXqRfgJp4l7AJN6HVacWEwRFBs8KSg8cxbmwRkevt
	 VJsRIwnwLIbOC5xuwTtA5shEFYtJihy99q3sGPRBk0GWSBsZWA+uRrLSL5Vsqm8g5wFgW
	 BegeOlwG08KtxZB9cR0JjDkOZBbcY4pGEyPStSsYkDsbKMGEAnCWstwRxoeTx3vBjStfY
	 iefSAeNx/E9pOPeoKQsox4yNScK8qpERUCBdEpz2SDlxzw5IIARN9xm6qclwBtUu7WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="I3/SxCb9";
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825B2606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 15:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 825B2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I3/SxCb9
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso1353595a12.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 07:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793548798; x=1794153598; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I/3KNWEEu6IZN+CXs23fsbkAyCG4qcqp3COErszDAAU=;
        b=I3/SxCb9r8isKAZuyi8zggBKTG9izfADqSnDe8BsNCPcv6urpOKu715L0wIp5ZDSzg
         iyOSc9qrMULYv8W9eZPP0mT8DgXreddeqZIF6ay99VMHR8MMBPYNQVs0apHttn6pQnVM
         m8XvOrnYbVE9PT2rGQ+zcJ6hu09DCZzCbZCysKlJ2V8kaSzw0l2eUSZg7efO5vRBhMry
         uYmIBNQVNioWG6TQX7giEpQn9A0cJ5LSpIxy3tKrwak1ckvOfrzgN2ZW8PAtKV2Yt0n1
         NgHSWKDrZM7JifhfuzdMLYeSbL9EPv8F6nlNeMoCKPzfCF9VfZCQBnxDBm/CbsnAs0ve
         v9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793548798; x=1794153598;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I/3KNWEEu6IZN+CXs23fsbkAyCG4qcqp3COErszDAAU=;
        b=ReU9i/vTrafF0GSLJmjiHzij3pmP/IwXNYvNpkjm5uUv4EgBhQ5TOnk0qZ3H4PQC5C
         zPeXopyZ2gn4E4Au18oDCqWtHS3YLcfoSo5nCOTAhQ2UzYd/8B55EQGitNYXXlkueSms
         N3yjjMyMa9XephCdBJ+h+XfD4L2zHCaBRO83H1rhkQv69jrWI29Y8exgc0daDaB+tmh8
         LCtOimvgaT5f9KwYY6AyM0nXW7DjbwS8nqUmfedNa/tecbuNuwn0Zq4mgV331RP4v9ny
         dSgInZmrNGoRH4lU3Hu2bXJehaQEgLd5oeN+oGR0uxv8RYfnBuYZuzDgndBGk0j1ACGw
         N6JQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsIkpvUX2AJrRZQ/x0uU2v63ZY52TphwQ7AXiKKoQmBzqMQ8tbjPkf9kbuxhEc0CmXz8Cg/KM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSCFXMXXLZAkilz1paOgMcCXUQWkq1qbiXd/BeNjFJQrkoEmYE
	c+TijygTnoy6Y3eHGsQ5C+P/0QlCLcvJ5r7LOeK5gocX+oh86smIvtr8GSz86zkKdxgiFUa4xro
	fDpFNqw==
X-Received: from pgbd16-n1.prod.google.com ([2002:a05:6a02:64d0:10b0:cd8:b7a7:1171])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a96:b0:3e2:b17e:40e6
 with SMTP id adf61e73a8af0-3e928ab246cmr6424437637.4.1793548797553; Sun, 01
 Nov 2026 07:59:57 -0800 (PST)
Date: Sun, 1 Nov 2026 15:59:57 +0000
In-Reply-To: <20261030032314.1978575-1-zhiyuzhang999@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030032314.1978575-1-zhiyuzhang999@gmail.com>
Message-ID: <audeGRiIR1JE1Yk_@google.com>
Subject: Re: [PATCH net] tcp: restore IPv6 af_ops on disconnect of a v4-mapped socket
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Tong Liu <lyutoon@gmail.com>, Qi Tang <tpluszz77@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, 29 Oct 2026 23:23:14 -0400, Zhiyu Zhang wrote:
> From: Eric Dumazet <edumazet@kernel.org>
> 
> A successful connect() of an IPv6 socket to a v4-mapped address switches
> icsk_af_ops, sk_backlog_rcv and af_specific to their IPv4-mapped variants.
> These are only restored if the connect() fails.
> 
> After connect(AF_UNSPEC), the socket can be reused for listen() or for a
> native IPv6 connect while still using the mapped handlers. IPv6 packets
> processed from the socket backlog are then handled by tcp_v4_do_rcv().
> tcp_v4_send_reset() and tcp_v4_send_ack() interpret
> TCP_SKB_CB(skb)->header.h6 as IPv4 options, and __ip_options_echo() can
> overflow its 40-byte destination buffer.
> 
> Commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between ehash
> and lhash2.") prevents listen() after connect(AF_UNSPEC), but a native IPv6
> connect is still allowed.
> 
> Add tcp_v6_disconnect() to restore the IPv6 handlers when a v4-mapped
> socket is disconnected, and use the same helper in the connect error path.
> 
> MPTCP subflows override sk_prot, and two teardown paths call
> tcp_disconnect() directly. Route those calls through the protocol-specific
> disconnect operation so IPv6 MPTCP subflows receive the same restoration.
> 
> Tested with TCP and MPTCP by reconnecting an AF_INET6 socket from a
> v4-mapped peer to a native IPv6 peer after connect(AF_UNSPEC).
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Tong Liu <lyutoon@gmail.com>
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>

This is not needed when you add Co-developed-by.

> Closes: https://lore.kernel.org/netdev/CALf2hKvp0NPVLwr=a3+jUHtPohxbra8gox+aYAfWathJnn-J+Q@mail.gmail.com/
> Link: https://lore.kernel.org/netdev/CAL4WiiqFJpmcV4=TWRpukCq6q=-729658FwGvieNcPXe97kLvQ@mail.gmail.com/
> Link: https://lore.kernel.org/lkml/20261029054136.1174216-1-zhiyuzhang999@gmail.com/

This link is not directly related, remove it.


> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Co-developed-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>

Otherwise looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
