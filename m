Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793663025;
	b=HaBP337UmHXtsApYmXL8tkm4lHYu7UkbQdGOj6AGmPXYjfFWpVfVIviFwpudMe6v/hXo
	 etb+NiC0FfxtvupP6P+ct0sPrZxHgiloIzTNT0PmNz7Emkupc5lvcnJikMpwLdhbtTW9T
	 J+U9VP7WLhdBS0d2EA2eB7pIdtmbggjLhgZMjqo23Mp5T6ix6G8/GuArHhS8RSYzmydyh
	 MqByMzgykHLnO++r/P7QaJUR8gaeGUOjrPE8tU/66t4uXzKtsIynvdtEcD2xAHzzQ8Hl3
	 21sjHFiEI3u7613Jwxrs86u2+RGJ64GBfC1MlSPPiAIQXDT1VzS5MnDbgMNrK9XUjMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663025;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=AwLIGZfZw/5o+dOtzSU684ACh8V5MINOHpM2KEP51MQ=;
	b=Hojy5rgeF0MYsVN7Lajgokq5tJoYqk+yo2chrg518lDiU2GklzY8fqIT8AP+pkw79pO1
	 cl+p20ccpU6wjXlior/MBw2QOQhmP27A2YqbF+CdyCv4leB7y3RnZz8618SnRKr2we50f
	 mcaFN8VAf9DMF9/ki73ux4ruTBU46A+yoqqd96vE88jwxKFwGRjGyYhjfPT6R7OZ1LTWh
	 YMkHCixvjpUzJSSdd97suu+fgaEoFlMvZjHkFCn8+y+ZZcvaKCHax9PX3tdnfZ3GL5ZRV
	 ai7aJunFRp98ZgJUJI2tcsJWYZ903gOx51LaL79tRBQRD3NZGGargwzlYfEW33VoOFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcUniiSB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4735606A324;
	Mon,  2 Nov 2026 23:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcUniiSB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D005B1F00A16;
	Mon,  2 Nov 2026 23:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793663024;
	bh=AwLIGZfZw/5o+dOtzSU684ACh8V5MINOHpM2KEP51MQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GcUniiSBAfF70k8fPOvu13liULpxTkd9TmWsVN3/LaKgDmTf7cA465gfHPwP3maj5
	 YdEiV2DQ1vrGOvvylNCtU2e8zcV4mC9GWS+1T9aEVHgDUJ8L3mr2EmuzoGaFed3dPK
	 yTK8V8ARUqgQDAI/b399GTq5g6shQj1ESCi3Pfdgq+8iSQzl6O5XpwVNxBSIwssBsa
	 9Dkp6UPk9U08DMpPllwQe01gfl7yw+HHk6FmtOTldFXuYgfEwibbrJumxjGlwKVa6C
	 UWj+OhfH7Q9EkSLITGxjsMImir4pbI9/ZRhzIN8e/FQ+1nELX1rt50So8J87Zi6eMu
	 zgqjlyZO6TmaQ==
Subject: Re: [PATCH net 1/5] nfc: nci: don't drop data received on HCI and
 loopback connections
From: netdev-bot+sashiko@kernel.org
To: joasantonio108@gmail.com
Cc: david@ixit.cz, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kipreyyy@gmail.com,
 sanghyun.park.cnu@gmail.com, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 23:43:43 +0000
Message-ID: <179366302337.488856.9811166362114360611@kernel.org>
In-Reply-To: <179331585573.30322.8986243734262725676@gmail.com>
References: <179331585573.30322.8986243734262725676@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 2 (3) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Three completion paths pass ndev->cur_conn_id where they
  should pass the RF connection id, and after this patch that can leave…
- [Medium] After this patch, completions on non-RF connections still tear
  down the RF exchange's timeout state but no longer release…

Pre-existing issues:
- [High] HCI work can use the device after it is freed during teardown.
- [High] At the target commit, this patch lets NFCC data on the HCI
  connection reach nci_hci_data_received_cb() and nci_hci_msg_rx_work()…
- [Medium] nci_nfcc_loopback_cb() (net/nfc/nci/core.c:409-423) ignores
  err, stores the skb (possibly NULL) in conn_info->rx_skb, and…
- [Medium] This patch makes the conn_info->rx_skb lifecycle reachable
  again.
- [Medium] For an HCP RESPONSE, nci_hci_hcp_message_rx() completes the
  request twice.

--

nfc: nci: don't drop data received on HCI and loopback connections

This patch limits the NCI_DATA_EXCHANGE claim in
nci_data_exchange_complete() to data on the static RF connection. Data
on HCI over NCI and NFCC loopback connections goes to their
data_exchange_cb again, instead of being freed. That undoes the
regression from 8265a626cc14 where every HCI and loopback request timed
out.

> diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
> index 4253edea5c8db..76ec891a02b09 100644
> --- a/net/nfc/nci/data.c
> +++ b/net/nfc/nci/data.c
> @@ -46,8 +46,13 @@ void nci_data_exchange_complete(struct nci_dev *ndev, struct sk_buff *skb,
>  	timer_delete_sync(&ndev->data_timer);
>  	clear_bit(NCI_DATA_EXCHANGE_TO, &ndev->flags);
>  
> -	/* Claim completion atomically -- both close and rx_work may race here */
> -	if (!test_and_clear_bit(NCI_DATA_EXCHANGE, &ndev->flags)) {
> +	/* Claim completion atomically -- both close and rx_work may race here.
> +	 * NCI_DATA_EXCHANGE only tracks nci_transceive() on the static RF
> +	 * connection; data received on other logical connections (HCI over
> +	 * NCI, NFCC loopback) is always handed to their callback.
> +	 */
> +	if (conn_id == NCI_STATIC_RF_CONN_ID &&
> +	    !test_and_clear_bit(NCI_DATA_EXCHANGE, &ndev->flags)) {

[Severity: Medium]
Can this leave NCI_DATA_EXCHANGE set with nothing left to clear it?

The callers gated on NCI_DATA_EXCHANGE pass ndev->cur_conn_id, not the
RF connection id. In nci_rx_work():

	if (test_bit(NCI_DATA_EXCHANGE_TO, &ndev->flags)) {
		/* complete the data exchange transaction, if exists */
		if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags))
			nci_data_exchange_complete(ndev, NULL,
						   ndev->cur_conn_id,
						   -ETIMEDOUT);

Both completions in nci_close_device() do the same thing with -ENODEV.

Only nci_transceive() sets NCI_DATA_EXCHANGE, so a set bit means an RF
exchange on conn 0 is pending. But every nci_send_data() overwrites
cur_conn_id without a lock. That includes HCI sends through
nci_hci_send_data() and nci_nfcc_loopback(), and nci_transceive()
doesn't take req_lock.

Say an RF exchange from rawsock or LLCP is pending. An HCI or loopback
send then sets cur_conn_id to a non-RF connection and re-arms data_timer
in nci_tx_work(). If the timer fires:

nci_rx_work()
  nci_data_exchange_complete(ndev, NULL, ndev->cur_conn_id, -ETIMEDOUT)
    timer_delete_sync(&ndev->data_timer);
    clear_bit(NCI_DATA_EXCHANGE_TO, &ndev->flags);
    conn_id != NCI_STATIC_RF_CONN_ID, so test_and_clear_bit() is skipped
    HCI or loopback cb(cb_context, NULL, -ETIMEDOUT)

The RF callback never runs. NCI_DATA_EXCHANGE stays set and no timer is
left, so every later nci_transceive() returns -EBUSY. Only an
RF_DEACTIVATE_NTF or a close with NCI_UP set clears it. Before this
patch, test_and_clear_bit() released the bit whatever the conn_id was.

The same mismatch lets a close-time completion and an rx_work delivery
on the same non-RF connection both reach the callback. The atomic claim
from 8265a626cc14 no longer covers them, so nci_nfcc_loopback_cb() could
overwrite a just-stored rx_skb with NULL.

One part of this is older than this patch. On close the RF callback
never runs, which leaks the rawsock sock_hold(), but the old code also
called the cur_conn_id callback.

Should the paths gated on NCI_DATA_EXCHANGE pass NCI_STATIC_RF_CONN_ID
instead, as nci_rf_deactivate_ntf_packet() already does?

[Severity: Medium]
With the claim now limited to conn 0, a completion on a non-RF
connection still runs this on the device-wide data_timer:

	timer_delete_sync(&ndev->data_timer);
	clear_bit(NCI_DATA_EXCHANGE_TO, &ndev->flags);

but it no longer releases NCI_DATA_EXCHANGE. Does this cancel the only
timeout of a pending RF nci_transceive()?

nci_tx_work() re-arms data_timer for frames on any connection. While an
RF exchange is pending, any HCI or loopback data on its own connection
deletes the RF exchange's timer. That includes unsolicited HCP events
from the NFCC or SE.

If data_timer has already fired and rx_work handles such a packet in
its dequeue loop, NCI_DATA_EXCHANGE_TO is cleared before the check at
the end of nci_rx_work(). The timeout is lost.

nci_core_conn_intf_error_ntf_packet() has the same shape:

	if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags))
		nci_data_exchange_complete(ndev, NULL, ntf->conn_id, -EIO);

If the NFCC sends a non-RF ntf->conn_id, this deletes the RF timer and
leaves the bit set.

If the RF response is then lost, NCI_DATA_EXCHANGE stays set. Every
later nci_transceive() returns -EBUSY until an RF deactivation. Before
this patch, the non-RF completion's test_and_clear_bit() released the
bit.

The new comment says NCI_DATA_EXCHANGE only tracks the RF connection,
but the timer and TO state are still shared. Should the timer and TO
handling also be limited to conn_id == NCI_STATIC_RF_CONN_ID, or be
made per connection?

>  		kfree_skb(skb);
>  		return;
>  	}

[Severity: Medium]
This isn't a bug introduced by this patch, but now that non-RF data is
always forwarded again, can nci_nfcc_loopback_cb() report success with
a NULL skb?

	conn_info->rx_skb = skb;

	nci_req_complete(ndev, NCI_STATUS_OK);

The callback ignores err. A NULL skb can come from the rx_work timeout,
from CORE_INTERFACE_ERROR_NTF, or from the skb_cow_head() failure path
in nci_add_rx_data_frag() (err = -ENOMEM). In each case the request
completes with OK, and nci_nfcc_loopback() returns 0 with
*resp == NULL. st_nci_loopback() then dereferences it:

	r = nci_nfcc_loopback(ndev, data, data_len, &skb);
	if (r < 0)
		return r;

	msg = nfc_vendor_cmd_alloc_reply_skb(dev, ST_NCI_VENDOR_OUI,
					     LOOPBACK, skb->len);

With this patch, the -ENOMEM case is reachable without an RF exchange.

A later patch in this series, "nfc: nci: consume the loopback response
exactly once", fixes the NULL dereference: nci_nfcc_loopback() detaches
rx_skb and returns -EPROTO when it is NULL. One minor gap remains after
that: a non-NULL skb that arrives together with an error is still
reported as success.

[Severity: Medium]
This is a pre-existing issue, but this patch makes the
conn_info->rx_skb lifecycle reachable again. At this commit rx_skb is
never consumed in these cases, so those skbs leak:

  nci_hci_set_param()
  nci_hci_send_cmd(), when skb is NULL or the HCI result is non-zero
  nci_hci_open_pipe()

Also, any skb that is handed out leaves conn_info->rx_skb dangling.

Later patches in this series fix most of that. "nfc: nci: hci: consume
the HCP response exactly once" adds nci_hci_take_resp(), and "nfc: nci:
consume the loopback response exactly once" does the same for loopback.

One gap remains after those. nci_hci_resp_received() and
nci_nfcc_loopback_cb() both still do:

	conn_info->rx_skb = skb;

without freeing an unconsumed previous skb. Does each late reply after
nci_request() has timed out, or each extra unsolicited HCP RESPONSE from
the NFCC, leak one skb? Nothing frees rx_skb when the connection or
device is torn down either.

[Severity: High]
This isn't a bug introduced by this patch, but HCI delivery was
effectively unreachable after 8265a626cc14, and this patch turns it
back on. Is msg_rx_work ever synchronized with device teardown?

nci_hci_data_received_cb() queues non-RESPONSE messages on the system
workqueue:

		skb_queue_tail(&ndev->hci_dev->msg_rx_queue, hcp_skb);
		schedule_work(&ndev->hci_dev->msg_rx_work);

nci_unregister_device() only flushes and destroys the NCI cmd, rx and
tx workqueues. nci_free_device() calls nci_hci_deallocate():

void nci_hci_deallocate(struct nci_dev *ndev)
{
	kfree(ndev->hci_dev);
}

and then frees ndev. Nothing in net/nfc/nci calls cancel_work_sync() or
flush_work() on msg_rx_work. msg_rx_queue and rx_hcp_frags are never
purged.

In the NCI_UP branch, nci_close_device() keeps the transport open
during the reset request. HCI packets received then still go through
rx_work and schedule msg_rx_work. That work can sleep: for example,
st_nci_hci_connectivity_event_received() calls
devm_kzalloc(GFP_KERNEL) and nfc_se_transaction().

Suppose st_nci_remove()->nci_unregister_device()->nci_free_device()
runs meanwhile. Can nci_hci_msg_rx_work() then touch the freed hdev and
ndev, or call nci_hci_send_data()->queue_work() on the destroyed tx_wq?
Any queued fragments and messages would also leak.

[Severity: Medium]
This isn't a bug introduced by this patch, but now that HCI responses
reach their callback again, each HCP RESPONSE completes the request
twice:

nci_hci_hcp_message_rx()
  nci_hci_resp_received()
    nci_req_complete(ndev, NCI_STATUS_OK);
  nci_req_complete(ndev, NCI_STATUS_OK);

nci_req_complete() only checks req_status == NCI_REQ_PEND. Suppose
rx_work is preempted after the first complete(). The waiter can return,
drop req_lock and start the next nci_request(), which sets
NCI_REQ_PEND. Could the second call then complete that new request
early with OK?

req_lock serializes submitters but doesn't exclude the receive worker.
In the final series state, the next HCI request would get -EPROTO from
nci_hci_take_resp(). A plain NCI command would instead return success
before its RSP arrives, and its real response would later be stored and
never consumed.

At this commit, the race can also cause a use-after-free of a stale
rx_skb. "nfc: nci: hci: consume the HCP response exactly once" fixes
that part.

[Severity: High]
This is a pre-existing issue, but at this commit NFCC data on the HCI
connection reaches nci_hci_data_received_cb() and nci_hci_msg_rx_work()
again. nci_hci_hcp_message_rx() ends with:

	nci_req_complete(ndev, NCI_STATUS_OK);

It does this for COMMAND, EVENT and unknown types as well, and
conn_info->rx_skb is never reset to NULL.

Suppose an unsolicited HCP EVENT or COMMAND arrives while one of these
is waiting:

  nci_hci_send_cmd()
  nci_hci_set_param()
  nci_hci_get_param()
  nci_nfcc_loopback()

The request then completes with OK. Can the waiter skb_pull() a NULL or
already-freed conn_info->rx_skb and hand it out again? That would lead
to a double free in callers such as st_nci_hci_load_session() and
st_nci_loopback().

Later patches in this series fix this. "nfc: nci: hci: consume the HCP
response exactly once" adds nci_hci_take_resp(), which detaches rx_skb
and returns -EPROTO when it is NULL. "nfc: nci: consume the loopback
response exactly once" does the same for nci_nfcc_loopback().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179331585573.30322.4049957541187612575%40gmail.com
