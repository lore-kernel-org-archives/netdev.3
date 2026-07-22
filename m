Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9453635C687
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758601; cv=none; b=LfJFKgXcjn6TwzRT7g2AUSHewMiEoUf+lhxVMdqrqmW3k1cnk34Z+F9SpUPHXjmUsa+5p2lvqASd4tmWVFN9vDM7Z9l9jZASI1T9Fz8v/Gb+ud96395xajTyS+zEwCDXDKKH2LvyJQ3WvyMnCf1Sn96gS5rYGzF7dFfVff3v8fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758601; c=relaxed/simple;
	bh=1Us5xGkBAJXwBwExy8cfS9g65Z2dRyMfwJTU8OTSbAA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CTul2dMFWCX0rq2GxWYK0QoLXgLRZOXLNVMA5yH6HB2SCLhNbuIjdsTRCnQB/8mlStKGWIhgqGFzA68BzL4K2nO5hW8b3RTdSrebRdi1wkriAaqG8f2HzyMSRYUoDUH81ZTvbTPLlBQPwgXcPj0vM/cP3HQUwNjIdg0nfI304Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=korRYhqx; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="korRYhqx"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e01a62d99so3225657b3a.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 15:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784758599; x=1785363399; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NxbTcxXwuujoRQit/eAYaWnsgYP73zQK/sdfkRV8/Tw=;
        b=korRYhqxMmosDuRgMl2dQ+tYcEXhRdWeh8KOxAp0vW8+NHjdSt1312LxcEWIwae+vM
         uN8bx/5fztGqQKNaKevYJ26qeFcoLsNGNAJC6kKaQnBk0deGFyHP+aPWMBg+t7gJ+wCA
         2YVq9CF4uc4UvpnrE1M8Uf2tqjGjmSGVt+HAgudl9qO/wiT7V2P/C/+B+HmS41bYakLH
         g7tJ/Tajb4aWD1BgRHk4bzrIMPNeSqVznetArH2eRKEH84+eOD838xmbE1GMGATr9ACJ
         7+mpVyX83Fsa5ZQ1HfveSZ64eAiw/YTnijgsM0H7rZnSWxoPqTvy8P3eV3e0jA07zJ2h
         lPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784758599; x=1785363399;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NxbTcxXwuujoRQit/eAYaWnsgYP73zQK/sdfkRV8/Tw=;
        b=XyRcWjS2VS+bWTnZU+NqIPuu14igqQMgPxMM+Q+ZNnC32ER3gev7n0vm9fcn3+19Xb
         wAR+Uin/x2l52oJvXws4ZhWscB5bMyGJBp/CwVITjhnw1w6NwByut+6ZmfOwuPiPBT7r
         WidOWBiOh2ZB1gH/Y3dHaEvKqArMd6YAFnXQN3Yi8Jc+/1alsEd6GX2UzHIrYE9kPkrp
         T8reDpvc53iK8xc2Xz40J10m788BbRYaowDIXGiZLfaL5pB2Ct4h1A6nWtSaAy3h1Dwl
         RHRbo4/KPlV241dLacaxEc6gbiQeiFB2VjaQ1euPM1MDjKWG666L1fWNaZibJUgM6Lm9
         GVuw==
X-Gm-Message-State: AOJu0YxMJC+/N1K1MZeQYNR/XG491m7rKYLOq69evDHd0X2vljMhTudT
	1GY/Z1CaHlBN9I5+G7/nnNNXx5Q+n1TFNLzgHoXcfCJIUD6CfRRt6ld0NBLuS9q2TOS0TqHbERt
	SJoMVnRIwKWkdLy0KShsEakB0XlqfGVNpNbQV8KlUqqRqYINlQNS8frJX0/M+jevpAfmnDVwmzj
	BuCmnS28Ore9ZBTpLqD3lShp1F5iTtXADdiNm46cxOy44p5IE=
X-Received: from pfem19.prod.google.com ([2002:a05:6a00:c093:b0:84e:101:e491])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3cd6:b0:848:8619:c149 with SMTP id d2e1a72fcca58-84e2bbe8355mr790924b3a.2.1784758598470;
 Wed, 22 Jul 2026 15:16:38 -0700 (PDT)
Date: Wed, 22 Jul 2026 15:16:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722221634.186886-1-joshwash@google.com>
Subject: [PATCH net-next v3 0/2] XDP metadata support for DQ RDA
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jordan Rhee <jordanrhee@google.com>, 
	Tim Hostetler <thostet@google.com>, Ankit Garg <nktgrg@google.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This small series enables XDP metadata support in DQ RDA mode. While
space is reserved in the headroom for metadata and the DQ queue format
supports the xmo_rx_timestamp metadata operation, support for adjusting
the metadata and passing metadata along to SKBs was not actually
implemented.

v3:
  - Make use of xdp_build_skb methods to implicitly pass on metadata
    when constructing SKBs from XDP buffs.
  - v2: https://lore.kernel.org/netdev/20260318192450.3400774-1-joshwash@google.com/
v2:
  - Fix referenced commit hash
  - v1: https://lore.kernel.org/netdev/20260316230434.1398828-1-joshwash@google.com/

Joshua Washington (2):
  gve: use xdp_build_skb methods for XDP_PASS case
  gve: add XDP metadata support for DQ RDA

 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.55.0.229.g6434b31f56-goog

