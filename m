Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317AB3955EB
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078631; cv=none; b=ibMNCxSJ9njqEkatmE7vAuGXdWUPkoZsk8YOcq4qfeD/Iq/6flCvfIMssBMkIgE9nuR31AnXrRTDgnFUvxakaMq6aZ3DmKgxRU7D/PCcDr9QxaxvrR2PwkV/co/6nCODghmweN95dpormClREeqIdBnuUTCBu+BjGDXqnJjVwCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078631; c=relaxed/simple;
	bh=TZrOT8djkYsR3Y60uYuCrKmOFe/p1F+vK6m7f9HiUVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3zVDeKySA1CjiO1sLQqtyB9M/SLp2U/yD70PbcRQDasLmfBeDvKeYZsiZky8D1Y7A+5r6hGYVnijf0Ft/j5b39bwCPixsRtJWdi4kNZXGFEKq2kq0+V919dY6Yp2UXQZP3UrHGBJvxyVDGWMDg73VuFfORQnRNXcXm0XKAXsSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=iezskWIU; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="iezskWIU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=jtUVgGwM4/4YKET5/9R7Z4VqbBkAsNEzniTbNkK+P/A=; b=iezskWIUgfC7nL+6zFZpiPHJn5
	e6R/p0d4zLok6ArmRrfN/l2Pp3iIKGmATxhbSRchzPUEc9PmXYgz5U8/917uDKuti+7DH1oFOdo2z
	DLuSLcXL5Cb4g9tMv1DH45CxatngU5b4lN2o4bppXo+Kt9Hr5b+5p8OTWS0W7N3avLpuib0Y/ec8u
	D76M5ioJjLnOVL/ZuPEzelwRK8vDKco2fUcBo8VMMzfrwnrpIOJWC0cYbLWqMByGukCuBtWzEDoyi
	887sPuBzcFp8bgciVkxGwHzAzq4DJU2UWyn/BH6/b6vW3TZd/+bAp3gcM3p2xzUHBJcGTLsQuXiof
	uSGB7Plw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wXDue-0009XB-0W;
	Wed, 10 Jun 2026 10:03:48 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: razor@blackwall.org,
	bobbyeshleman@meta.com,
	dw@davidwei.uk,
	netdev@vger.kernel.org
Subject: [PATCH net-next 4/4] selftests/net: Add hugepage kernel config dependency for zcrx
Date: Wed, 10 Jun 2026 10:03:44 +0200
Message-ID: <20260610080344.701380-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610080344.701380-1-daniel@iogearbox.net>
References: <20260610080344.701380-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28027/Wed Jun 10 08:29:13 2026)

test_iou_zcrx_large_buf in drivers/net/hw/nk_qlease.py runs iou-zcrx
with rx_buf_len > page size, backed by a hugepage-mapped area. Thus
add to the Kconfig.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/drivers/net/hw/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index cd20024218cd..ed8642b68094 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -3,6 +3,7 @@ CONFIG_FAIL_FUNCTION=y
 CONFIG_FAULT_INJECTION=y
 CONFIG_FAULT_INJECTION_DEBUG_FS=y
 CONFIG_FUNCTION_ERROR_INJECTION=y
+CONFIG_HUGETLBFS=y
 CONFIG_INET6_ESP=y
 CONFIG_INET6_ESP_OFFLOAD=y
 CONFIG_INET_ESP=y
-- 
2.43.0

