Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD2B3148DA
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791426635; cv=none; b=FZl4Y8baMb7iTifKbBl/ZXP0h0kP0LEs0dhiA4RkG1YxDxa/CC2w3USJo+YTVyw9dk4FJeUeyZPr6YdS242t8+OK9wlGkgZKB3QgQ/KjbZjVuqAIjPnxl+0RTrhtqA07KyMOhGsFOeTgEfU4BN6yBo2y9SSy10OMXJV7Y8zhoPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791426635; c=relaxed/simple;
	bh=gwMGACdt17UUD4RyRUfeulQjcf9omLigre3rKSEoO84=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h8cTTpit+09Ra+VJPQQWLKo2cmaMhl4VZZ+nNCLPg78Ldn0YOK5E21o9xrsOOvUuwfjxCPRxWP0RIIaIv3vt+oESWTydfbmhWr4C3IkpbLrKoLxbYhMDYyYoa08UcEk6brdVg+gCxD1dnOdUQgBq/WREP+IsDjDgToZIcBu3gpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OmhS7XDp; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmhS7XDp"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3515d2fc5ebso5543886eec.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 19:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791426632; x=1792031432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sSq1DuZtI9E8c53+ZPTIUZgtVgIH1S08MWXDUuZ/wmo=;
        b=OmhS7XDp3n+7C0HhdxuY4fB8xLxwoAooq5EnvTQdkk46wf8YlNoDAHmCXzweMLIBUk
         mAp/+jkVHeig3f6LYeFqAB4+ENLSnphFvwUavAcbaWLfqn4qO9qzHpNPGOTL8Pmg02Wq
         hjNNyA/r5uLrofSbgZsqG+Uq/1E5gi86EcVSjWPaiov6/SBjkyawz4xs1Si1Rr6v9jsg
         MNBn3PWUVsnVMXZnxrIKhzCt/qSWZ/orucP9aYpx58o9r9tFQ98XH+ckACJ6gt6hMyQj
         3Tb/dRb3hKbYHPWESt8e4mmhWnFmBs+LCffNJykA/zb3IfdxfCQNkL1IL/W+Vip1Gtus
         n3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791426632; x=1792031432;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sSq1DuZtI9E8c53+ZPTIUZgtVgIH1S08MWXDUuZ/wmo=;
        b=HAjVxiX4qBwwvvkDWQjpcdUXjtlz1KPRlduFGv7kQ1wZU1z+la0F4V7FgfN23LEtPf
         BF/WZA41hp37aJWVGQ+kcK4W+noEjSztR9iiZ5EhEbkGa4Fe0/JDtH/deFTXiyMufeus
         XUoM2ilI3SXduddE5sOvaqf5f8DZhjbxDUkBqpEAhVXvfxrPhR3QHXix+EvgjRZyntzs
         p8LouhWB91UUcCYJaOJOfVEZxaMHG6kAvdxfkzEgcPHbKL3d7NkHQX/kKbuti9+5va1C
         heESZvkmCo7wIgdLaKkS5PSCKJqG5P2Ydkgpu31tR+dVQdVcYn9vAPvVdZO6gAasLZz7
         nacA==
X-Gm-Message-State: AFuF++l9d6XLeMrTzrJ8jvfjGOPFuYAnTuLjQTixrkOQjJwq/khwIf//
	33jTGgw1HqS1stcPzq3gOHPr+GowbPEL8y/HWRjZLDPhYbxpWQt9drZP9KASJZnKPGB6iIrOd9G
	6w9j4y2DEsAtvF20zx5OL72QdyzWNLVAmDC46c1e3MxwNsuk1RDn7ebeqRYjV2ox9cnQ43tNCho
	OcC0uwuSs4eSkpNpqWv3JXLXKQaRpIucBganpJNjX9QiEuov23AVEAoL88DntgF0c=
X-Received: from dycpw4.prod.google.com ([2002:a05:7300:de44:b0:34e:c69a:3070])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:6082:b0:351:28d9:4908 with SMTP id 5a478bee46e88-3515d719383mr5337829eec.0.1791426631196;
 Wed, 07 Oct 2026 19:30:31 -0700 (PDT)
Date: Thu,  8 Oct 2026 02:30:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008023030.1089616-1-almasrymina@google.com>
Subject: [PATCH net-next v2 0/2] net: netmem: document design principles and
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

 Documentation/networking/netmem.rst     | 52 +++++++++++++++++++++++++
 include/linux/skbuff.h                  |  4 ++
 include/net/netmem.h                    | 30 +++++++++-----
 include/net/page_pool/helpers.h         | 18 ++++++---
 include/net/page_pool/memory_provider.h | 10 +++++
 include/net/page_pool/types.h           |  6 +--
 net/core/skbuff.c                       |  3 ++
 7 files changed, 105 insertions(+), 18 deletions(-)


base-commit: 8df0638138d3e0344fd1fb36cf2d1ca1cf5028f0
--=20
2.56.0.385.gd3acb90ef8-goog

