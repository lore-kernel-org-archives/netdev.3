Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92A830BF4F;
	Fri, 31 Jul 2026 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785461437; cv=none; b=lxW2oG1uWMGF9AWIxEp0yzItCWfPs+7pDzH7GDmwbFRSOkjGQ8YLsbBS/7LZSx7mqP/W8W2jFRi9jugki1ht5zYELaRaX4GU6i2TXtNZ1xeO7ZNUGOGvwZqGGun4S498DCKyah0vFh+JICyJAQVgKecIGit46iQuEUrWpO7jAPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785461437; c=relaxed/simple;
	bh=Ktb4oRHoadvlw0MtMmhKBzvJnCBz8qzsGOTpqaIBD9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcrwTav7B2YVt2s0zv6EVz2Vxt1AkKmPwWK1ta9RmPaaGokbbxoCBAUaAKtEzCsGIUuZSbrPsSS12rcBfe/YpKbJLuFpV3idjgqhDVQ2yVsvEscdkMVbSQ93GVHTP6lexrK+K5y04ldpPBoRxZ7rl4Et5uBBZreh4T4bouTe/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inkpnURu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inkpnURu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D908D1F00A3A;
	Fri, 31 Jul 2026 01:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785461432;
	bh=gX1GrkVE/YBQr2ejTCdaAFrGHy2c8uL9TQgk1LrpBAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=inkpnURuWabzlgH/W2SPhJM11DTGxvGKn9J4F2yB29iHxrEYtXdam8ZCCNBJaxzGs
	 axiftBqJXt1d6mfZ8UQakyNVn+CQSiUcLV2JLKGyXbmVprjiswuVK72TUUgSSfZYia
	 /rz8k3OFT+w0ZXUWkv1UyqSEMNIfywbyuuMn+EzgVz7EjBz13t9RebthA/VCw2nX/e
	 +eLU8iJzdROLwmx8AgSwf7udQAzXhiV5RvVp7M8DuqtyrlJjzokuwp97KzodBfzTVa
	 I/W+HFUm1EthKM1iDNKrhi/p4SAmpVseaJ0wLggK5A76glrOuQ0srBrXURzZyhL7SC
	 PZyr/PhbhOCyg==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v22 net-next 06/12] net/nebula-matrix: add intr resource implementation
Date: Thu, 30 Jul 2026 18:30:31 -0700
Message-ID: <20260731013031.745107-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723040110.91410-7-illusion.wang@nebula-matrix.com>
References: <20260723040110.91410-7-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
--- Patch [6]: [PATCH v22 net-next 06/12] net/nebula-matrix: add intr resource implementation ---
commit 32d01aebd4d29040305943012638ac9e59c45fb8
Author: illusion wang <illusion.wang@nebula-matrix.com>

net/nebula-matrix: add intr resource implementation
    
This commit adds the nbl_interrupt module to manage driver global MSI-X
vector indices. It extends hw_ops with callbacks to program vendor-specific
internal MSI-X mapping registers, configure MSI-X metadata, and bind
interrupts to PF mailbox channels.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> new file mode 100644
> index 0000000000000..cb6874d13a88f
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c

[ ... ]

> @@ -0,0 +1,335 @@

[ ... ]

> +release_net_bits:
> +	while (i--) {
> +		intr_index = tmp_interrupts[i];
> +		if (intr_index >= NBL_NET_INTR_BASE)
> +			clear_bit(intr_index - NBL_NET_INTR_BASE,
> +				  intr_mgt->interrupt_net_bitmap);
> +		else
> +			clear_bit(intr_index,
> +				  intr_mgt->interrupt_others_bitmap);
> +	}
> +	i = num_net_msix;
> +release_all_bits:
> +	while (i--) {

[Severity: High]
Does this fall-through inadvertently corrupt the global interrupt bitmaps?

If resource allocation fails in the first loop for net interrupts, the code
jumps to release_net_bits, loops i down to 0, sets i = num_net_msix, and then
falls through into release_all_bits.

Because tmp_interrupts was allocated with devm_kcalloc, any uninitialized
entries are 0. When the second loop evaluates these uninitialized zero
values, 0 < NBL_NET_INTR_BASE, meaning the code will clear bit 0 in
interrupt_others_bitmap and also doubly clear the already-released net bits.

Should there be a jump to free_prealloc right before release_all_bits to
avoid evaluating the array twice?

> +		intr_index = tmp_interrupts[i];
> +		if (intr_index >= NBL_NET_INTR_BASE)
> +			clear_bit(intr_index - NBL_NET_INTR_BASE,
> +				  intr_mgt->interrupt_net_bitmap);
> +		else
> +			clear_bit(intr_index,
> +				  intr_mgt->interrupt_others_bitmap);
> +	}
> +	goto free_prealloc;
> +}
