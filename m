Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500825;
	b=zbz8fWo0t9E0R74wzy5luKdJr8bJ129KM6elNtCWb3LWfwtx8E3z5VR9qFfQjmP0GzR7
	 SnGEq/jVuKcVf7eQepRvWlUz/yBws7rL/zVSN/sV7uEzVddzqpvXNaXrTd1Ycy9Z44ANF
	 1u/zkFEykNfzCG19iOIHFezYUl763gC24dedZ0aN/p39PODC6D/DcA9jb7H5xuhXjmnlz
	 ZMMpTALW7tOlP8jgBKmiQD83Ct8c3PrOWAKtWvAOWpVNfs57mxfXTh1NgnHiKY5rojAYh
	 i3D3Gv6tLW1G9x/SHH8gwqvi1RGDXnxbBPqKLHJsD9vVelMThc0x889soVbFOtqdEWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PHhSiGv7NsVrVBKhJQlP69zE0Ua2+MTZMk1VrAIO/GU=;
	b=qLbFm6h1o6jrUt/dF8T5M8r0UQUBnC8aNQQE5LGaEzfoFTAfvfNtLUatH/7yA7IH21E3
	 /xfw9qnAytCdZBLyilVpqyUkto7VF0xcshal9tv4IRb7QwJr0HXJEVAocgImW8a14xqaQ
	 DdX5pzfz5rWiX6EVpK+AYhMRJPhFyl0eLRGMJcRZ8iYLomIYBid+FpG8SpNmVzjShJmNo
	 XHH/WENyxmQriSi9StAoS4Iq02O50GHqv8XfuJDrDZ62HgcOUkKep+JVi17e8F0t11Tlk
	 ZotxNmjJP8q2TZs3oOh2Zqy/3oX+GdhMuqkLSlu+8ADbnfjRe7EzTcaVf2VVYuKTSqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l8pNXIPd;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F314606A322
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 12:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F314606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l8pNXIPd
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b203527bceso3934619a12.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 05:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792500824; x=1793105624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PHhSiGv7NsVrVBKhJQlP69zE0Ua2+MTZMk1VrAIO/GU=;
        b=l8pNXIPdPKgh6DgFmINJfHrqdYV6b/OPNuQDuY42FxvFthp5pNYGUeDZFIoYiWKOmG
         vFhQ3Fs8VPQuqk/5oA000CQ3bU+1qdcggTd6nDOLRaK/TgQthZsLvJ9BG+uWy2UrSKNM
         O5BvXzKyIZsddoFNqjkssqVLkNxrzCiWKsm69+PY1tjIYCgUQZmxYp4TSohTW3YCavzF
         0YwZgQbHw6ULGc18Kng4THpCsoMyDp1sne/c0hPJpsqqrKzMv9DFnyjrJOfa7HQPE9Ga
         G85Yz7hwnfBgAmF7xHyNitDWBeMyjK6ClyL9o89gctv8vFJ33LIJmd2OBDLbLen1YF+9
         6HXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500824; x=1793105624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PHhSiGv7NsVrVBKhJQlP69zE0Ua2+MTZMk1VrAIO/GU=;
        b=v1xPIOpIgAzO8tmDhFDtFGKOAf6RUVcV8IJ6ahwr4yk27bN9jp/NGrumfrO+DiAnN3
         sBxX/roDTQSc9m4f1qvOm6BEBB5g127/2grjbNaZMR4EhbAzdFBTgpYAuLL+ceY5BKhl
         jKh5Z2gB9AF/iplJ1IZ3/0zUJJmgATGuiPhO8Cl+z1OLby/IZSE9Yfqzj+MaIh+Mtr7Q
         P3nDK70beEN4p3AIgiLmIb67XKufwMHLF4AKfAvGvLnQKimdELkQQhBvG0E8qTTejsOB
         3IapVQvqq8tptBzLX9j+9o19F6wa3lf3kA00U6Iq+4IWh83KSpbYYPdGUvfstbuBncbk
         TeRA==
X-Forwarded-Encrypted: i=1; AKwUvBy8lB62iv7BfK3H51GydYym2RIZu4Qh5RR2D02UL0YObmATLNi04/NHlerVhl2kz+vF//5+804=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMrxYQ62RSfZ6rM6AP0rqBi4E5jLDyxwE+GMwji6YrLBD2OL6+
	TqhJP15eVIHGfbalitMp8K7Sgnlz487gN3BgHcj3clXyBqEJQP23fpfq
X-Gm-Gg: AYBFou38ab3EF/pRkqqj764glD+ugQLAxjPhMjIUajaPTxeKxuyLa3Cpwnn7XJKqrDA
	AmkHYdAF5SoUEaCbVtdLyqryvFv2Yrmbf7NgO7pAVNTiZt+DLrnonHOvUB3cNucTPQWtEnvVI7O
	xorqqoLHzDKsW+1VFsMAAfaQjqx6nMpbIBXUaQO4EqNCV8ugqgb52pF3fx9J1H2oB2avZ6+nZsK
	PDsFDGOQrKHxhrpgccdd6tZ1I+qDgMlOsxe0RcImrfQhe9xahCg7p9X3QTb8U5xJ7nkYMFqs2jd
	d96PHB3fcWDP6UYelLRPGNoY/427nUgu2aeqGSRsx0FPnpX+dLUCx9KmaAiJQyEiTxiG+rW8vxg
	An9h8pwKS1yOf1j3YP2xoK5av4LIXUHCHKt4+B+Qi7PA3pyeE74Fbx+910itnD6lxo3bu8h3N42
	t/U/8bqVB4fOfW9BFELib4bCf954pfWd9weXBBWmSwd6wI90UAlBaqmLZl9jRGMuvL
X-Received: by 2002:a05:6402:a518:20b0:6b3:e575:f4ed with SMTP id 4fb4d7f45d1cf-6b3e575f74dmr1272971a12.21.1792500823260;
        Tue, 20 Oct 2026 05:53:43 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:4a::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1335d3sm5347046a12.3.2026.10.20.05.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:53:42 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: Boqun Feng <boqun@kernel.org>,
	netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Bart Van Assche <bvanassche@acm.org>,
	Davide Caratti <dcaratti@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net/sched: don't wait for RCU when destroying qdisc lockdep keys
Date: Tue, 20 Oct 2026 05:53:35 -0700
Message-ID: <20261020125335.678200-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <atZtYi_Xnz27O8Bp@tardis.local>
References: <atZtYi_Xnz27O8Bp@tardis.local>
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

On Mon, Oct 19, 2026 at 12:20:02PM -0700, Boqun Feng wrote:
> I think my concern is still valid: for lockdep PoV,
> lockdep_unregister_key_nosync() is an API that users have to use it
> carefully, because it leaves the unregistration process in a stage that
> you need to guarantee that the lockdep key reclamation is delayed by an
> RCU grace period. Or in other words, do you have a way to prevent a user
> from doing lockdep_unregister_key_nosync() but kfree(key), or some sort
> of debugging to find a mis-use?

Not in this version, but lockdep could catch it. Every slab, page and
vmalloc free already goes through debug_check_no_locks_freed(), so:

 - lockdep_unregister_key_nosync() records the key together with
   get_state_synchronize_rcu() in a small fixed-size table;
 - debug_check_no_locks_freed() warns if the freed range contains a
   recorded key whose grace period has not elapsed yet
   (poll_state_synchronize_rcu()), and retires entries whose grace
   period has;
 - lockdep_register_key() warns the same way if a recorded key is
   reused too early.

The table is empty nearly all the time, so frees only pay for it during
bursts of unregisters. A correct kfree_rcu() or call_rcu() free runs
after the grace period and never warns; lockdep_unregister_key_nosync()
followed by kfree() warns on that kfree().

Would that address your concern? If so I'll add it to v2.

The other way would be for lockdep to keep the dynamic-key hash nodes in
its own storage, freed via RCU like zapped classes, so is_dynamic_key()
never dereferences caller memory and lockdep_unregister_key() needs no
wait at all. That removes the nosync API, but it is a bigger change.

Separately, two corrections to the cover letter: please ignore the
stray "From: Vlad Poenaru <thevlad@meta.com>" line (Eric, sorry for the
confusion; the series is from and signed off by vlad.wing@gmail.com),
and [5] should be:

[5] https://lore.kernel.org/all/20261019170601.805087-1-vlad.wing@gmail.com/

Thanks,
Vlad
