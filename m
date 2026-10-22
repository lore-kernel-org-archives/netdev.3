Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705636;
	b=fMcDCQ40usNRpXJ2RR2NdkkDV94Ksqnstwl8EuQujqZWhD9KI4i6Yw1ely0BbfTiUhsK
	 j+M3udPU7bjX/bLjEGgkzJ4vOM+7OSrcEjwhzQh8D6FI18vPxsF5NEO7eA09HVyOs3uyC
	 9mrZb/7lvn3ZzN+mhTBUhxMLV2bSFZ+8+uy1px/9WQWUjfnMYgOjtRZfMDv2mSWqC8KFq
	 yfkj/f5BIpH/fYp9STeSVueSncSf6DqF2h+fqpXzTl8wujQYceWuTgFk3q/uFJ12Dxbil
	 635dvM5pk/Mmhh88AH0Gt750mWc2cxhdDvA1HHQJMy/o87vq30GvEbIxLbTBV8xrHvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705636;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wKPqJqJRsRIftiybgm74ZKb3ZfigwGYYnrH0NmLs6/4=;
	b=wzRnG8Nnn6mZ2Pfb898yf6BWOHGy55Wg53muVbFPIy/Aj882vGy4T0Y5y9djbR1RZ7Cy
	 S0LEBEW6iRKnIxd2VXIJf084zldmS9/CDmlaPK1Nwow8vLOi3pBEEASWyEQBgbMcxHFcc
	 pKvjcVfnFoBtEALSAkGD6tmKyJmTIE9xD3QM27FbMCNhVd0qlR5GJRFVyvlyj3EPyquWg
	 MRetqhqnKuSqFlMLAYQybk1whdQ5VFmQY+BbU1tMjO0ttgRNFrr8ZzWKZ6OTiGNwRpuh9
	 5FuWw80ms4W8zZae7syRa5moBc0G3hj/r16j2pwi37UKYKi34FjMZJZZrlg1mF9a7mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CN7FfGEO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FD9606A31A;
	Thu, 22 Oct 2026 21:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CN7FfGEO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463C61F01825;
	Thu, 22 Oct 2026 21:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792705635;
	bh=wKPqJqJRsRIftiybgm74ZKb3ZfigwGYYnrH0NmLs6/4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CN7FfGEO8O7/O1GpltV64CiqG9EaCgrrEDHNnF3fOUQYK0ZK8Ae7ThjguevVwgXN0
	 Dl0lgOh0G4AP7WfJy/DTxsKW5m/NTGjG/NYGwjaj8Z0Qz0h7d7RZJFhEsDVgoMLWXz
	 7MS5q68VJ6o5okIlPxw41AUA/vj2ZI0xi8Rx1xmIUfQJkBHbjVvhkk+ZAbHrT7B7wy
	 6KIQHYun7L9w+tMRaHgXfNn/c25arMQCNGDpHDd9iqH3SiD1Po7wMY1zkWy1vC9KdH
	 KgeDZILRauCfvsNT0/Qsk7HUvtLAz083/O5GQgJXcQyPuu/JWfm46WnYcKBBtcPFXG
	 AQAqMxFW0jizg==
Subject: Re: [PATCH v1] qed: Protect iSCSI connection hash operations
From: netdev-bot+sashiko@kernel.org
To: 18983559317@163.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 21:47:14 +0000
Message-ID: <179270563482.1189532.4852760296170154407@kernel.org>
In-Reply-To: <20261020064701.535531-1-18983559317@163.com>
References: <20261020064701.535531-1-18983559317@163.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds one global lock, `static
  DEFINE_MUTEX(qed_iscsi_conn_lock)` (qed_iscsi.c:122), but the data it…
- [Medium] The commit says the mutex "serializes connection acquisition
  with storage stop", but qed_iscsi_acquire_conn() never checks…
- [Low] qed_iscsi_start() still writes state the new lock is meant to
  protect, without taking qed_iscsi_conn_lock: `cdev->flags |=…

Pre-existing issues:
- [Low] Peer code: qed_fcoe.c and qed_nvmetcp.c use the same unlocked
  lookup/use/hlist_del+kfree pattern on cdev->connections, and the new…

--

qed: Protect iSCSI connection hash operations

This adds a static mutex to qed_iscsi.c. The mutex is taken with guard()
in qed_iscsi_stop() and in each iSCSI connection operation (acquire,
release, offload, update, clear_sq, destroy, change_mac). Hash lookup,
firmware submission and wrapper free are then serialized against
connection release.

> diff --git a/drivers/net/ethernet/qlogic/qed/qed_iscsi.c b/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
> index 34f1217227bc..f7b97883e4b9 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_iscsi.c

[ ... ]

> @@ -118,6 +119,8 @@ struct qed_iscsi_conn {
>  	u8 abortive_dsconnect;
>  };
>  
> +static DEFINE_MUTEX(qed_iscsi_conn_lock);
> +

[Severity: Medium]
This is one global lock, but the state it protects belongs to each
device. cdev->connections is declared in struct qed_dev as
DECLARE_HASHTABLE(connections, 10), and QED_FLAG_STORAGE_STARTED lives in
cdev->flags.

The lock is also held across blocking QED_SPQ_MODE_EBLOCK ramrods: conn
offload, update, clear_sq, terminate, mac update and FUNC_STOP. For
example:

qed_iscsi_offload_conn()
    guard(mutex)(&qed_iscsi_conn_lock);
    ...
    qed_sp_iscsi_conn_offload(..., QED_SPQ_MODE_EBLOCK, NULL)
        qed_spq_post()
            qed_spq_block()

qed_spq_block() polls with 1000 x msleep(5), drains the MCP, then polls
again before it declares the ramrod stuck. One stalled ramrod can
therefore hold the mutex for about 10 seconds or more.

Doesn't this serialize iSCSI connection setup, teardown and
qed_iscsi_stop() across every qed adapter in the system? If one PF's
firmware stalls, these would all wait behind it on unrelated adapters:

- qedi offload work
- ep_disconnect driven by cleanup work
- __qedi_remove()->qedi_ops->stop()

The netlink-driven paths are already serialized by rx_queue_mutex in
scsi_transport_iscsi.c. The extra cost therefore lands mostly on offload
work, cleanup-work disconnects and stop.

The commit message calls this a "file-local mutex", but it doesn't
mention the coupling across devices. Would a lock per device, in struct
qed_dev or struct qed_iscsi_info, close the same race without it?

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch.
qed_fcoe.c and qed_nvmetcp.c use the same unlocked pattern on
cdev->connections: lookup, use, then hlist_del() and kfree(). That
covers qed_fcoe_get_hash(), qed_fcoe_acquire_conn(),
qed_fcoe_release_conn(), qed_nvmetcp_get_hash() and
qed_nvmetcp_acquire_conn(). The new mutex does not cover any of them.

No in-tree race was found there. qedf only reaches the FCoE connection
ops from qedf_rport_event_handler(). libfc runs that handler on the
ordered rport_event_queue created in fc_setup_rport(). The NVMe-TCP ops
from qed_get_nvmetcp_ops() have no in-tree users.

>  static int qed_iscsi_async_event(struct qed_hwfn *p_hwfn, u8 fw_event_code,
>  				 __le16 echo, union event_ring_data *data,
>  				 u8 fw_return_code)
> @@ -1080,6 +1083,7 @@ static int qed_iscsi_stop(struct qed_dev *cdev)
>  {
>  	int rc;
>  
> +	guard(mutex)(&qed_iscsi_conn_lock);
>  	if (!(cdev->flags & QED_FLAG_STORAGE_STARTED)) {
>  		DP_NOTICE(cdev, "iscsi already stopped\n");
>  		return 0;

[Severity: Low]
qed_iscsi_stop(), the qed_iscsi_get_hash() callers, acquire and release
now all hold qed_iscsi_conn_lock. qed_iscsi_start() still writes the
same state without the lock, and it sets the flag before it initializes
the table:

qed_iscsi_start() {
    ...
	cdev->flags |= QED_FLAG_STORAGE_STARTED;
	hash_init(cdev->connections);
    ...
}

In a normal probe this can't overlap any connection op, because
ops->start runs before iscsi_host_add().

Recovery is different. qedi_recovery_handler() calls
__qedi_probe(QEDI_MODE_RECOVERY), which assigns a new qedi->cdev and
calls qedi_ops->start while the iSCSI host is still registered.

A qedi_ep_connect() that passed its QEDI_IN_RECOVERY check earlier could
call acquire_conn() on the new cdev at the same moment. hash_init() would
then drop that entry. Can this leak the wrapper and the CID?

Should qed_iscsi_start() take the lock, and set QED_FLAG_STORAGE_STARTED
only after hash_init()? This matters mostly together with a STARTED
check in qed_iscsi_acquire_conn() (see below).

The error paths in qed_iscsi_start() call qed_iscsi_stop(), which now
takes this mutex, and the mutex is not recursive. Would that need a
__qed_iscsi_stop() helper that runs with the lock already held?

[ ... ]

> @@ -1158,6 +1162,7 @@ static int qed_iscsi_acquire_conn(struct qed_dev *cdev,
>  	struct qed_hash_iscsi_con *hash_con;
>  	int rc;
>  
> +	guard(mutex)(&qed_iscsi_conn_lock);
>  	/* Allocate a hashed connection */
>  	hash_con = kzalloc_obj(*hash_con, GFP_ATOMIC);
>  	if (!hash_con)

[Severity: Medium]
The commit message says "The mutex also serializes connection
acquisition with storage stop". However, qed_iscsi_acquire_conn() never
checks QED_FLAG_STORAGE_STARTED. What happens if qed_iscsi_stop() gets
the mutex first?

CPU1 (recovery)
__qedi_remove(QEDI_MODE_RECOVERY)
    qedi_ops->stop()
        qed_iscsi_stop()
            guard(mutex)(&qed_iscsi_conn_lock);
            hash_empty() is true
            qed_sp_iscsi_func_stop()
            cdev->flags &= ~QED_FLAG_STORAGE_STARTED;

CPU2, waiting on the mutex in this path:
qedi_ep_connect()
    qedi_ops->acquire_conn()
        qed_iscsi_acquire_conn()
            kzalloc_obj()
            qed_iscsi_acquire_connection()
            hash_add()

Once CPU2 has inserted the entry, qed_iscsi_get_hash() returns NULL for
it because the started flag is clear:

	if (!(cdev->flags & QED_FLAG_STORAGE_STARTED))
		return NULL;

Every operation on that handle then fails with "Failed to find
connection": offload, update, clear_sq, destroy, change_mac and
release_conn. qedi only logs the release_conn failure.
qed_iscsi_free() only frees free_list entries.

Doesn't this leak the hash wrapper, the CID, and the connection's chains
and DMA buffers? Should qed_iscsi_acquire_conn() return an error while
holding the lock if the function isn't started?

This ordering is possible because qedi_ep_connect() checks
QEDI_IN_RECOVERY only once. That check can run before
qedi_schedule_recovery_handler() sets the bit.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020064701.535531-1-18983559317%40163.com
