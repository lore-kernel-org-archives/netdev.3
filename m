Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFA346A603;
	Tue, 21 Jul 2026 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649448; cv=none; b=SelGFw7feOu3iYVGuaEw/Q6tdYwEmoFwTcMAXaKEIwgdDBD7Xe7xtSHxGCW/xkHzAEIyr7+HaxMU/EbqwHLRlqmDO5aHLNdfDlraakQcaGfA39ZCd6DlGVKa7FnNws/pFTxqP9Ttd+uA4asjglnP5MdKl/uybqz6zuY7lGh+vng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649448; c=relaxed/simple;
	bh=fVgk+p0LhkBoS/Zk+I8bM2HmyPLZ4ZFlcNekaCyo3pk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdD6/bRyo6SOO6+R+yOBsYLMteQBCkAo986ahj3dW4ESZPIgnLRUdTHBMjTKoO5Klb25BtpG0t4RMtiM5ItEcmXNEFW5JNtEE3yiXiUT4UbarFxQLZY2NMHEBLxd46D2oqXxdlGuPd/Mskg8l3M1dSq365aeeNn3sxjdxmZfpH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdEXxZL3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdEXxZL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CF01F00A3A;
	Tue, 21 Jul 2026 15:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784649447;
	bh=MxeXvO6y66I7QMuvNAQ2ckSPYRJX1s+PoiXhdqIJ+pU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kdEXxZL3/nKEOoNbP/RPMUcdN1EuNP+wphAKGFWIPwhPfjg/3NRMzkzRxgdavUFF2
	 H55+YPbKqn+uAufwFPqw49OuWAYGZBQWhv08G9nDwh3G7l77omPxPI9EEUAaxuR5GY
	 SViDqGb9naNx1Qgl9G7FwJJ8ca3TUa+vpcZCC4GumSQIRqInViBh8L8oOpeJYnvh1M
	 02k7tiY426ytdMTizoNPWmo31SDo8rOH4m3Y2T4TiT2++fJpOC8fE9iXFlpsRGuplE
	 clkgEyc+26JgM6M2MtPJMQqPVvbE2mDqOpKMMkNa58vx8OtL/Y+GscaVvWH4y52s4Q
	 6esI0PdnxDzxQ==
Date: Tue, 21 Jul 2026 08:57:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <maxime.chevallier@bootlin.com>, <horms@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <daniel@makrotopia.org>, <linux@armlinux.org.uk>, <enelsonmoore@gmail.com>,
 <daniel@thingy.jp>
Subject: Re: [PATCH net-next v6 7/7] r8169: fix RTL8116af can not enter
 s0idle and c10
Message-ID: <20260721085726.05ca4851@kernel.org>
In-Reply-To: <20260709100237.541-8-javen_xu@realsil.com.cn>
References: <20260709100237.541-1-javen_xu@realsil.com.cn>
	<20260709100237.541-8-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jul 2026 18:02:36 +0800 javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> RTL8116AF is a multi-function device. Functions 2 to 7 are hidden from
> the PCI core and return an all-ones response when their vendor ID is read,
> so they are not enumerated as normal PCI functions.
> 
> However, these hidden functions can still affect platform power
> management. If they are left in D0 or keep ASPM disabled, the platform may
> fail to enter the low-power s0ix state and the CPU package may fail to
> enter Package C10.
> 
> Put functions 2 to 7 into D3hot and enable ASPM on their PCIe link control
> register. Since these functions are hidden, access their configuration
> space through pci_bus_read_config_dword() / pci_bus_write_config_dword()
> using the same slot and the target function numbers.
> 
> Ignore functions that return a PCI error response when reading their
> configuration space.

drivers/net/ethernet/realtek/r8169_main.c:3803:29: warning: invalid assignment: |=
drivers/net/ethernet/realtek/r8169_main.c:3803:29:    left side has type unsigned short
drivers/net/ethernet/realtek/r8169_main.c:3803:29:    right side has type restricted pci_power_t
-- 
pw-bot: cr
