Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BBB4AE13A;
	Fri, 25 Sep 2026 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372408; cv=none; b=jPZd4ewSl+453FTmYpEUBiKdxDKRDwjkJepLlDuhBzCm01BHgN+uxXZZFwJ2776WWtDWuPUKM3fkDnfwaQbgnhasbtDmSaEIw2h9xtW6aTyGus7hz+9CwSBbj/Rg7wnG7Mof0ixBIZbVXdmeCQUnZ+Uy3lLV1T6NaWBMOPi8AcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372408; c=relaxed/simple;
	bh=nLdsImlNFk9RT1Dt54W5Gr0Cm7rMBiXYvJWP3TsBIXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+L99rn9727RJiyBxL/NdUNdAn0kd3cxinquVHOhKQo3NSMTUqqeejLdyOyeuaAuLI0kkVSBdbrJryqaMG7xCvX/FFVPpDd/ugvKDd4XmftUm3Hx7Q8vxHXEBl0bTKHpzqmzTImEtIuAlt4ABtiQRsjCY20e0fwv0YKOYoDy5CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=KHK6muye; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="KHK6muye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1790372395;
	bh=nLdsImlNFk9RT1Dt54W5Gr0Cm7rMBiXYvJWP3TsBIXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHK6muyeAD5WULha1IAiVVVBg/QBfFj0N0A+GfY2cI35cY3WzMj8OzqtNOnEIbwKS
	 3OzqE006NAsEpTYHnyv4Zc7Ag5nEImnmwubCRX700DtgfI8Arnx8rKSFDlgxMOaSln
	 JInr8x5v7PzuJJ8mUYa1jxcjGib0K+iX1z3axj26fJzSbcI51sggEWOU6v7tNpZSQK
	 ZZVPXIT/vUwKUggrcdt+WihACHGZCfH8Tuya/d43b3194qCoN4pHptiKqbRY8OQklH
	 NVukc6CDJBnxYcpL4JIZ8fxihynho91pyAAVH5UvnS+L4o8776myk+eE1Sd4cLTCzg
	 16+e0T+9kdcAw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 211CA60103;
	Fri, 25 Sep 2026 21:39:49 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 4A8FF201C4D; Fri, 25 Sep 2026 21:39:21 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v2 8/9] netlink: specs: tc: fix typo in cls-flags
Date: Fri, 25 Sep 2026 21:39:11 +0000
Message-ID: <20260925213918.204767-9-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925213918.204767-1-ast@fiberby.net>
References: <20260925213918.204767-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a typo in the naming of a cls-flags constant.

The correct name for TCA_CLS_FLAGS_NOT_IN_HW is "not-in-hw",
not "not-in-nw".

CC: Jamal Hadi Salim <jhs@mojatatu.com>
CC: "Jonas Köppeler" <j.koeppeler@tu-berlin.de>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
Note for Sashiko/Clashiko: Targeting net-next, so no "Fixes" tag.

 Documentation/netlink/specs/tc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 2e663333a279..b6ccc645b0e3 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -42,7 +42,7 @@ definitions:
       - skip-hw
       - skip-sw
       - in-hw
-      - not-in-nw
+      - not-in-hw
       - verbose
   -
     name: flower-key-ctrl-flags
-- 
2.55.0

