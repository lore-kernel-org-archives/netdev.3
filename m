Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E81C84DC
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250308; cv=none; b=oLwW+Ul6dhwQLbWVTVl/a9sbNCJotl4G+imupY6SnEHDXB2YrXRAlL3DgnVUtyPIlLpOZAXgEY45d9IiU+Y8CcbGthBNF5JPSr1GIhbGVEleLLPN34F2hCkEzGwt9PMkn5gHTNAXorOgl1oxOLXafiuYSEpcKV6XQqwZK3hb5sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250308; c=relaxed/simple;
	bh=v04CGbLKLwuYUscXUu0EZuQfSDN/XtVTpSlIeFD528A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=exUxKrSsUyDZny1Sx9LfWFKM4Pdan/PLvRPhyQ6W6MPl9tEOVyXE2dc5Y9pPUd00qMN5/rRoeK9RW4qMz0BpyT5IvPsfdOULSN6lYpYAqvyrQfxzyM7+p4kbhFMd25bFUR4kdUO4mnTux0I21c+t5eg+WsZo7Z3YB8wi6dvtcfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JuRCvKSJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuRCvKSJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785250305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UTKNj2v00LQZeKS0M1n4cAi6ueVd94ATqtoaPg877Uc=;
	b=JuRCvKSJCBjjE0DamsY+cvfaYMNTVTppS0XulLU3t7aRFKT88At4resreabBwP8H72uEWi
	mzqQGkvLwwnafywzNVrqhmgPhOk0YFE35XsK/GflMeWK6a5LdOfBaY0afxg6JzSTxpu4tA
	eSrWbXWzTv4eLQQvCb8G1Vx1pN1ARcg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-hOf5FVcdO_SJaoohBtedwQ-1; Tue,
 28 Jul 2026 10:51:41 -0400
X-MC-Unique: hOf5FVcdO_SJaoohBtedwQ-1
X-Mimecast-MFC-AGG-ID: hOf5FVcdO_SJaoohBtedwQ_1785250298
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B77F195604A;
	Tue, 28 Jul 2026 14:51:38 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.35])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9146742A;
	Tue, 28 Jul 2026 14:51:36 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: alexyoung0@163.com
Cc: echaudro@redhat.com, i.maximets@ovn.org, security@kernel.org,
 dev@openvswitch.org, netdev@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, horms@kernel.org, edumazet@google.com,
 davem@davemloft.net
Subject: Re: [net] net: openvswitch: fix stack exhaustion from unaccounted
 clone_execute() recursion
In-Reply-To: <178521875706.803907.3226960398667307795@163.com>
References: <178521875706.803907.3226960398667307795@163.com>
Date: Tue, 28 Jul 2026 10:51:35 -0400
Message-ID: <f7twlufw4js.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Hi Yang,

yang zhuorao <alexyoung0@163.com> writes:

> clone_execute() only increments and decrements exec_level when
> clone_flow_key is true.  When clone_flow_key is false the optimized
> path reuses the original flow key and calls do_execute_actions()
> directly without updating the recursion counter, making those layers
> invisible to the OVS_RECURSION_LIMIT check in ovs_execute_actions().
> 
> A single action tree allows up to OVS_COPY_ACTIONS_MAX_DEPTH (16)
> nested clone actions.  When the innermost clone contains a RECIRC
> that selects another flow with its own 16-layer validation budget,
> multiple trees of unaccounted recursion can be stacked.  The deferred
> action threshold (OVS_DEFERRED_ACTION_THRESHOLD =
> OVS_RECURSION_LIMIT - 2 = 3) allows three synchronous recirc levels
> before clone_key() forces deferral, yielding 3 x 16 = 48 layers of
> synchronous, unaccounted clone recursion.
> 
> Per-layer stack usage is approximately 296 bytes (from disassembly:
> do_execute_actions() allocates 0x98 bytes, clone_execute() allocates
> 0x20 bytes, plus saved registers and return address).  48 layers
> consume ~14,208 bytes before recirc, flow lookup, Netlink, and base
> call frames, exceeding the 16 KiB x86_64 task stack and hitting the
> guard page.
> 
> An unprivileged user can trigger this from a private user/net
> namespace (clone(CLONE_NEWUSER | CLONE_NEWNET)) by installing three
> flow rules each with 16 nested clone actions linked by RECIRC, then
> injecting a single packet via OVS_PACKET_CMD_EXECUTE.  The result is
> a kernel panic:
> 
>     BUG: TASK stack guard page was hit ...
>     CPU: 0 UID: 1000 PID: 85 ... 7.2.0-rc5+
>     RIP: 0010:clone_execute+0x5a/0x2c0 [openvswitch]
>     [do_execute_actions / clone_execute alternating repeatedly]
>     Kernel panic - not syncing: Fatal exception in interrupt
> 
> Fix this by unconditionally incrementing exec_level for all
> synchronous clone recursion edges and checking OVS_RECURSION_LIMIT
> before calling do_execute_actions().  When the limit is exceeded the
> packet is dropped and -ENETDOWN is returned, consistent with the
> existing handling in ovs_execute_actions().
> 
> Tested on Linux 7.2.0-rc5+ (mainline HEAD 62cc90241548), x86_64,
> CONFIG_VMAP_STACK=y, CONFIG_OPENVSWITCH=m, isolated QEMU guest.
> Confirmed that the PoC (./poc_clone_overflow 2 16 3, run as UID 1000)
> no longer triggers a panic with this patch applied.
> 
> Fixes: b233504033db ("openvswitch: kernel datapath clone action")
> Cc: stable@vger.kernel.org
> Reported-by: yang zhuorao <alexyoung0@163.com>
> Signed-off-by: yang zhuorao <alexyoung0@163.com>
> ---
> Reproducer (C, single file, available upon request):
> 
>     gcc -O2 -Wall -o poc_clone_overflow poc_clone_overflow.c
>     ./poc_clone_overflow 2 16 3   # as unprivileged user
> 
> The PoC creates a private user/net namespace, installs three flows
> each with 16 nested clone actions linked by RECIRC, and injects a
> triggering packet.  Prerequisites: CONFIG_OPENVSWITCH=m/y loaded,
> unprivileged user namespace creation allowed.
> 
> Verified unfixed in Linus mainline (62cc90241548), net (97ac08560d23),
> and net-next (a50eba1e778a) as of 2026-07-27.
> 
>  net/openvswitch/actions.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> --

General - please remember to CC the netdev maintainers as well.

[...]

> @@ -1497,14 +1497,19 @@ static int clone_execute(struct datapath *dp, struct sk_buff *skb,
>  	if (clone) {
>  		int err = 0;
>  		if (actions) { /* Sample action */
> -			if (clone_flow_key)
> -				__this_cpu_inc(ovs_pcpu_storage->exec_level);
> +			__this_cpu_inc(ovs_pcpu_storage->exec_level);
> +
> +			if (unlikely(__this_cpu_read(ovs_pcpu_storage->exec_level) >
> +				     OVS_RECURSION_LIMIT)) {
> +				__this_cpu_dec(ovs_pcpu_storage->exec_level);
> +				ovs_kfree_skb_reason(skb, OVS_DROP_RECURSION_LIMIT);
> +				return -ENETDOWN;
> +			}

There is an existing check for recursion in ovs_execute_actions() and in
there we have a log before dropping:

	net_crit_ratelimited("ovs: recursion limit reached on datapath %s, probable configuration error\n",
			     ovs_dp_name(dp));

We should have a similar log here so we're not silently dropping.  But,
since we now have two places where this check occurs (and it's
complicated because of how deferred actions is processed), maybe it's
better to have a function that does the management:

  static int ovs_exec_level_enter(struct datapath *dp, struct sk_buff *skb) {
  	int level;

  	level = __this_cpu_inc_return(ovs_pcpu_storage->exec_level);
  	if (unlikely(level > OVS_RECURSION_LIMIT)) {
  		net_crit_ratelimited("ovs: recursion limit reached on datapath %s, probable configuration error\n",
  				     ovs_dp_name(dp));
  		ovs_kfree_skb_reason(skb, OVS_DROP_RECURSION_LIMIT);
  		return -ENETDOWN;
  	}
  	return 0;
  }

  static void ovs_exec_level_exit(void) {
  	__this_cpu_dec(ovs_pcpu_storage->exec_level);
  }

Then just put the enter/exit calls in the clone_execute() and
ovs_execute_actions() spaces.  That way if we need to adjust this limit
in the future, it's consolidated to just one place.

