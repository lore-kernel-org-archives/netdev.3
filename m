Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C17F3F411A;
	Mon, 27 Jul 2026 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145400; cv=none; b=NhjL6NWvSbcRxkbMs/1pKHi4vqdSYJw8PAhCSmpPI1u/T7NXTKfsBMTng8biPfLWft+/jc8dgII2k7abE+UFZ9daHHfeGo68h/6ZMX0ZSp79OXWM0TnU0MG2gJ9VXBBpCRuiUn3Sb5jinqh/cKcYT56IaVUHd5jDzcgj77b3rXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145400; c=relaxed/simple;
	bh=cn4UlB5bjIwDOkP1Lm0hlsqdtyxE3etQfrjCSSczwo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X65wkTRfOYW9CwBrgk95WAGjmjtQYIAiFEvE1drGMfGVjgbJJ1kCp1rodvt/PlTmhp84k/a9yzuSxUr8S8/Mlnp9LMtHBLBZO39Yrt6KsaD4mXS62GXSCr3BpTUKX/nHQj3QgEm1ZsNaZmHD48YSREnwgWRBYlyiWL9LR0JwSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=SN/JwiV0; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="SN/JwiV0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y5ZYwJ8WMhJlvn6YuT4NTCYDvgCoMsIiQZxEsn87oKU=; b=SN/JwiV09SuqNaskAyMNiAHz+8
	7VsW0ZbLZSEsE4UDbZDTY9xxdZO3PpQxCCPn+cWkNGRAsKM4jSYwQE7aZ+tueV1KzZVLyQcQ2Ejyx
	lj35Vg0tg7Fe+2GUh+YpzAh6jIboKAIAQ7JMbpiIxCmbbR7kyuwExWJlj/DDbE5yRwC5SGc2o0UX3
	C/RDjQY/P2kO66LuP9JDeCU996iO6/NBTKydYW2OncT2jvWGxfxVbRlIFj9CIG4uOEvq3jbedGYpw
	NiSdBPri/y0Owfv7cc8/adrd/PizgBmk811Xyu7EBXrxX16IcGd07dZmmauxXR8UHyRIwbd4y/f6L
	Tzs5Azmw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1woHr4-006nvd-2B;
	Mon, 27 Jul 2026 09:42:38 +0000
Date: Mon, 27 Jul 2026 02:42:33 -0700
From: Breno Leitao <leitao@debian.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jeff Garzik <jeff@garzik.org>, 
	Auke Kok <auke-jan.h.kok@intel.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH net v4] e1000e: Fix out-of-bounds MMIO access by
 validating BAR0 size
Message-ID: <amcn2lVGnmxwvsVr@gmail.com>
References: <20260727025645.2600363-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727025645.2600363-1-pulehui@huaweicloud.com>
X-Debian-User: leitao

On Mon, Jul 27, 2026 at 02:56:45AM +0000, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Syzkaller reported a kernel panic caused by an out-of-bounds MMIO
> access in the e1000e driver.
> 
> [   82.868719][  T404] e1000e 0000:00:02.0: The NVM Checksum Is Not Valid
> [   82.872328][  T404] Unable to handle kernel paging request at virtual address ffff80008894e090
> [   83.085218][  T404] CPU: 2 UID: 0 PID: 404 Comm: bash Not tainted 7.2.0-rc2-g3f1f75536668 #1 PREEMPTLAZY
> [   83.129013][  T404] pc : e1000_get_cfg_done_82571+0x70/0x158
> [   83.140092][  T404] lr : e1000_get_cfg_done_82571+0x68/0x158
> [   83.151196][  T404] sp : ffff80008ac37410
> [   83.158922][  T404] x29: ffff80008ac37410 x28: ffff0000cd6a11b8 x27: ffff0000c58190d0
> [   83.173919][  T404] x26: ffff0000cd6a11b8 x25: ffff0000cd6a0bc0 x24: ffff0000cd6a0000
> [   83.189417][  T404] x23: 0000000000001010 x22: ffff0000cd6a11c0 x21: ffff0000cd6a11b8
> [   83.205195][  T404] x20: 0000000000000064 x19: ffff80008894e090 x18: 0000000000000000
> [   83.220545][  T404] x17: ffff800081c1a3f4 x16: ffff800081c19c10 x15: ffff800081e86510
> [   83.235764][  T404] x14: 0000000000000001 x13: 0000000000000001 x12: ffff60001bc8a8b3
> [   83.251301][  T404] x11: 1fffe0001bc8a8b2 x10: ffff60001bc8a8b2 x9 : ffff800081eae25c
> [   83.266705][  T404] x8 : 00009fffe437574e x7 : ffff0000de454593 x6 : 0000000000000001
> [   83.281919][  T404] x5 : ffff0000cf2b9640 x4 : 0000000000000000 x3 : dfff800000000000
> [   83.297317][  T404] x2 : 0000000000000007 x1 : ffff0000cd6a11c0 x0 : 0000000000000000
> [   83.312601][  T404] Call trace:
> [   83.318662][  T404]  e1000_get_cfg_done_82571+0x70/0x158 (P)
> [   83.329748][  T404]  e1000e_phy_hw_reset_generic+0x17c/0x1a8
> [   83.341541][  T404]  e1000_probe+0xbd8/0x1988
> [   83.350334][  T404]  local_pci_probe+0x84/0x130
> 
> Repetition steps:
> 1. Find PCI device which BAR0 size <= 4K. If it's:
>    Device Addr: 0000:00:02.0   BAR0 SIZE: 4K
>    Vendor/Device ID: 0x1af4 0x1004
> 2. Unbind the above PCI device
>    echo '0000:00:02.0' > /sys/bus/pci/devices/0000:00:02.0/driver/unbind
> 3. Set the above device to e1000e new_id
>    echo '1af4 1004' > /sys/bus/pci/drivers/e1000e/new_id
> 
> During e1000_probe(), the driver maps the device's BAR0 memory region.
> If the device has a 4K BAR0, ioremap() maps only 4K of space. Later in
> the probe process, when the NVM checksum validation fails, the driver
> attempts to perform a hardware reset and falls back to the err_eeprom
> cleanup path.
> 
> This cleanup path will trigger an OOB access kernel panic:
> e1000_phy_hw_reset
>   e1000e_phy_hw_reset_generic
>     e1000_get_cfg_done_82571
>       er32(EEMNGCTL)
>         readl(hw->hw_addr + EEMNGCTL); <-- EEMNGCTL(0x1010) > 4K, OOB access
> 
> Fix this by verifying that the MMIO length (pci_resource_len(pdev, 0))
> is at least SZ_64K before calling ioremap(). This accounts not only for
> standard registers up to E1000_SYSSTMPH, but also for flash registers
> mapped on ICH/PCH chipsets (up to offset 0xE074 / ~57.1 KB). Since PCI
> BAR sizes are power-of-two aligned, SZ_64K is the minimum valid BAR0
> size required to ensure all subsequent MMIO accesses remain strictly
> within the mapped boundary.
> 
> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
