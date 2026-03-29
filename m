Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6735DA74
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774783424; cv=none; b=hIrvnKig1WHI8Yx9+HovsxBRFUEpEaVDR3Ym4v2bhsWUGLJGo0xxT6aTR0unsUoD6Pj+em264ojmqEidV1yTvhiY0+q/IG5slXFYzPGMnBYjeMeWT2bkLU/kXR41w2UNP764aNHVrRJ+nFHeY5z/c6Ip7kbyQfz3/Wv2lGjvkC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774783424; c=relaxed/simple;
	bh=VKCyhqMVXE+KSqjXVeG+3hvSNLI273PUuk32Xdv7S5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ca+tdWm6I8RV1VBgjpGmEoRzM+3sE/q2aUv1Li+qgYBPSp/7EmYt8PusfsUJnLYpwdXL5LUe8QXZ35wvsz3y7EL2dZ2BmdTOjjMmrbP+aeWLn2wZKX2R2LbiUIOcxjrN/o/McY1bFUTKXwbUAywbL49Q/yI3uALb3c73o2FhaO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qZGYf98q; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qZGYf98q"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774783421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXNLfi3VDWQRurd0FK4vAiq2uw5ZAgnel28YQEol3sw=;
	b=qZGYf98qDzH/XrSDpmsRSmQPC6jJ7ujqElb9DTolYikrak3n2fiP7ruhalUQqHtSEzm7Ax
	MdcTemMo/klrKgqCWtDAsmgNjXgX+ZYUn9+OG0fLg6rdlYfedXPdvfh7VOIy0go8EgbTU4
	aTJb665WMEvh/96ZmRERXFqpqM1mJkU=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev
Subject: [PATCH net-next v3 4/4] net: hsr: reject unresolved interlink ifindex
Date: Sun, 29 Mar 2026 13:23:13 +0200
Message-ID: <20260329112313.17164-5-luka.gejak@linux.dev>
In-Reply-To: <20260329112313.17164-1-luka.gejak@linux.dev>
References: <20260329112313.17164-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Luka Gejak <luka.gejak@linux.dev>

In hsr_newlink(), a provided but invalid IFLA_HSR_INTERLINK attribute
was silently ignored if __dev_get_by_index() returned NULL. This leads
to incorrect RedBox topology creation without notifying the user.

Fix this by returning -EINVAL and an extack message when the
interlink attribute is present but cannot be resolved.

Reviewed-by: Felix Maurer <fmaurer@redhat.com>
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_netlink.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index db0b0af7a692..f0ca23da3ab9 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -76,9 +76,14 @@ static int hsr_newlink(struct net_device *dev,
 		return -EINVAL;
 	}
 
-	if (data[IFLA_HSR_INTERLINK])
+	if (data[IFLA_HSR_INTERLINK]) {
 		interlink = __dev_get_by_index(link_net,
 					       nla_get_u32(data[IFLA_HSR_INTERLINK]));
+		if (!interlink) {
+			NL_SET_ERR_MSG_MOD(extack, "Interlink does not exist");
+			return -EINVAL;
+		}
+	}
 
 	if (interlink && interlink == link[0]) {
 		NL_SET_ERR_MSG_MOD(extack, "Interlink and Slave1 are the same");
-- 
2.53.0

