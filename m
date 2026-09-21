Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A52048F02A;
	Mon, 21 Sep 2026 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.14.198.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982894; cv=none; b=hWz+IIs/PoBwmM+wYl9zwux9JNcD/hW21pqxz6JAaGtqt8m98lY/nuY2mTfd7mCua3cHw1bnHlrRGlB38UUigmvnXXjDtKyaPWlPc+qLhoHW6j88AlcBbrRaOj1hROPtbVFLbn3ssNCd+2+/uoVb2K1BhNL2VTzzy0CrUZ0HL2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982894; c=relaxed/simple;
	bh=PH4/FT+SgS9Z/G4pWqkm/WiDabKc+6oc79OwZwH8JTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l736XRzZVpZolhTgbq3kF/wvBM/OinA06K+Xc1KvwZxKWj+Rc/QjW0oOxTEw9bfm4WfJnkG/TCzFwW5TOtJOM4KjpD50fnmm7n+55cP3DUmn59Nkxa5pfx3CmOIyiUTlyV6iN/9rnVUlouWuU3lPEB/u3YVnXO5oH1H9qa7YA+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com; spf=pass smtp.mailfrom=rimpianto.com; dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.b=pmY3E/zB; arc=none smtp.client-ip=46.14.198.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.b="pmY3E/zB"
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: =?UTF-8?q?Gajdos=20Tam=C3=A1s?= <tamas@rimpianto.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	chris.snook@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	gatis@mikrotik.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: atl1c: fix soft lockup on out-of-range tpd_cons read
Date: Mon, 21 Sep 2026 11:27:55 +0200
Message-ID: <20260921092755.3573852-1-tamas@rimpianto.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917004924.2461599-1-kuba@kernel.org>
References: <20260917004924.2461599-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id A2A76402-2A36-4946-B8D5-72374F76B25A.1
	envelope-from <tamas@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Mon, 21 Sep 2026 11:28:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=s20260314391;
 t=1789982890; bh=fMB8li3SdzNXwqIERvGv3IFialqAVuf5hLhWvqJ6h2g=;
 b=pmY3E/zBaoesZoQsrWvOMRZrES2zs3mg7pR5vFhLz+hXdqZEbL7U6eeaLYKQc+fc/A1jnbYD1
 Bb6tI/nIe1V0nK5oIZxE0nqi0VyxI0mRqb21DuNRnLCx4TZUF8iShgGUPdftuhU8RXkixc9NFXf
 RO4Uxpt2arC+jkeLYU85QIC1JUGLkzXVGrQMjY+OuwEmg33zh2p1iwHL7ad9ulzwqdFjWVEMztO
 TRAidM23P6ugSLJArjar8Md9WRLXdrS4NCRsvgwzmH1mYT51GVIgryhdRd0Such5M40LTCFiML5
 EfCOc6/O7BpkK2bH0Y2uDhFufVsZtmgXWRuf+MkqC5Hw==

Thanks for the review.

> Should this carry a Fixes: tag and a Cc: stable@vger.kernel.org?
>
> Fixes: 43250ddd75a35d ("atl1c: Atheros L1C Gigabit Ethernet driver")

Agreed on both, will add in v2.

> Could the changelog also say how the 0xffff value was observed - kernel
> version, hardware, and the log or reproducer? That makes the hardware
> claim easier to confirm.

Reproduced on two machines, same NIC (Qualcomm Atheros AR8151 v2.0,
4-port), triggered by rebooting a Mikrotik CCR2004 PCIe card that the
ports are directly linked to:

- Ubuntu 26.04.1 LTS, kernel 7.0.0-31-generic. The link-flap precursor,
  before the lockup was captured with a full trace elsewhere:

    atl1c 0000:05:00.0 enp5s0f0: NETDEV WATCHDOG: CPU: 4: transmit queue 2 timed out 489984 ms
    atl1c 0000:05:00.0: MAC state machine can't be idle since disabled for 10ms second
    atl1c 0000:05:00.0: atl1c: enp5s0f0 NIC Link is Up<65535 Mbps Full Duplex>

  65535 (0xffff) here is the same value the tpd_cons register reads
  back once the loop this patch fixes gets stuck.

- Proxmox VE, kernel 7.0.14-11-pve. Same NIC/trigger, this time caught
  by the soft lockup watchdog with a full stack trace:

    watchdog: BUG: soft lockup - CPU#12 stuck for 354s! [napi/eth%d-0:329]
    CPU: 12 UID: 0 PID: 329 Comm: napi/eth%d-0 Tainted: P O L 7.0.14-11-pve #1 PREEMPT(lazy)
    RIP: 0010:atl1c_clean_tx+0x142/0x2d0 [atl1c]
    Call Trace:
     <TASK>
     __napi_poll+0x32/0x1e0
     napi_threaded_poll_loop+0x286/0x2e0
     napi_threaded_poll+0xfd/0x140
     kthread+0xf7/0x130
     ret_from_fork+0x2da/0x3a0
     ret_from_fork_asm+0x1a/0x30
     </TASK>

Will fold both into the v2 changelog.

> This isn't a bug introduced by this patch, but the sibling Atheros
> drivers have the same loop and are left untouched here. Were they
> audited?

Yes - sending this as a 3-patch series (atl1c/atl1e/atl1), same guard
applied to atl1e_clean_tx_irq() and atl1_intr_tx(). One caveat worth
being upfront about: only the atl1c fix has been validated against
real hardware (repeated reboot cycles against the CCR2004 above,
confirmed fixed). The atl1e and atl1 patches apply the identical guard
against the identical loop shape by code inspection - I don't have
atl1e/atl1 hardware to reproduce and confirm the fix against directly.
Flagging this explicitly rather than implying equivalent test coverage
across all three.

> Would adding napi_disable()/napi_synchronize() around the reset in
> the link-change path be the right complement to this clamp?

Agreed this looks real - still confirming the right fix, will follow
up separately since it's an independent bug from the one this patch
addresses.
