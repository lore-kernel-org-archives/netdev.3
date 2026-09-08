Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B0C5505E5
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876250; cv=none; b=cuKVEarGM19KfDllJekBMYmp2I0PGcoM0NBz1nqc8OGn4pYrXp3ZwheHZANofuOfXWrp/bXzwDb2S2+GBCLkAjesN5NWfNAR4Kh9t1NIIU6sp7aJEeImj+MoatnNI9PccTqZwm3z1uyIe0NPvAJppyYHDA44dXTLLLijsmDzz0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876250; c=relaxed/simple;
	bh=/hf+JaN80kkUeIvT9savcMWGneOYjndNEDsyR1nSTpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y5a/VjgiYTewKxBmwElNxtSBt67pFiz+EgavOJlx30pMxjO7XWu1bmDSm7xqLg1079huy+P8/gkvQE2mlZrmV2eV17lCrlyf/ysiUiYxmMSEj8V4VgxAttXqzpHgupZ+26k/SgSmogdXivBOwnwgPwcIgVXCgDDj/MOhtWGzwJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=MpAwRV9j; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="MpAwRV9j"
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 09BC43F4E7
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 14:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788876232;
	bh=SXIMe4oMHTuXDpcB4oft04tFKxq0tl8ji9Vspwz0rd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=MpAwRV9jc9+EBdHYjU7mVVJ6N6GJOuwhNGOW200+1i7B7l+Z0F4kbVRuT+lZG6VgF
	 293qVLsq3LqkkNJqbbsrrx2ULr3E2NvOv/Tw+5CrB+zDROoSJUXsx/WEulgjf27YuO
	 YGM8MA7iiw0+somTIIqPuDvoSvO/XlTPeBZ0V2MYsB5r4Y7iwhWf5L31ltzbsZ7Cmu
	 8OHyzh+UnQq8b7ukv0GDJsEc7cUNJZPpnApAA+UckCAmFIgOThNfRXJ7X39FbPxpRZ
	 QKjr5Y8TGrwcvSzWSDRe9827g0yS/u+QfasxlUoucjxZWDt7/FB+HCI1GVKIMKv4ag
	 FCSxcrDqYq1TzC7RBguYpVHfkARKEYPO+nVUPOBDtbX/7LVP32F0IHOY9ACfZceV5C
	 qJkpgOLdN0ME1BvkqJiCHJnNUcrOYaehiNLN0EFFfBRBC+PKIRd+uqwVyuhXAZjqSN
	 Bw4ps7vjZJoMJG+1LG+S7qA5U/WtBTUhSkCILaVPE+dnkPe4Llyffet4k7TwoyshTU
	 53SRRnOO0aIu4VRQTgarMdWyXLZOqLJN2OCNgEq66uFatN0O1u+ggq97a/Ahf4KVMo
	 oH6Q0iTPXgy2VH/RJtTET3wg5gvQiSaqjjw65uGajtwbtO8UmsNnm3FTj+71askfkr
	 xoiNku/T8+ZeS8tIsQMxbYSQ=
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c1c232fa136so591238666b.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 07:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788876231; x=1789481031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXIMe4oMHTuXDpcB4oft04tFKxq0tl8ji9Vspwz0rd0=;
        b=PJjmm9pe73zaiwPnQ+67syE3ZqcklbeQaM4lZRjSV3nNDvlZoRktn/yyCyLmWQPCvY
         J5Ss6VIWnLB6YXI/Ecf5x2q06Nt8m8d4Qv2VFWvlJdOvSWLRAf/tAWkgUa/88eWADhLZ
         vAPsxXFSPFieJOC49U+8dVQBH/EZEV1+YlP4HHPJMBUPhwSaHNHeAYysQt4CVBeqe8nu
         ZV1jUrg0PPW3tNbFmwpozpmg6arqkPzBMWaP7EjTnq/GBjn+JQo39PNMRpL6+Iip/u+1
         JU0RX660qinIG1gymLs+y5k95XYbuFdBayiixzhUHxBzQOGG2bfDLCpZgZ1YT6BuhiEU
         e6yg==
X-Gm-Message-State: AFuF++nBHRqmIaIEk0farHZYTC1eRmuSXOQaF8edJlhNj/mbEHGzGgE4
	viXvfowcJfqh+mH0JgXk0/WvYzaede2stuOY5AUVseEoxYrt5lSAy6S4q3CqyCLy446j876KyZl
	PTW6PsCm5xAdggIFnkgGN1fnZ4AWWkBoQmMfWtW+8bzzQLBNoAjkfNydBpFN9O2l4sgn9xvuifw
	==
X-Gm-Gg: AYBFou0u4emmKg3d6h6R/wVOqmKopC/O5HgppGhSRETWur3ZB2yCCFh8Q13xGERl4T3
	xGgxfd19q+AUGl7ZmA3SjB/OYL1OqqATo2f5GFJ70zvpKyctD49mYrqpuWcWnoo9XA16mzHnC3K
	ktCUPWFddQ6tzEzOo3k/sVR4gBHz0JC9RT9TkzMxihYnSBMDePjqE2DLIaQnVr0hG+sBJBn+clJ
	PEQ7p0Ryj/TTUcuVBF0QcyxO9XlbAL9jOkTeygvrytcys5inLH0qyCqKpCadB1WuZBDP4XhnubT
	aaY0l7pmluuprh/cQkpP1pN+rxEXnRN4yQ97BIiwNbYJVz9XBD6c68sEU8hV0gh5qBkXFyRIkco
	IeAXeEufVXPbbJa8V3uZNEmFHgsRNZePE51bgUFoCnFcTsXL1utUL3NIxyHEMBkUkog==
X-Received: by 2002:a17:907:c48b:b0:c25:f7dc:2dd with SMTP id a640c23a62f3a-c25f7dc091fmr1249500466b.30.1788876231440;
        Tue, 08 Sep 2026 07:03:51 -0700 (PDT)
X-Received: by 2002:a17:907:c48b:b0:c25:f7dc:2dd with SMTP id a640c23a62f3a-c25f7dc091fmr1249496266b.30.1788876230905;
        Tue, 08 Sep 2026 07:03:50 -0700 (PDT)
Received: from localhost ([154.62.191.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5768c2sm616647866b.39.2026.09.08.07.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 07:03:49 -0700 (PDT)
From: Andrei Gherzan <andrei.gherzan@canonical.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Andrei Gherzan <andrei.gherzan@canonical.com>
Subject: [PATCH net 0/2] netdevsim: fix IPsec debugfs byte order
Date: Tue,  8 Sep 2026 15:03:23 +0100
Message-ID: <20260908140325.13367-1-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netdevsim IPsec debugfs file (used by selftests/net/rtnetlink.sh's
ipsec_offload subtest) prints the SA salt and key in host CPU byte
order instead of network byte order, because nsim_sa.key[]/salt are
typed as plain u32 and printed directly with "%08x". This makes the
reported values differ between little-endian and big-endian hosts for
the same underlying key material, and breaks the selftest on
big-endian (e.g. s390x), which hardcodes the little-endian output.

A driver-side fix was proposed in 2022 but stalled in review: keeping
the fields as plain u32 meant sparse could not validate the added
ntohl()/be32_to_cpu() conversions.

  https://lore.kernel.org/netdev/20220308135106.890270-1-kleber.souza@canonical.com/

This series:

  1/2 retypes nsim_sa.key[]/salt to __be32 (matching the existing
      __be32 ipaddr[] field) and converts with be32_to_cpu() before
      printing, so the debugfs output is now network-order on every
      host, independent of endianness.

  2/2 updates the selftest's expected output to match the new,
      endianness-independent values. It depends on 1/2: applied on
      its own it would regress little-endian hosts (though it happens
      to have no effect on big-endian hosts, whose old host-order
      output already matched the new expected values).

Tested on real booted kernels, both patches applied:
  - x86_64 (little-endian): PASS: ipsec_offload
  - s390x (big-endian):     PASS: ipsec_offload

checkpatch.pl --strict and sparse (make C=2) are clean on both patches.

Andrei Gherzan (2):
  netdevsim: print IPsec salt/key in network byte order
  selftests: rtnetlink: update ipsec_offload expected output

 drivers/net/netdevsim/ipsec.c            | 10 +++++-----
 drivers/net/netdevsim/netdevsim.h        |  4 ++--
 tools/testing/selftests/net/rtnetlink.sh |  8 ++++----
 3 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.43.0

