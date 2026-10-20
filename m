Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500601;
	b=mMZ1QB6z5CDBLd4uO75GucAWYcQ4qmUDkyFQALUuzfO9iSsJLV7wOdHYGu1ybyB+S9kM
	 8LhGke4+83udBKFL2zkO5aee9jTnNBykktz9LtV6RNX4uplkLD8fKjiJ3+gle5qpuaXTv
	 8Xa/1LAuU8P1hmPDDWEoKASp0FrMuWrTPcyBRmjaelbpjmaVXLzt+0iUzaXblqvDRvkF3
	 E0ZhxGj6prYDw48sAda9PaprmvZd5W45+2WSxgz0EAcaejt3TQ0A0QO977oL/OAPmsjeF
	 ZvjIiIuzBbllvUChjEFLDv8ChulIpEcssgxR3dKwXgnkCVW/3oVtqZbsgMkjL95iciA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500601;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IzQx6pHKIouWCSktHVNsKQuHimzuXnFnXJ6+lki+f2c=;
	b=2mVGRuQYkVDFGGQ9c2lVqUNku6bL1YBK+ZkYC6MvbLj692ljS3TwXWSkU1VLcXRX7sJp
	 8TfZGJmYf+AZOipqbQZ/CRQUrWzMN8zyUfJwrjgVYPMJ2fV0XhSyJ2caWggXhphi3HABm
	 HgkCdgMLUSlUNx4w07zRniBECNnDB8SERmpzK57LWeSf1pRJ5zNfQohP0OApvW6V1B2R5
	 BcmkfR85QfDYLuEsPaOM+4ZIJoVTJg9/iudI8FGlhM/VXzFB6VywPlChOvLTvQxQAyNEW
	 Rjuo3YbheEBRZuTBrgOU0HS3e2YOzTmiQYZg4MNN1E1022s81TE7vPcJXEO/S229AFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400A6606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 12:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 400A6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 cake@lists.bufferbloat.net, Victor Nogueira <victor@mojatatu.com>, Sashiko
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v3 1/4] net/sched/sch_cake: serialize
 reconfiguration with the datapath
In-Reply-To: <QDISC-5RTM.v3.r0.20261020053711-1@mojatatu.com>
References: <QDISC-5RTM.v3.r0.20261020053711@mojatatu.com>
 <QDISC-5RTM.v3.r0.20261020053711-1@mojatatu.com>
Date: Tue, 20 Oct 2026 14:49:57 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87wlrctu2y.fsf@toke.dk>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> This is a follow-up to commit 7cbfb180945c ("net/sched: sch_cake: fix
> autorate reconfiguration throttling").  That change only stored
> last_reconfig_time; it did not address the concurrency between the
> autorate rate update in cake_enqueue() and the netlink reconfiguration
> path, which the original review flagged.
>
> The issue:
> cake_change() -> cake_config_change() updates the fields of the shared
> struct cake_sched_config under RTNL but not under the qdisc lock: it only
> took sch_tree_lock() later, around cake_reconfigure().  The datapath in
> turn serializes cake_enqueue() with itself under the qdisc lock, and its
> autorate-ingress path stores the estimated rate into
> q->config->rate_bps.  Two writers therefore update the same rate with no
> common lock:
>
>   CPU0: cake_enqueue() sees CAKE_FLAG_AUTORATE_INGRESS, computes an
>         estimate, and is about to store it.
>   CPU1: 'tc qdisc change ... bandwidth X' clears autorate in its local
>         rate_flags, writes rate_bps =3D X, publishes the cleared flag, and
>         waits in sch_tree_lock().
>   CPU0: stores the estimate, calls cake_reconfigure(), and unlocks.
>   CPU1: reconfigures from the estimate and returns.
>
> The qdisc is left with autorate disabled but with the estimate installed
> instead of X.
>
> The fix:
> Commit the parsed configuration and reconfigure while holding the same
> qdisc lock that serializes the datapath, so the netlink writer and the
> autorate writer can no longer interleave.  rate_bps needs no atomic: it is
> only ever loaded and stored, so plain READ_ONCE()/WRITE_ONCE() annotations
> are enough for the accesses that run outside the lock.  The lockless
> paths read the rate once into a local and reuse that value, so a single
> coherent snapshot is used per operation.
>
> The annotations do not make a 64-bit access single-copy atomic on 32-bit:
> READ_ONCE()/WRITE_ONCE() are still two 32-bit accesses there.  The lockle=
ss
> readers -- cake_config_dump() and the cake_mq children, which observe the
> shared config under a different child's lock -- can therefore still see a
> torn rate on 32-bit.  That rate is an advisory shaper value and is accept=
ed
> as best-effort; the state that must be consistent (the configured rate and
> the autorate flag) is written under the qdisc lock.
>
> Conditions to recreate the bug:
> The lost update (a) needs no sanitizer. Put cake in autorate-ingress on a
> device, drive bursty traffic with gaps so the 250 ms autorate reconfigura=
tion
> fires, and concurrently loop 'tc qdisc change ... cake bandwidth <N>kbit'
> without autorate-ingress (specifying a bandwidth clears the flag).
> If the autorate store lands after the change wrote its rate but before the
> change reconfigures, the qdisc ends up with autorate disabled and the est=
imate
> installed instead of <N>; reading the rate back then shows the estimate, =
which
> an unfixed kernel can do and a fixed one cannot.
> (b) The unsynchronized access is reported by KCSAN: build with CONFIG_KCS=
AN=3Dy
> and run the same trigger with the change loop keeping autorate-ingress se=
t;
> KCSAN reports a data race in cake_config_change / cake_enqueue.
> The non-atomic 64-bit store only shows up as tearing on a 32-bit machine;
> on 64-bit the store is atomic and KCSAN flags the access discipline inste=
ad.
>
> Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260816012109.2865223-1-ooonea@gmai=
l.com
> Link: https://lore.kernel.org/netdev/20260816012109.2865223-1-ooonea@gmai=
l.com/
> Link: https://lore.kernel.org/netdev/875wzctsky.fsf@toke.dk/
> Link: https://lore.kernel.org/netdev/87ld7t3kl3.fsf@all.your.base.are.bel=
ong.to.us/
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
