Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1063ABD8C
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697069; cv=none; b=Gut/FnjBxZGZ8zqcGcaFSqpnkRHLPD8hnL5P2ssW/+/R+vVGpDqwD3rsAgvsp7rF+QcMFI7dm3ibKtjVb1ZE5IGWAUZLURnnq1BOkNXhBhDvFR0jJTrnVnwwlYPw7kKUltXSj1R7+dk7GpggDXIgWfvZ1SBxGE7XfvWut6OCfyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697069; c=relaxed/simple;
	bh=GqEmDjbmlD43nKcKkz3682LJMrGqtTA7m5Mhi4U8TjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbRvNEdHTB63OUCojv6zP5v0gI3qPEZiEYgJUIC0yYOhjqKaaSMx6nZIdXoLQSK+TO5/IXjoEpCUZQoCgR8c5tmlAdn8ZfoNCp7yBNiMNDQSSnFTygQxmWZbAa7jzRNNfKnDomPvW7dFGin5dQ12FecNx7+SnXnkpeTv8UYnjiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQI9n4X8; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQI9n4X8"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8692a856865so249501b3a.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 19:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789697061; x=1790301861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y8IHVPQTh4E48RsfYHS1AOxQ6DrEMP7aqWgbccraUDI=;
        b=DQI9n4X8v9uHILIdBUDpz7OpGvJXBhMGCjM/mESEz1FeDQvp+nySIgdM5uS3LCgjvu
         8bvZumz4fBHcd0MjRZX/nOV2kUFLBWB8BIhOGQv1HLzhVvEO2NRpTRBCp6wB6XRGCRzu
         dHN1k1Kh4w/YTpc5iExFUuFn9KqOUkYFX9Mt/T4ARATwICip7sYunMN1sqx6fR5oPfo2
         C/2CFBgThuGRuPfjEAVYiMgEubZNnArsRxp4B+xE9IyonJqUkXPsmxVHmEUxEH8DOVhB
         Wk2QB56tiWgQRvnlIq7YILvmrThyPVv3YsX9zMo7C6oiC/ivwBpxGAdKHC3L7NZaNO9x
         DWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789697061; x=1790301861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y8IHVPQTh4E48RsfYHS1AOxQ6DrEMP7aqWgbccraUDI=;
        b=b8bdHm4hr841ZJ05bFVQ05Sd9TtfJTC/Z5ffHu4mrtHmonTRUH+606PIbr9YIYPu6r
         +hOFOHuRJxcGjQhFUNqZVqpf2rafQEnO9Ir65A18ZUNPCjISlnRry8SvWs1oEeyY2Bkw
         rFPiA0lnTBz3SSMXwypDNy3/PnxnnpJGpx4SfQTOxeQEBYS8JY0VzGKyCV6/JgsPjEFz
         4uyU/PxFXB856/gKOm2GKRrR+5F43OjsyYQf7dV0f/3O6UewprEge6r+LfklTe8OICYY
         Q3kG2ds3A5EimbAOSmzThVtPdD4+RF6ISSW8o4M2phgEJuWRM75Z7+ZqT1sp4lIBehzu
         d/5g==
X-Forwarded-Encrypted: i=1; AKwUvBxgCB/wtIyjHAT5vR4QDvnM5XnJbGJQ5ueNAGYk1PZEBrKnXChec7KPLAf1CqnKyLeui8iE4rI=@vger.kernel.org
X-Gm-Message-State: AFuF++m0DyGbNU9eccKM0AqlASdlBBaL3iTC23WrGHQ2V6rkXlL+Behf
	TaO7qG70Q1LUkvMuvzwyOc67PnW+QnYO76Uut6NgQfrmaL0h68FAK2om
X-Gm-Gg: AYBFou0VqeqcpyHftdaB8ZXCS6Yl1KtGyBdzJWHR6QMn/gn1yOB/32uAsEuz2V+MTZR
	aWOIQzCzFrrJjpxkSZZHFq/stbI+/496eUQspIpN6Gl+BQrqyzxokNcv1YlLB9UsGKj39dbZ7h2
	IQA2ytm5gqy97F7s8/bcVNuDVigxPDzpCHYu3LtgK1UcZG059oGEVB8gXBnC/rVUYTOCsHTg/+p
	/GTNSAHDlsSBCQb39Vd7+oeTKEpZD16KmFYWYJCGhtLohFoy38NBAi43+eoaGTA1I1lBwOFOIzD
	bc4GA3fEoc0ye07J0h0Bc3eDA2vXiVpphbYTs65m28NAF44HigOXxnzanCNcYw5ac2F6C3kYKpH
	S7PzLSqjuw9fVPzKrjvu6m01ZsBnZyXSqpGSi7Nv7vMtn/n9KzXaz9T63+G9PrzexCJr45trPlo
	EysmpLBlpPaUU5ZeuAQl6yMX68QeW5FxO7RBVl9bHBuAnyxgrPhL2UJyeD9BRfm9WsMjik5GOdF
	aVcr0z82sG6fFd9QuTTtzDKTfc0UKlcRGEAreE=
X-Received: by 2002:a05:6a20:a11d:b0:3d0:ba81:79b9 with SMTP id adf61e73a8af0-3dd8c41fd70mr1660945637.12.1789697061119;
        Thu, 17 Sep 2026 19:04:21 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:79ca:7a54:4576:24ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c2890b915sm136049eec.30.2026.09.17.19.04.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 19:04:20 -0700 (PDT)
From: zjamg <ndaugoing@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: Christophe Ricard <christophe.ricard@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH 0/1] nfc: nci: do not process unexpected or invalid CORE_CONN_CREATE_RSP
Date: Fri, 18 Sep 2026 10:04:11 +0800
Message-ID: <20260918020412.82878-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuchao Zhang <ndaugoing@gmail.com>

Hello,

This patch addresses several issues in the NCI core logical connection
handling where an unsolicited or malformed CORE_CONN_CREATE_RSP packet
can corrupt connection tracking, shadow the static RF connection, and
cause TX queue stalls or hung waiters.

Problem Overview:
=================
In the NCI core stack, logical connections can be created by sending
NCI_OP_CORE_CONN_CREATE_CMD to the NFCC, which answers with
NCI_OP_CORE_CONN_CREATE_RSP. nci_core_conn_create_rsp_packet() parses
this response and adds a new struct nci_conn_info to ndev->conn_info_list.

However, nci_core_conn_create_rsp_packet() had several vulnerabilities:
1. No Pending Command Check:
   It did not check whether a connection creation command was actually
   pending. An unsolicited or delayed CORE_CONN_CREATE_RSP packet
   unconditionally allocated and inserted a connection into
   ndev->conn_info_list, and called nci_req_complete(ndev, status),
   prematurely completing whatever unrelated request was in-flight.
2. Connection ID Collision & Shadowing:
   Dynamic logical connections allocated by the NFCC must not use
   NCI_STATIC_RF_CONN_ID (0x00) or collide with existing connections.
   Furthermore, nci_core_conn_create_rsp_packet() used list_add() to
   prepend the new connection to ndev->conn_info_list. Because
   connection lookups (e.g. in nci_tx_work() and
   nci_data_exchange_complete()) use first-match semantics, prepending
   allowed an injected connection with conn_id = 0 to shadow
   ndev->rf_conn_info. This caused:
   - Cross-connection credit accounting in nci_tx_work().
   - TX queue stall when credits == 0 (frame wedged without timer).
   - Dropped RX completion (cb == NULL on the rogue connection, hanging
     the real waiter registered by nci_transceive()).
3. Missing Length Validation:
   The handler accessed payload fields without checking whether
   skb->len >= sizeof(struct nci_core_conn_create_rsp), risking
   out-of-bounds reads.
4. Spurious HCI conn_info Assignment:
   ndev->hci_dev->conn_info was updated whenever cur_params.id matched
   hci_dev->nfcee_id. Because both default to 0, non-NFCEE connections
   (such as loopback) erroneously updated ndev->hci_dev->conn_info.

Solution:
=========
- Add an NCI_CONN_CREATE_PENDING flag in enum nci_flag to track
  in-flight connection creation commands, and reject unsolicited or
  delayed responses.
- Validate packet length before reading payload fields.
- Reject responses that allocate NCI_STATIC_RF_CONN_ID or duplicate
  existing connection IDs.
- Append new connections with list_add_tail() instead of list_add().
- Restrict ndev->hci_dev->conn_info assignment to NFCEE destination
  types.

Non-overlap with adjacent fixes:
================================
This issue does not overlap with the adjacent upstream fixes in this
area: Lin Ma's commit 1b1499a817c9 ("nfc: nci: fix the UAF of
rf_conn_info object") addresses a use-after-free in the conn_close
path, and Yun Zhou's commit d56575a2595e ("nfc: nci: fix use of
uninitialized memory in CORE_INIT_RSP parsing") addresses a different
packet. The problem fixed here is the list_add() head-insertion
combined with first-match lookup semantics (core.c:43-54), which lets
a forged connection shadow the real one.

Testing:
========
Verified with QEMU arm64 empirical test harness. Unsolicited
CORE_CONN_CREATE_RSP frames were rejected with a rate-limited warning;
conn_count remained 1, and the static RF connection was not shadowed.
Verified with module compilation and checkpatch.pl (0 errors, 0 warnings).

Thanks,
Yuchao Zhang

Yuchao Zhang (1):
  nfc: nci: do not process unexpected or invalid CORE_CONN_CREATE_RSP

 include/net/nfc/nci_core.h |  1 +
 net/nfc/nci/core.c         |  2 ++
 net/nfc/nci/rsp.c          | 37 ++++++++++++++++++++++++++++++-------
 3 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.53.0
