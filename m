Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B875B3C7E1D
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461015; cv=none; b=k3MrMjRbi4FhfZwkz0qDjVenAJNPF+JsJ5YNInPI+/iCsIchngZ/vKV1NqWmcMfsNxJN7/9AeOdGILqTHCNS/0d6/+1RYAPDa/SWi5uIZqY6KZQg64jZ5VL2evwtV+bRkWkUftGSUEJO0w+YKi13HLeJT2dbPSBJmTicSasU5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461015; c=relaxed/simple;
	bh=OYGEaUQOc84tn+UWAjYrfHv+cxmGpTCjaaEPswNuzZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sh9R40a6cPIdfy8jJA1qXlWIC0YcxOi4wqmw0bdWUFb0bo3L+UV0HTyyXnYm8t0LniG13seLLl7Rvk/QWTOzgdK+32e8qLuOMNlh49xkkdusctgyODHUoJjxyWoWBZxR9DWy3jzZfA21efmDSco9k6I+2m+x/Q159xGKQCoRpFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, cake@lists.bufferbloat.net, Victor Nogueira
 <victor@mojatatu.com>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next 1/4] net/sched/sch_cake: serialize
 reconfiguration with the datapath
In-Reply-To: <CAM0EoMk2nKEaywg0fa6bwKxdAH8kp7dKfxHq2unZi=Qd7HBttg@mail.gmail.com>
References: <QDISC-5RTM.v1.20261007130704@mojatatu.com>
 <QDISC-5RTM.v1.20261007130704-2@mojatatu.com> <875wzctsky.fsf@toke.dk>
 <CAM0EoMk2nKEaywg0fa6bwKxdAH8kp7dKfxHq2unZi=Qd7HBttg@mail.gmail.com>
Date: Thu, 08 Oct 2026 14:03:10 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87se2gs8ld.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> On Thu, Oct 8, 2026 at 6:29=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@toke.dk> wrote:
>>
>> > The qdisc is left with autorate disabled but with the estimate install=
ed
>> > instead of X.  On 32-bit machines the unlocked 64-bit rate_bps store is
>> > also not atomic, so a reader can observe a torn rate.  iproute2 reaches
>> > this because parsing 'bandwidth X' sets autorate =3D 0 and emits both
>> > TCA_CAKE_BASE_RATE64 and TCA_CAKE_AUTORATE.
>> >
>> > Commit the parsed configuration and reconfigure while holding the same
>> > qdisc lock that serializes the datapath, so the netlink writer and the
>> > autorate writer can no longer interleave.  Make rate_bps an atomic64_t
>> > so a 64-bit rate update is atomic on 32-bit machines as well, and keep
>> > the READ_ONCE()/WRITE_ONCE() annotations for the remaining lockless
>> > readers (cake_config_dump(), which runs without the lock, and the
>> > cake_mq shared config, which readers observe under different child
>> > locks).
>>
>> So atomic_t.txt has this section:
>>
>> "SEMANTICS
>> ---------
>>
>> Non-RMW ops:
>>
>> The non-RMW ops are (typically) regular LOADs and STOREs and are canonic=
ally
>> implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
>> smp_store_release() respectively. Therefore, if you find yourself only u=
sing
>> the Non-RMW operations of atomic_t, you do not in fact need atomic_t at =
all
>> and are doing it wrong."
>>
>>
>> So AFAICT, we don't need atomic_t, we just need READ/WRITE_ONCE()
>> annotations?
>>
>
> hrm. actually, the sch_tree_lock() already protects cake_change(): it
> commits the parsed config and reconfigures together with the datapath
> under the same qdisc lock, so the netlink writer and the autorate
> store can no longer interleave. So the atomic64_t was never needed for
> the lost update.
>
> on the atomic_t.txt point you pointed out: rate_bps takes only non-RMW
> ops, so per SEMANTICS it should be a plain u64 with
> READ_ONCE()/WRITE_ONCE(). I'll drop the atomic64_t.
>
> The only lockless readers left are cake_config_dump() (cosmetic) and
> the cake_mq shared config, which a child reads while holding a
> different child's lock than the parent writes it under - on 32-bit
> READ_ONCE() on a u64 can tear there. It's an advisory rate that
> self-corrects on the next sync interval, so best-effort is fine.
>
> I will resend a v2 with rate_bps as u64 + READ/WRITE_ONCE. Let's wait
> for Sashiko first - it will always find something to complain about.

SGTM.

-Toke
