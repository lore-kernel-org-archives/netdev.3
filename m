Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999665;
	b=ePg96QzbllGdZVssNDbKePpY1SrChGVOGelSPt4t28OUQEp4maZ3NiyIzwjD7vmgPRv2
	 x0D90+Yhh1qT8040oBISk+E2ORWXt31BdkPlJu/wImfhrRyJjpjl0KR/TtRCmN8en38Xe
	 fHBRXjSHMrb8sp03wd7vfglrXOSWjBDcn3o6CFrm8NZuvgye4b/LOYv3euSKgQxD8Hu2U
	 vCPf7Ts2XYYWPeH6Pa05s0YlX0UBRQJ2hq7dg7I6mHwWEeidDYLpYykzsM0R0iCZojpEq
	 EQf4SASm9BA3L5i1O0BcJwX7kIWc+3dCZC2d2ULxQIHutWTejER2HCv/uwpkFATsz+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999665;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=CpLX50bNJo30/B0OUh8eff4hLAcAxJR9An+r3MEC1iM=;
	b=cCU+4I1og6REr4G3EQT7EbsqS5tXPCblc+CZ4MSc7x41Q4qUbxlt0U+Lzmc9F09wRAfD
	 EAUXGrHH5UU62FvLYKR6N9AJgBxLbczlLon970Qj4zgyY3iagukjadTr4Aq5mhnJY9wNs
	 RO5u7eWdsShbuGcORjwKx/+s1zbgJYNr/L9LkiYLDv6YVscwo3CIT3oISBaJxbjTAq/eD
	 LsOkR/iylxVdFNUMM4/xKYHVOrFKpMlIHyKh813QIH9J4ww/yaLQeTWnfdfMyieSUpRfG
	 EVuIvhz+ebV8XuE4QXXpVKGpqs0aGmdTaj6D0gXarRHdoyJfm8YoxnWi0SnougW8+Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nKAnohgw;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E428606A31E
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E428606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nKAnohgw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=CpLX50bNJo30/B0OUh8eff4hLAcAxJR9An+r3MEC1iM=;
	b=nKAnohgwm2ODVzSWW/fLfpf2u/toxo8ZLv+ProMGgXBL8UzOw/aqyF2115unDw
	PUrlHdz08bsssciZ2LTQA1EyGf+y7+xBWzmOtmMwm/ap2bpn6ut6Eq3dwFgxZGot
	vYpf3ry7pu44MpTykESf1Se9cDm9HLIK/yjZ8QLlj3QMU=
Message-ID: <5df19294-c5e9-4917-b989-9b7a14a7102f@163.com>
Date: Mon, 26 Oct 2026 15:26:37 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] bonding: 3ad: select a port when the TX array is
 empty
To: Jay Vosburgh <jv@jvosburgh.net>, Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 maheshb@google.com, razor@blackwall.org, netdev@vger.kernel.org
References: <20261008024031.16224-1-luyun_611@163.com>
 <asoItm3JVXSC5GQ4@fedora> <463c6b0e-8b46-4c70-b9d8-56b42beaa7d0@163.com>
 <asyt2Gt4LzKWWnZS@fedora> <0d32d785-d16a-456d-98e5-8e952d09ab76@redhat.com>
 <65061.1792871049@vermin>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <65061.1792871049@vermin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33wWuAN9qRcgqDA--.30359S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFy5Zry7XrWDKF48Kr4DJwb_yoW5ZFy3pF
	yrG3WkKF4DJr1rGwn7tw4xCayFvrWxWw47Jr1vqw1xAws8AryIgrs7tF4xua4UCrs7K34Y
	vF4jqa4DZa1UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5-BiUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7A+9jGrfAK8MtQAA3x

Hi Paolo and Jay,

Thanks for the suggestions. I agree that addressing this issue in the 
control path is preferable to adding a fallback to the transmit path. 
The gap is between port enablement and the asynchronous array update, 
which can be delayed by RTNL contention. My current plan is to 
synchronize membership changes and array updates with a per-bond mutex, 
removing the builder's RTNL dependency. The AD state machine would then 
update the arrays directly after releasing mode_lock and RCU, with the 
existing worker retained for allocation-failure retries. This keeps the 
transmit path unchanged. Implementation and validation are in progress. 
Once these are complete, I will follow up with a revised patch.

--- Thanks,

Yun Lu

在 2026/10/25 03:44, Jay Vosburgh 写道:
> Paolo Abeni <pabeni@redhat.com> wrote:
>
>> On 10/12/26 11:52, Hangbin Liu wrote:
>>> On Mon, Oct 12, 2026 at 03:20:09PM +0800, luyun wrote:
>>>> On cost: the fallback only runs when the array is empty, so the normal
>>>> transmit path is untouched. Inside the window it is a lockless RCU list
>>>> walk with no new state; the second pass and the broadcast branch are
>>>> there to keep the array path's hash mapping and broadcast_neighbor
>>>> semantics.
>>>>
>>>> I would also like Jay's feedback on the preferred direction. If a
>>>> control-path solution is preferred, I am open to working on separating
>>>> array preparation from port enablement, as long as it does not change
>>>> LACP convergence behavior.
>>> +1
>> I guess we are not getting Jay's feedback anytime soon.
> 	Apologies for not responding sooner, I've been traveling and
> missed this discussion when catching up.
>
>> I think a control-plane solution is highly preferable, even if it's
>> going to be a more significant work. I have just skimmed over the code
>> and it feels like removing the rtnl lock requirement for
>> bond_update_slave_arr() is doable - i.e. moving ->all_slaves and
>> ->usable_slaves under a new bond specific mutex).
> 	Reading the patch and subsequent discussion, I tend to agree
> with this.  In addition to what's been stated previously, the fallback
> method has the disadvantage that it adds a test and branch to the
> transmit path that will be taken very rarely.
>
> 	As I recall, bond_update_slave_arr requires RTNL only to prevent
> anything else from altering the set of interfaces in the bond while it
> runs.  It doesn't need to actually made interface-level changes or send
> notifications, so, I think that as long as the bond_enslave /
> __bond_release_one paths synchronize with the bond_update_slave_arr, it
> should be safe without RTNL.  Using RTNL for this was originally easy,
> as the enslave / release paths always have RTNL held.
>
> 	Having a mechanism to provide a lighter weight "don't change the
> bond's list of interfaces" knob might also permit removing or at least
> narrowing the scope of some of the other RTNL-related weirdness in other
> places.
>
> 	All of the "rtnl_trylock run in a work queue" patterns are hacks
> to avoid deadlocks, and if we can change any of those to be synchronous
> and deterministic while removing a trylock that's a good thing in my
> mind.
>
> 	-J
>
> ---
> 	-Jay Vosburgh, jv@jvosburgh.net

