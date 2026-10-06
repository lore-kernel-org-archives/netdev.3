Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6764A014E
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303832; cv=none; b=mmWwYsw/LwGIgej0R8W+k88kddYwyX76wl8CflXtkCanbVxt6XuTq6j+yxm/WuKBRFhgbTmZESZ/+itVpMqiH0jPG5R209ltz0uzddoLtJ/QpGeA7COBmI2oN/o54uiCuMgbVDp5aeJpO6Iwf6wAJUgq+xA8vKBlg2b/j/Esr6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303832; c=relaxed/simple;
	bh=5QSdoeQyOeaQ2nPRgt43kjsQrDVLF6Qe5SQ77InDBk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zi80Bb5zB/TrJsjxAtsAZXkXWptLfmK1oP9gDe7D/MD64UjuNc6Uxtay9Mjuh4JwyQr6NTaitBOFmMPWJwPIXOJHCMJSFuEQKQR1askxI753Zkli/DG66iKWqXgPXK5M7qgvtRZAxDk8HTrOTGSGF143QX7OZmS+BKv0Q1w8WD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UU59djDT; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UU59djDT"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3a7fecf8440so595615a91.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 09:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791303826; x=1791908626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NjN0Qep3AXtJMLugfSyEYf4+Yl9Dz3rPxAXCvJ82fTM=;
        b=Z8LEO1znjENnt5eynmkr/Infvol/ntVjwafO+hwXENzlJcPMR0fwM6PUbWTssQz41g
         i2FPTiDKb5DlZJJitEOqDQVSxNl8wQy+ILoROLjEo31+6EggANiPWuAS+6/aCjAZkaeg
         Itl+sYf2OvV7vLqlnaoj2ZKCpPaiCwj+R7ijnANqF7fdpICM0x+RFqQwyJJfHz0JTD05
         WUtMnyvIR2i0JAAPIeqdF1Y4A/hCEp7HmsyKCDBCevdgzqC4fakJm/dmgoRm37DpG+P7
         /6Jc3ubMJJk7B4h7FEcDuG88NV1Hl2P2D1KHPSyQQ1cVhCWT2UPoNCDgwvhxLPOCYSin
         5ibw==
X-Forwarded-Encrypted: i=1; AKwUvByEJbioiNlLN4kdfX61yDgO4rB5BfFQb2pTewbvOZFKcfJgOA9Wt39YQmQF4OMxtxn6snVzfbs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVvNWL/zZVMW+lH9yUq2uoPkmYgBWVbf/4YbIq+uLA7nEa8+Cn
	w7qk2s+RP6EA5n2Od4jQFofLpdd5TICOXXcJ7f9bE52/T3nQmq5FQQC2J5kzxmizlYEU+2R7byV
	6D6rIOsnLJJsE/obB7s+JMuxRxGIbs/mQXzIKPDMZCmYbpzZEgMwisolcn+hbgTWpqPHAw0MMiE
	OphItA6nO64NYW24SDq9zZTfrnLQU9p2PSYYneKNOudU+AR3SiqooqRNWAA57AQ7r+tCdzhf/EX
	4aC5vnmSqnk
X-Gm-Gg: AYBFou28stRZJn16aDxqoSG6G2LKNa4Uyhz8pJLxcoFY4QwOAAzqzIzIqXahavCqfw6
	oJF4YHZs9p8WAAU3i8Knn3n+Yj0jPSttsAUVKCHyvOyHQm62EsA5rYSLiK1+SYaUnw8kWlTuh6/
	YVkzrbIE9I+y9Yuufx7U3upJ+yNaFxHaBgturaI53mxscmfFB+C4sVilseQDVbMyQn//ftIzTQi
	wCrIzhK3Y9KQSZ3AG8nZIisTgXwKsKu7F+OyqaaERPqoGgqTTKF0WtlbDvwq8IhgyvdtGjnuzJF
	Jn0Jd1sujCrYFoxMgKqegeXKeXPG5JnkohxFwAnTFCeILxGOq+ZIKHosCQJDAZ7msXj36BCSQkc
	AwkEgZq9pt2eeuAMBDsTa2IkgOyyLW3Zo+PQDDMIy9PyDorv4yvoIdoF+7lLmFFCzkconH4C8fw
	ig9TsalMT1AbOL6wMQC75R2L0hVqSSAmt1p7tq
X-Received: by 2002:a17:90b:3851:b0:39e:4c7f:7308 with SMTP id 98e67ed59e1d1-3a87369b454mr1299721a91.31.1791303824145;
        Tue, 06 Oct 2026 09:23:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a85425788csm1355926a91.6.2026.10.06.09.23.43
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2026 09:23:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5350bf63ba3so81449251cf.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791303823; x=1791908623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NjN0Qep3AXtJMLugfSyEYf4+Yl9Dz3rPxAXCvJ82fTM=;
        b=UU59djDTh/Zey9jHPkk/KqObwIZSvgL7zr9tIIameDAUmGZm3/5aLURs9wqDVz5r2+
         ilSYhEqkdkiFxrnps16E+mFSCMXmIGa4v7Y/f9tRGsGhzpPoUGgS7oOLrC7jwt7snd9K
         syYS1D5iBtxh7svWwn7Iq6aWRgR2Qo26lIJmU=
X-Forwarded-Encrypted: i=1; AKwUvBwc/PzO0cXowqRqyJ2R9LAIDVo2uOrQNF4WyzrlS128y1MlaLManplLi1OxPCGepF5i8plu+Do=@vger.kernel.org
X-Received: by 2002:a05:622a:1826:b0:535:70b3:3527 with SMTP id d75a77b69052e-53570b337ddmr6045911cf.62.1791303822972;
        Tue, 06 Oct 2026 09:23:42 -0700 (PDT)
X-Received: by 2002:a05:622a:1826:b0:535:70b3:3527 with SMTP id d75a77b69052e-53570b337ddmr6045491cf.62.1791303822485;
        Tue, 06 Oct 2026 09:23:42 -0700 (PDT)
Received: from mgmt5.dhcp.broadcom.net ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5356b860df8sm9020961cf.14.2026.10.06.09.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 09:23:41 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: vikas.gupta@broadcom.com,
	ajit.khaparde@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [net-next v2 0/3] bnge changes for RoCE driver
Date: Tue,  6 Oct 2026 09:12:53 -0700
Message-ID: <20261006161256.1493672-1-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add bnge specific changes needed for RoCE MPC channel
support.

v1->v2:
- Created pull request for RoCE MPC channel changes
  of bnge driver 
- Addressed Shasiko review comments

The following are changes since
commit 2c3418fffa9d ("Merge tag 'keys-v7.3-rc7' of
git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd")
   Merge tag 'for_linus' in Linus's tree
and are available in the git repository at:
  https://github.com/siva-kallam/linux bnge-roce-v2
for you to fetch changes up to
commit 4f4b78c1e577 ("bnge: reserve TX/completion rings for the
RoCE MPC channel")

Sachin Holla (1):
  bnge: reserve TX/completion rings for the RoCE MPC channel

Saswati Das (2):
  bnge: Add infrastructure support for RoCE MPC channels
  bnge: Update HSI

 .../net/ethernet/broadcom/bnge/bnge_auxr.c    |   1 +
 .../net/ethernet/broadcom/bnge/bnge_auxr.h    |   1 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |  32 +++-
 include/linux/bnge/hsi.h                      | 161 ++++++++++++++++++
 4 files changed, 191 insertions(+), 4 deletions(-)

-- 
2.43.5

