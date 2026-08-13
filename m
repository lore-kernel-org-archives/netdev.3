Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C259147141E
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623174; cv=none; b=pCRKAMZ810oMlW322DN8TSF9rtb+zQtVzh0bLMEWka2qdaJ4ljAxZRnd4U640zdO4n7Mxgj5Dzd6FqcFa4rjjJzxODltWWw+1WChp6Dxdayucwbu6PT5k5vjK1IiSXsw1kGPD4HLnP2qvnfF+S5PYZj9y4pIRgNrs8UU4bLDer8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623174; c=relaxed/simple;
	bh=/17flycYSc19MMlgQ2UNX8D5txCWeH/AzDfCPa7n4L8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJsqxuttBQhK9VXS1BGMm1SfUZz0+lti1ABjHcIhmSwbVf7xaUeU1nUEPcdncvDn42vhMwpdN3HQBaU5jrcZCSDm3abrUFl5RlLtWBOBLauIgDDYW57sU6iBk66BLx/JpzalpEji/jIHVnUt2NH/QuK+JHc9JktJ8wfgbjZf3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFIUTMOR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFIUTMOR"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc97653887so9173685ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 05:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786623172; x=1787227972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P7D5ColudFir3efNk2jSAtS6dOixRUPB2JAx0kV9F6Y=;
        b=oFIUTMORwgOEieNGXp2MtRKZf1gdtvqY6OpjO5d/YUXOirjCGApqU+liN7/7UCL8yY
         xQ02uHRCFTif20wkEjf8/I47eR9e0km8xgR37h+wd144r0Z3h2O2GDXdTnh+QrFbXvZ+
         xTD7fA6O/Pc0AqkjYuSNa6xEySdjzDDNDa7qP5DgOgGvS+dBlrdgcWBHGgfVkk+ZuMuy
         KXQ68IKI7TV36Tpt+FSNfPGWtrb+ZvdC15u91Ga27otBvW16eChB8fE2P3NsF3F9t8qf
         XYNDat4wJ/Imi9DiWPx/DN0OcdbVjXORttG9AGZEzqQMMu/HqgTrXRpGkNVVmHW+GuBO
         5XdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786623172; x=1787227972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P7D5ColudFir3efNk2jSAtS6dOixRUPB2JAx0kV9F6Y=;
        b=jehp1t0reO0WQD7VvRllX9u+U/JAJqmDFFR5mlTLueKhWQOM1510uRc/QXCGA+cdQG
         +i9hiMm56l9EyOoYh1SGyp3r4FUPeGJOuIk4+8uGw1hy8f1XUpT8w/OqhNWPAAwSUBYp
         nLPDiZ5hC72RABo3H6vUbCSoLPc0F2oEP7o/axR/2U961r9ZhM3+C7uPiZTVWYvPQfTS
         5lGGmAx0BUy0tVlpga+lOkCrtMxGka7kZGclmblVN0HWg8panYDMJPt+6oFRPP7kh2vJ
         Chx5G27XrcXKex5z/rLG16Co+HWc7Mud54H9VI8zWtl+V6Qc9mAkoCfmt7rUB8q8tJ2O
         xCow==
X-Gm-Message-State: AOJu0Yz9NHiXHhlD4epuHZu6Dc2pJUvcdzKJXG395fqies0nvpQu8CkJ
	CGGTWDBsJxWEVEZ8YKucSmK4UaKsHB5Of2CjK6d/amFbrvoY71rorJSy98lDta1U
X-Gm-Gg: AR+sD13ISiobtHtaIRxYweF17aTzjVD9If2lY7PEYEMNUn5n1fSyx3ZPQJUTTURIt9D
	8b7fvv0zDbnHX7eF7IeCCvU/f0FOfIyLRfa9OfT0/gG3F62nhLQqcJ1KhTiueAvtcV2c9jnHHin
	lltdzBmsIWqRd0w2uxIq1GxtBAF8mrbIQ1qIm36IbKl52DxTFKKVJTdJzb1XjnBsuGIYhZUKWiG
	Y0MPftzY8R/vF6bvDW7CvLZQ1txVoGTSI7BW5q8CidmE9FYRatBXQIyEghzDmOtJ4kawHiZe6el
	K+rV9PD0e3BVqc9rRkDxGQvocYIM89KAGVD3Sj2HjgvwBVCx5t1jTNkzbYNU8VzENWj1Oht0ptK
	1DM7fnnzmvSN3qrKOsst95T+GphIWmaTG4htEbzUcf2BdGV3prt7Q/VpEFBm92lO9Xx/jD0TLo9
	MDahaIA3utoHySacn3ZTc2pGprchvjUAoCB3V+Tv3lIKQ6xuD4a9QgcJe30fVcJAW2Meq79dc4
X-Received: by 2002:a17:90b:53cb:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-3931e0241cemr6853696a91.3.1786623171943;
        Thu, 13 Aug 2026 05:12:51 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931d872ec5sm1069999a91.0.2026.08.13.05.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 05:12:51 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net] vsock/virtio: validate packet source for connected sockets
Date: Thu, 13 Aug 2026 21:12:36 +0900
Message-ID: <20260813121236.2328599-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_transport_recv_pkt() first looks up a socket using the full source
and destination tuple.  If that misses, it falls back to a bound-socket
lookup using only the destination address.  The fallback is needed for
listening and connecting sockets, but it can also select an established
socket that remains in the bound table.

As a result, a packet from an unrelated source can be dispatched to a
non-listening socket.  In TCP_SYN_SENT, a source-blind RESPONSE marks the
selected socket established while retaining its original remote address.
Subsequent RW packets can likewise be delivered through the
destination-only fallback.

This was reproduced with two capless processes under different UIDs.  The
attacker discovered the victim tuple through unprivileged AF_VSOCK
sock_diag and injected a chosen 16-byte payload into the victim established
loopback socket.  The legitimate peer received none of those bytes.

After taking the socket lock, verify that packets for non-listening sockets
come from the peer stored in remote_addr.  Listening sockets continue to
accept packets from any source.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8becad812..f73e0406a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1822,11 +1822,15 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	lock_sock(sk);
 
-	/* Check if sk has been closed or assigned to another transport before
-	 * lock_sock (note: listener sockets are not assigned to any transport)
+	/* Check if sk has been closed, assigned to another transport, or if the
+	 * packet is from a different peer than the one connected to sk.  These
+	 * properties could have changed before lock_sock.  Listener sockets are
+	 * not assigned to any transport and accept packets from any peer.
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
-	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
+	    (sk->sk_state != TCP_LISTEN &&
+	     (vsk->transport != &t->transport ||
+	      !vsock_addr_equals_addr(&src, &vsk->remote_addr)))) {
 		(void)virtio_transport_reset_no_sock(t, skb, net);
 		release_sock(sk);
 		sock_put(sk);

base-commit: 9006c116dd111d457bf5d074990210f70a4ad2c8
-- 
2.54.0

