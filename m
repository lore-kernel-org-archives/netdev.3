Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9203336F8F1
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809757; cv=none; b=Jwk+KpYTS/lFcWjFc8+XPpMCh2AzyghCBMEpb/qZOuIIQ3xa5WIRfFbMrVQjgeUW2o5X/VqjdMHrc/T0aKrzDKb/c8+75m/ZyPlt/e2PSTW/9dqegc2NiitvOMqRbls0UxcFaesOlduY5urZngT5CGbNKU2xuGaKaZFJ1OmfMHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809757; c=relaxed/simple;
	bh=TnbW0dApMYRoHuNwGRCDVqvvGqvkBno+Xwrvn+K0w0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejHloU5Cs1OnuFNLwqNVVvrqVDGjFfilIf8AyRkX9kQO8umvnrCnJIvGf1Y8HR1HunnnbJzQFXw+UR1pmqXcaU02cOVrxFM6K/6PFQPZHz2kc9/bJiaYWltxm1rVcGVOaiDN/xJvRrdHapK3ZUCb/con7BRDp1tQc+5fTHcEDDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=me/6vSLh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="me/6vSLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB011F00ADB;
	Tue, 26 May 2026 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809752;
	bh=7M/Mip6AVKg7RdPD9R/drGNztHDZa3IsEQ5UqwjllsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=me/6vSLhFDRQ6I5Q3x9s+Hwoj5sRbptZ/Ni11XdozZ/yWDPqfCYZJbvJgHdnKyVmD
	 JNJ0EtWmUiuqe083EMXYRdblsI3udJfPSi3jHWH3b8YDQfc/MtVjvixAIHKzotpa8U
	 uRNrdfdd/H6gd5gbJWVTOC5lu2KpwsYL4GwntuI9DU0gyy8Zg32PRQ2aSDBOwtHnNu
	 uiSWoFkkouVDgQuRQQ1iyRNj7WXHGpVxuV14brnBgBIybJSNDRUb6uT1BZUjwJVh3S
	 2hENx98bswcKdLxxK9pJjBpAJarDor2M5IZ7efadcmzSDjGQ7vnoErc9QS1axtLxV6
	 enRrdWBpf2OFQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	haiyangz@microsoft.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev
Subject: [PATCH net 05/10] ethtool: tsconfig: fix missing ethnl_ops_complete()
Date: Tue, 26 May 2026 08:35:28 -0700
Message-ID: <20260526153533.2779187-6-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526153533.2779187-1-kuba@kernel.org>
References: <20260526153533.2779187-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tsconfig_prepare_data() calls ethnl_ops_begin(), we need to call
ethnl_ops_complete() before returning the error.

Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: vadim.fedorenko@linux.dev
CC: kory.maincent@bootlin.com
---
 net/ethtool/tsconfig.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
index e9db4ee2299d..fc4f93cfa459 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -69,8 +69,10 @@ static int tsconfig_prepare_data(const struct ethnl_req_info *req_base,
 		if (ret)
 			goto out;
 
-		if (ts_info.phc_index == -1)
-			return -ENODEV;
+		if (ts_info.phc_index == -1) {
+			ret = -ENODEV;
+			goto out;
+		}
 
 		data->hwprov_desc.index = ts_info.phc_index;
 		data->hwprov_desc.qualifier = ts_info.phc_qualifier;
-- 
2.54.0

