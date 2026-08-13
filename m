Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A65387348
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642317; cv=none; b=k/btyE5nZdMePe02GEUIxmtksDo5lJX1/K4cSvB21E5hYbqOfyortDAcmxL5PFVV6ZywR4uOolNIb84VQ+ciTcDSkBgxwfXaGmJo8qfTM11neXSgWdELAKK9jNBOQbqZ1zp+gN3QrZmhM3PBf8sbk2L0zgwkoqJJYDMGHdO1UYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642317; c=relaxed/simple;
	bh=OK+3PSY7/vVg8tPTstwFNKlug+QDc4pfGSyYeQEKZn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ed9dcW7M/0LNiP0ZKrTx0R1oPy7t/OyxFhVARXRnnI56Fbb3GudnDcrLriyVb9BAuDejaElON0KyrKZ6ElOhq2FR+djjbLTzcS0B4XBEcM+DP1+EYuVYl/Lv5C+R299YDEsO2cIipigm2dO7UxA2t+ywrQEHVQFMZzrHktrJo+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWHSLbQZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWHSLbQZ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so155722a91.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786642315; x=1787247115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hHhRM52KdKrRi6gpE3cIbQsE04qBYaQW/Y0DpiPJx5g=;
        b=iWHSLbQZnFFTq5IIqwBV2/o32D25e71oEmXPTin7AOAIgcc9J/pezSWTPZQx3MIIf9
         CjWlBijwkGyxfxInWNdloYIpKK2jH2QdYkwwgfgmNSSygmDKtSo0wcxQmFW9faT2MujV
         lU56m/VH2EPkDW0J1MrG9qncgPQp9gpKZFzPI4zMkClnGRJvlx0yMB/IRlvgUqhotnlj
         LwKihQhey3q+8NmVE9kRX+J/2rqhXpVdJvoqG6KyfIQ6Bdm94wln5IqiIw/TcKpjusNT
         MXc1fxR0+W2P9+O8/Rgg9MTzJsUX+gByliRRvo9fevugwnwDCC93YZmcMnbJRakNgOTQ
         i9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786642315; x=1787247115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hHhRM52KdKrRi6gpE3cIbQsE04qBYaQW/Y0DpiPJx5g=;
        b=PE11dHrvnWXdYHH9uhbK0pyUnk8f2XIDp52ggGbEo0ug2/Vq0qgqZYKq67sZGNMZVP
         10ivibbH1j3wc0Ou41TDzWJP0yXpo/U6NkvCa63XbK5d+BugQeKjx3s1VH99HMiIdVWf
         89Zz3fewfV4TM2mGfmx8oHdoQYepuGTbp6UR3/8mfRWCty/WRKwP1FigZBneX3imNFZ1
         lh3fxJ5AolNMqR/5hb7aMLROdxCwwguU5JenRY24Fh64KUFkpUQFWQruFWAXAEaQ+L2z
         6Hx8RR0WVqLCeIbqUsEjCPnAaeLI4iV+HNMZFk9sxvKKnPBYTPycZI79FyUHNmOgm6eM
         U09w==
X-Forwarded-Encrypted: i=1; AHgh+RocxOdzU/TAJ8hDXaWxox3rUeo7K1IpxdKeAL4EDRvMzH1rYl2Lk9DtvpIDdcmnjg1MyES8k4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUsWRydJESS7SQDWvxoGiOD70P2Gi+TETW4ODEqibSxPtZlcXu
	Z3xsIB55FlDxNBVXxLgML2hVJv7hMmWz8Gx2PZisn6ta8wSnfU+LfE1R
X-Gm-Gg: AR+sD13o0vO6yOwU+1sU6PjdF+OgVj21rY3i8qdpjsvGygZ2y2tiIW/++WhUw2anGzU
	SHy7BgEMH56EuhfKU2NqFOUypuUFGWHgJxe5UrcNlQTtvQt122ivoqeXE8kf1BUHccrTM8E0Uet
	CRM0vrxAM+3BIRv3vXxNpUHOjlqAsSONh6s9CBEx+nfw/JRwXoUQWIQF6ASD7E2Ag9DdvoSVw8n
	VS+mrWn+nDkM2xonfE/+8TnPUCZMLpPKjEv6HKm2va0+tGuLNfxZxIGwLZPsCr8RZOoI9VU3Vk1
	8Hdj3OuYVAhwsOmLAThEDXIzZDllcG7jpQ8zy7LJV7DMI8yEB+fdZjIlJHqfdv6apofTUBsbW7G
	5STk4r4I0rbBrqQHnqLyJ+Z+bAT+DfXon5oSrKyQ7vYzhPvXCSeheLgES4A5EKyCf9BawJNfs9+
	dihMR3Q+U6dbxvZNsjB/6LAG67Qb8RUIh1Kru3unNPly/rG71EmUr+Ano1NabELA==
X-Received: by 2002:a17:90a:d40b:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-3931e058763mr8418570a91.6.1786642315261;
        Thu, 13 Aug 2026 10:31:55 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebc75d8casm10961169eec.3.2026.08.13.10.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:31:54 -0700 (PDT)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dmitry Torokhov <dtor@vmware.com>,
	Andy King <acking@vmware.com>,
	George Zhang <georgezhang@vmware.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	Wupeng Ma <mawupeng1@huawei.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] vsock: use sock_error() to consume sk_err after a failed connect
Date: Fri, 14 Aug 2026 01:30:20 +0800
Message-ID: <20260813173024.2362935-4-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813173024.2362935-1-phind.uet@gmail.com>
References: <20260813173024.2362935-1-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vsock_connect() returns sk_err to userspace but does not clear it:
  if (sk->sk_err) {
            err = -sk->sk_err;

For a blocking connect() the error has already been delivered as
connect()'s return value, so leaving it set causes subsequent operations
like poll()/epoll() to keep reporting POLLERR even though the connect
failure was already delivered.

The error should be consumed once it has been returned to userspace.
Switch to sock_error(), which reads and clears sk_err atomically,
matching the behavior of other protocol implementations such as
__inet_stream_connect().

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Tested-by: Wupeng Ma <mawupeng1@huawei.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 62e22c4b13c0..e89cb84b8d73 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1842,12 +1842,10 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 	}
 
-	if (sk->sk_err) {
-		err = -sk->sk_err;
+	err = sock_error(sk);
+	if (err) {
 		sk->sk_state = TCP_CLOSE;
 		sock->state = SS_UNCONNECTED;
-	} else {
-		err = 0;
 	}
 
 out_wait:
-- 
2.53.0

