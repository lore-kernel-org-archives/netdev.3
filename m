Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFF0386C39
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579146; cv=none; b=U0aC9o+BqkTFN1KZhjuxLu5+cu32DJ8gkhybo1Fp7VDRyygBzxis/Y91nYkZ0laCnetjUlkUmhwk3dNEufL/FQNbeFOIneEoE8zV9xDFVVD1fVYExHemCdWBhRPC7UZ+sV81bpkhnc0cv9DRp6plW+03KWPjHX+41CkYtaJtBMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579146; c=relaxed/simple;
	bh=ROyw1MdPB9DcByeawoAyVYPl0rLfKl4UhoYM16AC3Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQZt82XuxeHbugLCMDCOOMqRkEuBR+VlOrCVT6edl+v/enC8M0KZjGESZtqatA9vSJyI0FqjOseIrNBpb2zZZB8UdrcYzcYE/9jOwI3RrzRlwSZ6QViSosm1iJ24SjQNCjXs5/YjXypj336JUQeqt1soUVUBajgBrGFA3TE1eUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EE1W2r6v; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EE1W2r6v"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775579142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YOENZZQbNACYeoZTLDZRVd7RdcAhxT1W804j+3zTWSg=;
	b=EE1W2r6vFH2VzMeZiLglJe7w8zENpcJ/7jPFJ6k3YUrZOd0ZkFTVqKZAQKdS7KARwLpWrS
	p6K2eCYmorFVsb9897DJZYgQY7wBpO9a95bV0EdcKR4rKDIZEY8zXz5vJf3sdOLJVKAUMF
	jbK21k27dYZl3gVkjOlI+uhYAoEVcOM=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	fmaurer@redhat.com,
	horms@kernel.org,
	luka.gejak@linux.dev
Subject: [PATCH net-next v5 0/2] net: hsr: strict supervision TLV validation
Date: Tue,  7 Apr 2026 18:25:00 +0200
Message-ID: <20260407162502.19462-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Luka Gejak <luka.gejak@linux.dev>

Changes in v5:
 - Reverted TLV loop in Patch 1 to strict sequential parsing per IEC
   62439-3.
 - Retained pskb_may_pull() logic to ensure memory safety for TLV
   headers.
 - Dropped Reviewed-by from Patch 1 due to the logic evolving since
   original review.
 - Added Assisted-by tag for AI-aided translation and formatting to
   both patches.

Changes in v4:
 - Split from a 4-patch series into 'net' and 'net-next' as requested.
 - Implemented a TLV walker in Patch 1 to correctly handle extension
   TLVs and avoid regressions on paged frames/non-linearized skbs.
 - Corrected pskb_may_pull() logic to include the TLV header size.

History of pre-separation series (v1-v3):
Changes in v3:
 - addressed Felix review feedback in the VLAN add unwind fix
 - removed the superfluous empty line

Changes in v2:
 - picked up Reviewed-by tags on patches 1, 3 and 4
 - changes in patch 2 per advice of Felix Maurer

Luka Gejak (2):
  net: hsr: require valid EOT supervision TLV
  net: hsr: reject unresolved interlink ifindex

 net/hsr/hsr_forward.c | 20 +++++++++-----------
 net/hsr/hsr_netlink.c |  7 ++++++-
 2 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.53.0

