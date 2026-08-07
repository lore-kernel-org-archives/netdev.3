Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE9A1C5D59
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127986; cv=none; b=nfGy3agySTktEc2u+xd4TWFXNnsPIOdhc6pxXhMnaRv2WTdZV8GvKvN3xFc/ciUjbtg8KIz64cBPbtHIVgx+E2ocjs9tySXTa77lDSbW2OQbh/tpVNxZPp5WrIY6s623xsZ0de0syrKdvSX2r7zJ2vUOQiiTG7EP44Yi6fsyWBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127986; c=relaxed/simple;
	bh=IzPmcRJ4AgDYRWiKH693rYRs6l7oHafS/JmoHHbw1Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h8ohmqIkuH0FpXs2MKe+4IuMdCcILI7XuUB4bMP+Acejsc6liLQJkDyU5UjRz/tClLm+0YU7CDr9t7TBHgdipqmevwN79W1qY6WVmuAZkeb/yY0qGHpgJB6fwIs3tuT5XNSQ9fzJSW1zhxysRjHfLHYBpAWFU9yLTct0F3+3mfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NxF5e2Xh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NxF5e2Xh"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so37129575e9.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 11:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1786127982; x=1786732782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Y/2I1qMhTbN5OiL5ZOkSR3I6MY/IGkPfgkqdR7RNwc=;
        b=NxF5e2Xh0M7nX1u3FkAYR5/9SDMSF+CmC9bg9VVXHoJ0IRPv7AJSaLlAMsEye5PCnh
         aYa1pLGPZZjcUdHZ2cTVzCRLRM/EJVv63A6aQPtYH4yolQ6+GdvwXCbQfaJRhRo67PAT
         QcfnZnFXf8V7fMtZMyv8j3dz1TJw/OhkIp4/EEPWSUOgWj3vePTKhFvwXYTIJgxFFPGi
         yrNzYLQ5XsEjJafBEYAE5iQMZPvgAT99IbFmmZcBmrXLo/e7uxEGle8XZU+zHL4XCPXr
         DjH7vMjQ3ilCdaMJVxhIz6Xae65TxwEv89aOsDTcf+eZW8pRbRD44HjMGSch0+mKBoLY
         uI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786127982; x=1786732782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Y/2I1qMhTbN5OiL5ZOkSR3I6MY/IGkPfgkqdR7RNwc=;
        b=jDEBi47BpKGer86aYFrJuoOAhgYTfFVjNiWyK5DtVwsY8eb7bWt8zb1iDdssosKSkB
         NmIOJAoOf7p0kXOdq230VBOlmeVL9r6HQAMqvwQcwDDmR5vAYAI+wtLUlGQAmkyOeuvB
         10tuO3vauyzjFoEZu4tX//nY1QDymWvGCMcXeF+JozmArPPMY2174cdGPG8hOZBwihUK
         LaA7Vv7R0gBQrY8k9mmistZoPdGj2xoi0c+k/5UJreraj4ZHIGeILQWLy2UUe4OfZy31
         K6S40xm1iaXzpVeumY9hYROpwATjQZUWyc+1VXpJuZKIDm1RHpA8jQ/HJ8ovtfWiZFbY
         5JdQ==
X-Gm-Message-State: AOJu0YyCyuIHPzMFNDKBC+VsfU9IS7tBm98vVXUt8ryqiER+OspurVjt
	5c1H4ZTiQVj5D0CaD78uU/thmKmW1vYJzmI9xp202PSwtWT7DSHe4aPqyIe8JQ6BoQvZbcaP/UA
	J/xeAVF8yX1XqLIU9GL3sMqNSXCiwU5B6toGyT8shR+8hNAUrIoWbhjOJ1VFMwI7MUfrYba5GuH
	MTuXVx8nT6fmUaAPQ3OSCVFGEOg9V8dmmZvMV/FNtKJXcMi6s=
X-Gm-Gg: AR+sD12x15xLBcpP011pH4haQRxqYNhk9IPqGDB7wLdOmvFll3y3lSVmWvXoi8nWxpr
	lmtssoei9DwZ4UerX0aXZIefOTcGIAE3jjRK+bDiqMz9E3GbxTmPhX5DERLUn3rJLkWXNvSIttC
	L38iswLps8+GBUvA+4Idv2dUKr1uT9pGhdluW+qOB/1T0GjlTX8KYIteTWf/+0k1RZxS8wMlUDG
	qd+nDguVCW+e/h5TdqaIwYlpFdBc8vVp23BC2M+V1ukfaFCYR5H7UJWQVpSEedtDlkM/B1vH+fL
	0YmlFBJ5ojkFubpyDFU4Nyr0hCg+f1tlN0XoFp7majmTTcqdwUZ8B5OcY8GbDWaYCB8qqqmRzsC
	0DMHNEDC+xmsag07VJUjIQBZ9YpD70BELjXiAjJQPEOZ6fpPhB/SVgnVab7vf/o3dOPFKi1Hp+z
	ssVqh4yff6GZtcz3unmMlpKHEO1vBa2Pd26MegyP6oJuWSoUTIfpqjfPIFLhcBa75JkKrJxt/1B
	kxyt4yDf5qRDO9qfSlF6GEQYQMDdb8ENAJw5h7OuUZ53ip+/s2hknHiQGE6FgniaVSWtmBQ+gz/
	Ax87vlEmWJSOpCEmWE+wyeRaOFshIVRmv7Gyy0EetojEeN153Unu7SrVpj0VnSq+lIaH6EK3Iew
	iaOGR0MU=
X-Received: by 2002:a05:600c:a47:b0:499:484a:7644 with SMTP id 5b1f17b1804b1-49959e2eb00mr140337935e9.9.1786127982439;
        Fri, 07 Aug 2026 11:39:42 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-499541b86f5sm166106135e9.0.2026.08.07.11.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:39:41 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	andrew.gospodarek@broadcom.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net-next v16 00/10] tls: Add TLS 1.3 hardware offload support
Date: Fri,  7 Aug 2026 12:38:43 -0600
Message-Id: <20260807183853.2288959-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

  This series adds TLS 1.3 hardware offload support including KeyUpdate
  (rekey) and a selftest for validation.

  Patch 1: Reject TLS 1.3 offload in chcr_ktls and nfp drivers
    These drivers only support TLS 1.2; add explicit version check.

  Patch 2: mlx5e TLS 1.3 hardware offload
    Add TLS 1.3 TX/RX offload on ConnectX-6 Dx and newer.
    Handle 12-byte IV format and TLS_1_3 context type.

  Patch 3: tls: reject rekey attempts on an existing HW-offloaded connection
    Prep for the following patch ("tls: add TLS 1.3 hardware offload
    support")

  Patch 4: tls: add TLS 1.3 hardware offload support
    Extend tls_device.c for TLS 1.3 record format (content type
    appended before tag). Handle TLS 1.3 IV construction in fallback.

  Patch 5: Split tls_set_sw_offload into init/finalize

  Patch 6: Prep helpers and refactors for HW offload KeyUpdate

  Patch 7: TX KeyUpdate support

  Patch 8: RX KeyUpdate support

  Patch 9: Tracepoints for RX KeyUpdate path

  Patch 10: Selftest for hardware offload

Rishikesh

Changes in v16:
  - Addressed review comments

Rishikesh Jethwani (10):
  net: tls: reject TLS 1.3 offload in chcr_ktls and nfp drivers
  net/mlx5e: add TLS 1.3 hardware offload support
  tls: reject rekey attempts on an existing HW-offloaded connection
  tls: add TLS 1.3 hardware offload support
  tls: split tls_set_sw_offload into init and finalize stages
  tls: prep helpers and refactors for HW offload KeyUpdate
  tls: device: add TX KeyUpdate support
  tls: device: add RX KeyUpdate support
  tls: device: add tracepoints for the KeyUpdate path
  selftests: net: add TLS hardware offload test

 MAINTAINERS                                   |   2 +
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |   3 +
 .../mellanox/mlx5/core/en_accel/ktls.c        |  10 +
 .../mellanox/mlx5/core/en_accel/ktls.h        |   8 +-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   |  14 +-
 .../net/ethernet/netronome/nfp/crypto/tls.c   |   3 +
 include/net/tls.h                             | 104 +-
 include/uapi/linux/snmp.h                     |   6 +
 net/tls/tls.h                                 |  24 +-
 net/tls/tls_device.c                          | 955 +++++++++++++++--
 net/tls/tls_device_fallback.c                 |  82 +-
 net/tls/tls_main.c                            |  77 +-
 net/tls/tls_proc.c                            |   6 +
 net/tls/tls_sw.c                              | 167 ++-
 net/tls/trace.h                               |  98 ++
 .../selftests/drivers/net/hw/.gitignore       |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |   2 +
 .../selftests/drivers/net/hw/tls_hw_offload.c | 975 ++++++++++++++++++
 .../drivers/net/hw/tls_hw_offload.py          | 295 ++++++
 19 files changed, 2613 insertions(+), 219 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py

-- 
2.25.1

