Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD65334C0D;
	Thu, 28 May 2026 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954843; cv=none; b=VDKVOb/4d1tKyMKJ/DHQ9ycb60E1OGICnqqY3fj23Y/5tYF63ZzAYFowBPku40LsiqQDyriA9axSmV+ym/8WnS9VtEnOFlsubyNZEbWzX8Mv0fUvxIvQZgfbA3YZWSyC2EsaJzFggIFOIyGIkg4qBAQd1z6BxJv+TG62YZ9hZTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954843; c=relaxed/simple;
	bh=vl8wScL2d2cJklerzkHS7SfqmnWjlG0aZglpoxDbIPE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P/lJeFVqUuiZB1zI5JTfgaQIKl8SsOQMQaistUAx8QO2iQ9o7ByKSuA1Vo6Xoy04jPEn5ZpYuT3AJdu7kRQacOhdwS/fPxv0hOrTUpfE1lES3LvQOje9ym6wcLdU6b7q+06VjLrgMJjTwgV9vvVTdesb2G7zjb94h2fdgdJhrqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=SBEvVO37; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="SBEvVO37"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64S7qsrZ73171604, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1779954775;
	bh=upr6H4x6Hk2F2QkTwj3XjWohSS+2qk2x9trp0rxENxQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=SBEvVO37d4+iN/7mzr59h+MM/G76TJybpthSwprS/FSKvYMVu8HusGVF3uX8aadNp
	 LRiYDTYV4rOHU52LShvEdKk6U+lTjFltC9NPNW0x8+72Ko9ot9Phf5xcj4BAfwPzNe
	 +ZwrLdxeqSIfbcWp8QkDiZTW9JVTbSX8tGL4bjVec6Xz/I/9pZLAS3US+laf7kQ4Mh
	 MtmJff9lEjgEGvTWsajraacKOJm7HDPvvZXC47q/NZ1wfaXQR5gfjUNnIEQmctBIgA
	 /heQqkMA68V47pCXLf6FAt4VbFKizHEB+TAyLONm1GNdkjAAW+/3HJioUOfBp7csHb
	 HjkugvxCXZ5tA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64S7qsrZ73171604
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 May 2026 15:52:55 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 May 2026 15:52:54 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 28 May 2026 15:52:54 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 0/2] Add support for RTL8261c
Date: Thu, 28 May 2026 15:52:24 +0800
Message-ID: <20260528075226.1054-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

Add support for RTL8261c and add support for loading firmware.

Javen Xu (2):
  net: phy: realtek: add support for RTL8261
  net: phy: realtek: load firmware for RTL8261C

 drivers/net/phy/realtek/realtek_main.c | 536 +++++++++++++++++++++++++
 1 file changed, 536 insertions(+)

-- 
2.43.0

