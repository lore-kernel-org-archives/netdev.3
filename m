Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE933A70E;
	Mon, 19 Oct 2026 04:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792382959; cv=none; b=ZtKlu4zP51OG5j/WNe37vcOC7Zcw9D26dhJf3Ak8zqHF7p4bHBDbImYf2I4084LU99BasU/agT1IzSp7wMJ3sM/rMhgAKADhbLb++0jeemoL40vr6cfL7Lq2tGp92x9cUjlUJm0zxJDgMs3FUIT6lJ09dKlSbiybc1uQBiiI51Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792382959; c=relaxed/simple;
	bh=WsLMTbcIKn8mAqXM2fEkKBbdwry6lJdPOUF+8u4YuU8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JhGSzVqHpybiaQmpwr6MvCIAkDoIeKKjxtqzzP4x+nyo7HhXHZbY0dgk5AlMXvFahsVFlfUVUpsJAhObHp27pcWcoyg1QEi1PsZ9gYyQQFOEaclQGckek/SfiDm+XRDbOtxOE92S9N6hNcFdd57ujfIZ0NAQf5SkSg7MgE8xddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNBnYy+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNBnYy+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDC11F000C4;
	Mon, 19 Oct 2026 04:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792382957;
	bh=YkbBQ2hChcNjEweU5kk7xG5MQFWyjFHL2ZSV0BeKE6A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fNBnYy+xtZVjPb3O/AthKd2rB1Nn7j9USwXwI3lLQFKOU+jEabm03tB3pPNz57nCv
	 7L0/xpnIuTC0mp7OV4BVe8DbKCJMfHRtScvJhCfmYicA5kTAyM3bPF9mtEwdOAClWq
	 +cJPngzQUb4ibXl7GI7KRluKUv4ExhtRlWZH9Bxp55n1s3jfMOXBRrkjXg2TVDvo3x
	 TXmCalY8DpbgLIXN6c5ZpxAkjoPbEEzz1fEa716xO1Sx4/NbUBca9HN9KFOKpIFQ2D
	 7ncs3ShXd/+sZaXe04LPkrHP0nH2Hc1gtc6G/A2NuAWFORvdpF+om9/55ix6MEUXPp
	 6F7j31b6TfcNA==
Subject: Re: [PATCH] mlxsw: pci: drain EQ tasklet during teardown
From: netdev-bot+sashiko@kernel.org
To: yaojiale02@163.com
Cc: idosch@nvidia.com, petrm@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 jiri@resnulli.us, eladr@mellanox.com, sfeldma@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 04:09:16 +0000
Message-ID: <179238295637.3135.13378300618060950499@kernel.org>
In-Reply-To: <20261018040653.534066-1-yaojiale02@163.com>
References: <20261018040653.534066-1-yaojiale02@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch drains only the first stage of the deferred EQ chain
  (IRQ -> tasklet).

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch adds
  another unconditional EQ dereference to the path it affects.

--

mlxsw: pci: drain EQ tasklet during teardown

This patch adds a tasklet_kill() for the EQ tasklet in mlxsw_pci_fini(),
after free_irq() and before mlxsw_pci_aqs_fini(). The goal is to stop a
tasklet that was queued before the IRQ was released from touching the EQ
DMA buffer and queue array after they are freed.

> diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
> index bfe3268dfdc17..ba66142ae333c 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
> @@ -2085,8 +2085,11 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
>  static void mlxsw_pci_fini(void *bus_priv)
>  {
>  	struct mlxsw_pci *mlxsw_pci = bus_priv;
> +	struct mlxsw_pci_queue *q;
>  
>  	free_irq(pci_irq_vector(mlxsw_pci->pdev, 0), mlxsw_pci);
> +	q = mlxsw_pci_eq_get(mlxsw_pci);
> +	tasklet_kill(&q->u.eq.tasklet);

[Severity: High]
Does this fully close the teardown race the commit message describes?

tasklet_kill() waits for TASKLET_STATE_SCHED to clear. So a tasklet that
was pending when free_irq() ran will run to completion. At the end,
mlxsw_pci_eq_tasklet() schedules NAPI for each CQ that saw an event:

drivers/net/ethernet/mellanox/mlxsw/pci.c:mlxsw_pci_eq_tasklet() {
    ...
	cq_count = mlxsw_pci->num_cqs;
	for_each_set_bit(cqn, active_cqns, cq_count) {
		q = mlxsw_pci_cq_get(mlxsw_pci, cqn);
		napi_schedule(&q->u.cq.napi);
	}
}

Nothing waits for those polls. The RX NAPI device is threaded, see
netif_threaded_enable(mlxsw_pci->napi_dev_rx) in
mlxsw_pci_napi_devs_init(). Its poll runs in a kthread and can run well
after tasklet_kill() returns.

mlxsw_pci_aqs_fini() frees the RDQ group first, then the SDQ group, and
the CQ group last:

	mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_rdq_ops);
	mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_sdq_ops);
	mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_cq_ops);

The RDQ teardown frees memory in three places:

  - mlxsw_pci_rdq_fini() frees the RX pages
  - mlxsw_pci_queue_fini() frees elem_info and the DMA ring
  - mlxsw_pci_queue_group_fini() frees the queue structs

The only napi_disable() is in mlxsw_pci_cq_fini(), and that runs after
all of this.

A concurrent mlxsw_pci_napi_poll_cq_rx() can still be using the RDQ:

	struct mlxsw_pci_queue *rdq = q->u.cq.dq;
	...
		if (unlikely(dqn != rdq->num)) {
	...
		mlxsw_pci_cqe_rdq_handle(mlxsw_pci, napi, rdq,
					 wqe_counter, q->u.cq.v, cqe);
	...
	mlxsw_pci_queue_doorbell_producer_ring(mlxsw_pci, rdq);

The producer doorbell ring runs on every poll, even when there are no
CQEs. mlxsw_pci_napi_poll_cq_tx() uses sdq = q->u.cq.dq the same way.

Could this cause a use-after-free of the RDQ/SDQ structs, their elem_info
arrays and the RX pages?

Besides killing the tasklet, should the CQ NAPI instances be quiesced
(napi_disable() or napi_synchronize()) before the RDQ/SDQ groups are
freed?

[Severity: High]
This is a pre-existing issue, but this patch adds another unconditional
EQ dereference on a path that can run with no queues set up.

In mlxsw_pci_init(), the unsupported CQE version branch jumps to the
unwind path without setting err:

	} else {
		dev_err(&pdev->dev, "Invalid supported CQE version combination reported\n");
		goto err_cqe_v_check;
	}

At that point err is still 0 from the earlier successful
mlxsw_core_resources_query(). The unwind runs mlxsw_pci_fw_area_fini()
and mlxsw_pci_free_irq_vectors(), then returns 0.

So __mlxsw_core_bus_device_register() treats bus init as successful. No
napi devs, async queues or IRQ were set up.

Suppose a later registration step fails, for example registering
resources or mlxsw_ports_init(). The unwind then calls the bus fini:

err_register_resources:
	mlxsw_bus->fini(bus_priv);

mlxsw_pci_fini() then calls free_irq() on an IRQ that was never
requested. With this patch, mlxsw_pci_eq_get() returns an address derived
from a NULL queues[].q array (or a stale freed one after a reload), and
tasklet_kill() dereferences it.

Before this patch, the same path already oopsed in
mlxsw_pci_napi_devs_fini()->free_netdev(NULL). mlxsw_pci_fw_area_fini()
also runs a second time, so the fw_area items get freed twice.

Should the CQE version check set err = -EINVAL before the goto? The
missing assignment seems to date back to commit 8404f6f2e8ed.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018040653.534066-1-yaojiale02%40163.com
