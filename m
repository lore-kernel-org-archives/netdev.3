Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB25155A5D
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272489; cv=none; b=ZJjNansGXSQOKin9BJnzACvxgrqs7zwtIyAv384z3Be9kNHPEaB6KsK9iw1V5Latd97JPLb2mSZ7BxI15+Wulz1VJmWTOwYpQ/DBBgbA3ecDlEEUKlcfJHdmq+o7SBRttiSc9Jr4inpGVvsLcBZWJvkdYaiRDKa2yjEyExx97zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272489; c=relaxed/simple;
	bh=mMMs6TNd2h5GLaREkH8+T2L9t10862GpzsJBhokXF10=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I9LAPDnlOxinJtPGRGsGTWoIYPvFcNzV2oQ6nRTgnVR/sbGBLaup4s8RV8PHkrk7pAYF5sgtyswzCyqlYWx09qUbTKn9L5I1YrkM0QG4g4axvySSvSsP2xPvjgAaUR45P/fmtcun4L8JwUCMc07IOHzHABUgeS7F4KiFfZaFXxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CRRq+pxp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRRq+pxp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785272487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8CPMU1ZJL197k+K49RzhQKTURmn2Tp6RzSVMECzAefE=;
	b=CRRq+pxpiMQ+jTLI0caGJp1+xI0aCwfKp74CRxf79AU8D4U1zOAtXhxm86Og9DF5lJdfJu
	3ZrlM1DSTEUxYgvegIJWNYqUU6KHOAomd+hbSc2x0SQzjk+/FSlR4ix+4oPIOYcIB1tCxi
	BsoKLFMbb1uEWRa92Jtzw7T9Sa3n1GI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-cjOR0ef5OP-2b4YG6Jk3sg-1; Tue,
 28 Jul 2026 17:01:25 -0400
X-MC-Unique: cjOR0ef5OP-2b4YG6Jk3sg-1
X-Mimecast-MFC-AGG-ID: cjOR0ef5OP-2b4YG6Jk3sg_1785272483
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65C39195609F;
	Tue, 28 Jul 2026 21:01:23 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.35])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1CB11956088;
	Tue, 28 Jul 2026 21:01:21 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: i.maximets@ovn.org
Cc: alexyoung0@163.com, echaudro@redhat.com, security@kernel.org,
 dev@openvswitch.org, netdev@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, horms@kernel.org, edumazet@google.com,
 davem@davemloft.net
Subject: Re: [net] net: openvswitch: fix stack exhaustion from unaccounted
 clone_execute() recursion
In-Reply-To: <a56fe38b-5fc8-4845-8d68-d199d753dcee@ovn.org>
References: <178521875706.803907.3226960398667307795@163.com>
 <f7twlufw4js.fsf@redhat.com>
 <a56fe38b-5fc8-4845-8d68-d199d753dcee@ovn.org>
Date: Tue, 28 Jul 2026 17:01:20 -0400
Message-ID: <f7tse52x1zz.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Ilya Maximets <i.maximets@ovn.org> writes:

> On 7/28/26 4:51 PM, Aaron Conole wrote:
> > Hi Yang,
> > 
> > yang zhuorao <alexyoung0@163.com> writes:
> > 
> >> clone_execute() only increments and decrements exec_level when
> >> clone_flow_key is true.  When clone_flow_key is false the optimized
> >> path reuses the original flow key and calls do_execute_actions()
> >> directly without updating the recursion counter, making those layers
> >> invisible to the OVS_RECURSION_LIMIT check in ovs_execute_actions().
> >>
> >> A single action tree allows up to OVS_COPY_ACTIONS_MAX_DEPTH (16)
> >> nested clone actions.  When the innermost clone contains a RECIRC
> >> that selects another flow with its own 16-layer validation budget,
> >> multiple trees of unaccounted recursion can be stacked.  The deferred
> >> action threshold (OVS_DEFERRED_ACTION_THRESHOLD =
> >> OVS_RECURSION_LIMIT - 2 = 3) allows three synchronous recirc levels
> >> before clone_key() forces deferral, yielding 3 x 16 = 48 layers of
> >> synchronous, unaccounted clone recursion.
> >>
> >> Per-layer stack usage is approximately 296 bytes (from disassembly:
> >> do_execute_actions() allocates 0x98 bytes, clone_execute() allocates
> >> 0x20 bytes, plus saved registers and return address).  48 layers
> >> consume ~14,208 bytes before recirc, flow lookup, Netlink, and base
> >> call frames, exceeding the 16 KiB x86_64 task stack and hitting the
> >> guard page.
> >>
> >> An unprivileged user can trigger this from a private user/net
> >> namespace (clone(CLONE_NEWUSER | CLONE_NEWNET)) by installing three
> >> flow rules each with 16 nested clone actions linked by RECIRC, then
> >> injecting a single packet via OVS_PACKET_CMD_EXECUTE.  The result is
> >> a kernel panic:
> >>
> >>     BUG: TASK stack guard page was hit ...
> >>     CPU: 0 UID: 1000 PID: 85 ... 7.2.0-rc5+
> >>     RIP: 0010:clone_execute+0x5a/0x2c0 [openvswitch]
> >>     [do_execute_actions / clone_execute alternating repeatedly]
> >>     Kernel panic - not syncing: Fatal exception in interrupt
> >>
> >> Fix this by unconditionally incrementing exec_level for all
> >> synchronous clone recursion edges and checking OVS_RECURSION_LIMIT
> >> before calling do_execute_actions().  When the limit is exceeded the
> >> packet is dropped and -ENETDOWN is returned, consistent with the
> >> existing handling in ovs_execute_actions().
> >>
> >> Tested on Linux 7.2.0-rc5+ (mainline HEAD 62cc90241548), x86_64,
> >> CONFIG_VMAP_STACK=y, CONFIG_OPENVSWITCH=m, isolated QEMU guest.
> >> Confirmed that the PoC (./poc_clone_overflow 2 16 3, run as UID 1000)
> >> no longer triggers a panic with this patch applied.
> >>
> >> Fixes: b233504033db ("openvswitch: kernel datapath clone action")
> >> Cc: stable@vger.kernel.org
> >> Reported-by: yang zhuorao <alexyoung0@163.com>
> >> Signed-off-by: yang zhuorao <alexyoung0@163.com>
> >> ---
> >> Reproducer (C, single file, available upon request):
> >>
> >>     gcc -O2 -Wall -o poc_clone_overflow poc_clone_overflow.c
> >>     ./poc_clone_overflow 2 16 3   # as unprivileged user
> >>
> >> The PoC creates a private user/net namespace, installs three flows
> >> each with 16 nested clone actions linked by RECIRC, and injects a
> >> triggering packet.  Prerequisites: CONFIG_OPENVSWITCH=m/y loaded,
> >> unprivileged user namespace creation allowed.
> >>
> >> Verified unfixed in Linus mainline (62cc90241548), net (97ac08560d23),
> >> and net-next (a50eba1e778a) as of 2026-07-27.
> >>
> >>  net/openvswitch/actions.c | 13 +++++++++----
> >>  1 file changed, 9 insertions(+), 4 deletions(-)
> >>
> >> --
> > 
> > General - please remember to CC the netdev maintainers as well.
> > 
> > [...]
> > 
> >> @@ -1497,14 +1497,19 @@ static int clone_execute(struct datapath *dp, struct sk_buff *skb,
> >>  	if (clone) {
> >>  		int err = 0;
> >>  		if (actions) { /* Sample action */
> >> -			if (clone_flow_key)
> >> -				__this_cpu_inc(ovs_pcpu_storage->exec_level);
> >> +			__this_cpu_inc(ovs_pcpu_storage->exec_level);
> >> +
> >> +			if (unlikely(__this_cpu_read(ovs_pcpu_storage->exec_level) >
> >> +				     OVS_RECURSION_LIMIT)) {
> >> +				__this_cpu_dec(ovs_pcpu_storage->exec_level);
> >> +				ovs_kfree_skb_reason(skb, OVS_DROP_RECURSION_LIMIT);
> >> +				return -ENETDOWN;
> >> +			}
> > 
> > There is an existing check for recursion in ovs_execute_actions() and in
> > there we have a log before dropping:
> > 
> > 	net_crit_ratelimited("ovs: recursion limit reached on datapath %s, probable configuration error\n",
> > 			     ovs_dp_name(dp));
> > 
> > We should have a similar log here so we're not silently dropping.  But,
> > since we now have two places where this check occurs (and it's
> > complicated because of how deferred actions is processed), maybe it's
> > better to have a function that does the management:
> > 
> >   static int ovs_exec_level_enter(struct datapath *dp, struct sk_buff *skb) {
> >   	int level;
> > 
> >   	level = __this_cpu_inc_return(ovs_pcpu_storage->exec_level);
> >   	if (unlikely(level > OVS_RECURSION_LIMIT)) {
> >   		net_crit_ratelimited("ovs: recursion limit reached on datapath %s, probable configuration error\n",
> >   				     ovs_dp_name(dp));
> >   		ovs_kfree_skb_reason(skb, OVS_DROP_RECURSION_LIMIT);
> >   		return -ENETDOWN;
> >   	}
> >   	return 0;
> >   }
> > 
> >   static void ovs_exec_level_exit(void) {
> >   	__this_cpu_dec(ovs_pcpu_storage->exec_level);
> >   }
> > 
> > Then just put the enter/exit calls in the clone_execute() and
> > ovs_execute_actions() spaces.  That way if we need to adjust this limit
> > in the future, it's consolidated to just one place.
> > 
> 
> 
> There is a different issue here though.  The exec_level is used as a
> counter for the flow keys during the clone.  And if we increment it
> unconditionally while not allocating new keys, we'll ran out of key
> slots much faster without actually using them.  This will lead to
> much more actions to be deferred and packets dropped in the end.
> There is already a mismatch here as ovs_execute_actions() increments
> the level without allocating the key, but doing so also for non-recirc
> cases would significantly amplify the problem.

That's an additional concern, but the code path at least currently
handles the event that we advance beyond the clone flow key per-cpu
array.  This change makes a low-likelihood scenario a bit worse (the
case where we have lots of clones + sub-actions).  I don't think it
needs to be addressed with this work since this is a security fix, but
we should address it via a follow up change (and I can work on that if
needed).  AFAICT the affected actions are:

- sample()
- clone()
- dec_ttl()
- check_pkt_len()

I think in most deployments I've seen they only nest once or twice, and
we should have 3 'nests' worth of clone flow keys to handle it, meaning
that the increased pressure should still fit within the slots we have
(we just wouldn't support another nest, which is different from today):
ie: nest 1, we are 'taking' slot 2 (key[1]), and nest 2 we are 'taking'
slot 3 (key[2]), which leaves no more available.

For example, check_pkt_len(..., check_pkt_len(...)) would still work as
long as there's no sample() wrapped around it, or a dec_ttl within it,
or some other more complex scenario.  And it seems to be very heavy
handed to ask for a fix that includes both the stack overflow and the
clone allocation change together.

> We likely need to decouple the recursion level couter from the slot
> index in the keys array.  Though they still should stay related as
> we should start deferring when we approach recursion limit even if
> we still have some free slots for key clones.

Agreed, we need to have two discreet operations - one to track the stack
recursion and one to do the clone flow key allocation.  Unless you feel
strongly that they should come as part of the same series, but it seems
a lot.

> Best regards, Ilya Maximets.

