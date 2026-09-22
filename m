Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BF436D9EB
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039905; cv=none; b=HAM0UTFhOVXP3g/RWuFlk9ogUWgKeqNqpzfK66I1RGPpKzamfuw8SwfGTeLg0RNInbBoJEPlIDck06QvQrJWuJ0F1BHvEvEQyKgKWZ+qv8fjgQCeD+BllpnouUlsXq6rEpC7njE6mpUgo/YEtkwu8W6WA7mnuUXcxgW6lB26lnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039905; c=relaxed/simple;
	bh=cS9vNKu7FK5uQuQp6x72bj2FugS7mq6eGvzVjip2oIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t+LVFYeQSTmSez1lm+Utm/NN/IfbIKZaPtGc1EQJMMN3SUi0pqZLslCYxkAZ7FrVg016FZP99pCR+DFFtUCwzYpgariJ93nLqo8cejYvRBXKXOrTK9cq3D36KnpXBHKQJSQasQvYu+vjhFf9dV/HFwXV2ZoKLTg4b42OQSRyONg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAgYGnV8; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAgYGnV8"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7f4f0cfb33cso2086055a34.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039901; x=1790644701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eOcxxxCAKSQioxaCmq9VVEr3ww8ELRw40nRpvvXToPE=;
        b=XAgYGnV83DZzPD98Sv48z1rn5c9hysvhHdi0L0zfgjlCntlPiV1WEvsP+DdJ9SjFKd
         PKQly6wMCabbqzajOQzf3CWWfs9ZEnVDHRz86TmCr53Jrcqr7ry7uCWUX/azcupUPaTZ
         MhNb4WC7pVNjP2+7ZRJM17BnGIRRihfjincD38po/XttMVLFLJfgQaDOZgdERcJMswSi
         yHGrQuJX1zkgfDmzL5EBYWlJNwQMt1SZ+KKjw2XZw9rLxrWwUC/zZ2oOoc2Hl0asLS1L
         XtxPVegOuZrxcZZfsNvM/uhuSuVMZin5bhxdo05uzs4c3umbGXZh1Cwv13Yv15YWu1xI
         ddiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039901; x=1790644701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eOcxxxCAKSQioxaCmq9VVEr3ww8ELRw40nRpvvXToPE=;
        b=KiWqocjcPLO164yn0fXoWrhCWBwzZlbWVRWltB7cF0gOfhX4CUD78I/YLUADx9r02F
         dkZUsQtg0L4baaFEFWkOHAEusx5y0SmHxeb7hDu8Tpzif+/AXaRbBrpRu4m4X7ZiK3g5
         6fvgYXOxWk35RQBDHCbaPdZ+vNhbDEtTMKagpQOJHdYR65u/JFMW4Gd4tARdd2nCY/U4
         kICRsW3px1ZGRLGHySFLWUWenGig6uSbv4bbCL6rya21x2IeorcY+JDklnyIBNRGNHxO
         ea6CZLBIPunm91spBB1E5wcIbfVot3Pz8qj/sixtoDT7ix1a78Vd2mwp5RTCGuEA5RyI
         EXSA==
X-Forwarded-Encrypted: i=1; AKwUvBwd4GMSRUEyAEcVoGE2E+SL9XRzWU+8mdDHV6LWCdhF3/uNjZ8lDNfPE52CqxXDpT3GbCgInqA=@vger.kernel.org
X-Gm-Message-State: AFuF++lxwdQbasQxWFJDPWYbLryrGAl3Pb71o5Z1EmnCl6whpdH57Jy6
	+9C3/QQ//ambpGqUHlWZRZj0V1eWnc3avebvJbscFBPjdvaDEvURSIjd
X-Gm-Gg: AYBFou2VRy1zEJVOkfwnMwiJW7X/9Paj/QbsaPuC790Cwu0wKFl9c5oSxbOfdEWz7O1
	Zb+s0UKBvitVgVrksiLsvwFV69scUM6aJGo2sYnhOH42cTwOM3Hz827Yej/pbhZAlCgR95gK6eK
	NFpSdGUgd/6ponzjI9cjL+zbJhn27yGmcW0OncNs4gSckvAkBHiyMKm8jxy73OGjpvxlQYgXyXP
	FF+QQpyrd/bz8/GO+BxVpzUir9J9RPe6IFq+ykEnaoctl//182ywCn6WT+GZ1Vc6Lbk9+BojIGC
	St/qLGPGpyij3zkOxzAI/+y0qdQy5RaReIBJsEeC6ASPisYr6g3umjlPU9TzjSXJhBuR6D/2fFJ
	aXvii2CeodM5WRBnNcQj2UEUAqI5ezXEt7ggDG6TejTm6LWfzF10Q65XUHWy0GmaEYfUh2D9stN
	A+A6rEX3oInENo/gtSoSqBlwK1/m9YIH15O81SRSev6Bq0eBP+AgDsvs1GP7KChHXP8JI=
X-Received: by 2002:a05:6830:4905:b0:7e6:d384:459e with SMTP id 46e09a7af769-80ddff5b5f6mr12954905a34.3.1790039901424;
        Mon, 21 Sep 2026 18:18:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-814e5983e4dsm608478a34.6.2026.09.21.18.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:18:20 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 21 Sep 2026 18:18:04 -0700
Subject: [PATCH net-next v2 1/6] vsock: constify the transport in
 vsock_for_each_connected_socket()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vsock-guest-ns-v2-1-693bd78fde9e@meta.com>
References: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
In-Reply-To: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Stanislav Fomichev <sdf.kernel@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Allow const transports to be passed too. The function only compares the
pointer against vsk->transport, which is itself const, and never writes
through it.

No functional change.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/net/af_vsock.h   | 2 +-
 net/vmw_vsock/af_vsock.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 5549298c1ec6..370fcd3ddabc 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -233,7 +233,7 @@ bool vsock_check_source(const struct vsock_sock *vsk,
 			const struct vsock_transport *transport,
 			const struct sockaddr_vm *src);
 void vsock_remove_sock(struct vsock_sock *vsk);
-void vsock_for_each_connected_socket(struct vsock_transport *transport,
+void vsock_for_each_connected_socket(const struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
 bool vsock_find_cid(unsigned int cid);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index f840498b58af..8d6b705f8640 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -480,7 +480,7 @@ void vsock_remove_sock(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(vsock_remove_sock);
 
-void vsock_for_each_connected_socket(struct vsock_transport *transport,
+void vsock_for_each_connected_socket(const struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk))
 {
 	int i;

-- 
2.53.0-Meta

