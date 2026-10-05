Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12FA36C9EC
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791229328; cv=none; b=g4nGJ4gWlZRRPyfP6bpFTG711UpmWNILpvdxjEitvPV5COhRIigvkmzKHy3DyQdxaT4HaTwJ2D/F04VLzsOApblaq95QbCH7HmHm9RlPxIRcoSiP6GNsMt21H6gZV+kbVsWJ/7ElxRMD0qa/+SEBBrplKeBdHsBxFJyBtVSf8V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791229328; c=relaxed/simple;
	bh=JjXTa/+cKg34EhRNO5mzTHP1vpg1WM+OUzkYtXltSHE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BeVzWNl66PZnWr7H1nsS5PQBEpN4oa3mZBM21I1tXUzvFcnfA2iYmeVY3NpcRbshBZ5ArcoKoYLAtp0QgaLsZb4DeTpzY81mM6/UKshCy9+EdESPCSxahizBgVEQvChXjXdjg5mmXLWXcFZg+raLjWAcZHGovHjX72Hgf4+hFZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+TwSyei; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+TwSyei"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33fb4680717so6052362eec.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 12:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791229326; x=1791834126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AXet9GVXIs8XuM+O3dt7RNbOl39Pb0NUJxPHM/V2l6c=;
        b=S+TwSyeiRlm+OPjqJPe1+u7GdKKeEcfrF2xzoHl/ED1Almau3dG+wwtahWdbe1sg9T
         FykCEQiJV/w2dpN2T5FELETXCU87agyVTqtqTFEB20jWEgI2Jv9Oc6FsHq2cjOdsqTAu
         jmr5la46mqGiVPYfVUKu5W1PEYb3ptT+wjp7XiQ1DCEUccsCFwh6bYijYhcXHzpeFBhD
         Dz2StDpD1IlSMJVoQGVYNZH/2Ysk7+6UCEZMOT5AQHbqflWmEqBRRxfLUm8yNST0g0LW
         PWQWPoLhzYdn0x6S+wyuc5ngwCqJDB6ayQSrvAHizHZ9mRQr+jyZX/tdbmTYt3hN+tOK
         iBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791229326; x=1791834126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AXet9GVXIs8XuM+O3dt7RNbOl39Pb0NUJxPHM/V2l6c=;
        b=fzKNMQUIM0dE/9KM1OdS4N+aX/MtOev9Ungc85Y1qLVw6UGrn+BkP+6rr8mNXnqV3G
         We7pn89xNtaMZEO5QpnWoQ7m41B0+k0ccXWPQuzk7g64P8UnvotH90P2UCJ4ecDcV7ce
         mwXpeYsx8fRHDj2SN5N44kN9d9CGHfM/PReUVfyA58PFnce35XGmClqbmV4Z3KZEP5nI
         yJyUhmcZUCduPQaUwAkH8klPwO2u9WmgwnezGqnZE4bq9EbG1yTkbrg/wI4PR9Y3uwSR
         Rld+0Z6mgvsMWJ5OvcUchtffBxfOqlNn2zhY5vLuQB4DE/+gaq2TKRWIMJIdhzKlaZBv
         bhsQ==
X-Gm-Message-State: AFq9FYLTplW1N6PZL3DixlAAHl9IF3nzZU7JwTw0ZFkypwgiwbTg/2fN
	6NRGzgxOcP+oK6haMe5VTu1r4PASc2vI74pfIC3GlYp/3GKvP5jt2zwP
X-Gm-Gg: AYBFou2TEowUaGplUc5Lxv1+7ObAJGZ0Jxylh9X6Bc5Mk0LPjJw4FJYjZ0wxHF/vDLh
	6zIxvs4IZQLpwGIK+4eleImQm1miVcRQMIUZ9sDMY0W+4jKLe5MzPqblK+97RbEKsT6VkQcDxbe
	/NKcU72iWDwb7VuKRwe8X5lcgBs7Z9/bRw2Pi00V76qbTMVqCpTstxFiFe1LuV1ywpbEEFtp1Lw
	dIsekoM7fR+0F47hBSNVrno+VErp5afK69CdSlQMOSCOMoZU4t2GEATTlUqbVelF5jjk+P5mgaD
	A3np5waPKVe1nNwAMZXd3usB1rMFDFChT/jMtpO9RvpSc4qjnIfLoB84SX8DkJH5TJD+W6bamF/
	g75GA7B6goQqB19p3dt9ZgZd07mVLJyfSYtlIMTPzlOkwtGTcB6iIXMrUKBBp2ggGOK2ohz0C2k
	KobQYwjCrVBMG9S5E43OTYY9dpbKLVAVYKF83KvLMTEBE9KuZhz1ow2MmoqwSn4InydvX1zpJME
	218EYahtdZCm+pFYMQ=
X-Received: by 2002:a05:693c:69cd:b0:351:39db:42db with SMTP id 5a478bee46e88-35139db48d1mr3032371eec.20.1791229325700;
        Mon, 05 Oct 2026 12:42:05 -0700 (PDT)
Received: from hp-OMEN-Laptop-15-en0xxx.. ([122.172.84.229])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146b73111sm444485eec.31.2026.10.05.12.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 12:42:05 -0700 (PDT)
From: Jayaraj Devaraj <jayarajdmit@gmail.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jayaraj Devaraj <jayarajdmit@gmail.com>
Subject: [PATCH net-next] docs: oa-tc6-framework: Fix typo in SYNC bit description
Date: Tue,  6 Oct 2026 01:11:35 +0530
Message-Id: <20261005194135.64584-1-jayarajdmit@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a missing space in the SYNC bit
description: "bitin" should
be "bit in".

Signed-off-by: Jayaraj Devaraj <jayarajdmit@gmail.com>
---
 Documentation/networking/oa-tc6-framework.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/networking/oa-tc6-framework.rst
index 0feda2f9d..2545ef694 100644
--- a/Documentation/networking/oa-tc6-framework.rst
+++ b/Documentation/networking/oa-tc6-framework.rst
@@ -278,7 +278,7 @@ SYNC (Bit 29) - Configuration Synchronized flag. This bit reflects the
                 register (see Table 12). A zero indicates that the MAC-PHY
                 configuration may not be as expected by the SPI host.
                 Following configuration, the SPI host sets the
-                corresponding bitin the configuration register which is
+                corresponding bit in the configuration register which is
                 reflected in this field.
 
 RCA (Bit 28..24) - Receive Chunks Available. The RCA field indicates to
-- 
2.34.1

