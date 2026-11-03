Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793679152;
	b=dwn+WFdzInzcD095/iK3/lh3o5vLmnGilyUF7gdXCTpFlBeW0Bs8mnsm0v1YzHpkMUeK
	 3hsUuYsn6sQs4kYRhFstcXBd0Kx9va2/AyBAmurRg/Pwm2v4PPcn/6TmMSmZ4bhS9Q0x1
	 Q2IeOFBZ6HxUC0Qca/SNaLPLkgHIeA+rqQXGlrwS7fjw+sYBRxIXzAYDahbdMh6GtPPlM
	 lksOYEk9FWWNYqyo6DeUJnjPT83a2eutyba/HhtHPRSaGql9CiC2c3Uq3qodWvcd/9kMl
	 GlH4o5JRTi0dVIeiazbr3kLk2d12FEuXeqC0AlR+/Xth6Q4drvZ2Ld8+/2Dk6gtvRKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793679152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YqasG4hoa5HMln8cuz36jlojNM8+bH53t/aSP0CVnp8=;
	b=yQHE3YrOcqwLR1/nreyEEUzb93UQuMWUtHk1JyNdpTbsapKIPWu9nyCLBimr2KZ++kZX
	 5CymSb0oKyP4w5D8ZT9zndfZx/xL00t4Uaid3DENQnOXn+Tl9EUAKActYjU4pkIbnR9BR
	 uaY/S4KnjMMlT2hpC9Gk6s1RiRoCKDj7igAe4gxStIzickhOjBLsLV+VqNN3MCMw+83BW
	 WhFjLTWVYy3hDjv7R/TWcTv5/G3tkasYRjiICT9tB4jg0mvnUL3huTr5TgRtbgEmJLtMB
	 F+PHbAqUQlSHGaj2obZQQXYssfhmwjKNE2hKdcFQyHyRnO9TFET4grOMOpYTLZbQ9RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yzaUTNE6;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A35606A327
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 04:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64A35606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yzaUTNE6
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso2723693a91.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 20:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793679152; x=1794283952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YqasG4hoa5HMln8cuz36jlojNM8+bH53t/aSP0CVnp8=;
        b=yzaUTNE6F6RJplgdhN82dhJZSzDhQ06QB5gPHmzagXtVy27eP3PELDsWY0W7jkkuHZ
         ekd5XdsvxVF032K2Gi1sp5KhDd0CBDv8vk6F1bg4wUuO4GzlOANZtOvINeO+soGra2PG
         7RZv4zAGkd0Rhz7TwXZtQHtri7lxyIdG0POr0yrjAj+qqAjSLwvsxk8+bFHtk3W//8dl
         yIxrdXZy9Q7MDJ3SkdspAPwKtjOhvzaCAwTNJG0e+9NUE0BYMZSr3jDljs2PlsUe1TRh
         lesKrhlCR72x63yIrZxo3eNy3YD/zJAOzgyXvrUoQmMybulJuN33+09brnDRblX+jwNt
         becQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793679152; x=1794283952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YqasG4hoa5HMln8cuz36jlojNM8+bH53t/aSP0CVnp8=;
        b=uMeRfZkwwqOz6K8nrveXyHd1Fat+/J4ZPcecuUaV/FSD7DXEUjNkjZL3UDUaQj45+Y
         cmv2j8cIjefQewBjblxXOK2PZXgylBpFkbIoajP4r7Akkav/Ph6D6h/zcqR6kU9G1l4R
         N3aromtuR++Ylk8CMJYVMfYu3XTWW0r8VK1ayRW74Huj3ff8OsaguphmXKMCWVQfQ8F8
         jzVyWh895Dm06o/UeaZPYM3+bG8Imc/j/HLKrBs8TQ87sOmW93lf4IdwjWooLM5XsUeB
         OV5qFm+LgqBgo5reuE4cCRyHpoFs3Z6WXVr7AdzOpccti63n4SWsEZ/zzM/m7eKS2X9c
         tgXA==
X-Gm-Message-State: APuU4Z+gUR0gAu9YY5qPFPMZhXbOnMRPSKiLr4ioGk4om6DOchihUvSj
	hLLa+lTM9BLxWhvZ97PVK6PZ+C4ltDBQ5J2JtYyTQR81TOrIv5tynBch8BW3kw==
X-Gm-Gg: AYBFou3wh0TwpLFd0jM7NFvY8LmZLj/ZeJnOtdMaIkjmNI/52CcAEoGrTNZigez10m/
	dPZ1+Wx6ZOmKIoIzCbBgdmsjLaV9kZuXa7ckemcssiY9OyrbM0TRy3uzAA9yYSVZxw3GQLybwlc
	LrNcmTiuHcCO6SVTcUKAGK3CNgqEPQmKpEEJMMMQqzNJ5loBSeEqgkpElwS7dO/kfI9XaaN1qcD
	A7WGdxpjd3JhIJ/J98dZrDxFW+P3X8iwfkFzuDPD9ZR8RLxTE21s4KfAR9ghq9xm6FIOx3yO4C6
	9Ou82HMvG+Mozx854wX63bTRvxV4cW7+Rq5+R1QrgItwQYR1QgIFJzeIm42KaIwVBON1nCORNk4
	LlB/KcZowEOe4Vf8MxDBPzILktKnueGFQJZGUbpbkXyUtny6G5LvhdcNG4VD+l6lUjMVvJLfnJp
	wBmYhOCw33N+bEsJGHpTvgCfLJGEsq9KsT8RGysazQ8oh+HdAg2vlZp8WK3KkMmOxqIHxrzU7Wa
	RYv/hir8eNyosofN6RC49Dsype9JrY37kS6IetehiILxKRZAqV/qv1lndeCHXcVG0E0m4uCAmRD
	4YNS7SgL
X-Received: by 2002:a17:90b:224d:b0:3ab:afca:1d79 with SMTP id 98e67ed59e1d1-3ae897eb33emr9769580a91.21.1793679151782;
        Mon, 02 Nov 2026 20:12:31 -0800 (PST)
Received: from gmail.com ([2407:cdc0:f00f::117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6f010asm1941708a91.15.2026.11.02.20.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:12:31 -0800 (PST)
From: Jia Jia <physicalmtea@gmail.com>
To: netdev@vger.kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 2/5] vsock/virtio: factor RX skb metadata budget check
Date: Tue,  3 Nov 2026 12:11:31 +0800
Message-Id: <20261103041134.33310-3-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103041134.33310-1-physicalmtea@gmail.com>
References: <20261103041134.33310-1-physicalmtea@gmail.com>
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

