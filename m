Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050673803F1;
	Thu,  3 Sep 2026 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463496; cv=none; b=KDdkgyutih3Y8d017k1bpLB9QQtMki3IluNQghWdiJqwR7dEXuqi1UDWpOEzQ27TDkRnTTylgXuu5b7ribPiTmazjXhEAUMhqOzTzofrYaVUl/pSQxzsdUYdsRLDAvkqpK6ShA1a5ZBxAKcaNp9zEn9AQsUwZYRYzpM+TuCfJ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463496; c=relaxed/simple;
	bh=+fNdJZOmvapYX3MmKPmxsURktulSEHp/3I0FbtTk3vk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lgcyFbaJEUkQCD2gaFWRbStm0wBRno7vAHpZ8vQ+PYtldi8WKtdMO/PEyyckW8A94g7p1Hu/2aQqs82aFSv478SKTIRZQzxlKVRUqZRy/5rzdiUq6mEOhXEGHr0pBiEROJVSZhy9w/6/zPTcKETROz/xq5nZY1vCcguArj+ISzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsp2o2Cx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsp2o2Cx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082F71F000E9;
	Thu,  3 Sep 2026 19:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788463484;
	bh=617IV9aUFHVhs1kqL0fyEBVpgctDw0jm9RKwMNfcZzs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nsp2o2CxM8tRSYXAO+1CTMCBaBVQqRreDtTExeSGghLWwGWUeZ3mDFLmauSDdEJUG
	 7O8BQbnS9GkaunteS+RwWVj9JT1xZaqhVRYiFg0mCfpvmSm+6cviC/Ox3jKrw9wOTQ
	 ImUoMZRNmsXOMcY99+Ng619r+DdPHt/npLMyDEdKopn+/FKg1cjaU5NeUxgnLFsURF
	 ks4uN2tzvBakNsTXtmvMBUt6+ABlhB/jFU9L0TFxAI6fT7KcRkFyPhv3k/Aou8wPmt
	 75rnV7P1iKDz575N9eBLZU9mojKaYIo1NNCj175xs59XS/K324hw8a09L41k5PB13x
	 xB5axXYxIWvGQ==
Subject: Re: [v9,net-next,1/8] octeontx2-af: switch: Add AF to switch mbox and
 skeleton files
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com
Date: Thu, 03 Sep 2026 19:24:43 +0000
Message-ID: <178846348357.3394541.4333175060649528755@kernel.org>
In-Reply-To: <20260831131944.2649362-2-rkannoth@marvell.com>
References: <20260831131944.2649362-2-rkannoth@marvell.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 0

- [High] The four new messages are registered in the generic AF ID range
  (0x010-0x013) and are dispatched by rvu_process_mbox_msg(), which…
- [Medium] rvu_mbox_handler_fl_notify() and
  rvu_mbox_handler_fl_get_stats() (af/switch/rvu_sw_fl.c:9-21) register…

Pre-existing issues:
- [Medium] rvu_process_mbox_msg() casts the received message to `struct
  _req_type *` purely on the basis of the sender-supplied req->id, and…

--

octeontx2-af: switch: Add AF to switch mbox and skeleton files

This patch adds four new AF mailbox messages (FDB_NOTIFY, FIB_NOTIFY,
FL_NOTIFY, FL_GET_STATS) with their request/response structures, plus a new
switch/ subdirectory holding skeleton handler functions that currently just
return 0.

A few questions about the new message IDs and the stub handlers below.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index cece197d1074b..854696d2a35f1 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -164,6 +164,14 @@ M(PTP_GET_CAP,		0x00c, ptp_get_cap, msg_req, ptp_get_cap_rsp)	\
>  M(GET_REP_CNT,		0x00d, get_rep_cnt, msg_req, get_rep_cnt_rsp)	\
>  M(ESW_CFG,		0x00e, esw_cfg, esw_cfg_req, msg_rsp)	\
>  M(REP_EVENT_NOTIFY,     0x00f, rep_event_notify, rep_event, msg_rsp) \
> +M(FDB_NOTIFY,		0x010,  fdb_notify,				\
> +				fdb_notify_req, msg_rsp)		\
> +M(FIB_NOTIFY,		0x011,  fib_notify,				\
> +				fib_notify_req, msg_rsp)		\
> +M(FL_NOTIFY,		0x012,  fl_notify,				\
> +				fl_notify_req, msg_rsp)		\
> +M(FL_GET_STATS,		0x013,  fl_get_stats,				\
> +				fl_get_stats_req, fl_get_stats_rsp)	\

[Severity: High]
Should these four IDs be restricted to a privileged sender?

They are added to the generic AF ID range, and rvu_process_mbox_msg() in
af/rvu.c dispatches on req->id after only checking req->sig, with no
per-ID or per-sender filtering. __rvu_mbox_handler() feeds both TYPE_AFPF
and TYPE_AFVF messages into that same dispatcher, and the only
sanitisation it does for a VF is to stamp the sender's own identity:

	case TYPE_AFVF:
		msg->pcifunc &=
			~(RVU_PFVF_FUNC_MASK << RVU_PFVF_FUNC_SHIFT);
		msg->pcifunc |= (devid << RVU_PFVF_FUNC_SHIFT) + 1;
		break;

	err = rvu_process_mbox_msg(mbox, devid, msg);

So any PF and any VF, including a VF assigned to an untrusted guest via
SR-IOV, can issue these switch control-plane messages. None of the new
handlers looks at who sent the message.

The stubs make this harmless today, but as the series makes the handlers
functional, rvu_mbox_handler_fdb_notify() ends up gating only on
RVU_SWITCH_FLAG_FW_READY plus

	port_id = rvu_sw_port_id(rvu, req->hdr.pcifunc);
	if (port_id == RVU_SW_INVALID_PORT_ID)
		return -EINVAL;
	...
	ether_addr_copy(l2_entry->mac, req->mac);
	l2_entry->flags = req->flags;

which every representor-mapped PF and VF satisfies, after which the
caller-supplied MAC and OTX2_FDB_ADD/OTX2_FDB_DEL are programmed toward
the switch for that port. rvu_mbox_handler_fib_notify() similarly accepts
caller-supplied route entries from any PF/VF.

Compare with the sibling handler added in the same series, which does
perform the check:

	if (!rvu_is_switch_pcifunc(rvu, sender))
		return -EPERM;

and with rvu_mbox_handler_esw_cfg() in af/rvu_rep.c, which ignores
requests whose hdr.pcifunc differs from rvu->rep_pcifunc. Would an
equivalent sender check on the new handlers be appropriate?

[ ... ]

> @@ -1812,6 +1820,116 @@ struct rep_event {
>  	struct rep_evt_data evt_data;
>  };
>  
[ ... ]
> +struct fib_notify_req {
> +	struct  mbox_msghdr hdr;
> +	u16 cnt;
> +	u16 rsvd[3]; /* explicit padding for entry[] 8-byte alignment */
> +	struct fib_entry entry[16];
> +};

[Severity: Medium]
This isn't a problem introduced by this patch, but it does enlarge the
worst case for it.

rvu_process_mbox_msg() casts the received message to struct _req_type *
based purely on the sender-supplied req->id:

	err = rvu_mbox_handler_ ## _fn_name(rvu,			\
					    (struct _req_type *)req, \
					    rsp);

and __rvu_mbox_handler() walks the message list using the sender-supplied
offset without bounding it against the region:

		offset = mbox->rx_start + msg->next_msgoff;

struct fib_notify_req is 1176 bytes here, which becomes by far the largest
AF request payload, so it widens how far past a minimally sized message a
handler can be made to read once it dereferences req->entry[]. At the end
of the series rvu_mbox_handler_fib_notify() memcpy()s req->cnt *
sizeof(struct fib_entry) out of the shared mbox region and forwards it to
the switch OS.

The actionable fix here belongs in the mbox core (validating next_msgoff
and the available message size against the declared request type) rather
than in these handlers, so this is noted for information only.

[ ... ]

> +struct fl_get_stats_req {
> +	struct  mbox_msghdr hdr;
> +	u64 cookie;
> +};
> +
> +struct fl_get_stats_rsp {
> +	struct  mbox_msghdr hdr;
> +	u64 pkts_diff;
> +};
> +

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
> new file mode 100644
> index 0000000000000..1f8b82a84a5dd
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
> @@ -0,0 +1,21 @@
[ ... ]
> +int rvu_mbox_handler_fl_get_stats(struct rvu *rvu,
> +				  struct fl_get_stats_req *req,
> +				  struct fl_get_stats_rsp *rsp)
> +{
> +	return 0;
> +}
> +
> +int rvu_mbox_handler_fl_notify(struct rvu *rvu,
> +			       struct fl_notify_req *req,
> +			       struct msg_rsp *rsp)
> +{
> +	return 0;
> +}

[Severity: Medium]
Should these two stubs report success?

Once FL_NOTIFY and FL_GET_STATS are registered in MBOX_MESSAGES, the
dispatcher no longer answers with otx2_reply_invalid_msg(); instead it
presets a success code and only overrides it if the handler fails:

	if (rsp) {
		...
		rsp->hdr.rc = 0;
	}
	err = rvu_mbox_handler_ ## _fn_name(rvu, (struct _req_type *)req, rsp);
	if (rsp && err)
		rsp->hdr.rc = err;

Since otx2_mbox_alloc_msg_rsp() zeroes the whole response region:

	/* Clear the whole msg region */
	memset(msghdr, 0, size);

FL_GET_STATS answers every query with pkts_diff = 0 and rc = 0, so a
requesting peer cannot tell a genuine zero delta from a discarded request
and may age the flow out. Likewise, rvu_mbox_handler_fl_notify() ignores
cookie, flags, features and tuple entirely, yet acknowledges the flow
install or delete as done, so a peer that stops software forwarding after
a successful FL_NOTIFY would blackhole that flow.

Both handlers are still identical at the end of the series, so this is not
a transient state within the series. Would returning -EOPNOTSUPP, or
holding back the ID registration until the handlers are implemented, be
preferable?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831131944.2649362-1-rkannoth%40marvell.com
