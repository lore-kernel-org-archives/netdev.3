Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892D2EB5B8
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776014017; cv=none; b=Eh8WU77mYIFshP8ynjI3YoCwRgFkZX5PygKpN9KG9ck5xxUFWB9WXpNP8fyuJ8icdmhhxXhIlZgIWp+pTVLb60BQQowONZUwsoPM25F/h21nd40H9GvzMIXTx25S/yiwmzxP0T0gHEteE0jjiV019YmFgiClyvLtlsrfx6Bg/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776014017; c=relaxed/simple;
	bh=hjHOgP42jyOjhXmhZDTRmIeJi3voOL/RA+RDlx4s1zU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rSh7/yZCfzlHVGxT2nQrNQ7xR9/6+9UkiOjMRGBImx/untUtmhyIQ/rQX8NZZixCm/DwxQprW+gyxxnKAibeikuRl2XLtBNdJbe+dI37jAEFJUZjIb1EYA9drqLPpzWjaE6iCEbpjbDbS7CIIV3rV1pCiB1QWD3ToyZwFv6dF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7vkhePs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7vkhePs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E4BC19424;
	Sun, 12 Apr 2026 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776014016;
	bh=hjHOgP42jyOjhXmhZDTRmIeJi3voOL/RA+RDlx4s1zU=;
	h=From:Subject:Date:To:Cc:From;
	b=r7vkhePsh0GW6/snUukc7DyFTROM4JYNdyCPBtLdgMDtL5PiqrJlPLN7EAWUGPkkq
	 7i5FpwagNNMgUNoVTdFDy45v5zniq2fp7IQWKfGJJrAz1o52n/jYz28TSlgxQ3g311
	 MuX73X1nSdu0kYLtUxaKa+s3UZJ0r9DKLipcpEyk/Gn+ftdoserAUi1BfLwZZbljsh
	 7um0WjYQE44XuiKpXPi42tynykh2e7eR5WEfRKYvRbX7IIyT0Fg8ZV3RwGAMJAhreR
	 Xoi8H+SKuzBSrbPr+aS6HMaoFppKeeW347J/o82HkTG7cGj8eNdnV99u2URiqQJ+1d
	 9+pvizHR8kcWw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/3] net: airoha: Preliminary series to support
 multiple net_devices connected to the same GDM port
Date: Sun, 12 Apr 2026 19:13:11 +0200
Message-Id: <20260412-airoha-multi-serdes-preliminary-patch-v1-0-08d5b670ca8f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2N0QrCMAxFf2Xk2cBarKi/Ij7ELrWBrRtpJ5Oxf
 zf4eOCee3aorMIV7t0Oyh+pMhcDd+ogZipvRhmMwff+0p+dRxKdM+G0jk3Q5IErLsqjTFJIv7h
 QixlvIbmYwitcXQD7skWS7d95QOGGhbcGz+P4AV0z2KOBAAAA
X-Change-ID: 20260412-airoha-multi-serdes-preliminary-patch-95f1cf5b5815
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3

EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw arbiter that
manages the traffic in a TDM manner.
This series introduces some preliminary changes necessary to introduce
support for multiple net_devices connected to the same Frame Engine (FE)
GDM port (GDM3 or GDM4).

---
Lorenzo Bianconi (3):
      net: airoha: Rely on net_device pointer in airoha_dev_setup_tc_block signature
      net: airoha: Rely on net_device pointer in HTB callbacks
      net: airoha: Rely on net_device pointer in ETS callbacks

 drivers/net/ethernet/airoha/airoha_eth.c | 85 ++++++++++++++++----------------
 1 file changed, 43 insertions(+), 42 deletions(-)
---
base-commit: 118cbd428e434bc1b8aac92a74b4992c7683f0fe
change-id: 20260412-airoha-multi-serdes-preliminary-patch-95f1cf5b5815

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

