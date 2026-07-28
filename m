Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396D91A5B9E
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785239397; cv=none; b=sVOzyFLlm0+HJs9fqJ2k8VIyLK/vBIyEHsvI6Hqd5uLgyIxZs31Td3guiEjTcJjDi9VEFA01vuil2ErG8ofnPTbk1E1vkLsdv7gRWtHNXxOdaArP7nGTB0swuCYXpTsJ8n2GCcPbY2YQJBdxlfDl+6vU7cBnFggX7hIw5K6NJzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785239397; c=relaxed/simple;
	bh=wtjr+jisvt2M9z9plAqh7JqHeu4+mowPJoTDgcCqygI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaVncl9M8/jdQnCIM3AvhAemFNpUmCfjIkzojve/yE3qGrmeH2VaZ55v4gc0mx5q46IP77VAl+XZ7EoiNm+6oCxp1cqEnUUVzPBFPojJVl4LAk3kZ1sbjhQRAJJiUCmfX/eBpWs9Q/D7bFIOFDujt/4kDGuQgUiTrf93jznVYq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALgO4WoT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALgO4WoT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D495E1F000E9;
	Tue, 28 Jul 2026 11:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785239395;
	bh=RzWJXVxdM9eSw3ZCzcb5gnFCSxov90kE+e6rSFBsJ8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ALgO4WoTZSKgGbn3bhfKe3/gTlmnRUC2KN4axTXKbiIQcnJh/j0ivYhJ3xTwNf6KH
	 x2ClHfJQxIu1BkPjHzdex0DDtf1hPB+ICl8V5GZVB1xZsMQ1GAbFopa3VqiZC2c6Lr
	 AktnmJc2gUnFLkWYi2wVr5BpahhHCTU5EDpLt4gHrCqa+fwTl8uFDNlhOlswzieeoq
	 hE25d2P0yMo+A8CuFchME90yuLKvkhwK5fdud9iv/ip5n1zgXoPC+YDQhCuD0knnSJ
	 S96+5RWDItDu2hZuDo1td54n3aYSQmE8hO76eKYywzJ1CydWjcTWk3QfOwjVZrTpEB
	 2q8ibV8yvfqTw==
From: Simon Horman <horms@kernel.org>
To: enjou1224z@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	luoxuanqiang@kylinos.cn,
	tim.bird@sony.com,
	acme@mandriva.com,
	vega@nebusec.ai,
	xizh2024@lzu.edu.cn
Subject: Re: [PATCH net 1/1] llc: fix listener child socket leak on non-SABME frames
Date: Tue, 28 Jul 2026 12:49:43 +0100
Message-ID: <20260728114943.887161-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <631a34bdb0c1e1ab47ba75a4be94b5129b7a122f.1784725007.git.zihanx@nebusec.ai>
References: <631a34bdb0c1e1ab47ba75a4be94b5129b7a122f.1784725007.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/631a34bdb0c1e1ab47ba75a4be94b5129b7a122f.1784725007.git.zihanx@nebusec.ai?part=1
---
llc: fix listener child socket leak on non-SABME frames

This patch restricts child socket creation in llc_conn_handler() to
frames that are actual SABME commands, by gating the TCP_LISTEN branch
on llc_conn_ev_rx_sabme_cmd_pbit_set_x(). Non-SABME traffic then falls
through to the else branch, which attaches skb->sk to the listener and
runs the LLC connection state machine on the listener socket itself.

> diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> index 260460d50f54..7bf3f7f517b3 100644
> --- a/net/llc/llc_conn.c
> +++ b/net/llc/llc_conn.c
> @@ -794,7 +794,8 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
>  	 * the originator of the new connection, and this state has to be
>  	 * in the newly created struct sock private area. -acme
>  	 */
> -	if (unlikely(sk->sk_state == TCP_LISTEN)) {
> +	if (unlikely(sk->sk_state == TCP_LISTEN) &&
> +	    !llc_conn_ev_rx_sabme_cmd_pbit_set_x(sk, skb)) {
>  		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
>  							      &saddr, &daddr);
>  		if (!newsk)

[Critical]
When the new condition is false (non-SABME frame arriving at a listener),
control now falls into the else branch and drives the listener itself
through llc_conn_rcv() -> llc_conn_state_process() -> llc_conn_service().
Is that intentional?

The listener's llc_sock state is set by llc_sk_init() to
LLC_CONN_STATE_ADM and is not updated by llc_ui_listen():

  net/llc/llc_c_ac.c / llc_sk_init():
    llc->state = LLC_CONN_STATE_ADM;

In net/llc/llc_c_st.c the ADM state table contains llc_adm_state_trans_5
with .ev = llc_conn_ev_rx_any_frame (an unconditional match) and
.next_state = LLC_CONN_OUT_OF_SVC, which equals 0. After a single
non-DISC, non-XXX-with-P=1 frame (for example an I-frame or S-frame with
P=0, or a DM/UA/FRMR response) matches trans_5, llc_conn_service() will
write llc_sk(listener)->state = 0.

On the following non-SABME frame reaching the same listener,
llc_conn_service() only guards:

    if (llc->state > NBR_CONN_STATES)
        goto out;

so state == 0 passes through, and llc_qualify_conn_ev() then computes:

    curr_state = &llc_conn_state_table[llc->state - 1];

which indexes llc_conn_state_table[-1], followed by
llc_find_offset(llc->state - 1, ev->type) indexing llc_offset_table[-1]
[...]. Both are out-of-bounds reads before a 12-entry array. The garbage
curr_state->transitions pointer is then iterated and eventually
(*next_trans)->ev(sk, skb) is called through an attacker-triggerable but
uninfluenced function pointer.

Since llc_lookup_listener() will match any frame carrying the listener's
SAP when no established socket exists, a peer on the local segment can
reach this with two crafted LLC frames.

Should the else branch continue to skip the connection state machine
for a listening socket, or should the ADM tables be prevented from
executing against a TCP_LISTEN sk in the first place?

[Medium]
Is the wire-level behavior for DISC and other pbit=1 commands against a
listener intended to change here?

Prior to this patch, llc_create_incoming_sock() ran first and did:

    memcpy(&newllc->daddr, saddr, sizeof(newllc->daddr));

so DM responses generated by the ADM state transitions were addressed to
the peer that sent the DISC. After the patch, the ADM transitions run on
the listener itself.

In net/llc/llc_c_st.c the ADM table includes llc_adm_state_trans_3 for
DISC commands, whose action is llc_conn_ac_send_dm_rsp_f_set_p() in
net/llc/llc_c_ac.c. That builds the DM response using llc->daddr.lsap
(via llc_pdu_header_init) and llc->daddr.mac (via llc_mac_hdr_init).

For a socket()+bind()+listen() socket, llc->daddr is never populated:
llc_ui_bind() only writes llc->laddr and llc->dev, and llc_sk_init()
zero-initializes daddr. The DM response therefore goes to MAC
00:00:00:00:00:00 with destination LSAP 0. The same concern applies to
llc_adm_state_trans_4 (rx_xxx_cmd_pbit_set_1 ->
llc_conn_ac_send_dm_rsp_f_set_1).

Should the commit message call out this on-wire behavioral change for
legitimate DISC traffic against a listening socket, or should the else
branch avoid running these transitions on a listener whose daddr is
unset?
