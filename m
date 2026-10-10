Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F7437DAA9
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791603393; cv=none; b=jZwfFFRawCY80PZ+blx31wRxAEmyIuQbIsZeXmf3D+gHE+tYpcd0FnIrkNsAV/LccE2Xq/ljnpOQ/E5e9X62CX465lV+vVHadJz59T5pG/BIQ1J1HKkvSfpDqeYLRhC5nqvOx6SJ35b9WiVao/mWhMjgRQMEDapk0kTntspTZmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791603393; c=relaxed/simple;
	bh=70YgM1Mt4Z5YsyjAZUstuPenINMCxDg+GnCsfmv86Gg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O+nzwMzJKH91mn5kuO2I4fLIlzzRPxIf07EduOPXX7y2KNTb4AIxzmzQhkcuzXwvgcTQYeBV6uhsPGuh28vpzmdYpnfLT0CuvZjOVueZ39qFWDSgkJIt7s2pnwNlc+3bopy0rn/Vy2apt5Y3/441yEkEMaokYL7apk1SgQYRpxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvnisGYQ; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvnisGYQ"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-147be78cd56so1409356c88.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 20:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791603392; x=1792208192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FN3jzVFTvR1bxiOc6QpulyJ81OKLo+adR8/+V0xSoVo=;
        b=dvnisGYQQDcD8L1ZZv5AfQx1JnQvKicEPFUpJXia7M6AGhKtiXVM6h3Wtl4FI91clX
         3jFGz91cUCXnkdyQAE4jOOiOUMUBPkrzlQ9LFjRHQDxn85db8YfBp0LIHHb4GzJXOBHe
         woVo7NSjUJz4ktoipH/gve2GX65em5Gscpy4qjvSzWMpDmgcTeo0jeOX88bONGujJZui
         3NnsxlSJg5CHpgOMpqb527cdc4HvCKNYufZcnfOIJMrO+DrOGf08K/R53XcFBRYGTFOa
         uQSgdf3m8UVwHSp9jQuuwR2hpcxX6H0uL6LvSHoSswZDpbScogXK/6tswotDC6IBQj12
         2l7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791603392; x=1792208192;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FN3jzVFTvR1bxiOc6QpulyJ81OKLo+adR8/+V0xSoVo=;
        b=CfGZb4CDBbhtg5/M1ewjkhWKwdohxEqNQSJq55Fu2NVhO5kR0h09m3pFroRf27oLmd
         8x54PFMMlJUkqWngGs8ibaXvu/CRL5xv+8/20H9sRj+Y44AdbLQRl3YnwHIjaDdoNaB+
         +ihWz2qrK6FHIto4ooNSzdW09KBbsblDKfmRd7v3YMs4eRkbFoTst+9wwkZ8RWXmok0x
         W7ye6KOaUbog26t4KKXAmL17zQo6EMkIsTsSIdGczZmh3MXGQiHNxFfcayXgxk0Us+8U
         v+1kznCk4ETPzUVleeXpvlkt7tGjRfkWnCGOUeyGKgAMR6VjX+gnNuXJt7M3R3uHZv39
         jHNg==
X-Gm-Message-State: AFq9FYKCttYyUuYPLW3K4MYUgXLqn1PEb/g4rghz+4I/g6YamXvy4nwN
	kXrkLogLl3fyKitOQsUaB2stVi/LkeK4ff9+yVPKDsrTP0oi3voJ7DYXpl+l7I1Bw9PgjsZrrkn
	7qwR0VMtf21tY0eD1wvhTrON15ipDgyCkwsHNNjBHOoJ8vcdkNxf/cF4w+WTkUzuYbBzFhviIti
	n6sIHUbtk3oPulUQeC/vmKAKPERWnvrX1A32qA+/+SbpTDamH5n5aJk6OcqZS42o4=
X-Received: from dlep17-n2.prod.google.com ([2002:a05:701b:4591:20b0:14a:c841:ce30])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:e11:b0:145:3a5:d918 with SMTP id a92af1059eb24-16a640fd0admr7318681c88.33.1791603391029;
 Fri, 09 Oct 2026 20:36:31 -0700 (PDT)
Date: Sat, 10 Oct 2026 03:36:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261010033630.1171692-1-almasrymina@google.com>
Subject: [PATCH net-next v3 0/2] net: netmem: document design principles and
 intended direction
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Luigi Rizzo <lrizzo@google.com>, "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Because the networking stack and drivers are only partially converted to
netmem_ref and current memory providers only supply unreadable net_iovs,
automated code review and analysis tools (such as LLMs) frequently infer
the wrong architectural invariants from existing code. Specifically,
they often assume that page_pool's struct page APIs are primary rather
than legacy wrappers, that memory providers always imply net_iov, that
net_iov is inherently unreadable, or that callers should branch on or
downcast netmem_ref directly.

Document the intended netmem, memory provider, page_pool, and skb
fragment design principles concisely in the relevant headers, code
comments, and netmem documentation so both developers and automated
tools follow the intended abstractions. This series adds comments and
documentation rather than performing a large refactor all at once, so
that future incremental changes nudge the codebase in the intended
direction.

This reflects my mental model of the netmem, page_pool, and memory
provider architecture; I welcome feedback and disagreements,
particularly from major contributors to page_pool and memory providers.

Cc: Luigi Rizzo <lrizzo@google.com>
Cc: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Pavel Begunkov <asml.silence@gmail.com>
---
v3:
- Collect Reviewed-by/Acked-by tags from Bj=C3=B6rn, Pavel, and Stanislav.
- Clarify skb fragment homogeneity rule: all frags in an skb must either
  be struct page-backed or belong to the same memory provider instance
  (Pavel Begunkov).
- Link to v2: https://lore.kernel.org/netdev/20261008023030.1089616-1-almas=
rymina@google.com/
v2:
- Document both current implementation status (memory providers currently
  supply net_iov, and net_iov is currently unreadable) and target design
  principles, and clarify that new code should generalize existing
  limitations as much as possible (Stanislav Fomichev).
- Link to v1: https://lore.kernel.org/netdev/20261005004958.3603059-1-almas=
rymina@google.com/

Mina Almasry (2):
  net: netmem: document netmem and memory provider design in comments
  docs: netmem: document netmem and memory provider design principles

 Documentation/networking/netmem.rst     | 53 +++++++++++++++++++++++++
 include/linux/skbuff.h                  |  6 +++
 include/net/netmem.h                    | 30 +++++++++-----
 include/net/page_pool/helpers.h         | 18 ++++++---
 include/net/page_pool/memory_provider.h | 10 +++++
 include/net/page_pool/types.h           |  6 +--
 net/core/skbuff.c                       |  4 ++
 7 files changed, 109 insertions(+), 18 deletions(-)


base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
--=20
2.56.0.385.gd3acb90ef8-goog

