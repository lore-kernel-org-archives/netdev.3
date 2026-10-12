Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A422744163B
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791789675; cv=none; b=aHc/KmkFBc59hbOwSxbzrYY1oxzBUdyPEmWtd7j07z/VYIUUTRzM4MGzgUVDrJNtGqKUEkfA1IE/SNdEK4O1C1GNryecnCBzR7CCNIFb0SISO3CQncsOx2fs3V7ZKaFvXLgi1oJKdYjn2NfLL3Gf3j+pQDvdAzIn6gwM4NTQZrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791789675; c=relaxed/simple;
	bh=F66TOSmSLULQ9N26fNXSNb948WDTcoMdqt6dwnwDAEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t0kSpVblhGLQyi11Q78EIMwEJ1WUDBz3HsvJUxheE5wwvC5mUE9LecIFcMrO+Sd7dA+6WwfbJagCqJKRozN5LTp4jhxpLc+YytpTvJLW/VqmV/onKyB4TZAPcY5YvXdOYxBoEck3hWkgVhWBYKrs9kNVuq5E/sJmGEBIzmtrohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NzYUj8OJ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NzYUj8OJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=F66TOSmSLULQ9N26fNXSNb948WDTcoMdqt6dwnwDAEo=;
	b=NzYUj8OJ+hgAgSBn3mlZ5qyVuanGvr4oPVeCZUhoMv/3+jlXL5CH/Qr6lm0KBh
	45zUI+vK07VRyYQiJuLX0QqEbYASa/s6Yz1TwRtBPfPxupm4xzkGBKhe1Nm24EpV
	UDZRlp+jUqPgz8q99Nh04hOnZGgoT7M8g8Xqpix9WmV8w=
Message-ID: <463c6b0e-8b46-4c70-b9d8-56b42beaa7d0@163.com>
Date: Mon, 12 Oct 2026 15:20:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] bonding: 3ad: select a port when the TX array is
 empty
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, maheshb@google.com,
 razor@blackwall.org, netdev@vger.kernel.org
References: <20261008024031.16224-1-luyun_611@163.com>
 <asoItm3JVXSC5GQ4@fedora>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <asoItm3JVXSC5GQ4@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v0YpisxqHi8FEQ--.63609S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFWDXr4fGw4xWr4DuF4DArb_yoWruF1rpF
	WFg3s3tw1DZ34jvwnFya1Uua1ruws7Ja17Gry8Kry8ZFs8urn29FWIgw1vqa47Crs5G34Y
	vrWqgFy5ua1YyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5HUgUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCwwp6SWrMiirpvQAA3o


在 2026/10/10 17:43, Hangbin Liu 写道:
> Hi Lu Yun,
> On Thu, Oct 08, 2026 at 10:40:31AM +0800, Yun Lu wrote:
>> From: Yun Lu <luyun@kylinos.cn>
>>
>> This issue was observed on a machine in real use. During 802.3ad
>> bring-up in production, packets were dropped even though the bond's
>> carrier was up and LACP had enabled ports for distribution. The
>> transmit path only consults usable_slaves and returns no slave when
>> the array is NULL or its count is zero.
>>
>> LACP port eligibility and the TX array are updated separately. The
>> state machine enables ports and updates carrier before scheduling
>> slave_arr_work to rebuild and publish the array. The worker requires
>> RTNL and retries if rtnl_trylock() fails, so RTNL contention can
>> prolong the interval in which eligible ports exist but the cached
>> array is empty.
>>
>> Add a fallback for 802.3ad when the usable array is empty and carrier
>> is up. Walk the RCU-protected slave list and use ports whose
>> aggregator is active and which pass bond_slave_can_tx(), without
>> taking mode_lock or changing LACP state. In 802.3ad mode the
>> per-slave active flag is set only by the mux machine for ports of the
>> active aggregator, so these lockless reads identify distributable
>> ports with the same criteria bond_update_slave_arr() applies when
>> building the array.
> `bond_update_slave_arr()` is called from `bond_enslave()`, and it should be
> very fast. Could we add a check in `bond_3ad_state_machine_handler()` or
> another suitable place to ensure usable slaves exist before entering the
> distribution state?
>
> The fallback path seems somewhat complex and costly. Or you can wait for
> Jay's feedback.

Hi Hangbin,

Thanks for the review and the suggestion.

bond_enslave() does call bond_update_slave_arr() synchronously, but at
that point the newly enslaved 802.3ad port is still inactive and there
is usually no active aggregator yet, so that call typically resets both
arrays to NULL. The problematic window opens later, when LACP
convergence completes, and it comes from the delay stages between port
enablement and array publication:

1) The state machine enables the port and brings carrier up inside the
    sweep (__enable_port() -> bond_3ad_set_carrier()), but slave_arr_work
    is only queued after mode_lock is released.

2) bond->wq is an ordered workqueue shared with ad_work, mcast_work and
    peer_notify_work, so slave_arr_work runs only after the work items
    queued ahead of it finish, on top of normal scheduler latency under
    boot load.

3) The worker needs RTNL. rtnl_lock is global: any concurrent netdev
    operation (e.g. udev / network manager churn during boot) makes
    rtnl_trylock() fail, and the worker requeues itself with a 1 jiffy
    delay, retrying until RTNL becomes available. This was exactly the
    situation on the production machine where we hit the problem.

During this window carrier is up and the ports are already
collecting/distributing, but usable_slaves is still NULL or empty, so
every packet goes through bond_tx_drop() and the sender sees no error.
In production ARP simply never went out.

A control-path check before entering the distribution state would be
circular with the current builder: bond_update_slave_arr() only picks
ports that already pass bond_slave_can_tx(), and that flag is set by
the mux machine itself on entering collecting/distributing. Waiting
for a non-empty array before enabling the first port never converges.

Deferring the mux transition instead would delay carrier-on, be
visible to the LACP partner, and under RTNL contention extend bring-up
by the same delay the fallback covers, so traffic would not flow any
sooner. The builder also needs RTNL, may sleep and takes mode_lock
itself, so it cannot be called from the mux critical section; a
control-path fix means splitting array preparation from port
enablement, with recovery when RTNL or allocation fails.

On cost: the fallback only runs when the array is empty, so the normal
transmit path is untouched. Inside the window it is a lockless RCU list
walk with no new state; the second pass and the broadcast branch are
there to keep the array path's hash mapping and broadcast_neighbor
semantics.

I would also like Jay's feedback on the preferred direction. If a
control-path solution is preferred, I am open to working on separating
array preparation from port enablement, as long as it does not change
LACP convergence behavior.

---

Thanks,
Yun Lu

>
> Thanks
> Hangbin

