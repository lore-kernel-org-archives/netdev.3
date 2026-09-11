Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B068390603;
	Fri, 11 Sep 2026 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152339; cv=none; b=HpHOKmBeDPEW0BXSyh04XSmZ6VTfbtJVNE0REeIaiTs/9BGwgZqG7iEwGB99LiRxOL2rhIphsZ1sQBspd7/FfYIK9NMe4LZx1zPSHgpBC7XUd3net11bjb3XIAKZ6jxcNdJI/sxvlpbRYe8E6ZT9anmz17sh0jpMMfS89ztEK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152339; c=relaxed/simple;
	bh=bB6zZ/r9t4Hco1hdmHS5Vd6WCuAFrO94Y8zdwuxSwbs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FuACRacwq/AQ93070C7dpgdzrkTMEZPqZu5Xv40aU+J/boSva/sB3WNT6IUfz2EHRFn2tQ4NHZ5vRfXnMr4F2tUGMP+99oC/4NctvWnJjHQ9WnCeV6y8QIcUoNTmRqQnlJ1ACUXmyDRFTod1wxZolOaED1nv4lIS/CqzR3Dd/zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTzaCIhA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTzaCIhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D4A1F00893;
	Fri, 11 Sep 2026 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152334;
	bh=Gj7dgaAw30zvtgszk2wXMwbDtA8UOklsz0Rf5Gwa+20=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XTzaCIhA57ZbFv8SyKcQjSZIaSpZMPo58Yu6KCKtYn/HTD+2zF35TrfVXLrcB9Lvm
	 VVDKBZS+f1VgCHH/8eqSPWkyX8CtbQxOF0DENGMMVThiXlMrPBuncNlUwYaPc36x4V
	 lpbuR74wuOixbmqkt0+oMhjL3BTuyyYgqe/eTxNJ1vyWObJP65qFQhoMge8DLdu9SS
	 pJaYEVVSrkW6WRPqDLKAsdEwQwXKb9IdGOCUgA+TgzSur/AZ/gr+nwll/e9OItyTRp
	 FyCdf6JmWMRz0Ad/TVWoSgBqfSx7USdrMwMljzYLAVR2AjoDktI0KpZE6qWPx2DA2v
	 pbsUxq8DnlHyQ==
Subject:
 Re: [PATCH] net: ipa: validate QMI sender for modem-only server requests
From: netdev-bot+sashiko@kernel.org
To: kennethkabogo2@gmail.com
Cc: elder@kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 18:45:34 +0000
Message-ID: <178915233401.219967.3094305844336909787@kernel.org>
In-Reply-To: <20260910181737.55570-1-kennethkabogo2@gmail.com>
References: <20260910181737.55570-1-kennethkabogo2@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 0 · High: 3 · Medium: 4 · Low: 0

- [High] The patch guards the two readiness flags set from the server
  handle (indication_requested at ipa_qmi.c:210, uc_ready at :246) but…
- [High] The new sender check anchors trust in ipa_qmi->modem_sq, but
  modem_sq is itself learned from an unauthenticated QRTR name-service…
- [High] The new gate rejects every request whenever modem_sq is zero or
  stale, and two structurally reachable paths put it there while the…
- [Medium] ipa_server_from_modem() (drivers/net/ipa/ipa_qmi.c:172-177)
  requires sq->sq_port == ipa_qmi->modem_sq.sq_port, but modem_sq is the…
- [Medium] The commit message states that a local non-modem process "can
  spoof both signals and drive ipa_qmi_ready() to completion before the…
- [Medium] The new gate ipa_server_from_modem() (ipa_qmi.c:172-177) reads
  ipa_qmi->modem_sq.sq_node and .sq_port from the *server* QMI handle's…
- [Medium] The commit message relies on ipa_server_bye() zeroing modem_sq
  to make teardown-window requests fail the new check, but…

--

net: ipa: validate QMI sender for modem-only server requests

This adds a helper ipa_server_from_modem() and uses it in
ipa_server_indication_register() and ipa_server_driver_init_complete()
to drop QMI requests whose sender does not match the cached
ipa_qmi->modem_sq.  Requests from any other sender are logged and
discarded.

A few questions on the commit message and the new check below.

The commit message says:

  "A local process able to send QMI messages on the qrtr socket, other
  than the modem, can spoof both signals and drive ipa_qmi_ready() to
  completion before the modem has confirmed its endpoint configuration"

[Severity: Medium]
Is that mechanism description accurate for the two handlers being changed?

ipa_qmi_ready() has a third gate that neither patched handler touches:

drivers/net/ipa/ipa_qmi.c:ipa_qmi_ready() {
	/* We aren't ready until the modem and microcontroller are */
	if (!ipa_qmi->modem_ready || !ipa_qmi->uc_ready)
		return;
	...
}

and modem_ready is only set after the AP's own INIT_DRIVER transaction
completes successfully in ipa_client_init_driver_work():

	if (!ret) {
		ipa_qmi->modem_ready = true;
		ipa_qmi_ready(ipa_qmi);		/* We might be ready now */

So spoofing only INDICATION_REGISTER and DRIVER_INIT_COMPLETE cannot reach
ipa_modem_start() "before the modem has confirmed its endpoint
configuration" — modem_ready is that confirmation.  The effect appears to
be bring-up after INIT_DRIVER succeeds but before the genuine
DRIVER_INIT_COMPLETE, unless the sender also supplies the client-side
response or supplants the cached service.

Could the message be reworded to describe what the two patched handlers can
actually do, and mention the client-handle path?

> diff --git a/drivers/net/ipa/ipa_qmi.c b/drivers/net/ipa/ipa_qmi.c
> index d771f3a71f94f..a7cc98b27e33c 100644
> --- a/drivers/net/ipa/ipa_qmi.c
> +++ b/drivers/net/ipa/ipa_qmi.c
> @@ -168,6 +168,14 @@ static const struct qmi_ops ipa_server_ops = {
>  	.bye		= ipa_server_bye,
>  };
>  
> +/* True if a QMI request arrived from the modem we are paired with */
> +static bool ipa_server_from_modem(const struct ipa_qmi *ipa_qmi,
> +				  const struct sockaddr_qrtr *sq)
> +{
> +	return sq->sq_node == ipa_qmi->modem_sq.sq_node &&
> +	       sq->sq_port == ipa_qmi->modem_sq.sq_port;
> +}
> +

[Severity: Medium]
Is the sq_port term correct here?  modem_sq is written only in
ipa_client_new_server(), from the modem's advertised service address:

	ipa_qmi->modem_sq.sq_family = AF_QIPCRTR;
	ipa_qmi->modem_sq.sq_node = svc->node;
	ipa_qmi->modem_sq.sq_port = svc->port;

That is the port the AP's client handle sends INIT_DRIVER to.  The sq
passed to the two patched handlers is the source address of a request that
arrived on the AP's server handle, i.e. the modem's QMI client endpoint.

Is a peer's client port guaranteed to equal its advertised service port?
This driver itself is a counterexample: ipa_qmi_setup() creates two
qmi_handles, each bound to its own qrtr port, so a symmetric modem
implementation would send from a port other than the one its service is
registered on.

If those two ports differ on real firmware, every legitimate request fails
the check, indication_requested and uc_ready are never set, and
ipa_modem_start() is never called.  DRIVER_INIT_COMPLETE is one-shot per
initial boot, so there is no retry.  Has this been confirmed on hardware?

[Severity: High]
Does anchoring trust in modem_sq close the described hole, given how
modem_sq is learned?  ipa_client_new_server() stores whatever node and port
were announced for service 0x31 instance 2, with no check that the
announcing node is the modem's remote qrtr node.

For a local sender, the name service rewrites the announced address to the
sender's own:

net/qrtr/ns.c:ctrl_cmd_new_server() {
	/* Ignore specified node and port for local servers */
	if (from->sq_node == qrtr_ns.local_node) {
		node_id = from->sq_node;
		port = from->sq_port;
	}
	...
}

and binding an ephemeral port needs no capability:

net/qrtr/af_qrtr.c:qrtr_port_assign() {
	} else if (*port < QRTR_MIN_EPH_SOCKET && !capable(CAP_NET_ADMIN)) {
		rc = -EACCES;
	...
}

So the same actor the commit message describes can register a fake IPA
modem service, become the cached modem_sq, receive the AP's INIT_DRIVER
request, answer it, and then send INDICATION_REGISTER and
DRIVER_INIT_COMPLETE from that same port — satisfying
ipa_server_from_modem() exactly.

Would validating the peer's qrtr node against the modem remoteproc or
DT-derived node (or rejecting services announced on the local node) be the
check that actually holds?

[Severity: High]
Is the modem_ready path left unguarded on purpose?  modem_ready is set when
the INIT_DRIVER response is matched on the client handle, and the QMI core
matches responses by transaction id alone:

drivers/soc/qcom/qmi_interface.c:qmi_handle_message() {
	...
		txn = idr_find(&qmi->txns, le16_to_cpu(hdr->txn_id));
	...
}

The sender address is never compared against the address the request was
sent to, and ipa_client_init_driver() ignores both sq and the decoded
result:

	txn->result = 0;	/* IPA_QMI_INIT_DRIVER request was successful */
	complete(&txn->completion);

ipa_server_bye() deliberately preserves uc_ready and leaves initial_boot
false across modem restarts, so on any non-initial boot modem_ready is the
only remaining gate and a single forged INIT_DRIVER response reaches
ipa_modem_start() by itself.  Does the bug class the commit message
describes remain reachable through this sibling path?

[Severity: Medium]
Can these two loads race with the writer?  modem_sq is read here from the
server handle's worker, while ipa_client_new_server() writes sq_family,
sq_node and sq_port as three plain stores from the client handle's worker.
Each handle gets its own workqueue:

drivers/soc/qcom/qmi_interface.c:qmi_handle_init() {
	qmi->wq = alloc_ordered_workqueue("qmi_msg_handler", 0);
	...
}

There is no lock, no READ_ONCE()/WRITE_ONCE() and no release/acquire
pairing, so a reader on the server worker can see sq_node updated while
sq_port is still zero.  The gate then returns false and the request is
dropped with no QMI response sent.

[Severity: Medium]
Related to the same unserialized field: the commit message relies on

  "is zeroed in ipa_server_bye(); a zeroed modem_sq does not match any real
  sender's address"

but ipa_server_bye() runs on the server handle's worker and
ipa_client_new_server() on the client handle's, with nothing ordering BYE
for the dying modem instance against NEW_SERVER for the new one.  If the
server worker is delayed across the restart, its

	memset(&ipa_qmi->modem_sq, 0, sizeof(ipa_qmi->modem_sq));

lands after modem_sq was re-populated for the new modem, leaving it
all-zero while a real modem is present.  Before this patch that only
mis-addressed the optional INIT_COMPLETE indication; now it rejects every
real modem request for the rest of the boot.  Is that inversion prevented
somewhere?

>  /* Callback function to handle an INDICATION_REGISTER request message from the
>   * modem.  This informs the AP that the modem is now ready to receive the
>   * INIT_COMPLETE indication message.
> @@ -185,6 +193,13 @@ static void ipa_server_indication_register(struct qmi_handle *qmi,
>  	ipa_qmi = container_of(qmi, struct ipa_qmi, server_handle);
>  	ipa = container_of(ipa_qmi, struct ipa, qmi);
>  
> +	if (!ipa_server_from_modem(ipa_qmi, sq)) {
> +		dev_warn_ratelimited(ipa->dev,
> +				     "ignoring QMI request from non-modem sender %u:%u\n",
> +				     sq->sq_node, sq->sq_port);
> +		return;
> +	}
> +

[Severity: High]
Can a legitimate modem request be dropped here whenever modem_sq is zero or
stale?  Two paths put it in that state while the modem is alive.

First, an unrelated subsystem restart.  ipa_server_bye() zeroes modem_sq and
ignores its node argument:

drivers/net/ipa/ipa_qmi.c:ipa_server_bye() {
	/* The modem client and server go away at the same time */
	memset(&ipa_qmi->modem_sq, 0, sizeof(ipa_qmi->modem_sq));
	...
}

while the name service fans a BYE for any dying remote node out to every
local server port:

net/qrtr/ns.c:ctrl_cmd_bye() {
	xa_for_each(&local_node->servers, index, srv) {
		sq.sq_family = AF_QIPCRTR;
		sq.sq_node = srv->node;
		sq.sq_port = srv->port;
	...
}

and the QMI core passes that node straight through:

drivers/soc/qcom/qmi_interface.c:qmi_recv_bye() {
	qmi_recv_del_server(qmi, node, -1);

	if (ops->bye)
		ops->bye(qmi, node);
}

So an ADSP or CDSP restart zeroes modem_sq with the modem still up, and
nothing repopulates it until the modem itself re-registers.

Second, ordering at boot.  ipa_qmi_setup() advertises the AP server with
qmi_add_server() before qmi_add_lookup() for the modem service, and
modem_sq is only populated from the asynchronous NEW_SERVER message
processed on the client handle's separate socket and workqueue.  Nothing
ties the modem's INDICATION_REGISTER or DRIVER_INIT_COMPLETE to the AP
having already observed the modem's service registration — this is the
ordering concern raised in the cover note.

In both cases the return happens before qmi_send_response(), so the modem's
transaction is never answered, indication_requested and uc_ready stay
false, and there is no retry or re-arm path back into ipa_qmi_ready().
Would explicitly testing whether modem_sq has been populated, and only then
enforcing the match, avoid this?

Also, should ipa_server_bye() compare its node argument against
modem_sq.sq_node before zeroing, now that the zeroed value denies all
requests?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910181737.55570-1-kennethkabogo2%40gmail.com
