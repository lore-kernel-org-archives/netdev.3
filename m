Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56EE51475A
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983959; cv=none; b=D+mVN9Ol7T5eNeXFO9GJbiUhFfZuIw4iN3Ol4E2o4kwRkgevfhHxgapUQQNCmUBo5dFvQG3X3s9cYsiuMsKG9XRC024AJ7ivrQSItzJBrOyY84t499BpWtxcRQ6s8oY+TFRn6Na+UNsABY5Rdo8qFVVnSdnsl8Hi/QYzdQMtgq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983959; c=relaxed/simple;
	bh=TDfvCnlt3vHJTFcpfvKrM9XijlLL3vsiUM8ock/2Pjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a5jBuhctXVnoVYu60lv3cGZZbOPwzignx8YVscq/I5EG1Gm70AZ7uSmas0x9bokokXJd7hwFKeYCn2fSDGoXhY3WooBb+rO0vCIm02WCHsOpNnRs3MIVFangw46F0JrYmqMmMV2d559Jz9yElYzcS2aUKiRnIuYVKA9lHTs/+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThDDXQmy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThDDXQmy"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so9741855e9.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791983952; x=1792588752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0J0ffcbNwQFdi2bxWVwWWJHG1Wg4oUvyyvT8GnkmOas=;
        b=ThDDXQmy78dz/88HmHYl7q3dJNUKh24rMPqmaAJYQsMfsbaRu+EnX9CBW6VFxUXpz7
         k1R1jrKnZ19BI+OVY4m6SEPHs0baSrU1YrEK/N/UVu2EOz6wwgt7H2ZTnhpo138PmaaM
         l3PQcmPOOX7gCL1EJlCUCZLpLJXoG14wD7tVLWlZNLbL8qFCSY70s59SeQOX8myem+5i
         bZcCkfxXXN/soECAW4g2lua5UWM/0GwDPABHHCAk/TQUSuvPXnQvcnL9s97hhk9F3L1L
         Lb2S0I5d4C8GCpClfOLuCx5RYBoDZYs1wXesZnWzn4V3ssU+V2CZTKcBIoBLBEfUBwum
         Ru9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983952; x=1792588752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0J0ffcbNwQFdi2bxWVwWWJHG1Wg4oUvyyvT8GnkmOas=;
        b=m1dFhHeM3IJCU35uDHqu1dxPolQ9iRH9Tp7tVbj9qnpDjx8O9PFG5MNiFN4r5g5mov
         aA2/7LeZdgu5Upr+DoxPn9KRJkPm3vW83R//C3orgZf+WZjTsrD/eYbjJKYU0fzOL2Oj
         8e0k8rY4eSpwWLA0M6Wn0k21TZooXP4FPDyehAf5jP45bU02ixwy/SgFR3K3/nDhg+H0
         40+45CSNzg7Bjflw1lVaurUALS0Vrg2jKIis0D9lORk5ol1CuARYDYaTl3K5QnEv63r/
         3yRtJImiNTDiE/I9OnvqPTizyW53bGL2jVSfCX7CQuLmKa9oiSH6XFwJMZpScdLUE6ym
         E6Kg==
X-Forwarded-Encrypted: i=1; AKwUvBxRo1xUjocIy27g7ZXl0RffjAKAnvXt6gCAG2sjUSziaP5asDGqM6nWuzdHRT+wW0x4Y5WwZ3A=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPc+cEK0W5CqMBP56eLxyb25K8kTT0SxYObMPdroQBLveNB12y
	zoiMxEpLRryhcg7DYrWkJtgWoRWJOwnk5I5FS1DCZxqi2yHYT+elu9cc
X-Gm-Gg: AYBFou28B5eWtdsffx86+xGEb4899CmFRxzMkoZnB9jebNWPIIajycUD+Rytg6RMtiq
	ABKdQAInprVIQ3Ee53bOiFjFZBvTOsdpS+m+UkdyEWrZejbOTrrWm82jFfOs41tFbKSlzcfqQak
	u8gqKqDLf+O4o0H9bXFqvk/xZYnJoImRpiS8o8eEeOO6PSotfPvM9yi3PMp0ANaFL5F5e5hJG+7
	0orF6fzEXSynb5NHd9ooKec3013nx9uih42udmHC3e6XXSM5mpJXVPnNLOZrssIv/yHQiXPAsNH
	b8fpubN1NKBazf0Mn6teuHTzChtqdNw3MNHRIaVzrJuQbDjzJZySEK/p3cb4vDc1WEeddTCd2Tb
	jo3+dljdCLuuSZHjubRNg07ltKtmXjBrSJcvlYT1lA1TDITlOa7pCfJTEUzWLAFPKH/Mp+VQvEB
	Au9iFeGPrwWhXezzCN51zKAMItU4ey77ccoFZ78mHs9Tz5sGqRPPnS8fRaTDcDuFxOMB0us1yQB
	iEGyBP55kWg0c2CViQ3NVwJo53gsS7zCHJARmXdcrnH1eJ758/54KPTQOXs9H2SdvRsOAF+KsDj
	Qt3BkNvDLAvqIMgCIg==
X-Received: by 2002:a05:600c:6289:b0:4a1:a475:d885 with SMTP id 5b1f17b1804b1-4a1a475d8acmr145032095e9.34.1791983951734;
        Wed, 14 Oct 2026 06:19:11 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:ea0c:b1b4:c6cc:a0af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bcecbd0dsm1413825e9.8.2026.10.14.06.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:19:11 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v3 00/13] Add ETHSW support for Renesas RZ/T2H and RZ/N2H SoCs
Date: Wed, 14 Oct 2026 14:18:48 +0100
Message-ID: <20261014131906.990077-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This series of patches adds support for the Renesas RZ/T2H and RZ/N2H SoCs
which integrate an Ethernet switch IP variant called ETHSW. The ETHSW is
largely compatible with the A5PSW switch found on RZ/N1 SoCs, but has
several key differences in register layout and hardware configuration. The
series includes updates to the DSA driver, device tree bindings, and
Kconfig to enable support for these SoCs.

v2->v3:
- Added new patch to restrict ports beyond port@4
- Added a restriction to disallow port@4 on T2H SoC
- Updated commit message for patch #5
- Fixed typo in commit message: swicth -> switch
- Marked of_data as const pointer to avoid build warning

v1->v2:
- Added RB tag
- Fixed review comments from Vladimir.
- Added info about the IP issue and the workaround

v2: https://lore.kernel.org/all/20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
v1: https://lore.kernel.org/all/20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (13):
  net: dsa: tag_rzn1_a5psw: Drop redundant ETH_P_DSA_A5PSW definition
  net: dsa: tag_rzn1_a5psw: Add RZ/T2H ETHSW tag protocol support
  net: dsa: Kconfig: Expand config description to cover RZ/T2H and
    RZ/N2H ETHSW
  dt-bindings: net: dsa: renesas,rzn1-a5psw: Disallow ports beyond
    port@4
  dt-bindings: net: dsa: renesas,rzn1-a5psw: Add RZ/T2H and RZ/N2H ETHSW
    support
  net: dsa: rzn1-a5psw: Add support for optional reset control
  net: dsa: rzn1-a5psw: Add support for optional timestamp clock
  net: dsa: rzn1-a5psw: Make use dev_err_probe()
  net: dsa: rzn1-a5psw: Get switch info via OF data
  net: dsa: rzn1-a5psw: Choose tagging protocol based on compatible
    string
  net: dsa: rzn1-a5psw: Add fixed frame length workaround for management
    port
  net: dsa: rzn1-a5psw: Add support for RZ/T2H Ethernet switch
  net: dsa: Kconfig: Enable support for RZ/T2H and RZ/N2H SoCs

 .../bindings/net/dsa/renesas,rzn1-a5psw.yaml  | 166 +++++++++++++++---
 drivers/net/dsa/Kconfig                       |   9 +-
 drivers/net/dsa/rzn1_a5psw.c                  |  79 +++++++--
 drivers/net/dsa/rzn1_a5psw.h                  |  25 ++-
 include/net/dsa.h                             |   2 +
 include/uapi/linux/if_ether.h                 |   2 +-
 net/dsa/Kconfig                               |   9 +-
 net/dsa/tag_rzn1_a5psw.c                      |  22 ++-
 8 files changed, 261 insertions(+), 53 deletions(-)

-- 
2.55.0

