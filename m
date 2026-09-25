Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB124E06FA;
	Fri, 25 Sep 2026 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354393; cv=none; b=atQ0MRHrFtnMYSFv+SaFXrPEhApl+nre01gIwWfOTEAovnFMiHQjW/6sMFqTsyG4aFhEJ9W3T3m/n0SE6+PHl0LivuZ1z1chy5zNfQjM1lH5bgD8EXbh99Z7UzVCOTvNTEz40fRSI/s6nOMzIbj23kcK8/Y1jY4qtmtCchakJP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354393; c=relaxed/simple;
	bh=9KgwWoen8eQwgRgAmsggf9RKts821AvQGpwwRSVZbWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+I183PrJWl7fZXUc+OfBIT8IlDkkyJm3/ZXyInL812HUAWzUV+kke8gwYH2FZFrtlnosGvqIeAAvVcZ03Uczd9ebbigtAWd11oqUvyXgyqh99IDop6D2Up8rswEVGeGp/k53CqCE2B6fV1nqVc+ioqnVZ7PYm3p1Ny4fdoo4cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb3YSOMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb3YSOMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6471F000FF;
	Fri, 25 Sep 2026 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790354372;
	bh=d+zQp+1omJq6CVjx/eZB1Bfc+CtQiGvnhxcCaK3LH4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tb3YSOMplqpOF3cxjCQg/bciM6BGVSONhj2VD61sVGA9NAOdhbB1hIci9rGi1KUfz
	 kNLSDtzMgnBMtca+AJlMw11c6H31IsQ0oRQLLWqglTF0RSnrYN0PdYpnnnhK7WhlcF
	 09xLNl5muH1W/Fmj/8lRsv6KW+02fb4/t7X7UPPjw99u8dCiOBumKdrPIyC843XW21
	 X4Xl6LDfabblPXcQvORce202TGMT4mTgpc5GcoVMKgrAeLf2RiED+ZXUYPVwOuq4KA
	 0B+9LE8zlgEnfWuEXH0NbAVWVR0f32jFVJnKwumRDcAVH9YkaWqxTjgaOHXZl0yu3h
	 zxbcbGxaNKiKg==
From: Simon Horman <horms@kernel.org>
To: parvathi@couthit.com
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	afd@ti.com,
	vadim.fedorenko@linux.dev,
	haokexin@gmail.com,
	basharath@couthit.com,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	pratheesh@ti.com,
	j-rameshbabu@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	m-malladi@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: Re: [PATCH net-next v4 1/3] net: ti: icssm-prueth: Add HSR and PRP HW offload mode support for AM57xx, AM437x and AM335x
Date: Fri, 25 Sep 2026 17:39:14 +0100
Message-ID: <20260925163914.721071-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921134343.200426-2-parvathi@couthit.com>
References: <20260921134343.200426-2-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260921134343.200426-4-parvathi@couthit.com?part=1
---
net: ti: icssm-prueth: Add HSR and PRP HW offload mode support for AM57xx, AM437x and AM335x

This commit extends the ICSSM PRUETH driver to support HSR and PRP redundancy
protocols on compatible TI SoCs. It enables dynamically switching PRU ethernet
ports from dual-EMAC mode into HSR/PRP slave modes via firmware reconfiguration.

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
[ ... ]
> +static int icssm_prueth_hsr_port_link(struct net_device *ndev,
> +				      struct net_device *hsr_ndev)
> +{
[ ... ]
> +free_hsr:
> +	prueth->eth_type = prev_mode;
> +
> +	spin_lock_irqsave(&prueth->addr_lock, flags);
> +
> +	prueth->hsr_dev = NULL;
> +	prueth->hsr_members &= ~all_slaves;

[Severity: High]
Can this rollback improperly destroy the state for the already-linked first
port alongside the failing second port?

If the second port fails to transition to HSR/PRP mode, the free_hsr error
path clears the hsr_members mask for all ports by applying ~all_slaves.

Because the first port was successfully enrolled into the HSR bridge in a
previous invocation, it remains an active slave in the networking stack's
view. By wiping its membership state here, the driver drastically
desynchronizes its internal state from the kernel.

Would it be safer to only clear the bit for the specific port that is
failing to link?

> +
> +	spin_unlock_irqrestore(&prueth->addr_lock, flags);
> +	return ret;
> +}
