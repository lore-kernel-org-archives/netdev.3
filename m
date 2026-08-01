Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B1A26E173
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785588798; cv=none; b=fgK3zHvxJhIS1z2NNbot6RpYl9h1G6by1hEPo3dPz09Mb+b3G54cUTkvePT5SXBsIJQRLyuZuoTny50NVAhun0eWIbbyWFW+Sw45m9Tx5xoRwi8+kN7x4k+CtpUFoL2rlGkf1pI65lQoAmpC/IcfFAnSc8l8fspwp6gT+RFrUK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785588798; c=relaxed/simple;
	bh=AOKZpDSw3Las4QHYsL7qkLgH4+UbyYvjH9SLgnGcoJM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=l3WFZXgq3Cgcs4n4YEwj5SMUOELq/GHtUVuPqGFMKyI+4v5dt5K0v977c01toFNAPSbCJ9twCa1dVZV+rbl/MBX6qluZZ7W2hsbPr13nsHAWls2c3KIRx3DkRbt5lYRDUGye3dUlG5Z/9mfwpCWFKoLWAL5j642/qB5mYRoVQBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BfQgzcFv; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BfQgzcFv"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d001671a54so38715905ad.2
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 05:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785588797; x=1786193597; darn=vger.kernel.org;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gAxXXam8n+CPIEdz13wbnbvJt2f6TZ533SHqTK8C3oU=;
        b=BfQgzcFv+5lBVPjgzNgdFkElJBQPNUyEO1PD3YmfAOv0gIaOhjA4AZzSYfR/jwmkDL
         A/vCmGmehnh/CghRnv7AA5uwKK3q7L2Nl6Xd6p1ocpKZZHaly9/QOSttmG644WIpxHxm
         0lmasBmJBbhHq2qqtFbiRi5Yu0YG3gSA3m1T6DvtwouozTGGlSCz6JnS0tXYZXUGSJaB
         WpItPrqirmtuMIdbNMEMuhBR7vPOr4nAftDRqV/ew+LbFWqVQGqSNFvQ1RYxaHdpejLf
         8Ev1KUHr7SxUtOgFHSzb8E98tepHSji0gV4k3AKUF1X61yWmWrhryFJmtzfvWJkHL2vA
         kI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785588797; x=1786193597;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gAxXXam8n+CPIEdz13wbnbvJt2f6TZ533SHqTK8C3oU=;
        b=ic5SoLveNiJTbySPnmsBTaEkpEyk3NIMtvcNu1NS4CDGYn3r0GAOAttMcMl/f/2gLG
         c+g7kE7cAu5R5bsot+B19Qqo6YWWJYs3AGs3XzS3WEhAH/fqQMZ7xO0p79gpUhLOT1sd
         qrXGXNBdy54PYw/fAP8iW1B3nvYJSZjXtAccCy2Pi4ujeSOP+yO86SDL22yEe1V6rpsh
         0mkK2aqGZTh+HM1YdaP4G3M39kqZcnOTm0u7R/GkwMKKVm1IovTm8ZxaH5ITokoSiafp
         TDeTNLJToRpsc9ov0dx+n+uttRwtITaYP8RgEvz7iBzRi/NUYBuApCaVc1/OtMe+28/c
         JfMw==
X-Forwarded-Encrypted: i=1; AHgh+RorbMH7iTFp6Wl5x6cBPqukLIeIxCbwqH/8cnV+5HxkZ2XXO/QvBGw8AC/nK0WbEvaPIgyw/BE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+o9FrOGj3d+NtfNoJqA98egfG15C8ipMgsgE7+e+dOmnR477L
	1cqOn5IJkg1IMSGITF+sYubyqaz85NWOu0HSx4omODjyQ7Pn7o6cRU4nyhy3PdhZUcHMgIGlO9i
	7QHClZxB8Ojc6vccnNuoQWaHwgA==
X-Received: from dycue2.prod.google.com ([2002:a05:7300:82:b0:30c:1aab:2586])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:112:b0:3c3:92ba:c61f with SMTP id adf61e73a8af0-3c92a5176cbmr3675379637.8.1785588796761;
 Sat, 01 Aug 2026 05:53:16 -0700 (PDT)
Date: Sat,  1 Aug 2026 12:52:21 +0000
In-Reply-To: <20260801125308.1342897-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260801125308.1342897-1-almasrymina@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260801125308.1342897-3-almasrymina@google.com>
Subject: [PATCH net v1 3/3] net: tcp: block standard payload injection into
 devmem skbs
From: Mina Almasry <almasrymina@google.com>
Cc: Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Protect tcp_sendmsg_locked() from mistakenly appending non-zerocopy
page fragments to unreadable devmem skbs. Create a new segment instead.

Fixes: bd61848900bff ("net: devmem: Implement TX path")
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/ipv4/tcp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 455441f1b6949..186a36c698798 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1278,6 +1278,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		if (copy > msg_data_left(msg))
 			copy = msg_data_left(msg);
 
+		if (zc != MSG_ZEROCOPY && unlikely(!skb_frags_readable(skb))) {
+			tcp_mark_push(tp, skb);
+			goto new_segment;
+		}
+
 		if (zc == 0) {
 			bool merge = true;
 			int i = skb_shinfo(skb)->nr_frags;
-- 
2.55.0.571.g244d577d93-goog

