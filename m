Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915533;
	b=uz1yHCvXCmPZGyZJvTyjlvPIbTg0pkciXEtRUx6XtsTEbVhmi/GLTseN1kUoyfAZxH+e
	 B6g0fSjm97NPnTs7/aEg9qiTrZs07Ly6ChjICtZXElVvvU7jKqmYjk7Prweexr/Ynpxqr
	 qiH6XGXpQ6w9RbFUoOv1oXIJ04nLYeCZe5QQ2N0ovQ3ZFp5AKO2WYOKTyjd3LOqpeP3ES
	 Uv0oDW1cLJyxGlywFencSw8pihfjRgOKDLZztEsdNbj0nQ27dsKprWmdvKxuj/gLXxq87
	 M/NnMvWVha8PM/SdYNXgBVwiK6czxZmghFcuBdTn9c4W1AKKFjVA2LEnR6EdCNx5xOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Kr3ykGzElaQTD96FwpFR8J0tFuqnCvyPzypKvj3ukwQ=;
	b=UR555bjJZqJ4by1BaREin7hdVs6hJATmZgF3JsyF5XW8jfPjusTeL8dWJPURCbiMwJ2U
	 5BqepkfWUc9+mN5Kl6BIN3LIvN0pH41UVCd/YtxJz0zJYvS6awZbj0OFRCBjKYlQcJ8Sc
	 IrBcvZKwRPebklIWSvlrqZ2S2gwU9Xb/rfI2ulA/N17TKKUAZ97saB/3UENZoYPEBfHhs
	 lAhHjdpMf+fwh/XeAA76AORBz1Q8TBO1w5ck9u4vqPt1PDXnDpNjXl7EOr0e6xJBCPAfo
	 TfnY8QMpIyFHHEYSB5/hUsp8GTHpoNFnsZJdXPlo2Hiv4Z5u8fk7W+n4oq5U1aV1ilQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HLhYG9ZV;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629E0606A32F
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 21:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 629E0606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HLhYG9ZV
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ac0ae43900so10889a91.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 13:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793915533; x=1794520333; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kr3ykGzElaQTD96FwpFR8J0tFuqnCvyPzypKvj3ukwQ=;
        b=HLhYG9ZVUhfGGtY2zPW0kdBD5T1/qCWE7upzw+3AxUUIKGpKdKvnGqct4K3iKXyLlw
         rpgR9XW42+U4w6ThOUAGCsRqw+OsqC8u1stGk1p0XMXk4qE9XZEb2c+Ivz5+5GYPk/DW
         eHtniLWDcBuG5GwbBkpTGpEU6BWkli1+lSZcBq2pi66TO21GVVOiF9B1S97tzx95rVj9
         ZXsoSCYgtMfsaV4gsHXWWUQpLMQoxgDfw8GgUd/wp8BlygHJSShROd4FeM/HhcjpmSlq
         46adHrkb6Jk3qsRIjOw5Ay0XzIPYflH8pbS8rHu96JbGUk9/sjwKH/mED+RI6SxS6EEu
         TYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793915533; x=1794520333;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kr3ykGzElaQTD96FwpFR8J0tFuqnCvyPzypKvj3ukwQ=;
        b=LoDMlkpcDFWKglgY8bj9gBOt/YpLz3/zPjPclBnTAlt7hOyn3XY7lB9LcPZPmjfA3l
         OAFEAbn2N/vbNSOxLjjsmIRsZtYHV/lg8pa/SR0LxASj8tSDWLbyWgkwGiXdKI0agC6H
         tn+PIZTW0iv8t6SSVeJiik9TncGyF6kAj6aY8W80K9DXy2NPnJjGgFvfOkRyspuoBIn4
         o1Dkkvif45TRS9LUTo5OItW5eGdFUqUOLUGf+SJeuaErNsq5hCLpxKCeK9q8l25753qh
         Qi6sXBpXIe6bqxWz3kJD+H6KSgdb6PwRIaThS6KRtZvH6ObHV1Sx3s7bNn7fGEfpWCgJ
         1IZA==
X-Forwarded-Encrypted: i=1; AKwUvBxqp8AlKlDYjy0U8jyiGmdM5xewspELmzWrTObBWPveQpBv+QR2F+flsggRBG5G+onqQ0vc8w4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tzRiwM0nJ1+TROt5f7hREnH/vvEgHaVdu8SpxTamgdHUZUh8a
	A6jdbItrH2MlE3WXYI26XQqVBvEWcBSsIm1m9gpNnWiaEH+NFui/kwDV/EyXZ3c1zNHIjO5gVfN
	dz269UA==
X-Received: from pjib16.prod.google.com ([2002:a17:90a:5510:b0:3aa:fb90:d203])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec84:b0:3b0:92be:ea4a
 with SMTP id 98e67ed59e1d1-3b0db718db7mr306120a91.45.1793915532526; Thu, 05
 Nov 2026 13:52:12 -0800 (PST)
Date: Thu,  5 Nov 2026 21:51:46 +0000
In-Reply-To: <20261105215209.3160316-1-kuniyu@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105215209.3160316-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261105215209.3160316-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 2/2] mptcp: Don't call tcp_update_recv_tstamps()
 if not needed.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As with TCP, __mptcp_recvmsg_mskq() also always triggers
tcp_recv_timestamp() if skb has hwtstamp.

Accessing sk->sk_tsflags incurs unnecessary costs for sockets
that do not need RX tstamp.

Let's check SOCK_RCVTSTAMP and SOCK_TIMESTAMPING_ANY under
lock_sock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7a22e9388e0e..797797ce4e88 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2189,7 +2189,8 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 			}
 		}
 
-		if (MPTCP_SKB_CB(skb)->has_rxtstamp) {
+		if (MPTCP_SKB_CB(skb)->has_rxtstamp &&
+		    tcp_want_rx_tstamp_cmsg(sk)) {
 			tcp_update_recv_tstamps(skb, tss);
 			*cmsg_flags |= MPTCP_CMSG_TS;
 		}
-- 
2.56.0.455.g6c5a503b38-goog

