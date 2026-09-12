Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4272C3251
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 05:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789192052; cv=none; b=DOJPAMinRNPvyLaLtine6E6RY5EPIo0+/k8Jd+JrQ6DzLyJS9lmITHeRQRXpV7wjMBTMeA0E724SuisT6I2ofQTrp3ID2TSfOV4k6vksUiQG1cqwo24rSr0SrAXrbyfnZcHR0AdqzFB599XPSyqix/pqA36MG1CXkcKfxfe2peA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789192052; c=relaxed/simple;
	bh=R09DxYWwRFKcA3zJJT1V2QC12PMl4Pco+H920Yla4H0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tIC4PCB8GupGynH9+v8XfdR9Boe9uU65k+LPHEXqthRHj94UiLHvO2cbCmprW+lFf51+ZamR0tbofU8XoYea8fRIZDB3CVWRx9Jpc7noc5DWS9pdFXNRYE31l3oYcIax5tFrV4cezk1gwXIRvFcTXqlwfQZDTweOa91G7bKNNiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=HkIRVxBY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="HkIRVxBY"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c169ae1cb26so363463066b.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 22:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1789192047; x=1789796847; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SwE5kzox6mDh+dA8LbUvBfhYlkbwUpzVlt+545kDdSw=;
        b=HkIRVxBYEzn2I8M05X+oZVM1uAw5Zd84N3ViNT1mi2q7RAMd4XIRv+nNmq60ldhPbw
         WOm5uqfibd85JRH9KsBAT1Lc7GvLGV/3KP1OfLVAigJ01gZOYT17fmtjaBrGmjtrZxjV
         hHaO5xHbh17/3jyaOh3vXu9bPWEoNtLKXzbgz3RL4NBVg/ybeD00yECxeep2YLkp0M8b
         f41I1Hx/F3EmTmrbS/WBc2dYAPx6fnenqtIzUSFE9PhLtF8t9e2MjmGHWruNCykNokb0
         doplgLdxVqolOsG7G6Bzwj/ybqHMSMAnhYXFPhonuc1Zw8eQWVtb4dkWMkHyRC5QFiA+
         CeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789192047; x=1789796847;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SwE5kzox6mDh+dA8LbUvBfhYlkbwUpzVlt+545kDdSw=;
        b=hod0haBAwI5AkGpM+TPOadyNxwTOume1MoBtWJbHpCoptqkfgsIlzmNaTsSuVwnEm7
         QqDKbwOeB9NfIat8MrG1mIiTziETdkieOFKi+0ARx3e5Qv9DMMysH+zkT3o7ow++Uo31
         tXJLsNPN+Jb2V3KNrGExlkYNHCbc9DXd6Kz8GCXpKTtVbPXiv9LVNjuwIDpgOpDnK8ba
         4hAqeqOS+6YIdyCyssUS+PQGLX96AvfOCESIUOTPdJq7RmDSu7yLoLN/bUVhIOaldw/C
         gQflVYg2lyIhX6AY+QyEQCQunTv35Q86tPAVuGGctl+hPGgbfdOA1o8uCDDObxJrSYlL
         3gSA==
X-Gm-Message-State: AFuF++lOwz4gWBYPJmmiYSoXEuN/BTsRfNHrANRvrXrAkEk5pbN85NBZ
	qikzXqz82c61BFHKKLn1WoiDmM5assX2V+KNUFpiYrx7ikc+a4CXWC5gwLTzQWzdCgg=
X-Gm-Gg: AYBFou2JKOWyCav41WxOwsF7+sN0T3ug2hyM4Kemw0KTX22zQXmeptPIIc9CFlw+TJv
	JoyCK7nWehGq6ijUXJO1ISkvpNHq+R92E3c6xHH3Hrfq2u5QhpLyf9iWZkSckwTdEFJCgF4Z07X
	HjdEjWWy1n8LngKH7pPdosHWNOoZcA17tstaDlBmFfuN/CGjkyJqafmWh1Lk0RP2/Ahr3bPaaFH
	kUStRKvD9MV9N930K24az1jSvxJB9dRxXnUuEpgdE7oBDNcAYVDm7a6dhWeowKB0OY1CO046tAH
	mDJKECwccGlRFZImFzYa7nFcWH/xvN9kSuKd43qr/SdWkfnD9ZDvXkRh1vT2Bsd/8pTLIZuJ9NM
	FG0w/10ob/hUXVeZq0paWK+Z7qLRmPo6K+0AI3TJvRQ2EeEEULK3aMvy5/L21ssVHwuk+Rwg/rd
	DFlmyctG8kCUcsk48WlI15TuOk5Kg2zWnb5DVfK1ZNCX32vP4KvfotyDzhrXZqfnBGIEnbge2gz
	hsMXaMupSZ4giV0MMDQM/nUxMt59XbX1lL/c62ZUe/h+XrkTkogbRq4DklAcME=
X-Received: by 2002:a17:906:7316:b0:c25:f7dc:2dc with SMTP id a640c23a62f3a-c2945f4690fmr695098566b.29.1789192047502;
        Fri, 11 Sep 2026 22:47:27 -0700 (PDT)
Received: from smtpclient.apple (80.49.147.201.ipv4.supernova.orange.pl. [80.49.147.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966026e2esm160958266b.19.2026.09.11.22.47.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2026 22:47:26 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH net] net: clear stale traffic class mappings when num_tc
 shrinks
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <178906438394.219967.1407792738957504620@kernel.org>
Date: Sat, 12 Sep 2026 07:47:15 +0200
Cc: netdev@vger.kernel.org,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 horms@kernel.org,
 kees@kernel.org,
 kuniyu@google.com,
 alexander.duyck@gmail.com,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B8A2130-773E-4D0A-9381-E3C7FBF8B0AD@doyensec.com>
References: <16E3A318-5532-4B5E-8D03-86D21B463A2D@doyensec.com>
 <178906438394.219967.1407792738957504620@kernel.org>
To: netdev-bot+sashiko@kernel.org
X-Mailer: Apple Mail (2.3864.700.51.1.1)

On Sep 10, 2026, at 20:19, netdev-bot+sashiko@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>=20
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 0
>=20
> - [High] The patch keeps the 'tc < num_tc' invariant only at a =
distance
>  (scrubbing the source arrays) and never validates it at the point =
of=E2=80=A6
> - [Medium] netdev_set_num_tc() now zeroes
>  dev->tc_to_txq[num_tc..TC_MAX_QUEUE-1] and the out-of-range=E2=80=A6
>=20
> --
>=20
> net: clear stale traffic class mappings when num_tc shrinks
>=20
> netdev_set_num_tc() lowers dev->num_tc without touching =
dev->tc_to_txq[]
> or dev->prio_tc_map[], so stale entries naming a class >=3D =
dev->num_tc are
> handed back out by netdev_txq_to_tc() and netdev_get_prio_tc_map().  =
The
> patch clears the entries the new num_tc no longer covers before =
publishing
> the new num_tc.
>=20
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index ecfbd72d5d1a..e63e36a7c4d4 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -3145,6 +3145,8 @@ EXPORT_SYMBOL(netdev_set_tc_queue);
>>=20
>> int netdev_set_num_tc(struct net_device *dev, u8 num_tc)
>> {
>> + int i;
>> +
>> if (num_tc > TC_MAX_QUEUE)
>> return -EINVAL;
>>=20
>> @@ -3153,6 +3155,14 @@ int netdev_set_num_tc(struct net_device *dev, =
u8 num_tc)
>> #endif
>> netdev_unbind_all_sb_channels(dev);
>>=20
>> + /* Drop the mappings the new num_tc no longer covers. */
>> + for (i =3D num_tc; i < TC_MAX_QUEUE; i++)
>> + WRITE_ONCE(dev->tc_to_txq[i].combined, 0);
>> + for (i =3D 0; i <=3D TC_BITMASK; i++) {
>> + if (READ_ONCE(dev->prio_tc_map[i]) >=3D num_tc)
>> + WRITE_ONCE(dev->prio_tc_map[i], 0);
>> + }
>> +
>=20
> [Severity: Medium]
> These two loops run while the old, larger dev->num_tc is still =
published.
> Can a concurrent lockless transmitter observe the old num_tc together =
with
> already-cleared mappings?
>=20
> netdev_pick_tx() -> skb_tx_hash() gates on num_tc and then reads
> tc_to_txq[] with no lock:
>=20
> net/core/dev.c:skb_tx_hash() {
> if (READ_ONCE(dev->num_tc)) {
> u8 tc =3D netdev_get_prio_tc_map(dev, skb->priority);
> struct netdev_tc_txq res;
>=20
> res.combined =3D READ_ONCE(sb_dev->tc_to_txq[tc].combined);
> qoffset =3D res.offset;
> qcount =3D res.count;
> if (unlikely(!qcount)) {
> net_warn_ratelimited("%s: invalid qcount, qoffset %u for tc %u\n",
>     sb_dev->name, qoffset, tc);
> qoffset =3D 0;
> qcount =3D dev->real_num_tx_queues;
> }
> }
>=20
> During the window the entry is already zero, so qcount =3D=3D 0, the
> "invalid qcount" warning is emitted and the packet is hashed over the =
whole
> device queue range instead of the class range that num_tc still =
advertises.
>=20
> netdev_txq_to_tc() has the same exposure and returns -1 while num_tc =
is
> still non-zero:
>=20
> net/core/dev.c:netdev_txq_to_tc() {
> if (READ_ONCE(dev->num_tc)) {
> ...
> /* didn't find it, just return -1 to indicate no match */
> return -1;
> }
>=20
> DSA taggers store that result in a u8 (ocelot_xmit() in
> net/dsa/tag_ocelot_8021q.c, and the equivalents in net/dsa/tag_ksz.c =
and
> net/dsa/tag_sja1105.c), which turns into a priority of 255.
>=20
> The peer teardown helper netdev_reset_tc() uses the opposite store =
order,
> publishing num_tc first and clearing the arrays afterwards:
>=20
> net/core/dev.c:netdev_reset_tc() {
> WRITE_ONCE(dev->num_tc, 0);
> for (i =3D 0; i < TC_MAX_QUEUE; i++)
> WRITE_ONCE(dev->tc_to_txq[i].combined, 0);
> for (i =3D 0; i <=3D TC_BITMASK; i++)
> WRITE_ONCE(dev->prio_tc_map[i], 0);
> }
>=20
> Since every reader gates map use on num_tc, would matching that order =
here
> avoid the intermediate state, and should the commit message mention =
the
> inverse inconsistency this order creates?

Agreed with that, I am dropping the loops. v2 follows, I'll retitle it =
since
the fix moved into the XPS path.

>=20
>> WRITE_ONCE(dev->num_tc, num_tc);
>> return 0;
>> }
>=20
> [Severity: High]
> Does scrubbing the source arrays close the out-of-bounds write quoted =
in
> the commit message for XPS callers that do not hold RTNL?

No, and this is the right objection. v1 fixed the instance I could =
reach,=20
but I missed virtnet_set_affinity() as a non-RTNL caller. v2 rejects a =
class=20
the map has no room for instead.

> __netif_set_xps_queue() takes two independent unsynchronized snapshots =
and
> only rejects a negative class:
>=20
> net/core/dev.c:__netif_set_xps_queue() {
> dev_num_tc =3D READ_ONCE(dev->num_tc);
> if (dev_num_tc) {
> num_tc =3D dev_num_tc;
> ...
> tc =3D netdev_txq_to_tc(dev, index);
> if (tc < 0)
> return -EINVAL;
> }
>=20
> mutex_lock(&xps_map_mutex);
> ...
> tci =3D j * num_tc + tc;
> ...
> RCU_INIT_POINTER(new_dev_maps->attr_map[tci], map);
>=20
> xps_map_mutex is taken only after both loads and does not protect
> dev->num_tc, and the allocation is sized with
> XPS_CPU_DEV_MAPS_SIZE(num_tc) / XPS_RXQ_DEV_MAPS_SIZE(num_tc, nr_rx), =
so
> any tc >=3D the snapshotted num_tc writes attr_map[] past the =
allocation.
>=20
> Two paths look like they remain:
>=20
> Raising num_tc is not covered at all.  A reader that snapshotted
> num_tc =3D=3D 1 and is then preempted can pick up tc =3D=3D 3..7 after =
another CPU
> ran mqprio_init() -> netdev_set_num_tc(dev, 8) plus
> netdev_set_tc_queue(dev, 3, ...) in net/sched/sch_mqprio.c, and then =
writes
> attr_map[j * 1 + 3] into a map sized for one class.
>=20
> The ordering the commit message relies on is not enforced.  The =
message
> says the entries are cleared "before publishing num_tc so that a =
lockless
> reader cannot observe the new num_tc together with the old mappings", =
but
> the clearing stores and WRITE_ONCE(dev->num_tc, num_tc) are plain
> WRITE_ONCE() with no smp_wmb()/smp_store_release(), and =
netdev_txq_to_tc(),
> skb_tx_hash() and netdev_get_prio_tc_map() use bare READ_ONCE() with =
no
> smp_rmb()/acquire.  On a weakly ordered CPU, can a non-RTNL reader =
still
> see the new smaller num_tc together with mappings that have not been
> cleared yet?
>=20
> A non-RTNL XPS caller exists:
>=20
> drivers/net/virtio_net.c
>  virtnet_cpu_online() / virtnet_cpu_dead()
>    virtnet_set_affinity()
>      __netif_set_xps_queue(vi->dev, cpumask_bits(mask), i, XPS_CPUS);
>=20
> which runs with only cpus_read_lock() held while netdev_set_num_tc() =
holds
> only RTNL.  The sysfs callers xps_cpus_store()/xps_rxqs_store() in
> net/core/net-sysfs.c are serialized by sysfs_rtnl_lock() and are not
> affected.
>=20
> Would bounding the class at the point of use, for example
>=20
> tc =3D netdev_txq_to_tc(dev, index);
> if (tc < 0 || tc >=3D num_tc)
> return -EINVAL;
>=20
> after the snapshot that sizes the map, together with a release/acquire =
pair
> or shared locking for the num_tc publish, be a more direct fix than
> scrubbing the arrays?

I believe so. I left out the barrier and the extra locking, as I don't =
think
it's needed here.

N.

> --=20
> Sashiko AI review =C2=B7 =
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/16E3A318-5532-4B5E-8D0=
3-86D21B463A2D%40doyensec.com

