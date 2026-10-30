Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334711;
	b=qZtfpQFv2HrSzs2laEcfigrtwFr2nzslo8P7yKTHNoxetHwpRNotzb1yo43/fsD+aSYx
	 QDFhM/3hlB0RvwyPuIdW8tMDP3iuSGXumLrkOPTh0xMaUQ5VyZfGIXd/M9FpZ0Ov9ZTWQ
	 qwZTcTppYthOWxfSPrQfmc7s5e8HoLBmO1mE52gPXSLCLrMwHk4fPosin8d2PGlj34TpE
	 hctcBWSb5h2nfz8vkZnY1iy+KLRWjxzE+P6ZrgNoL2BTIYC4H/pcPo8Bsqa+Vv+KRXyJf
	 KrylxHt1d0PgokvQWVjedYLV9GwVhWU7S3Ro4zBOuOAKoaevVluewWw0hDzPWU065pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=io8JORXoJvhQnQrjoZCgz8Xcl3owpfnw9TmdubvOgOw=;
	b=PCEFCode7slbLnwX38eWErpQ7b1JBPaWbYRr8WI0Rg1URWgXn/QheHZU7pTH8c019n4B
	 HEKMQtDkLY2caAzJ0DP5HwfKpKnQFozLRmT0XDU5huwOG0zrxCXPwRgG5r9x7J1h8rq3i
	 5pftql2ZichvgsNQ0lT4A7a+AqBk4qH04wib5bwQY/sIHmnDsdupTHoNJTnIimLuQVFXh
	 EUkUhUQP69APvNqtHUDaE7FzxUYkQY05NXU6Eh/+8vsJGmWO02g3npfQ1eQxbSnCXqNuu
	 jXyxebDHGULn/g2iqPeLCsvtHWI+DaJLTbf8ygy68cBVzN23lVmsbex17SRHJij3A/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CowTEKHI;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1AD606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A1AD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CowTEKHI
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-88c768885b4so303008b3a.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793334710; x=1793939510; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=io8JORXoJvhQnQrjoZCgz8Xcl3owpfnw9TmdubvOgOw=;
        b=CowTEKHI5sIJmXyky4r4dCX5ALZx+ZPyS2q31kY/7bqpb4J9Zz7Ughg5k72s0+J36w
         Cq11T3mUm2547HQfWuIYeoKdMgvfsqLj1loT02IERNVfLsOvlUyEIGJPoSjLtz/JRX7N
         astphQmvFEQ0DSlB4U5k1bB6sdv9PVwkREyxWZNWOzlHc+UdD2vOZDyrNwFlLKwx9hZH
         2JN3wc9IU0MbqWs2Uni+n5f1Vz8q2hLiD3s0ysUdMMADtkES2SSsgeNXDH/t6SY4jKEY
         XAXOF/1EV+LIQc1v5AHXwY7osxiEnRLSEFpHsTrgP7713lPIn/kCUcarlS6d/lwx/U2b
         HZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334710; x=1793939510;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=io8JORXoJvhQnQrjoZCgz8Xcl3owpfnw9TmdubvOgOw=;
        b=NvtFLsFb5kK4Ce1tKYbK7b50Cajf1Uly+moPWHozaCE8B+bX8gZsGhAZdiLt9gzdSd
         nXpHSk+YLQkTkriOOjCfdc/gKj/FrXNReHErnQX0ba+mLtQbWk/2nlDueVlx3NmTKmRr
         NvorfDMGbV/pbV8fhZ9cgrFWOr7H6wtWe+YwqlIR+7wLxkijXN8yGnn3s5bzt9y7AjnU
         zYi3dH+EWhRazawqJB5b+XSnD3KraiTTMLuAfynhuGIGVI70rb38fHM/VE7M9/su89Ge
         1ZxF14q5iEoek2rL60UwNbCon8NGNzQQgqwrQbCTlt2iOk9LLSx2A4xaWyXdVetyaxE8
         OvOw==
X-Forwarded-Encrypted: i=1; AKwUvBwITtOyE7+WElxWhpv3/LwFSbQfR+2BWExPo53sAQLb0SqtSaEvTfDish9dexQkmssP4ZTeFps=@vger.kernel.org
X-Gm-Message-State: AFq9FYINnqQknuiw65YA1LknrLnXC+y/dKHhdLGTPwMXAbeIwMCm9lYK
	H7TG5bx85Xjoiemb99N7RdMoMatPamVrkyCfGU6UEKiuyXr7/EYe9TQyAxjv/KMzJUvnbWvA1qJ
	+pMKKiw==
X-Received: from pfbdr6.prod.google.com ([2002:a05:6a00:4a86:b0:8a6:c8f0:ec6d])
 (user=weiwan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2388:b0:899:13ee:1bd7
 with SMTP id d2e1a72fcca58-8a9bf04faecmr1031284b3a.35.1793334709539; Thu, 29
 Oct 2026 21:31:49 -0700 (PDT)
Date: Fri, 30 Oct 2026 04:31:43 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030043145.2185700-1-weiwan@google.com>
Subject: [PATCH net v2 0/2] net: psp: preserve SKB_EXT_PSP across packet scrubbing
From: Wei Wang <weiwan@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"

When a virtual interface such as netkit is associated with a PSP device
in another network namespace via PSP_CMD_DEV_ASSOC, incoming PSP packets
decapsulated on the physical device lose their SKB_EXT_PSP extension
when scrubbed during redirection (e.g. skb_do_redirect() or
netkit_xmit() calling skb_scrub_packet()). As a result,
__psp_sk_rx_policy_check() rejects incoming PSP-encrypted TCP data
segments at the socket layer.

This gap slipped through the existing psp.py selftests because both
_data_basic_send() and _data_basic_send_netkit_psp_assoc() only sent a
unidirectional data stream from the test socket to psp_responder; the
returning pure TCP ACKs had SKB_EXT_PSP stripped by skb_scrub_packet(),
but were still accepted by __psp_sk_rx_policy_check() while peer_tx was
unset.

Patch 1 (originally from Jakub Sitnicki's BPF skb extension series [1])
introduces skb_ext_scrub() to selectively preserve SKB_EXT_PSP during
skb_scrub_packet().

Patch 2 updates the psp.py selftests to exercise bidirectional PSP data
transfer using psp_responder's "data echo" command in both direct and
netkit dev-assoc test cases.

Changes in v2:
- Patch 1: Replace the skb_ext_del() loop in skb_ext_scrub() with
  skb_ext_reset() + skb_ext_add() (and a fast path when SKB_EXT_PSP is
  the only extension in the skb_ext buffer) so shared skb_ext buffers
  with refcounted extensions (SKB_EXT_SEC_PATH / SKB_EXT_MCTP) are not
  left half-deleted; clear skb->decrypted if skb_ext_add() fails.
- Patch 1: Make skb_ext_scrub() static in net/core/skbuff.c and drop
  EXPORT_SYMBOL() / public header prototype.

Link: https://lore.kernel.org/netdev/20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com/ [1]

Wei Wang (2):
  net: Make PSP skb extension survive packet scrubbing
  selftests/net: psp: test bidirectional data transfer

 net/core/skbuff.c                          | 31 ++++++++++++++++++++--
 tools/testing/selftests/drivers/net/psp.py |  8 ++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.56.0.317.g454f8302e1-goog

