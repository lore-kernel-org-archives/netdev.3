Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F2370AC7;
	Thu, 10 Sep 2026 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051031; cv=none; b=VbdTBFn0LRlQnhSNwCgL/p0YodnTShkEZNs1QgBD8rtkRgUCbL6rP6AN7h2CCxwr+wwkfaTmt2LaHeF+SKl4PANizCBc4LfZkWJfH15e50t1F7tELjiV/qy3A3cwHRYPAQPD6PjQKhTRtu8nr9XelN4OzTF7yatTkHs9lcgslCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051031; c=relaxed/simple;
	bh=EypdHwRtm0sBpacY8hG4eXzqWQ1CbCxuTO8xmfryXiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSHNTKsQR91iI+OTVCmDyAZJ/xGHYQHZA5H9qLOEimSbH3neh9qfNnnQh5XksDFZQfFKmICctozsOhRbeu15XnOC4dLx9q+dh/sRz7SPswIK/F5aEZOdZtZm5M0aHwgu+fl+9+4XHIRQs6QWGkW48QFkUZHpsfB3XvWWN3WhzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=f3lix.dev@gmx.de header.b=LP17A8iW; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=f3lix.dev@gmx.de header.b="LP17A8iW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789051022; x=1789655822; i=f3lix.dev@gmx.de;
	bh=dbN+myIZeYzJ0MfMkjmxQTt29oibZ7TyvoKWBCqN4Ik=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LP17A8iWPeEx0Uj2DJ0jbF5cWcZPyGHar1cILXDPd8DW+ZJKgWaYKfBcw32glrmk
	 uZIQGbUcCOJxopPjpPomInT5LdxfJaey4XtiCSYHm9Xa+gKLqxq3nfLcyBvDnXjQ5
	 le69nBJJQAxuTAKKCGEMH2tkkrm16uSc/tCBwjcnxxis0Izh3glWARry8Ru890gBc
	 4Gv3DCDXDryP3GL0SBe10wh98QHxEXViqQEAVgif5QEm0hei8KRwe1OTouMu81DoA
	 t2yt6iKzgkV6feKTiAe5ZYpfbTQx8PyX/zXkxy9ow80sTMBsxegS7JOa826BTRQZT
	 W+vvhien9AZcCg2/pQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwfWa-1wswlw0jD0-00zXne; Thu, 10
 Sep 2026 16:37:02 +0200
From: Felix Hoffmann <f3lix.dev@gmx.de>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: devmem: fix TX binding UAF on netdevice unregister
Date: Thu, 10 Sep 2026 16:36:52 +0200
Message-ID: <20260910143652.166683-1-f3lix.dev@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GjHGMeHjxvl6130qkNEfdrhOyVB1z1sQ3E5/nUKGP0/1ZPEx9RF
 h8xgSaaCaGeAOyUcUn3v2CHBC72P52rRPlaxdKZ9gNkRfb6YJxTEC3YhfkGoM6KLRYwh2Y1
 FahPLGgd35x8Kh3Y/AFC9yQxdOwaaWIFrYlLCrytRp0hkaLNf0EL1VEkKuBP/5wiqilRUgz
 OUFAwKhQ/pLrCuVQUv08A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GtKBP49dBtw=;4j+nPeHC5/R1eWe5fUUGVMcKdge
 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
 0bk7bXR0hZw7PqiFHfY53lCXwz9quW0whNg==

RX dma-buf bindings are invalidated by their memory provider when a
netdevice is unregistered. TX bindings have no bound RX queues and no
equivalent uninstall callback, so their physical and virtual netdevice
pointers remain live after the devices are freed.

Closing the owning netlink socket after device removal then makes
netdev_nl_sock_priv_destroy() dereference the freed physical netdevice to
hold and lock it. KASAN reports a slab-use-after-free and the kernel can
panic.

The binding can also outlive the device used for its dma-buf attachment.
Since dma_buf_attach() does not hold a reference to that device, deferred
binding cleanup can pass a freed device to dma_buf_unmap_attachment().

Invalidate TX bindings that refer to either the physical or virtual
netdevice during unregister. Keep a reference on the exact DMA device
until the attachment is unmapped. The netlink socket destructor then uses
the existing device-gone path, while delayed dma-buf cleanup retains a
valid DMA device.

NETDEV_CMD_BIND_TX does not require GENL_ADMIN_PERM. The failure was
reproduced with the binding owned by UID 65534 across module removal.

Fixes: bd61848900bf ("net: devmem: Implement TX path")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Felix Hoffmann <f3lix.dev@gmx.de>
=2D--
The reproducer is available privately on request.

Testing:
- Full x86-64 kernel build with generic KASAN enabled
- Unpatched kernel: UID 65534 bind, netdevice removal, and socket close
  produced the reported KASAN use-after-free and panic
- Patched kernel: the identical sequence completed without a KASAN report
- Patched kernel: 10 additional bind, removal, and close iterations passed

 net/core/dev.c    |  2 ++
 net/core/devmem.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 net/core/devmem.h |  7 +++++++
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ecfbd72d5d1a..c325fa7e0d6f 100644
=2D-- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12401,6 +12401,8 @@ static void dev_memory_provider_uninstall(struct n=
et_device *dev)
=20
 		__netif_mp_uninstall_rxq(rxq, &rxq->mp_params);
 	}
+
+	net_devmem_uninstall_tx_bindings(dev);
 }
=20
 /* devices must be UP and netdev_lock()'d */
diff --git a/net/core/devmem.c b/net/core/devmem.c
index f4d60654ce7f..a21a8fe92f58 100644
=2D-- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -77,6 +77,7 @@ void __net_devmem_dmabuf_binding_free(struct work_struct=
 *wq)
 	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
 					  binding->direction);
 	dma_buf_detach(binding->dmabuf, binding->attachment);
+	put_device(binding->dma_dev);
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
 	percpu_ref_exit(&binding->ref);
@@ -153,6 +154,46 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabu=
f_binding *binding)
 	percpu_ref_kill(&binding->ref);
 }
=20
+void net_devmem_uninstall_tx_bindings(struct net_device *dev)
+{
+	struct net_devmem_dmabuf_binding *binding;
+	struct net_devmem_dmabuf_binding *found;
+	unsigned long xa_idx;
+
+	/* Unlike RX bindings, TX bindings have no memory provider whose
+	 * uninstall callback can invalidate their net_device pointers.
+	 */
+again:
+	found =3D NULL;
+	rcu_read_lock();
+	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
+		if (binding->direction !=3D DMA_TO_DEVICE ||
+		    (READ_ONCE(binding->dev) !=3D dev &&
+		     READ_ONCE(binding->vdev) !=3D dev))
+			continue;
+
+		if (!net_devmem_dmabuf_binding_get(binding))
+			continue;
+		found =3D binding;
+		break;
+	}
+	rcu_read_unlock();
+
+	if (!found)
+		return;
+
+	binding =3D found;
+	mutex_lock(&binding->lock);
+	if (binding->direction =3D=3D DMA_TO_DEVICE &&
+	    (binding->dev =3D=3D dev || binding->vdev =3D=3D dev)) {
+		WRITE_ONCE(binding->dev, NULL);
+		WRITE_ONCE(binding->vdev, NULL);
+	}
+	mutex_unlock(&binding->lock);
+	net_devmem_dmabuf_binding_put(binding);
+	goto again;
+}
+
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding,
 				    struct netlink_ext_ack *extack)
@@ -233,12 +274,13 @@ net_devmem_bind_dmabuf(struct net_device *dev, void =
*vdev,
=20
 	binding->dmabuf =3D dmabuf;
 	binding->direction =3D direction;
+	binding->dma_dev =3D get_device(dma_dev);
=20
 	binding->attachment =3D dma_buf_attach(binding->dmabuf, dma_dev);
 	if (IS_ERR(binding->attachment)) {
 		err =3D PTR_ERR(binding->attachment);
 		NL_SET_ERR_MSG(extack, "Failed to bind dmabuf to device");
-		goto err_exit_ref;
+		goto err_put_dma_dev;
 	}
=20
 	binding->sgt =3D dma_buf_map_attachment_unlocked(binding->attachment,
@@ -347,7 +389,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *v=
dev,
 					  direction);
 err_detach:
 	dma_buf_detach(dmabuf, binding->attachment);
-err_exit_ref:
+err_put_dma_dev:
+	put_device(binding->dma_dev);
 	percpu_ref_exit(&binding->ref);
 err_free_binding:
 	kfree(binding);
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 4a293a7d1149..a40f0a7c221f 100644
=2D-- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -19,6 +19,8 @@ struct net_devmem_dmabuf_binding {
 	struct dma_buf *dmabuf;
 	struct dma_buf_attachment *attachment;
 	struct sg_table *sgt;
+	/* Device used to map the dma-buf. Held until the mapping is removed. */
+	struct device *dma_dev;
 	/* Physical NIC that does the actual DMA for this binding. */
 	struct net_device *dev;
 	/* Opaque cookie identifying the virtual device (e.g. netkit) the user
@@ -100,6 +102,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *v=
dev,
 		       struct netlink_ext_ack *extack);
 struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
+void net_devmem_uninstall_tx_bindings(struct net_device *dev);
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding,
 				    struct netlink_ext_ack *extack);
@@ -196,6 +199,10 @@ net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_bin=
ding *binding)
 {
 }
=20
+static inline void net_devmem_uninstall_tx_bindings(struct net_device *de=
v)
+{
+}
+
 static inline int
 net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				struct net_devmem_dmabuf_binding *binding,
=2D-=20
2.43.0
