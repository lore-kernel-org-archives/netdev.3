Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D74A41A798;
	Tue,  7 Jul 2026 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431491; cv=none; b=Hnsa4fhQ3FUwjy408xMAsL12IQPxzZwu1lJbeNidU040btOrDnh0ZKiOI/OW7mC3yPr5eQbP3AMneVE8t+HU93LFDxqjyL86xERNsa1FsDLGB4PifAMFCWPU9tKDu7nWQ6iWqLY0gD8Ep0WUarSEacjWvNllIWDPKByMuxahcRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431491; c=relaxed/simple;
	bh=teZ+moBp1QlZu223Z+r+VeDqWVTHPa5ou4AKCAe2Mto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shQa9NI1pFBiEANS3pd7nmyQv5KJmFOSj4PffThuJvgV4PWtm8Q8qPuBZxbpMSaGY7WB+x3ZeeikazSgs5NzYTjlUYxE0tdLYADNgWnOhONvk3ddXTAoJF6J+FSsSpBMSI7WAl87ICdzf3+s+OjXc87wBwylhWuvJABp/nOKvxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgzW+c58; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgzW+c58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406D51F000E9;
	Tue,  7 Jul 2026 13:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783431489;
	bh=RYbaBrhQEitADW+4SI2VoYdDVhKcI2a9kMoyfM0Cv44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jgzW+c58B37nFSMdmK6yd3eUeIrUld9N+hk908EbC4Zhd/5WrhZZz2pl3pQyOpks4
	 052813ehEQfZ2HdCxsiYx/sMPKGMmOmGsdF/t+FTYKBV95BUuAJ9A03i1Q/UntFiD1
	 wmLCDcVopn2S/NgeynuV4Z9U8LX3OldIjR5YkBB77bB4YCFJ7KtyONZJOJR17UamHv
	 Nl9GQAAfmXh2/lKQawawDzzJ9cTeQq48ix++WPJq64pZxml2UWA4NlQe9ZLkPFsd9V
	 bcF1op1eawLWr5JJlqUWSO1ZCshC/EecA8+E+FvxzI8sLq9vMQfPpnFnzqu5CCkuWp
	 3amFKXf+BzrIw==
Date: Tue, 7 Jul 2026 14:38:05 +0100
From: Simon Horman <horms@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jgarzik@redhat.com>,
	Bruce Allan <bruce.w.allan@intel.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] e1000e: fix IRQ leak when request_irq() fails in
 e1000_request_msix()
Message-ID: <20260707133805.GF1364329@horms.kernel.org>
References: <20260626083917.49745-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626083917.49745-1-jiayuan.chen@linux.dev>

On Fri, Jun 26, 2026 at 04:39:16PM +0800, Jiayuan Chen wrote:
> An internal syzbot instance reported the warning below.
> 
> comedi (comedi_parport) lets userspace request_irq() an arbitrary IRQ
> number and can thus grab one of e1000e's MSI-X vectors. When
> e1000_request_msix() then fails partway through, it returned without
> freeing the vectors it had already requested; pci_disable_msix() later
> tears those descriptors down while their irqaction is still attached,
> leaking the /proc/irq entry.
> 
> Free the already requested IRQs on the error path.
> 
> genirq: Flags mismatch irq 28. 00200000 (eth1-tx-0) vs. 00200000 (comedi_parport)
> 
> remove_proc_entry: removing non-empty directory 'irq/27', leaking at least 'eth1-rx-0'
> WARNING: fs/proc/generic.c:742 at remove_proc_entry+0x436/0x560, CPU#3: ip/445
> Modules linked in:
> CPU: 3 UID: 0 PID: 445 Comm: ip Not tainted 7.1.0+ #284 PREEMPT
> RIP: 0010:remove_proc_entry (fs/proc/generic.c:742 (discriminator 4))
> PKRU: 55555554
> Call Trace:
> <TASK>
> unregister_irq_proc (kernel/irq/proc.c:406)
> free_desc (kernel/irq/irqdesc.c:482)
> irq_free_descs (kernel/irq/irqdesc.c:874 kernel/irq/irqdesc.c:865)
> irq_domain_free_irqs (kernel/irq/irqdomain.c:1917)
> msi_domain_free_locked.part.0 (kernel/irq/msi.c:1619 kernel/irq/msi.c:1645)
> msi_domain_free_irqs_all_locked (kernel/irq/msi.c:1632)
> pci_msi_teardown_msi_irqs (drivers/pci/msi/irqdomain.c:28)
> pci_free_msi_irqs (drivers/pci/msi/msi.c:925)
> pci_disable_msix (drivers/pci/msi/api.c:200 drivers/pci/msi/api.c:193)
> e1000_request_irq (drivers/net/ethernet/intel/e1000e/netdev.c:2028)
> e1000e_open (drivers/net/ethernet/intel/e1000e/netdev.c:4681)
> __dev_open (net/core/dev.c:1702)
> netif_change_flags (net/core/dev.c:9806)
> do_setlink.isra.0 (net/core/rtnetlink.c:3207 (discriminator 1))
> rtnetlink_rcv_msg (net/core/rtnetlink.c:7068)
> netlink_rcv_skb (net/netlink/af_netlink.c:2556)
> 
> Fixes: 4662e82b2cb4 ("e1000e: add support for new 82574L part")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Assisted-by: Claude:claude-opus-4-8

Reviewed-by: Simon Horman <horms@kernel.org>

