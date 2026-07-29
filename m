Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BEF47A861
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326442; cv=none; b=Aen9B6cAlluSuSOOVwmHzKDcxyHzjt4LBLs0GVgr/KpK55FDwzyMZxtVqkisrJUBnWKST9ljp7Cqxc1UR/vG/bmYEzoqs7D6x8e5msulNG6IG9plxevhWcrlFuL3a61wDYUGQff6WU3XUricn7y+NoHMzTE4epBsIfXQYmRGmc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326442; c=relaxed/simple;
	bh=2dwwud663WcRS2re1oQDEPUNZyPFtZQjBQnoG9tK80I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMPsH3MkSoHWcvOOVzcxqLTcYWwzyblJdhAipTWa0nwKOASq61r9eL1EjhXE/Yo8OpO3BWkvEZCaGclU/cyb18woD7ty+dQANkfqHKAFqttfCcyJ+qX5Hs8tK2nFTrGQHE5+WkK9D6PyDz0hEEXHd7RSCMhFv6oT6u+IwIyGLLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+ddvetT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQ25JksA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+ddvetT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQ25JksA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785326439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0kfFovj/5VYrjgPm7tJBdcFR+lim6bdvkFidPTmHWjE=;
	b=a+ddvetTfxKhVbqRtPBzMS6Zfn12LC7r8jdSTBL7WB3BOL+l+grfdEcPKyXhS5tQE9s6iJ
	9ElbkWU0cNh+4QHH5A/b+YTzSBau2pi4eRJPyQ7e3ZnXp8ktAxug4OPPVd8oMx9uTNA1Gr
	Kh96RqACbTvSxcfSyh/zTq/tY5UuFS4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-VuLN3C9lO92rKu2cbXRWUw-1; Wed, 29 Jul 2026 08:00:36 -0400
X-MC-Unique: VuLN3C9lO92rKu2cbXRWUw-1
X-Mimecast-MFC-AGG-ID: VuLN3C9lO92rKu2cbXRWUw_1785326435
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c11f2b9f62fso78683666b.2
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 05:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785326435; x=1785931235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0kfFovj/5VYrjgPm7tJBdcFR+lim6bdvkFidPTmHWjE=;
        b=PQ25JksAJ3J76DpTldkobWioCPoYM023y3A0Lt04J9lK9k0RB5We7qNc8aRpU7L4xx
         ckPXrkwzdl7CsoSPfNlGHWRIhmAT2yUiSzt9XEVQh/1ng2UuGPXDvjgdEZBnJAZfxouv
         ePdGQI4LuBXA4vmjnHOkrtIQ5M0EwkDdAMRXFzP23VwGSIfpzwMxhcNStEqvESFNFqyC
         t3BQV/22z6quj2eTwMJX0LtgPNeyjfRZTv0w08bV6tYXdjanFPIHRd3NI/Cx5H8Ei0SF
         4UEfyuXKE5At5GiL3n2JjNB4nEz0BtLbkrXOL3ipkKC8MuW/XpWR3gEz1Q+mlSZPrwQj
         MdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785326435; x=1785931235;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0kfFovj/5VYrjgPm7tJBdcFR+lim6bdvkFidPTmHWjE=;
        b=WyCLG6JF9gALYOUQUkx490jgeM5479U+ugMZtW+EkmgOR459/j3IdMVeQaE7/Cr6iV
         RAu5GUmGeiFZfnEuGS1OUZ9KsFw8IOaWoqUz4LwansKnApSaErlddc1d6oOFDGnKTPhJ
         BZSOHuqLt0nkeCKj4utPQVDJtA3NeMDtOcZQDVQpuKivDtvuUStA9IS9PYn5NLXgAPoM
         NUXlXyG2wU9PvTdcePd6t8rEDqU4M04FNFYwkkm7RYLiVTom1rqy2UM6jHZGnczfugrz
         PWplf48vKdH9Fd6hrWIPEEydgDHTCOawx8URbn7uy3lbL2O+xeXIlVoKyIImJs1fwEYi
         OxBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrwh/PFO/RjTNE2eh806eO/yIoXhgb1nHjROx+oBpy8NfSRmZr3gWF2iNPzb3ssnZUTj/ooJ3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3JhEgsbRIMAZNdgLvDObFIQy50/M+ZD46uAp/r8dlsx685N3e
	/fYp8qG+LaIatj+dgCsjmar4gY9imRF46+Q9/N/wLS5ANGOhrJ2NC/jeq+Uac2jmBL6nFnVz0ug
	F7S/b0vw/fPKDtHmlmLmH1SOV0bgpusVUPbjYvYHAoblZ2gCNdYEWWjliOg==
X-Gm-Gg: AR+sD11ineGn2yJ8LOLnvYyOeCcs+aKMmRTqZRY6iIH9wyLO/qBmahzkBkdJq5ExEPo
	z15ElbEVlamcSsF113ru7M3QfXddl8JYGnyMTEQv3MndvWWXzVtRt6/LemaWjosSewZZMm5PfWg
	BbR94Ad2Y1UfRlT5Wn25vBzSP5YLFJVWKQ/kBQ7JIgNxxXW87/6zZnPLjY7TEgxBjUu8YFbIZAz
	KvWVJxizvS3WDSRcqq3ooYY6vRy2Nysfxcuqs4KmXuTj+M4ESUQAvXoRVftb3kq55uDr+oMNsZ9
	nfv2eAcvnOHk1VWsRxhArjQg3/G9gatBC/390Q4iz07jqhvC/SMuT6sfMJZhcfhGCWzMSRL3bVo
	sjJvqghZDdkeRwB15ywR2IeBqFavgfsOR1C3Q361O8fp7bVzY
X-Received: by 2002:a17:907:1c86:b0:c16:592b:ec4c with SMTP id a640c23a62f3a-c1f7215dab8mr385769366b.1.1785326434991;
        Wed, 29 Jul 2026 05:00:34 -0700 (PDT)
X-Received: by 2002:a17:907:1c86:b0:c16:592b:ec4c with SMTP id a640c23a62f3a-c1f7215dab8mr385763766b.1.1785326434225;
        Wed, 29 Jul 2026 05:00:34 -0700 (PDT)
Received: from [172.16.2.95] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83c711cfsm104887166b.7.2026.07.29.05.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:00:33 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Aaron Conole <aconole@redhat.com>, alexyoung0@163.com,
 dev@openvswitch.org, netdev@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, horms@kernel.org, edumazet@google.com, davem@davemloft.net
Subject: Re: [net] net: openvswitch: fix stack exhaustion from unaccounted
 clone_execute() recursion
Date: Wed, 29 Jul 2026 14:00:32 +0200
X-Mailer: MailMate (3.0r7024)
Message-ID: <580EC07E-B018-4BB0-9C3B-D43E4122554D@redhat.com>
In-Reply-To: <749a52f7-c613-4b70-a400-6bd54ead39b7@ovn.org>
References: <178521875706.803907.3226960398667307795@163.com>
 <f7twlufw4js.fsf@redhat.com> <a56fe38b-5fc8-4845-8d68-d199d753dcee@ovn.org>
 <f7tse52x1zz.fsf@redhat.com> <749a52f7-c613-4b70-a400-6bd54ead39b7@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow



On 29 Jul 2026, at 11:56, Ilya Maximets wrote:

> On 7/28/26 11:01 PM, Aaron Conole wrote:
>> Ilya Maximets <i.maximets@ovn.org> writes:
>>
>>> On 7/28/26 4:51 PM, Aaron Conole wrote:
>>>> Hi Yang,
>>>>
>>>> yang zhuorao <alexyoung0@163.com> writes:
>>>>
>>>>> clone_execute() only increments and decrements exec_level when
>>>>> clone_flow_key is true.  When clone_flow_key is false the optimized=

>>>>> path reuses the original flow key and calls do_execute_actions()
>>>>> directly without updating the recursion counter, making those layer=
s
>>>>> invisible to the OVS_RECURSION_LIMIT check in ovs_execute_actions()=
=2E
>>>>>
>>>>> A single action tree allows up to OVS_COPY_ACTIONS_MAX_DEPTH (16)
>>>>> nested clone actions.  When the innermost clone contains a RECIRC
>>>>> that selects another flow with its own 16-layer validation budget,
>>>>> multiple trees of unaccounted recursion can be stacked.  The deferr=
ed
>>>>> action threshold (OVS_DEFERRED_ACTION_THRESHOLD =3D
>>>>> OVS_RECURSION_LIMIT - 2 =3D 3) allows three synchronous recirc leve=
ls
>>>>> before clone_key() forces deferral, yielding 3 x 16 =3D 48 layers o=
f
>>>>> synchronous, unaccounted clone recursion.
>>>>>
>>>>> Per-layer stack usage is approximately 296 bytes (from disassembly:=

>>>>> do_execute_actions() allocates 0x98 bytes, clone_execute() allocate=
s
>>>>> 0x20 bytes, plus saved registers and return address).  48 layers
>>>>> consume ~14,208 bytes before recirc, flow lookup, Netlink, and base=

>>>>> call frames, exceeding the 16 KiB x86_64 task stack and hitting the=

>>>>> guard page.
>>>>>
>>>>> An unprivileged user can trigger this from a private user/net
>>>>> namespace (clone(CLONE_NEWUSER | CLONE_NEWNET)) by installing three=

>>>>> flow rules each with 16 nested clone actions linked by RECIRC, then=

>>>>> injecting a single packet via OVS_PACKET_CMD_EXECUTE.  The result i=
s
>>>>> a kernel panic:
>>>>>
>>>>>     BUG: TASK stack guard page was hit ...
>>>>>     CPU: 0 UID: 1000 PID: 85 ... 7.2.0-rc5+
>>>>>     RIP: 0010:clone_execute+0x5a/0x2c0 [openvswitch]
>>>>>     [do_execute_actions / clone_execute alternating repeatedly]
>>>>>     Kernel panic - not syncing: Fatal exception in interrupt
>>>>>
>>>>> Fix this by unconditionally incrementing exec_level for all
>>>>> synchronous clone recursion edges and checking OVS_RECURSION_LIMIT
>>>>> before calling do_execute_actions().  When the limit is exceeded th=
e
>>>>> packet is dropped and -ENETDOWN is returned, consistent with the
>>>>> existing handling in ovs_execute_actions().
>>>>>
>>>>> Tested on Linux 7.2.0-rc5+ (mainline HEAD 62cc90241548), x86_64,
>>>>> CONFIG_VMAP_STACK=3Dy, CONFIG_OPENVSWITCH=3Dm, isolated QEMU guest.=

>>>>> Confirmed that the PoC (./poc_clone_overflow 2 16 3, run as UID 100=
0)
>>>>> no longer triggers a panic with this patch applied.
>>>>>
>>>>> Fixes: b233504033db ("openvswitch: kernel datapath clone action")
>>>>> Cc: stable@vger.kernel.org
>>>>> Reported-by: yang zhuorao <alexyoung0@163.com>
>>>>> Signed-off-by: yang zhuorao <alexyoung0@163.com>
>>>>> ---
>>>>> Reproducer (C, single file, available upon request):
>>>>>
>>>>>     gcc -O2 -Wall -o poc_clone_overflow poc_clone_overflow.c
>>>>>     ./poc_clone_overflow 2 16 3   # as unprivileged user
>>>>>
>>>>> The PoC creates a private user/net namespace, installs three flows
>>>>> each with 16 nested clone actions linked by RECIRC, and injects a
>>>>> triggering packet.  Prerequisites: CONFIG_OPENVSWITCH=3Dm/y loaded,=

>>>>> unprivileged user namespace creation allowed.
>>>>>
>>>>> Verified unfixed in Linus mainline (62cc90241548), net (97ac08560d2=
3),
>>>>> and net-next (a50eba1e778a) as of 2026-07-27.
>>>>>
>>>>>  net/openvswitch/actions.c | 13 +++++++++----
>>>>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>>>>
>>>>> --
>>>>
>>>> General - please remember to CC the netdev maintainers as well.
>>>>
>>>> [...]
>>>>
>>>>> @@ -1497,14 +1497,19 @@ static int clone_execute(struct datapath *d=
p, struct sk_buff *skb,
>>>>>  	if (clone) {
>>>>>  		int err =3D 0;
>>>>>  		if (actions) { /* Sample action */
>>>>> -			if (clone_flow_key)
>>>>> -				__this_cpu_inc(ovs_pcpu_storage->exec_level);
>>>>> +			__this_cpu_inc(ovs_pcpu_storage->exec_level);
>>>>> +
>>>>> +			if (unlikely(__this_cpu_read(ovs_pcpu_storage->exec_level) >
>>>>> +				     OVS_RECURSION_LIMIT)) {
>>>>> +				__this_cpu_dec(ovs_pcpu_storage->exec_level);
>>>>> +				ovs_kfree_skb_reason(skb, OVS_DROP_RECURSION_LIMIT);
>>>>> +				return -ENETDOWN;
>>>>> +			}
>>>>
>>>> There is an existing check for recursion in ovs_execute_actions() an=
d in
>>>> there we have a log before dropping:
>>>>
>>>> 	net_crit_ratelimited("ovs: recursion limit reached on datapath %s, =
probable configuration error\n",
>>>> 			     ovs_dp_name(dp));
>>>>
>>>> We should have a similar log here so we're not silently dropping.  B=
ut,
>>>> since we now have two places where this check occurs (and it's
>>>> complicated because of how deferred actions is processed), maybe it'=
s
>>>> better to have a function that does the management:
>>>>
>>>>   static int ovs_exec_level_enter(struct datapath *dp, struct sk_buf=
f *skb) {
>>>>   	int level;
>>>>
>>>>   	level =3D __this_cpu_inc_return(ovs_pcpu_storage->exec_level);
>>>>   	if (unlikely(level > OVS_RECURSION_LIMIT)) {
>>>>   		net_crit_ratelimited("ovs: recursion limit reached on datapath %=
s, probable configuration error\n",
>>>>   				     ovs_dp_name(dp));
>>>>   		ovs_kfree_skb_reason(skb, OVS_DROP_RECURSION_LIMIT);
>>>>   		return -ENETDOWN;
>>>>   	}
>>>>   	return 0;
>>>>   }
>>>>
>>>>   static void ovs_exec_level_exit(void) {
>>>>   	__this_cpu_dec(ovs_pcpu_storage->exec_level);
>>>>   }
>>>>
>>>> Then just put the enter/exit calls in the clone_execute() and
>>>> ovs_execute_actions() spaces.  That way if we need to adjust this li=
mit
>>>> in the future, it's consolidated to just one place.
>>>>
>>>
>>>
>>> There is a different issue here though.  The exec_level is used as a
>>> counter for the flow keys during the clone.  And if we increment it
>>> unconditionally while not allocating new keys, we'll ran out of key
>>> slots much faster without actually using them.  This will lead to
>>> much more actions to be deferred and packets dropped in the end.
>>> There is already a mismatch here as ovs_execute_actions() increments
>>> the level without allocating the key, but doing so also for non-recir=
c
>>> cases would significantly amplify the problem.
>>
>> That's an additional concern, but the code path at least currently
>> handles the event that we advance beyond the clone flow key per-cpu
>> array.  This change makes a low-likelihood scenario a bit worse (the
>> case where we have lots of clones + sub-actions).  I don't think it
>> needs to be addressed with this work since this is a security fix, but=

>> we should address it via a follow up change (and I can work on that if=

>> needed).  AFAICT the affected actions are:
>>
>> - sample()
>> - clone()
>> - dec_ttl()
>> - check_pkt_len()
>>
>> I think in most deployments I've seen they only nest once or twice, an=
d
>> we should have 3 'nests' worth of clone flow keys to handle it, meanin=
g
>> that the increased pressure should still fit within the slots we have
>> (we just wouldn't support another nest, which is different from today)=
:
>> ie: nest 1, we are 'taking' slot 2 (key[1]), and nest 2 we are 'taking=
'
>> slot 3 (key[2]), which leaves no more available.
>>
>> For example, check_pkt_len(..., check_pkt_len(...)) would still work a=
s
>> long as there's no sample() wrapped around it, or a dec_ttl within it,=

>> or some other more complex scenario.  And it seems to be very heavy
>> handed to ask for a fix that includes both the stack overflow and the
>> clone allocation change together.
>
> While direct nesting is indeed not common, it is very common to have
> recirculation actions inside the clones or check_pkt_len, e.g.:
>
>   check_pkt_len(1514, le(recirc(X)), gt(recirc(Y)))
>
> Before this patch we'd only count one level, which is recirculation
> itself.  After this change it will be two levels.
>
> A lot of production setups hover at 3-4 recirculations on certain
> packet paths, e.g. pod-to-external traffic in ovn-kubernetes.
> And these setups do have at least a few clones or check_pkt_len
> actions on these paths.  And so, if we start counting plain clones
> towards the limit, we could easily break real world deployments,
> given the limit is just 5.
>
> So, we need to reconsider the limits here.  But we also can't blindly
> increase the limit as it will increase per-CPU memory consumption
> since that number dictates the size of the storage for keys, which
> are large.
>
>>
>>> We likely need to decouple the recursion level couter from the slot
>>> index in the keys array.  Though they still should stay related as
>>> we should start deferring when we approach recursion limit even if
>>> we still have some free slots for key clones.
>>
>> Agreed, we need to have two discreet operations - one to track the sta=
ck
>> recursion and one to do the clone flow key allocation.  Unless you fee=
l
>> strongly that they should come as part of the same series, but it seem=
s
>> a lot.
> I think, it should be done within this patch, because otherwise we'll
> be most likely breaking existing deployments.
>
> We need a few things:
>
> 1. Decouple the key array index from the execution level.
>
> 2. Potentially increase the recursion limit, since it is going to count=

>    more things.  x2 might be a safe choice, but it is also quite a lot
>    and we're risking to ran out of stack in other scenarios.  Something=

>    like +3 may be a change to explore.
>
>    We will need extra testing here to make sure we're not breaking
>    existing setups.  I could try and check ovn-kubernetes deployments,
>    as an example of the most demanding configuration, but it will take
>    a bit of time.
>
> 3. Sahiko also points out that we should not be dropping packets in
>    case we reached the limit inside the clone_execute(), we should
>    attempt to defer the actions first.  In which case we should not
>    log that the limit is reached.
>
> WDYT?
>
> Eelco, do you have some thoughts on this?

I agree we should not blindly remove the 'if (clone_flow_key)' guard from=

the exec_level increment and assume everything will work correctly.  We
have seen issues with this code in the past.

One approach would be to introduce a second counter, clone_nest_level,
to take over the role that exec_level currently plays for key/slot
allocation and deferral triggering. exec_level could then be incremented
unconditionally for all synchronous do_execute_actions() calls, serving
as a stack-depth safeguard, while clone_nest_level preserves the existing=

deferral semantics.

For this patch, clone_nest_level could mirror the current exec_level
behaviour, i.e., increment when clone_flow_key is true, use the value as
the index into the flow_keys slot array, and defer when the slot array is=

exhausted. That would close the stack overflow window without changing
deferral behaviour for existing deployments.

As a follow-up patch we could refine clone_nest_level so that it only
advances when a key slot is actually allocated rather than on every
clone_flow_key=3Dtrue entry.

Have not tried to code this, but seems doable.

//Eelco


