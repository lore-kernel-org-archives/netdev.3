Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274939;
	b=ScnjFGgFFgchRqFFKTZfqZ5JdoNUE+anEVtyafEY8EwSV7Exr/+wb7st1pjco8z74m4K
	 K6Tw4F7zNFlioenOZT1fjObaLNFRgFKJq6QLckh+rXxgs1QPWMyEGjNrVc+mTVO5ByBgR
	 bQNqhW530lBrj1xf2OSRoGqIbxpmtz00QC2oy2qz0D6oayxG3PxGYPAByhyZDpzLBeL1E
	 t+gTYH1bQQ2Pmaveqr+ycK6E6e+GHrHWo+xT+vaUSzt3DLMt1NkZ3z+HWs1z/wBNuV6Gd
	 N8egA0WW15kaYHo2OIEaPd79V4883g36Jurdp9aECi5xCVeMr2fM+HueEpYWX/HLiMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274939;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9Q9x9YV71OJzvOz2gtsdsLZIjv3t7ylv41JVQw5X9no=;
	b=3E/mB7nK7i+xIEKIrz2ADrZmaHU0vN1lkYaqhVCRlAcL9sjrDhJeODGAcX19oACghcgZ
	 vWusM4BfRQ39aq81AAvjbZtuw6HjwgwAlP3+JpHAILPfHrudP1mi1SBUtrNppUX9lxCvI
	 ZGpFqinusR3Z34rC9ZwsS+PmC5Obp+h+rnLvlWrnW3j9cyoHdrx+ZqtkN1PHLs+m3zcFy
	 jeY7FKmhuLhS5p2HN9THgQcLSSMgjHx8aKJvhOuVb9vPz1qC/50S+ZAaYkRG6oCOclgf3
	 ptUHusJc35Q4XoAvGm7ctdQnDxddZf8791QB3cnXtczk1B4jd30qO3kWVNJqIxfFzOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hjliKOHV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4386A606A325;
	Tue, 10 Nov 2026 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hjliKOHV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6071E1F0089F;
	Tue, 10 Nov 2026 01:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274939;
	bh=9Q9x9YV71OJzvOz2gtsdsLZIjv3t7ylv41JVQw5X9no=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hjliKOHVAUO70Bj7fp0kMTIh2dSdoyoH2UssYwG2TCOZnUuxY2QQ8NpjIYqYxmwOE
	 ZHRJc9UpcQJYZ2ZK13GSOFaEsDgP5fo/PelhRwm2b/p8gm8AYldv7MVtIZGzZw4aTT
	 awIIUDMXgmK4tDNTVd0zSgg9etUEY4/PZV9LMnCSv6wKj2vu4CwDux4MBOlKOSoOTq
	 nCST1+ddFU8Sktd/nUwMM37YopPY1l0Q7++OoGDyNqCCo1q4jGOjE1xu1bivDll49J
	 jVnRMRosgcGB8euTHD3kSePfjAca/KxrUyekkE6mgySyFXpvlKY85XwvtEPP41iUm/
	 G5EgiQbgVvaAQ==
Subject: Re: [PATCH net-next] netconsole: register one console per target
From: netdev-bot+sashiko@kernel.org
To: leitao@debian.org
Cc: gustavold@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 john.ogness@linutronix.de, pmladek@suse.com, samuelcrossley@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Date: Tue, 10 Nov 2026 01:42:17 +0000
Message-ID: <179427493788.994134.10458088525635523245@kernel.org>
In-Reply-To: <20261106-netcons_one_console_per_target-v1-1-c29dacdb9c1f@debian.org>
References: <20261106-netcons_one_console_per_target-v1-1-c29dacdb9c1f@debian.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] netconsole_register_console() calls register_console(), which
  returns void and can fail silently.
- [Medium] netconsole: console left registered on error path in
  enabled_store()
- [Low] In make_netconsole_target() (drivers/net/netconsole.c) the patch
  sets `nt->console.index = -1` with the comment "No index, the console…
- [Low] The patch names a target's console in two places, and they handle
  the 'cmdline<N>' name differently.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  keeps it and wires a console straight onto it.

--

netconsole: register one console per target

This commit replaces the two shared netconsole consoles (netcon and
netcon_ext) with a struct console embedded in each netconsole_target,
named netcons_<target name>. A target's console is registered when the
target is enabled or resumes, and unregistered when it is disabled or
dropped. The write callback now sends only to the target that owns the
console.

Link: https://lore.kernel.org/all/20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com/ [1]
Link: https://lore.kernel.org/all/auDjNKi336lstU7j@pathway.suse.cz/ [2]

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 267254f046de9..8353dd56789c1 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c

[ ... ]

> @@ -1080,6 +1048,7 @@ static ssize_t enabled_store(struct config_item *item,
>  		}
>  
>  		nt->state = STATE_ENABLED;
> +		netconsole_register_console(nt, 0);
>  		pr_info("network logging started\n");

[Severity: High]
This isn't a bug introduced by this patch, but this patch now registers
a console right after this lockless store of STATE_ENABLED. Can the store
overwrite a deactivation done at the same time by a NETDEV_UNREGISTER?

By the time we get here, netcons_netpoll_setup() has published np.dev,
dropped the RTNL and waited for a grace period:

drivers/net/netconsole.c:netcons_netpoll_setup() {
    ...
	err = __netpoll_setup(np, ndev);
	if (err)
		goto put;
	rtnl_unlock();
    ...
	synchronize_rcu();
    ...
}

The target is on target_list during that window, so this sequence looks
possible:

enabled_store()                     NETDEV_UNREGISTER
  netcons_netpoll_setup()
    rtnl_unlock()
    synchronize_rcu()               netconsole_netdev_event()
                                      nt->state = STATE_DEACTIVATED;
                                      list_move(..., &target_cleanup_list);
                                    netconsole_process_cleanups_core()
                                      netcons_release_dev()
                                        do_netpoll_cleanup()
                                          np->dev = NULL
                                      target back on target_list
  nt->state = STATE_ENABLED;
  netconsole_register_console()

The next netconsole_write() would pass the state check and call
netif_running() with a NULL dev:

	if (nt->state != STATE_ENABLED || !netif_running(nt->np.dev))
		return;

process_resume_target() handles this race with the reg_state re-check
under the RTNL, but enabled_store() has no such check. Does it need one?

The commit message also says:

  target_list_lock remains the device_lock of all the consoles, as the
  state changes that race with the write callback are made under it.

This store is not done under target_list_lock. Is that statement accurate
for enabled_store()?

[ ... ]

> @@ -1770,6 +1736,10 @@ static struct config_group *make_netconsole_target(struct config_group *group,
>  
>  	/* Initialize the config_group member */
>  	init_target_config_group(nt, name);
> +	snprintf(nt->console.name, sizeof(nt->console.name), "netcons_%s",
> +		 name);

[Severity: Low]
What happens to a configfs target named cmdline<N> when no boot target
has that name? This can happen after mkdir cmdline5, or when the matching
netconsole= entry failed to parse in dynamic mode.

find_cmdline_target() only matches a boot target with exactly that name,
so the target is created here. "netcons_cmdline5" needs 17 bytes, so
snprintf() truncates it to "netcons_cmdline" and the 5 is lost.

alloc_param_target() already handles this exact name pattern by moving
N into the index:

	strscpy(nt->console.name, "netcons_" NETCONSOLE_PARAM_TARGET_PREFIX);
	nt->console.index = cmdline_count;

This path sets the index to -1 instead. The console then shows up as
netcons_cmdline-1, or as netcons_cmdline0 once printk rewrites the
negative index (see below). netcons_cmdline0 is also the console name of
boot target cmdline0.

Should make_netconsole_target() apply the same rule to cmdline<N> names?

> +	/* No index, the console is named after the target */
> +	nt->console.index = -1;

[Severity: Low]
Does printk treat an index of -1 as "no index"? It looks like the core
treats a negative index as "not assigned yet" and rewrites it:

kernel/printk/printk.c:try_enable_default_console() {
	if (newcon->index < 0)
		newcon->index = 0;
    ...
}

kernel/printk/printk.c:try_enable_preferred_console() {
    ...
			if (newcon->index < 0)
				newcon->index = c->index;
    ...
}

try_enable_default_console() runs when preferred_console < 0 and the
first console in the list has no ->device or is a boot console.
netconsole consoles never set ->device. So if a netcons_cmdline<N>
console is first in the list, for example on a headless box booted with
netconsole= and no console=, every configfs console registered after it
gets index 0.

The index is always printed after the name: in con_printk(), in
/proc/consoles via show_console_dev(), and in the "pr/%s%d" printer
thread name. The same target can therefore show up as netcons_foo-1 on
one system and as netcons_foo0 on another.

netconsole_register_console() resets flags and callbacks on every
registration, but not ->index. Once the core rewrites the index, the new
value stays across later disable/enable and resume cycles.

This also doesn't match the example in the commit message:

        netcons_foo-1        -W- (E  N   )

[ ... ]

> @@ -2692,29 +2655,38 @@ static void free_param_target(struct netconsole_target *nt)

[ ... ]

> +/* Register the console of an enabled @nt, @flags can request CON_PRINTBUFFER */
> +static void netconsole_register_console(struct netconsole_target *nt,
> +					short flags)
> +{
> +	struct console *con = &nt->console;

[ ... ]

> +	if (nt->state != STATE_ENABLED)
> +		return;
> +
> +	con->flags = CON_ENABLED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE | flags;
> +	if (nt->extended)
> +		con->flags |= CON_EXTENDED;
> +	con->write_thread = netconsole_write;
> +	con->write_atomic = netconsole_write;
> +	con->device_lock = netconsole_device_lock;
> +	con->device_unlock = netconsole_device_unlock;
> +
> +	register_console(con);
> +}

[Severity: Medium]
What happens to the target if this register_console() call fails?
register_console() returns void and can fail silently.

For nbcon consoles, nbcon_alloc() fails if the pbufs allocation fails or
if nbcon_kthread_create() fails. The kthread can fail with -EINTR when
the task writing to the configfs enabled file has a fatal signal
pending:

kernel/printk/nbcon.c:nbcon_alloc() {
    ...
			if (!nbcon_kthread_create(con)) {
				kfree(con->pbufs);
				con->pbufs = NULL;
				return false;
			}
    ...
}

With this patch, enabled_store() and process_resume_target() unregister
the console and register it again each time. If registration fails, the
target stays in STATE_ENABLED and keeps its netpoll, its net_device
reference and its skb pool. It has no console, though, so it never sends
anything.

enabled_store() still returns count and prints "network logging
started", and resume_target() prints "network logging resumed".

Before this patch, the shared netcon/netcon_ext console stayed registered
across a resume, so the resume path could not lose its console this way.
On the configfs path, the next enable of any target of that type retried
the registration. Now the failure is per target and lasts until enabled
is toggled again.

Should netconsole_register_console() check console_is_registered()
afterwards and report the failure, for example by returning an error
from enabled_store() or by leaving the target disabled?

[ ... ]

> @@ -1046,18 +1024,8 @@ static ssize_t enabled_store(struct config_item *item,
>  			goto out_unlock;
>  		}
>  
> -		if (nt->extended && !console_is_registered(&netconsole_ext)) {
> -			netconsole_ext.flags |= CON_ENABLED;
> -			register_console(&netconsole_ext);
> -		}
> -
> -		/* User might be enabling the basic format target for the very
> -		 * first time, make sure the console is registered.
> -		 */
> -		if (!nt->extended && !console_is_registered(&netconsole)) {
> -			netconsole.flags |= CON_ENABLED;
> -			register_console(&netconsole);
> -		}
> +		/* Interface events disable a target but keep its console */
> +		netconsole_unregister_console(nt);
>  
>  		/*
>  		 * Skip netconsole_parser_cmdline() -- all the attributes are

[Severity: Medium]
Can this path leave the console of a deactivated target registered?

With this patch, a target stopped by NETDEV_UNREGISTER keeps its
console, and netconsole_netdev_event() only moves it to
STATE_DEACTIVATED. At the top of enabled_store() that state is turned
into STATE_DISABLED before anything else is checked:

	if (nt->state == STATE_DEACTIVATED)
		nt->state = STATE_DISABLED;

While the target is deactivated, the user can set release to 1 and
extended to 0. extended_store() and release_store() only refuse changes
while the target is STATE_ENABLED.

Writing 1 to enabled then hits the release && !extended check. That
check jumps to out_unlock before the netconsole_unregister_console()
call that follows it.

The write fails with -EINVAL, but the switch to STATE_DISABLED is kept.
The console of the target stays in console_list and in /proc/consoles,
together with its pbufs and its nbcon printer thread.

deactivated_target_match() no longer matches a STATE_DISABLED target,
so process_resume_target() never runs for it either. Nothing replaces
or drops the console until one of these happens:

  - the user writes 0 to enabled
  - the user fixes the configuration and enables the target again
  - the user removes the target directory

netconsole_write() skips the target because its state is not
STATE_ENABLED, so nothing is sent. This still contradicts the commit
message, which says /proc/consoles lists only enabled targets and
targets stopped by an interface event.

Would it be simpler to drop the console at the point where
STATE_DEACTIVATED is turned into STATE_DISABLED? Every exit from
enabled_store() would then see a target without a stale console. That
would also cover the "already stopped" branch, which currently
unregisters for the same reason.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-netcons_one_console_per_target-v1-1-c29dacdb9c1f%40debian.org
