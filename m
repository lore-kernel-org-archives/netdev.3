Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736053;
	b=u/+tqhIAx1yQxC879MaGSDQFM75onvcM3Ket0ITrF16yk512zKDTSNOmKKZEfPWUm8I/
	 h6uu+Irh5HJlQIUYIrhPv/Ts2a1gQ0PpGMm5lCGwkdRs/IiFadY1sCeQP2g1liyfo8cSy
	 oSh15VPqhfCNjRhF3YyWQT9SfYnDFBF8RG+fZepirsha+GBzjBDRQWKCyQ+M6R/ETKqE4
	 CQWYi5SC5er+k4Hq/CApp7dKnO1i2WKZDX9vrd2/ei+vdBHOxy2xDIUa0mDMLVCNgfQPa
	 RDSoxNuR6pm50nQIsW8PtlU9PC6jVeu0TmCrUvO9DDTGxsXCdleVgS//kh9RGk4AU9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PwIPxynn/Ts+hRyBLxahwIuYBf8HIZ9im3ZAloF6OKU=;
	b=a7CqH/Mff9mm84D8bBkj2nnWGSsOM9QczZ+FYrAW2CENbx6hwIXWevXCGvl9o4M2fZtj
	 KJ+RmiSnPN9w1THGjZwAzWEUXVuWM0j1HLC3IFhJwbUS12W7YEe1NXkVyiCy3ACWCjmMb
	 OmdHJK293LXqeOaJGhRrm1VkNCH4le70XPcp/tjfhC0djBDKr5lWxtAa7iSpd17qP3DKC
	 bdY7OSOxwDM8CTfQMQ2WHve0Jw6mhjSYwmYkhn5eGbSj40eSVmwFlBmQR8xf810tXXMDs
	 CvB6Nm48NTb1Xx6o0KxBZSU6kkC9crr9zJDLcYQefT+045Ffp1Lna8zxxPR3CL1vB1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=TvQA4Pri;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7991E606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 20:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7991E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=TvQA4Pri
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so7878495a12.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 12:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793736052; x=1794340852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PwIPxynn/Ts+hRyBLxahwIuYBf8HIZ9im3ZAloF6OKU=;
        b=TvQA4PriTmn+nz4DaXS/V9tkl72XSKiTidZx9tK4/+l4YXO7Z6CJDGxU1X4jxIgZeC
         PPzjjCrW2dZ5+K78SwTMxcKOXaxQ+2ZIyL+3LtQcWWGMcyxt955QX4NFsjj9t7LTW3tj
         usr9957QCwSh2azAzuYVIY+Skh3Df/rPIj2X4Eo/Ht6tfmxeCBE2t0PHpTBhiaP0sGE2
         ixvjcR/xCJzJ7T4S7ClYyFkZtGn9Q3h1lOAvcHdlKJx8PyKfUdf+6lMJiCI68pVpnD68
         8DNX+KAErrKy9Z/NT4JGp4tfR3XVfWQcbfjGoBipTZR1C0xBprQasEUFHJ57KtGMSLtA
         bdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736052; x=1794340852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PwIPxynn/Ts+hRyBLxahwIuYBf8HIZ9im3ZAloF6OKU=;
        b=ziqVPp1Srdyi2Ac6vbWWk0qdNYSUfUaOWnKtalFl50gstk4o3hEFbYDBMNXr554OmJ
         iHRyGFzKINkSReIXF+Degt0uetsXNRyWIvcjJ0oIsGWEpskoABtLrVgJHp1p9AzwvwkA
         INwAY+wC/OmXtRgld9v8jZbf/2wTvlLv/UJbMDNRJwCVuVxpuSNywi0a2Dhm9jX3/hc8
         brkMDjh2QuwmDhz3X0OYhtKtSh5kr2OFUuGDA5c2oORxqIBgJLMe4vsjBk5q0+0f9Gaz
         RcuPdl/fVstREP5LvdekDrD1GkDSij6KC8RmyKQFmaItgB2ekUWGAw4e/pySN+XlRsU9
         1jfw==
X-Gm-Message-State: APuU4Z/+Fb2wo/7yBoVmzDslsNJyIbRmPsf/BAbMFllyCELgrMxzixCc
	dITLCiHAmQNG7C4LrR4HroGYOri6iBeJLMf+V9v/itAOC+HExMDuTu2xrbE6a4E/7rP5ZFMiXun
	LMWWIzBA=
X-Gm-Gg: AYBFou2UjPEokRZwzJvVeh1rx1RfIsod0j0HziuBEK9OWHOcRXtNHw0CKHCAdUZx4QB
	WnC0Y7u8wU2DUkJLCZ98yE5+grJ5gp/g+nyZclA1Gk12ZZE+3M4X75iIBFu9FCJCUTNYhz/KjdA
	0DOjx/hN0BrQwGsPxZASj6OudtD+oW+cB+frmpmUqfk1Db6Ac41TPUwFQsvrp7ih/GtPROrUoNx
	9RpXtFI0FV0wVhiCAjK9HlmP6bB/OFWjf/xlp+8KowtjKmYblaK2o5VuKcOOUUHoG+EfwYOzr37
	G0ujsAOW3Nio/jlbBkaQrBjtdibGmzPg8hEzONbXPOT9gXxOiRQvnbLURa96Em4NoMy17ZFPy6Z
	ZK9vP2K2GiSp0tkFSNaAZa9tMIUiCv8+kBdTV44zJ5W+Tm/D8qlEB4FCvqpJGF5ztBfHL+QICSU
	0GF1YRdOSKXXYToJQ8NnOcwuO5JYwwkKwG6iqpxWSIJt/IwBeMwKAnfpfDCuLDOSGn6Q8CKYP2X
	NMDWqxMVH1OWe071mCTiMfQALTM2r+5SB651eFJ6AaHR6qGo4ynAV1Q9EMx3HxMzGeYGQj0w+dM
	YzbXMNVl+XADefCzxYuSXn42a++dQytOEiHZ4W6fkIa6iAA=
X-Received: by 2002:a05:6402:1d51:b0:6ab:7700:9371 with SMTP id 4fb4d7f45d1cf-6b4d468b63cmr9974496a12.25.1793736051901;
        Tue, 03 Nov 2026 12:00:51 -0800 (PST)
Received: from D90XRJJJNQ ([2a09:bac6:37af:1e5a::306:a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4ec91e2f2sm4499801a12.0.2026.11.03.12.00.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 12:00:51 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net 0/2] net: fix mac_len of skbs copied by generic XDP
Date: Tue,  3 Nov 2026 20:00:35 +0000
Message-ID: <20261103200036.65764-2-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.55.0
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

Generic XDP copies the skb before it runs a program with frags support.
The copy happens when the skb is cloned, nonlinear, or has less than 256
bytes of headroom. skb_pp_cow_data() makes the copy, but it does not
copy mac_len. After XDP, the skb has mac_len 0.

Two places after generic XDP move skb->data by mac_len:
- On XDP_REDIRECT to a cpumap, cpu_map_generic_redirect() pulls mac_len
  bytes, the length of the Ethernet header. Then it queues the skb to
  the target CPU. With mac_len 0, the IP layer on that CPU sees the
  Ethernet header and drops the packet.
- On XDP_PASS, the skb can go on to tc ingress with a BPF program
  attached (tcx, cls_bpf or act_bpf). Before it runs the program, tc
  pushes mac_len bytes, the length of the Ethernet header. With
  mac_len 0, skb->data stays at the IP header. Therefore, the program
  reads the IP header as the Ethernet header.

Patch 1 copies mac_len in skb_pp_cow_data(). Patch 2 adds a test to
drivers/net/ping.py. The test redirects packets to a cpumap in generic
XDP. On netdevsim, the test fails without patch 1.

---
Copying mac_len in __copy_skb_header() would cover every caller. But it
would also change skb_copy(), pskb_copy() and skb_copy_expand().
Commit 6001896f0098 ("bpf: Run generic devmap egress prog on private
skb") hit a similar problem. It copies mac_len right after skb_copy() in
dev_map_generic_redirect() [1]. We followed that approach.

The bug can be reproduced on veth, virtio_net and netdevsim. The fix was
tested on all three. Native XDP is not affected.

[1] https://lore.kernel.org/all/CABFUUZFQXxYVdi_QqhGG8WTTf=F1BqOmroYj50mv0w70Acf5Bw@mail.gmail.com/

Tianyi Gao (2):
  net: fix mac_len of skbs copied by generic XDP
  selftests: drv-net: ping: test generic XDP redirect to cpumap

 net/core/skbuff.c                             |  1 +
 tools/testing/selftests/drivers/net/ping.py   | 27 ++++++++++++++++---
 .../selftests/net/lib/xdp_cpumap.bpf.c        | 19 +++++++++++++
 3 files changed, 44 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib/xdp_cpumap.bpf.c


base-commit: 647b81ddefc6364290e67bf33c89d54971f8995e
-- 
2.55.0

