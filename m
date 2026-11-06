Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.190.148.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943949;
	b=RvAwkDs5F4+iwu0pZdcr7lbQVoDIM345LPWlaUIp/nojnVmKkKMNd8y9nrM0xa0mT7dt
	 UgXBY+ac8mbOyWa5braRuMsvFwLA0fGlSu4aBfMpfoVbdzIg3i+flyrnCzqRh8lbLduGj
	 AZ1I3BsORFrd9JcKCjh61+oHUR3SkoAkDBo0p9brNv8D23PI3+aeUZWBxfg0COYIfNMJP
	 PPwm/IAMjg4znUZOER888YiANV20VYxfxV3Nxzt629AS6pG5nUXHUr9A7qc717yu/jVKd
	 agFqQ6pERo3caE0SzSibujh/sQYs1TZnKrT+dwepZGr51raV7SVFOTb++Kt+LCRlgvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943949;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Da1SaMO0CRhyo8NUsuKEWZa9VmLrT53aVWII3on28cs=;
	b=eBWocAn/3VqVBHCzVxacq+VOyqGJ6AvemL1UxfppjYvzgDJUlKe22aDwa22Cb0nN4WQH
	 2ENcxbd2YhgQwQboJtGdWOb+Zmxe6gIZ6Vo8NOWpbBmP31B5JOAiU4FWF+xjuK23BIbpw
	 mx3da3MUq4/bRUCcetrcgRJV9OMA7m/8vq58sC7xywpr2bP9v+14Rynr29oLrZDRnxdRS
	 7fttoIXCxSZI/Xq3dVveGKTronIU0wUpTUBEdLuJTv+A2Hau8cZ9ua0lZnVhrziiX5i/w
	 voMaxMcw55lS9dn+ZWJ767QJH50VVvPbak9UXvK743KTFExWX1mUUVHFUgO+IWLagJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=foundata.com;
	spf=pass smtp.mailfrom=foundata.com;
	arc=none smtp.remote-ip=195.190.148.227
Received: from hera.efm.de (hera.efm.de [195.190.148.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7821606A334;
	Fri,  6 Nov 2026 05:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7821606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=foundata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foundata.com
Received: from hera.efm.de (localhost [IPv6:::1])
	by hera.efm.de (Postfix) with ESMTPS id 82E4240C3D59A;
	Fri,  6 Nov 2026 06:45:39 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by hera.efm.de (Postfix) with ESMTP id 67905414F1D5B;
	Fri,  6 Nov 2026 06:45:39 +0100 (CET)
Received: from hera.efm.de ([IPv6:::1])
 by localhost (hera.efm.de [IPv6:::1]) (amavis, port 10026) with ESMTP
 id I9DkL1TP4yKV; Fri,  6 Nov 2026 06:45:39 +0100 (CET)
Received: from tpx13-pf5nr32.fritz.box (ip-037-209-109-094.um11.pools.vodafone-ip.de [37.209.109.94])
	(Authenticated sender: ah@foundata.com)
	by hera.efm.de (Postfix) with ESMTPSA id CC99C40C3D59A;
	Fri,  6 Nov 2026 06:45:38 +0100 (CET)
From: Andreas Haerter <ah@foundata.com>
To: tim770802@gmail.com
Cc: Chih.Hung.Huang@wnc.com.tw,
	andrew+netdev@lunn.ch,
	chandrashekar.devegowda@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	horms@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	loic.poulain@oss.qualcomm.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	tim.jh.chen@wnc.com.tw
Subject: Re: [PATCH net v6 2/4] net: wwan: t7xx: do not exit the TX push kthread on resume failure
Date: Fri,  6 Nov 2026 06:45:30 +0100
Message-ID: <20261106054532.201311-1-ah@foundata.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261002014638.47981-3-tim770802@gmail.com>
References: <20261002014638.47981-3-tim770802@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2026 at 09:46:36AM +0800, Tim JH Chen wrote:
> A later
> t7xx_dpmaif_tx_thread_rel() then calls kthread_stop() on the stale
> pointer [...]

I hit this in normal use on a ThinkPad X13 Gen 6 with a Rolling
RW350R-GL (14c3:4d75, subsystem 2099:3552), on Fedora's 7.2.4 and
7.2.5.

A runtime suspend failed with "[PM] SAP suspend error: -110". After
that, every MBIM write failed with -22 and the modem stayed dead.
Writing to the PCI remove attribute then gave a WARNING at
kernel/kthread.c:84 and, on a later occurrence, this oops:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor write access in kernel mode
  RIP: 0010:kthread_stop+0x44/0x180
  Call Trace:
   t7xx_dpmaif_hif_exit+0x46/0xa0 [mtk_t7xx]
   t7xx_md_exit+0x5c/0xa0 [mtk_t7xx]
   t7xx_pci_remove+0x41/0xc0 [mtk_t7xx]
   pci_device_remove+0x4a/0xb0
   device_release_driver_internal+0x19e/0x200
   pci_stop_bus_device+0x80/0xa0
   pci_stop_and_remove_bus_device_locked+0x1a/0x30
   remove_store+0x83/0xa0

The faulting instruction is the set_bit of KTHREAD_SHOULD_STOP with
worker_private NULL, so the pointer no longer referred to a kthread.
The writing process stayed in D state holding pci_rescan_remove_lock.
Shutdown then hung and the machine needed a forced power-off, which may
be worth a line in the changelog.

One question on the retry. In my case the failure is permanent:
runtime_error is latched, so rpm_resume() returns -EINVAL from then on.
With this patch the crash goes away, but TX stays dead and the thread
retries every 20 ms for as long as the TX lists are non-empty. Is that
the intended end state, or should something report the dead data path?

I have no reproducer, so I cannot offer a Tested-by.

Thanks,
Andreas

--=20
foundata GmbH
Steinh=C3=A4userstr. 20
76135 Karlsruhe

Web: https://foundata.com
Sitz der Gesellschaft: Karlsruhe
Registergericht: Amtsgericht Mannheim, HRB 714807
Gesch=C3=A4ftsf=C3=BChrung: Andreas Haerter
USt-IdNr.: DE284122682
