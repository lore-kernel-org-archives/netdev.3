Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793663027;
	b=us1SxY3iv3LaMBKGSuKdL9mQBvpUGqyZwxJfjom6I2bcX9PowqdGhtBZSj4yOOiyELlQ
	 iGDmYk7tTDUhENIfKp5dU+vaZ68E8gXn2imTiLHG4pRcwpFIF0tMMFTXTfv6UuWwyafbt
	 hUs6RypgQAqmtdMYL6H/Af0UT3jrddXa1AkXo3wFR1aM+3WosrVzpE7b4t1inf3oeN4Qs
	 yrYs6tx3xScw7aJICci98u4QEdK8ZzUHCieBHTKMsijcDf7P5lup0EThP9x57uZXpF/mr
	 lQwcJYMMv/VGGsRNQf1qYqExAkJQOn3ESILkliJZoFMkqq1MacrqhLBhrCZ2cMAIFVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663027;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fiY9qWgjrYJMpr6GH8v035SqUvzibVkrP6YYRS1LKkU=;
	b=v5WIFSQ2MuL6SWJ1BXCXJQe/nZYK7ulrWvsbF1YKolAy+x1A4qkR07fBLgFGv7U7i9JY
	 R9V1YqfZ62G36svEbSAeEKv2HAN4mYQTryayudvZ+UGf4DkGWRxJQ2lP2JpaBKTEfD3ke
	 uVTvR2i3Yw2ch3/sPB7aQC++CyxRyTUWheTwgR+1sv70gqDkQFxp63I/1InNI0ozeCvtD
	 J42hgRcAmkpOx3/DUlxlELz4LxnXo0yFURw5yUm3JHYyiWB0ouDBdCaHQ83exiYW4wMvk
	 KtrgVWS31ZlrUy56fIZQfdpwbTRLMNQjDs9JVmbcl9vhzfw7qGCCH/R2qluaXN0wF7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VV3fldM5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AB3606A32C;
	Mon,  2 Nov 2026 23:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VV3fldM5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F4C1F00A16;
	Mon,  2 Nov 2026 23:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793663026;
	bh=fiY9qWgjrYJMpr6GH8v035SqUvzibVkrP6YYRS1LKkU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VV3fldM5z0a/KL0QUT1/KwUVd+V4NJI4+aLLAVoHx9IUlR4WMLLKcQbJpBlcyg4kd
	 zC5ZxwU7AMjjc7OOTD3EOAOIRx5eWjcxDTM6a/ITr+gNMYpdjYTFyAObV3wPhI8jYv
	 XgOb2E7RIs8wDBVti0Hoh7vCwLAlBwjz1PFm95xXCl4HF10EUkvQ+0wBJM7N9O/tW4
	 +OEAFEk6FEARhC4t9qgfAAvYOiEZGszZ5+KtlOGT6L5+I6e8vW9Wqt9yv4djVKdujk
	 AnLucMr7yrt8XDRnoKSKvUuGVrr8uPIS6TEIEu89faW3Uye1+FRRTWE0WiBb8W9pgK
	 hIzAbhDVw52zQ==
Subject:
 Re: [PATCH net 3/5] nfc: nci: consume the loopback response exactly once
From: netdev-bot+sashiko@kernel.org
To: joasantonio108@gmail.com
Cc: david@ixit.cz, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kipreyyy@gmail.com,
 sanghyun.park.cnu@gmail.com, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 23:43:45 +0000
Message-ID: <179366302585.488856.12804499169587262096@kernel.org>
In-Reply-To: <179331585573.30322.5511229003943288914@gmail.com>
References: <179331585573.30322.5511229003943288914@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] nci_nfcc_loopback() (net/nfc/nci/core.c) can still use or write
  freed memory.
- [Medium] The patch consumes conn_info->rx_skb only when nci_request()
  returns NCI_STATUS_OK.
- [Medium] The read-then-clear the patch adds to nci_nfcc_loopback()
  (core.c:471-472, `rx_skb = conn_info->rx_skb; conn_info->rx_skb =…

--

nfc: nci: consume the loopback response exactly once

This patch changes nci_nfcc_loopback() so that, after a successful
nci_request(), it detaches conn_info->rx_skb before using it. The skb is
freed if the caller passed no resp pointer, and -EPROTO is returned if the
request completed without a data packet. The goal is to fix a
use-after-free and double free that happen when a stray zero-status NCI
response completes a loopback request.

> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index 73e3a96470ace..8e2a755ce2555 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c

[ ... ]

> @@ -464,8 +464,20 @@ int nci_nfcc_loopback(struct nci_dev *ndev, const void *data, size_t data_len,
>  	ndev->cur_conn_id = conn_id;
>  	r = nci_request(ndev, nci_send_data_req, &loopback_data,
>  			msecs_to_jiffies(NCI_DATA_TIMEOUT));
> -	if (r == NCI_STATUS_OK && resp)
> -		*resp = conn_info->rx_skb;
> +	if (r == NCI_STATUS_OK) {

[Severity: Medium]
Can a stale rx_skb from an earlier loopback still be returned here?

The rx_skb is only consumed when nci_request() returns NCI_STATUS_OK.
Nothing clears or frees conn_info->rx_skb before the new request is sent.
The same is true on the -ETIMEDOUT, -ERESTARTSYS and non-zero status
paths.

data_exchange_cb is never cleared. nci_data_exchange_complete() checks
NCI_DATA_EXCHANGE only for the static RF connection:

net/nfc/nci/data.c:nci_data_exchange_complete() {
    ...
	if (conn_id == NCI_STATIC_RF_CONN_ID &&
	    !test_and_clear_bit(NCI_DATA_EXCHANGE, &ndev->flags)) {
    ...
}

Suppose loopback #1 times out and its data packet arrives late.
nci_nfcc_loopback_cb() still stores the packet:

	conn_info->rx_skb = skb;

Suppose loopback #2 is then completed by a stray zero-status response,
like the CORE_SET_CONFIG_RSP in the commit message. Wouldn't this code
return the skb from loopback #1 as the reply to loopback #2?
st_nci_loopback() would then copy that skb's data to userspace.

If the real data for loopback #2 arrives instead, nci_nfcc_loopback_cb()
overwrites rx_skb without freeing it. Does that leak the late skb?

nci_core_conn_close_rsp_packet() and nci_unregister_device() also drop
conn_info without freeing any skb still stored in rx_skb.

st21nfca_hci_loopback(), by comparison, clears its rx_skb before it sends.
Could conn_info->rx_skb be freed and cleared before nci_request() here,
and on the error paths too?

> +		/* Consume the stored data packet exactly once, see
> +		 * nci_nfcc_loopback_cb().
> +		 */
> +		rx_skb = conn_info->rx_skb;
> +		conn_info->rx_skb = NULL;

[Severity: High]
Is conn_info still valid at this point?

conn_info is looked up before the blocking nci_request() call, and
ndev->cur_conn_id is set to the loopback conn_id. While the request is
pending, the NFCC can send an unsolicited CORE_CONN_CLOSE_RSP with
status 0. nci_rsp_packet() picks the handler by opcode only, and the
handler does:

net/nfc/nci/rsp.c:nci_core_conn_close_rsp_packet() {
    ...
	if (status == NCI_STATUS_OK) {
		conn_info = nci_get_conn_info_by_conn_id(ndev,
							 ndev->cur_conn_id);
		if (conn_info) {
			list_del(&conn_info->list);
			...
			devm_kfree(&ndev->nfc_dev->dev, conn_info->dest_params);
			devm_kfree(&ndev->nfc_dev->dev, conn_info);
		}
	}
	nci_req_complete(ndev, status);
}

That completes the loopback request with NCI_STATUS_OK. The code above then
reads rx_skb from freed memory, and with this patch it also writes NULL
into that memory.

If the slab object has been reused, could the new NULL store corrupt the
new owner? If the read returns a non-NULL value, st_nci_loopback() would
read skb->len and skb->data and then call kfree_skb() on it. That is the
same skb use-after-free and double free the commit message describes.

Would it be safer to look up conn_info again after nci_request() returns,
or to check that the completing response belongs to this request?

[Severity: Medium]
Can this read-then-clear race with nci_nfcc_loopback_cb()?

These are two plain accesses, and they share no lock with the code that
stores rx_skb. nci_nfcc_loopback_cb() runs from rx_work and doesn't take
req_lock:

	conn_info->rx_skb = skb;

	nci_req_complete(ndev, NCI_STATUS_OK);

In the case this patch targets, a stray zero-status response completes
the request first. rx_work can then handle the real loopback data packet
while the woken caller is in this code:

caller                                rx_work
rx_skb = conn_info->rx_skb; /* NULL */
                                      conn_info->rx_skb = skb;
conn_info->rx_skb = NULL;
return -EPROTO;

Does that leak the skb stored by the callback? This is also an unlocked
race on a plain pointer, which KCSAN would report.

> +		if (!rx_skb)
> +			return -EPROTO;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179331585573.30322.4049957541187612575%40gmail.com
