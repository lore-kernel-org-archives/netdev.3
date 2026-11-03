Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705352;
	b=CFan7sh0ENI81mdNE3KXoxXfbOoDdx8dAr/9iwYChUH4VO3RyH0qGreT/fc+8FNanIsd
	 lVB0L1F1IvyEjw0Lgl0rulO8WKXbVzg70soLWsg5Svkl10PToJyCt/NYtE/qGtI4utNd3
	 0AXtAZmp0ceuUkTIPXZq13AxvZfGHcLAsUA/mGGLZ7x1f8lzzUMCLFwYmg3sT98BeR+Aj
	 w1nIFH/UFtz03XOpX8Bdw6WLandGeVfwZNdgogfQgRslyC/sQUEZ7OB4oZKkW0Ns9tRzY
	 bND2FQTG78hVU/pJw/+qNN9OveApmhmwjO9wByfP+Ln5m1WtSgZxJILolpn2w/RDnAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705352;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=J5yxO8lilgc19IuqfuL9Fa6EIhGpaW4Jlrhz7b/ZRXE=;
	b=MirYWXDUdnBLYJTb7ym9lfw0LfJbSrl7/Vimh/99z31OBeZPqzuJh+i7fN13amesOhYB
	 fogp6vv0hV0Q57SKx0hl/z40X473X3HqD0d/Jh5TXMNRAt1KfDf2JBMG2ZUzoSlD2GJf6
	 vOG7woh4w9qZ/x9fO7ehX5dpVPPJJjSetgXcWMLCB38z4XerU3HWFpY9NiUmvaouhmAky
	 1vLj0bOTfLJBuDaBg+/TxS973P1EnCxwvPqinLhjAMkL+0C4FwotwGUhzlB0bsAUb2cyC
	 jVgH4vSeqYFLRY8nG+GsmwyzNZvH/NqEFqfG3/qthFFeZicLPFsGYSNY9lfaoGdYHyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jv4K7HV2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FD8606A815;
	Tue,  3 Nov 2026 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jv4K7HV2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508211F00ADD;
	Tue,  3 Nov 2026 11:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793705351;
	bh=J5yxO8lilgc19IuqfuL9Fa6EIhGpaW4Jlrhz7b/ZRXE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jv4K7HV2eFB7r3M6sMnFkarUIXko0cUORWLLWFiEOPrPZ1NGdGXMGLwjdw5DhHzTy
	 ew9ilppd5krjkME3P4f+WXvX16Ws2lY2nsjfUTHK4jR66nV89xkvQ75y5pSUdaV9M9
	 Bsl7XD9bj7SeL/8uICn6opt9xdNlUdjV3RRUG9K8mzF7dGIdfnY9cPmVxJ70mwb6Y/
	 lpSgFUqAjADItLdUPsV8wyRDZ5AmUM2BCXseHskATowKdqzGx2OjWz7UHXPshMEjiW
	 vrWHAvj/B/rAmTNtLcru8K/8JiuTDFoVWnXKhbhCrsp4oI6pHIIOeigx7BD2Sb1Zeh
	 Otrr5A5py4Iqw==
Subject: Re: [PATCH net 3/3] nfc: llcp: free the response skb when the data
 exchange fails
From: netdev-bot+sashiko@kernel.org
To: joasantonio108@gmail.com
Cc: david@ixit.cz, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 11:29:10 +0000
Message-ID: <179370535090.488856.2461985767393023537@kernel.org>
In-Reply-To: <179335864272.64596.2156668877648051796@gmail.com>
References: <179335864272.64596.2156668877648051796@gmail.com>
X-sashiko-severity: Critical
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

Critical: 3 · High: 0 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Double free of the LLCP response skb on digital (NFC-DEP)
  devices.
- [Critical] Double free of the raw-socket response skb on digital NFC-
  DEP targets, caused by the companion commit "nfc: rawsock: free the…
- [Critical] nfc: rawsock: double free of skb in
  rawsock_data_exchange_complete()

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but on ST21NFCA
  the failed HCI LLCP initiator exchange that the commit message…

--

nfc: llcp: free the response skb when the data exchange fails

This patch makes nfc_llcp_recv() free the skb it gets when the data
exchange reports an error. The commit message says HCI and NCI pass a
response skb along with the error, so the old early return leaked it. It
also says the skb is NULL when the error comes without a response.

> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index 74bf817007cf2..f0632a0b94e74 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -1638,6 +1638,8 @@ void nfc_llcp_recv(void *data, struct sk_buff *skb, int err)
>  
>  	if (err < 0) {
>  		pr_err("LLCP PDU receive err %d\n", err);
> +		/* skb may carry the response even when the exchange failed */
> +		kfree_skb(skb);

[Severity: Critical]
The double free isn't in this hunk. The commit message builds on the
raw socket change earlier in this series ("Like for raw sockets"), and
that change looks like it can free the response skb twice on digital
stack devices.

With the rawsock patch applied, rawsock_data_exchange_complete() frees
the skb whenever err is set:

net/nfc/rawsock.c:rawsock_data_exchange_complete() {
    ...
	/* skb may carry the response even when the exchange failed */
	if (err)
		goto error_skb;
    ...
error_skb:
	kfree_skb(skb);
    ...
}

A raw socket can connect with nfc_protocol = NFC_PROTO_NFC_DEP.
rawsock_connect() calls nfc_activate_target(), and
digital_activate_target() stores that value in ddev->curr_protocol.
After that, every send from rawsock_tx_work() takes this path:

rawsock_tx_work()
  nfc_data_exchange(..., rawsock_data_exchange_complete, sk)
    digital_in_send()
      digital_in_send_dep_req()
        ... digital_in_recv_dep_res()

digital_in_recv_dep_res() has several protocol error paths that set
rc < 0 and jump to exit: while resp is still live:

  - a bad SoD length byte
  - an oversized frame
  - the NAD bit is set
  - a NACK is received
  - an ACK has a PNI mismatch
  - an ACK arrives with no chaining skb

On each of them it calls the callback and then frees resp itself:

net/nfc/digital_dep.c:digital_in_recv_dep_res() {
    ...
exit:
	data_exch->cb(data_exch->cb_context, resp, rc);

error:
	kfree(data_exch);
    ...
	if (rc)
		kfree_skb(resp);
}

So rawsock_data_exchange_complete() frees resp once, and the end of
digital_in_recv_dep_res() frees it again. The remote NFC-DEP peer
controls all of these error conditions. A single malformed DEP_RES is
enough to corrupt memory or crash the kernel.

Before this series, rawsock_data_exchange_complete() did not free the
skb on error. That makes this a regression, and both patches are
tagged Cc: stable.

The rawsock commit message says the skb is NULL when the error comes
without a response, and it lists digital as one of those cases. That
doesn't match digital_in_recv_dep_res(). It passes a live skb to the
callback but keeps ownership of it.

Which side is meant to own the skb when err is set? One option is for
digital_in_recv_dep_res() to pass NULL to the callback on error, as
digital_in_send_complete() already does. Then HCI, NCI and digital
would all follow one rule. Could that change go into this series ahead
of the rawsock and llcp patches? Could the data_exchange_cb_t
kernel-doc also state the ownership rule?

                 ^^^^

[Severity: Critical]
Can this free the response skb twice on digital stack devices (port100,
trf7970a, st95hf, nfcsim)?

On those devices LLCP runs over NFC-DEP. digital_dep_link_up() sets
ddev->curr_protocol = NFC_PROTO_NFC_DEP, so every LLCP exchange goes
through:

nfc_llcp_tx_work() / nfc_llcp_send_symm()
  nfc_data_exchange(..., nfc_llcp_recv, local)
    digital_in_send()
      digital_in_send_dep_req()

The exchange then completes in digital_in_recv_dep_res(). That function
still frees resp after it has called the callback:

net/nfc/digital_dep.c:digital_in_recv_dep_res() {
    ...
	rc = digital_skb_pull_dep_sod(ddev, resp);
	if (rc) {
		PROTOCOL_ERR("14.4.1.2");
		goto exit;
	}
    ...
exit:
	data_exch->cb(data_exch->cb_context, resp, rc);

error:
	kfree(data_exch);
    ...
	if (rc)
		kfree_skb(resp);
    ...
}

With this patch, nfc_llcp_recv() frees resp inside data_exch->cb(). The
"if (rc) kfree_skb(resp)" at the end then frees the same skb again.

Several other cases also reach exit: with a live resp and rc < 0:

  - resp->len > ddev->local_payload_max (-EMSGSIZE)
  - the NAD bit is set
  - a NACK is received
  - an ACK has a PNI mismatch
  - an ACK arrives with no ddev->chaining_skb

The remote NFC-DEP peer controls all of these. The SoD length byte is
checked before the CRC.

The commit message says:

    Free the skb on the error path; it is NULL when the error does not come
    with a response, and kfree_skb() handles that.

That doesn't seem to hold for digital NFC-DEP. There the error does come
with a response, but the producer keeps ownership of it.

The producers also disagree with each other:

  - digital_in_send_complete() frees resp and passes NULL on error.
  - HCI (__nfc_hci_cmd_completion()) and NCI hand ownership to the
    callback.
  - digital_in_recv_dep_res() frees resp itself after the callback.

The data_exchange_cb_t kernel-doc in include/net/nfc/nfc.h doesn't say
who owns the skb when err is set.

Could the producers be made to agree in the same series? For example,
digital_in_recv_dep_res() could pass NULL on error the way
digital_in_send_complete() does, or stop freeing resp after it calls the
callback. This patch is also tagged Cc: stable.

[Severity: Medium]
This isn't a bug introduced by this patch, but does a failed HCI LLCP
initiator exchange like the one in the commit message still leak the
response skb on st21nfca?

Take a READER_F target with supported_protocols == NFC_PROTO_NFC_DEP_MASK.
For it, st21nfca_hci_im_transceive() drops the callback it was given:

drivers/nfc/st21nfca/core.c:st21nfca_hci_im_transceive() {
    ...
	case ST21NFCA_RF_READER_F_GATE:
		if (target->supported_protocols == NFC_PROTO_NFC_DEP_MASK)
			return st21nfca_im_send_dep_req(hdev, skb);
    ...
}

So nfc_llcp_recv() is never reached on this path. The completion goes to
st21nfca_im_recv_dep_res_cb() instead.

When the controller returns an error result, __nfc_hci_cmd_completion()
passes both skb and err to that callback and does not free the skb. The
callback then returns early:

drivers/nfc/st21nfca/dep.c:st21nfca_im_recv_dep_res_cb() {
    ...
	if (err != 0)
		return;
    ...
}

Does this leak one skb per failed WR_XCHG_DATA exchange?

[Severity: Critical]
The commit message builds on the raw socket change ("Like for raw
sockets"). Is the same double free also reachable through the companion
commit f50c413847da ("nfc: rawsock: free the response skb when the data
exchange fails") in this series?

After that commit, rawsock_data_exchange_complete() frees the skb on any
error:

net/nfc/rawsock.c:rawsock_data_exchange_complete() {
    ...
	/* skb may carry the response even when the exchange failed */
	if (err)
		goto error_skb;
    ...
error_skb:
	kfree_skb(skb);
    ...
}

A SOCK_SEQPACKET raw socket does not need CAP_NET_RAW, and it can connect
with nfc_protocol = NFC_PROTO_NFC_DEP. digital_activate_target() then just
stores that value:

	ddev->curr_protocol = protocol;

>From then on, raw socket exchanges follow this path:

rawsock_tx_work()
  nfc_data_exchange()
    digital_in_send()
      digital_in_send_dep_req()
        ... digital_in_recv_dep_res()

A malformed DEP_RES (bad SoD length byte, NAD bit set, NACK, PNI
mismatch) reaches the exit: label with a live resp.
rawsock_data_exchange_complete() frees it, and then
"if (rc) kfree_skb(resp)" in digital_in_recv_dep_res() frees it again.

That commit message also says the skb:

    is NULL when the error does not
    come with a response (digital, timeouts, device close)

This doesn't seem to match digital NFC-DEP. In the baseline,
rawsock_data_exchange_complete() did not free the skb on error, so this
double free would be new with the series.

Should the fix for digital DEP ownership cover the raw socket path too?

>  		return;
>  	}
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179335864271.64596.805818095553030218%40gmail.com
