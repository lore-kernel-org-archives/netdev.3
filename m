Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D1617D6
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 03:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702771; cv=none; b=b5TfBz3rfCfWNTx3ntfPsaTPHf42/zDLyc3/VYq1wE8c1viKruFU3ibrhD4eGw2F/t4jLoQVSfx5VJroocjYu5sraNCkLeSE7/OsatwFTTaCmXId4hzB05L6IxEtPhREumoDTpxg3oUlVa8Xu2C8SmoRHIaqaN8wZWyqYZP85sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702771; c=relaxed/simple;
	bh=fZjGGfzjD+e67lahGDJ1EAc/Am9Wz2vBr6GU6aH3PVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dypFebROKQt1YItSysyfxli405Het82/xo98nJjniCnuR/oYbNtOWiQmTYy4LdWb62BlNHK0PfhS/wNWrnwNep9ihobEYT3Q3qnfJNJ6GKXfKyghGiDc4R7xitydnJLqLt0RNxDnQkWVSp895D9ehfJdhiqfo4XxVlcZUXTmoIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qgg3hUgG; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qgg3hUgG"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5121bcf1aso172485a12.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789702769; x=1790307569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v9YKjnadMhV6kY6CH7XzaeiUdpmUgyn3iCQMQXyXjxw=;
        b=Qgg3hUgG+Sx+R2dllZ83l2bnEibvCo8HZCVkTfnKssidm5AUCumNY/XZlTsY0nFbGn
         BlxJQPmEURnkwns5i0CUyNtByEq9Zjvtl/+4SfNokO/KUCqvADJrtDwa82Fr0e1wyMcy
         onVe09P7yyZQcgqcsk4V6RQ3NfYcItYCrLPSyrBpaQtNMQdZkz/sjVQKuq0nYv1mpeCb
         2MUbquKssowxJlNERUt6apVtGaxfIfftR5q+QDlPphVt2LfuD5tUslqp1F2MWqsY9yY9
         1KR6CEo2tFYvWediqWmTBXxPeZII6d2YTqtfAFYtgJUKiqUhY+X93rQ8o6lj48ovMLC2
         UoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789702769; x=1790307569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v9YKjnadMhV6kY6CH7XzaeiUdpmUgyn3iCQMQXyXjxw=;
        b=YGIeXiwy1xrh4wcxpNHQVcotNmG9htqNDVrK0DmiWbXG/4bDjMlmTM/ZWiYNkmeCuL
         6QYdwH4mNagSGVBPavDuod7zVGQ+pn7K5Wfj0FjrcNm3ltGtTqe6+nNXnD5Qy/O+V3DS
         Mmr5BrZnAuHt6aDMBfq2iORdewg5bb0lE+ZzezihGX0GPfjJnxVzpoLb87spjU60qFro
         FfY7F9fdP6/m6CkrViPkFC6baYbc3UdgkcAwnyIcBNP1kEIeBCbpy73yHPvopZwkh1xG
         EK1N1feGN2z8GF8uVV1rPSqyK9Jaj/efuEM+wht9b40U7lH0Ln1T41WVHdkk+bhsmOZO
         3ONQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4yK9R2dZNoBqafg3RMkEUd+WVfg8bqk07RwxDsEMN7SCMV9rnjLyziY0QS/5eU46BWqWe4uE=@vger.kernel.org
X-Gm-Message-State: AFuF++lm82N3p+S+aAZXT9t9jxF5kDj3qzWrzqf0j2reQJO2RATrE3w2
	jxV5NTpkizPwVgdM7YoObm/uO5fZ+iqaO2Ebc9H3mb3J91FKCy8ilNC4o8KGew7nIY21yw==
X-Gm-Gg: AYBFou2dTUsphFI7dVj0ziTX5pHHrubKCn0pZoU4lY8nYIjtnIT68xx5QSByht84MB2
	l/ugTpoC9hHHeLWqwZm6WxjxKnbddd+cJcraj3aZzqT6Oas5G/Hvv+lfP+6tTtxNX+MIrW4vU4+
	Rh6uoBDyPlS+JaxA0Vjyxe7lZjuMN9ZkNADKTsMW8GwOegkFOSsHArZ+b1xwbMp/Eb/KmZ3p1HH
	hX3oFSccVp1/kYAYWeGnWM7h3SZO95LXojXuwpiT3K2YpntG7VQ5T0VSnSmVSZ38u6JGWhrujZq
	BPLXlieYZt5nAj1V5pFI2Ur3THltVtn7AU40bWLkg0fs0AlM+pXMlNs11O/tIzA9DgtC8yKgqRu
	0HOm+6WEr3FD0z8fhXBZf3lKmO+pgD1yonnb4UIHJgJAYxMJdv5WGB4HzgVqZQSwK3nru8C4CMg
	BEZI3oNB9hQGSbaIk+mZ87R5vY36jUhnP5FXngTFHVvSK8yKIPAqk5D+b/wAm+AdqrjBek9LXp8
	PwwsdM+IZm6BwQjZsD4+FHI+csInFhK/45LXoph5MGjEvBFVQ==
X-Received: by 2002:a05:6300:4049:b0:3da:c10c:6aa6 with SMTP id adf61e73a8af0-3dd8c2dc837mr2488298637.1.1789702768516;
        Thu, 17 Sep 2026 20:39:28 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:79da:8b9b:16b2:8431])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144cdfe957asm1039280c88.7.2026.09.17.20.39.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 20:39:27 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH 0/1] nfc: llcp: reject connect() on sockets not in LLCP_CLOSED state
Date: Fri, 18 Sep 2026 11:39:19 +0800
Message-ID: <20260918033920.85025-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses a socket state validation gap in NFC LLCP socket
connection logic where connect() can be invoked on sockets in the
LLCP_BOUND (or LLCP_LISTEN) state.

Historical background and context:
Earlier patches addressing CVE-2020-25670 / CVE-2020-25673 added an
explicit check for the LLCP_CONNECTING state in llcp_sock_connect() to
prevent duplicate in-flight connection requests on non-blocking sockets
from linking the socket multiple times into local->connecting_sockets.

However, that check implicitly assumed that any socket that was neither
LLCP_CONNECTED nor LLCP_CONNECTING was in LLCP_CLOSED. It omitted the
possibility that a socket had already been bound via llcp_sock_bind(),
which transitions the socket to LLCP_BOUND and adds it to local->sockets.

Vulnerability impact:
When connect() is called on an already bound socket:
1. llcp_sock_connect() overwrites llcp_sock->dev and llcp_sock->local
   without dropping the original references, causing refcount and memory
   leaks (service_name).
2. The socket is added to local->connecting_sockets while still remaining
   linked in local->sockets.
3. Upon receiving connection confirmation (CC), nfc_llcp_recv_cc() unlinks
   the socket from connecting_sockets and links it into local->sockets.
   Because the head of local->sockets still pointed to the socket itself,
   hlist_add_head() links the node to itself (node->next = node), forming
   an infinite loop. Subsequent traversals of local->sockets (e.g. during
   lookup or release) loop indefinitely under spinlock, leading to kernel
   soft-lockups and RCU stalls.
4. If connect() targets a different device index, the socket becomes linked
   across two different NFC devices, causing cross-device socket confusion.

Fix:
Enforce that sockets must be in LLCP_CLOSED before initiating a connection,
returning -EBADFD otherwise, aligning with the state check behavior in
llcp_sock_bind() and llcp_raw_sock_bind().

Tested and confirmed style-compliant with checkpatch.pl
(0 errors, 0 warnings).

Yuchao Zhang (1):
  nfc: llcp: reject connect() on sockets not in LLCP_CLOSED state

 net/nfc/llcp_sock.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.53.0

