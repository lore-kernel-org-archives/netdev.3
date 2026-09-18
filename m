Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB09C39A800
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695232; cv=none; b=Fn/ekUayaxT14CjSEXGPVhV2kQzk0GyFAADlQTHAXjkDqLNV408ZJP6t+4BkPxkUYaNllPSpPV2+OzIeLz/S7lPb7iw3A1FU81yFiI1pwpB1b3INfXvFMj8wBI2d4h66B8cVqTkOxlFSgTYfLzyshQWkiCe6/pN+P8Juj/gqlOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695232; c=relaxed/simple;
	bh=r6wg1fxuHJV5fVthhBMAQtpw90GcHVHZyZLGN4yf8h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhFzkr2h020vbDoXVOIT6pcBeuw3cLChtCYfV7k/aUN02067ujCThzNYN3T2ZE3N1EQRrQDm7nNiY9Y5WxTolnF4TxKjUFHDyMNvNJPsEusCMD2Z/yclCfZhBIcJsu/2fp84+yKPym1Bmgos94N2HUefGzttpt4oNULqt4HY3xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZU3CVs1; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZU3CVs1"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2dso69341a12.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789695229; x=1790300029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MkXkRtAByi7EwmQiCmqbYZQrF7WUF4/7cAMEO1mUpMw=;
        b=mZU3CVs1aYJxtZ10KA0x+gXKognk5ldxoc/QJXwsRaRamywwmHSuHQAbb5WqJGDe+C
         aOGCtcKVi+LQKuI4iZxxS208T03sZnw/a4q17TTMOzRqwk3goRlRd9favImnMnhrD+rp
         /51OKJ2X3vZ/P78hbr+w5k09BpaUjG9Bx28xTnmhIuV5GgpezxsV/S4ibiBpXdy50lOl
         15JOX5M3nhRZX0PXUgN9U2TxxwYp0PlI+g5mvjmONH0xBumUGmxT4iPa9OfBjuiYuGhd
         ZUOaErL2x32W/YDQ9K5voMOvXiDhxrYq7/ytGUtM3tXHb8mCZAst/T9xN2vAWUoXk2kF
         dUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789695229; x=1790300029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MkXkRtAByi7EwmQiCmqbYZQrF7WUF4/7cAMEO1mUpMw=;
        b=yTeHB604yd2Q5byxzGTAOepi95tmzO2RToTwFXEwOya4xSdpAF/+XivDltNWh2o2Iq
         hjgC2L/Yq4h2I05ZnvutVMjeUj0LRDDYMjj8rLn1/ChTCICE7ZKHa3fn9qIQNz73H3qg
         DAECXSJWGw/pfNI87/886jyV12o4MHO0KeWyukmUruSKJlTX4PT2Wec8mnH5UG0ztvoX
         faLb54d+w5VkDMHpOeQc5eR+ZLxR9nHZehz37aEzWnhx7Ft4t3axl1FbcTN1hUeafLid
         lxcXttJAKVPy1TIZKyk8bvSh/G3VV9LjhioTn2Q9CRc8tIEvtUGdk/6zHmmRTzMQb7Bb
         9C/w==
X-Forwarded-Encrypted: i=1; AKwUvBzJdntVVQcKbGm7/XRppN4vcduaBzjt1xvrFLHBlhrswd9ugjSNFOmcYyyQVjbEEpsM4eeD8aE=@vger.kernel.org
X-Gm-Message-State: AFuF++lqIcaXR9Iy6+GppAlxn/wtcxtZu+5qHqlSI3SNGznpkxrVWsbT
	NZkgKxechid93wv3e8I6aiQiJraQqTVWXvLNESQqBMWKBf85SSQzcdDD
X-Gm-Gg: AYBFou2DAk8IY0LrXD27MX6rLyotu4wY6YIb9Pu6uYC0KEAaiZkK6pU/c0b05xAolM4
	TLgxDqaTE0vZu+VIUwuiRBswbQdINPV4yQuY73TEfHubyNIxbA7HibKiZ4psrwTEJLunRXuOMoy
	Lq1EObkQ56jBFkHjzePLSPZmDVtYO90oAfwGPAg0xpuvsi3d2yq5J7/fXYqyEWiDdjGhEcTlSaA
	guQoqO9PvEK5SqEKLF8IfjfTdQ5ZqbbZyqThxiGbGkrpBe3ecZobMurX4pSWDSEWP05vMWWAosc
	cz04iJBsEi8JgnRPOcQObJnmd4AAWdTWC8bdhMU04GVe8rmZSFcyiiV6uUX+UE5w0P3tkx8ysjq
	/pmRj7npsYXi9r4QIx5UFoCrPMMO4OyBtpkC+gjy2H0R06Li9EQ6GKuWqGqcStwaCXvN3YfXMy9
	MS1EIUGHOfyEQ+qCuwYU+ImvYoodyofcO2Q77sWvUunTp7O3dA0EF8ps5Pr0LxJOQb5Nk688L5u
	+uK1Gtb3oAs+KPc8HWUIRZbTd1D6a1OVUEq41t//qLEfhtv9A==
X-Received: by 2002:a17:90b:5885:b0:39d:f6a6:60d8 with SMTP id 98e67ed59e1d1-39e54cb0e29mr2306656a91.3.1789695228974;
        Thu, 17 Sep 2026 18:33:48 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:e17f:a362:fc0a:a2ab])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c2872052fsm40520eec.11.2026.09.17.18.33.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 18:33:48 -0700 (PDT)
From: zjamg <ndaugoing@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] nfc: nci: ignore unexpected CORE_RESET_NTF
Date: Fri, 18 Sep 2026 09:33:37 +0800
Message-ID: <20260918013337.82214-2-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260918013337.82214-1-ndaugoing@gmail.com>
References: <20260918013337.82214-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuchao Zhang <ndaugoing@gmail.com>

Commit bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
added handling of CORE_RESET_NTF in nci_core_reset_ntf_packet(). When
received, it updates ndev->nci_ver, ndev->manufact_id, and
ndev->manufact_specific_info, and calls nci_req_complete(ndev,
NCI_STATUS_OK) to finish the pending reset request.

However, unlike other notification handlers in ntf.c (which validate
ndev->state before completing requests), nci_core_reset_ntf_packet()
does not check whether a core reset request is actually pending.
If an unsolicited or delayed CORE_RESET_NTF arrives (e.g. after a reset
command times out or from a misbehaving NFCC), it unconditionally:
1. Completes whatever request is currently in-flight (such as CORE_INIT,
   RF_DISCOVER, or CONN_CREATE) with NCI_STATUS_OK, leading to kernel
   state desynchronization.
2. Overwrites ndev->nci_ver and manufacturer info. Because
   ndev->nci_ver is used as a selector for subsequent packet formats
   and parsers (e.g., in nci_open_device() and nci_core_init_rsp_packet()),
   unexpectedly modifying it can cause protocol format confusion.

Introduce an NCI_RESET_PENDING flag to ensure CORE_RESET_NTF is only
processed when a reset command is actively awaiting it:
- Set NCI_RESET_PENDING in nci_reset_req() when sending CORE_RESET_CMD.
- In nci_core_reset_rsp_packet(), if the reset failed or if handling
  NCI 1.x (where no notification is expected), clear NCI_RESET_PENDING
  and complete the request immediately.
- In __nci_request(), ensure NCI_RESET_PENDING is cleared upon request
  completion, cancellation, or timeout.
- In nci_core_reset_ntf_packet(), check and clear NCI_RESET_PENDING
  before updating device fields and completing the request. If the flag
  is not set, log a warning and drop the packet.

Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
 include/net/nfc/nci_core.h |  1 +
 net/nfc/nci/core.c         |  3 +++
 net/nfc/nci/ntf.c          |  5 +++++
 net/nfc/nci/rsp.c          | 15 ++++++++++-----
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index 664d5058e66e..504ea91ddf27 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -31,6 +31,7 @@ enum nci_flag {
 	NCI_DATA_EXCHANGE,
 	NCI_DATA_EXCHANGE_TO,
 	NCI_UNREG,
+	NCI_RESET_PENDING,
 };
 
 /* NCI device states */
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 5f46c4b5720f..5a90591cd9af 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -134,6 +134,7 @@ static int __nci_request(struct nci_dev *ndev,
 	}
 
 	ndev->req_status = ndev->req_result = 0;
+	clear_bit(NCI_RESET_PENDING, &ndev->flags);
 
 	return rc;
 }
@@ -163,6 +164,8 @@ static void nci_reset_req(struct nci_dev *ndev, const void *opt)
 {
 	struct nci_core_reset_cmd cmd;
 
+	set_bit(NCI_RESET_PENDING, &ndev->flags);
+
 	cmd.reset_type = NCI_RESET_TYPE_RESET_CONFIG;
 	nci_send_cmd(ndev, NCI_OP_CORE_RESET_CMD, 1, &cmd);
 }
diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index f5c9a8ab7ec1..69bc9047f057 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -36,6 +36,11 @@ static int nci_core_reset_ntf_packet(struct nci_dev *ndev,
 	if (skb->len < sizeof(struct nci_core_reset_ntf))
 		return -EINVAL;
 
+	if (!test_and_clear_bit(NCI_RESET_PENDING, &ndev->flags)) {
+		pr_warn_ratelimited("unexpected CORE_RESET_NTF\n");
+		return -EINVAL;
+	}
+
 	ntf = (struct nci_core_reset_ntf *)skb->data;
 
 	ndev->nci_ver = ntf->nci_ver;
diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index b0ab4f5acbce..a4bfe14372a8 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -32,14 +32,19 @@ static void nci_core_reset_rsp_packet(struct nci_dev *ndev,
 
 	pr_debug("status 0x%x\n", rsp->status);
 
+	if (rsp->status != NCI_STATUS_OK) {
+		clear_bit(NCI_RESET_PENDING, &ndev->flags);
+		nci_req_complete(ndev, rsp->status);
+		return;
+	}
+
 	/* Handle NCI 1.x ver */
 	if (skb->len != 1) {
-		if (rsp->status == NCI_STATUS_OK) {
-			ndev->nci_ver = rsp->nci_ver;
-			pr_debug("nci_ver 0x%x, config_status 0x%x\n",
-				 rsp->nci_ver, rsp->config_status);
-		}
+		ndev->nci_ver = rsp->nci_ver;
+		pr_debug("nci_ver 0x%x, config_status 0x%x\n",
+			 rsp->nci_ver, rsp->config_status);
 
+		clear_bit(NCI_RESET_PENDING, &ndev->flags);
 		nci_req_complete(ndev, rsp->status);
 	}
 }
-- 
2.53.0

