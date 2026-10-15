Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333953264CC
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066741; cv=none; b=bqiCkHHwEyHdD2l5KDPxVIZbRLyRK15sQaypVAkA1wzzJjjiSUnZuYR7cnXgQ18G77Sg/MEXWE5GqokPzXe1YfWoXmW+UGGyJmWamWOaDjDLuvpxXy75IrLBq0zQTOKDCgM/hry0CjqaTGETppZtm3p29DJIAChfkgZnjBL57Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066741; c=relaxed/simple;
	bh=i+svUFWgR0CVmdNaW9gvdHhxIb9SSNi2f2TTUhncJI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PA5U0A4mqWccHbe7ehXidT9FNsCbxUEpQN5O/39Tt2VISWGQN1pnPxaR7dapL8i755/CsUMiHu8+KVgA/jsKuh+e1kyxYRZlQIUh3Ubp2TUIYa1PKEXywQ/+bKx4wkJ0JhPDFhYBngFN4+Ma5fGz3lvFsRF1ajlrS49fXQT3mvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N4Pc5+nh; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N4Pc5+nh"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so1333733a91.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792066739; x=1792671539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8UE0FnktA/0QB+N/hruvrQD7JLt1z1nNTBQq1wQCA4A=;
        b=vZoj3pMoAOuTU7V8++qaRXyPme7kgotCyIBRvV6oG0ij5Uk0o7uf+JDXXOWgkRzOj3
         M7d7+uzzOEpXFgq34zZie3HD9rJ4UiFd25cYMimMNNaJ2dSzimwy54ALrYohMyG+LVhG
         Iisbv3g7EUW14IZ6FgVhYR67b6VR5ZOyPK5nzvwBsJ2CyJdsQjTo+/kr8NKxOnXHx3jF
         HHvCWxFRtqsqIlG4ksgyZBbGi9Uf4mkDSQNFm7t+qw+oy6YyVmQ7PL2H9DOSAzwcugar
         T42iymNBWCYbyKsqPs4LbljoEbjDk1632+SE+f2jepL1ZGoxsNCeI9KycnQcJY0SiJ1D
         9XJQ==
X-Gm-Message-State: AFq9FYJc+vK5/NN1cMGCIs28CaP1GgaHILnGXaGIWXUb/wHEsx2mtiqW
	dgBt8B8bTjEloM29Up+aNFEAROBj7IIXIF3tLTo8/tlDNBjFKLm0PIEmpbjgjsQP+Lzwi/TLxqL
	WksaYHyZ7WDHtCX3488O4v6zQokny74r3WTAPWOJWF97y4mOWhdEJIF5JWqTjq6Uea3HOO3jjmP
	iSWIsCmcAhokc0btI5qU6yziKe8Ajw8uQMwL2QOiSBmtzHBFKwjm8KaIms4hN9mZ0Jzw6gR8OVj
	MM1EePymQ==
X-Gm-Gg: AYBFou3AUuo2rjQMzzcHKsBntVoOs5DPvWFXxd0Las6kn0UWnzSwh6l9SvuNYQfy7K7
	WmUfT4V9ObqS0Y01/IHLku7x2mi4IA1g/Nncc+dgv1Useg3Tf2uOkPXS11dSeSnCwvnnu0s9A+l
	IaKLr5iJ+kxO99Mw3c7gZHS2RyCVCApLyh/+smA/hB4qYjtKl8tqYCJ8VRtqRKLCWMVg15KOM8m
	lQOly8TeUaoDLzarQkZxGzC0G96pD2jjn+AMggHwzjZp8/NjF01qJgJvfjhzxpvWirupVAzhdMK
	w4k0ardEUnOakhdAReOzgJmSTySY33vLnoUOQm8Aj2EDyIqd8ekCGPnEqxDC8AzqJUZhugIRwtl
	1r2KCA7XBPOfJipuROyPdzjF2Mg880WTA+zuGvH3DPOj0bOv84SYj/uIKv/UXjbpRBxCTiTF7cX
	mylZ4nrfIhK10w/WNufndCCqi0hgqLzKQ4UDiQ
X-Received: by 2002:a17:90b:2885:b0:3a7:b260:9ccc with SMTP id 98e67ed59e1d1-3ab3af73996mr15931816a91.65.1792066739477;
        Thu, 15 Oct 2026 05:18:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac930496e2sm511965a91.1.2026.10.15.05.18.58
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2026 05:18:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35a4d2e39acso2873704eec.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792066738; x=1792671538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8UE0FnktA/0QB+N/hruvrQD7JLt1z1nNTBQq1wQCA4A=;
        b=N4Pc5+nhUGLPQ/+fw0aMEcQTGMvrAKfjfKlk1qOuPAQvfqVSLLt1z+Riw5EdqYWchC
         x3ycNdAbXMCsCc/YCQYjwWjwcf+HkIkGgYCEPScrCT5CjoxA8DcSp2N7X1LnjwEbWb2W
         IA6DK/cySdRnADJdCcLE0MwH18HABnxRYK+xE=
X-Received: by 2002:a05:7301:1890:b0:351:13b4:9c59 with SMTP id 5a478bee46e88-3537dde3eb0mr27290916eec.2.1792066737356;
        Thu, 15 Oct 2026 05:18:57 -0700 (PDT)
X-Received: by 2002:a05:7301:1890:b0:351:13b4:9c59 with SMTP id 5a478bee46e88-3537dde3eb0mr27290863eec.2.1792066736616;
        Thu, 15 Oct 2026 05:18:56 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2954bsm64496032eec.26.2026.10.15.05.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:18:56 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net v2 0/2] bnge fixes
Date: Thu, 15 Oct 2026 17:48:45 +0530
Message-ID: <20261015121847.1933308-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This series fixes RSS indirection table and context sizing for large RX
ring counts. Patch 1 caps the hardware RSS context count and RX rings
to the RSS table size, preventing out-of-bounds writes and an oversized
memset(). Patch 2 fixes the indirection table sizing so rings above
the table size still receive default RSS traffic.

Thanks,
Vikas

v1->v2:
  - Fix Sashiko (Nipa) review comments.

Dharmender Garg (2):
  bnge: cap RSS contexts and RX rings to the RSS table size
  bnge: fix RSS table sizing for large RX ring counts

 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c | 10 +++++-----
 drivers/net/ethernet/broadcom/bnge/bnge_resc.c   |  6 ++++--
 drivers/net/ethernet/broadcom/bnge/bnge_resc.h   | 11 +++++++++++
 3 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.52.0

