Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF751F8755;
	Sun,  9 Aug 2026 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786238965; cv=none; b=rvcXW9BXpo3h/+rc5Gul6EVAG30wbguAZ67MtPgjnDIhlK49RDBdfT9+tV7muLTAAw62yDypiEkyeVIc+KLHvOLrr3C+IVAVT6IuAA2JZ2OtrhFZGQUFovrLNTwLAc4gQ5wmea0xHSwvCK2CtAd1XEUKjlSG8qV9VoAv5FKv5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786238965; c=relaxed/simple;
	bh=65zC6bgiIOa+ZNTw/BhxTe/xKIHf84mMOgPh/jQyIMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKhJQ3z2mB4CFbG1buj0MarWM9IH/mns4xzCf2g08tSElHT3Mfp98K5ba7gl/1zlppa/Lte8FXePAXsi9OfjdhFAdvWDeWBXC7uYSWfGGKjDhzf1+HcCTnbOuVlSnsh4ICEz9Ph4jmDSFQNIbrjWWZewHqYvl9E48J2O4zVewak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wsrze-0000000068e-1gYP;
	Sun, 09 Aug 2026 01:06:26 +0000
Date: Sun, 9 Aug 2026 02:05:51 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, horms@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, andrew@lunn.ch, olteanv@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 4/5] net: dsa: mxl862xx: recover switch stuck
 in MCUboot rescue mode
Message-ID: <20260809005030.GA31337@makrotopia.org>
References: <6ab6dd06b95c01e30cf3a7387817a53cdb5e84f9.1785728574.git.daniel@makrotopia.org>
 <20260806112621.164297-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806112621.164297-1-pabeni@redhat.com>

On Thu, Aug 06, 2026 at 01:26:21PM +0200, Paolo Abeni wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.

Thanks. I traced all six findings. One is a real bug, two become
comment and commit message fixes, and the rest I believe the loader
protocol answers.

For context, since several findings concern state classification: v9
was tested on hardware in all three states the detection has to tell
apart, that is WSP firmware running, loader idle at READY, and a
loader wedged in the payload receive loop after an interrupted
download. Classification was correct in each case, and the wedged case
drained back to READY and reprobed into a flashable rescue mode.

[main-4-7] the queued reprobe cannot be cancelled

Real, and I will fix it. dsa_switch_shutdown() only unlinks the
netdevs, so dst->ports keeps entries whose dp->ds points at the devm
allocated switch, and the tree stays on dsa_tree_list.
mxl862xx_shutdown() then clears drvdata. A reprobe queued earlier
fires 500 ms later and finds dev->driver still set, since shutdown
does not unbind, so it detaches: mxl862xx_remove() returns early on
the NULL drvdata, dsa_unregister_switch() never runs, devres frees
priv and ds under the live tree, and the rebind walks those stale
ports in dsa_switch_find().

Two corrections. The probe failure variant is already covered, because
mxl862xx_probe() cancels the heal work when dsa_register_switch()
fails and that path calls dsa_switch_release_ports(), leaving no stale
ports. And the mechanism came in with patch 3: every user flash queues
the same uncancellable reprobe. The realistic reproducer is "devlink
dev flash, then reboot within 500 ms", so the fix belongs there.

The simple fixes do not hold. cancel_delayed_work_sync() from teardown
deadlocks, as the work calls device_reprobe() which takes device_lock
while device_shutdown() holds it across ->shutdown(). A drvdata or
system_state test inside the work is check then act: it can pass,
block on device_lock behind shutdown, and detach anyway. For v10 I
plan to track the pending reprobe in priv under heal_lock and have
teardown do an asynchronous cancel_delayed_work() with an ownership
handoff, so whoever wins the cancel drops the module and device
references. For a work item already executing when teardown starts, I
will drop devm for priv and ds and free them in mxl862xx_remove().
The early return on cleared drvdata then leaks them on a dying system
instead of freeing them under a live tree, dsa_switch_find() returns
the old ds, parse fails with a clean -EEXIST, and the reprobe only
logs that the device was left unbound.

[main-1-1] inconsistent timeouts for the same loader step

Agreed, fixed for v10. FW_WRITE_TIMEOUT_MS drops from 120 s to 60 s.
DRAIN_DONE_MS becomes SB_PDI_VERIFY_MS, still 15 s, and now covers the
verdict wait on both paths; flush_last() cannot see the boundary
between programming the last slice and verifying, so it gets the sum
of the write and verify budgets. DRAIN_POLL_MS becomes SB_PDI_STEP_MS
at 2 s, and both detection waits use it too. RESCUE_READY_TIMEOUT_MS
is gone. There is now one constant per loader operation.

I would keep the sticky verdict. With the budgets aligned, a STAT
still holding 1 after the verify window means a genuinely wedged
loader, usually a counter underflowed by an earlier oversized chunk,
and only a power cycle clears that. I will document that power cycling
the switch alone does not clear rescue_failed while the driver stays
bound.

[main-3-5] is STAT == 0 unambiguous enough?

I do not think the ambiguous state exists. The loader leaves the
receive loop exactly when r_remain reaches zero, so "in the loop,
asking for the next chunk" and "out of the loop, publishing verdict 0"
cannot overlap in time. Once it has left, a STAT write is a command
rather than a decrement, so there is nothing to underflow. Verdict 0
ending a drain would also require the zero stuffed remains of an
interrupted image to pass the checksum. What the hardware does at the
end of a drain is the other branch: STAT lingers at 1 during verify,
then the loader resets into READY, which is what
mxl862xx_rescue_drain_finish() waits out.

The post reset case cannot arrive that early either. The second
detection call runs only after mxl862xx_reset() and after
mxl862xx_wait_ready() has spent its whole budget, an unconditional 2 s
sleep plus polling to timeout, while MCUboot reaches its loop in
milliseconds. It is also self correcting: a booting MCU publishes
READY or a firmware status word, a freshly booted loader sits in the
console loop where the 1-byte advance is not a count, and the drain
converges through the "firmware booted while draining" branch. I will
add a comment so the next reader need not re-derive this.

[main-3-6] alloc failure after a successful drain

The hole is real: a NULL from mxl862xx_reprobe_alloc() leaves both
rescue_ready and rescue_failed clear and logs nothing, so flash
answers "retry shortly" forever. I would rather not set rescue_ready
before queueing the reprobe, though. That flag is what stops a user
flash from starting while the reprobe is pending, given that the flash
path's own guard is skip_teardown, which the heal path never sets, so
setting it early would let a flash begin and then be detached mid
transfer. v10 will log the failure and set rescue_failed instead. The
try_module_get() leg needs nothing, as it only fails during rmmod.

[main-1-0] "left untouched" and the -ENODEV cases

Fair, the commit message overstates it. The presence probe does write
the CTRL/ADDR/DATA scratch latches of a running firmware. It never
writes STAT, and the writes are inert on the tested firmware, but I
will reword it rather than claim the firmware is untouched.

A live switch with a relocated SB PDI window would indeed fail to
probe now. Those offsets are the OTP reset defaults and no supported
compatible moves them, so I would document the behaviour rather than
consult the probe only after clause-45 has failed, which brings back
the CRC error storm for genuinely absent switches. Happy to
reconsider.

[main-1-2] the -ENXIO outcome

Deliberate, and I will say so in the commit message. The RDREG
challenge is what separates a loader idle at READY from a running
firmware whose status word happens to read 0xc55c. Treating an
unresponsive challenge as flashable would sometimes classify healthy
firmware as a flash target, which is worse than refusing to bind.
Every loader I have tested services it.

[main-2-4] documented return values

Both mismatches are real and will be fixed. Detection can also return
the -ETIMEDOUT from mxl862xx_sb_pdi_poll_stat() when READY is never
re-armed, and drain_finish() also returns -EIO and SMDIO bus errors.
I lean towards mapping the challenge timeout to -ENXIO so the
documented set becomes true.


Cheers

Daniel
