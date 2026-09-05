Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5C94C77A3;
	Sat,  5 Sep 2026 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788626645; cv=none; b=BJm1LF6pRRlEIM+gMD6CJoU31c2Z5XdMDrRhDBYUjW6IJG61Fhpys9PQFAL2yF0hntcG2/1hjmCd7exahFxKvCuEw6ZUi4JBIa+LKArp31LkuCWQkeuRsMzNm0Jdk94sJh3wc7Uk/CYA+3qTp1OhCHR9c2aPBYUtCRdeTa6ThH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788626645; c=relaxed/simple;
	bh=ECfy6kf264WsG+e0/JSjZpNvCUxSaHGjxJJ54yikV8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkhnACIiCW9vP9PTufJlUibkmgpWGpTliISsHeh/OOV9G0FUninqYGg74G43sZLkSo2bLnOUWcAORjAPcu1ndvFVwK5fEy1uWtbexJwegtmD9PFu46BLGGejZBUgSw0qhZJdpXsm92Ye0+y/dd8pnPSYAxhQp/ZbWOzxxKwuLGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNXGIKey; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNXGIKey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999E61F00A3A;
	Sat,  5 Sep 2026 16:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788626642;
	bh=LWaaU5zyScA+VJ02eCufXGlRBF8ep/hpmQdGT9xk1D8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JNXGIKey5pisbmytxYo7UefMTE3aD9X+bgOEHTATZJQ4/Wnn5WuULPujASquUWeyl
	 pk2O5BLuIHkzVGnWM1j3gSgFf9DQXzsyKPXBQE3MZP7F9SE7w/OQcGqIc6j6QLXlAL
	 StqG3AVsrbLVMiz7JQu7iCT2tpDm+g+LbwRG/LDHgdDMHAnGXjYiTmOtYYp5w3xPLP
	 Tso6XsLb4glCAKSQ4i+xnN65UHQWkUkTFp/Pgwj8zcF4NdarwpVF05Pt9DJpjZ7Iyk
	 6Wzv5T72IxSt2ol6OY58Y+C0adcJGdE4CfRzAVEzhnYLp0aw1xC4Hm+2xMqMzQp6N6
	 aVmMcG0P0zlzQ==
From: Simon Horman <horms@kernel.org>
To: aaron.ma@canonical.com
Cc: Simon Horman <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	henry.w.tieman@intel.com,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH 1/2] ice: restore DDP state during PFR recovery
Date: Sat,  5 Sep 2026 17:43:50 +0100
Message-ID: <20260905164350.150004-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903074706.602087-1-aaron.ma@canonical.com>
References: <20260903074706.602087-1-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260903074706.602087-2-aaron.ma@canonical.com?part=1
---
Subject: ice: restore DDP state during PFR recovery

This patch serializes rebuilds across PFs of the same adapter while allowing
each PFR to complete independently. It reloads the DDP package from its
cached copy and restores the default DVM recipes before rebuilding the
remaining PF state.

Fixes: 462acf6aca85 ("ice: Enable DDP package download")

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3aa..a97a1941cec6a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -659,7 +659,9 @@ static void ice_do_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  	 */
>  	if (reset_type == ICE_RESET_PFR) {
>  		pf->pfr_count++;
> +		mutex_lock(&pf->adapter->rebuild_lock);
>  		ice_rebuild(pf, reset_type);
> +		mutex_unlock(&pf->adapter->rebuild_lock);

[Severity: High]
Can this cause a use-after-free of pf->adapter during concurrent device
removal?

If a device reset triggered in the service task takes longer than the
timeout, ice_remove() proceeds to teardown and calls ice_adapter_put().
For the last PF on the adapter, this drops the refcount to zero and frees
the adapter structure memory.

However, the service task is only explicitly halted by ice_deinit_dev()
after this point:

ice_remove()
    ...
    ice_adapter_put(pdev);
    ice_deinit_hw(&pf->hw);
    ice_deinit_dev(pf); /* service task halted here */

If the service task was executing ice_do_reset(), it will eventually
complete the rebuild and call mutex_unlock(&pf->adapter->rebuild_lock),
dereferencing the freed adapter structure.

>  		clear_bit(ICE_PREPARED_FOR_RESET, pf->state);
>  		clear_bit(ICE_PFR_REQ, pf->state);
>  		wake_up(&pf->reset_wait_queue);
> @@ -704,7 +706,9 @@ static void ice_reset_subtask(struct ice_pf *pf)
>  		} else {
>  			/* done with reset. start rebuild */
>  			pf->hw.reset_ongoing = false;
> +			mutex_lock(&pf->adapter->rebuild_lock);
>  			ice_rebuild(pf, reset_type);
> +			mutex_unlock(&pf->adapter->rebuild_lock);

[Severity: High]
Similarly, does this reset subtask release the rebuild_lock on a potentially
freed adapter structure if the remove timeout expired while the rebuild was
in progress?

>  			/* clear bit to resume normal operations, but
>  			 * ICE_NEEDS_RESTART bit is set in case rebuild failed
>  			 */

[ ... ]
