Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202D02E6CB8
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780902606; cv=none; b=FOX/Q1ugbp+3GcST64aSiEq4P4X/88U0R3AJEUGl3oV21RylehOFLpRKAPsN1YMEx39xv5YBklo8RLtU6gKTsROcgaAeNtgLOrM5qslrXo+jI4W2AGP9rVIJ2scmdm7krrYmXw9mhy0Agmr8fjxMV35EcwmPPMXh6iHExG+08OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780902606; c=relaxed/simple;
	bh=FPU6ZZSWbmtJRNRRYPgfsIG7mdKktKajqHvlHdZhhP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gBx9IblFi6u/yXZZzUaEIAWdPwCtNabCXf2+1iFALaeYNAhtfYdOSRMfEcrDfTjZSZziTLN9FkKS4Tp6OJ8zplFi33bEPGLZ7ZIOtycvs29mlhkfwydY5WaNHCU+oUi9t7dAD32EtnefNit77astguEWKuhnwAh1lw9tBH4vABE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz13t1780902536t0fb5b13f
X-QQ-Originating-IP: DjFP08ug7f5Ljn8/qOjseuzvy/yAAxwE5KXMO+47ho4=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.184.84])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Jun 2026 15:08:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17286028086524605664
EX-QQ-RecipientCnt: 11
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v3 0/3] net: txgbe: fix module identification
Date: Mon,  8 Jun 2026 15:08:39 +0800
Message-Id: <20260608070842.36504-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NWy4VZNGBv1F4Yaacy14AouuHtC0rjbzeiyRohd++c4FAJbrKUvH6Qj0
	oKcB54x7WARcTdg8lu2Ag40UjwR5WoNL4F8ryKNa0hmv+if0KB7JA5TSbzqk0QfhX6DLhN1
	23kdhEaEYQRNb1q0B5ABL92etlio939B9M49i9mEGZkj1660HxJqo0YyKnpaHZuf8b1fAR3
	Lx+Um4vtegFSM94O0gUpRai/a9n+hrjF3C/MD1RK9h0l/a87ccJUsI+eYlpeIQnTDR5Qr97
	2jcs3qjw3Yb6wib6ppeXsIimE5E8WJ2mxIH4ZtfyukECTqI9u+ALhSbEfmVYms/kjLFCUV0
	x//kKiVwjQMynxwLoJT0U+En8i2avIUtuTCF6RNTbsO8po5Lxv3jv3mZdU+kdV4F6su8BRH
	0J9VE04IiDeNUcpW854pBoAt21rWpNI8FmOrdxdKGcGm+DxVCnsz6Vm3B0AHVEW8Hze/rtx
	/JUm7LtzpElrx2jnOJIXjfxRmx5Vp3jYt4K+tsANJb0t6fX8QUZOsI4XlSteLCxoMafzGMg
	hqMcruM8DdSp2kzZ9KGRS56210Su8f+sSgtQJflX+EjonMzNGvDGZokjjUO+0h/6NMSSvci
	QW4dCPg/Y1C4CCy0J0xy6KhuJ2G2ZgGg+HOrNx/KtWxLlJZCVNcyU6HeXJRFKcgHOeo3IEf
	WRpKqq4WWr4hgA+EzIvAgk+S+9Phgceik93xVlH7Tf5IAAaSuNsmqvEkCNU3eLdeqP2+Swj
	0r/Wnt7RDsSNsc/bEUbzM91LPOhQoPRK2/Ck3KTWCjFxIkLs3+T0xFF/VKKBX25nZTk33HZ
	6aMFeMtD8o1AL6NaptE2b4mynnP9/DHJ6JNSRUCe2BM5jrLUznWPwjTts6n8EjcKGHl6XU/
	JJakKgb/UMrScSateXro1/3X1RfA6lJ77gDEsCuSHc+8NVXgpXgptEK7L3wrm6DE6pDT9If
	kaXQPYFuELKmczjShDFtVmyON7P4F4lbofBrmKLhQLKNKgAdhXKH97hsvH1F9+OxWqBD6eD
	hvff7YWiaxlo/yIrri0FDbBDt0nONxoCRph7L326VJFXKhmXeqo69M8Kxx9d7o2uROkvH68
	eMNFxwx6zwAZI2zEIgqdYVquGmoxbC8ZA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

For AML devices, there are some issues where the wrong module
indentified then configure PHY failed.

The module info buffers should be initialized to 0 before the firmware
returns information. And DECLARE_PHY_INTERFACE_MASK() does not guarantee
zeroed contents, so explicitly clear the temporary interface masks before
setting supported interfaces.

Rework txgbe_identify_module() to validate module identifiers through
explicit type checks instead of relying on transceiver_type heuristics.
When using the SFP module, transceiver_type could be a random value,
because it was read from an invalid register.

---
Changes log:
v3:
- Add a new macro DECLARE_PHY_INTERFACE_MASK_ZEROED().

v2: https://lore.kernel.org/all/20260605030850.17796-1-jiawenwu@trustnetic.com
- Split the patch into 3 fixes.
- Change DECLARE_PHY_INTERFACE_MASK() to empty array.

v1: https://lore.kernel.org/all/F3DA1ECDCE0A1E9E+20260602025443.332456-1-jiawenwu@trustnetic.com
---

Jiawen Wu (3):
  net: txgbe: initialize module info buffer
  net: txgbe: distinguish module types by checking identifier
  net: txgbe: initialize PHY interface to 0

 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 24 +++++++++----------
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  3 +++
 2 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.51.0

