Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C722F3C18
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642306; cv=none; b=SFa0EoSwIys+S3daspGmcQxvBVVNRiQoWXeSdkBN5rHr+qMY0mGlM1tdHbFqta1rV+tdl8mCH3nTaQjQCFg2G4RMNpWnyaxJifbKssZLMnKHbZNeDlhzzbNQLQjing/7XVsTtMkTY2L7O0QNOmSCdFO0t5+/JoQgATkfIGrhvg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642306; c=relaxed/simple;
	bh=PX2mRjRcZ6SKnMiqIW3z5oZL9FVYrWm7HbB1K3LDT+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJhCgx5Dbl3pBdlx/hlSlm8yoMWvJg6BcWA9LDHr4tvzuiAJAu6ebg6wlGJlVyI4rG34kWKr8E4r9tphQjPnybY13hxitVKjaHMfViTY7E1sX0cPDzjYUbHvkkffLaC+l7Lfu9LuFGlFkrVdR0v7H0hDv3J52ARlTMVPe61p4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bt6S+uXz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bt6S+uXz"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38759bcd877so126960a91.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786642303; x=1787247103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GIDNbht2xN43TSM9aB32QdRabnlhTJtOheOWQcIxtKg=;
        b=Bt6S+uXz/8DY8PbfppQ8Dax56mWVq+TTUrNEO5AzXX5QgrAKibKqAH9g9yomB4YEUv
         Bum4WZyapagRoI4nLecgE7P2VqyaQSeyDXmYEBcuK7AmNQ5SEeCBo96H+Ghc+7WYsrrm
         kIy6G3PuY+QRE6mcYHKfQhH6odWnUD1EJcXzOeLRIQIaVMYwBwt6/tQcmxT111y02kHZ
         gCI8fgw7tc6K3/0EV/wTEkpzEb4hAGpODaJwgaOyXSoLpDciNQvhX4oAXtaA8NMErkmD
         GexQJdQ/RoRasQDLgyxFz68ZEBBHxtC3xnplIMdXlRzwqSZsNCv8vMcgirs+IRfaGgf0
         5nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786642303; x=1787247103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GIDNbht2xN43TSM9aB32QdRabnlhTJtOheOWQcIxtKg=;
        b=piwkIeDZkaWpoTFK34L1FFuLv2ltVmrKdjxLsNqUYI4PXe4XdlbuoruJGCNVY6DqJ5
         2UMHz6+GzwqtMlREL3zHBOOURjCg64YHCcpO1CkdKR0MJfzP/GwB55yCeJn1/oLtLAsY
         PK2xN6EUB1saQZsYwuH+o99h8L9IZ3pQCvSR3kqkialslKzk6Xu+QRRffCHanRTvxgHj
         UAMDJQ2cjMPrDsfkzocUjNuM3+lgtLYwpON2bKW6sn03/7SgF0l5IQwibsrMiiN6+3sC
         lSJ+KVkTRG7cfdlUMCXENoE/iwRmA4z+6ATNBXTodTvGfKBeKtbIYeNUba/WcGRbPo20
         FtmA==
X-Forwarded-Encrypted: i=1; AHgh+RownqfA2ngL6nid2wrEC5/0uw3pGEkbQuhmQJWyt3Wb7aDcHIMCnXgbtMlmZjYpi9zpAspA2qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7MdzOK5CQI8Xt4HH3AmVFI5ic4g53eBEY+QMX7WQyJRX8jsX4
	FrbbZkcXA6CqmBrlGB5TY9FFnBdDu1feDZYN19fnOFV8+YkE7r3I1jxK
X-Gm-Gg: AR+sD12mxeLI20geBMEYw5Jt8gfqpIa5biINcqz2r7JkKPdf3tIbGNE2CLxJpNkxPIF
	83t9vXbrK8j09aJ4Ft47ifuYiXjZ358RwMJGjTB4WOsGs4fQogKcsJ3WqkMLuUK+Z9IcfXaTuBg
	NJWxFO3rb96RE7pPj57Rjy1nMop8InJRVzkTywphbQ2kJhZswcoWGdLDIsRAIiAqiZ9kWHwkeIV
	95R4ky4k3E1eo0w3935c0wITwOm1UFO9WbD5lHsj/7gcalU6rvNKxkMKM+hJDMNRN7plBgdE2q0
	nWK5QhlqOboGgaG9A+j8oFblqPfRwYOq5rNvRFICrVNMbb0EfNdLVACRcQoEdHWWKvzIa9bV7+O
	Td5War5SirBA/W/s/n2/npY48Hqh7ISKOg4KZwgYrXRpB+RtZgmexQPiD1znS9JgoV6dBoQSDJd
	NdcooXWP7/ER+qiXUQGmhbWmUL/wf3/kV0BAKYa6SP/XaC/QTw/Mk1/v2zJnJZEA==
X-Received: by 2002:a17:90b:540c:b0:390:b41a:b92f with SMTP id 98e67ed59e1d1-3931e31bd38mr8495099a91.18.1786642303201;
        Thu, 13 Aug 2026 10:31:43 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebc75d8casm10961169eec.3.2026.08.13.10.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:31:42 -0700 (PDT)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dmitry Torokhov <dtor@vmware.com>,
	Andy King <acking@vmware.com>,
	George Zhang <georgezhang@vmware.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3]  vsock: fix stale sk_err handling after a failed connect
Date: Fri, 14 Aug 2026 01:30:17 +0800
Message-ID: <20260813173024.2362935-1-phind.uet@gmail.com>
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
Changes in v6:
- Reorder if/else in vsock_accept() to put the smaller block first.
- Add historical context to patch 2
v5: https://lore.kernel.org/netdev/20260810170935.2242314-1-phind.uet@gmail.com/
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

