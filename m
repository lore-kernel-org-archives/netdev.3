Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15936A36B;
	Thu,  3 Sep 2026 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431289; cv=none; b=auTEhbBLgWI0V7Xsw2EsboEGMPsjPO5Xa/nWGYum9SLTsa0gjtcWKg7bu7JHUU+8M0DVo98DrDFeG4TeR3dx0mtMqARheMgU9HHyLkKgDvC9pN9yct7S6ELqhxPvZM7KBQ0xuJk4pTFzXc5Hl8IOIxx/FdmriPMc1qV/PjdJ0yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431289; c=relaxed/simple;
	bh=r39OwDIidsdmPm27rLdZU5gWa7pXs22H8jB5WxLNB6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLyDO0X/6K5Akv1gMnE2dKC7vINxm/dLH4XSqwy0vqNRpwTcyGTT+V61u6iLb0r4TbzcnXfgcllueCf+haB+GDaClkc2XyeqJ2mMGML8c5r79aLF/BASTtFN8vzAsFlHuC+d62MLkepfY1ysAF1Fxnquhp2lBDNJ9JH6FgBVy8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA4aYCyo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA4aYCyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4EF1F00A3A;
	Thu,  3 Sep 2026 10:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788431275;
	bh=a4c1woQ9AJvItpYFTfW7Q9gNf4I+aOW6flvKS8gj4h4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bA4aYCyoK/Cz+nUGXSM/J1Go45ueDIO4MMNRXB0xoe7VZawXneuMArnLQJQlXLvvv
	 om36d1x3MniUO8APyU1J9ditp6Xp+tks96x41cqHw3OnZgixwfcI0uMqtQM6R6oi1O
	 gwrxHNVFVe516yL0hLRUNDcrIx/bRDgf2Imel2odx1VtUduDkZyhhTM9dxc8vlvIit
	 GYaeGoERz9Cs7B7k11Fxo8l8w0n+oFn2iBa5NhZ6enAtqeB2Ap75woAkrhX4AM+xht
	 EQa2xhuym2q3KIR9fZLVcHhNP/2JPeqMLvg47ZurSJt9+SuYgCwOatMErZDb7l298o
	 J2cPU8Vl8S/VA==
From: Simon Horman <horms@kernel.org>
To: tactii@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next 6/8] e1000e: disable NAPI while interface is down
Date: Thu,  3 Sep 2026 11:27:48 +0100
Message-ID: <20260903102748.578986-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830232146.36948-7-tactii@gmail.com>
References: <20260830232146.36948-7-tactii@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260830232146.36948-2-tactii@gmail.com?part=6
---
e1000e: disable NAPI while interface is down

This commit moves napi_disable into e1000e_down and adds napi_enable to
e1000e_up to ensure NAPI is disabled during reconfiguration windows.

> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 194166531bc84..6d846cacb026e 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
[ ... ]
> @@ -3601,7 +3603,7 @@ void e1000e_down(struct e1000_adapter *adapter, bool reset)
>  
>  	e1000_irq_disable(adapter);
>  
> -	napi_synchronize(&adapter->napi);
> +	napi_disable(&adapter->napi);

[Severity: High]
Does this change introduce an infinite hang in napi_disable() due to
concurrent or duplicate e1000e_down() calls?

A runtime PM suspend callback (e1000e_pm_runtime_suspend) can execute
concurrently with an ethtool operation like e1000_set_ringparam. The ethtool
operation sets the __E1000_RESETTING bit and holds it while allocating
resources.

The PM suspend callback waits on this bit but uses a bounded timeout (300ms).
If the ethtool operation takes longer than 300ms, the PM callback times out,
prints a WARN_ON, and unconditionally calls e1000e_down():

e1000e_pm_runtime_suspend() {
        while (test_bit(__E1000_RESETTING, &adapter->state) && count--)
                usleep_range(10000, 11000);

        WARN_ON(test_bit(__E1000_RESETTING, &adapter->state));

        /* Down the device without resetting the hardware */
        e1000e_down(adapter, false);
}

Because the ethtool operation also called (or is calling) e1000e_down(),
napi_disable() is executed either concurrently or sequentially on an
already-disabled NAPI struct, leading to an infinite hang waiting for
NAPI_STATE_SCHED.

[Severity: High]
Could this also lead to a sequential double napi_disable() hang due to state
mismatches where e1000e_down() is called but netif_running() remains true?

The e1000e_pm_thaw() function attempts to bring the device back up after a
freeze/suspend. If e1000_request_irq() fails, it exits via the err_irq label
without calling e1000e_up(), leaving NAPI disabled:

e1000e_pm_thaw() {
        rc = e1000_request_irq(adapter);
        if (rc)
                goto err_irq;

        e1000e_up(adapter);
}

However, the device's IFF_UP flag is untouched, so netif_running() remains
true. Subsequently, if an administrator changes the MTU via
e1000_change_mtu(), the driver checks netif_running() and blindly calls
e1000e_down():

e1000_change_mtu() {
        if (netif_running(netdev))
                e1000e_down(adapter, true);
}

This invokes napi_disable() a second time sequentially, which hangs
indefinitely because the NAPI instance was never re-enabled.

>  
>  	timer_delete_sync(&adapter->watchdog_timer);
>  	timer_delete_sync(&adapter->phy_info_timer);
