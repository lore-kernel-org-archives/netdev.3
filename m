Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2156E367F21;
	Mon, 10 Aug 2026 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786397467; cv=none; b=RV0ywNqdyy4yJ498VfEZbjl438nXOrLaziZOfuVz6WNPadxSKQ+VmumI5ApFwN74/pW6rTIFT5Wwr0SYly5BL6ZUj2juCxr/k13iu8iv5TetgSOdXfZBqZn+z+Ji82/lxUz4/zp2Ymi2krMjUwxZ1z7Xry4TJr9lQNx32pU2V2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786397467; c=relaxed/simple;
	bh=N51HxUOZMs2Lbq5K4mssRfAfcrdE5kefb5BQfn+pvR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTZwQE2oY4FmrJ9RYVJOyYlqNbNOXW6Bp4eefJP392LNUKLVHp6NUdv+rC4akS5QPbde/lj6cwiisJ7gauqsjlNxmXlmLHILR0FXd6BtJKpldasBrFTOa41UIUVMIgpK9TnE2LvF/MBuuB4m+J38F29s6hZ3FzEE8/lBU2QjeEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAWzfEI1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAWzfEI1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACAE1F000E9;
	Mon, 10 Aug 2026 21:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786397465;
	bh=b7V5POBNPQ5QnJuKExPYA65GV6vIW4UASQxkPEue1mE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LAWzfEI19tKk4iess3kFGVWKnMWyNX/JEdEPPdZArgGTfd957oZOVdDblVd8f0NZh
	 3gJLOR/mar755nEUq/Vh09K+BAFUZDrTRCZLAju2+tiE4ps7MMxkLaW56GnhDPK9uZ
	 gFpuviESwQA1qmxin2b0BlZr9U2AVp9bPBUomtW2v8JHl3wjMr3k9QVvwhtufcDIuC
	 ZWLstYtGwnQex6PvIZDHsD0W3FwwBlOLO1Sjmd9XUA7sXlO+RRgaH7gViPEBmSFfCd
	 IWLEDGuVG849vA441dippwkZbf731FzC31Sxkh8F/wffcT45QQMkh2V1cPwYN2bcCx
	 iRMq6eisSFBxA==
From: Jakub Kicinski <kuba@kernel.org>
To: javen_xu@realsil.com.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	hkallweit1@gmail.com,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 4/7] r8169: enable new interrupt mapping
Date: Mon, 10 Aug 2026 14:31:04 -0700
Message-ID: <20260810213104.853262-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803021305.488-5-javen_xu@realsil.com.cn>
References: <20260803021305.488-5-javen_xu@realsil.com.cn>
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
r8169: enable new interrupt mapping

This patch enables new interrupt mapping for the RTL8127 device. It sets up
vector mapping if the device is configured with multiple MSI-X vectors.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 6a7e9d875cf00..31f6d0c2e3d15 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -3945,6 +3954,9 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>  	RTL_W32(tp, RSS_CTRL_8125, 0);
>  	RTL_W16(tp, Q_NUM_CTRL_8125, 0);
>  
> +	if (tp->irq_nvecs > 1)
> +		rtl8169_hw_enable_vec_mapping(tp);
> +

[Severity: Medium]
With multiple MSI-X vectors enabled here, will concurrent NAPI polling cause
data races on the shared dev->stats counters?

When multiple NAPI instances process packets on different CPUs, rtl_rx() and
rtl8169_check_rx_desc_error() directly increment shared counters without
synchronization:

drivers/net/ethernet/realtek/r8169_main.c:rtl8169_check_rx_desc_error() {
    ...
    dev->stats.rx_length_errors++;
    if (status & RxCRC)
        dev->stats.rx_crc_errors++;
    ...
}

Could this lead to lost increments or torn reads on these network statistics?

[Severity: Medium]
Also, regarding the multiple RX rings setup for these vectors, is there a
memory leak in the teardown path?

The rx_ring array is allocated dynamically in rtl_init_one() during probe,
but rtl_remove_one() doesn't seem to free it:

drivers/net/ethernet/realtek/r8169_main.c:rtl_remove_one() {
    ...
    unregister_netdev(tp->dev);
    r8169_free_napi(tp);
    if (tp->dash_type != RTL_DASH_NONE)
        rtl8168_driver_stop(tp);
    rtl_release_firmware(tp);
    /* restore original MAC address */
    rtl_rar_set(tp, tp->dev->perm_addr);
}

Should there be a call to kfree(tp->rx_ring) here when the driver unbinds?

>  	/* disable UPS */
>  	r8168_mac_ocp_modify(tp, 0xd40a, 0x0010, 0x0000);
>
