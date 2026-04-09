Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C13DCD91;
	Thu,  9 Apr 2026 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747906; cv=none; b=lVzwi/TQnnG53fpTXnsY+I2Pyjrv4rIHB4A75noFO6o9x1O4AruNg64ulQfXClGHuUp2xLKMbrdXE5U/LOpVitioTZQwgO3BRyWz8q5aHQ49fGuV23S3+/vUiwpMC8gSOSv9PntSnRkCbKkRdO7MVZ3+uPZzeeLhfE1t+X4IRC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747906; c=relaxed/simple;
	bh=/KWU9bdf/71yHQtLgHP31xr2jYis+xHocJwTTB0vP20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P9Y+HNg/m2WVHrxPrcfa8JkBb1TcRHJjnW/P5l/1dVmwYIyjkskeCU0gEDrUdWzXKDJvlXyTP3UYal8c91yNC9cZpMJQa/mOhVBmt0FExHMzQU5YAUtKT5bBTRWYKIVysZ5nAywbiuMkVJrn5lDQ2Qnl7l910C02YA+lQPQNrFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QucOVjVU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QucOVjVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70198C19424;
	Thu,  9 Apr 2026 15:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775747905;
	bh=/KWU9bdf/71yHQtLgHP31xr2jYis+xHocJwTTB0vP20=;
	h=From:To:Cc:Subject:Date:From;
	b=QucOVjVUn+ZtEOM4yfx0PGJNLnnuwXn1qCtQ/WD3lk+OgBFSUxs5sOWSWJcAAeP6O
	 WyW0x5ulH4oiZa9NyrtidZGmkr4gBLIICCmGsfu0+BWahWt+BDfkGf9hQhkXc6loI+
	 tiZ0sCUdt43r9fzD1whhhhqNOwTT+/mIT92GILrQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thierry Escande <thierry.escande@linux.intel.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	stable <stable@kernel.org>
Subject: [PATCH net 1/2] NFC: digital: Bounds check NFC-A cascade depth in SDD response handler
Date: Thu,  9 Apr 2026 17:18:14 +0200
Message-ID: <2026040913-figure-seducing-bd3f@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2114; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=/KWU9bdf/71yHQtLgHP31xr2jYis+xHocJwTTB0vP20=; b=owGbwMvMwCRo6H6F97bub03G02pJDJnXD5vuiFE/8jRssnJ/7seJsUvcv0oaGMdVWX7/K3DWR WR1esenjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiIQxLDgrOtVzXFDkZmRM67 GTxl0+LVdYF3sxkWHFyp92Nj+q3tJ8TWzStr1BSyq8hlBAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The NFC-A anti-collision cascade in digital_in_recv_sdd_res() appends 3
or 4 bytes to target->nfcid1 on each round, but the number of cascade
rounds is controlled entirely by the peer device.  The peer sets the
cascade tag in the SDD_RES (deciding 3 vs 4 bytes) and the
cascade-incomplete bit in the SEL_RES (deciding whether another round
follows).

ISO 14443-3 limits NFC-A to three cascade levels and target->nfcid1 is
sized accordingly (NFC_NFCID1_MAXSIZE = 10), but nothing in the driver
actually enforces this.  This means a malicious peer can keep the
cascade running, writing past the heap-allocated nfc_target with each
round.

Fix this by rejecting the response when the accumulated UID would exceed
the buffer.

Commit e329e71013c9 ("NFC: nci: Bounds check struct nfc_target arrays")
fixed similar missing checks against the same field on the NCI path.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Thierry Escande <thierry.escande@linux.intel.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Fixes: 2c66daecc409 ("NFC Digital: Add NFC-A technology support")
Cc: stable <stable@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/digital_technology.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index 63f1b721c71d..ae63c5eb06fa 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -424,6 +424,12 @@ static void digital_in_recv_sdd_res(struct nfc_digital_dev *ddev, void *arg,
 		size = 4;
 	}
 
+	if (target->nfcid1_len + size > NFC_NFCID1_MAXSIZE) {
+		PROTOCOL_ERR("4.7.2.1");
+		rc = -EPROTO;
+		goto exit;
+	}
+
 	memcpy(target->nfcid1 + target->nfcid1_len, sdd_res->nfcid1 + offset,
 	       size);
 	target->nfcid1_len += size;
-- 
2.53.0

