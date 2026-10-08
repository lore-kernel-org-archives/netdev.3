Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938DC49B5B5;
	Thu,  8 Oct 2026 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466319; cv=none; b=OjLQoJCFWlkeZIRaj9H34oebG8Cl1Dp+5JBCkysBX7Lum7edfVp2qBfuDA8OGdn6GLxa9mxd7DWF31XJSBxZtYf9VOu8vIaztUqv4GhUb8HPC9+1JGYYpI/6qpbQAYhxUwxkmHLfhqu66zRGxUDw1FUQAfaLIvaDv6FGhJDivV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466319; c=relaxed/simple;
	bh=IzBjr1E1bCvEVJ3DmEgW6YXI7zv5VhZXUqK+GJjb3P4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X+3IZq4M/5JEnvfKr3Q/jmRodlci2s7ykN5W3fdsA/N/S0QOf6QxTJssMAdGN7fG/usWkq3rZT8wpwCC2ISW4dJLrvt1fTDvXpAO45d1BIV/EJ7pMMlCk+J3GrFeM17u8gYGJLnDH859BdosIJNBgo2aa04k54noIJJhOli5J7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/FybsXu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/FybsXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696741F000FF;
	Thu,  8 Oct 2026 13:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791466318;
	bh=YIvDPaOD+8x8ASTWI9FmPb2ebvUMocupjWhOxXiGsT4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U/FybsXuRaPylDa5xPg56icmLN9OViBMwPS8zpuaYoevz2q9WMVulUL1GGVidVSdJ
	 7JQ3da+++w0Oq+eEU4/3Rs5kSJ2OcNZknRQd61hE6+/zBbS2cPTBI1T/72oDriPjkq
	 gPlprf/ugDXByqFl2KfKWcIKotmHSAUlXReNQd0OITmy429wUAm+RRB8EvyonyQuCr
	 neiRcgtW0kzQjWSIlGTcZxH3b5T/Fj6eJf4i0CFzuAFhdZ4i49t8K37ikfRmThAjc+
	 C63DwU+1xipP2Bn9RgogNDsheTTMwlAK1S/1DLu0fiZtYgKMVdatZNuvlUAqd2H5ov
	 CfaLiuWQe/big==
Subject: Re: [PATCH] nfc: nci: drain rx_wq before cmd_wq on unregister
From: netdev-bot+sashiko@kernel.org
To: yogeshgaur.83@gmail.com
Cc: david@ixit.cz, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ian.ray@gehealthcare.com,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+ebbbf06f152da8ea4716@syzkaller.appspotmail.com
Date: Thu, 08 Oct 2026 13:31:56 +0000
Message-ID: <179146631693.434549.10968955013781183787@kernel.org>
In-Reply-To: <20261005102849.486-1-yogeshgaur.83@gmail.com>
References: <20261005102849.486-1-yogeshgaur.83@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new teardown order in nci_unregister_device() does not cover
  a deferred producer of tx_work: the NCI-HCI msg_rx_work, which runs on…
- [High] nci_recv_frame() (net/nfc/nci/core.c:1360-1368) tests
  NCI_UP/NCI_INIT without a lock, then calls skb_queue_tail(&ndev->rx_q)…

Pre-existing issues:
- [High] This problem was not introduced by this patch, but
  nxp_nci_i2c_remove() calls nxp_nci_remove() before…

--

nfc: nci: drain rx_wq before cmd_wq on unregister

This patch changes the teardown order in nci_unregister_device(). It
first shuts down cmd_timer and data_timer with timer_shutdown_sync().
It then destroys rx_wq before cmd_wq and tx_wq, so rx_work can no
longer queue cmd_work on a cmd_wq that is already draining.

> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index 73e3a96470ace..aa417f863f967 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -1329,8 +1329,13 @@ void nci_unregister_device(struct nci_dev *ndev)
>  
>  	nci_close_device(ndev);
>  
> -	destroy_workqueue(ndev->cmd_wq);
> +	/* cmd_work and tx_work re-arm these, and they queue cmd/rx work */
> +	timer_shutdown_sync(&ndev->cmd_timer);
> +	timer_shutdown_sync(&ndev->data_timer);
> +
> +	/* rx_work queues cmd_work and tx_work, so drain rx_wq first */
>  	destroy_workqueue(ndev->rx_wq);

[Severity: High]
The commit message says "the driver can still deliver frames through
nci_recv_frame() until it has stopped calling it". Does anything order
that producer against destroy_workqueue(ndev->rx_wq) here?

nci_recv_frame() tests the flags without a lock, then queues rx_work:

net/nfc/nci/core.c:nci_recv_frame() {
	if (!ndev || (!test_bit(NCI_UP, &ndev->flags) &&
	    !test_bit(NCI_INIT, &ndev->flags))) {
		kfree_skb(skb);
		return -ENXIO;
	}

	/* Queue frame for rx worker thread */
	skb_queue_tail(&ndev->rx_q, skb);
	queue_work(ndev->rx_wq, &ndev->rx_work);
	...
}

Suppose a driver thread passes the flag test before nci_close_device()
clears the flags with ndev->flags &= BIT(NCI_UNREG), and is then delayed
before queue_work(). Two outcomes look possible:

- It calls queue_work() while destroy_workqueue(rx_wq) is draining. That
  gives the same "cannot queue" warning.
- It calls queue_work() after destroy_workqueue(rx_wq) has returned.
  That uses the freed workqueue_struct.

This looks reachable with nfcmrvl i2c. The remove path:

nfcmrvl_i2c_remove()
  nfcmrvl_nci_unregister_dev()
    nci_unregister_device()

runs while the devm-managed threaded IRQ is still registered. The IRQ
thread, nfcmrvl_i2c_int_irq_thread_fn()->nfcmrvl_nci_recv_frame()->
nci_recv_frame(), shares no lock with the remove path.

nxp-nci does not seem to be affected by this race.
nxp_nci_remove() holds info->info_lock across nci_unregister_device(),
and the IRQ thread takes the same lock.

Would this need a core-side gate around the flag test and queue_work()?
Or should drivers be required to stop RX before they call
nci_unregister_device()?

> +	destroy_workqueue(ndev->cmd_wq);
>  	destroy_workqueue(ndev->tx_wq);
>  
>  	list_for_each_entry_safe(conn_info, n, &ndev->conn_info_list, list) {

[Severity: High]
Does this ordering cover the NCI-HCI msg_rx_work? It runs on system_wq
and can also queue tx_work.

When rx_work handles a data packet on the HCI connection, the callback
installed by nci_hci_dev_session_init() defers non-response HCP
messages:

nci_rx_work()
  nci_rx_data_packet()
    nci_add_rx_data_frag()
      nci_data_exchange_complete()
        nci_hci_data_received_cb()
          schedule_work(&ndev->hci_dev->msg_rx_work);

msg_rx_work then always sends a reply:

nci_hci_msg_rx_work()
  nci_hci_hcp_message_rx()
    nci_hci_cmd_received()
      nci_hci_send_data()
        nci_send_data()
          queue_work(ndev->tx_wq, &ndev->tx_work);

Neither nci_close_device() nor nci_unregister_device() flushes or
cancels msg_rx_work. conn_info_list is only emptied after the
destroy_workqueue() calls, so nci_send_data() still finds the HCI
connection.

The window is narrower than it first looks.
nci_data_exchange_complete() only runs the callback if
test_and_clear_bit(NCI_DATA_EXCHANGE) succeeds. nci_close_device()
clears that bit, and nfc_unregister_rfkill() sets shutting_down, which
stops the bit from being set again. So the work can't be newly
scheduled during the rx_wq drain.

But msg_rx_work might have been scheduled before nci_close_device() and
still be pending or running here. Could it then queue tx_work while
tx_wq is draining, or after destroy_workqueue(ndev->tx_wq) has freed it?

Later, nci_free_device()->nci_hci_deallocate() calls
kfree(ndev->hci_dev). That happens while msg_rx_work and msg_rx_queue
may still be in use.

Should hci_dev->msg_rx_work be cancelled or flushed after rx_wq is
drained and before cmd_wq and tx_wq are destroyed?

[Severity: High]
This isn't a bug introduced by this patch. While looking at callers of
nci_unregister_device(), I noticed that the nxp-nci i2c remove path
frees the nci_dev before it frees the IRQ:

drivers/nfc/nxp-nci/i2c.c:nxp_nci_i2c_remove() {
	...
	nxp_nci_remove(phy->ndev);
	free_irq(client->irq, phy);
}

nxp_nci_remove() calls nci_unregister_device() and nci_free_device(),
and phy->ndev is never cleared. If the IRQ fires before free_irq(),
nxp_nci_i2c_irq_thread_fn() does:

	info = nci_get_drvdata(phy->ndev);
	...
	mutex_lock(&info->info_lock);

Is this a use-after-free read of the freed nci_dev? The read happens
before the info->mode check. So switching the controller to
NXP_NCI_MODE_COLD beforehand doesn't prevent it.

Would freeing or disabling the IRQ before nxp_nci_remove() fix this?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005102849.486-1-yogeshgaur.83%40gmail.com
