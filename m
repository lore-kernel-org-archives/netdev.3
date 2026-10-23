Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741919;
	b=x667uSaGG8msJk/Mz1/sdSmB0S3AIuEobW3CAC+245ciDf4hQfZDbXeXYU5GI/mAvyjj
	 KYjX2OTiM915sKoDWywo7n33zlTR/VgKqdUSCTO6nKx2yLIzdNUVhACgeiXx4a7bch7bB
	 9OFnV4+qM68XV/Fw3LmtLs4+YQm6AHtzN3Nw5ADE7XTQ+JxNSiDkS76C8rHkUEZm1XScO
	 j9Vlp4/fvhKqUM0jClVvp0b/9XXLULnOHcycWO3gVbHoGxsrrFD1ZuF5Gj02V3FGP6xV3
	 44BFl7lnrwtxRXLwyOQPo77yqwJJSJrgmFsWjgZ2LhVxcBKKI4m13ZuPrGZyU6gxiJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YqasG4hoa5HMln8cuz36jlojNM8+bH53t/aSP0CVnp8=;
	b=sKrummpy5oLlXCNN+SdlhHvvL8BSByNOMkmrJ44EK2jbUxU967nFRUm4llR3T6cOsAwR
	 tSrDMb2pLBzUEQ0NvurkZ5GGKg5qi7/uhVwluQhQrVZ1r4THLOGoWvz1sBvNDVoG51Ri/
	 3m2AQJ7ogjQwg26D8EZnJxP2EvZ96QxC6adUA3rFEJjSceWXORSaY/qcnZv0LrDx+jt2x
	 iQkpJ0gpaKzB7zLluhml1dOe+f6LHi5vGc8e5dP9eKH3DRnfg9cLqyryWy0G/RkE3IqHx
	 XwB/l9S7OCa9jS9RZ9b5GfYRvAtOVhK/lROMNqlWwL5VPLKTb38EQNylX7nITQ1v3VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RACWuQxq;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A91606A31F
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15A91606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RACWuQxq
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ea7190aea1so2520575ad.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 00:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792741918; x=1793346718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YqasG4hoa5HMln8cuz36jlojNM8+bH53t/aSP0CVnp8=;
        b=RACWuQxqcNvxZdCaZkfaqIrUNiPiYMBz5+g6sqBaI+yYIWvMYlPkMnUBWaiKQID20f
         bh2Cf3hmYtKlRrrkw7TbIPZRI+BPP2zGFWKj57/PIlqsbw9+8Haf1V5bs5dDRM96eNJc
         oQ7+LK+uvdX85peHEnZ5eltX6FH8J7DGBj+3uPXtWNSXuhwKtd9VIsIbAVlppPnkIJ3n
         lgUYHZJsb6OxDwAXLpzlISBSrzFyrRUa2GPhpiP1Vpce6lVuo69sPz3NKWKb0s51L+gi
         M7UPzlUqfiH0Y8WvsePP3dfmCqRC8Jv+OqfolzDJri0D3izC3LaPXwXNovw6Hp+QOwi5
         vRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741918; x=1793346718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YqasG4hoa5HMln8cuz36jlojNM8+bH53t/aSP0CVnp8=;
        b=UPUUVa6jDZS19eW4Lfa1jISxGWNrLHl7NwnKsBCQ3Ljpo2szQC49rJMWam6t65kgqn
         KwNctJwC94DSmvxiY5W2IRY0993XFNevQK52Ltbv82WSjfnRMDM62x5HnOrrqzztA6jW
         RntSKJupd5PMQnJ1dtEaSvTEpEyprkFp9wWt3FtHfZySBgPDgtbaWE8J8mcZSHy6NEbs
         vd6mNV1J2QsdnoGRGeTdEKQtlf0gZgI0MQgMpDg6AMEEl7dgwLp+rzs6+4P4M9srpXB1
         iOcDPcK52mmpu84ygMItI6oOsmINT1f1AEuqbhlp5fd9u4Ra8TCrvb+3miK9kyAHv+yg
         A+EA==
X-Gm-Message-State: AFq9FYLWmTOVjmtdoeBokmOGa6ACfIdgxQ9idTA2ZeROq4a5a7a0Wh0m
	Jj1+RR5eDnQef1v/UMGC/Bc6VYzH9bItPrbixG/M1rEH7PUmHtrVK16w9WAxn9ESwPo=
X-Gm-Gg: AYBFou2kVCR9P6rGusLJmlLyWRYGaFhrkWDrZSGr5dESZOzT50lf5f4W3Caa+mZmRd2
	ozhQYim7CkQeqCxerTs+UsNq/5fwCvv6mmVJJ/3E6IRw+xb4hyeTd7Ix+CoMoZPbxR/VVkql1Zf
	aS82StGm3EOrL04GUkFynzyPf3GwB/PAn073VBWxJHxz/SJPp9+MUT1xoM3X8cnJM3ZsvV+SwN8
	vgOG6j/LfjE1XoCTZR1voLSB+aeifvI2kEJE24yOenuDEeeuXFaxD79P2IdROjDLQ1wYbcsQN/H
	W5aK96YNuFeqe8Ynnqw5LQU0c/4dr/ONiko3yGoRMz3TnEdJl6Abh57i+DkoEgBoAThH2dpnh/H
	EWsY4KfNPdiloQJx0lKNadFtuD1q1Gc1kPpFUOOUbafmTS0VjgCzkFp/qlfqqDaQqFBRIfMAUOq
	z/zbz6SFg3I/d3c+T/Fy2wYLEI7BFrAf2Q4C23PDw0IlvU2HebZvTC5ws0a9HieClq0xI0dk4QX
	71tgAO4nr3OKmZ2kR7ubpfTkcAFiLNvEAtsQyC+YZk03s91E0UIbbeJC0C6I/JuzBk8vGh7d4Tx
	LqE=
X-Received: by 2002:a17:903:26c7:b0:2e9:6be2:1296 with SMTP id d9443c01a7336-2ea7c330b3bmr15087225ad.56.1792741918158;
        Fri, 23 Oct 2026 00:51:58 -0700 (PDT)
Received: from gmail.com ([185.220.236.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b368c90sm7208265ad.29.2026.10.23.00.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:51:57 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: netdev@vger.kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	bobbyeshleman@meta.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 2/5] vsock/virtio: factor RX skb metadata budget check
Date: Fri, 23 Oct 2026 15:51:37 +0800
Message-Id: <20261023075140.9613-3-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023075140.9613-1-physicalmtea@gmail.com>
References: <20261023075140.9613-1-physicalmtea@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the skb metadata budget check from virtio_transport_inc_rx_pkt()
into virtio_transport_rx_buf_full().

The helper retains the existing condition and will be reused by a
following RX batching change.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 43325d7aebbb1..2a9cfed085515 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -576,11 +576,17 @@ virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
 	skb_queue_splice(&new_queue, &vvs->rx_queue);
 }
 
-static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
-					u32 len)
+static bool
+virtio_transport_rx_buf_full(struct virtio_vsock_sock *vvs)
 {
 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
+	return skb_overhead > vvs->buf_alloc;
+}
+
+static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
+					u32 len)
+{
 	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
 	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
 	 * metadata. Check payload against buf_alloc to be sure the other
@@ -588,7 +594,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 	 * queue growth.
 	 */
 	if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
-	    skb_overhead > vvs->buf_alloc)
+	    virtio_transport_rx_buf_full(vvs))
 		return false;
 
 	vvs->rx_bytes += len;
-- 
2.53.0

