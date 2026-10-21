Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547761;
	b=uIFyOTjD7BNZLTrHEtG7KC1xePzKx7p4ow0hVMy96Ahi+h1GviFSB3wrBU7gF83znM69
	 tf73w8UB+oP201bcT4t/S73ZBkrPBnwcHHooyX6gXzTt95/Npw+pEq5eHj5xBlsZvFUYp
	 ygMP+tPnKqIxGjtulbZee45bY15uvOT+cHGy7OkuxwE5RXzaNjX5ASSeV4ameSRq9cwpw
	 tFoEWarN5Vm43W6vit6yzg1xrP8Ln/PZ08Inr+cYsI05aiLbZvbmBotAiywTrowVs0Zw1
	 N63SnDF/cf6nRt8PfYAZ69o9qbc4yLe783OdSKL5XyC49oiG/v7cyyCFchefWxyyLFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=Y4b/p07AdLceqUapVIYWgI0P/ZEXX9X6CrBOWJ0OIWo=;
	b=xUfgU8NCEpoo61CD318ud8JR6MwnKRsDrH1iQ2eELgjsTi+ukJFVB+/a+ui54FKqY47J
	 Yyl5o5PGqxzVjqY9ORdVmCVaOX4KBN2JNOYECD3vOGDrdSTFXF666bhu5wtz6vYyFXTSi
	 P8DLBFAhZjkALsu/Ao47Txmn+0+A1PB2WAeVObIidWP9qjPNjBs6290sEsn/qPvVtnbBn
	 biR+jZwG/VKaBv7WxVzwUF/oD6WC+llu+QPbhJ/PgfmghWwA93hbFcl9zd4Gidr2IEkfa
	 MhUvm5xBg8z7QIwK1t0ztlfWeipnOIbybpP0gQWkW2qoSs8D9Bb91tuULiCHv0lDpYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bzzdT6r0;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE189606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 01:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE189606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bzzdT6r0
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so239275c88.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 18:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792547760; x=1793152560; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y4b/p07AdLceqUapVIYWgI0P/ZEXX9X6CrBOWJ0OIWo=;
        b=bzzdT6r0nA0mv9yT8Nyb331vATzCkzysQ651946LfUk46Ue5s6ultyJ9Ns77Q9ZZZb
         6Ckt/lsLdppiO55Fkk04q+LYNdn3zFKXiuYfjm7kLyIpDqkb45dEo6s4gKNcA434UoM1
         et7RKrTsxSmfm7H3I9pXuLknMX0YtmvAkk9YqOuFh2JzgB6sKCgduTNRdyrj2EMdnl3s
         rzgoGfPbCqRdha3SdGpkcvGArUsU5sADQuJsd4Gx1Dmcg+94ESbuT2p8K9q97MN6T+jC
         xTLgCPUPhd0gRLqXOKdtKmACq7laNoMYhm10z0SLZm++vAhFqgBcBGLkJjW70y0JEJ9n
         dzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792547760; x=1793152560;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y4b/p07AdLceqUapVIYWgI0P/ZEXX9X6CrBOWJ0OIWo=;
        b=gr5PenERsarNQw4YF7D4yA/Yp9cIotFhRcVmwur3E37CcF8ZtSugbwctAFxr3ADnDn
         LZjltn0Wnq+fWH7hD9sQxx9MXMGFcNn95KBTDFUvcBxn6+mKLzMeVAF9DvMPyEPh9XbP
         /v70sHJQEc3ZoevPot5jK3MiYAMCZxXBCjd2UGsX6aO3WuAGppibtTgKNdtl58JEW969
         B6Spxe2Mv/ghUR/FSTcL3Fi0cDxxSOQU42HOjznI7pPoOrYmHOZNR6QedmCu4jGkk7Pa
         rEN9gK0p7evmFzrvjXDs8KlOOttJqdufspuMOUHyTh9GhaK802xgOrVOC93TpfPUBbQX
         3q0A==
X-Gm-Message-State: AFq9FYJbu8m+m/5jrDt+GkhQ+oJYyx0M8CjJRA9LDEYOL48mwicsa7U6
	HCzGZLvVtqIPfeDG29uhPTnPhLIXiOgHFN2+PAznHKyy4RdQUBXeKTASv0dbGSG4sWdqlLWMKlA
	2wHWDAOdRK7XqR5aPoa+kjges7pwqCyp2+mn+v42jKhm9Ng2lwMWYRav5ZQD+XJJpufqHTq642N
	1CLUgsoG2qOFEWAQ0PT7GlEY6atbbcnvx+YlA7hDIp0vD7UpjYXdPi/Y68MzYL1v8=
X-Received: from dlai24.prod.google.com ([2002:a05:701b:2718:b0:17f:8a38:d873])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:4092:b0:18a:3911:ec1 with SMTP id a92af1059eb24-190a7ff8258mr658995c88.39.1792547759131;
 Tue, 20 Oct 2026 18:55:59 -0700 (PDT)
Date: Wed, 21 Oct 2026 01:55:56 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021015558.4124825-1-almasrymina@google.com>
Subject: [PATCH net-next v1 0/2] netmem: rename non-pp ref helpers to *_inc/dec_ref()
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Ralf Lici <ralf@mandelbit.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Pavel Begunkov <asml.silence@gmail.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Willem de Bruijn <willemb@google.com>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"

Rename the net_iov and netmem non-page_pool reference helpers from
get/put_net_iov(), net_devmem_get/put_net_iov(), and get/put_netmem() to
net_iov_inc/dec_ref(), net_devmem_net_iov_inc/dec_ref(), and
netmem_inc/dec_ref() to follow the object_action() naming convention.

Use *_inc_ref() and *_dec_ref() rather than netmem_ref() because
netmem_ref is already the typedef for the generic network memory handle.

Mina Almasry (2):
  netmem: rename get/put_net_iov() to net_iov_inc/dec_ref()
  netmem: rename get/put_netmem() to netmem_inc/dec_ref()

 drivers/net/veth.c            |  2 +-
 include/linux/skbuff_ref.h    |  8 ++++----
 include/net/netmem.h          | 24 ++++++++++++------------
 net/core/datagram.c           |  2 +-
 net/core/devmem.c             |  4 ++--
 net/core/devmem.h             | 10 +++++-----
 net/core/net_test.c           | 24 ++++++++++++------------
 net/core/skbuff.c             | 20 ++++++++++----------
 net/tls/tls_device.c          |  2 +-
 net/tls/tls_device_fallback.c |  2 +-
 10 files changed, 49 insertions(+), 49 deletions(-)


base-commit: 3c9d71edf50ad153e892ef887e54496286774544
-- 
2.56.0.212.g129ede20d9-goog

