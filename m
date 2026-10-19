Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431460;
	b=EyWKUY2lLOSuRzmMp+NRKX3vCe9l6aCcpE6KlFtl5u5henMxYdi+XnKSlM6ajDAbcOIM
	 DgFCGcQSHh+cvlWF3cKaA30I9mw8PgGbuWhgxaDvCUc4Lg1VeOOUMhAQzLfT66jNxHgZP
	 t175VCL1VT2ESn3kXuEfkBpqV1e+/fTJ51rTNopNtGCw4r6HJdVbAbYewrE8eeRWRDZBq
	 ORcE53IY6QLuFQ1WXPKGh6iFlx6Ew771HtEW7bYk6d16upKs/9KCreZwwNPey6meqW3eO
	 3iF6+Ufh/PXqxMDmLEyoFudVyWWXi0NAu5QJOeXOuTnEUeF3f8GrwcbjaXNM5KvZSuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431460;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=3jsS+FNvhPFXRiNcpF56A9Osarqkn7xZmkyJiCqJ+Y8=;
	b=XpfLSj/32568Oy3fqUtIqdMWnLNpMHeFlVed23FcmH4dIxDIcIIgwAyLV3IMSb6Sqbwa
	 7Oj47t+laKlCwHM1203Y/cKpZlORifcMSycHfb12MAy2AYr845qsoKLTTrH+r0tJ1gOZ9
	 a5PL8vst43CH6jSk6bwEZ3MgSglBpwfGQyz0w738QBnZIUrsQG1n5ujyLJqu8DJYNXk5f
	 lrkGPSC8Lrr9kFA7nErVeyIM+VkVFfCCAaf+KVygXKTKit7n6dfTgeKiffVkzMAd+HCSL
	 mCV/4M/Rilt4rRiL31yV9eBC4TFNfp1fSKc00/NH0aI5+gaezbWj4y77CBA2P60wFiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVtcrFVI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E6C606A31E
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVtcrFVI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793C61F000CB
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792431459;
	bh=3jsS+FNvhPFXRiNcpF56A9Osarqkn7xZmkyJiCqJ+Y8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GVtcrFVImLGYgjXGyo4tFVbzGCn7jhOhpHmYHiAqItt+oOq4mQcQCGCJtYqrzui7r
	 x6ejFbKXf4Jz/emcs8KEpYgujPqft8G3Vomg/n5qrQjduZOdNqLv5+6yEGRvgY8BaT
	 ETCb2b7UH+eYgNoFg8OgH3Z3F/Ym4LFaEQQvttnu82h2ZGxcs0kGF8/mRJiw7/UhDO
	 RBCLdS9PB1ez4LRBN9ayEJryr/EQkuexa8bSlS07Z4585Fd8dQigCexiQokya+RT7W
	 1G4QM6EYEgaqaAIf7ppI41wH2nxIngagxVISYa9rpOLY7ridgqQ75eXp0NXM8bxQs5
	 eUoOBvY+VyUgQ==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-704597ef1d8so645295eaf.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:37:39 -0700 (PDT)
X-Gm-Message-State: AFq9FYJ4fDerfwPhTLtyU4NoaiPJd3Kk5EakvkhXK1MVFDTwBngqJgNW
	anPI7Y8hlgPgngKOubBWqsKbBjDdlZm4JnO0y7InkE4OseeTVqnbX4WcOkHa1KZTOEV+PF5oXa6
	BBjh1sjBHS1wGGpuSFowBg9T1ztQlOLU=
X-Received: by 2002:a05:6820:8cc:b0:6dc:99b3:2efc with SMTP id
 006d021491bc7-70356392c96mr5105426eaf.43.1792431458807; Mon, 19 Oct 2026
 10:37:38 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019170225.729789-1-vlad.wing@gmail.com> <20261019170225.729789-3-vlad.wing@gmail.com>
In-Reply-To: <20261019170225.729789-3-vlad.wing@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 19 Oct 2026 19:37:26 +0200
X-Gmail-Original-Message-ID: <CAL4WiioUPnMxAkoGWxpAT7AHa8-_Ep+Kvhugxib-ZznqCzTvRw@mail.gmail.com>
X-Gm-Features: AclHuK_6szSoVVhZVQEh44AAfITVZxXWoYCC47ElAK_YE8jC0b-RxlR2q8JjGZk
Message-ID: <CAL4WiioUPnMxAkoGWxpAT7AHa8-_Ep+Kvhugxib-ZznqCzTvRw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net/sched: Don't wait for RCU when
 unregistering the qdisc lockdep key
To: Vlad Poenaru <vlad.wing@gmail.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	Bart Van Assche <bvanassche@acm.org>, Davide Caratti <dcaratti@redhat.com>, 
	Breno Leitao <leitao@debian.org>, Nilay Shroff <nilay@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 19 oct. 2026 =C3=A0 19:02, Vlad Poenaru <vlad.wing@gmail.com> a =C3=
=A9crit :
>
> Since commit af0cb3fa3f9e ("net/sched: fix false lockdep warning on
> qdisc root lock") every qdisc except ingress, clsact and noqueue
> registers a dynamic lockdep key, and destroying it calls
> lockdep_unregister_key(), which waits for an expedited RCU grace period.
> Replacing an mq root destroys one qdisc per TX queue under RTNL, so a
> single "tc qdisc replace dev eth0 root mq" waits for that many grace
> periods, each of which IPIs every CPU that is not idle.
>
> The wait is not needed here: __qdisc_destroy() and qdisc_create() free
> the qdisc with qdisc_free_rcu() after unregistering, which already
> keeps the key's memory valid for a grace period. Use
> lockdep_unregister_key_nosync(), and free with kfree_rcu() in the one
> qdisc_alloc() error path that used kfree().
>
> On an x86_64 KASAN + PROVE_LOCKING kernel (64 vCPU KVM guest, 64-queue
> netdevsim device, 214K lock chains) this removes 5.3 ms of grace-period
> wait from each of the 65 qdisc destroys in "tc qdisc replace dev eth0
> root handle 1: mq".
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Link: https://lore.kernel.org/all/CANn89iLvu_ijSV+FnrZ6qei_Ty2c9V-RjwLMk2=
4+oOS91bNjaQ@mail.gmail.com/
> Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>

Note the cover letter has 'From: Vlad Poenaru <thevlad@meta.com>', so
this SoB is a bit confusing.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

Thanks.
