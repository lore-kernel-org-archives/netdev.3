Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFCB30C618;
	Sat,  5 Sep 2026 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788637592; cv=none; b=QH6Xtz4pNL+Wrhi5io9iFSyvLz1Sab3vAZWhGGhhiQp7HezpNlWzJS++yBxj0pxHfGJoxAeqG7X3UXm9yh+2aAZDxxWNB3JSv3WHaoVJNXpNRyPuwj9Fu0P6JpioZYu0QhTmfGLdgcvvRzK38XjxCgeFOaKK1Dm59X5jhhAzEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788637592; c=relaxed/simple;
	bh=bT58/hIVivXfR+cVIAQdAXf64R1sSvSWyXwRcd0goCM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hDyLKxW2kz/zGXuAnwuAXZvlzVad1uGWBX7rmRpWWTZ08IAlVmKd+dD1KXc+YETgKV4ssLVI10gtgqnYKzvxuD12LDzDKm1MY0ZGCug6ArYo1gquAy6bJE0VYYSJUTSCM/u3Vup7LUTENb67m/6Z9pXowJ3H2I+KIoF5Vcy+6Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM+gIQ5u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM+gIQ5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FD11F00A3A;
	Sat,  5 Sep 2026 19:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788637584;
	bh=2ObsW+H/YcTNdLYYwjDqgLrl8yqGH0OOU+Xl/KFFj44=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DM+gIQ5umb0S4dOcxfDstp3iHyZTuwnrcL1SxqF0AH/tfnUbvis3jIbITF8a22d+r
	 l79BHaXWER1vNtOOO32IBCkuPwSySLK+rmnpXk1eLEX3lfjrHUB/Lrw8/Mwk2XQLy4
	 Ed8Cf389mFhcS+beWBErDJcRUG8IemSavE4Ze9Ib5VIotFG95ohKdtHA8ak4g+s3av
	 h0ZbYJ5OUuFgzA3vG3uP6KY80EwE88jcUK6yz0FfmrYyit7P2jlMVTsnmprew5b58v
	 15yM8GYICHZeA6l8Iz+rjNw+yKmyR5aZVRQj8jX0p11cIt72LR/SiBDoe7w4OdbtW7
	 t43SH9N2berxw==
Subject: Re: [PATCH net] atm: pppoatm: reject duplicate backend assignment
From: netdev-bot+sashiko@kernel.org
To: v3rdant.xiang@gmail.com
Cc: mitch@sfgoth.com, 3chas3@gmail.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Date: Sat, 05 Sep 2026 19:46:23 +0000
Message-ID: <178863758341.219967.1263005070837622760@kernel.org>
In-Reply-To: <20260902040320.4007552-1-v3rdant.xiang@gmail.com>
References: <20260902040320.4007552-1-v3rdant.xiang@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

- [High] Incomplete fix: the new `if (atmvcc->user_back) return -EBUSY;`
  guard in pppoatm_assign_vcc() (net/atm/pppoatm.c:399) only rejects a…

Pre-existing issues:
- [Medium] pppoatm_assign_vcc() publishes the backend with two plain,
  unordered stores: `atmvcc->user_back = pvcc;` immediately followed by…

--

atm: pppoatm: reject duplicate backend assignment

This adds a check in pppoatm_assign_vcc() that returns -EBUSY when
atmvcc->user_back is already populated, so a second ATM_SETBACKEND with
ATM_BACKEND_PPP cannot stack a second pppoatm_vcc on the same VCC. The
commit message describes the resulting NULL user_back dereference during
VCC teardown as the bug being fixed.

> diff --git a/net/atm/pppoatm.c b/net/atm/pppoatm.c
> index 6da52d12df68e..93ba22f437bc9 100644
> --- a/net/atm/pppoatm.c
> +++ b/net/atm/pppoatm.c
> @@ -396,6 +396,8 @@ static int pppoatm_assign_vcc(struct atm_vcc *atmvcc, void __user *arg)
>  	if (be.encaps != PPPOATM_ENCAPS_AUTODETECT &&
>  	    be.encaps != PPPOATM_ENCAPS_VC && be.encaps != PPPOATM_ENCAPS_LLC)
>  		return -EINVAL;
> +	if (atmvcc->user_back)
> +		return -EBUSY;

[Severity: High]
Does this guard close the described crash, or only the pppoatm-over-pppoatm
ordering of it?  pppoatm is not the only writer of atmvcc->user_back.
br2684_regvcc() in net/atm/br2684.c writes the same field, and its only
ownership checks are:

net/atm/br2684.c:br2684_regvcc() {
	...
	if (atmvcc->push == NULL) {
		err = -EBADFD;
		goto error;
	}
	if (!list_empty(&brdev->brvccs)) {
		/* Only 1 VCC/dev right now */
		err = -EEXIST;
		goto error;
	}
	...
}

After pppoatm_assign_vcc() has installed pppoatm_push, atmvcc->push is
non-NULL, and a freshly created nas device from ATM_NEWBACKENDIF has an
empty brvccs list, so neither check fires.  br2684_regvcc() then does:

net/atm/br2684.c:br2684_regvcc() {
	...
	atmvcc->user_back = brvcc;
	brvcc->encaps = (enum br2684_encaps)be.encaps;
	brvcc->old_push = atmvcc->push;
	...
}

which overwrites the pppoatm private pointer and chains pppoatm_push as
old_push.

On close, vcc_destroy_socket() calls vcc->push(vcc, NULL) -> br2684_push()
-> br2684_close_vcc():

net/atm/br2684.c:br2684_close_vcc() {
	...
	brvcc->atmvcc->user_back = NULL;	/* what about vcc->recvq ??? */
	brvcc->atmvcc->release_cb = brvcc->old_release_cb;
	brvcc->old_push(brvcc->atmvcc, NULL);	/* pass on the bad news */
	...
}

so pppoatm_push() runs with user_back already NULL and dereferences it:

net/atm/pppoatm.c:pppoatm_push() {
	...
		module = pvcc->old_owner;
		pppoatm_unassign_vcc(atmvcc);
	...
}

Is that not the same NULL dereference the commit message says is removed,
just with the two ATM_SETBACKEND calls in the opposite order?

While both backends are stacked, can this also corrupt memory?  br2684_pop()
calls brvcc->old_pop, which is pppoatm_pop():

net/atm/pppoatm.c:pppoatm_pop() {
	struct pppoatm_vcc *pvcc = atmvcc_to_pvcc(atmvcc);

	pvcc->old_pop(atmvcc, skb);
	atomic_dec(&pvcc->inflight);
	...
}

Here user_back points at a struct br2684_vcc, so pvcc->old_pop is an
indirect call through br2684_vcc::old_push and atomic_dec(&pvcc->inflight)
writes into br2684_vcc::old_owner.  The same type confusion applies to
br2684_release_cb() -> pppoatm_release_cb().  The first pvcc also stays
registered via ppp_register_channel() with a live tasklet, and its
__module_get(THIS_MODULE) is never balanced, since teardown now runs through
br2684_push().

Regarding this part of the commit message:

    do_vcc_ioctl() holds ioctl_mutex while invoking backend handlers, so
    concurrent backend assignments cannot race past this check.

Is serialization the relevant property here?  do_vcc_ioctl() offers
ATM_SETBACKEND to every registered backend handler with no core-level
"backend already assigned" rejection:

net/atm/ioctl.c:do_vcc_ioctl() {
	...
	list_for_each(pos, &ioctl_list) {
		struct atm_ioctl *ic = list_entry(pos, struct atm_ioctl, list);
		if (try_module_get(ic->owner)) {
			error = ic->ioctl(sock, cmd, arg);
	...
}

so the other writer of user_back runs under the same mutex without any such
guard.  Would it make sense to add the same rejection to br2684_regvcc(), or
to do the check once in the shared ATM_SETBACKEND dispatch instead?

>  	pvcc = kzalloc_obj(*pvcc);
>  	if (pvcc == NULL)
>  		return -ENOMEM;

[Severity: Medium]
This isn't a bug introduced by this patch, but since the same field is
involved: is the publication of user_back ordered against the publication of
the push callback?  Further down in pppoatm_assign_vcc() the two stores are
plain and adjacent:

net/atm/pppoatm.c:pppoatm_assign_vcc() {
	...
	atmvcc->user_back = pvcc;
	atmvcc->push = pppoatm_push;
	atmvcc->pop = pppoatm_pop;
	...
}

ATM_SETBACKEND requires sock->state == SS_CONNECTED, and the driver receive
path calls vcc->push(vcc, skb) from softirq context without any lock shared
with do_vcc_ioctl(), which holds only ioctl_mutex.  If the store to
atmvcc->push becomes visible first, pppoatm_push() reads user_back as NULL
and dereferences it with no NULL check:

net/atm/pppoatm.c:pppoatm_push() {
	struct pppoatm_vcc *pvcc = atmvcc_to_pvcc(atmvcc);
	pr_debug("\n");
	if (skb == NULL) {
	...
		module = pvcc->old_owner;
	...
	switch (pvcc->encaps) {
	...
}

The sibling backend orders the same sequence explicitly:

net/atm/br2684.c:br2684_regvcc() {
	...
	brvcc->old_owner = atmvcc->owner;
	barrier();
	atmvcc->push = br2684_push;
	...
}

Would smp_store_release(&atmvcc->push, pppoatm_push) after user_back is set
be appropriate here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902040320.4007552-1-v3rdant.xiang%40gmail.com
