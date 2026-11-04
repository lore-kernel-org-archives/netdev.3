Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776012;
	b=Mfsou9uYZLHc+XUbdIRORdXjUBjlinyhkuRyCI+Q2FusBsGB0LJKm+hoAXedKznZI4sK
	 p0smCwcD+W7GPyPzr+5EcE0E87Ifoa+zxaACp21pGBqLt4hRcC37dEydeSuQNbseo2XHV
	 JyOSOWkV5Xlrus+xgY0VTzLPXxM7p3Xxs9kvzLL5f6NELJgOzoPXr/LF0ksxdVR3aCOKN
	 7JHHjoTZfDzR9Qlv+oCZVONl9CkCdq/B1vGzSQJy5z6Jjq15o7BiGFE1y+wHz/aEy1Xm4
	 4/aPgJuJDu4pLcXFRIk2GkvKdNxl7jsqRN5hN10qFhUgfraSsKmnkMJHkpUPFZ5VU3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=QJzESvD8vuME65W2GcPr8N8G0TWw7wsApf01g/in8yQ=;
	b=FDhhJeH9MP79B8x9BCZ3nfDkRj8+t9y8NQw4ZdsisiY9nBJq1JRY9H21epRfI83TpcRY
	 85WPeKkxT7ptMV7ismPzg7Z3bocHZcMQd326TqSG3w794J4EOZOQPkz7B1/xGbCyLbX8n
	 e1bweLMxuMrX+MhrlMo4G6blxZbpCChuOiStswqGjLLO99ebVYbCgD90S7dC5Frw6YRz9
	 barodg7De2kvDL+rWblSKfA6T9XVOrMvXUznzFb1VzoKXePLhSmrY4r+SJj1a21tUca+5
	 0EL27Fay7q9KST08mqy4NRqwNAxAJcK2DJ/j6K3YnStqYTiFzDBO/zTRzv+5i8HhUYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gAI4SmBo;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAC1606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 07:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AAC1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gAI4SmBo
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3adad90c894so633882a91.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 23:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793776011; x=1794380811; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QJzESvD8vuME65W2GcPr8N8G0TWw7wsApf01g/in8yQ=;
        b=gAI4SmBoPAmQd8xkI63BehgOf9VmvmdMORskjRU8iTNIhgN+EsaEzLRugabzGOW27c
         urkNRX011I6DtdW67DVHiEV0sjsvotP2u7ubTCZysu0jdEiUGx4QdVX8Xx4hBlHJ3tlF
         V7xkn+utKsXbM3QG+wxqg3roKcxpxpwhVQq7tIwyQuVUDBmLw4RGu4IPbTUMrqGK9Frm
         vs4r8oA7fGS7r2t1pLbIh9UIlcHEBJ9G9Q3fE2/ammTdbnoHaLeyQHr/itHktb+kdahy
         +f7SjwiMrrHTeszTXcgj2gZcXHoPpC8/OnSj+AsegoaFaCvRMp8Bv8byV6MFvclH/JlD
         UIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793776011; x=1794380811;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QJzESvD8vuME65W2GcPr8N8G0TWw7wsApf01g/in8yQ=;
        b=sxqP8IgKwZ5OfyrYajFjgbFcCMysWMdAl0G+xfT1y4LQWSWDbS4VEDLPbouYJoD1BX
         NC23PZHXTc2gv509pK+TTgzMKR4xwasW2cgGigDvU+ZtWxBCawOiwegQV1iTzt7IfTtL
         1HkqZOQu9L+/22LqRMzI907f4wNepwJb+pr4PHfejlcpMfEW8tHdVUGyDJuIUYT0hw6h
         LFCwk27MgpPJrSvHM00qnkSo6XW62Dt0g4E6C8VNDgq+v21EF5UgaCmevklF35AOSZax
         9wNgm4tH3dM88F0bwlHJb7IlBSNJMW9RFEDe1RgHxSQ7ip2Dvf9mpbO8P1WN3gMcVFG8
         yGdw==
X-Forwarded-Encrypted: i=1; AKwUvBzQAgEhriB4WRd65JW0WFdj9t335X7kFsZ8zrJq7yjGT3FXhNjED+kw/t3sFFyAbNiBVKuPciw=@vger.kernel.org
X-Gm-Message-State: APuU4Z97IPl0CXZW9kAaSANMfB9avrbrq3TNdvLCxNfGHIdiQvNKXCdI
	Q2Yx/Flq6pT02vXP4EpygIXYPkJCNB2cfKEzOO+JiQQ9eM9A+dyv6YAUOB0E8bO1NndlgCyHCyV
	49a3liQ==
X-Received: from pjbkr3.prod.google.com ([2002:a17:90b:4903:b0:3ac:24b3:3484])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e81:b0:3ac:8fff:5a1b
 with SMTP id 98e67ed59e1d1-3ae8982ab40mr13181199a91.34.1793776010617; Tue, 03
 Nov 2026 23:06:50 -0800 (PST)
Date: Wed, 4 Nov 2026 07:06:50 +0000
In-Reply-To: <20261103090011.4128420-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103090011.4128420-1-edumazet@kernel.org>
Message-ID: <aurZeKTs2w_MbMcs@google.com>
Subject: Re: [PATCH net] tcp: ipv6: free ireq->ipv6_opt after an RCU grace period
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, 03 Nov 2026 10:00:11 +0100, Eric Dumazet wrote:
> ireq->ipv6_opt is only set by calipso_req_setattr(), when a CALIPSO
> NetLabel mapping is configured.
> 
> Request socket migration (net.ipv4.tcp_migrate_req=1, or a
> BPF_SK_REUSEPORT_SELECT_OR_MIGRATE program) clones the request
> socket with inet_reqsk_clone(), so that the old request socket and
> its clone share the same ipv6_opt, then reqsk_migrate_reset() clears
> the pointer in the old one.
> 
> Another cpu holding a reference on the old request socket can still
> be using these options, sending a SYNACK from tcp_v6_send_synack()
> or creating a child in tcp_v6_syn_recv_sock(), when the clone
> is freed. tcp_v6_reqsk_destructor() frees ipv6_opt with a plain
> kfree(), leading to a use-after-free.
> 
> Both readers already run under RCU, like their IPv4 counterparts.
> Use kfree_rcu() in tcp_v6_reqsk_destructor(), as commit e3f33b0a1d89
> ("ipv4: free inet_opt and ireq_opt after an RCU grace period") did
> for ireq_opt.
> 
> Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/179369559062.488856.15441115725436277776@kernel.org/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
