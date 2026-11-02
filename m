Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793663026;
	b=2tKxbgxJgv3NUYqLXWjwsTvsa8sr+4j6uJfIBp7iS7TOmmoJYMz/S5jr5zs/SEYQeOJp
	 HXGp6Hrdbe/SWz9Tv9OCcQlqmI3cohrWf1yhE5qdrWf07lpfED2tRWUusgKw0YL9SLmR+
	 omXXhMa1mBwTlS1uF3YzlRCWofINmYm162XpPHHck6wAOj64GVU0mqK2iT5Bfg197v8dN
	 U+zx0nomfbkoJIxewrzO48xPanFlRaEHzBBzql1FrrkFYwEqDRVltvy/gZe0BxmdA02Re
	 5C6/r3RSzpvAmoVCcjrmlOrofeb1WpclEUbI7CO+vAnnL20asdXrI/rjsC1bnTEoNbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663026;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4Q+auJPRcijjK3FmxhEyDyKRGdGiI29PIOAGVmK0B2w=;
	b=cmp/It1Wc9gL/a2J+gVfl29tW74vxuBcGr8BGvELTeQcTL/7tFzYDVOywNHrL+e2qiRL
	 xcPX36/fKflCpMPiXkP1xzycb7nKQ0GdzCEtQmGUpc9IsmV+JjUVTT1DoDSycnxdu8t0X
	 7QfCzm3pt8j4HZHNpaJJw8KvH81GD/qAih3V65SvSDo8y7VutTt284Vkz8sw7dc1bOtb3
	 8D/FU/JYI5gnAJVNv2Aj+iKB34gqCaTokR4dOq9s+i/tnNUOceyw20f0qMoHTluASeloB
	 rnL7SsvYCShz4Qb5ntCZPJLRscl8HYl6AlsgztMCICG6uuSf4kVN2S769ywtI7vOFNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFtiEuez;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E46606A330;
	Mon,  2 Nov 2026 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFtiEuez
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3FF1F00A17;
	Mon,  2 Nov 2026 23:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793663025;
	bh=4Q+auJPRcijjK3FmxhEyDyKRGdGiI29PIOAGVmK0B2w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SFtiEuezJqws90yp2q8FCHJdJHK8rDKLYBpOGv1vlxYAqdkCmfVNJaqKU+NHPzJwt
	 HkzeVvx1uyAl4rXgeo7Of1v7BuZRN8YFEzeFjbeAMWKUGHgWRsCUG9+vjXlzC/GD2d
	 PjWpU6HcIlyJ5BU1guF+IPw8jpFkqos729+pwU7WmQYoSel2spEwjlZ7GvG1R984Fo
	 GfyN7tnUh3tMeO7BN8rE10EiHJfnqBLqzLckU0+ymY6bnR7DMhdN64Q1lJxycusgyG
	 gT0a4dVsVwqkAQnQ4LUy9hWPGFMfNrsyqCi8i29y2rnZPu2dwEOQMzJSber+oI+qyT
	 Yx6yXWdgcE3+Q==
Subject:
 Re: [PATCH net 2/5] nfc: nci: hci: consume the HCP response exactly once
From: netdev-bot+sashiko@kernel.org
To: joasantonio108@gmail.com
Cc: david@ixit.cz, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kipreyyy@gmail.com,
 sanghyun.park.cnu@gmail.com, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 23:43:44 +0000
Message-ID: <179366302460.488856.3883849138274450813@kernel.org>
In-Reply-To: <179331585573.30322.10620513309471785412@gmail.com>
References: <179331585573.30322.10620513309471785412@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] nci_hci_take_resp() is supposed to return -EPROTO "when the
  request was completed without a response" and not "reuse whatever skb…
- [Low] nci_hci_take_resp() detaches the response with a plain load
  followed by a plain store (`rx_skb = conn_info->rx_skb;…

--

nfc: nci: hci: consume the HCP response exactly once

This patch adds nci_hci_take_resp(). The helper detaches the HCP response
stored in conn_info->rx_skb, parses it, and either hands it to the caller
or frees it. It returns -EPROTO when a request completes without a stored
response. nci_hci_send_cmd(), nci_hci_set_param(), nci_hci_get_param() and
now nci_hci_open_pipe() all use it, which closes the use-after-free and
NULL dereference shown in the commit message.

> diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
> index c03e8a0bd3bd6..bdfe9eee6358c 100644
> --- a/net/nfc/nci/hci.c
> +++ b/net/nfc/nci/hci.c
> @@ -107,6 +107,38 @@ static int nci_hci_result_to_errno(u8 result)
>  	}
>  }
>  
> +/* Take the HCP response stored by nci_hci_resp_received().
> + *
> + * The response skb is detached from conn_info so that it is consumed
> + * exactly once.  A request can also be completed without a response
> + * being stored (an HCP command or event received while the request is
> + * pending, or an unrelated NCI response), so a missing response is an
> + * error rather than a reason to reuse whatever skb was stored last.
> + */
> +static int nci_hci_take_resp(struct nci_conn_info *conn_info,
> +			     struct sk_buff **skb)
> +{
> +	const struct nci_hcp_message *message;
> +	struct sk_buff *rx_skb;
> +	int r;
> +
> +	rx_skb = conn_info->rx_skb;
> +	conn_info->rx_skb = NULL;

[Severity: Low]
Can this read-and-clear race with nci_hci_resp_received()? Every caller
runs nci_hci_take_resp() after nci_request() has dropped ndev->req_lock.
The producer runs from rx_wq and shares no lock with this code.

Suppose an HCI command is completed early by an HCP event or an OK-status
NCI notification, and its real response comes in during this window:

caller                                rx_wq
nci_hci_take_resp()
  rx_skb = conn_info->rx_skb; /* NULL */
                                      nci_hci_resp_received()
                                        conn_info->rx_skb = skb;
  conn_info->rx_skb = NULL;

The skb stored by rx_wq would be overwritten and leaked, and the call
would return -EPROTO. These are also plain, unannotated concurrent
accesses that KCSAN would report.

Two consumers detaching the same skb doesn't look reachable in-tree. The
nfc generic netlink family doesn't set parallel_ops, so genl_mutex
serializes the callers.

Would xchg(), or detaching under a lock shared with the producer, avoid
the lost store?

> +	if (!rx_skb)
> +		return -EPROTO;

[Severity: Medium]
Can a request still get an earlier request's response here? The comment
above says a missing response is an error rather than a reason to reuse
whatever skb was stored last. However, the only check is for NULL.

Several paths call nci_req_complete(ndev, NCI_STATUS_OK) whenever any
request is pending:

  nci_hci_hcp_message_rx() for HCP events and commands (run later from
  msg_rx_work)
  nci_rf_deactivate_ntf_packet(), nci_nfcee_discover_ntf_packet() and
  nci_core_reset_ntf_packet() in ntf.c
  the zero-status NCI response handlers in rsp.c

If one of these completes HCI command R1 early, this correctly returns
-EPROTO. When R1's real response arrives afterwards,
nci_hci_resp_received() still stores it unconditionally:

net/nfc/nci/hci.c:nci_hci_resp_received() {
	...
	conn_info->rx_skb = skb;

exit:
	nci_req_complete(ndev, NCI_STATUS_OK);
}

That function doesn't check whether a request is pending or which pipe
the response is for. It also doesn't free an skb that is already stored.
The same thing happens when R1 hits NCI_DATA_TIMEOUT in __nci_request()
and the NFCC answers late.

None of nci_hci_send_cmd(), nci_hci_get_param(), nci_hci_set_param() or
nci_hci_open_pipe() clears rx_skb before calling nci_request().

For the next command R2, there seem to be two outcomes.

If R2's own response arrives, it overwrites the orphan and the orphaned
skb leaks. Could an NFCC that keeps sending late or unsolicited responses
leak skbs without bound this way?

If R2 is also completed early, nci_hci_take_resp() parses R1's HCP result
code and hands R1's payload to R2's caller. R2's own response then becomes
the next orphan, so the mismatch carries forward. Callers that would get
the wrong payload include:

  nci_hci_create_pipe(), which reads resp->pipe at offset 4 with no
  length check, so a payload-less ANY_OPEN_PIPE response would be read
  past its data
  nci_hci_dev_session_init() (session identity)
  st_nci_hci_load_session() (pipe list)
  st_nci_control_se() (host list)
  st_nci_se_get_atr() (ATR)

The commit message says the helper returns -EPROTO "when the request was
completed without a response". In this sequence the request succeeds with
the previous request's response.

Would it make sense to drop any stale rx_skb before sending, for example
in the req callback under req_lock? Separately, nci_hci_resp_received()
could store a response only while a request is pending, freeing any
previous skb.

> +
> +	message = (struct nci_hcp_message *)rx_skb->data;
> +	r = nci_hci_result_to_errno(NCI_HCP_MSG_GET_CMD(message->header));
> +	skb_pull(rx_skb, NCI_HCI_HCP_MESSAGE_HEADER_LEN);
> +
> +	if (!r && skb)
> +		*skb = rx_skb;
> +	else
> +		kfree_skb(rx_skb);
> +
> +	return r;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179331585573.30322.4049957541187612575%40gmail.com
