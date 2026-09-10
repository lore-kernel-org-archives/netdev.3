Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92491DED5C
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084476; cv=none; b=EBhkEz0oM/KSyf6njPUzMQsvLujHM89lNP8wS142CShA/NLUzxShR1xY3GQ+kGX9BBfaFTD83VSF+ZXmSZ9n1rIlp4qNup+Qb7rfNn7IBqBIcHcX3mbNsRKHZRdOElef7wInTV0zVdfqTHKMg/eBmkXhdEr8Ci3DDN/r4/xdMQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084476; c=relaxed/simple;
	bh=Ft7f41YWg68luqVZMqHB/DBFbLfPIbAPmFq3513RkkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gr3aCRc5ZatJDUTvOqNUoghBOH40mc3BVsyErYvfoKp7IPI0EWGsV9LMRJoFIwKPGJo97+BzoXUVPRI0NMiz9JcijNnEImwuJECC2EqDymvhWnk8NgJ22ImxUK7vVeZLt738ctrUAllyhgR/36QtGruYbSKpTiqVrfSaPcU4YTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fd0A2Avz; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fd0A2Avz"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb766bfd3so5034011cf.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 16:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789084473; x=1789689273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xr4ylB1KGaYrjMDmEnz8DBoGfYS3HjosxfsRR5CFGeY=;
        b=Fd0A2AvzzuzBmpzhtgynZppD8WsN26osZi1qpg1yjMO8lO4m3HfA4zjpPr4EiJtnKf
         OM5QZ6VYvQOErb7I9tF6Erth87R4bdhKFVxA0n61l5D3q0A1GodmccZ2xRWFESK3GcY5
         vSxiSApT3uTOznwnoOvZEVKGu5BVl3SClJN+MRjOcgEabX7BRb/6FBTDUXjSK0BaClKy
         bGY9Y+jdf2O310shbOgmaKhRakgzpL2l8U5nnWZ6xEYoWQjR9wpppva7DsgAp8zZUuyD
         ssq2RKNrbM0KKMB0THfklzll1zLnU3PREe5OPKvfs08mThx0Zv4XDxWFV8xN11jNYDXh
         JQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084473; x=1789689273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xr4ylB1KGaYrjMDmEnz8DBoGfYS3HjosxfsRR5CFGeY=;
        b=Py6UnOkNz9DacJqzhCewZg8ApZel8fUDlPTas7KHra3E+cOTduufrGbGqj88CMAOgi
         y34mcXHxFGKw+5v21YPNgp1ugBXOcVflyy5ctKMgx6kScV5QodH5L8NCGexAThTJrGk6
         hdOSYLBPH9slgXTvYW31hHhPDDomU1jMjIq4Hz0wLEnxar+6HG5Eshwv1Qoh51p6tZLB
         JkaNCyBZ0JCcYOSfQK07j0D/H80gMH1ClAMXSQWMaNfBJIrwrlHeJVa5P79bZdquVfGY
         hRaDFhaCs7TXBXK4uU7tZ8DZsln0bNXvP8z0T0X7kqhYU3M8MiAUYcPmNWAALhHZIzQn
         PKFw==
X-Forwarded-Encrypted: i=1; AKwUvBzlo4O4UZPAjvMROd1q5H4fno3ZOCeVZuCPtYgq0UC7txrlwWBvedwKw+ucG8al43RyTceUPjQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kiqLoEjmvM1LYGeK4x+/ZZCowwgH5R7o/Jj7vo/0eo5znIz08I
	zJfPIpfcA/amaQkkUcFMaeTwa2ZWs5XCXJhKSfd3cSNspYSQHrWND4E=
X-Gm-Gg: AYBFou00YNiVKcyu4nfwJu/KcOTC+EBlJjUUMaW6DNp5xc2NImhQkG9U0gRfS3I/cJb
	TmerB0A5+KXme4OtxilOd4bJqt609YUBLL6iBr71FCkI7qrd3foYOZrjL1WtY8nf1kfS7VuydD4
	1lHnPBmnOFjQq0zRTXrgGvK2ld1Qb/dthJN/OUceGlN3T98G5lZwexVzAP3k9aYH9Zl9eJIal9S
	1Ejq73H+94xdI35In9Yk5Zg0b42I+l37I6SnYMHjrlwnKF2QCcsJyYPkCwFjPfKEsobhUIHG+jj
	mFJafQEHOwYY6murZSaRwe3Zf+L+XwvdDTbFyunvi76efwHIwIFQWnRU5/noFVXHtW8tGwH+Dgs
	kc82ZY0aMTYoGKdS2H/nH/x1XHc6HkuVCLNiEzBf0FD08t1RmOmm3uhGm/wgKfe47InRid5TeAH
	DlZSEHT2Il4af0pF6U6PC6UIvE3un85Te1DhBLM5AKWZ+bTxtPNX2X6SVdrDMbFIKs9rA/5ZEu8
	iiST2S2MroTkjNMSWZfnjPqpyGi7GCAEVjU+Ec6pdWcNpjDu32XI2WrdSmtH00Uh7E3kvY395yG
	JkiCDXq5PcCWQsJcAGy+luwmyzc0L+Q1Xw==
X-Received: by 2002:a05:622a:229d:b0:530:2146:81c with SMTP id d75a77b69052e-530c8525903mr43339041cf.12.1789084473405;
        Thu, 10 Sep 2026 16:54:33 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca48912csm6100771cf.13.2026.09.10.16.54.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 16:54:32 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexandra Diupina <adiupina@astralinux.ru>,
	Christophe Leroy <chleroy@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/4] net: wan: fix FSL UCC HDLC lifecycle bugs
Date: Thu, 10 Sep 2026 19:54:26 -0400
Message-ID: <cover.1788128904.git.mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

The v2 review found two pre-existing FSL UCC HDLC bugs and asked that
the generic HDLC behavior change be separated and audited.

Patch 1 validates that an HDLC protocol is attached before starting the
UCC, avoiding a NULL protocol dereference on a premature interface open.
Patch 2 allocates the suspend backup before disabling NAPI, so allocation
failure leaves the running interface usable. Patch 3 closes active HDLC
devices before detaching their protocol and documents the audit of every
current caller, including the farsync probe unwind. Patch 4 unregisters
and frees the FSL UCC HDLC netdev before its private resources.

Patch 4 depends on patch 3 to stop an active device while its protocol is
still attached and before UCC and DMA resources are released.

These fixes and changelogs were prepared with an LLM and then checked
against the cited source paths and call ordering.

Changes since v2:
- split the generic unregister_hdlc_device() change into its own patch;
- audit all eight in-tree HDLC hardware drivers and document farsync;
- fix the NULL protocol dereference reported in uhdlc_open();
- keep NAPI enabled when the suspend backup allocation fails;
- rebase the series onto Linux 7.3-rc1.

v2: https://lore.kernel.org/r/20260803133048.42650-1-mhun512@gmail.com
review: https://lore.kernel.org/r/20260806020541.2011936-2-kuba@kernel.org

Validation:
The series applies cleanly to net commit 784450234395.
All four patches pass strict checkpatch.
No hardware runtime testing was performed.

Myeonghun Pak (4):
  net: wan: fsl_ucc_hdlc: validate protocol before starting device
  net: wan: fsl_ucc_hdlc: allocate suspend backup before quiescing
  net: wan: hdlc: close active devices before protocol detach
  net: wan: fsl_ucc_hdlc: release HDLC device on remove

 drivers/net/wan/fsl_ucc_hdlc.c | 29 ++++++++++++++++-------------
 drivers/net/wan/hdlc.c         |  1 +
 2 files changed, 17 insertions(+), 13 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.47.1
