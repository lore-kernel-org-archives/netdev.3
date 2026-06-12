Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D303002CF;
	Fri, 12 Jun 2026 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304498; cv=none; b=hKe/UAxL+NLr9lH2TyL97I7P+FMNavVmoZG5U4FvtW5171RK+YUDygbVDnfK4pQdpx98uhBLIpT29GbJTuc8+YT5sFE9tjx1zgi75iQNSM5ow28G/iprkpAzQ6X469SM5cchQPax9F3PuRqt9ullPsBNKc6pjK7TltK0LTtY4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304498; c=relaxed/simple;
	bh=vwl+Kzvflq4BBOrvfguLLJIf/KFDxQcW5qKArMqzNDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=imq527mNlEthh+IKe9H/ARGqXi9bwEe8q1Ek0ZJn3c9wkDFExcOoahUSc02UjzhyGE/+/CqkiOE1LN5ZULLgMF9VJvwH9SiCYn7F8DjVLwZ78+7zB/oa/gRh5mgrCPQINzGmMD27U/0bnJc7NS3JMgK9b0o4ELNvHwrFajWb96g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJeQ4xXW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJeQ4xXW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE741F000E9;
	Fri, 12 Jun 2026 22:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781304497;
	bh=O3H20/hJghCbyY6nSBzsuvN7jb+ijjvYLSpVFEBAvSc=;
	h=From:To:Cc:Subject:Date;
	b=BJeQ4xXWuV5Zocwx8Jef0xyp8zsbXufW3ucVa+h1CJVEPIUzhzh6d3xBdQLu/YHdR
	 LsaOQkHiwQKQg2J0977mNKjfSretBxeWbi4U6VyhF5NixAxt0Q3IGeOsl6HyXGaPrs
	 jOyDjehXVuRKPKUskaC07iDLcUkH6H7JTuxRHuL25/cQKGUa1sslhp6vbuhN0qcTOf
	 +cKQkVqrX6/DD4SuyOGIo2ON59Bu/AU/HNl0hoDv4eTFK5JzmHt7vaiqABmEApt4tQ
	 3xWnUtEublAD3al+iQ+dE1Nbb0SieocUCXGI8zp5fGN6CyD7lEuvhFXAHIOD6IGwMT
	 SsN+hYMD8Adgg==
From: Jesse Brandeburg <jbrandeb@kernel.org>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Subject: [PATCH] mailmap: add entry for Jesse Brandeburg
Date: Fri, 12 Jun 2026 15:47:21 -0700
Message-ID: <20260612224727.141614-1-jbrandeb@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Brandeburg <jbrandeburg@cloudflare.com>

My Intel email address is no longer used, redirect it to my kernel.org
address.

Signed-off-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index a009f73d7ea5..829d609980c7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -401,6 +401,7 @@ Jesper Dangaard Brouer <hawk@kernel.org> <hawk@comx.dk>
 Jesper Dangaard Brouer <hawk@kernel.org> <jbrouer@redhat.com>
 Jesper Dangaard Brouer <hawk@kernel.org> <jdb@comx.dk>
 Jesper Dangaard Brouer <hawk@kernel.org> <netoptimizer@brouer.com>
+Jesse Brandeburg <jbrandeb@kernel.org> <jesse.brandeburg@intel.com>
 Jessica Zhang <jesszhan0024@gmail.com> <jesszhan@codeaurora.org>
 Jessica Zhang <jesszhan0024@gmail.com> <quic_jesszhan@quicinc.com>
 Jessica Zhang <jesszhan0024@gmail.com> <jessica.zhang@oss.qualcomm.com>
-- 
2.47.3

