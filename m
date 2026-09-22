Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3253ECF7
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087465; cv=none; b=G8mufa/rWiOrOKR88IjZiT5A5MKBZRGmeCnzqCU71mIBq25mrMsR6AxCsu8dpNYYQshuybFIeINjcCwgHehoc+tbs3wQIYu7iW9dk72RJ7rPdzVHxMtYMCaMZv05H+T35mmDBgp5odb7T6xa5Q++kYYj2d9vhi91w4I1KE3pZ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087465; c=relaxed/simple;
	bh=tzmNra10DRpKlxzzHDS3f5hrHELF846/timG5QL3w7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8mfFtxc/64o3f5yJpuBD/R+VF9auZVDeD5HscPyGGB1F1v81nZvWSRHJ4nzV3Xw5HmrOX5ZrZAqdpNDA/MDAltoyfQ+kOxtk6l0rnS/m8eSkwTw2HF5nvz1rqosyQ9hdLicOiqB7BMU+5bM40+a1oESsAW4ZRrq9HCO25b2nlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5H/6t7J; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5H/6t7J"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a47f740839so35256601fa.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790087461; x=1790692261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ejn1Cv3AZYuVHBui/3jgxRQSkdpmmTaViOr0Swl2g9o=;
        b=D5H/6t7JI3WzYI8dYR15Fxdol7kEIhtBZIvSwZc/7/1rmFNyLW7Huov3lj8MXdwF54
         3ztNX+0j9AmAEiFlf4bMdkx0RM3gFz4J5rrAT9125EnUmW24RfYBnV8fp6PthCKTV7fG
         I4UOcAj+gsyKYXmZqHzcW/CpVb+RaTvKq1esDmrmLQZXr4w9oUBUTUXePHMLZRlhDtfb
         DKAG8hTVmxoxxB6idxOZVjiz7loxJUYYPBvzv35lXnS60Uwovx8nTrapp2fpb6Rhrx7C
         4j+vPQ8ZBgbWcaIws9XTSHJshbiBL3TIajXwHeXz/dvz3LP7F83jwvXDw7dsVF6S9Hbp
         FFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087461; x=1790692261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ejn1Cv3AZYuVHBui/3jgxRQSkdpmmTaViOr0Swl2g9o=;
        b=TjIewH7H7b4KgeNCuboz5AJmYx6G7H0GT+8fxkgNJNnUSLjvrPVe07ObU6oAKGaOwZ
         zL884KS9TGtPnU1Cp3MKdBxdcQcqzOCSJB5e+wWN4yBjD4QNgEuMHrdLuVGHwYXZoYYz
         jkVpE24iZFgZ9w6BeGa7P04Vxbqq0xu9SV+YrUbye2waLhtoWTq1Zht2YAVtXsywRBcP
         d2XN8YHXT7pWmkleohHEF+3Xx6xSPycZ55zBJeSYKtJt2LUocmdLeI4QqFlw+ccCoRKN
         5ln3L1N1lv92JleZi2UzqeMYuTc+kpPPkeGRBaoqoY3Qrx76TuDMM0j70wVE5LM+jkKE
         mpdQ==
X-Gm-Message-State: AFuF++nx6LhUmlEh83AxZ2VrzX5yTKpuI6Ly673oXO9sD5D+rmUOa0ab
	GhEDeT8q+DC7ET04ZYxE8DDGryxpBIMFnbo4oIQE5aKF0YQ39NkyhZbWnCCvDm8M
X-Gm-Gg: AYBFou1HIqNgveDLNsQT6H7FX8UiGoeDLxFz9lJhox1+i6DijtvMQxxBJSlG8kL/XVs
	AgX3fLTkfk49/Y9zHavh9UwPlrgWZ3B2eCD2d6hb0E5oHRg7wuZpvxfDhRclDXktAmxb2XtFSLB
	eorINHuyRR0P78/YxXbs4aLya26hPP5oXC8/rR326bVn8rcz9bmuv9rQmDtuOki/zIiopXVZsT0
	hH/H1e4XhuQ6Y6cM/aLqsL+CISrkPwl335VBqHaHdJ/ZXJ+5NCZOMcjTR+FhHBzWuNqLHhrral9
	OmrTJeVS24KJLyTMUZG15/ZNm3cwuRhHZK31vJhmPxAfvWGsSYdTtZBN2x1xLbkH/VJf17uKBX3
	HVvy2ieY/6pG/MUgGF57OBuPLFJBcBhQ5R90nN7X+IvfQ/hb2vs/RTRiZg9gg3DXXEkOy0aP8su
	jnqP9exZP2KOYq1iXuIeBCn8F7Iu+wXvuJOZvgwB8cP/3JEwkDRFM6B8cjTzJt4uX3aMbb4WnmP
	jeYixPZNDQahZbzD+ry9tjOY+Jv7qf/ebFbKSrD
X-Received: by 2002:a2e:a9a5:0:b0:3a3:476:2e37 with SMTP id 38308e7fff4ca-3a5fbe36d88mr32233001fa.6.1790087460701;
        Tue, 22 Sep 2026 07:31:00 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a627d82b71sm6868881fa.34.2026.09.22.07.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:31:00 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: Re: [PATCH net-next v15 4/4] ptp: ocp: add TAP CPLD flashing via devlink
Date: Tue, 22 Sep 2026 17:30:58 +0300
Message-ID: <20260922143058.58562-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <178991648294.2160803.18070095713191970409@kernel.org>
References: <178991648294.2160803.18070095713191970409@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Sep 2026 15:01:22 +0000 netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 9 potential
> issue(s) to consider.

Five of the six Medium findings are fixed in the follow-up series I am
posting alongside this; the sixth I have answered below rather than
changed.  All three Low ones are fixed.  The series is already applied to
net-next, so this is incremental rather than a respin; no "pw-bot: cr".

  https://lore.kernel.org/netdev/20260922142829.57740-1-maimon.sagi@gmail.com/T/#u

> [Medium] ptp_ocp_devlink_info_get() publishes the literal string
> "unknown" as the devlink *running version* value for the fw.cpld
> component
> (...)
> so passing "" would still register the name for
> devlink_flash_component_get() while emitting no version attribute

Thank you - that is better than what I had, and I had not spotted that
version_cb runs ahead of the empty-value early-out.  The placeholder
existed only because naming the component is what makes it flashable, and
a part left holding a bad image answers neither READ_ID nor
READ_USERCODE, so gating the name on a successful read would have made
exactly that state unrecoverable.  An empty value keeps that property
without publishing a version nobody can use.  Changed, with a
Suggested-by.

> [Medium] adva_x1_cpld_flash() invalidates the cached CPLD identity only
> after *both* the ERASE write and its completion wait succeed

Right.  An ACKed ERASE is running in the part whatever the wait then
returns, so the invalidation has to happen before the ERASE is issued,
not after it is confirmed.  Moved.

> Since the Lattice IDCODE cannot change when the configuration flash is
> erased, should cpld.id survive a failed update

It should, and this is the better half of that finding.  cpld.id was
being dropped along with the USERCODE, so a failed update hid information
that was still correct and made recovery depend on a re-read that might
not succeed.  Only the USERCODE is dropped now.  The ABI and .rst text
claiming the identification is re-read "after a successful CPLD update"
never matched the code either; both now describe what is actually
dropped and restored.

> [Medium] In adva_x1_cpld_flash() the first status wait after EN_CFG_TP
> uses adva_x1_cpld_wait_ready()

This is the most useful finding in the set.  FAILED is latched and
nothing in the driver clears it, so a part that had failed once would
return -EIO at the enable step of every later flash, before reaching the
ERASE and REFRESH that would put it back into a defined state - directly
contradicting the "recoverable, fw.cpld stays advertised so the image can
be written again" comment in the page loop.  The enable step uses
adva_x1_cpld_wait_idle() now, and the ENAB check that follows decides
whether the part entered configuration mode, which is also what
machxo2_write_init() does.

> [Medium] The driver clears its configuration-mode bookkeeping from an
> I2C ACK alone, and its post-REFRESH success predicate cannot detect a
> REFRESH that was ACKed but never latched

Correct, and the reason is exactly the one you give: DONE set, BUSY clear
and no error code are already true of the state SET_DONE leaves behind,
so they cannot separate the two cases.  The check now also requires ENAB
to be clear, since leaving configuration mode is the one thing only a
REFRESH does, and cpld_in_config_mode is put back when it is not, so the
exit path and the recovery at the start of the next flash act on the real
state instead of an ACK.

I have not added the REFRESH retry loop machxo2_write_complete() uses.
With the ENAB test in place a REFRESH that does not latch is now reported
as a failure rather than a success, which is the part that mattered; a
retry would change what goes on the wire for a case I have not been able
to produce on the part.  Happy to add it if you would rather have it.

> [Medium] adva_x1_cpld_flash() holds bp->cpld_lock and the I2C root
> adapter lock (...) can this trip the hung-task detector?

This is the one I have not changed, and I would rather say why than guess
at a fix I cannot verify.

The 100 ms in the page loop is a timeout, not a per-page cost: a real
6526-page image programs in well under a minute, and the hand-back that
follows was measured at about 670 ms against its 2 s budget.  The worst
case you add up is reachable only if the part stops answering at every
step, in which case the sequence is failing anyway.

Releasing the bus between phases is not safe here: the whole point of
holding the root lock across the claim is that the controller is routed
away from the EEPROMs for the duration, so dropping it mid-sequence would
let an EEPROM read land on the TMC segment - the problem patch 2 of the
follow-up exists to prevent.  Bounding the total hold would mean
abandoning a part mid-erase, which is worse than waiting.

Lowering CPLD_MAX_IMAGE_SZ would shrink the arithmetic without changing
the real behaviour, so I have left the cap where it is rather than
pretend it is a fix.  If you would rather see the phases split or the cap
tightened, say so and I will do it.

> [Low] Is "the only check the driver makes" accurate?

No - the size cap arrived after that sentence was written.  Corrected,
and the .rst now also says what state a failure part-way leaves the part
in, and that the component stays available to write a valid image again.

> [Low] Should this report offset + CPLD_PAGE_SIZE?

Yes; it was a page behind and never reached fw->size from inside the
loop.  Fixed.

> [Low] Should these two be WRITE_ONCE() as well?

Yes.  Done, and the struct comments that claimed a lock the readers do
not take are reworded.

The series is tested on an ADVA TimeCard X1: the CPLD still programs and
activates with all of it applied, so the two checks that decide whether an
operation is believed - ENAB after EN_CFG_TP, and ENAB clear after REFRESH
- agree with the part rather than just with my reading of the datasheet.

Thanks for the review - the enable-step and REFRESH findings were real
false-success paths and I would not have found them on my own.

Sagi
