Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F7411A07
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381844; cv=none; b=sbbFW4qGXBnfEMmTc5fcUFS+0xItaDsV/xWN6sz+a0DlpuwYBZHZHuOqWfczBPR66StkvH6AVKKtj+9Cg4qTpenpjH4IWCsCFL1u6h7m+YIOLah1uX1ba9+xMua+dZ+XNZs2b4S33buCXoM38IFHhFWk1sCPEUT6J88oTY+GKOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381844; c=relaxed/simple;
	bh=u/03OJopUWpYIZLPOmNno1ZcdLO9Vd/Dsn+H/2t7RQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nQy9WEb/0aIuMsSvoM3qZe2tD0+m5bddErHdXl7wbU+7I5DdSvUgGRr3nOXQsODgVoPJyxY8eUPCui/0G/swodUTIEy7d+67cciqRaApgvd1IzQMf4CCzspwGlLazvkt1c/uMlMPcT9TxdKKOJfQ+fW5/8HVRFUTFcRXgK///5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6S4imYx; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6S4imYx"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca88130e09aso1505853a12.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786381842; x=1786986642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YwnNatVO8vJ44aB8viIABkdP11ZOZYuCLz8W0eTqLj8=;
        b=q6S4imYxecYXPy0FJL4W3KSm+8av5+fn0PVSFfVyzYCVJmwTzBYw4G5/wDwoWzb1ih
         itCau3a3cXtEF3ZY5tumQ4Newo+el8aoBZRcx4RhjH7RjBu2yS95BN2jprLL33s4B/1p
         GvyDxKXRekVMA3ZduVtM1Zv+WOC60HzxqCRxhTOuBgAC06TH748ES684lyA2hTPt3d+h
         7UvoUfY8XfXZIOpYCWZbkuo1L+Mg/kiEN8blBdnDzmdXIP7odARNIVBlgSP+EJdBPAc1
         MnXDeevSmmxaim5RUbn9KksqeI8tB0hSOEjfrkiWD44WqriolUptR98CG+nKAbQ+Puxb
         DgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786381842; x=1786986642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YwnNatVO8vJ44aB8viIABkdP11ZOZYuCLz8W0eTqLj8=;
        b=f0OLK5PkEJcZh47PhRAkwYdGjQsest0Qg2+Y6JelUuCw7qaqNWLNgnx7llqpy9bCCb
         SUbG8ffoYyoUyBJBWuUFP2q6gWGwDfmfXuEMSe/to2m1sciWHTj/Alr9fkJShJhLu/Rt
         bE529t8BMwOfgYnbh6ttbGVB0A+v7Q1+0fQvaIEIAMrQBRj/9mfwzavxZ4oHXiv0Os9u
         UZVvUef0VPuqy2PnZaDlrUvGdr4KUXthJ/j1mTV3K5Gk0L+Kvm6v0r3Uof7nuvQ2c0eL
         rzlqpiU1RaspMmMlK1VqZW7GO+yaPCV3aXD3DAqrg1czQ9i1g3limow8LUhEYB0V66II
         /llg==
X-Forwarded-Encrypted: i=1; AHgh+Rqg5NU1sLHkET3oNcE2tGpYL+YpnlI4x/6ePHgu6C1fNmACDwwbxhPitrMVKFimDmWkySmcWkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbxYDJnXQXqpX4dPqsI7Y/dod4dZ/VNnAkOhQwtTtC+kBZE2QN
	x0vW4+NLdFTl5XKm9GSaoKsRZxrmXzxmfLHGYSvXcx7orUk45e0J8u0M
X-Gm-Gg: AR+sD138ekNmXtBfTM/DdddNi7ZB8ZcOW7H3TSKziq/IuvPpWQp8IzCymD18boUZO+7
	yC5g9tolE1ArTD39/O5O2KVi7eumVggJ61jnkBskz3MXxEXiLRuLM3W1qlutpo+Rx2u2abGIOqO
	1um2zJDahG56FiqHVviuruMsj1MTwHsyL9ljdII4VvRgqRHqLkDhiCEeptxKpfqXvbgWP5jCq6P
	iwBz2ueQzlnJv4kyyiskKBoucNMoQQZS/ZD1YrLl6iZpy1GQsD/VkEXjshgUR6EHJalSyL0H9u2
	SGnx+IZ8dcAUEQbATvKem+GsK8AH0zd29r10HndOjArg9i354MMQ+I13usUK4atxhHoQfmk1VEO
	RyutlPzjPJkOw7WhPyMOH6an2f0518TaGS7cfg/EnM8ewaOKrQhMGOZF/q/gU2vBjiF7jVFrxxc
	pvk8db3qlZVrhDof2nLrMEcE666e3lF42N2GbyuQCEQznkuK8UqA1/t2sQ8QA02A==
X-Received: by 2002:a05:6a20:6a05:b0:3c4:3112:3b with SMTP id adf61e73a8af0-3cb85e771acmr47912530637.18.1786381842462;
        Mon, 10 Aug 2026 10:10:42 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1410199cf49sm37194663c88.3.2026.08.10.10.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 10:10:41 -0700 (PDT)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andy King <acking@vmware.com>,
	Dmitry Torokhov <dtor@vmware.com>,
	George Zhang <georgezhang@vmware.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3]  vsock: fix stale sk_err handling after a failed connect
Date: Tue, 11 Aug 2026 01:09:29 +0800
Message-ID: <20260810170935.2242314-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A socket whose connect() failed keeps sk_err set. If that socket is
later reused as a listener, vsock_accept() rejects an unrelated
incoming connection, and on virtio/hyperv the resulting child socket
is leaked.

Patch 1 removes the listener's sk_err check from vsock_accept(), since
no vsock transport ever sets sk_err on a TCP_LISTEN socket. This will
fix what the syzbot reported.

Patch 2 removes vsock_sock.rejected, now unreachable after patch 1.

Patch 3 is a related but separate fix: vsock_connect() now consumes
sk_err via sock_error() once it has been returned to userspace, so a
failed blocking connect() doesn't keep reporting the same error a
second time.

---
Changes in v5:
- Split into a series
- Remove the now-unused rejected flag from vsock_sock
v4: https://lore.kernel.org/netdev/20260804135238.386417-1-phind.uet@gmail.com/
- Remove sk_err checks from vsock_accept()
v3: https://lore.kernel.org/netdev/20260730081843.287563-1-phind.uet@gmail.com/
- Fix truncated title and add annotations to reproducer steps.
v2: https://lore.kernel.org/netdev/20260727071305.45826-1-phind.uet@gmail.com/
- Add reproducer steps to commit message.
v1: https://lore.kernel.org/netdev/20260719220103.684489-1-phind.uet@gmail.com/

Nguyen Dinh Phi (3):
  vsock: don't check the listener's sk_err in vsock_accept()
  vsock: remove the now-unused rejected flag
  vsock: use sock_error() to consume sk_err after a failed connect

 include/net/af_vsock.h   |  5 +---
 net/vmw_vsock/af_vsock.c | 62 +++++++++++++---------------------------
 2 files changed, 21 insertions(+), 46 deletions(-)

-- 
2.53.0

