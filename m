Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9A2248A5
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791161402; cv=none; b=TV0W40WvyVB6RkAilfFJx/jccQRdlcpQolCT+qzWIu6YXCWKJR4NJ1vkYhgaIvw3s9UtakfhMa9qY+jdCghkE4Y3QDnMm2YkgXXXrOwLs+TRAgrUi/gcI7yXwYWMx4Aj5A/ceKQyHgKSjCikQ/4+m+M1b30+x8UWOH2BLevp62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791161402; c=relaxed/simple;
	bh=5U3p3n9SoGNIsKvYk03MtXQZiesnM0GoAl4ZZQ/BtH0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QmfAwo/j8b21kW+bSMRO7osGl2Zl+yokAprmFtdViNkR80Oi1ivkfrk5cqMdhw8gQWIeFG0Q5KIGtY8KSItvz5mDd34wanOfRmB8nBmfvz2wWuJPqlok1v+g9i8/OG+vSq8wnGkaz3H/pTt/fnD4+cXZ+RLqPh93uo61RNxPOt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SjskruFO; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SjskruFO"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3510d0baf63so2532573eec.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 17:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791161399; x=1791766199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E/DnWa3scR3tfCHHHs5UWOIbpkLR2JqKiP9EY3L/XAM=;
        b=SjskruFOEXQ/8o7Z7x3OrNonJPIwc2W4sphrU1FydLF6nDJ20S0Ssg4NsGd/kcXqiv
         9TXc+B4Hviabo7F25nkX6w9N+sNGSsTUKO2wrlac/dNtK1orZ28a+PXrlSkMIjXmXfdU
         K37io+6Hf47sDl6UtwCtiL+9BO6jRSgpY3fs7Kit1TU1zLtkzF5+I7CtHViGNo8NJbzo
         r6gDN6U5EouP3wcWkNePMSRAMaGv4BCSk3lEO/JKBi9JHwZ5kqjtRa292nULy+YaazRM
         uPTm8pk8lfjdMQwpWp6ALqBwb5Tg9A2wZI2EcOxGIVDCJ9hHs6GzWCABrqLgN0apnVnw
         +dFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791161399; x=1791766199;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E/DnWa3scR3tfCHHHs5UWOIbpkLR2JqKiP9EY3L/XAM=;
        b=ygzgXKlYpVizDxJ4flalrvYcwIxpiD/HdxMrhZ6t+twLUc9LnkTyJ+HEc+iu6s6ufe
         Su1jCMBA82Imx1zG4ZFcuwojkMiZi2rTJZflNRTv0mzfhiDxSU6lIHMpKhu2Vy+8i8PV
         jTeoQN7Nrel24HRshfhob44F/W0izbYExLzzzc/LgE4wajvCIQXe1s603gCj50hjFdyY
         V0u+BVtQiWyN3l3wmSkCc8ovZdnpvKLvTnEn094+Hb47P5PO6Tnel7jsyxYlzOeUu94z
         FnOc9QnqxQ5eDWWj99GVFYt54HgYAYuhHZQ1H6hl3l34n9avKrnA2FG/se3MApAvZwEu
         o7GA==
X-Gm-Message-State: AFuF++kNFg2EXj6R6PrfecwawapAEB0p4NZbIyZN7O7CeRwLoiCdKdX8
	czk9odRdFBDr0rLQnneU8WEA2+MQnhm1lw2R4tg6VKECuNh//DsJuKIUZdh4JFJBDXQoKAVWraA
	t1vwGkGywrAP1cbFD6b+/FCpYSEByuHmdDxGt+Q2WDgXi+k1Dy0CE+Qvp5cACKp3Q7VKpV5+UsD
	v1bpqQC8ahgrB3YzsLewINSqvcx1H5Lv4+jGH7Q7YYHJFYlas5Uv6ybfALR654b5Y=
X-Received: from dlbep7.prod.google.com ([2002:a05:7022:1087:b0:149:5660:627e])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:4302:b0:149:7f69:a3ad with SMTP id a92af1059eb24-151c2d0b416mr6487824c88.13.1791161398925;
 Sun, 04 Oct 2026 17:49:58 -0700 (PDT)
Date: Mon,  5 Oct 2026 00:49:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005004958.3603059-1-almasrymina@google.com>
Subject: [PATCH net-next v1 0/2] net: netmem: document design principles and
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

Mina Almasry (2):
  net: netmem: document netmem and memory provider design in comments
  docs: netmem: document netmem and memory provider design principles

 Documentation/networking/netmem.rst     | 46 +++++++++++++++++++++++++
 include/linux/skbuff.h                  |  4 +++
 include/net/netmem.h                    | 29 ++++++++++------
 include/net/page_pool/helpers.h         | 18 +++++++---
 include/net/page_pool/memory_provider.h |  8 +++++
 include/net/page_pool/types.h           |  6 ++--
 net/core/skbuff.c                       |  3 ++
 7 files changed, 96 insertions(+), 18 deletions(-)


base-commit: cfb7793d1bc0f7d90571611979654cf1b3886b29
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

