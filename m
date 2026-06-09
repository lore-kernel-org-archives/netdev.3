Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0859A348C77
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016302; cv=none; b=l1ioCM2Wz0tU6tsik3XxI0UO3ZzLUczgD6j9qC49hpXJ3h28F5hCL2Itlas0X3Un3hS/6N7mRy8n1CZBOZfA7sPg6Nj3b2pNTgKloTDmQLDeZu4MIsJ2dPmJ5k4ZW+sVZG70/Myl/ggWatH34qPYSAkCiHdkftkTuMMjCHll8V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016302; c=relaxed/simple;
	bh=I+MG6j6+kplApxXEDI0QzwwsnO+1FJglAwz2d2/D274=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=km5LK2OM439I7w6GMw09yfUVxMvrOQY4x0eg+Z17IGxfMcoNLJRUWHGsISaHq/EyzLgT2Bra/E9AwwU1QT5SopGJE6T5ocQv6Ht612EvvZCfNuUA+Vixs63fXDaiv9MtCVF7kDxNy7ZK05ACY1gi1nsm0R33JEfiMFNLp6PnEdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EM9FvEZn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EM9FvEZn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781016300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7uzm9MlJqtx/K+dgYJZWwnUeSqqolzoT5g/R7O33N54=;
	b=EM9FvEZnX7DOWosFsQHaPz/h6yWsva/0Uy8AqOCUMCHkaVjvn7MOJzA0Y5tElqdZIzvXkJ
	yBpXX3bpEFMSFO7MvjG//JpVd4uzXNDky+j9qP0xn0BLa6O2cisg1yc+tTDYi91L2b47Eb
	HnDY18YXEIjpgewPO5ZmV2AkFMOcJoA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-ae7hAeFjM1OUJsnSXBe_xQ-1; Tue,
 09 Jun 2026 10:44:56 -0400
X-MC-Unique: ae7hAeFjM1OUJsnSXBe_xQ-1
X-Mimecast-MFC-AGG-ID: ae7hAeFjM1OUJsnSXBe_xQ_1781016295
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF8A91831357;
	Tue,  9 Jun 2026 14:44:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.0])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B486436535;
	Tue,  9 Jun 2026 14:44:50 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux.dev,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net] virtio_net: do not allow tunnel csum offload for non GSO packets
Date: Tue,  9 Jun 2026 16:44:26 +0200
Message-ID: <38d33d63ce5d1aee486bd6c7c47345040d526e35.1781016169.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Fiona reports broken connectivity for virtio net setup using UDP tunnel
inside the guest and NIC with not UDP tunnel TSO support in the host.

Currently the virtio_net driver exposes csum offload for UDP-tunneled,
TCP non GSO packets. Such packet reach the host as CSUM_PARTIAL ones
with the 'encapsulation' flag cleared, as the virtio specification do
not support this specific kind of offload.

HW NICs with UDP tunnel TSO support - and those drivers directly
accessing skb->csum_start/csum_offset - are still capable of computing
the needed csum correctly, but otherwise the packets reach the wire with
bad csum on both the inner and outer transport header.

Address the issue explicitly disabling csum offload for UDP tunneled,
non GSO packets via the ndo_features_check op.

Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
Reported-by: Fiona Ebner <f.ebner@proxmox.com>
Closes: https://bugzilla.proxmox.com/show_bug.cgi?id=7627
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/virtio_net.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..07b8710639f9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6222,6 +6222,18 @@ static void virtnet_free_irq_moder(struct virtnet_info *vi)
 	rtnl_unlock();
 }
 
+static netdev_features_t virtnet_features_check(struct sk_buff *skb,
+						struct net_device *dev,
+						netdev_features_t features)
+{
+	/* Inner csum offload is only available for GSO packets. */
+	if (skb->encapsulation && !skb_is_gso(skb))
+		return features & ~NETIF_F_CSUM_MASK;
+
+	/* Passthru. */
+	return features;
+}
+
 static const struct net_device_ops virtnet_netdev = {
 	.ndo_open            = virtnet_open,
 	.ndo_stop   	     = virtnet_close,
@@ -6235,7 +6247,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_bpf		= virtnet_xdp,
 	.ndo_xdp_xmit		= virtnet_xdp_xmit,
 	.ndo_xsk_wakeup         = virtnet_xsk_wakeup,
-	.ndo_features_check	= passthru_features_check,
+	.ndo_features_check	= virtnet_features_check,
 	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 	.ndo_set_features	= virtnet_set_features,
 	.ndo_tx_timeout		= virtnet_tx_timeout,
-- 
2.54.0

