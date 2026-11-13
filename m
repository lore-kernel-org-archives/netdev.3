Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574192;
	b=SvKDxllHiHJo1UGj5dS6dWhgx82DN6K6KeQ4lUnky99yayZFGwUQwyUxe3MQCPjSFvqc
	 Ya8cZsffO7st42czabzJVR07e0XfunvkQxWvwlvFvbfHiwzwjx9ZBEblEd4v6Hn6mrjFq
	 867SIyFcCHrcyzfQ0GI2jrzbTONgEyGN0gMgQeJQ6bb6osMc2Ta6tST7BTbUUbojuIaUg
	 cGFitBOtMAzResJ7v1z4SIxsqW8q0nPXziXGvVLXCs8LPhyp+joGQDTPrEC287U0mxeBW
	 CszssfB2jXHJNBFfhGKrpVh4a3tsrVxXBDRJ0X022aHTJmyrvKYuh3MLUCoyJg4zpMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574192;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
	b=qBQmmK/FNIvPmfbmvBURtNL5uQzjM0iyC0V36+Ev9X4MOh+aUaym6YB0wIt5YK9+teir
	 BZByPQkjPJz9fu+1Ah5hIIKn2DG43dKnGIEPTRFaPJtYhaTaSlFGJHWFaScauNhJHa2kz
	 9uI6IxZxzMhrserpGgVl4ONYjMtXLsqlDUUCk5v2qRiPgkoCfKq6eCeHHUla9YQsiakom
	 sr/ckLwFCOxZOiLu8D+n8klSfMN5sJjtr3DTUPQ7BLR5K77qeA4WE5twnldo31Vv/Zh9z
	 ZbQ0Q9uooBdmBjaEFp9zVU9vO1jFB0m53uTA7/lIR6SgBoe6xKoHWzZ8UM5tbsMGiAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ufs+XkD1;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lmTsmUr3;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB1606A8B4
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ADB1606A8B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ufs+XkD1;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lmTsmUr3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794574190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
	b=Ufs+XkD1JsW2snGybwJeCFbsxdmrSizDVvAn0b9KAshLaUTqOiF8RacB3wwj76Kw1QQVTC
	L8ut/9FxvLxEW7pSEPtX3rb+ugWNBk0euZPn95KWbgYD9KTqbkrpp5dmeq14akbXy7nRZk
	7G91PsAUrCYd+zYfvSNSjljLniyMuME=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-U-9F1Z4JOO2FAbTsrzONSw-1; Fri, 13 Nov 2026 07:49:49 -0500
X-MC-Unique: U-9F1Z4JOO2FAbTsrzONSw-1
X-Mimecast-MFC-AGG-ID: U-9F1Z4JOO2FAbTsrzONSw_1794574188
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e29c25101so323701f8f.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 04:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794574188; x=1795178988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
        b=lmTsmUr3CCPY75iJ/bcghJ5i9XXJsqlO9ikUH0BUjTeqBp1MbCyxBaIfUDSNbWNIna
         j+7t/GS9RuBn4uFewVk+dEknt1pBOkRZxl/v28QWBAAiY0Xd1cF4KVNlT5xVIf10TWFV
         SOcZdNl2mBNSkoehYBZP/342U3NPGThuEVv/YwpYtxh3dqc22VDmGSP8mo60TIZlmsQO
         WI3N4Kh0GX5rA49Z0NH2y5EbppiPW6ueOAFdtDaFULxZcE/GNx08KPmIyv/srbnphC04
         vh7q56SqB7ZEX0QNKje8zi91/vevKC3sxDHP2U7UJ6V3NudF8beHiaHfRMeLCB/v5Pyb
         rtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574188; x=1795178988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
        b=LdSERTTDuJSz4SuCRISkq2uaH+gzPf4QB1akMJdfXn3CSbjBEdu0GmbdRTPd2iYCeO
         +dOyFFMBoWUo3MaThmabrIGXW5dZYJ/RvbOplFDYZHBGvy0giho3tnIfwDQ++ju1ZQj7
         gj1IXFCaAkMoBlkUBr1n+YDVoF/yLJ2V5IX6FbkLFhy2QgLw2QrYCGhFL85AvlOTIPnh
         A0f8h2bDZPgTCxjgdibGdNNfi72wkDxVe6rd6VTil1EN5BwOr2R0GR+DrupohQurN1Am
         zVMYl/a+tzz3ZzfHmUH4XWqavD4pnSUcwbeFKbe0u52tvT36CyYeiWyuD7ijnzu4ZCja
         PfCw==
X-Forwarded-Encrypted: i=1; AL+hErGLpuvUSAwFAEu2/4P2hA+8VJXxiQwNjq9GhXGP86p8B4eS3FMwaLf0ZfMtUnWxZxp1ykYyGlU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Bfa3QSqi2/RJu4QAjoaHqktVb4z66kZGxZ4tZYXeqp6fuJKj9
	0+mCxhYUJk8OtBGKAkHzrcRQNazbhN/gHGNFeVF4s4qAOs6nSBZwXnbLs2BvhZglMZw54XCCFil
	pHAba82EmiUfuXNkyI0Xdri/QSWtXppwY0+8lpdbrNyLcpXRqeAHgIXJjwQ==
X-Gm-Gg: AYBFou0OObg39EPl6tsydhk2BzpL11ac1jmpoVbLSA+4XWBI6P8r7MbmiKp1CfmgpHm
	yQkgeAQgB1c9Zq4ztj0qA+Hib5YKMQF0xuQjJyWSX3PhXLRIo4XiS7a2RS7mueEpDBrxsf9f6iX
	w4he71NNlxvxRDzCwwltXKYJSrZEAfLMvOdb0lGfrjDs4LCMingquFHVgZRwtV1GPMhgNOlzP1M
	Tw9QAEAUPQMh42d4kSIbC0ifC5PtpLTBLgJi2eQSV8cUVWaV5G53+wySBa9KrPmEDYYUEdVLFfh
	ubnopxrTj/WOqzS2/9BveS8ItxPSpiSjeVx1UAq68bHVFwGZTBFhYwu8hfLFI/6ATZP0RpHpEgu
	XuOCuou3LOkYOdF2JPBZmQEcz2TYw/9zyEa5TYfBMqaibb9bAZNSBluvnRrWqRJV1C91qSSp9JM
	Fs1guQfG0PAOQ=
X-Received: by 2002:a05:600c:a30e:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4bb55a5d63fmr43628735e9.11.1794574188135;
        Fri, 13 Nov 2026 04:49:48 -0800 (PST)
X-Received: by 2002:a05:600c:a30e:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4bb55a5d63fmr43628375e9.11.1794574187689;
        Fri, 13 Nov 2026 04:49:47 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm151135805e9.15.2026.11.13.04.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:49:45 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 13 Nov 2026 13:47:35 +0100
Subject: [PATCH RFC v2 2/8] vsock: report datagram receive and send queue
 state
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-vsock-dgram-support-v2-2-bacfc85b71ce@redhat.com>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4270; i=slp@redhat.com;
 h=from:subject:message-id; bh=DAGnzS4beIxvhBc5LWV62Y4RCwEPeEYebUU+gVLqZ9Q=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq9wdc1HVuwZr7WAO3p5X3i9Hbncg0wLnW2CWGa
 dt8UHDsRAGJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavcHXAAKCRD0aSeNLwwC
 Ne95D/4xcEjEk6TsQj6Ph8foZvuU98DdLBcYKq+Lywy9+F8qDFnfQY7bzbWE3k0FAswmveRqM9n
 pBPGB7f2ZPGyg5EMdAEUL1HQd2TtMVa0soWaiphkuqn/P72rTNImirhe6RFeX9yynltp0UgQ2DH
 ZogLxK6KPSrRl5ThiNzbF+La2F94WXzvfytjX2MbFhQP7CyyrjkmrUUZJd6YEoo+1fsTb1dRvBG
 D2HSG3i3C+M0K4KqIZObgWkfzaqKCYyqtqMsqbMED93+wpapn2copA/Zs18H578VdZRj/URVj2Y
 0i6QDx5WlAa/FX7MBkp+FsjiPgaOmrP7MAWiu9fLmVRj7PlKppl/X8j0LtGDOgq/Y+J54ZXlWa8
 VQVT/VqTVvFG+lXUtA6//a9k9ytewq3ZOXiEZpldYKURp5E47aLuRA9YwZ6Z/mIY0tAs8zdg7l9
 o6bnO2mC2sFMFlRGcz2/o/4RVadRtdDQrmQqwCfxfz5HmL2SRA6wzKWEVPS/Tg1aCe3YgsEoGzC
 ywsKTw7HVls7gnJz1GmtgR687mjJpN+ELLSAGwWS7unPCdyhGNU0JgZArRz9m2nNbuCMSdrPwrG
 EcIiZyURGquQ+Z94G9Oh6MSlbYNcflDRo2Wk/lglGuImynATDU82u8wQuOcvkPBkeGw7Hlmguk7
 zjlR5wTokFxLAxg==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Datagram receive queues hold whole messages, and transports may charge
queued datagrams to the socket send buffer. Report the size of the
next datagram payload for SIOCINQ under the receive-queue lock, so
concurrent recvmsg() cannot free the skb during the query. Let
transports override the length calculation to exclude headers such as
VMCI's.

Report datagram write readiness only while the send buffer has space.
Set the asynchronous no-space flag when it is full so freeing pending
send buffers can wake poll waiters.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 include/net/af_vsock.h         |  2 ++
 net/vmw_vsock/af_vsock.c       | 32 ++++++++++++++++++++++++--------
 net/vmw_vsock/vmci_transport.c |  9 +++++++++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index ac061115ed30..e4fbea3b0e46 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -124,6 +124,8 @@ struct vsock_transport {
 	int (*dgram_enqueue)(struct vsock_sock *, struct sockaddr_vm *,
 			     struct msghdr *, size_t len);
 	bool (*dgram_allow)(struct vsock_sock *vsk, u32 cid, u32 port);
+	/* Optional payload length override, called with the receive queue locked. */
+	size_t (*dgram_payload_len)(const struct sk_buff *skb);
 
 	/* STREAM. */
 	/* TODO: stream_bind() */
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d5cf240d4ece..8a271eb66860 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1359,16 +1359,20 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 		mask |= vsock_poll_shutdown(sk, peer_shutdown);
 
 		/* For datagram sockets we can read if there is something in
-		 * the queue and write as long as the socket isn't shutdown for
-		 * sending.
+		 * the queue and write if the send buffer has space and the
+		 * socket isn't shutdown for sending.
 		 */
 		if (!skb_queue_empty_lockless(&sk->sk_receive_queue) ||
 		    (sk->sk_shutdown & RCV_SHUTDOWN)) {
 			mask |= EPOLLIN | EPOLLRDNORM;
 		}
 
-		if (!(sk->sk_shutdown & SEND_SHUTDOWN))
-			mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
+		if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
+			if (sock_writeable(sk))
+				mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
+			else
+				sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
+		}
 
 	} else if (sock_type_connectible(sk->sk_type)) {
 		const struct vsock_transport *transport;
@@ -1632,10 +1636,22 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
 			break;
 		}
 
-		n_bytes = vsock_stream_has_data(vsk);
-		if (n_bytes < 0) {
-			ret = n_bytes;
-			break;
+		if (sk->sk_type == SOCK_DGRAM) {
+			struct sk_buff *skb;
+
+			spin_lock_bh(&sk->sk_receive_queue.lock);
+			skb = skb_peek(&sk->sk_receive_queue);
+			if (skb && vsk->transport->dgram_payload_len)
+				n_bytes = vsk->transport->dgram_payload_len(skb);
+			else
+				n_bytes = skb ? skb->len : 0;
+			spin_unlock_bh(&sk->sk_receive_queue.lock);
+		} else {
+			n_bytes = vsock_stream_has_data(vsk);
+			if (n_bytes < 0) {
+				ret = n_bytes;
+				break;
+			}
 		}
 		ret = put_user(n_bytes, arg);
 		break;
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 1f186e8f8364..2b9493e987d1 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1761,6 +1761,14 @@ static int vmci_transport_dgram_enqueue(
 	return err - sizeof(*dg);
 }
 
+static size_t vmci_transport_dgram_payload_len(const struct sk_buff *skb)
+{
+	if (skb->len < sizeof(struct vmci_datagram))
+		return 0;
+
+	return skb->len - sizeof(struct vmci_datagram);
+}
+
 static int vmci_transport_dgram_dequeue(struct vsock_sock *vsk,
 					struct msghdr *msg, size_t len,
 					int flags)
@@ -2075,6 +2083,7 @@ static struct vsock_transport vmci_transport = {
 	.connect = vmci_transport_connect,
 	.dgram_bind = vmci_transport_dgram_bind,
 	.dgram_dequeue = vmci_transport_dgram_dequeue,
+	.dgram_payload_len = vmci_transport_dgram_payload_len,
 	.dgram_enqueue = vmci_transport_dgram_enqueue,
 	.dgram_allow = vmci_transport_dgram_allow,
 	.stream_dequeue = vmci_transport_stream_dequeue,

-- 
2.56.0

