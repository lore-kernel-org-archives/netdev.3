Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2E23BFAE0;
	Wed,  3 Jun 2026 03:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780457625; cv=none; b=JqHdRnBSF4NBlZQrR7w0Be0aIep5xnocG4+rrzMdaYCZbCWBsC1Yo84WM/uAuo5bDb1y66b67770peCGwmJJMBUtcP7jgU6+hecJQp4gLvsnRY4EXJsAAZT7ajQBxdfPv2lEo31py3mMZ9zTWQmomhyS2JoKQ5ykoQU1rnjSK5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780457625; c=relaxed/simple;
	bh=Tjmzo/Rh4lCuGvDyzI+1fPtCJ334F/mbAqZS1dUmmUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q0PXwsCrMwADxGoxJW5GKMBnbyfo4uzNSrngufsfvCozJ2xz4l8fCD5MYJ86Q5Rnup2ArZ+YmOo5WbBZ8mSizNo8u46NBZQdI4uvyULG/xBi9iNjSRGgQh/sse9NGzJCwNGvenZvTp0Pngt7XPkiHEj7EZqq1Ejz2TvosnizlNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=CVqqJ3qg; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="CVqqJ3qg"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40da5bf7e;
	Wed, 3 Jun 2026 11:28:23 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: sln@onemain.com
Cc: aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	zilin@seu.edu.cn,
	dawei.feng@seu.edu.cn
Subject: Re: [PATCH net] i40e: fix netdev leak in i40e_vsi_setup() error paths
Date: Wed,  3 Jun 2026 11:28:22 +0800
Message-Id: <20260603032822.763195-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <eb74ae1c-3027-42f5-ad5b-a6f2c2cd6a98@onemain.com>
References: <eb74ae1c-3027-42f5-ad5b-a6f2c2cd6a98@onemain.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e8b866c3c03a2kunm3ab0b4b71d9396
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQkgfVk1NSkNLGUIZTB9ISlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=CVqqJ3qggwqt7spIFygPCJqsy5Mobw6JPPgnGpJa4dpzyVX4J0T1kwFR1uTmzH9rddA3AJJVCWJzOFIAceb/T2y/Wd1sVCuBN58MlXIZAXadfBQQ8OX90T4hdX+Qqgeoy/RAMQPm03M9Z7GCGSSPYko5yTpk+tSot1omh1VC7Ew=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Tjmzo/Rh4lCuGvDyzI+1fPtCJ334F/mbAqZS1dUmmUM=;
	h=date:mime-version:subject:message-id:from;

Hi Shannon,

Thanks for the suggestion. I took a closer look at the cleanup paths, and
I think the localized v1 fix is safer here.

In particular, i40e_vsi_reinit_setup() has early failure paths that can
reach i40e_vsi_clear() before unregister_netdev() is called. Moving
free_netdev() into i40e_vsi_clear() could therefore free a
still-registered netdev.

So I plan to keep the current v1 approach for this fix, rather than moving
free_netdev() into the common VSI teardown path.

Best regards,
Dawei
