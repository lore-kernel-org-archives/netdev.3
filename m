Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792901131;
	b=v80NKypsV9su2dAMk6aBxVLs6Qh+xlJ8FPbQayZ1oYI0jZtTZQhhBdVeOWRGQqqB6EB2
	 hhFiOT/9ynsBgG+PQfbgiaZ+2GPYWR9JK9nMvTqM3VZXLZTViX9/yyqb/36Orp3w+IX6+
	 jxp+T6b15TmIbt2eCW304zugqUL1mjvSeGlJZ0wh32GWPUSY4PeZEWt8LUymH8HAVOwUV
	 fhKa0XmAGfMPB0FwlM4mDKXRO/2dsTaAznWeBuCrPmiTay2DxAvaf48+6Kn2jefspy2I4
	 NQmBhKzJw+rKXmC936AX04F+TBhuSA5rvuU4EKr5D/orIQoN2wZZTd15F7bmrHrNDLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792901131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=VtUIhvjUIXS0O+fAa/mNh6XhVMFUshrdlfp0Rfaq3nQ=;
	b=MdqO6kUIBnrJUZTu7gZ6w/hQ7ZqJXqPjJ52qPIIFSSCcza9fHXKg9tslcQz1gN88a35M
	 SXBUAMjJGlW3QzfHfPucGE258uSqFQfDgG4eOn0ZVhbqCIMV0JcMXVbwgTnGjuamAuLSP
	 DcbIlUyAJwWoEGz4Nj+ZPym7VVDYMTRwsPb0q/yqG8mPKFRKu4LRPZCsWxhIwP5eJL+g+
	 XG0F1aJsK2AYxKZx9DdOjBlXlOug5eEa2POStBbf03yc0C66K1vOagoMaU2IMSWF6aVtf
	 28stdOiB03SJvmEKaDoysxOFGxH2rolBR+hM70KpU3nWV+mHLKbddbLSPTClFDro4RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=h+sENBGd;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98960606A31E
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 04:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98960606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=h+sENBGd
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd67d4bbdffso1568542a12.3
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 21:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792901130; x=1793505930; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VtUIhvjUIXS0O+fAa/mNh6XhVMFUshrdlfp0Rfaq3nQ=;
        b=h+sENBGdqUjPol1nVxf1Fw2cCO8rFZjOCgu8Jxdj8d5vx/yqWnoORi2+WMyzELiw2h
         5AP/a6VdPHk2KKYaYju5/EaNNPcrn2t3LCfCD523mQ9drrvkG9RdFkuD0WXh4fGiUY1f
         jckeIAhor+g7LGMbo64EniuNGuEB1kFYovy5shxwaxDSnW/zTDuM3kTwtA+QZiF8IzPm
         ykzQNHflsiC/+U7SMfbonwL3/ETGp2YpiiHrtf1Rlg4Cli6stKd1LWJTyhrFytkqnpf5
         mVT3x5P/NhEFKF+fKsRWsySvR35I4G+Zm9Z5YCIDcsUuqQyhjJ4A7FSlmYrVNH/dyEff
         AtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792901130; x=1793505930;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VtUIhvjUIXS0O+fAa/mNh6XhVMFUshrdlfp0Rfaq3nQ=;
        b=W0qQ6ZXhj0LUUHxTdHKri3MAL2q7UTTSs3GYKjvU3s2EBQtxuf03jbUWN/auVjwhlT
         xcX8PXPU2LlIXv1TjnzFjyHT8JbW5al0PwY9I5mYkK7xMQzKfpphiaQSyptvrJIaEjAV
         Auj6MwUYsYBlUtWfGSIYlHy63WHQmXgcWw3WYEnuvYrSdPmBiwJq7YtbeyNBPjD1HKNC
         yv3m4zQHIiix6ILcdIfzKwyffAwJQR2PM3OPYfqlKZYOgFIxLAkRRtRARj1Bkw3Y8qnG
         6PIYMcNMyYj9Qp/1Z6xkEzppM1JP50+UT0XJ7WlnNUzzcEtkVfTn7UnPiEo0bhDdg9Bc
         Tg0Q==
X-Forwarded-Encrypted: i=1; AKwUvBzBLTsKACP522O/AlPm9/uTDBhNkZdCfCZJ3BITidjMnxF770qLN5jF1Ws7mYB7Ky0YQGikY4A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbrwGnOC/ASwfNT4L5027cGY6urdDTU2dKWFCgdjirzYDSlkVD
	Kc5uo/T4MYhRLPHssd8UiAEKVLh6loR6uyJjxOVdKtysEPfcq55ikGYNtY+dntSQImA+WD0jPEn
	xgdzpgQ==
X-Received: from pglq37.prod.google.com ([2002:a63:5065:0:b0:cd8:b247:590f])
 (user=weiwan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6bdc:b0:3e0:b937:883d
 with SMTP id adf61e73a8af0-3e7bfbdba5amr2693469637.25.1792901129714; Sat, 24
 Oct 2026 21:05:29 -0700 (PDT)
Date: Sun, 25 Oct 2026 04:05:21 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261025040523.678027-1-weiwan@google.com>
Subject: [PATCH net 0/2] net: psp: preserve SKB_EXT_PSP across packet scrubbing
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
when scrubbed during cross-namespace redirection (e.g. skb_do_redirect()
calling skb_scrub_packet()). As a result, __psp_sk_rx_policy_check()
rejects incoming PSP-encrypted TCP data segments at the socket layer.

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

[1] https://lore.kernel.org/netdev/20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com/

Wei Wang (2):
  net: Make PSP skb extension survive packet scrubbing
  selftests/net: psp: test bidirectional data transfer

 include/linux/skbuff.h                     |  2 ++
 net/core/skbuff.c                          | 22 ++++++++++++++++++++--
 tools/testing/selftests/drivers/net/psp.py |  8 ++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

-- 
2.56.0.257.gf7497c7d27-goog

