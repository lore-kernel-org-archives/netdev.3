Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006890;
	b=Qoq3ej5IxTL8LNTpT2BtWGlkwEFACuwrq/ZpNFFDrFxMdoexedMBMaHgiFsBj8Cy2Y8G
	 RVOEuWA9JyWpT+dN7jRApbt0YVgOZ+htUHQ55blHYbJEll7mnlg5ZKCw5jwDX4PFh8PTW
	 uU7NMHOhPdxeAfL8ft+xNPszK9egJrDoTIoIQJw4tXslgwbifVA7x8C4nZf2hyHxyOTxr
	 fWZuJ6+I6kKQIfxVsrmEnbN6O1d0HZj5fgj20v77rpAO3qrFYgE6uvn/XrmRhCG1MZqmK
	 FaNoGjxaJZfOKvfzX26pBA6C0DjePxOjiVPwgXh785dmSVfwEUprLMiEASz4b9Gb2MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006890;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=NcMZbSKk+Fr7qV28EkyvvxtcCdxcqzKGsfGHYdYZ+qU=;
	b=o5MZ3w12OpSQYk4xgMt7IMOIpF74Gx8YhDiTXRUp0C2FXrddl4PhE0O4Up5IDyvAaDA4
	 JeHQjALaEdZAs0TEjxIoyYUrfdW+LU+9et+BVQ/nsHlZnlsFuI+PqdebrBMan/xwvXEen
	 wFeC6hydf7sroklcztR9/5+JXrKGYp4wP01WIhYg6RjEgwj5MNnv6iHvS/UoSqQU/ynnw
	 sJEVQ2Tpggoz8IWK7s5YMgXQdgqm2ns2rO7kdN5y+S3v7W6nDfS3umWQB0mi5DFDAeoJu
	 NVp68rR78vHj6Ghp/anC431cnrurJn0Fo8WfPcLTQVv1ZTecpfQyX8Kd1q69J+KgzOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Xzm+K8lW;
	arc=none smtp.remote-ip=209.85.214.227
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1B7606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D1B7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Xzm+K8lW
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2e9eb579c0eso14984015ad.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 02:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793006889; x=1793611689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NcMZbSKk+Fr7qV28EkyvvxtcCdxcqzKGsfGHYdYZ+qU=;
        b=nkh5O88Tvi2crn3zMTJ18TNpd/sKp0FEw//w0i9ms7U2FnLASJykxIYF0RTWGSf/5F
         pj7Cd5W3wG5qi1EPhjmBQ6ypwdXnM0HsBeO5RzxSrGdcj0z2gpL/QelqB6k3YlGeqCFV
         RRt6ARFmr8cyBQzsGHtP5CsX6RgjOpmF508oaockHkbAhCEmCkaQtkhzbBEMZbvVPZTU
         Jv8re9HdtB/ZLcMRJ7qk6gLXMsz475dWJhbJbw1fgTh3CgAESfjM6j8wR96LE+KTSP01
         noBYNz1zIfVtI2ziFDdmBRm3sBZZiLRNdiJnuEZjTfoFivMWOAEK/dy/VUQbl2mTpbzQ
         zbIQ==
X-Gm-Message-State: AFq9FYJt5OgmwXmCZjk1YTTyQvcDUfwHZ36Yc40MsxfvVfgOz/vBAHx/
	bSH2gyJcxf31ylytVHHXle2C7OmR1kK8eKKsgVc15iAn6OiTMrz3NERCKt6t1UkXBTmrbCuXcst
	P2UbAOcle5hTThKc2KNSLWxOx3YOeYG9tOL4NaiGY1vYWqKsalQI1fHsgylICZzJLHwgyaIu8i8
	qwHyfyWVMHR9l88mLfPTbJyi1ovd9gZL+l7Yf+uvpRMI+Z35rzCsZ6YbkF6c15Ux16SJ6yCpW4l
	WI7ze3vGg==
X-Gm-Gg: AYBFou314l1TlVCG0JdC+UxfmmTB8dnk4m4MKl4zmJ9vrrr6VcOnrx6Dtimd6LNw1fA
	vF9bfQZECdRRU4UJChiuTDSaWjfHSz8UHZ7I7DnICiBO0wqenewUbpHR0iWqiTsUlXyGRLYZDFx
	1BcrbhbGTOjtAOExoC11Z6quSgN0OJ8KiGSKzOvJo4zx1QtbvdVK/Yy83GCqoPdeZM007mtDRqd
	pr527UOSRgP67/WSyUIlzlnr0YCTFpUpPd4NzY53QVzw6EwgdbzDX4Ph9jm2Gyydg5CGzMSJ4FI
	qwtncXHCdnltW/rzarMTMCUuDUezx+RKgofqI/xkuiI+IQRhc9EbEwo4rmuylzOEKq49LdECcTe
	3dG5LYfCrywPnTmlWGonhAuvoRCYbrIW3zFrRPUpfJ8qmKfgr65xUEGqqPkJ//PyGDL2yvvtl1N
	QR5CUg5Jmo+RbKCC6Rx+NsFgibBSsSayM4pg==
X-Received: by 2002:a17:90b:274a:b0:3ac:7874:639e with SMTP id 98e67ed59e1d1-3adeb0fbb29mr4805046a91.46.1793006889498;
        Mon, 26 Oct 2026 02:28:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3adebb37c12sm3042588a91.5.2026.10.26.02.28.09
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 02:28:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33713e5e6daso5601135eec.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 02:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793006888; x=1793611688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NcMZbSKk+Fr7qV28EkyvvxtcCdxcqzKGsfGHYdYZ+qU=;
        b=Xzm+K8lW0mUGk55AxqhA66uVifxA/ILn/O1KWK7w3WJDy9UhzsOPGLVNj4AMt3gX/t
         zjR+CKNRMePuUKkGOlktYKGcaFt5bRQgLPdVth/NKsM/cMGf2+mR8z6OeBLv3M9znAKU
         UIZSlUx3vciJ9NUeqS5VbLb5pa9AeXV4kJtpI=
X-Received: by 2002:a05:7300:6da8:b0:369:f655:cc85 with SMTP id 5a478bee46e88-369f655d09cmr9019263eec.18.1793006887721;
        Mon, 26 Oct 2026 02:28:07 -0700 (PDT)
X-Received: by 2002:a05:7300:6da8:b0:369:f655:cc85 with SMTP id 5a478bee46e88-369f655d09cmr9019235eec.18.1793006887082;
        Mon, 26 Oct 2026 02:28:07 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f4164886sm16711294eec.7.2026.10.26.02.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:28:06 -0700 (PDT)
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
Subject: [PATCH net v3 0/2] bnge fixes
Date: Mon, 26 Oct 2026 14:57:55 +0530
Message-ID: <20261026092757.9168-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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

v2->v3:
  - Fix Sashiko (Nipa) review comments.

v1->v2:
  - Fix Sashiko (Nipa) review comments.


Dharmender Garg (2):
  bnge: cap RSS contexts and RX rings to the RSS table size
  bnge: fix RSS table sizing for large RX ring counts

 drivers/net/ethernet/broadcom/bnge/bnge_resc.c | 6 ++++--
 drivers/net/ethernet/broadcom/bnge/bnge_resc.h | 9 +++------
 2 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.52.0

