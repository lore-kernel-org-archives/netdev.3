Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989212;
	b=fC3u2BMHNYikhm9DzYDaSwpWwirpLDrfjJjII605DORkD6V9b2822FXN4Bd7N+CF24cL
	 0lN9vAHbBi+3Qi04zY/4WVZ+Itr7O6dbdnGynE9RJXagMdLRDjQeUBoED3R6e+L02buku
	 yIbMBEqCUv0Uf9O+jRZ6ggzpgrObch7sIqG4ZrlN5/NxP8YV0NlGUty45Pki+XlONJEKh
	 7a24wAJ1Z/xUDJcg+Kep953V1ttx9f5z5NtslZ9/jLUB8jX3KlTt+sf76rKx/cUorCfi9
	 /shvvpUCXGPzaGh/VxVN9Sgm1BSnIW1VfllKn2gYtogOTBTThDLsUt2qnX08m8SbCnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=71V+AIGlLe9tGQsH861SMnNvz1v73B93HY2pNoIeulM=;
	b=mdfXb34TyYgTJ73+Nz3TIlmtLeLuyOP0/L/znlOTHc062whN9c+EiCkulBmzUihT7QeZ
	 Re3ZpmXKIXQ7/0gf5XAmpksEhURFJNjqq8fTSyrWQnq7+/ntQWll5Oml9VGWVbY/zGhZi
	 +3XQCYUeZF0V8UGL0aUU4staGH3N+3LRqWabWI1p15cUwaYe7FZACa/lNJRtXW9xAXloI
	 GMLjJRZF+WPzX0BYvZvV3DqkTs9meXVPO/mOgUhrgjdULu91MrYH3Qs+UBAd0anCLN1N3
	 XUgQ70jnpgewIlaUzuPWXBZMVaZWAufcOW8bfNdg8Vs6A8IfjrtH2pBbOo0IYcHRq8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o9R8LNPX;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7AA606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 18:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA7AA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o9R8LNPX
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b0a3ee64bbso1790064a91.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 10:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793989211; x=1794594011; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=71V+AIGlLe9tGQsH861SMnNvz1v73B93HY2pNoIeulM=;
        b=o9R8LNPXDoSkSXW8WPh7f/AW7td6ABkMNhmRoubPFNbzsbnFVhrDENiceq4Xf5oC4s
         ZZAVoa1CLfXOtqOqy3rIxWYPLvuywa5adD5y5xsokdCJGVw74+MkYiacMnBBnhEkl2xF
         QCfz5zH2ByBLXlXp6lzPknqlMs2MuM2SrdAIMT3uG0ySoI0/82T/GLF6fI/DH3LH5Xpd
         Y/EsM8R3aYaEKaysndTpHUQAjWWITShqbY2ccW+Us1u2QUA4voZNRVcCSC/4uGCAcvUB
         ul1+3PFMVhqCNfJmNUficMF5yYVW2MMeJkUVpbzdqr2oBsYap2Tao+4+onELr1pwQ5k9
         SH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989211; x=1794594011;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=71V+AIGlLe9tGQsH861SMnNvz1v73B93HY2pNoIeulM=;
        b=VyhSqbPENAMjQ3C/cHD6hrdLsbVeU2xByCfCka7FD9kUfRT1ZWYH/XOzeBLLhH2VOb
         oULP0OhgoWYI9fFKfQA0/obvLLPF+2STF+G8KYucshzV89xcGh1M7+OtDZlmbFLTFdPA
         xbuTu1EuUldZkKRiQeWZLSvXu2/sLAivN2/BaNsrwhgiwmVFWXbP0xrjQP2yfT4qGCN7
         /NBH3Dwenu/E4D6ikHM4gJVN0ripo/bBO1qbXkPJpUO8b8Z9y8IAJyVHhNTPJeGTOggi
         HERhE82PQgt3P5yEzBsZBu+2BKDWcGm1qLDMYUv8ZNCXziC3xqKL/v0X1ypF07rIeoRO
         E8/g==
X-Forwarded-Encrypted: i=1; AL+hErHoPpBXN8WXskMlNs4/k69yqS8LRMhQHZFn7Xe4z8cH+a4IwkdCq90qnfAjylXUfMcC9mL827I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FW3/4rDhAF2w4hh1Yxcf09b6bqKnKJgxxu0YOvU8rFJ5suEPs
	aOJNAm0v7OX0jCaZva9xr5QPYHZWhvm+ZM+OjZ/pd7Ylbm0B0X+DfjozVt0WwgNZ+DSknbB4YpA
	k4YfusA==
X-Received: from pgq6.prod.google.com ([2002:a63:1046:0:b0:cc7:cad8:ada5])
 (user=weiwan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52cf:b0:3b0:ae41:2706
 with SMTP id 98e67ed59e1d1-3b0db5f60efmr3709018a91.4.1793989210913; Fri, 06
 Nov 2026 10:20:10 -0800 (PST)
Date: Fri,  6 Nov 2026 18:20:05 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106182007.374660-1-weiwan@google.com>
Subject: [PATCH net v3 0/2] net: psp: preserve SKB_EXT_PSP across packet scrubbing
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

Changes in v3:
- Patch 1: Move tmp = *pse; after the fast-path early return, just
  before skb_ext_reset(skb).
- Patch 1: Do not clear skb->decrypted if skb_ext_add() fails so
  sk_validate_xmit_skb() still drops socketless decrypted packets on
  egress.
- Patch 2: Replace s.settimeout() in _check_data_echo() with
  non-blocking _recv_careful() and _req_echo() helpers.

Changes in v2:
- Patch 1: Replace the skb_ext_del() loop in skb_ext_scrub() with
  skb_ext_reset() + skb_ext_add() (and a fast path when SKB_EXT_PSP is
  the only extension in the skb_ext buffer) so shared skb_ext buffers
  with refcounted extensions (SKB_EXT_SEC_PATH / SKB_EXT_MCTP) are not
  left half-deleted.
- Patch 1: Make skb_ext_scrub() static in net/core/skbuff.c and drop
  EXPORT_SYMBOL() / public header prototype.

Link: https://lore.kernel.org/netdev/20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com/ [1]

Wei Wang (2):
  net: Make PSP skb extension survive packet scrubbing
  selftests/net: psp: test bidirectional data transfer

 net/core/skbuff.c                          | 30 ++++++++++++++++++++--
 tools/testing/selftests/drivers/net/psp.py | 22 ++++++++++++++++
 2 files changed, 50 insertions(+), 2 deletions(-)

-- 
2.56.0.455.g6c5a503b38-goog

