Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2299305679;
	Fri, 31 Jul 2026 01:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785461438; cv=none; b=CKi+vQEKyR+nsncvWz3CN1ofJ4dSe3CvxXjAAKvPeIkxDYIXOqS3EMsBpifuiUWfEfm262nm9t+PLYc0lQkgxwxX4JpaR2cYvLacXitL+GGNU++wvpsRpDaDs3KL0wf2ZaUm7e0H/1uyVbxfSkefrU7oxU2RfaHNgMAXuiE+ik0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785461438; c=relaxed/simple;
	bh=sGSvvSj1edFc8KNo83G1+m35hpQsaTtdWLUflg6MecU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKzh4qYEKbpBrlAM9zF2NoQcDomyAWBjGoJqcal8r3rtCLuK5mMWQMV77cWVt0uwQLvi7txtxKYrPgD5JzAdiY+8ttfNvWEh0rhaM6IgFGCyhzzrLBXIIU4QyX5yTlUbqySOqM0FZUfP4jfPD7B4n8uuKgPGswTowtAmHVQE5Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQrXYGs7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQrXYGs7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDCF1F00A3E;
	Fri, 31 Jul 2026 01:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785461436;
	bh=o3vgH8nxPMXThhusGaMt88XABY8jEPdTMHFLqOQyTUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OQrXYGs7tCwoRacNHv2bPlqqUDZcvZQImEI1oSH3sKvPv3WRdUL5T3j9e4vzI7Ec7
	 8M8yUPBcsWgtoy0AS4ZRhL8sZ+mNBVe1HjBoXyY86yvr6wvGCTU5CkCjffWQZIT06s
	 0oK3KfojqgFAHjz96sM3r2b9moqbwghxaQ778q/T0g2CJD6J2FKasbWVklSDhcSg0Y
	 yB7zDrF9ZmENEGHqm/xOeL41ohXu5+IEpqHSscAseBU0zP9Dnh9F5MPzpqqM3zx9P7
	 BQlrZaxUJCwj6XNMYVKSxcfVR06Yfsx5KhdaPCrQTcwqTJbD6hx1hdiGqD5XRUZ9b+
	 tXsspVqYspQCg==
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
Subject: Re: [PATCH v22 net-next 10/12] net/nebula-matrix: dispatch: add mutual exclusion lock for shared hardware resource ops
Date: Thu, 30 Jul 2026 18:30:35 -0700
Message-ID: <20260731013035.745239-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723040110.91410-11-illusion.wang@nebula-matrix.com>
References: <20260723040110.91410-11-illusion.wang@nebula-matrix.com>
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
--- Patch [10]: [PATCH v22 net-next 10/12] net/nebula-matrix: dispatch: add mutual exclusion lock for shared hardware resource ops ---
commit 629ed395b64ead7623f563c4a19ea0794f996cf1
Author: illusion wang <illusion.wang@nebula-matrix.com>

net/nebula-matrix: dispatch: add mutual exclusion lock for shared hardware resource ops
    
Add ops_mutex_lock to serialize concurrent hardware-modifying dispatch
resource operations, preventing race conditions between PF local calls
and remote mailbox message handlers that manipulate MSI-X mapping and
mailbox IRQ state.

> 4. Fix cleanup ordering: unregister all channel message handlers before
>    hardware resource teardown to avoid lockdep splats and invalid mutex
>    access after destruction.

Does this cleanup ordering actually prevent the invalid mutex access?

Looking at the driver teardown path in nbl_core_remove() and
nbl_chan_remove_common(), it appears the channel workqueue is never cancelled
via teardown_queue(). 

If a remote PF sends mailbox messages while the local PF driver is being
unloaded, won't the uncancelled work item still process it?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> index c82c336f50e5e..175250f952506 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c

[ ... ]

> @@ -227,14 +228,15 @@ static void nbl_disp_chan_configure_msix_map_resp(void *priv, u16 src_id,
>  	if (!res_ops->configure_msix_map) {
>  		err = NBL_CHAN_RESP_UNIMPLEMENTED;
>  	} else {
> -		ret = NBL_OPS_CALL_RET(res_ops->configure_msix_map,
> -				       (p, src_id,
> -					le16_to_cpu(param.num_net_msix),
> -					le16_to_cpu(param.num_others_msix),
> -					le16_to_cpu(param.msix_mask_en)));
> +		ret = NBL_OPS_CALL_LOCK_RET(disp_mgt,
> +					    res_ops->configure_msix_map, p,
> +					    src_id,
> +					    le16_to_cpu(param.num_net_msix),
> +					    le16_to_cpu(param.num_others_msix),
> +					    le16_to_cpu(param.msix_mask_en));

[Severity: High]
If the inflight work item runs after handler unregistration, will it attempt
to acquire the newly added ops_mutex_lock here via NBL_OPS_CALL_LOCK_RET?

Since this mutex is initialized via devm_mutex_init and destroyed
automatically on device detach, could this result in a use-after-free crash
on the destroyed lock?

[ ... ]

This is a pre-existing issue, but while looking at the MSI-X resource
operations I noticed a potential problem in nbl_res_intr_configure_msix_map()
in drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c:

release_net_bits:
        while (i--) {
                intr_index = tmp_interrupts[i];
                ...
        }
        i = num_net_msix;
release_all_bits:
        while (i--) {

[Severity: High]
Does this error path intentionally fall through to release_all_bits?

When devm_kcalloc or find_first_zero_bit fails during net interrupt
allocation, the code jumps to release_net_bits. Without a goto free_prealloc
before the i = num_net_msix assignment, it falls through into release_all_bits.

Because tmp_interrupts is unpopulated and contains zeros, will this loop
unconditionally clear bit 0 in interrupt_others_bitmap, corrupting the
MSI-X allocator state?
