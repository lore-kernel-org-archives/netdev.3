Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378184BC00B;
	Wed, 16 Sep 2026 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562280; cv=none; b=VQvKuFYzGoV7zySnsuIhOnymT/jrmwGgoo8tOZITXUOP3VRGN3S/4zq4zxpx7LHQ8Xth5uMKW/Cf/oFQvsndbWPmvO9EC9kbOtg87Xme0/xS1fY2qiE0oWjQzS1cMVG1wczBIT+deQBSEWrcnNT5Yio64we7pLcKo4rqAoiZ1ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562280; c=relaxed/simple;
	bh=TP5AdabhgzYN5k4hVgXYmllLu6Wj2l5QzvFK0FJIQ3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1dOczXkvo6cXcSvBS/te3dA41GJwFTqvruoSzPVqUOMBNYFL4KTAtcK+RGQjxunXbsZ9DDkRlI6HwgauCd94/8tsOejfLyDlbk+XPe977kKqYpOKz5H0xyZyyr2RptEfPqIiaiEpmYeGfZk/w3wQiV3LfnqR7OJSiJ1FNKvxPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tBLvs8er; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vg6i7jQk; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tBLvs8er";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vg6i7jQk"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hlJM86SrKzMl2l;
	Wed, 16 Sep 2026 14:37:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789562276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AYceURoh7gtzk/BMV9k28UkTev5RmX3481dhU4tPlAI=;
	b=tBLvs8erjcQd1ddLUPlwmoO4S9tfsvRAzYAkQzJcFNSaH3at7prXUQ6naJ+pnblDbwCzTd
	TPg5++3+o/AlwTyTAos25IApIrnGbcsI8pan2E2jUIdKFCGz3fWdmxtou/WeEcdMsUreYz
	KdbAjelIZ5+qJBTbf0Bv39j/XK7Go4pSrpPkwVPi9u2hrbe4m6O62cae+FfNsUpWNYXFmU
	IlGoUfxry0K/9xmRV7CvEVLiOrqQB46ysozyCFL7A6L7oIQt+DyVFnUrnD0bojsxSIq4a7
	DK1NwXGML03lf14YKcBeCNJN4x5cNWHf+aTZ9bDf2YYySLd6dNz8URQfk/x9UA==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789562275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AYceURoh7gtzk/BMV9k28UkTev5RmX3481dhU4tPlAI=;
	b=vg6i7jQkFFnzEy0UITAV06U2Y1Dgpb1XBuDSZnyhz8UgSrxYBi2v2/uNhY+X7N08wgcK7a
	t6Fc3ud6uzQkns8PQ6OgUkoAOLOOIkgitD3EXIBYhC3PtPWsUOTN8uTbw6y68QiNTC6Pi8
	5pAFkV3EUVccgmU0m0DRWFjI+P90pdLjgvhbqbQA/CRfzbaSNxHOHuluPuakgWANziQbzL
	CvcadoSzwDKrAfPt8gzCDhGgjrouvaQkh6klXd6vkKQppCHr8fVNoozatUp9oUkgtJCZL2
	zPm566xBv81k8G8nHXGp4Xh8yqnfz/e9PGJ58y0Ohbm1D1ebXXWKLzHcpypUyQ==
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: networking: radiotap: Fix bracket
Date: Wed, 16 Sep 2026 14:34:58 +0200
Message-ID: <20260916123458.314458-8-manuelebnerli@mailbox.org>
In-Reply-To: <20260916123458.314458-2-manuelebnerli@mailbox.org>
References: <20260916123458.314458-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1c196a3bbf7e8f64fcd
X-MBO-RS-META: ec73dwtoq7ksrs1nf9rbg69hai3j9q9d

Remove needless ')' from code.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 Documentation/networking/radiotap-headers.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/radiotap-headers.rst b/Documentation/networking/radiotap-headers.rst
index 1a1bd1ec0..aadc7bc6b 100644
--- a/Documentation/networking/radiotap-headers.rst
+++ b/Documentation/networking/radiotap-headers.rst
@@ -133,7 +133,7 @@ its prototypes available in include/net/cfg80211.h.  You use it like this::
 
 		    case IEEE80211_RADIOTAP_ANTENNA:
 			    /* radiotap uses 0 for 1st ant */
-			    antenna = *iterator.this_arg);
+			    antenna = *iterator.this_arg;
 			    break;
 
 		    case IEEE80211_RADIOTAP_DBM_TX_POWER:
-- 
2.55.0

