Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1B263F44;
	Wed, 16 Sep 2026 00:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518496; cv=none; b=XldB3rdzM9R4OL88tZXJLxyGqAA1DzmynNX1Ii0121NlxZ1Tc6GvyrjCZ8i2NyCwPRr+bfC86OK6/4bOMJhvAQqPOcI1YzjsVQnsRtuRJt/Rt5GXgx3DExHVckptxXEnvnLJQ5wUGBjOtQzT/EoU5MW8cO1cxgEAfk9l/8EZk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518496; c=relaxed/simple;
	bh=Ny41xNGqO6b5R6Wa+gW0apsQgTnW0x5xcQAkJaLfuw8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TmREZjQWEXeVMWNKWmaFGmeKnqs/tI+uJLsX2xsTJxKsFFlX+70OBq6uyqZZiTcaTzXgT7wApth3ynUQfL0VSrUSyPLAWqd8nh/v5wSIr/9/BkQR8scrcvxPJqyBLzt+BfCj86ZUeelEXYunKPXnMHoZQnZsNf1c5oczUQizFeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2anxolS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2anxolS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EE21F000FF;
	Wed, 16 Sep 2026 00:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789518491;
	bh=2zmHRFdTlNJTWZ2YTgH3+XapaGG7xJUHGS4YejvCz70=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h2anxolSckCnGkH4gp4TqdRdlaE9ERFilKHeERzT/qziDzzVSoBZJsbxIy+nmEtyJ
	 6BRMgdZwHio6LGUI/96N6b0bpJeurLOTWnvG7LZt24uQVwB1iNEPWqK9ptibABAZwd
	 uOl0vgZPmR1kzwLiQdjF0RWqIp4mXnIl7B21dhS0IHKK1sl54si+jYoKWp0NV1jCJv
	 itha2tr2Gp82MEHtIjxroD+XiSUB3I/Un+YXhtirXf/BBxTIM9Uxw1i5YOtNHsY5iV
	 0JMqHopdIBs2KYjNaHIGg8ZZnKLPw2q5hsjKDkeuhwJ4vmNFykJxfjWS3ROMeOlRm8
	 PgWYbvh22aJqQ==
Subject:
 Re: [PATCH] ixgbe: do not busy wait in ixgbe_devlink_reload_empr_finish()
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn
Date: Wed, 16 Sep 2026 00:28:10 +0000
Message-ID: <178951849042.22033.2945172314296253214@kernel.org>
In-Reply-To: <20260914092626.263886-1-xiaolinkui@126.com>
References: <20260914092626.263886-1-xiaolinkui@126.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 1

- [Medium] The commit message justifies the mdelay()->msleep() conversion
  with technically false claims about mdelay().
- [Low] The patch bundles a purely cosmetic macro rename
  (IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC ->…

Pre-existing issues:
- [Medium] In ixgbe_devlink_reload_empr_finish()
  (drivers/net/ethernet/intel/ixgbe/devlink/devlink.c:455-470) the…
- [Medium] The EMPR completion poll in ixgbe_devlink_reload_empr_finish()
  treats an all-ones FWSM read as 'firmware valid'.

--

ixgbe: do not busy wait in ixgbe_devlink_reload_empr_finish()

This converts the EMP reset completion poll in
ixgbe_devlink_reload_empr_finish() from mdelay(500) to msleep(500), and
renames IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC to
IXGBE_DEVLINK_RELOAD_TIMEOUT_TICS.  The commit carries a Fixes: tag
pointing at c9e563cae19e ("ixgbe: add support for devlink reload").

A few questions on the changelog and on the polling loop below.

> ixgbe_devlink_reload_empr_finish() is the .reload_up devlink operation,
> so it always runs in process context with the devlink instance lock held.
> Its polling loop delays with mdelay(500), i.e. it busy waits for half a
> second per iteration and, because the loop bound is 20 iterations, for up
> to ten seconds with preemption and interrupts to the timer subsystem
> effectively blocked on that CPU. That is long enough to trip the soft
> lockup detector and to stall RCU grace periods, and it keeps a CPU fully
> occupied while the firmware performs the EMP reset.

[Severity: Medium]
Is this description of mdelay() accurate?  mdelay() is a plain udelay()
loop:

include/linux/delay.h:
    #define mdelay(n) (\
    	(__builtin_constant_p(n) && (n)<=MAX_UDELAY_MS) ? udelay((n)*1000) : \
    	({unsigned long __ms=(n); while (__ms--) udelay(1000);}))

There is no local_irq_disable() or preempt_disable() anywhere in that
path, so timer interrupts (including the watchdog hrtimer) keep firing
and the loop stays preemptible on CONFIG_PREEMPT kernels.  In what sense
are "preemption and interrupts to the timer subsystem effectively
blocked on that CPU"?

Are the two detectors named here actually reachable at the stated bound?
get_softlockup_thresh() in kernel/watchdog.c returns watchdog_thresh * 2,
which is 20 s by default, and RCU_CPU_STALL_TIMEOUT defaults to 21 s, both
above the ~10 s worst case described.

Since the changelog is paired with a Fixes: tag, could it be reworded to
state the rationale that does hold, namely that spinning a CPU for ~10 s
in sleepable process context is wasteful and needlessly non-preemptible
on CONFIG_PREEMPT_NONE, rather than citing soft lockup splats and RCU
stalls?

> diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> index cf8908b82f8a3..7ce0a0cbf9d2a 100644
> --- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> @@ -430,7 +430,7 @@ static int ixgbe_devlink_reload_empr_start(struct devlink *devlink,
>  }
>  
>  /*Wait for 10 sec with 0.5 sec tic. EMPR takes no less than half of a sec */
> -#define IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC	20
> +#define IXGBE_DEVLINK_RELOAD_TIMEOUT_TICS	20

[Severity: Low]
This isn't a bug, but would it be better to keep this rename out of a
Fixes-tagged commit that also carries the behavioural mdelay() to
msleep() change?

Also, "TICS" reads as a misspelling of "TICKS", and "tick" in kernel
parlance means a jiffy/timer tick rather than an arbitrary 500 ms poll
iteration.  What the constant expresses is a maximum iteration count, so
something like IXGBE_DEVLINK_RELOAD_MAX_ITER, or a bound stated in ms
next to the 500 ms step, would say what the value is.

>  
>  /**
>   * ixgbe_devlink_reload_empr_finish - finishes EMP reset
> @@ -460,11 +460,11 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
>  		 * may be not cleared yet, so begin the loop with the delay
>  		 * in order to not check the not updated register.
>  		 */
> -		mdelay(500);
> +		msleep(500);
>  
>  		fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
>  
> -		if (i++ >= IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC)
> +		if (i++ >= IXGBE_DEVLINK_RELOAD_TIMEOUT_TICS)
>  			return -ETIME;

[Severity: Medium]
This isn't a bug introduced by this patch, but since the patch renames the
macro to declare its unit as tics and touches the delay right above it:
does this loop really perform the 20 tics that the macro name and the
comment advertise?

With i starting at 0, the test is false for the pre-increment values 0
through 19, so the check first fires on the 21st pass:

    do {
    	msleep(500);

    	fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));

    	if (i++ >= IXGBE_DEVLINK_RELOAD_TIMEOUT_TICS)
    		return -ETIME;

    } while (!(fwsm & IXGBE_FWSM_FW_VAL_BIT));

That is 21 sleeps, i.e. at least 10.5 s, and more once msleep() rounds up
to whole jiffies, against the "/*Wait for 10 sec with 0.5 sec tic." above.

Separately, is the fwsm value read on that last pass being thrown away?
The return -ETIME happens before the while() condition is evaluated, so if
firmware sets IXGBE_FWSM_FW_VAL_BIT exactly in the final 500 ms window,
devlink reload reports -ETIME even though the read already showed the bit
set.  In that case *actions_performed is left unset, the
IXGBE_FLAG2_API_MISMATCH and IXGBE_FLAG2_FW_ROLLBACK bits stay stale and
ixgbe_refresh_fw_version() is skipped.  Would moving the bound check
before the sleep, or testing fwsm before returning -ETIME, be preferable?

>  
>  	} while (!(fwsm & IXGBE_FWSM_FW_VAL_BIT));

[Severity: Medium]
This is also a pre-existing issue rather than something this patch
introduces, but can a failed register read end this wait early and be
reported as a successful firmware activation?

IXGBE_READ_REG() goes to ixgbe_read_reg() in ixgbe_main.c, which returns
IXGBE_FAILED_READ_REG (0xFFFFFFFF) when the adapter is marked removed, and
otherwise funnels an all-ones readl() through ixgbe_check_remove():

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_read_reg() {
	if (ixgbe_removed(reg_addr))
		return IXGBE_FAILED_READ_REG;
	...
	value = readl(reg_addr + reg);
	if (unlikely(value == IXGBE_FAILED_READ_REG))
		value = ixgbe_check_remove(hw, reg);
}

ixgbe_check_remove() only tolerates about 15 ms of unresponsiveness before
declaring the adapter gone:

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_check_remove() {
	for (i = 0; i < IXGBE_FAILED_READ_RETRIES; i++) {
		value = readl(reg_addr + IXGBE_STATUS);
		if (value != IXGBE_FAILED_READ_REG)
			break;
		mdelay(3);
	}

	if (value == IXGBE_FAILED_READ_REG)
		ixgbe_remove_adapter(hw);
}

0xFFFFFFFF has IXGBE_FWSM_FW_VAL_BIT (BIT(15)) set, so the while()
condition above is satisfied by a failed read.  The function then sets
*actions_performed to BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE), clears the
API_MISMATCH and FW_ROLLBACK flags and calls ixgbe_refresh_fw_version(),
which issues ACI commands to a device the driver has just flagged as
surprise-removed.

Should the poll reject fwsm == IXGBE_FAILED_READ_REG, or check
ixgbe_removed(hw->hw_addr), and keep polling until the timeout instead?
This depends on whether the E610 memory BAR actually returns all-ones
during the EMP reset window, which I could not confirm from the tree.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914092626.263886-1-xiaolinkui%40126.com
