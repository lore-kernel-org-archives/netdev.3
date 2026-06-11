Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACB930E82D
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166335; cv=none; b=cQKS/m+GWtGHDvDbZMVhoB+0UufMHqUmZIoaVBs7YiKezObArf8YDFrxRI3Su2TT8QhkNMxtJSV9dD4kncfQA3j8BIHLBkOFmnedORZpZndvfz1aekuXvmdvmu6QY5+tNQ1g2tgCU3rmadDUzXpoRRzBv66Pbh78tHu6cXPwSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166335; c=relaxed/simple;
	bh=WlxapzB9/qhluL8vXEKS0t0tYicVH7BeGoejz2BxDX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtgDgUu55p2tg2TMKxYToK7DuMsPelm/EAcSCMea6svMHhOFwv2e5gPiy9r5RTNOzICdMyHyBmtdgKWS34/AJ8ayRFJcllQ2PReBdZ5ZjZf6d7/bn3lZ3mLBwNnypT+gKFSIN2w2YGvqFDRDqav+OEdq8yT/CIjnOrTRJK7VGGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=bWfH69Ta; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="bWfH69Ta"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=C4mXeC1iJ/AzgXR7HuY39KddOLnZzVo8e0sm0ONAMGI=; b=bWfH69TaaFNzxGrLsIYph17DF5
	zpcxpUVUdxaLtHF7xnxAQSRG+NIreYzAP9iIUD2LiDGGj3Sh+pJskGvyNanDV1a/1ZwA7dC6tPOAJ
	S/PIkF8QFTqwGLQsq3eemLSYIHkITXyClYfu3R2R5P/Hon4wgtdG0su5mxjedAPeUMLZedjYD5FLn
	KXJ0ZQ3qQkG5BeRAvRstB5ZBVQDL/t6ome6ABi+DYfLwLZO6dhMPQMWKpPhk5N+FxtBmJiLrz78Wg
	pZJngYCaqFgEIaKwno6uEGahPfDNsvrzUpokeWOzsWBaUvbrnRUzfck2TKx1ogC0ob0BI0BiPcR1J
	ilgFVWNg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wXajD-0009sL-1D;
	Thu, 11 Jun 2026 10:25:31 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: razor@blackwall.org,
	bobbyeshleman@meta.com,
	dw@davidwei.uk,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 4/4] selftests/net: Add hugepage kernel config dependency for zcrx
Date: Thu, 11 Jun 2026 10:25:27 +0200
Message-ID: <20260611082527.741674-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611082527.741674-1-daniel@iogearbox.net>
References: <20260611082527.741674-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28028/Thu Jun 11 08:27:22 2026)

test_iou_zcrx_large_buf in drivers/net/hw/nk_qlease.py runs iou-zcrx
with rx_buf_len > page size, backed by a hugepage-mapped area. Thus
add to the Kconfig.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
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

