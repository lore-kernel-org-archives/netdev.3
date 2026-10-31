Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793414367;
	b=ZO1K78xjESVLiVLMFiDQCp841ZhNeGkI9r+nXdT2TUfcoxW3E/Wt89km5XOC6yY/DItC
	 jJ1lGidQk2bYjEFqEt/fhfYMVOv/XQzDwg1Q5CI0kbpEmfH8WfZXBYegOhTevJNji7mXR
	 DrOTb5uEQl7x50g1dS2gx/nAsgT9Wc4IPID+ztUzWftwGUuoFKfxaNBSrrB/mJomN/MGo
	 kI+mzjhE8zDJD+MIUwHC7gNNeKk7EH3UWMfWSrp4X3uvsgDRSSMKOsgen0nd4T4DPbolF
	 60kh4wcTL7MGLOY9iOAa21iTsmG6YhXKVfoI5jB6Lcfusw0gCIT6qoNpUi5VZ7KsIgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793414367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=gVc9TPj/IZ8w9n5WydoWXS0s1Ds7y5JXsgUbicbXJYI=;
	b=SBE/+jxgF/qdQsUgIhT7xCGyHj1IOPtvNK03nbkLCTjHiRgXC6mjOznU35jmF7sGc5YI
	 Pm2igW2/lEK/IfwmtFXIG/2PdqREOQ+AWyl8oZh+oc6DCyGx4qpgml/B++zCNs+U997T8
	 4H9ASLUAswBE8BE24eKboiFxHUBgBXGkPDhmRYr3fErK9VAwDXvL6o24gVZTtCF/BxIOg
	 rcxKknC23Jm0PHoGMc8QvyOFHFoCI1imubgPw79PSNWHy1Tcx15NKprQUjsLpIprONUR5
	 2ISRi2OI5gWPjK1Aix+zHCcCYllDEQlbmL2JWdfnpWTJdX6baSCQZ/LlyQDGcYY0p7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MBVj60KG;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FF2606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 02:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7FF2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MBVj60KG
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab67ff8ec3so912060a91.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 19:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793414366; x=1794019166; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gVc9TPj/IZ8w9n5WydoWXS0s1Ds7y5JXsgUbicbXJYI=;
        b=MBVj60KGgHaQYZ3+ECHf1GPcKDSZUfnm5AnNmCKn6HW1PEcXTIswuuYwcrQ6uj3NTh
         HJMoJJCVEiVVFjGokuOqhQNqA1GC1SqjhLwYXjN4Ygp26IkqAvkNbRVY4+QgFsL3GtAd
         I8WCpx0pifPWuxBB+hT20sXfJ6otXyyCzAsxfH1HRs/uB0yfpUFjiTfvA2rRXYbTl12g
         lCy/PO/SNI3ZJyd9fj66HSQMCQi5Ap+13kXC0fvPk6GS5uybLXWykpPc+tA0NZ9rmTjf
         hEOX4GlB4sP8HXMqUw86zoumHDF4EM+AbIznAIz4/WkY7YgVB9mU7WrVGaB5RnOO8YAZ
         mObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793414366; x=1794019166;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gVc9TPj/IZ8w9n5WydoWXS0s1Ds7y5JXsgUbicbXJYI=;
        b=m5gAFf+zG8yiiASUSp5UhTW23Ua29b0utdXBp8srQ2LFQsqxfqNivhTw0DwzgBPNQJ
         mkwQpfuqwva+h1ZFZv8CmSmQnIQN91m1x3ouQ1eeH7EH3eFuOdy/ZKmzSG8IJyK26uch
         VzU3aG4/+R61UAp2omzfxY3SUFWQjHglMyn7kJ5uMsBfNsm5l819YGuajWZr8U5NGpPC
         f70jHMSoRv85QQVXhJXWMgKgSo7my3BnMIZlPkstBd8faKlPUgKYTEuUBaniJfsWSh4r
         1AmWopOC0s9IVKK3WVjaeDyinF7NipPjJzuTCyRDa5UCAB/z2xWggL5nbzZ/mMbTBmK+
         KkRw==
X-Forwarded-Encrypted: i=1; AKwUvBxMKnellkrX+BSCxEL8tflM0do1euzleA7pfk63gVYebq8CauwzeYFjKJONtuNYRj9z23kUTYY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKu1FyJ4VEecP88AdpeXv0A2aGcltJYz5M9LHQH0HpY63kC+lNc
	cf+7kRxsFjfmoAhOw71picMJyu7C1u7Ht4Sw+D3JHap4xj6EkGE9U+o0yuiPDLuSCVaROjFF8kZ
	se3hMvQ==
X-Received: from pgby23-n1.prod.google.com ([2002:a05:6a02:6517:10b0:cc7:4919:5ed9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc3:b0:3a0:b312:1fbe
 with SMTP id 98e67ed59e1d1-3ae897cfe51mr3298740a91.23.1793414365763; Fri, 30
 Oct 2026 19:39:25 -0700 (PDT)
Date: Sat, 31 Oct 2026 02:39:25 +0000
In-Reply-To: <20261030075843.2567707-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030075843.2567707-1-edumazet@kernel.org>
Message-ID: <auVUox0QAYELIm3b@google.com>
Subject: Re: [PATCH v2 net] tcp: wait for TIME_WAIT teardown before freeing
 per-netns ehash
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Fri, 30 Oct 2026 08:58:43 +0100, Eric Dumazet wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> inet_twsk_kill() removes a TIME_WAIT socket from the established hash
> before it finishes using the ehash lock, hashinfo and bind tables, and
> before it drops the death-row reference. A running timer can therefore
> unhash its socket before inet_twsk_purge() reaches it. The purge cannot
> synchronize with that timer, and tcp_sk_exit_batch() can free the
> private ehash and hashinfo while inet_twsk_kill() is still using them.
> 
> An unprivileged reproducer using user and network namespaces, a private
> TCP ehash and a FIN_WAIT2 timer triggers a KASAN slab-use-after-free in
> inet_twsk_kill(). The allocation and free stacks point to
> inet_pernet_hashinfo_alloc() and inet_pernet_hashinfo_free().
> 
> Wait for an RCU grace period after purging the whole batch, if one
> netns in the batch uses a private ehash. TIME_WAIT removal runs with
> bottom halves disabled, so this also waits for removers that were
> already invisible to the purge. Keep the wait under
> tcp_exit_batch_mutex, before freeing any private hashinfo.
> 
> The same window exists with the shared tcp_hashinfo. There, the
> hashinfo memory stays valid, but tcp_sk_exit_batch() can decrement
> tcp_death_row.tw_refcount from 2 to 1 before inet_twsk_kill() drops its
> own reference. This triggers the WARN_ON_ONCE() in tcp_sk_exit_batch(),
> then a refcount_t "decrement hit 0" warning from inet_twsk_kill().
> 
> Adding a grace period for the shared case would be costly on busy
> hosts. It is not needed: struct net is freed by a later cleanup_net(),
> after the synchronize_rcu() in ops_undo_list(), so inet_twsk_kill()
> can safely drop the last tw_refcount reference itself.
> Use refcount_dec_if_one() and only warn if tw_refcount is not 1
> after a grace period.
> 
> Fixes: d1e5e6408b30 ("tcp: Introduce optional per-netns ehash.")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> [edumazet: only call synchronize_net() if one netns in the batch uses a private ehash,
>  use refcount_dec_if_one() to avoid a false WARN with the shared ehash]
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> v2: [edumazet]
>     Avoid a false WARN_ON_ONCE() in tcp_sk_exit_batch() when a concurrent
>     inet_twsk_kill() still holds a tw_refcount reference, as reported by
>     Jiayuan Chen and Sashiko. Use refcount_dec_if_one() and only warn
>     after a grace period, instead of adding synchronize_net() for the
>     shared ehash, which would be costly on busy hosts.
> 
>     When net-next reopens, I plan to free the private hashinfo after
>     an RCU grace period (call_rcu()), so that tcp_sk_exit_batch() no
>     longer needs synchronize_net(). This would also cover request
>     sockets and RCU lookups that could still touch a private ehash.

Sounds good, thanks !

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
