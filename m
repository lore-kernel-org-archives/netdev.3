Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE60D28750A
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769544409; cv=none; b=m0VB3syai7pj95RqJRkdRtqSQO22QBMVAkLoqTfkxbQPyqt8InSOEGZUekDAkxPNDmBWppTVBEAqsydOPDHQ1WMu3FB2ATfekIwKmK2Y2zd3liezthxFezQGFTz5tQ16GLpO0dlJPM+QD2lKQ3fO3x9HPjLWJ9abnR5/eUp9L+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769544409; c=relaxed/simple;
	bh=gIiyIgLUReotONL+IzL1vGlOIjfi66A9rvNonMuYFJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nh9a1H6o2LKr03q967oMV3Ypl7aRVVFkd+cWrRLgrHuijqejFgChmeykWWr2HNPyh+cmPPPDtmo7F4FRWRgnoBY+EPE42KNs9mHISQ4jFG/1Bh2ihcRIv2ROhI0RBQgy/0ds3WDijFyCZ9YAYHplnOc1y6h424lbRd+rLKXR/Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjV85nvZ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjV85nvZ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-503347dea84so6360371cf.3
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 12:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769544407; x=1770149207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8MqDct5CkuVtyBGYtNEgK5oo43Hn318or5byf6H6PwA=;
        b=AjV85nvZTBihhcCX5ia9LlwuIyxJjkU2i+Pjytd+wiryo1WcyZllVaVY6CVHNr882L
         S2Vhg8ABo2TGXdaNc6EuR4AV4Oi/OxCBGefDW3PMHeQqK173U+XTr9ThCmKhRoBiJ+s+
         LaHiCfLXtSUJ5tE39FOGo0ShbONbixoX9Fq4o7dTqDFMQvG/PdGjc1+6uEY0XE4Hhlzi
         9Ip/oMUQEZozpQA/H+SaLlgDROC5fPELbeho6jhBg8GhG81mI4mv8Q+fkmi9f9Te4SNy
         z8xI3sXJ3sOf0Wa9joOQGYJiMnd0R3BwTIKLHMS4FyvBLQj1vW+vBm6+GTpsI/KO/8Mh
         fF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769544407; x=1770149207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MqDct5CkuVtyBGYtNEgK5oo43Hn318or5byf6H6PwA=;
        b=tvdqoMDVe2UuespWAss5SktATVWr+tkK9c9/i/VtXiYfuSH54A5XRprmmYmnADHWXg
         TKdGo6KadyBs/eN/AJPEKFkCvRT/EPum/xOckWcLIV5kOIl2RlZ8WriNkc+rGMddFjWC
         r+8bLFEBhzQ8BGbE0danzukXY8HkDDxrvkULqO509/dkNxKs53WdENg+LGtOcSxkX4Rh
         WC0I7StklLCX6ZmHL0JpIzo/UjCPOTWRmQncd4D+JZr1ksCqhbIA4mOhsqINrYIoex2S
         pWcdx6zS5SjRGy8P31jECmciNPtQ9zilalqK9khTtAU6vLf41SLoJT3u5ih4k4nXgaM2
         lvIw==
X-Gm-Message-State: AOJu0Yx/9cz/xD3mYjkO9OsiBckm34HJ8LAR8bvFADKrvmaCWky1L66J
	HKbPMdpyDbTXR2A6XGrirP7gEF3t8EPhbdm2dIOCx0z3VUG3iWCJsKoA
X-Gm-Gg: AZuq6aIUAgSVYepf8jE8EiS601X/eiwtMwgNk8Zkfx62ZmZ4dG5H3Ks7hfUwhfLGAH9
	iTJ0UcP0XJ55a0hX/fIayI7uq1iATqlbHc4NvAymsJf/k4kkY4+6Fdio9fEpfOpn2kXcJ0P/SYI
	j7NUcWCSIn/l5++jYTzSVcZ8ogf/SQW7SOstx4Jw1nQ7yBiNg1Tbrx/7/DYdx9eW7QMR1/eVsJs
	VBTSLRRaq6ZJa3xsgsDHsP+fpP40+Z9A32eyks2WdeaLyob3ahvsrX/QI5Eauvs2QjdVBLX3KXH
	lobd6hg9Y/vKKT6j5wspKPkL/AgZMsEputhcF3nBE4TKlf3bE1gUCzBOcWYcYQonFZVPGTrfum6
	lk597XPKnRzbR1YcVy/mKCny+TMy1QR2B3tyfKpFIiNPhYmQ9vvkkleA+Bq3W+t486nmufzivGv
	7zYNhsaLN8aygy08gRHoWMj4G4WEd1Gx3Osw+FnuWippWT4K/Yw8Kl2J0=
X-Received: by 2002:a05:622a:60b:b0:501:13d5:a755 with SMTP id d75a77b69052e-5032f74b0c9mr34040461cf.7.1769544406549;
        Tue, 27 Jan 2026 12:06:46 -0800 (PST)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d37420c5sm3450696d6.31.2026.01.27.12.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 12:06:46 -0800 (PST)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
Subject: [PATCH net-next 0/2] eth fbnic: Add debugfs for mbx and tx/rx
Date: Tue, 27 Jan 2026 15:06:42 -0500
Message-ID: <20260127200644.11640-1-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

This patches adds debugfs read of the firmware mailbox tx/rx
and of the tx/rx rings for each napi vector.

Mike Marciniszyn (Meta) (2):
  eth fbnic: Add debugfs hooks for firmware mailbox
  eth fbnic: Add debugfs hooks for tx/rx rings

 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  12 +
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   | 407 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   4 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |  20 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   6 +
 7 files changed, 450 insertions(+), 2 deletions(-)

--
2.43.0

