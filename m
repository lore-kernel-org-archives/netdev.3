Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6E94502F
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 00:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787184965; cv=none; b=b/3mVvr4Zcqg8/Vl8k15watk/8JlS34lFTX8obii0eYmyeB+WkfhrbwOforsNX2Mvex7wWZlWYo+sF22OSzQriQvM9M7n3uFkb294nhjtSQb8gCSs/qecpIPDNb0N/k6lkPYiruKyITeWebPOS9bO51EztrQi+GmzxZFCpdm2l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787184965; c=relaxed/simple;
	bh=E3uXNxxcgOKr8O+Ol4NWRlQkVgWbAHK9PUoEMPh9nH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qdG++0gm46ne63gguNL5NMM32j0NOdGdf2lRzChVaQdZ6mpZckVvlzCVdb3apD7AVxm6kCEqRx+5Bbyh1QNjMGtBkOys4iCo/z67vW3kQWz6Gzod+qaPCc/hBWaSKcwndJ3fbhi14v+j+4GFwLQCcBr8TlmgHucgrwWSscM5hQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKyZU/gN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKyZU/gN"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d01663d816so11981335ad.1
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 17:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787184963; x=1787789763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jslw2VH1wX/f/fbPJ3JCQynMI1RaFB5i5SOhQ447iqQ=;
        b=cKyZU/gNSkquZN/XuWP3YfkZb7NUecyEf/pYoPxUfrpwlSxFjXLrUvu5jZJtpACbZK
         sfkg6SNFQQmd2a59ZrGr2hhCdL3oiMinEDNqaL38X5IMezpn0WYZ25lTJtMmVwRVyHi2
         IHkx8KxPetpn+zjS96i6FVtRX8k3pK6trkI3GCMdj6Wg3gg6BQx5OFd/YTK1Csj1YgLl
         tBW/fvIP9XR7J0VK6wMcLw4nPXkI0KmMD2fOReevNRXXEQ8WWPQFkCsSz5QDU00bKL5j
         PrdKRjvdI2tEh+POXAUN2RZF3wPytgZfWI/2lKelpxdavFE2EPOcC99qo3vmLTFMKnlT
         e29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787184963; x=1787789763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jslw2VH1wX/f/fbPJ3JCQynMI1RaFB5i5SOhQ447iqQ=;
        b=bpdl3+6z9BwWEA1P8QaGhfb1xCLF3VOy2rpZU3VUaJPm6LoqK7WflAj9HvEwDTI5MF
         GLKn65zdB6Utn3spAj80YDzL6Pcl7eunLR6TTUyJrQXV+h1PXjXCUk9BAY++SCIIzIOO
         MQUeeNAi76DCZK5FRHdqMUgtrD4jt2RXvJXvRK4Z4ZwnZC+NWwfPLBUMOTkR4gNpi8gp
         eQMiZvVHXBuxmalc8qrApFSGp2ZRWRwRKFm4v8RwzhvDS1sYrEcb9gd0O1Hmm0kl3+E9
         Bv9LwBTV+k1kF3Rz+X+GjtkbQHzbJC1WsInRKFepGH5ZYF5Cvyi+d2l2KDDA2zax7gWN
         DC2Q==
X-Gm-Message-State: AFuF++kmg7dM5+vwt/Yx7Nv4vcy3Rp5u2cXPbGGobigQp+L58kPnBh4y
	+nnz0y6JhVZh4QFXjDCMoAmMb5fT7Xa9JXnuIAoIZmDKgc9kS3oGDvnM8WgaG5n6
X-Gm-Gg: AR+sD13N5fTpgIke/SdZe6BnfrCXOOo1YcM97GWWkjrsL/041oN6oXK/t1p7Tr06uXC
	tkEyLBKcPXXcZFFeZA1SYNUBdBw08ZR82vYLkGtW8jdGo5S9XEeIzBAYYNxcZGWiC6VurEaaZwp
	4eU41cXvUEaax9zO1iDnMsZ04JdCUqfM0CTSNOSnMP/ttiQ9Pk8lbHsdrBPzGpPfPlphvff7O1t
	gtri8fqLJ3aGAqzw9/Di+zlN8r22Zgf3YKeFfJG1I5sbdDNYWWojCIH2EyAZLShEafdhzfv3s/d
	1zA/SL6IlMprFQ/8OT67WGtIYZDia+286xLSF7M+M+6FWT3bQmCjcO1UASHw5ulbCnNgC125a0F
	TkpHT9iDMeNVc1yc/Pg3ABRl8FdLAXLHTVuT+X0I7txOdSqHzuOnVPCf1s4B0R6D9u9PaylegL3
	4LYQQ5lniGKcx0H593py3AedLn3UjycpDSLEfo3rDSAD12iWbbaI5YEx85kEnUMnEt5Alg3w6x
X-Received: by 2002:a17:903:1ae6:b0:2d3:78c2:1f19 with SMTP id d9443c01a7336-2d60185bde4mr163961655ad.9.1787184962718;
        Wed, 19 Aug 2026 17:16:02 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e3cf1e3sm197075ad.72.2026.08.19.17.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 17:16:02 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH net v2] vsock/virtio: validate packet source for connected sockets
Date: Thu, 20 Aug 2026 09:15:17 +0900
Message-ID: <20260820001517.2148196-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_transport_recv_pkt() looks up sockets first by the full source and
destination tuple, then by destination only in the bound table.  The
fallback is needed for listening and connecting sockets, but sockets remain
in the bound table after connect(), so it can also return a non-listening
socket.

The fallback does not validate the source address.  In TCP_SYN_SENT, a
RESPONSE from an unrelated source can transition the victim socket to
TCP_ESTABLISHED while its stored remote address remains unchanged.
Subsequent RW packets from that source are delivered through the same
destination-only fallback.

This was reproduced with capability-empty processes under different UIDs.
The attacker discovered the target tuple through unprivileged AF_VSOCK
sock_diag and caused the victim socket to read 16 attacker-chosen bytes;
the intended peer-side socket read 0 of those 16 bytes.

After lock_sock(), reject packets for non-listening sockets unless their
source port matches the stored remote port.  Require the CID to match too,
except that the loopback transport uses VMADDR_CID_LOCAL as the packet
source for connections addressed through its valid CID aliases.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Closes: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Changes in v2:
- Preserve valid loopback CID aliases by matching the source port and
  accepting VMADDR_CID_LOCAL only for the loopback transport.
- Rewrite the commit message and receive-path comment for clarity.

v1: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/

 net/vmw_vsock/virtio_transport_common.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8becad812..d8990f5f6 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1764,6 +1764,21 @@ static bool virtio_transport_valid_type(u16 type)
 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
 }
 
+static bool virtio_transport_source_matches(const struct virtio_transport *t,
+					    const struct sockaddr_vm *src,
+					    const struct sockaddr_vm *remote)
+{
+	if (src->svm_port != remote->svm_port)
+		return false;
+
+	if (src->svm_cid == remote->svm_cid)
+		return true;
+
+	/* The loopback transport represents its peer as VMADDR_CID_LOCAL. */
+	return t->transport.get_local_cid() == VMADDR_CID_LOCAL &&
+	       src->svm_cid == VMADDR_CID_LOCAL;
+}
+
 /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
  * lock.
  */
@@ -1823,10 +1838,15 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	lock_sock(sk);
 
 	/* Check if sk has been closed or assigned to another transport before
-	 * lock_sock (note: listener sockets are not assigned to any transport)
+	 * lock_sock (note: listener sockets are not assigned to any transport).
+	 * The bound-table fallback matches only the destination, so reject packets
+	 * from a peer other than the one stored in the socket.
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
-	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
+	    (sk->sk_state != TCP_LISTEN &&
+	     (vsk->transport != &t->transport ||
+	      !virtio_transport_source_matches(t, &src,
+					       &vsk->remote_addr)))) {
 		(void)virtio_transport_reset_no_sock(t, skb, net);
 		release_sock(sk);
 		sock_put(sk);

base-commit: e2466392a0b8496000e12181cb1ee1535eb0da25
-- 
2.54.0
