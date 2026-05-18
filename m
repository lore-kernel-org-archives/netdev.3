Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32393E5573
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095229; cv=none; b=G5QouNe0o9WMqu5LQ75dQxePu8sG2qIevA1YsxSnkGcuW+ndakv4HtMa53JQz336NyF19iZhMYm1k5QkjvSTuq7r2XqbHdRI3+ubbZIcSOQuMnf0RWZuaBdjI/flFY4kMnEdxtVe+XJkTz+QTcrpcERHR7uWl2/iRCHx41vUMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095229; c=relaxed/simple;
	bh=uQ6Wln7pJey/LF1d0dz2kzM3P6XyAQup1rTFP8pIs04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQ00xqup/tOc+N3CgLUkFeG7Fz9xvuUha4MPaDGDnMK3MnTsYwKPbgJWMQmu8bz+27jV+g0g3nVPXLYm6x6YTFbF6kxfkZ3EgJvtkubfHCXD+f7AgfbxXGygTTqzUAuBfvzQEoiamNtNoZuwMHE7byPQ2UUlkFlQXLn6m4NY2rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VO8tJG6S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6888Ohs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VO8tJG6S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6888Ohs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779095227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=200SzWxPjUpvXvgPwqt07Qg/dRT4TNSJWBHGA2MWMbU=;
	b=VO8tJG6SZAN85Fv2pDSxlTG8UL72wUsZ8VsqDIxgY8MajWoH+1r/lCQy787fX8H+Jl7uRa
	B4TxLdvqQTgoImVkR5uNsUKex9nuoJ9dy/0lJgvpSe7j4IshDNm/3yE6Ns1LfoOkDlaj7n
	mWAh57A5w5yx96NBkFQGOBKG2jI5Zm4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-qWCdJKIlObGsZ_UErPgdvA-1; Mon, 18 May 2026 05:07:05 -0400
X-MC-Unique: qWCdJKIlObGsZ_UErPgdvA-1
X-Mimecast-MFC-AGG-ID: qWCdJKIlObGsZ_UErPgdvA_1779095224
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48d1bc85bb3so5546485e9.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 02:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779095224; x=1779700024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=200SzWxPjUpvXvgPwqt07Qg/dRT4TNSJWBHGA2MWMbU=;
        b=S6888OhsGUJrpUapZHoe8wg1D12MJ6Z1NYXzeXUUO8b0icS0Ieaf0khOTB42Ka6b64
         rGzI5WyAHJusNVZMEDEv1Y1l68BFh5EgxaqFuAzM9w7W8rFk5p1qwoXk5tyTCnBF3Wtw
         Q9TU2ROluUhopKxci8X0cXmGif/+zMxqbWhHj+UgxjacCFQwr6iY8G7KrcVFr7mCGQmP
         8cQqJvHMIEJxRN4JvZGZJIexyN9EbAF06C25NeRXa8++U08ipne/syIdg4VKuwfT2Kok
         B9qTVlXtqfxEq7qZvLRegwM9llVh7KQ759O/eIoMvuFWTySy+CfcBx/yRA0WNhQXZyRD
         Zp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095224; x=1779700024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=200SzWxPjUpvXvgPwqt07Qg/dRT4TNSJWBHGA2MWMbU=;
        b=hJzn/s2AlLAXJwsO1Ux6mDL5vuMuoKT6jTUZv5drKqfhJuZS9ohunZtyVlwypH9eYu
         ki+eGxEtRq7y0h8j5ME6F1bVhu/HI6R3t6V+nu8kxaKWFqH5ziTclcqdb2E+oxwgftgt
         BCFLvrj7OBkCVSopR8u+Sh8Q/VQrr4L9bGOVLfwlH5SaGPRIC2znaRB02fxFH8CPRXvy
         vlXdN7OaCrpIF7+rHd62VGxLUEzG2iIFo9RFw22qrTEuucVRJuieT4600wuGzJ1htkft
         T2zyGrDqeN3yIflV5RsVSSwoZX94QJ0CWo/3JtwwLjZmT4ilhLBGafXALaHMswBaA8jC
         bniA==
X-Gm-Message-State: AOJu0YwKpEHBh7baK6Vno1uAfoyE1tIN9pux6HT7pXOjRi/NYvTznIqa
	5f8J8FpjgpZOAwp2qktoXJlu9GECX2fGqXqklAWtrBjz2QGWK6ITNghjSJQ/LYU6L2BK/RVJgG3
	2R0Hmbe16PvFYVimBWWA4S0xdaCkCKdRTthEJC+g3pFk7G0HxBg+cIno4ouuSg+P4+wdsZ+1SPo
	HJqIg+uQtaVdyIGfzSmJr+XyK99q9eaxKzYtbvB4Rvqg==
X-Gm-Gg: Acq92OHoX4KU/Xb185BsVipV+Z1aWI9+JC9A5HDjWXnG0fc0BpHSKAhr5f5dfwSpsLw
	O6qEf4PK5h1umVScANny+TFvAabKZ7S3FFhfH1w81C+vd0QZQLkkIVM2knSKkColymO702rPePu
	7Ruo4D1Nh63cglJc8a9Czx+Oty69k8w2SBoVBR0UBUyYKo7dsPttzGvnn8PVFM0Gih331wJGBXD
	03/JyV4y6oc1GwLGGFa9A8Fjk4K8OgIlB/lO/2gMB7ia4DL0g280Ngtkj3LXv+lHY9m4DxaJYj/
	ewg2J0EbveWjoMlUNsNkRa36wNElubiNeDFelK95UJyuvlBN+QIMDQTSt63GfhERhNCfTzc2C1X
	z4kxIa6rz4VQtkVRNIcYTWUESahtrMuk13yibXhxnUv5xYxTJIyOgj+bCSuzu
X-Received: by 2002:a05:600c:1515:b0:48f:fe2a:107a with SMTP id 5b1f17b1804b1-48ffe2a10b7mr66193455e9.3.1779095223735;
        Mon, 18 May 2026 02:07:03 -0700 (PDT)
X-Received: by 2002:a05:600c:1515:b0:48f:fe2a:107a with SMTP id 5b1f17b1804b1-48ffe2a10b7mr66192625e9.3.1779095223029;
        Mon, 18 May 2026 02:07:03 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe6b60csm105880345e9.6.2026.05.18.02.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:07:02 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 1/2] vsock/virtio: reset connection on receiving queue overflow
Date: Mon, 18 May 2026 11:06:55 +0200
Message-ID: <20260518090656.134588-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518090656.134588-1-sgarzare@redhat.com>
References: <20260518090656.134588-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

When there is no more space to queue an incoming packet, the packet is
silently dropped. This causes data loss without any notification to
either peer, since there is no retransmission.

Under normal circumstances, this should never happen. However, it could
happen if the other peer doesn't respect the credit, or if the skb
overhead, which we recently began to take into account with commit
059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
is too high.

Fix this by resetting the connection and setting the local socket error
to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
packet, so both peers are explicitly notified of the failure rather than
silently losing data.

Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1e3409d28164..5028ff534888 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1335,7 +1335,7 @@ virtio_transport_recv_connecting(struct sock *sk,
 	return err;
 }
 
-static void
+static bool
 virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 			      struct sk_buff *skb)
 {
@@ -1350,10 +1350,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_lock_bh(&vvs->rx_lock);
 
 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
-	if (!can_enqueue) {
-		free_pkt = true;
+	if (!can_enqueue)
 		goto out;
-	}
 
 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
 		vvs->msg_count++;
@@ -1393,6 +1391,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_unlock_bh(&vvs->rx_lock);
 	if (free_pkt)
 		kfree_skb(skb);
+
+	return can_enqueue;
 }
 
 static int
@@ -1405,7 +1405,17 @@ virtio_transport_recv_connected(struct sock *sk,
 
 	switch (le16_to_cpu(hdr->op)) {
 	case VIRTIO_VSOCK_OP_RW:
-		virtio_transport_recv_enqueue(vsk, skb);
+		if (!virtio_transport_recv_enqueue(vsk, skb)) {
+			/* There is no more space to queue the packet, so let's
+			 * close the connection; otherwise, we'll lose data.
+			 */
+			(void)virtio_transport_reset(vsk, skb);
+			virtio_transport_do_close(vsk, true);
+			sk->sk_err = ENOBUFS;
+			sk_error_report(sk);
+			vsock_remove_sock(vsk);
+			break;
+		}
 		vsock_data_ready(sk);
 		return err;
 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
-- 
2.54.0

