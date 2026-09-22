Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EBE5349CC;
	Tue, 22 Sep 2026 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790074590; cv=none; b=S4rmfQzjq50VdmVHtKG/peepWRhQi/uvTWGcDiRXLT93l5Jrj7DjBjApx9SITVQrE/TeHpZBaRQp+Msr0Z53uteLPv5Rd4QQL9VHAfRvzDmR8TBws20Tzc27c/aImcNET2SBInVWI61y0j2vgHCVm50/Csnyh2aZPcuuOMhOKdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790074590; c=relaxed/simple;
	bh=BaOKa6gDiwdZMHlzoNnkDZljCU8CLAL3hHHAvlsR814=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZGoxLTaQ6wwbjR9OLmY6CiFw+acACtJ4NH0w1fKpG1NEVoYDtSZ+4d6Uwjlr3teqc3XvCWT65rXfc84ne0rmx3l6LEdRGj0caaRitMttPWwj5SJDq/0o6AzwutLTYnGjurjq5HTBWxpyy3TbPR3dENC8bgd+Ucpcs9isIX99VRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXawFPrw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXawFPrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB961F000FF;
	Tue, 22 Sep 2026 10:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790074581;
	bh=z+tMrQ5pPFejRapMiyMQ81+N3hZiDVmPs4BB/RN3mzI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VXawFPrwoY33mMHkG7u7UoVI7k7FsDInE545MA+t+F9Snz4PCQV/foxyUZr4uI+OK
	 KrhI/anzi9WQKDBAUR5bnA1pNV0jlSD79Epi48y6z6LsNP3cOZF/cL2zt6h1b4AHuX
	 SyznAL4rVPfhnQnuoZwk2u3qhr8ROh90PiNuNa1wpqXhCgaLtYJ8PpL0eeVDYNcgwZ
	 8k/TrwFFMgrBithkGna607KSVwOQUjLSTzJA8U7Bjg0uN/eYWoexPMHGDFN+xRYKHr
	 lTtqhO/BUDyMhNH+jjYCBzsOz1lQyupmd9VmrDTveurrkAQ8QXQy+u2D3NULfmdDxf
	 Rqy3VQ6lLvmrQ==
Subject: Re: [PATCH net-next v1] net: devmem: document that bind-tx is
 unprivileged by design
From: netdev-bot+sashiko@kernel.org
To: almasrymina@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, razor@blackwall.org,
 daniel@iogearbox.net, bobbyeshleman@meta.com
Date: Tue, 22 Sep 2026 10:56:20 +0000
Message-ID: <179007458060.2160803.1077952399417880240@kernel.org>
In-Reply-To: <20260921195545.493253-1-almasrymina@google.com>
References: <20260921195545.493253-1-almasrymina@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] NETDEV_CMD_BIND_TX is unprivileged (net/core/netdev-genl-
  gen.c:240-245: .flags = GENL_CMD_CAP_DO), and this patch cements that…
- [Medium] The comment added above netdev_nl_bind_tx_doit()
  (net/core/netdev-genl.c:1183-1188) and the mirrored note in…
- [Medium] bind-tx is reachable by any unprivileged user
  (net/core/netdev-genl-gen.c:244: .flags = GENL_CMD_CAP_DO) with no…

--

net: devmem: document that bind-tx is unprivileged by design

This adds a comment above netdev_nl_bind_tx_doit() and a matching note in
Documentation/netlink/specs/netdev.yaml stating that NETDEV_CMD_BIND_TX
carries no GENL_ADMIN_PERM / GENL_UNS_ADMIN_PERM on purpose, on the grounds
that bind-tx only DMA-maps the caller's dmabuf.

A few questions about the rationale being recorded here.

> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index e13461cf3fc33..4303593e5003c 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -852,6 +852,8 @@ operations:
>        name: bind-tx
>        doc: Bind dmabuf to netdev for TX
>        attribute-set: dmabuf
> +      # Intentionally unprivileged (no admin-perm / uns-admin-perm); see
> +      # comment above netdev_nl_bind_tx_doit().
>        do:
>          request:
>            attributes:
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index fa9edfdb32c29..690c27f63d260 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1180,6 +1180,12 @@ netdev_find_netmem_tx_dev(struct net_device *dev)
>  	return NULL;
>  }
>  
> +/* Note: NETDEV_CMD_BIND_TX is intentionally unprivileged (no
> + * GENL_ADMIN_PERM / GENL_UNS_ADMIN_PERM). Unlike bind-rx, which configures
> + * shared NIC RX queues, bind-tx only DMA-maps the caller's dmabuf so they can
> + * transmit from it on their own sockets without affecting other traffic or
> + * device state.
> + */

[Severity: High]
Is the "on their own sockets" part of this rationale actually enforced
anywhere?

net_devmem_bind_dmabuf() in net/core/devmem.c allocates the id out of a
single global xarray and only records the owning netlink socket for cleanup:

	err = xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
			      binding, xa_limit_32b, &id_alloc_next,
			      GFP_KERNEL);
	...
	list_add(&binding->list, &priv->bindings);

priv->bindings is then only walked by netdev_nl_sock_priv_destroy().

On the TX side, net_devmem_get_binding() resolves whatever u32 the sender
passed and checks only that a tx_vec exists and that the route egresses the
bound device:

	binding = net_devmem_lookup_dmabuf(dmabuf_id);
	if (!binding || !binding->tx_vec) {
		err = -EINVAL;
		goto out_err;
	}
	...
	dst_dev = dst_dev_rcu(dst);
	if (unlikely(!dst_dev) ||
	    unlikely(dst_dev != READ_ONCE(binding->dev) &&
		     dst_dev != READ_ONCE(binding->vdev))) {
		err = -ENODEV;

and net_devmem_lookup_dmabuf() is a plain xa_load() with no credential,
netns or creator comparison.

So can an unrelated unprivileged process reach another user's binding like
this?

  process A: NETDEV_CMD_BIND_TX -> gets id N, keeps the netlink socket open
  process B: sendmsg(MSG_ZEROCOPY) with SCM_DEVMEM_DMABUF carrying id N

__sock_cmsg_send() in net/core/sock.c takes the bare id:

	case SCM_DEVMEM_DMABUF:
		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
			return -EINVAL;
		sockc->dmabuf_id = *(u32 *)CMSG_DATA(cmsg);

tcp_sendmsg_locked() then calls net_devmem_get_binding(sk, sockc.dmabuf_id)
and zerocopy_fill_skb_from_devmem() builds frags from the resulting niovs at
attacker-chosen offsets. If B's route egresses the same netdev, does this
let B transmit the contents of A's dmabuf to a peer of B's choosing?

Ids are allocated cyclically starting low, and the return codes differ
(-EINVAL for an unknown or non-TX id, -ENODEV for the wrong device), so is
guessing a live id cheap? Should the TX path check the binding against its
creating netdev_nl_sock before this is documented as safe, or should the
command grow a permission flag instead?

[Severity: Medium]
Separately from the enforcement question above, is the wording here wider
than what the code does?

Two parts look overstated:

"so they can transmit from it on their own sockets" - nothing in
net_devmem_get_binding() ties a binding to the socket, task, uid, netns or
cgroup that created it; the u32 id from the global xarray is the only
credential.

"without affecting other traffic or device state" -
netdev_find_netmem_tx_dev() can resolve the bind target to a different,
shared physical NIC via an rx queue lease:

		phys_dev = lease_rxq->dev;
		if (netif_device_present(phys_dev) &&
		    phys_dev->netmem_tx == NETMEM_TX_DMA)
			return phys_dev;

and net_devmem_bind_dmabuf() then runs dma_buf_attach() and
dma_buf_map_attachment_unlocked() against that physical device's dma_dev.

Would it be more accurate to state the narrow property that bind-tx does
not reconfigure RX queues or steering, rather than claiming no effect on
other traffic or device state? The same wording is mirrored into the uAPI
spec in Documentation/netlink/specs/netdev.yaml, so it becomes the answer
future readers get when they ask why this command has no permission flag.

[Severity: Medium]
Does anything bound how many times an unprivileged caller can do this, or
account the memory it consumes?

net_devmem_bind_dmabuf() can be called repeatedly on the same dmabuf FD, and
each call allocates with plain GFP_KERNEL / kvmalloc, so none of it is
charged to the caller's memcg:

		binding->tx_vec = kvmalloc_objs(struct net_iov *,
						dmabuf->size / PAGE_SIZE);
	...
		owner->area.niovs = kvmalloc_objs(*owner->area.niovs,
						  owner->area.num_niovs);

and each call installs another mapping on the shared device:

	binding->attachment = dma_buf_attach(binding->dmabuf, dma_dev);
	...
	binding->sgt = dma_buf_map_attachment_unlocked(binding->attachment,
						       direction);

There is no duplicate-binding check, no count limit on entries added to
priv->bindings, no __GFP_ACCOUNT, and no RLIMIT_MEMLOCK accounting for the
long-lived mapping. With the rx-lease path in netdev_find_netmem_tx_dev()
these mappings land on the physical NIC shared with other users.

Given that, is "without affecting other traffic or device state" the right
thing to document, or should a per-socket or per-user cap and memcg
accounting come first?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921195545.493253-1-almasrymina%40google.com
