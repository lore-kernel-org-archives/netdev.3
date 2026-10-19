Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437606;
	b=29tWy7WsqzzH0DYQ7fxFRm+anE6Df3BPzmnUwftkNvqPl3FROu2ZlUpG3ZF9UoEWx1zD
	 vh1A0mvp0czPEclXa9egRX2ftEjV4jZcaUC/7eySLo7cglcDoRtX6i6LCCgB/KkXKUb/N
	 0BPs162lP0bIaWyk29Rc4IU7OdAU2w3WHKmtdLGeeJwgYJcmj3PIEnD81rQ38izxBFUtC
	 5JgQdH767wNs6IJK2bFY585wa7cbtGfv1xZS/tgOLZzmozFwl0k2tPBMQe05erc4je2TK
	 QMadWDrgtI2MxHRY9N7OgOAtpUYlUhgFzegzRw6OWLrMImcdJxtu+ZYguaLVgrLesJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437606;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=zO+gnA/zH3TgtnnSvhjEEejhW5sMVUoWa55IAHxXUOM=;
	b=DdIJwp+oZVOyxnukqcjBaTJTCnx0z/sTYImMUIdxRZoQJI1rXuKacaCcE1iO4EoFm+x0
	 o22YQPFczCbmFAj63etsxstLM13mjC/ESosqCM7YVagmx6GzQSO9UCgOh9JeXdPxpjGf6
	 5FbPQGri/NCjghckc4HrNO9nmIinR1xvSFLStXhbpJDXG1/pqy/DA0tY0In6uDeyUL4cN
	 PACB0RE/xk0EFXAKToURIo/e0cH92dqtV4is1lziUbobTtQJak5sJf/KfSWMtb/Up4KE8
	 /J3/r79lcwRIGxRb5qkL2ITqWxiw+hW6ToFFe+1vvgXfWzt2HWcaPg6DZuR+oMZbHgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Axu28bPF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19717606A319;
	Mon, 19 Oct 2026 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Axu28bPF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81271F000C4;
	Mon, 19 Oct 2026 19:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792437605;
	bh=zO+gnA/zH3TgtnnSvhjEEejhW5sMVUoWa55IAHxXUOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Axu28bPFgYP2BRLtkMkrlQclgdkZE8vKmByQnwwpQBmtRFIR3BJmVDZuaI740N5tf
	 0yIEgVAwIm098IRoqVlu5Dw19ymejiwz2eFev+qTm8oqBNkBjbyHgDmOa1LBiVQnDj
	 WiqSWhFwvpx4oXqGjh58H7m+JDWIDKBbglJojm4z2wUsLE4buyirH14OLv+gfb8pTN
	 nyXaHhFvHaXB9epTW4pXLV63mXk218f/tKIdDYAFtFs4i1bNMV5Qy+FPtm8U3O5aW+
	 7hBz5LBZFM89ueRitbp5G0rDWYR/qT+0WcbqkJCf0/76lZ4kU4KjFh+QabbuSdZ1pc
	 vUH/2tq3whk/A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 16B65F4006B;
	Mon, 19 Oct 2026 15:20:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 19 Oct 2026 15:20:04 -0400
X-ME-Sender: <xms:ZG3Wak_BGNshMp7GWjR7g9zm24EHSCF6u-Z4URA1DI0-fKX6LAZTNg>
    <xme:ZG3WaomXDhppFgOC3tA2IjvLbWdfvbxIhzk1Z_qTgb3GmdU6oV3Fn6Sc-Ua0jfwN9
    Mqv2CrnwxewrHib5vEdM7Pz-X0iBB1pZyKX0iEpkLT8YrgCBrglog>
X-ME-Received: <xmr:ZG3WaliCu71KmFemc6e0yQyMirHqxDdhTOhZpiTDDyi3GRR2ZKgVVrIy37LtZIolCsioK4z3uqbdduugzoGYjIA5ZZYlKfth>
X-ME-Proxy-Cause: dmFkZTF8ZTFf3UNlRjGNClkfsXVnsNgWaE3Gr11Yn0/q3LURBvd+276ZeQs+jq7SKTRgNa
    ZgkrU8gV7YQPAHXwqUQ2G/RZURbmt9w7KJEgTdhQ92o+WqkksKV4qbZxkkEm1TrgePSoaI
    AJHhyq+/KiPQABrS6NMsV29tRs25KgXkTDz8kdEKAn4BUnDFL0HILHv1s0XCQi2cdgMBum
    ZIcWLHJcsYspJcjg/utM221MZpKWbCn3qs9R3fTfnlR7GJfb+Kx62wMVEr/piW9kJHzC8i
    FoGyU7iJbXKbETNUOtV1AQPXu/d2I25eRii3ySVguvn8jMarrQGzmvKFY/d+QCxZnhXVlf
    Khp9rcDWYeSOi3AKJAaIooJ3Et3NWFzCrnlDVuPIpxUojH++3J9jCZXISUHwziGPQ9yf6X
    Ce/YZAaREiV85avI4zQZAZGhkEB+d63Q2lBnAkmLhMP/Vsys9+NesVkBlo7L4jkEzF5/Bs
    QHk2UUInNF9o4II6DYQ7jXMqMsLbXdKnemzoc1WNTvoMfbVC3e936mn1XsQQhsHktzMvHq
    ZFGlB/XAA6rWrVkt5S+soavGjaQMzLzoqqmfKogtVPQD/GstR/rxiSa/3AN2CjCcEw7E6C
    1kD8kUKZhYxNvNAhf5Y1l/k1nLJC54iUe57Z6JE979oPECaPSTNnPGCWSOlw
X-ME-Proxy: <xmx:ZG3WaoZ5hAy0VswBfdHGx9-QhgfQv9xbR63jMsivfha43OVIDMWi-w>
    <xmx:ZG3WahHbiRB-eTBIcPikbF3oPFRI_D0LeWMUBsFSodso1UvHEtTugQ>
    <xmx:ZG3WatYii1fN2T7IKFugiW8TQgt_xbnaQfhL1HdXC5X4ImZoxuawaw>
    <xmx:ZG3Waq06nAIsRP959KK5v54PSZZ0HN3K0QTk5Z6dPK0qDhKc9n7r8A>
    <xmx:ZG3Watcdx2ByTHn7rW3h546cY5XE3lbG31I794aCEynvq0qEkva9SjFz>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 15:20:03 -0400 (EDT)
Date: Mon, 19 Oct 2026 12:20:02 -0700
From: Boqun Feng <boqun@kernel.org>
To: Vlad Poenaru <vlad.wing@gmail.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Davide Caratti <dcaratti@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-kernel@vger.kernel.org,
	Vlad Poenaru <thevlad@meta.com>
Subject: Re: [PATCH net-next 0/2] net/sched: don't wait for RCU when
 destroying qdisc lockdep keys
Message-ID: <atZtYi_Xnz27O8Bp@tardis.local>
References: <20261019170225.729789-1-vlad.wing@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019170225.729789-1-vlad.wing@gmail.com>

On Mon, Oct 19, 2026 at 10:02:23AM -0700, Vlad Poenaru wrote:
> From: Vlad Poenaru <thevlad@meta.com>
> 
> On kernels with CONFIG_PROVE_LOCKING, every qdisc except ingress, clsact
> and noqueue has a dynamic lockdep key, and destroying the qdisc calls
> lockdep_unregister_key(), which waits for an expedited RCU grace period.
> Replacing an mq root destroys one qdisc per TX queue under RTNL, so a
> single "tc qdisc replace dev eth0 root mq" waits for that many grace
> periods. Commit 7a3cedafccf8 ("lockdep: Speed up lockdep_unregister_key()
> with expedited RCU synchronization") made each wait shorter as a
> temporary workaround until hazard pointers are available.
> 
> The wait is redundant for qdiscs: the qdisc is freed with call_rcu()
> after its key is unregistered, so the key's memory already outlives an
> RCU grace period. Patch 1 revives Bart Van Assche's
> lockdep_unregister_key_nosync() [1], with the grace-period requirement
> spelled out, and patch 2 uses it for qdisc keys, as Eric suggested [2].
> 
> Boqun was concerned that a nosync variant is hard to enforce and review,
> since a later refactor could move the free [3]. For qdiscs the RCU-deferred
> free is not optional: datapath readers find the qdisc under RCU, so
> freeing it synchronously would already be a use-after-free regardless of
> lockdep. Patch 2 also documents the requirement at qdisc_lock_uninit().

I think my concern is still valid: for lockdep PoV,
lockdep_unregister_key_nosync() is an API that users have to use it
carefully, because it leaves the unregistration process in a stage that
you need to guarantee that the lockdep key reclamation is delayed by an
RCU grace period. Or in other words, do you have a way to prevent a user
from doing lockdep_unregister_key_nosync() but kfree(key), or some sort
of debugging to find a mis-use?

Regards,
Boqun

> The hazptr-based replacement for the wait is still under discussion [4];
> if it lands, the nosync variant can stay as the no-wait path or be
> dropped.
> 
> On an x86_64 KASAN + PROVE_LOCKING kernel (64 vCPU KVM guest, 64-queue
> netdevsim device, 214K lock chains) this removes 5.3 ms of grace-period
> wait from each of the 65 qdisc destroys in "tc qdisc replace dev eth0
> root handle 1: mq".
> 
> A separate lockdep patch, sent to tip, makes the zap_class() part of
> lockdep_unregister_key() cheaper [5]; the two are independent. Nilay
> Shroff's pending "lockdep: Fix subclass resource leak in
> lockdep_unregister_key()" [6] touches the same function as patch 1;
> whichever lands second needs a trivial rebase.
> 
> Peter, Boqun, Waiman: if patch 1 looks fine, an Ack for taking it
> through net-next with its user would be appreciated.
> 
> [1] https://lore.kernel.org/all/20250203175939.3133477-2-bvanassche@acm.org/
> [2] https://lore.kernel.org/all/CANn89iLvu_ijSV+FnrZ6qei_Ty2c9V-RjwLMk24+oOS91bNjaQ@mail.gmail.com/
> [3] https://lore.kernel.org/all/Z-OPya5HoqbKmMGj@Mac.home/
> [4] https://lore.kernel.org/all/20261005171529.1378809-9-kunwu.chan@gmail.com/
> [5] https://lore.kernel.org/all/20261019170018.699298-1-vlad.wing@gmail.com/
> [6] https://lore.kernel.org/all/20260727182312.3750145-1-nilay@linux.ibm.com/
> 
> Bart Van Assche (1):
>   lockdep: Introduce lockdep_unregister_key_nosync()
> 
> Vlad Poenaru (1):
>   net/sched: Don't wait for RCU when unregistering the qdisc lockdep key
> 
>  include/linux/lockdep.h  |  5 +++++
>  include/net/pkt_sched.h  |  3 ++-
>  kernel/locking/lockdep.c | 36 +++++++++++++++++++++++++-----------
>  net/sched/sch_generic.c  |  2 +-
>  4 files changed, 33 insertions(+), 13 deletions(-)
> 
> -- 
> 2.53.0-Meta
> 
