Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB683D7D83;
	Sun, 20 Sep 2026 22:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789944854; cv=none; b=KKX1GLB+3xkI7MuEFNFIlEfpo1S1WhSDV9S+R2KJK7LwJZ5FQArhqL5rt3lpp7jV1o/0YOZPHgRHbGYhf1wSDRfW5gK54PD8C1iflz0Iycz8nye97Zflf3J4ev7vCWeWGU6j83RfxgKCVru1CzSuFcsh6d72RlcZciwpksd03Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789944854; c=relaxed/simple;
	bh=SAGSC0TxHuVSU+IrRz7OEatPFjxEvaovOnrHzWRj698=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DKkzKwuZlOwdF9K3aCngap513g2jk/EIMcNrHQkaA0dq0haTO1Ix8Ylw5FZ2KyAZ0UaM3qz5V95B9SfwvpCdeWqSMdnsMythQcvsD2QzOkhv3t7Sjobp6dlXP3Kf4OYsGpaYFDvPlei3cMI3Isr6ulSe56tZFeEpjJligbVGkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACtTESMI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACtTESMI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891E01F00893;
	Sun, 20 Sep 2026 22:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789944852;
	bh=fpMaNOF200ruNa8+qU2rrp0Ikc1uFJ8IxTeaxltif/8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ACtTESMID6emUnfiYA8s9lDatpfEg9HxxcjfU1AJu6c/BLTF1EuTQeVv68KZiv3tD
	 HyG6gtdYA+2YaG4wtHiITl4A4DQkyhYFhwcoz1DUlzqfuugWZ19rLH7330i2Rsu90o
	 SbmNTQLC0wGY7hn5UOWVYDg8WeRuaQ2uDgGZj4VZo7WJcl1IwUTsd7Jh8lL1tcOiiB
	 F/que6C4C44jOPWJ2gWkA5fUfA907HPp+yCCExaNdAkFC6E84DBgikKxvYQ00KtLun
	 eznVPVrCncbC6HKssU1ZVbuJuygV4OUDMmmJ7ukZcndI3aJNazYUpoHErXZStOsKVC
	 qnB6Hcz14GY4A==
Subject: Re: [PATCH] atm: br2684, pppoatm: add missing pskb_may_pull() and
 headroom checks
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: 3chas3@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 22:54:11 +0000
Message-ID: <178994485114.2160803.13338464513075293200@kernel.org>
In-Reply-To: <20260919223431.3882212-1-benquike@gmail.com>
References: <20260919223431.3882212-1-benquike@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 2 · Low: 0 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Commit message advertises a transmit-side fix that the patch
  does not contain.
- [High] Newly introduced memory leak in pppoatm_assign_vcc()
  (net/atm/pppoatm.c).
- [Medium] The patch bundles three functional changes that have nothing
  to do with pskb_may_pull()/headroom validation and are not mentioned…
- [Medium] The receive hardening the commit message claims is incomplete
  in br2684_push() and entirely missing in pppoatm_push().

Pre-existing issues:
- [High] Use-after-free write in br2684_setfilt()
  (net/atm/br2684.c:359-388), the exact critical section this patch…
- [Low] Concern: the new `if (atmvcc->user_back) return -EINVAL;` checks
  give atm_vcc->user_back a new meaning ('a backend is already…
- [Low] Concern: brvcc->filter (prefix + netmask) is published by a plain
  `memcpy(&brvcc->filter, &fs.filter, sizeof(brvcc->filter));` in…

--

atm: br2684, pppoatm: add missing pskb_may_pull() and headroom checks

The patch converts several total-length tests in br2684_push() and
packet_fails_filter() to pskb_may_pull(), adds a NULL device test around
br2684_find_dev() in br2684_setfilt(), and rejects a repeated backend
assignment in br2684_regvcc() and pppoatm_assign_vcc().

A few questions below about the commit message and about the new
pppoatm_assign_vcc() return path.

> atm: br2684, pppoatm: add missing pskb_may_pull() and headroom checks
>
> In net/atm/br2684.c and net/atm/pppoatm.c, verify packet header lengths
> with pskb_may_pull() on receive and ensure sufficient skb headroom via
> skb_cow_head() before skb_push() on transmit.

[Severity: High]
Can the "ensure sufficient skb headroom via skb_cow_head() before
skb_push() on transmit" part of this description be matched to the diff?
No transmit function is touched by the patch.

In net/atm/br2684.c, br2684_xmit_vcc() still tests only the size of the
headroom:

	if (skb_headroom(skb) < minheadroom) {
		struct sk_buff *skb2 = skb_realloc_headroom(skb, minheadroom);

and then writes into the head area:

		skb_push(skb, sizeof(llc_oui_pid_pad));
		skb_copy_to_linear_data(skb, llc_oui_pid_pad,
					sizeof(llc_oui_pid_pad));

with the same pattern for skb_push(skb, sizeof(llc_oui_ipv4)) and for
skb_push(skb, 2) plus memset(skb->data, 0, 2). There is no
skb_cow_head() or skb_header_cloned() test anywhere in br2684.c, so an
skb that already satisfies skb_headroom(skb) >= minheadroom but whose
head is shared (for example a clone taken by an AF_PACKET tap before
ndo_start_xmit) still gets the encapsulation written into the shared
head.

In net/atm/pppoatm.c, pppoatm_send() already contained

		if (skb_cow_head(skb, LLC_LEN)) {

before this patch, so nothing is added there either.

The same paragraph claims pskb_may_pull() receive hardening "in
net/atm/br2684.c and net/atm/pppoatm.c", but pppoatm_push() is not
modified at all. Could the commit message be narrowed to what the diff
actually changes?

[Severity: Medium]
The patch also carries three functional changes that are unrelated to
header-length validation and are not mentioned in the commit message:
the net_dev NULL test in br2684_setfilt(), and the
"if (atmvcc->user_back) return -EINVAL;" tests in br2684_regvcc() and
pppoatm_assign_vcc().

The br2684_setfilt() hunk fixes a real NULL dereference: netdev_priv()
is "return (void *)dev->priv;", so the previous
"brdev = BRPRIV(br2684_find_dev(&fs.ifspec));" dereferenced NULL when
the lookup failed, before the existing "brdev == NULL" test could run.

The two user_back tests change externally visible ioctl behaviour: a
second ATM_SETBACKEND now returns -EINVAL. For pppoatm that closes
state corruption, since pppoatm_ioctl() deliberately lets ATM_SETBACKEND
through:

	if (cmd != ATM_SETBACKEND && atmvcc->push != pppoatm_push)
		return -ENOIOCTLCMD;

so a repeated ATM_SETBACKEND previously re-entered pppoatm_assign_vcc()
and captured pppoatm's own callbacks into pvcc->old_push/old_pop while
orphaning the first pvcc and its registered PPP channel.

Would it make sense to split these into separate patches with their own
Fixes: tags and impact descriptions?

> diff --git a/net/atm/br2684.c b/net/atm/br2684.c
> index 05712c28386a..4e397b1a3a27 100644
> --- a/net/atm/br2684.c
> +++ b/net/atm/br2684.c
> @@ -369,8 +369,11 @@ static int br2684_setfilt(struct atm_vcc *atmvcc, void __user * arg)
>  		 * by device.
>  		 */
>  		struct br2684_dev *brdev;
> +		struct net_device *net_dev;
> +
>  		read_lock(&devs_lock);
> -		brdev = BRPRIV(br2684_find_dev(&fs.ifspec));
> +		net_dev = br2684_find_dev(&fs.ifspec);
> +		brdev = net_dev ? BRPRIV(net_dev) : NULL;
>  		if (brdev == NULL || list_empty(&brdev->brvccs) ||
>  		    brdev->brvccs.next != brdev->brvccs.prev)	/* >1 VCC */
>  			brvcc = NULL;

[Severity: High]
This isn't a bug introduced by this patch, but since this lookup block
is being rewritten here: can the brvcc pointer found under devs_lock go
away before it is used?  br2684_setfilt() drops the lock and only then
writes into the object:

		read_unlock(&devs_lock);
		if (brvcc == NULL)
			return -ESRCH;
	} else
		brvcc = BR2684_VCC(atmvcc);
	memcpy(&brvcc->filter, &fs.filter, sizeof(brvcc->filter));

No reference is taken on brvcc, and the object belongs to a different
socket.  Concurrently br2684_close_vcc() removes and frees it:

	write_lock_irq(&devs_lock);
	list_del(&brvcc->brvccs);
	write_unlock_irq(&devs_lock);
	...
	kfree(brvcc);

The two paths do not share a lock.  The ioctl side holds only
ioctl_mutex:

net/atm/ioctl.c:do_vcc_ioctl() {
	...
	mutex_lock(&ioctl_mutex);
	list_for_each(pos, &ioctl_list) {
		struct atm_ioctl *ic = list_entry(pos, struct atm_ioctl, list);
		if (try_module_get(ic->owner)) {
			error = ic->ioctl(sock, cmd, arg);
	...
}

and the free side comes from close(2) on the target socket:

vcc_release() -> vcc_destroy_socket() {
	...
	if (vcc->push)
		vcc->push(vcc, NULL); /* atmarpd has no push */
	...
}
 -> br2684_push(NULL) -> br2684_close_vcc() -> kfree(brvcc)

which never takes ioctl_mutex.  If that completes in the window after
read_unlock(&devs_lock), does the memcpy() write into freed slab memory?
Would doing the filter update while still holding devs_lock close the
window?

> @@ -392,6 +395,7 @@ packet_fails_filter(__be16 type, struct br2684_vcc *brvcc, struct sk_buff *skb)
>  	if (brvcc->filter.netmask == 0)
>  		return 0;	/* no filter in place */
>  	if (type == htons(ETH_P_IP) &&
> +	    pskb_may_pull(skb, sizeof(struct iphdr)) &&
>  	    (((struct iphdr *)(skb->data))->daddr & brvcc->filter.
>  	     netmask) == brvcc->filter.prefix)
>  		return 0;

[Severity: Low]
This is a pre-existing issue, but while the reader is being touched
here: brvcc->filter is published by a plain
memcpy(&brvcc->filter, &fs.filter, sizeof(brvcc->filter)) in
br2684_setfilt() after devs_lock has been released, while this function
reads netmask and prefix as two independent loads from ATM driver
softirq context.  Can a packet be matched against a new netmask combined
with the old prefix during a BR2684_SETFILT update?

> @@ -449,7 +453,7 @@ static void br2684_push(struct atm_vcc *atmvcc, struct sk_buff *skb)
>  			__skb_trim(skb, skb->len - 4);
>  
>  		/* accept packets that have "ipv[46]" in the snap header */
> -		if ((skb->len >= (sizeof(llc_oui_ipv4))) &&
> +		if (pskb_may_pull(skb, sizeof(llc_oui_ipv4)) &&
>  		    (memcmp(skb->data, llc_oui_ipv4,
>  			    sizeof(llc_oui_ipv4) - BR2684_ETHERTYPE_LEN) == 0)) {
>  			if (memcmp(skb->data + 6, ethertype_ipv6,

[Severity: Medium]
Is the receive hardening complete?  The statement just above this hunk
in br2684_push(), which runs before the first pskb_may_pull() added
here, still dereferences the linear area based on the total length:

		if (skb->len > 7 && skb->data[7] == 0x01)
			__skb_trim(skb, skb->len - 4);

pppoatm_push() is not changed either, and it has the same shape:

net/atm/pppoatm.c:pppoatm_push() {
	...
		if (skb->len < LLC_LEN ||
		    memcmp(skb->data, pppllc, LLC_LEN))
			goto error;
		skb_pull(skb, LLC_LEN);
	...
		if (skb->len >= sizeof(pppllc) &&
		    !memcmp(skb->data, pppllc, sizeof(pppllc))) {
			pvcc->encaps = e_llc;
			skb_pull(skb, LLC_LEN);
	...
		pr_debug("Couldn't autodetect yet (skb: %6ph)\n", skb->data);
	...
}

If a non-linear skb whose linear part is shorter than the compared
header ever reaches these sites, do the memcmp() calls read past the
linear region, and can the following skb_pull() drop skb->len below
skb->data_len and hit the BUG() in __skb_pull()?  The %6ph dump also
has no guarantee that six bytes are present.

I could not find an in-tree ATM driver that builds fragmented receive
skbs (no skb_fill_page_desc/skb_add_rx_frag/nr_frags use under
drivers/atm), so this may be unreachable today; the question is whether
the stated goal of the patch is met in both files.

[ ... ]

> @@ -535,6 +543,8 @@ static int br2684_regvcc(struct atm_vcc *atmvcc, void __user * arg)
>  	struct atm_backend_br2684 be;
>  	int err;
>  
> +	if (atmvcc->user_back)
> +		return -EINVAL;
>  	if (copy_from_user(&be, arg, sizeof be))
>  		return -EFAULT;
>  	brvcc = kzalloc_obj(struct br2684_vcc);

[Severity: Low]
This is a pre-existing documentation issue, but the new test reads
user_back as an "a backend is already attached" indicator, which reads
oddly against its description in include/linux/atmdev.h:

	void		*user_back;	/* user backlink - not touched by the */
					/* native ATM stack, used by sch_atm */

net/sched/sch_atm.c no longer exists, and br2684/pppoatm already both
write this field.  Would it be worth updating that comment?

> diff --git a/net/atm/pppoatm.c b/net/atm/pppoatm.c
> index 5214786e61d1..c3a693e20aba 100644
> --- a/net/atm/pppoatm.c
> +++ b/net/atm/pppoatm.c
> @@ -397,6 +397,8 @@ static int pppoatm_assign_vcc(struct atm_vcc *atmvcc, void __user *arg)
>  	atomic_set(&pvcc->inflight, NONE_INFLIGHT);
>  	pvcc->old_push = atmvcc->push;
>  	pvcc->old_pop = atmvcc->pop;
> +	if (atmvcc->user_back)
> +		return -EINVAL;

[Severity: High]
Does this return leak pvcc?  The allocation has already happened above:

	pvcc = kzalloc_obj(*pvcc);
	if (pvcc == NULL)
		return -ENOMEM;

pvcc is still the only reference at this point: it is stored into
atmvcc->user_back only later, after ppp_register_channel().  The other
post-allocation failure path in the same function frees it:

	err = ppp_register_channel(&pvcc->chan);
	if (err != 0) {
		kfree(pvcc);
		return err;
	}

so each rejected duplicate ATM_SETBACKEND appears to leak one
struct pppoatm_vcc, and the ioctl can be repeated because
pppoatm_ioctl() lets ATM_SETBACKEND through even when a backend is
attached:

	if (cmd != ATM_SETBACKEND && atmvcc->push != pppoatm_push)
		return -ENOIOCTLCMD;

The sibling hunk in br2684_regvcc() places the identical test before
copy_from_user() and kzalloc_obj().  Could this check be moved to the
top of pppoatm_assign_vcc() as well?

>  	pvcc->old_owner = atmvcc->owner;
>  	pvcc->old_release_cb = atmvcc->release_cb;
>  	pvcc->encaps = (enum pppoatm_encaps) be.encaps;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919223431.3882212-1-benquike%40gmail.com
