Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723011;
	b=vLWLnDcshDJ0wg6LaPw3RjI7CasZcnPusYMf2/yQT75MV36NI+Odn/xMOVKlXRK+b7cb
	 SflS8SBdrG4EAgJKVkZs5/lAcuTLmd+C2T3mfgv+beVNiWUxVwh9atBa/7/gWoXHWwbtj
	 2G9MwkUolemFpwpOp1xfOVbauPn0wYKjdjtS9WbJZfS7ieFuWFnwbew4zOqxkdV1FWXaz
	 z9qFEGnRfEF0O/qkQ5oRmGYC1CSUyudxg63zxeGYQOeq34hRQUdpMnqbvhLtf7OC+EZBi
	 307DP2XlP0nfdgl6ix7MlQkasMl/YCcBhQLzehiFOYyIBEmCA3Zu2apNI/W2iM4tLZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=siM8Df/snDn0jLC7QUxpaD63oeFqtwGPtlZ0Xno7Huc=;
	b=4xN9dNSgZh4l4RFFg0qdil+z3XH1hPQzrVdIfRS7OPGRKrIcdAL4Ho2aS8RvGXWlxVCr
	 A3mv9dQBIpLgknaG3GX3aPefc38z3OuCA1QrGZ25DAiouMTp3D82NnWY2Hm/ZwilLSNy5
	 INuwGqytxKJHKfCVswluIdKKxfH6UwenVCjYj+snfJxnE5oMzTOSbe6q1QE6+Eh14x79c
	 3rrGpOxlMc8+HnOvZZ0W35R51OfgWsCH/Bhlsy0MybvRaWgk3h052t/gOqdmgyS5f2ypS
	 sJAvO7L0ulM1SLA3rltY+v2t2HNLqCN/HHsXxOOiLRdHFuffJUrXbvqbncSzHGQuN8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D8imWgDf;
	arc=none smtp.remote-ip=209.85.208.72
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEF1606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFEF1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D8imWgDf
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b1e00100eeso5216242a12.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793723009; x=1794327809; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=siM8Df/snDn0jLC7QUxpaD63oeFqtwGPtlZ0Xno7Huc=;
        b=D8imWgDfjigOJiw/1+h9P9edKVLjzbE6UNEmMHzg16OwaNOXW08/3YpkEKn50DXLz/
         7pBfmEaGt8Uphk76TAYdefar6SLw5dXS2fOmoARz8mfU9dV6ncwiLJO7WXlUvvvGbXZ2
         jItwmvV8DrZCmxI1CwiveXttySCbapbR7sQgdkVQiNOAHzCNZV2DjULEwssYxngz+FyP
         pXHQu1qHMOABPGjK9YEhnrtON5/lzOZuELpBr8aue+wWentDABr8484tq0BFLcqe+RKG
         lvqs0iEYctpX1RUhOab2vmQuTS2/pqre4roN/oP+BSz/cWoR+k+973fL048trOXlA3Sc
         DAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723009; x=1794327809;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=siM8Df/snDn0jLC7QUxpaD63oeFqtwGPtlZ0Xno7Huc=;
        b=pY4QnR+YPYaV0xe+jIMPBm50SsZS9yozCQTiVVm7InVLBEEb7ZhLAWLomYBBmpeG1z
         NPrDyk6+jinjy9slBv47bu0X/1zyRhEqWCgqNdwpZmclGisoqQu5zAR/jHXM/jTcck8N
         Y9s7oU6ZEN6e2TLshxVxhQeOXnSvo31c0huPp+AoIbszDcZwv10tUh/6xtWxued2oQuj
         qJ0RjrJVYc6ylV1k4ZquuVJZj04bx0l5CPE0gyFdUWQvYIx0uuNhfX0QpJKIwZUMDm2b
         bDBOxMCqdElrkRiDIyGfk6wWcBJfywrJxc3MuXxWpB3X7qab3gWcy1zMN8lUcpHZ+mRa
         CJww==
X-Gm-Message-State: APuU4Z986ztJiHiVHyZ0uhL6ChjUMrvyn2HxBwzPj87un4/Ct3RbjaeC
	yuliwT5PwMbZ5p3BiN+hWh0pSNNzBtcw+osGAqwn/4kl9LWd6LkFskrV8HBi7oXrIP1US6XMpt6
	Zao1sjA==
X-Received: from edj17.prod.google.com ([2002:a05:6402:3251:b0:6b4:21ae:bf65])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:d313:0:b0:6b4:1d53:519e
 with SMTP id 4fb4d7f45d1cf-6b4d4d80728mr6622485a12.40.1793723009040; Tue, 03
 Nov 2026 08:23:29 -0800 (PST)
Date: Tue,  3 Nov 2026 16:23:23 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103162326.3615979-1-lrizzo@google.com>
Subject: [PATCH iwl-next v3 0/2] libeth, idpf: use GFP_KERNEL for the initial
 Rx ring fill
From: Luigi Rizzo <lrizzo@google.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Brian Vazquez <brianvv@google.com>, 
	Joshua Hay <joshua.a.hay@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

libeth_rx_alloc() always allocates with GFP_ATOMIC, including when a
driver fills its Rx rings at open or on queue reconfiguration. That
fill runs in process context, right after page_pool_create() and before
the queues' NAPI is enabled, so it may sleep, and GFP_ATOMIC is
needlessly restrictive there: it can neither reclaim nor compact, while
the initial fill can allocate tens of thousands of buffers across all
queues.

Patch 1 adds __libeth_rx_alloc() taking a gfp_t parameter and turns
libeth_rx_alloc() into its GFP_ATOMIC wrapper.
Patch 2 switches idpf's initial Rx ring fill (both splitq and singleq)
to GFP_KERNEL.

v3:
  - rename libeth_rx_alloc_gfp() to __libeth_rx_alloc() and put the gfp
    argument on its own line in page_pool_alloc_netmem() (Alexander Lobakin)
v2: https://lore.kernel.org/r/20261019210604.2433620-1-lrizzo@google.com/
  - split into two patches (libeth helper and idpf consumer)
v1: https://lore.kernel.org/r/20261016151835.2500807-1-lrizzo@google.com/

Luigi Rizzo (2):
  libeth: add __libeth_rx_alloc() to specify allocation flags
  idpf: use GFP_KERNEL for the initial Rx ring fill

 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  7 +++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  9 ++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +-
 include/net/libeth/rx.h                       | 24 +++++++++++++++----
 4 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.56.0.385.gac671c819a-goog

