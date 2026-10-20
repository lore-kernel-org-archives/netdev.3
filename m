Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516570;
	b=dYCohwYVDDsC9LWY/Rr9Ry+1ddRq1ICTAJwqOrWH+127gAhuQvlwbiPO3q05me7IA7ZX
	 CupCcuhBQzvfs1QYtp8JLayqRQLlUuI/fwKZ1lPzN7HD6iILsO/9lhP+9/rX6Ko9u837X
	 sHG43DQeC58Kgw20nrXnpE0r+PA2FqBIOmQbjjsFXpHF2NLHN2UQze843D2ETajP5J+LY
	 CxhASsbDDAa3FhlAoe6ril729KLrVHVqOct/DofyzFzz3iRJnUD85fTVQ+8O6FjUPgUFJ
	 BbO+kX3DU9lt9+bhmgYtBYrn9n54jKqoz5uOsEb2jJUaM37foyiFdBl9nOfy5EOcxmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516570;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=yRtwQJoRBj8JHRW6EWWDkMp4408OqcvaN5oRuVYI7Co=;
	b=CfWe27/dwgd0DxKbChpgGFYopqgV6Lon3lRtQfzXV0b2Jw2o0oAi9viFoxpKudZjrmJL
	 tp0v1zPaEI2sDSNr+B8pMYZn7qPx/AlBcs+928yftNwt3XT+aDF2cyGpdgaTOAoMlKAYe
	 KlkI9/oYoWl0yPm9AC/artL8yuTZyPi/6x54ljVWEyYl0TonjmM1m9mZy8OhOrDt0OBhb
	 EC+8S3HdGvdjpiB8KX3sHE3Z6TVzUOun8AX+cK/qCks/46J9FoCz7wdFfSRYZRjl3NYsE
	 F9amMPJNEGsMK9kl7vzJrLly0eSMxVo5wCWgFIn65t4gQg2puaHJd3vIyQ2gDn8ESAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+CJlD5u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59703606B518;
	Tue, 20 Oct 2026 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+CJlD5u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0DE1F000C9;
	Tue, 20 Oct 2026 17:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792516570;
	bh=yRtwQJoRBj8JHRW6EWWDkMp4408OqcvaN5oRuVYI7Co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g+CJlD5umPMzG650LKD2SuygkRMNwTExREotGPc7aw0np4yBdzwQUm2cNiJCE8LzB
	 ijsH2Cd9eo9HGl5LpXYlhWFtfhjkn2tPKnEBFpCLfCo7H2j+nh/NQO94QQe/LcCeXo
	 ZbomAk78UB0TGgV2J6SGnwOZKGpIqWQEe5qY+wMchT9KeMKPtiLEI6C7jY3KdvolzF
	 F5m06aW9QlBxtGFZfoE9dkenURJ3cnTURsvBS4or4HIicN0nolNRmFHo67jPPwhSsj
	 g3DUkA0vpaJy0wqJmq79rG7ufZaGtAg5lkXmP+H9YnSQkQbPGvol7xlwKTwe2TOBla
	 E0fZ1W62lm+xQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 68DD1F40068;
	Tue, 20 Oct 2026 13:15:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 20 Oct 2026 13:15:49 -0400
X-ME-Sender: <xms:xaHXaiX6z24MEA8rzGmUGG1w2BDKM0jbBnc7f8-muQR36aL6wDE7Lw>
    <xme:xaHXamh2Xb1Sw0FeXsgn3r20Ti85WiYGr1R2ytMT_zPJt1vBdknwmcUd0xR-kX5-D
    aYJ1DEiAgp8MBeFSXy7HagSSwE8hdZWI3uXf1_TUCMjLL2HUXqJZA-J>
X-ME-Received: <xmr:xaHXatnjsgbwrBfU5B1UcG5UZfTvuiM3BvzDPpW9BCN2Qr9xhUIS-pc7csDLyYOFtdDEeX3yDtjgN9CB2XzercvbwRBRzXtA>
X-ME-Proxy-Cause: dmFkZTFHwY26Zyaya4KftCJetX+Xp4Td4MsO+2nPbR8Cync6Kyf4mAWnBlrjIVh/wTZP9r
    tu0/SbeU9bYdaa3nmrQhX2W+/B8bH8JeYeAhFQcDfTnEi0SvySnHjf3VSWtXimffT14tjG
    WASXS1JKkVdW2sEgdKinhjinsfayYBrS1p7WZUga+SQxumjKjZOLt2IkmLIiB5hN0tSouF
    KGDY0honu2+BV2Xhh4sqetcJpagcCh82+U6mYoHzH6sElTORv4RWITpeajxv9eAtYyLUBL
    CXy0s7h9xtU//kKQsL1HYmxRK9Wr9Qi8KuYi28MnX5NInFb5L4EHfTSBGpXns770K4iISS
    pTCL3nQFFUjJBYkApnx7iyxEJw+HrSVsgXSR6dxI7Cnjk7SC0Ag3p7ozfQiNRpN0hVq8TP
    a/U+qBeE6lcjEeXxt1YnfeXz4T7QUYNatE1dujUGWqEn2jgynEbfh3qZfbJTTKP9UcuTey
    cR8pLnw9L5RPFFjyO1OlrsSL5RtoMW6AVTwOa2sNcmJMXk8wKgPT9NTimcQFhMrAzEk9At
    Gi5SCeLGZuHFNi6G0CUdIV1Z7mTUDiW4rFaf900Q2RsxqnDAjDxTypUP6LNmXs2I+ZdNBh
    UXJm4koKkQygFXqScWkv4y43+kKK94FnQidBV6qLb7hDAE90ljFp3UsMyFLA
X-ME-Proxy: <xmx:xaHXavxWz-F-ZhxwsOClBpogqa9C5YGhNc33cU_3ZzSpVMMHLXTJvQ>
    <xmx:xaHXaovDrdcRXil-2XXKQcHpL4-g3aMzvUYJOsuqiLnGhUo8fpAk9Q>
    <xmx:xaHXaktcheVLSZ3O6sYd7xB6M36WPi3CCCA2M7FWYwEPW-J3ghulHQ>
    <xmx:xaHXammiNsTRMQ0yLGiOM_IpVAhRFTl7wnm5AY92FngziXIoPGaVaA>
    <xmx:xaHXaitUy-QKe3WrqO8y3KvV9VFVzKf9emEDewwsIV_c7yykXzNXFQeU>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 13:15:48 -0400 (EDT)
Date: Tue, 20 Oct 2026 10:15:47 -0700
From: Boqun Feng <boqun@kernel.org>
To: Vlad Poenaru <vlad.wing@gmail.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	Bart Van Assche <bvanassche@acm.org>,
	Davide Caratti <dcaratti@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net/sched: don't wait for RCU when
 destroying qdisc lockdep keys
Message-ID: <atehw5Cn5Ev7Z68i@tardis.local>
References: <atZtYi_Xnz27O8Bp@tardis.local>
 <20261020125335.678200-1-vlad.wing@gmail.com>
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
In-Reply-To: <20261020125335.678200-1-vlad.wing@gmail.com>

On Tue, Oct 20, 2026 at 05:53:35AM -0700, Vlad Poenaru wrote:
> On Mon, Oct 19, 2026 at 12:20:02PM -0700, Boqun Feng wrote:
> > I think my concern is still valid: for lockdep PoV,
> > lockdep_unregister_key_nosync() is an API that users have to use it
> > carefully, because it leaves the unregistration process in a stage that
> > you need to guarantee that the lockdep key reclamation is delayed by an
> > RCU grace period. Or in other words, do you have a way to prevent a user
> > from doing lockdep_unregister_key_nosync() but kfree(key), or some sort
> > of debugging to find a mis-use?
> 
> Not in this version, but lockdep could catch it. Every slab, page and
> vmalloc free already goes through debug_check_no_locks_freed(), so:
> 
>  - lockdep_unregister_key_nosync() records the key together with
>    get_state_synchronize_rcu() in a small fixed-size table;
>  - debug_check_no_locks_freed() warns if the freed range contains a
>    recorded key whose grace period has not elapsed yet
>    (poll_state_synchronize_rcu()), and retires entries whose grace
>    period has;
>  - lockdep_register_key() warns the same way if a recorded key is
>    reused too early.
> 
> The table is empty nearly all the time, so frees only pay for it during
> bursts of unregisters. A correct kfree_rcu() or call_rcu() free runs
> after the grace period and never warns; lockdep_unregister_key_nosync()
> followed by kfree() warns on that kfree().
> 
> Would that address your concern? If so I'll add it to v2.
> 

Sounds like a solid plan to me. You can make it behind
CONFIG_LOCKDEP_DEBUG.

> The other way would be for lockdep to keep the dynamic-key hash nodes in
> its own storage, freed via RCU like zapped classes, so is_dynamic_key()

But this means lockdep needs to do its own allocation for the hash
nodes? Where does the memory come from, a slab or something? If so, I
think we should probably avoid that. But I like this idea more since it
won't introduce another API. So please do explore this idea as well,
thank you!

Regards,
Boqun

> never dereferences caller memory and lockdep_unregister_key() needs no
> wait at all. That removes the nosync API, but it is a bigger change.
> 
> Separately, two corrections to the cover letter: please ignore the
> stray "From: Vlad Poenaru <thevlad@meta.com>" line (Eric, sorry for the
> confusion; the series is from and signed off by vlad.wing@gmail.com),
> and [5] should be:
> 
> [5] https://lore.kernel.org/all/20261019170601.805087-1-vlad.wing@gmail.com/
> 
> Thanks,
> Vlad
