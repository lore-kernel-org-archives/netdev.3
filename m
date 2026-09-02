Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A7B453A3B
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390079; cv=none; b=f7ZSUdTbFUgXPZ3/aNS0sdM/eww4hBuf/8wk9echwNx86m2QdD89TnWonG+b6g/0R3UU3SkqPMBGgGbIWQMTTtI6QjGUNt9yps9PDeO4Wy4mR4Dvh5RmbVIAbIqOd5c9Sp2tNKeMFWFj58uqz3lGHYkn2Vc1xn7rH8r0tEa6hqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390079; c=relaxed/simple;
	bh=dqBzikGa14hqqrjBAPe6y9B3zxWzEgOKtDsMRinPnZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qwphZZ14cEyM48cWFqh6rvQF6Iz6Lv88aS1IfRqEc3e5JlZs9M7JeRlY1nslhNEXUUw/3igKkIAYcvtmMvfsZcE2/VKaKy4e6ysF83Vr+ryG6RGEn9/bw+pDkANxMG9+CElgf2W0GMX2ftN/ynz+aAurXYOTDHEqWYCNTShNRuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NS/oc9Hs; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS/oc9Hs"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4b3b1b3b992so1036794b6e.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 16:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788390071; x=1788994871; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SMJ26BWtmMrRnikBYx5aKuMSmpbwrNZ5wPGOE3sWg+I=;
        b=NS/oc9Hs/kVwiejmZ7MPNrn6+wn+zRHOWaT93IT2LjLmJ+RO0MmW77B7NylKm0NVkt
         YagYJoRDEQxQxwoHPluJ3u1ibpr7/CQXyfoymvj4rnDBjNTEsN3ehMjTVnzKDLVicAqU
         Ik9SMedEsF/hVxj5knJ8kTChfDbSnZKdf9EIs03LmDZ4swRlJZRQMe19iULPOArImK23
         h2tTXXM0k84o5RUa0YitPwSz/udjr/wTvdE31p0X60UdHj+8yZ4u+xao8fDgi3vxX7m2
         3O6lWpzLFLuVsrT//36AjsL0vg9UZ8iBt+lTAy0iZlcDbHfbYWk4eAXWm8+ioPHtBF2m
         J1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390071; x=1788994871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SMJ26BWtmMrRnikBYx5aKuMSmpbwrNZ5wPGOE3sWg+I=;
        b=QhEI3DnmXUXuNycWNo05BZ0hlw9X881daMepQh3pJ7McsQMhL/jxgHVl53sDb+559F
         yNgRJHhwjug6SAQXm3X5BI9cVVGwOq+a3u0QAxyJ0kHYjyHqpSdaJUKlknfaXHllazw7
         qrhBlk5VOnoxpaRw3Tlgm16jfYoKOIt8u5rYYfARxS1h4DHqtLHrY2qUY2wCNxaYSU7f
         OUQYk+W0TP/vu91u/fb1jiUeCVLTnc4cCJTsm3ccki6zfflH0LsN6qhp0hfUWiKbIQb+
         +14Oslsz9G5dhOyJF2mOSDCN0/9GUVHt3HCTmzlBiTH1fZHaZusWK6z00T7hft/VeGsh
         Stew==
X-Forwarded-Encrypted: i=1; AKwUvBxFRVxjplXTCGEAMlPuI6atymPs4zGk7VKzH9x2UDId1QDHT4qXk6byejEKDTuWHfJGpVJHG1s=@vger.kernel.org
X-Gm-Message-State: AFuF++mGD2GR4BQ7ghguhiqh/kU91L1GAM9Zke6J3mfzPoioI3up7BzK
	IlHIu/Vg/EOiTwIQfHzKL4f4XXybv/J3lWgvzQjsKamvWGJ7rluKIplA
X-Gm-Gg: AYBFou10/WRDSDKfjKexQBhAQlawGUPWjGAvaomqbZkgB7LIuNgjgPOpqh3hSw/+7DE
	fGeQx6MTn2lplSdrU902jypXWEzxZczzwSQEhheZ7B+Ty1vLMgnLp+N4KNmp3hJJrxa7/AZAa+v
	LmCmoHCxogVemUMSnghcbgtecZvVSlSmjZyfWNMXdISu6J/XWm8hrnjRGiITxqXa2EmgSv2/NWG
	o7yd1+LHbaCX1LxnXz63Q0SBsYO0jQ3O38xA2eWWVnRHd2IUM6RPEcKK5L5Dp08+9dFctSTCuKQ
	DzGsZU4lG7K0dB2xwit/hWfPQB4W2MdqnXJt4FzSfXJKYedEIxVvi6DCKVJlKazf7xPOPKXHYVP
	6m9WaiEjNdY7LJvzqvSANWT0gFDg7Zor+qsKHsNty6lvTjlQ39tXDZjG7dRXDYLmeGLHOtZyoo5
	wKrpJ7laCJmogkxI4ZAl+CjzmXnKsvz7TyzvtkpUPjjGfTstlbbuQLCW+TaW8/cNoCO0k=
X-Received: by 2002:a05:6820:1898:b0:6ae:4131:98c6 with SMTP id 006d021491bc7-6b47ecdabc4mr6868224eaf.2.1788390070886;
        Wed, 02 Sep 2026 16:01:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1d::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b40f92004fsm3807143eaf.15.2026.09.02.16.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:01:09 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 02 Sep 2026 16:00:47 -0700
Subject: [PATCH net-next 1/6] vsock: constify the transport in
 vsock_for_each_connected_socket()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-vsock-guest-ns-v1-1-9995383e9a8b@meta.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
In-Reply-To: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Allow const transports to be passed too. The function only compares the
pointer against vsk->transport, which is itself const, and never writes
through it.

No functional change.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/net/af_vsock.h   | 2 +-
 net/vmw_vsock/af_vsock.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 3357ee62d10b..87fdec60ba45 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -230,7 +230,7 @@ struct sock *vsock_find_connected_socket_net(struct sockaddr_vm *src,
 					     struct sockaddr_vm *dst,
 					     struct net *net);
 void vsock_remove_sock(struct vsock_sock *vsk);
-void vsock_for_each_connected_socket(struct vsock_transport *transport,
+void vsock_for_each_connected_socket(const struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
 bool vsock_find_cid(unsigned int cid);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index a33b2a2d381d..29cde17e08f3 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -448,7 +448,7 @@ void vsock_remove_sock(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(vsock_remove_sock);
 
-void vsock_for_each_connected_socket(struct vsock_transport *transport,
+void vsock_for_each_connected_socket(const struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk))
 {
 	int i;

-- 
2.53.0-Meta

