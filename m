Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D135E958
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784684449; cv=none; b=a6tor0gTF1k/4IWw5o1xmSV3D0h9JxL3sYz79+/Y7XVY7nUle0+9zPVheXqeDK1UR6dq8bHaDauaEuefdxMfr6RxdoQzTfzgTjMk7fwS8JhvYfINtcji4tXxgWZz2VEgsBWKQbwtGQxTRUDupGWQHl2rz2dLW3SCdn89nHNUYEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784684449; c=relaxed/simple;
	bh=oOT4x1Fkbo7mXzrh9CCRi391+/lSZULDWU3R/5PADRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jnD9UGtwP5GVQD/Ndlo0BTIJ+7gEqoV0o6hjsoAjnJhb0GPv/qo5GrzKmOfPzsRhbuXfZIIgyQZXMs3eshcj7d/AQmWk4bUCj6Q8ZCaIgPcJnIOm45N0V/tMLTNyJZrY7EXWX9JPSMZ0KdVzEMdbp272nexJoKe6j7azt2cVQvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KOWhPlAH; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KOWhPlAH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784684444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b0L0kOWuCUyXkbPHeV1Q4/cbT/uo0HYYXIywIOwcaWA=;
	b=KOWhPlAHjX1lfZGX/67LjDD0qqeOuVk6h3jBrpcPuauasbI5G2rhIvgH4V6W0WwIkY1OJ7
	4immXX2fK/LOAtVqWOL3LNj6plcVf1BpVimwYLZsH8H/4qaMkyq669FNI/YbsSfLzVhExt
	PE6lc+STH8l2AmAvkQR0gOm2OsU0I7c=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: bh74.an@samsung.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH net v2 0/2] net: sxgbe: fix descriptor ring allocation failure handling
Date: Wed, 22 Jul 2026 09:40:53 +0800
Message-Id: <20260722014055.157269-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

Per Andrew's suggestion, split the patch into two

Chenguang Zhao (2):
  net: sxgbe: free TX rings on RX allocation failure
  net: sxgbe: check descriptor ring allocation failures

 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

---
v1:
 https://lore.kernel.org/all/20260720024747.504493-1-chenguang.zhao@linux.dev/
-- 
2.25.1

