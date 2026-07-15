Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571C13CB918
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104058; cv=none; b=qqgzE0YWfqHzAV//xPXaJBfXpbdZz88WzrwJr8E+RJdFmIf/ibtz1jVIL4AAbrJ2ISuJ3vQRVnUHYfJHUiR7TqEfAZL+omYnlELfylypLOyoZDJ/gQeew4JFoqBUvq7BvgZ98avwscXbVSMJj06A4FuZgwMGm1V4RRdMFBvAAcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104058; c=relaxed/simple;
	bh=nKd84V/9X2y89yu7OGQCN/8khagFxgbbCnrIv34xDZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tesuJnz5ijgp5vWauWS2MTiKJRWAovLuwkz658J/RWUC+EyfIo2wpqf5CEul+SZ+7pMNFQLgeb+HXmxDWj13jsMWA62XzYRGf2GFK9xSw5F7GjFMaa4hyFqPDNp4ge/4P+qR5ZdePJt1ikW6HsZpGL6MVWsiQSOtfx+y3zA09lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YgBrBjye; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YgBrBjye"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784104054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5zxSO+IiC/aaC3ze1Xp0Plh4QW43E7b/Q2x8rCpqKQ=;
	b=YgBrBjyeXwATe4y8fj92081fvgvxwEYXr5EgJazBct+C6+8lAewYvYoAXJOWa/67RO1E/U
	XFHtLTq6c95SQaNnMdqNiwrd7TG9YAN2c/pGTWMNny0zwJGHuQVSxDY7W0hbi/F9rUxk6l
	c5rGR08p01eKodOsqpIxEG1JJJJVg8M=
From: xuanqiang.luo@linux.dev
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jagielski,
	Jedrzej <jedrzej.jagielski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Mitch Williams <mitch.a.williams@intel.com>,
	Greg Rose <gregory.v.rose@intel.com>,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v2 2/2] iavf: fix QoS capabilities memory leak
Date: Wed, 15 Jul 2026 16:25:48 +0800
Message-ID: <20260715082548.56687-3-xuanqiang.luo@linux.dev>
In-Reply-To: <20260715082548.56687-1-xuanqiang.luo@linux.dev>
References: <20260715082548.56687-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Commit 4c1a457cb8b0 ("iavf: add support to exchange qos capabilities")
allocates adapter->qos_caps during probe, but iavf_remove() does not
free it. This leaks the allocation whenever an iavf device is removed.

Free adapter->qos_caps in iavf_remove().

Fixes: 4c1a457cb8b0 ("iavf: add support to exchange qos capabilities")
Cc: stable@vger.kernel.org
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 29b8403a066bc..c7f69a9040588 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5589,6 +5589,7 @@ static void iavf_remove(struct pci_dev *pdev)
 	iounmap(hw->hw_addr);
 	pci_release_regions(pdev);
 	kfree(adapter->vf_res);
+	kfree(adapter->qos_caps);
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 	/* If we got removed before an up/down sequence, we've got a filter
 	 * hanging out there that we need to get rid of.
-- 
2.43.0

