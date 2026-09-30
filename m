Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522154E7802;
	Wed, 30 Sep 2026 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781533; cv=none; b=D+Do7pF49g426UDhtleIVF7kQTo3SL49X3bZmLCV93Erut9M5HmgDDj7LtR5x2uP5sryApkFg1BAnCV8ETcQnNtGo7Lpa6sdoziR3KOm9hAhy2kNcVSn2cFtyRGdnWvOJiWEMyiDPI5bFvAi3SdC5On7AHoIwtGRgtA9DOxB9Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781533; c=relaxed/simple;
	bh=wHZvKDJpdYkYtVLH+6Nx+LiATsuF9iZiJiyfxDbFogE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JBz+eR1Iv5ZXgN+KM8vQnKIz+q07QniAjSHRdOn7f9s3DwT3LR046hfNtk1TECxKmZvkOS6JtZWfhXtw1lFWdae/h+VWYV9BPPYN9fD/tDqX4sJ7oyr2TEkHb5uGq17bQJAweTRhoJRY7+RCDcoiLGWrsUFandWX991BW+6ylio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=lcqkSA2o; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="lcqkSA2o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=lcqkSA2oVsPIjUR0knCJusRDAoY5XGVdCmJq0l/a0kZ+6gMuSQlGzk3VLmKfLGjANbVu2iKrl1YnC
	 ny7dB1w8Z/WfQOOpjw3vSZbo3eNXUbaJ1mpho9wLsrQcAaRIap+CFI/JTwWOxB/M9qKJktx299vlSB
	 nwro8EsGExd/CJ7I=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86abd278e850-2d838;
	Wed, 30 Sep 2026 23:15:33 +0800 (CST)
X-RM-TRANSID:2ee86abd278e850-2d838
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.22.250.209])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86abd2783ebf-02a35;
	Wed, 30 Sep 2026 23:15:33 +0800 (CST)
X-RM-TRANSID:2ee86abd2783ebf-02a35
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH net 0/2] pfcp: fix two bugs in the receive path
Date: Wed, 30 Sep 2026 20:48:16 +0800
Message-ID: <20260930124818.114224-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two bugs in pfcp_encap_recv(), both introduced when
the receive path started filling in PFCP tunnel metadata.

Patch 1 fixes a metadata_dst leak when iptunnel_pull_header() fails
after tun_dst has been allocated.

Patch 2 makes sure the SEID is in the linear area before it is read, so
that a short packet with the S flag set cannot make the driver read
beyond the end of the packet data.

Haishuang Yan (2):
  pfcp: fix metadata_dst leak in pfcp_encap_recv()
  pfcp: make sure the SEID is linear before reading it

 drivers/net/pfcp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- 
2.43.0



