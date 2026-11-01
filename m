Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793572401;
	b=j16I5Gt9MP/2gBxGPsPD+w7FnLb1tVCmIH/JImY9Px6eeqxOYU8pwd7ywoUmfIJfUa9s
	 SW9nDkfpkd1f14HSusL1DmnAxvdwW1Lky8evznckjf2ZXSwm0V3AC3VAo4ZVo8gmDTUNY
	 ZoKe4BBLKSqQAwrY/NYDX9zQRMYvfQYFeC54pGM+DzjJY5yHU4FDWasNvNIOTBIJ9PHpI
	 JE7mz28rgERd4ChqBq2XM0b6a8qgvwlO48KglVpKIZU1k6V7VJ/BmamUTK2DJ811xG15r
	 Psswnd0Lgwq/aEv2oBIlIfNlQFZk91B40EVU6vkvXiXCHzjrf+PBy+HR9XvNZeaWplA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793572401;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NR0Hh93UXRawxt+JabCf16N9EyzOgiFv1Rdldxr8dmE=;
	b=0oP1NX/tVDqMqhF80PGVf665AX5F+fgsLqU+CB56fyMqjNTeo+DuTXam1QtuLz429rQ3
	 XiKfCBR+CbaO0a8T+kkCl7y6VLbfwKm91rcjAqCjsMevnVbCO1harzKVdCuN1fqbNt/sF
	 Cjgu0drlP/0otIrLyIp6o55JD54R39vPianrRZHoy0ce5SrpPD5Ff2td+TczRF1zwQguO
	 onetIoHlpikiWsvhT6IRqBzCz0cMHW78DPErv3AE7lpsF0e/yVmoFcDtxz0VnrUSZGbFO
	 sC70dt3cnDoNBye+L/pmMgkVo3uixzUrSEsmOG0hrMdKzlN01q4KNEjEvh3niTQQX+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHPu4b7V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FBA606A33A
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHPu4b7V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505AD1F000C1;
	Sun,  1 Nov 2026 22:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793572400;
	bh=NR0Hh93UXRawxt+JabCf16N9EyzOgiFv1Rdldxr8dmE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mHPu4b7VIrq22AYrb5L++nEoTzSx9h3P8RDhrTXr2w7qynRo4VVvDQ8iTDN2lVR9U
	 Kx0SyXuLiN4bL9YfNEBZ90go6RoXTe10h6vGtR03KOC+lNcma8cDrwAr56PYmdJn7w
	 SDuA4MNThiKJqdKxAeNReYludyQYEiWub53odRdcUYv5+ZN9hLsQUehSC5VqqeIy40
	 /7evpswIlN80lKbpA/UTMlcSGj9xb7Ar37d0wK3vOmUk4FbgmAxzV/Po6oyrE/gBph
	 iYQeO3SE4IBSJzoJQKfTbFGe9IYZyj1y+e0e2CNeTuptTYlIjMPFp/d5P+Zo5ZYoxH
	 iDOf0d/ahu+aQ==
Subject: Re: [net PATCH 10/13] fbnic: Keep the BMC MAC address set whole
 across a capabilities update
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Sun, 01 Nov 2026 22:33:19 +0000
Message-ID: <179357239987.3131.13754518756856318258@kernel.org>
In-Reply-To:
 <179322343381.40667.1127592669876224055.stgit@ahduyck-xeon-server.home.arpa>
References:
 <179322343381.40667.1127592669876224055.stgit@ahduyck-xeon-server.home.arpa>
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

- [Medium] fbnic_mbx_init() is a second, unsequenced writer of
  fw_cap.bmc_mac_addr, and it also resets the live seqcount.

--

fbnic: Keep the BMC MAC address set whole across a capabilities update

This patch puts a seqcount around fw_cap.bmc_mac_addr. With it,
fbnic_bmc_rpc_init() can take a consistent snapshot while the mailbox
Rx path replaces the BMC MAC address set. The writer parses the new set
into a local copy and swaps it in inside a write section, with
preemption disabled.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> index 7964ce814b8ea..09d03274be08c 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> @@ -104,6 +104,7 @@ void fbnic_mbx_init(struct fbnic_dev *fbd)
>  
>  	/* Reset FW Capabilities */
>  	memset(&fbd->fw_cap, 0, sizeof(fbd->fw_cap));
> +	seqcount_init(&fbd->fw_cap.bmc_mac_seq);

[Severity: Medium]
Doesn't this make fbnic_mbx_init() a second writer of bmc_mac_addr?

The commit message and the new comments in struct fbnic_fw_cap and
fbnic_fw_parse_bmc_cap() say there is only one writer:

    Updates are rare and the mailbox Rx path is the only writer, so a
    seqcount is enough and the readers never wait on a lock.

However, the memset() here clears bmc_mac_addr outside any write
section. seqcount_init() then sets the live counter back to 0 instead
of making it odd.

fbnic_mbx_init() is reached on system resume and PCI slot_reset with
only devl_lock held:

__fbnic_pm_resume()
  fbnic_fw_request_mbx()
    __fbnic_fw_enable_mbx()
      fbnic_mbx_init()

The fbnic_bmc_rpc_init() reader in the service task holds RTNL and the
netdev instance lock. Nothing makes these two paths exclude each other.

Can a service task pass still be running at that point?
fbnic_pm_suspend() calls ndo_stop directly, so netif_running() stays
true. fbnic_service_task_stop() also does not wait for a running pass:

fbnic_service_task_stop() {
	...
	cancel_delayed_work(&fbd->service_task);
}

Take a pass that is already blocked on rtnl_lock() during suspend. It
runs once suspend drops RTNL, passes this check in
fbnic_service_task(), and re-arms itself every HZ into resume:

	if (netif_running(netdev)) {
		fbnic_health_check(fbd);

		fbnic_bmc_rpc_check(fbd);

		schedule_delayed_work(&fbd->service_task, HZ);
	}

If that pass is inside the new snapshot loop in fbnic_bmc_rpc_init(),
it looks like it can accept a torn copy in two ways.

First, bmc_mac_seq sits just before bmc_mac_addr in struct fbnic_fw_cap,
so the forward memset() clears the counter before the addresses. A
reader that samples 0 during the memset() can copy a half-cleared
address that is not all zeros. read_seqcount_retry() still sees 0, so
the copy is accepted.

Second, a reader samples seq == 2 and is preempted partway through the
24-byte copy. 2 is the usual value after one caps response since the
last init. The reset sets the counter to 0, and the next caps response
parsed via fbnic_mbx_poll_tx_ready() takes it 0 -> 1 -> 2. The reader
then copies the rest from the new set, and read_seqcount_retry() sees
2 == 2.

Either way, the torn address is tagged FBNIC_MAC_ADDR_T_BMC. The same
pass's __fbnic_set_rx_mode() then writes it to the MACDA TCAM, which is
the failure the commit message describes.

__fbnic_pm_resume() later rebuilds through __fbnic_open() ->
fbnic_bmc_rpc_init(), so the bad entry should normally be short-lived.

Would it work to init the seqcount once at probe and do the
bmc_mac_addr reset inside a write section? Another option would be to
quiesce the service task with cancel_delayed_work_sync() before the
mailbox is reinitialized.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179322311834.40667.5383039334126572422.stgit%40ahduyck-xeon-server.home.arpa
