Received: from mta0.migadu.com (out-209.mta0.migadu.com [91.218.175.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB0351C1C
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122278; cv=none; b=urfs3uLu9frjw2UmrkZOijxSADZfnV/s3uSdHflx8aADPYkdU8rkm8gYqcRFAvnw/d2JDPrMoInuYXuO9uK+x75GLnSpkVBHzCCbKTH3I2hCCkIxaqH9Hh8gaws9rfPHe+ICO66+FwrIJfPZDDwnwxgHMeKLnEgWVOUyOwau1Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122278; c=relaxed/simple;
	bh=GZ9XCy51N84hLwS6YMI9q+w9fAu9OHx8RzX/rDGqhWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qUyX/0XUNxAF60+noQ3VaXOXMIMwx1Yvsmr4DLgPWTJCjfbZBfPzoFHuDB2FT5iFR+kux40IDwnn+/l4pDvkrTKXJZxOAiubl4yJsOQK7sUl2jXDpQqquO4Pb3EUtoi+5MzehTHPF90inYD0u+tSh0Kl6nMhnJcFkIdNRwSwDtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OHTBF8on; arc=none smtp.client-ip=91.218.175.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OHTBF8on"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GZ9XCy51N84hLwS6YMI9q+w9fAu9OHx8RzX/rDGqhWI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789122273; v=1; x=1789727073;
 b=OHTBF8on2KhzPcwvCDx8p30zkuRzo9VMmycpTq+8/9x/BrQ4TVC5ohrLuSdFgX3PihfaAufh
 /yxjsBje8h82qBsy8mviNDYDEFi9IqkBgbJ/vP6cUAlng4Q+0m8wqpcMnw8K9Vqqh6p8ulKiLax
 Vj2pfuSTOSt8KvK7hEOrseHQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 27b3d04cbdc75e18;
	Fri, 11 Sep 2026 10:24:33 +0000
X-Mizu-Trace-ID: 27b3d04cbdc75e18
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v1 0/2] ipv6: make IPV6_FREEBIND and IPV6_TRANSPARENT lockless
Date: Fri, 11 Sep 2026 18:24:16 +0800
Message-ID: <20260911102418.157071-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Move both IPv6 setters to the lockless setsockopt path.

Patch 1 handles IPV6_FREEBIND.

Patch 2 handles IPV6_TRANSPARENT.

Xuanqiang Luo (2):
  ipv6: make IPV6_FREEBIND setsockopt lockless
  ipv6: make IPV6_TRANSPARENT setsockopt lockless

 net/ipv6/ipv6_sockglue.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)


base-commit: 348ea4642f56ab3dc93621c8e3ab0ccd0e5f1782
-- 
2.43.0

