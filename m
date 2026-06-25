Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE181C28E
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.0.186.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782412975; cv=none; b=Ok3CaxMkBSHji4wMHsttgJ69WY0YiEX9Uu28DPrpOMpmoSCD+OGxn06iCWylsFI27wixqJ7i9FvV5ZMO+PSEjjHuzGSBNW7NDUwGRUXbsAzHLBJQy19zWBMNjORG3X2W+yKCR85MWhjd16im92O30rZk9SlvyRsQXqMrFPk7Vhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782412975; c=relaxed/simple;
	bh=kJKNJkF5QOs4cZuQ9+D2G3nujsZcacTzbC9UogrJ7oU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D26sAvQdQbZazOfgFQET2yRuyTMNtx4MmqDfuz0ynMB2oCLl+IPFpwTOSRvPfz1zLSYfIgF5V0L6BiuhKyMs4JnmeiyZAz2+AkmiiAWCrSP0h6owckjQmclHLPhZJUcTvh1GZefWFKZj3b68zVDghEnIsxJRFZJDJY4bCmaDGPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com; spf=pass smtp.mailfrom=email-od.com; dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b=B73CI4zz; arc=none smtp.client-ip=142.0.186.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email-od.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b="B73CI4zz"
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
	c=relaxed/relaxed; q=dns/txt; t=1782412974; x=1785004974;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:x-thread-info:subject:to:from:cc:reply-to;
	bh=QafzHX47EfvlGgwNVRYg4gzbfir7598XKcBTZi54JhQ=;
	b=B73CI4zz2tMy+06LYOADi+YWFc9vfHqT+iZZq2p7M9tH6/NnfB01KvXAvjshZxnNX/R1VBK8WzXt853L7OaBBWQd344P/c92NvJo3/zbcAyIoBqv64NPOIDAR9pjF9YC5UiBnzCk8j/dT6fPPKTFr6HQ7f6cbcf9eW68JVL01jE=
X-Thread-Info: NDUwNC4xMi4zYjRhMzAwMDJjM2MwNTQubmV0ZGV2PXZnZXIua2VybmVsLm9yZw==
x-xsSpam: eyJTY29yZSI6MCwiRGV0YWlscyI6bnVsbH0=
Received: from nalramli-fst-tp.. (d4-50-191-215.clv.wideopenwest.com [50.4.215.191])
	by nalramli.com (Postfix) with ESMTPSA id 873A72CE019A;
	Thu, 25 Jun 2026 13:42:31 -0400 (EDT)
From: "Nabil S. Alramli" <dev@nalramli.com>
To: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	dtatulea@nvidia.com
Cc: dev@nalramli.com,
	nalramli@fastly.com,
	leon@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [mellanox/mlx5-next RFC 1/1] net/mlx5: RX, Fix refcount warning on frag page release
Date: Thu, 25 Jun 2026 13:40:58 -0400
Message-ID: <20260625174059.2879717-1-dev@nalramli.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello mlx5 experts,

We have been experiencing frequent WARNINGs in the mlx5 driver on frag pa=
ge
release and we think it could possibly be caused by a bug in mlx5. Could
you please review the attached patch and provide us your guidance on
whether or not our investigation and assumptions are valid, and if so,
would it be possible to incorporate this fix into your next release?

Best Regards,

Nabil S. Alramli (1):
  net/mlx5: RX, Fix refcount warning on frag page release

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 39 ++++++++++---------
 3 files changed, 22 insertions(+), 21 deletions(-)

--=20
2.43.0

