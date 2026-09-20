Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C28B1AC45D;
	Sun, 20 Sep 2026 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789919379; cv=none; b=crfDQxN6sFfbdTk+hUv3WyH859wmcpztUeIIHD2GJiy7b8avkzpdU9e6nG3nSEf9WdeKzbj8037htgqlJbDiLcb64Y05g337yH+YjCD5hTL5ZmkN7rkW/3O3FyXS0sxo55jlrKC06Yh5mHAIPj2KQUyI+1wsBsw/hBsBavv0LHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789919379; c=relaxed/simple;
	bh=z4VzVCKV6WfD71yhcxS1EiVFdbatrIMwXcVr3TT5Vxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kEgwCQermUThC26Z66sLLv3jRPkhBp/etG1SLShRimWOZpZkPh+ko1QzQcfdY/LYl6ruaMOInGDSMzbHw2kS3ae7poebHewdD4ustf4nyGwOzS93BeAZN6+h9Ehx6RpAG9PgU/Lu8Q2FoWVpBT9QVfpcMkc4zaNM18v7CZ23h8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=Lv1yaUxT; arc=none smtp.client-ip=85.220.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="Lv1yaUxT"
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id E75D3240655;
	Sun, 20 Sep 2026 17:44:04 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id A6437240350;
	Sun, 20 Sep 2026 17:44:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1789919042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tBsn9miQQPKGSJtsD4pDOgRy//TQgMGIazpQogwAOVw=;
	b=Lv1yaUxTsNMfDv5dsheRuWQA02pXjEeH8YUeZfwf4fY17FWwuv24TYjViUsDNX9+w3YMTG
	q/EFpzM1DRm7XZO8JzDzFrkMEhPDGRb6+H+48mejUGbzQXwkXdZ7FWVF1qVuymuqpZrYz2
	09eYSQbfDO9NTXOv2mTi2zUz+Ay0vb9YRVRvZAu4wO92ynWU50BN0rxJekDo7fdMAGaa/u
	6NyVCLagWAPMBgx2waDffCvPRBJ/bwoJZ8g3vC6q6c6+GmYDYwzdne92laO0QLSgeeVQaf
	5HwytlfkCCMBGheon7+uVtyVS6QF+dEM3bIPLa7eUQz3ItWJjY+JXvv/o9nimA==
Received: from Til-Notebook.lan (unknown [IPv6:2a00:1f:5743:bc00::d0f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 5D47224027A;
	Sun, 20 Sep 2026 17:43:57 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH net-next 0/2] net: airoha: Add XDP support
Date: Sun, 20 Sep 2026 17:43:27 +0200
Message-ID: <20260920154329.161755-1-mail@tk154.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: f4f184
X-Rspamd-UID: 6eb56b

Hello,

This series adds XDP support to the Airoha Ethernet driver.

Patch 1 adds the RX- and TX-path support needed for XDP_PASS, XDP_DROP,
XDP_TX, and XDP_REDIRECT.

Patch 2 exposes XDP and page-pool statistics through ethtool.

Thanks,
Til

Til Kaiser (2):
  net: airoha: Add XDP support
  net: airoha: Add XDP statistics

 drivers/net/ethernet/airoha/Kconfig      |   1 +
 drivers/net/ethernet/airoha/airoha_eth.c | 493 +++++++++++++++++++++--
 drivers/net/ethernet/airoha/airoha_eth.h |  32 +-
 3 files changed, 496 insertions(+), 30 deletions(-)

-- 
2.55.0

