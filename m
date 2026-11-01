Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793572402;
	b=nb25Q1TzwmtndSUoGZkyyU5LkGoY0vNFla2zouVNeRo/Rz3K9pOMSU7DVd9korMF/29s
	 vh1velV9qry0kMDHjJ5DywEk9QqugLQqm/DjXdNBKFsBaz9KTcLjSXRHMaotz9oRuFXbi
	 zit3ZBwHsoLnzMEWTgqdJDXLbq95Tj7IxrI3i7lk0LrvKxYTL/53Okxx8L8XkLOzBUZQu
	 qKA+A7DrrSL7AZ1kRHI2J9bl8Avc1YnIWx+eWPWBxetBZXimH5yRzJbr0a3y+A2jwMCSl
	 mYn3sC1pM9d536HS5elbxotFNWMJB+gjZ2/3NafIp6zXmmrSTk9BTOu72D7fKTkpXFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793572402;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cdTXy5b3AGO0iGh/vByPZP07EnA3IP0hdtOfUkezEr4=;
	b=2e530Jov5h3j75kyQqQJB6vO3nHqDR19STQBeAwTbDArb5efEWdbNOyo90Yv2hLVNqFu
	 braUCWasXZn4dwa8s1TVTV8wt/2vog8+wPgz/LCgmzvdv3KnReJYeF1Pfk1V6YVx2M2BA
	 XIdTu8UpC5fHBW21LEENHaHeeNtsZ48jXZdx4fxySdlYqWvFCAS1xHVfqnYfyLJshM+jQ
	 SzKllNvHL1+042wppRCaIi3d1ihr3gNyyRMEsFVtq3kEST3Y9/wwCUjjMnEerJbwOKL7a
	 pRkvIV6kkvKf60lS0+dur+lsimhn2nJ7yszqQ8q1B/vsFNL4Bx1mTwpl045VgmQyhXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJtJzt2r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33F60A261B
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJtJzt2r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7FE1F00A1A;
	Sun,  1 Nov 2026 22:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793572401;
	bh=cdTXy5b3AGO0iGh/vByPZP07EnA3IP0hdtOfUkezEr4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jJtJzt2rRmcDurmpm98wkPliOZOKE0otl3ImGfotnZY5fruQpWsY94X8jBu0uJMzX
	 yVkhXhf6SISUv8cAwGzql0dKhzCNy6FV2FuWhMAtXT/Nc/0GPmaZ/RATRjhQeC27wd
	 Ed2ex/CNFRNLPyRp+JZGtXQD5RLpQBj6HM+CfvUJr5b2Jepfh+PwOaJIUhdtW5d4Yn
	 UCqESkIHF27rMy7lGUL8dGWlDg+I/X1Xg7H1X59hlqK00r5VQCU3mhHmro8gw1LpZE
	 9S1xCTQIaLQD5/pFdm55anFmedoSBfeTqT+saJeC1W5Y0EgpPQKOqOGwxjkv9eI/mh
	 vxekkM5mBAgkw==
Subject: Re: [net PATCH 11/13] fbnic: Suspend phylink after taking the
 datapath down in ndo_stop
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Sun, 01 Nov 2026 22:33:20 +0000
Message-ID: <179357240097.3131.11471702213981654052@kernel.org>
In-Reply-To:
 <179322344127.40667.2505190570032252359.stgit@ahduyck-xeon-server.home.arpa>
References:
 <179322344127.40667.2505190570032252359.stgit@ahduyck-xeon-server.home.arpa>
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

- [Medium] The PM suspend path does not protect against a service-task
  pass that runs late.

--

fbnic: Suspend phylink after taking the datapath down in ndo_stop

This patch reorders fbnic_stop() so that fbnic_down() runs before
fbnic_mac_free_irq() and phylink_suspend(). Tx then drains while the link
is still up, and the shutdown order becomes the reverse of the open path.
The commit message says the PM suspend path picks up the same order
because it goes through ndo_stop.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> index a40566029a863..36ef17dec0f4a 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> @@ -86,11 +86,11 @@ static int fbnic_stop(struct net_device *netdev)
>  {
>  	struct fbnic_net *fbn = netdev_priv(netdev);
>  
> +	fbnic_down(fbn);
> +
>  	fbnic_mac_free_irq(fbn->fbd);
>  	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbn->fbd));
>  
> -	fbnic_down(fbn);
> -
>  	fbnic_time_stop(fbn);
>  	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);

[Severity: Medium]

The commit message says:

  The PM suspend path goes through ndo_stop and picks up the same order.

Does the PM path also get the service task protection that this ordering
relies on after ndo_stop?

fbnic_service_task() uses netif_running() to decide whether it may touch
host state:

drivers/net/ethernet/meta/fbnic/fbnic_pci.c:fbnic_service_task() {
    ...
	/* fbnic_service_task_stop() does not wait for a pass that is already
	 * blocked on RTNL, so one can run after ndo_stop. Leave host state
	 * alone in that case; __fbnic_open() reclaims and rebuilds it.
	 */
	if (netif_running(netdev)) {
		fbnic_health_check(fbd);

		fbnic_bmc_rpc_check(fbd);
    ...
}

That works for __dev_close_many(), which clears __LINK_STATE_START before
it calls ndo_stop. fbnic_pm_suspend() calls ndo_stop directly instead:

drivers/net/ethernet/meta/fbnic/fbnic_pci.c:fbnic_pm_suspend() {
    ...
	netif_device_detach(netdev);

	if (netif_running(netdev))
		netdev->netdev_ops->ndo_stop(netdev);
    ...
}

netif_device_detach() only clears __LINK_STATE_PRESENT, so netif_running()
is still true after this. Also, fbnic_stop()->fbnic_down()->
fbnic_down_noidle()->fbnic_service_task_stop() uses cancel_delayed_work().
That call does not wait for a pass that is already blocked in rtnl_lock().

Suppose a pass is waiting on RTNL during the PM ndo_stop. When
fbnic_pm_suspend() drops RTNL, that pass sees netif_running() == true.

At that point fbnic_health_check() runs right after
fbnic_fw_xmit_ownership_msg(fbd, false) has cleared fw_heartbeat_enabled.
If the Tx mailbox has drained, can it report "Firmware crash detected!"?
After that, fbnic_fw_config_after_crash() would reclaim ownership and write
the host MACDA/action rules through __fbnic_set_rx_mode() while the queues
are disabled.

fbnic_fw_present() only checks uc_addr4, and uc_addr4 stays set until the
end of fbnic_pm_suspend(). The work can also run at the same time as
fbnic_fw_free_mbx(), which is serialized by devl_lock and not RTNL.

fbnic_bmc_rpc_check() can reprogram the BMC/host rules in the same way.

The pass then calls schedule_delayed_work(&fbd->service_task, HZ). Would
the service task then keep re-arming every HZ across suspend, after the
mailbox and IRQs are freed? If so, it would repeat the false crash report
and the ownership reclaim until resume calls ndo_open.

The window is not trivially small, because ndo_stop includes
fbnic_wait_all_queues_idle(). The effect looks transient: on resume,
__fbnic_open() reclaims ownership and rebuilds the rules.

The netif_running() gate was added by the earlier series commit "fbnic:
Don't touch host filters from a service task pass after ndo_stop". It only
covers the __dev_close_many() caller, and the code is unchanged at the end
of the series.

Should fbnic_pm_suspend() keep a late service task pass out in a way that
does not depend on __LINK_STATE_START?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179322311834.40667.5383039334126572422.stgit%40ahduyck-xeon-server.home.arpa
