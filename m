Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793572397;
	b=tUnSqMoxLxHhbKpFUShu/fBJgnciVRKQytUszaK4ug9w0UWcn/s0bJQf2FQDqoQvBy+e
	 gr9JWdOJW/Oda1XpbmKz+qiJTPbTAL+U1pMAolxHBCyuy4thWeLBcUTPoJY63xPS237ej
	 p+S6Gp6BDo20lWheI2J2htub5cqyAsnxlzCcHzwbe+LBCCbPRkv14w0qdGTLP1uAuLA1o
	 pLF1L2h/lqRcufEpSR5J5oXTYDepQYmvGxtYNgtMVwuilaOBSqHG762R/n6igUYRj2Awc
	 kK3ahse+T24KI2pdb8QQKH2a5A4bJjQ2NgDptrfsZ7JHqhwRhkvZBKwjqDVAkFru28g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793572397;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=p1X70UjbxdLHWuH0p2EV9qJuGGy2CKshRTRf+Bp9O8g=;
	b=Qkc98ComBx8ESc28wYTsdTp0Eu4j0pyxUnX8Nwsgahr5Mpt11tV9TICF3Yvo9iWRKydv
	 JfGnxMLXKTTCJzTmraiU5WfwxOhnyhgGd5C8GQs/U1v6dR2rC4ECahIrYa2uGSQFCVFUp
	 4tuUovRtlx47aiFdJTT1BS8tt7Ui+AcglKkR7rgKJz1Vs445qzsf2LwCwk2/bxMZCmxI0
	 HTxCPlBXdmWzgMndKgZiM9uOtCCBN87Zh/k/pZoDoVB7KJEjx7qJmw9ZG9hpLalqjPSun
	 HCwqXePq/gllWj08kIFK9J5ct5WKyCwtEXa5kGoHFqmfKq1o/49rrFmkM76GDZXGXGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MD8mpgvM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A19606A327
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MD8mpgvM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1C81F000C1;
	Sun,  1 Nov 2026 22:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793572396;
	bh=p1X70UjbxdLHWuH0p2EV9qJuGGy2CKshRTRf+Bp9O8g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MD8mpgvMHB053iE8GlDXhm7NJou+WtjI5ePJH7Bawe9x76VpTN9fay6+2d6jtp9Iw
	 VVdZ9Ojvho8iy9gBT19DkOGL8L9/KowAPCsPSaG4Xf/kGhfnmkx3ASXEEDhaVOVFLk
	 n6+z+1W7YYzGR6aa7Y1bpAEn/AK1+DdE7e4X+gSAyE8Mg9dZbEN7f0tkCHC6wFQOnA
	 JnhJ9SCeQKOHCoa3t0+ndT5S0adX9zZ5wDSCML6bwZlPA2G9aapKn8USxr+CWyL1t7
	 DYte2DCtkwyfhcgeTlZqFsXfdScKDPLKa9uTsUHmb2Lp0Zlfmk12XG95/uf+9FmM9h
	 kbv/CxyUwyOog==
Subject:
 Re: [net PATCH 04/13] fbnic: Retry the MACDA sync to firmware if it fails
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Sun, 01 Nov 2026 22:33:15 +0000
Message-ID: <179357239570.3131.6726877389205316280@kernel.org>
In-Reply-To:
 <179322338727.40667.9687403297682768724.stgit@ahduyck-xeon-server.home.arpa>
References:
 <179322338727.40667.9687403297682768724.stgit@ahduyck-xeon-server.home.arpa>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch makes fbnic_bmc_rpc_check()
  (drivers/net/ethernet/meta/fbnic/fbnic_rpc.c:345-356) set…

--

fbnic: Retry the MACDA sync to firmware if it fails

When fbnic_fw_xmit_rpc_macda_sync() fails, fbnic_bmc_rpc_check() now sets
FBNIC_FW_CAP_F_BMC_MACDA_SYNC again, so the next service task pass retries
the MACDA table sync. The failure warning is switched to
dev_warn_ratelimited() because it can now repeat.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> index 0be71e6fd3d4e..d69c91066508f 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> @@ -345,9 +345,14 @@ void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
>  	if (test_and_clear_bit(FBNIC_FW_CAP_F_BMC_MACDA_SYNC,
>  			       &fbd->fw_cap.state)) {
>  		err = fbnic_fw_xmit_rpc_macda_sync(fbd);
> -		if (err)
> -			dev_warn(fbd->dev,
> -				 "Writing MACDA table to FW failed, err: %d\n", err);
> +		if (err) {
> +			dev_warn_ratelimited(fbd->dev,
> +					     "Writing MACDA table to FW failed, err: %d\n",
> +					     err);
> +			/* Leave FW to be synced on the next pass */
> +			set_bit(FBNIC_FW_CAP_F_BMC_MACDA_SYNC,
> +				&fbd->fw_cap.state);

[Severity: Medium]
Will this retry ever stop if the error is permanent rather than transient?

The bit is set again for any non-zero return, and that includes -ENODEV
after the device goes away. When fbnic_rd32() or fbnic_fw_rd32() sees
all-ones reads, they do:

    WRITE_ONCE(fbd->uc_addr0, NULL);
    WRITE_ONCE(fbd->uc_addr4, NULL);
    ...
    netif_device_detach(fbd->netdev);

This leaves mbx[FBNIC_IPC_MBX_TX_IDX].ready set and netif_running() true.
fbnic_fw_xmit_rpc_macda_sync() only bails out early on:

    if (!fbd->mbx[FBNIC_IPC_MBX_TX_IDX].ready)
        return 0;

So on every call it allocates a page, builds the TLV message, and gets
-ENODEV back from fbnic_mbx_map_tlv_msg()->fbnic_mbx_map_msg():

    if (!mbx->ready || !fbnic_fw_present(fbd))
        return -ENODEV;

It then frees the page.

fbnic_service_task() calls fbnic_bmc_rpc_check() and reschedules itself
with schedule_delayed_work(&fbd->service_task, HZ) while netif_running().
If MACDA_SYNC is pending when the device is lost, this loop runs about once
a second until the interface is downed, the device is removed, or AER
recovery runs.

The same thing happens with -EBUSY if firmware hangs with the TX mailbox
full.

About the commit message, which says:

    rate limit the warning now that it can repeat.

Does the rate limit actually suppress anything here?
dev_warn_ratelimited() uses DEFAULT_RATELIMIT_INTERVAL (5 * HZ) and
DEFAULT_RATELIMIT_BURST (10), which allows 2 messages per second. The
service task fires once per second, so every warning would be printed.

Before this patch, this condition logged one warning. With the patch, it
logs one warning per second for as long as the condition lasts.

For comparison, fbnic_fw_check_heartbeat() warns once, clears
fw_heartbeat_enabled, and stops. Could the retry skip setting the bit on
-ENODEV (or check fbnic_fw_present() first), and/or back off between
attempts?

> +		}
>  	}
>  
>  	netdev_unlock(fbd->netdev);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179322311834.40667.5383039334126572422.stgit%40ahduyck-xeon-server.home.arpa
