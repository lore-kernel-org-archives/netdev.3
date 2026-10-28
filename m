Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217288;
	b=zgO4ABKWl8wsBjsfzmQikBiOnBCDo0NN8T9mzoQmHsCzdKsmmSfKPaaZrQZrcUgPhoU2
	 hNQTjepILmLp94deXD/EvKnJLHq7pcBbMJ4itaOsqz8hq9xSaXSXne8s2EIyPIvqIWBqo
	 7uE8LKNABeIM6LO8dcg4GjlZdcOhyH4zybpEKXWOtw/aIp2C4YENaDfkjbne7xzIf/Cq8
	 2TWZNDwc7WkT5jqd+ttmfZx3ie5V1evnb4b73ZKnnRS3NKgvr+k9zBwy4byuXX3NEYJVW
	 LYP0bkqwPQt3juehbMAzsJTiwxWzF3Zj2tE4P/uPwUBX3Wb1zW887gG3/pH2x3tuOkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=NGjoYFG6eOfx5VbAgTCvrbSx4Jf+Le3xUIdD1KpfQNc=;
	b=jTsbZL6+9JueGzmYFFiwNSgOm6tqEzF5ABon+XbW3kBXeXYHCQJmCebzwWTJXciYHWOT
	 W/42l+KAIuTjzrOaiNMgYs0U2EqNCN6vTOgqs99dtP9EE2gQRkCEtxX2w/4bllRnnr8zj
	 TI2CD3zA2fYBxfkZ8zm9oeuymAbFjmVWsKY4LY/b3AiGZSBrYZmSMfY5o7yC81qkGGR/t
	 afiZgkqrHPrV0k6grmK0VCZEFo2s3b2/X55yMvN/VAJRsxykwttdZt1FPNl4RSSRNNbKB
	 MrBlrOCrxD6gvC52uzad9kVbIGepo6v3B1ERNqhC7cmnDnNK8Rw1qS3sxgEIV91Ifjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ly8jznwf;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA0606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 19:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8AA0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ly8jznwf
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ae1d132d52so1283700a91.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 12:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793217287; x=1793822087; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NGjoYFG6eOfx5VbAgTCvrbSx4Jf+Le3xUIdD1KpfQNc=;
        b=ly8jznwf+AS9GiIc7xELzlcxT5WJa85Udj0UjXWZVSxaxerbfbMrocuTT4tmNbu+8O
         pvog2zxY9bRu3OXu16eVw0YUTMUet49HqbwTBkChPOeFaw2rRm85KvYFvj8AhH8GKvIB
         59O5CTy/XXxErZn/sx1fkNa36kx7CC4cUW4BptfSOLjqeCf542tpHRZoyXD/3I2Qfrty
         4FkzkvRi8BBsWN1H+RIeIEOMUuR9FF1DHxlFTTFxhogTQRoWujl/gfgU8XGN7amnk05f
         jjAqPPHqoXs8RtJtdmo9A9ziUiic2tA2W09xGUnE0daCoo2ziQ+NmLfnitH7ziJNNnwm
         opow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793217287; x=1793822087;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NGjoYFG6eOfx5VbAgTCvrbSx4Jf+Le3xUIdD1KpfQNc=;
        b=IZ0P/sIWXCIahzhWDUUqtEqGLjyQSnWyAURfdh3GX86MsbcYEJXuvkjYa4TKPzubCj
         yR+SJ/HVshA+cdkNPxz08MIIKVkIsQC/AplEGawpe06O4Miz3P1eewF5oC9a8mqjSg0n
         7Bewja/uktYeqhhRR1qqOHHSKdr+OA0ibXqGA2bW2YSwapFa/JRX0GJ3rR0egztZ4X4V
         OxuGxdZiCsIJ9It7VDHj6rz/5rBJc2PsHjMWx5CvTeIKuGxwZevWG2S0Ok2AdEfFqtk3
         1g7C5x7Hw26/KEzWE4D2tOnJvCu2Up+ysw5vwN7fxE9lgSednTMAnN16Kjw5sog1NeXJ
         aK+A==
X-Forwarded-Encrypted: i=1; AKwUvBy3qEKXGD9eiBCIokOwBGw5oYdyv2eQh+83HW0I+Um7m3zd42dv9ClBiFvkQIsH7L4gqIBuPcw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUpy1IFy5i+MGYpRkhWC5m6IW+bePkRwpyjFDSM25By4KWSuXq
	N3mMoqSBIHaZeJXcLjSupptzWDOZ1E55jcqYy69rpLbXQT0g8wldPLjImsC2HUs8z/4wNcjtOcW
	j+B2UAg==
X-Received: from pjboj14.prod.google.com ([2002:a17:90b:4d8e:b0:3a2:ae7b:1cbe])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2681:b0:3ad:8963:344a
 with SMTP id 98e67ed59e1d1-3ae58329beamr2498110a91.66.1793217286989; Wed, 28
 Oct 2026 12:54:46 -0700 (PDT)
Date: Wed, 28 Oct 2026 19:54:46 +0000
In-Reply-To: <20261028160847.2170959-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028160847.2170959-1-edumazet@kernel.org>
Message-ID: <auJS_SXcIln-iJxd@google.com>
Subject: Re: [PATCH net] tcp: avoid double destroy in tcp_abort() of an
 unaccepted child
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, 28 Oct 2026 17:08:47 +0100, Eric Dumazet wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> tcp_abort() checks for TCP_CLOSE while only owning the socket lock,
> then grabs the BH lock before calling tcp_done_with_error().
> 
> For a child still sitting in a listener accept queue (which can be
> reached via SOCK_DESTROY or bpf_sock_destroy()), inet_csk_listen_stop()
> can run in this window: it only holds the child BH lock, and calls
> inet_child_forget(), which disconnects, orphans and destroys the child.
> 
> tcp_abort() then calls tcp_done_with_error() -> tcp_done(), which sees
> SOCK_DEAD and calls inet_csk_destroy_sock() a second time, leading to
> a double sock_put() and a use-after-free.
> 
> Recheck TCP_CLOSE after acquiring the BH lock, unless we just closed
> a listener ourselves, in which case tcp_done_with_error() must still
> run to report the error.
> 
> Note that the WARN_ON(sock_owned_by_user(child)) in
> inet_csk_listen_stop() can still trigger in this window.
> 
> Fixes: bac76cf89816 ("tcp: fix forever orphan socket caused by tcp_abort")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> [edumazet: recheck TCP_CLOSE under the BH lock instead of moving the test, smaller diff]
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
