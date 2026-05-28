Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F823E8688
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978909; cv=none; b=M9Hl9ZhayYSyh/2+SBi+BxrVmRp82nLREwYwvCnLGwcmQxUWLQ0yD5gyemgWzix9xjpuMJu1H5kuPDDJ+L6j+8BsRLJzd+LB367OFscy84S+/thzzeu46NcM/et3m9tGGxuvaFAsbMwil8MqBMfFglF++vXo6b48R3g8CvvTL7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978909; c=relaxed/simple;
	bh=qYhPMsjys/cS8XDt1EyRHcNqtI+pMRzAdBxQ+KRqYas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHj6caGVMqQGP4Tz3OD2OVmasT4TlWlCY8FhrcW3atOOnGeEMR8ECSVBjMBEvQgGfvTW3i++7SPuYrUqEtslzpP3ne83o/Bhrmhew/i0dinlkZyII9CpXHN/6Uz7c+K3Do6d1zUf9qCBWIpFdRRuQU/jGzM9d4VKbBybJcpv1jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=GbV+M//p; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="GbV+M//p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779978567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/EL+qJ6WKHkjBQeLQM+rO68NQsJGkz6Soatl6PUjU/0=;
	b=GbV+M//plOyCZbdFTYeFCduu6jVDmB8mP3aNV8NYm0iuSXNehFN6ANwokhWrTfvX9rFenJ
	lFNcpXhZdEBql/ZRN8lhCXGfrxIPq1ze3Caq7e+KHkz/toc8WNHkGBeXB+9N63om33bX+U
	uRVQ7jfusZ50KVbfxAPMKyC+D9dvGAUJUrOIe/inYPECsqZ4636Ycaf8CnI09Q6ddbMX5Y
	PUDU9MUR9b4bkX2JP8xexqnrKMXZyrfVEcxuY4MnsZx9PS08vjqXRns+9ml6XA8BOjSFwU
	WRm8sarAFIhlo1lHDzWEuZhZaiPBVYXRimiKa+IFinfW+ycdMJzJSl5bpfkLNA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 02/15] MAINTAINERS: Rename batman-adv T(ree)
Date: Thu, 28 May 2026 16:29:11 +0200
Message-ID: <20260528142924.329658-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528142924.329658-1-sw@simonwunderlich.de>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

Replace the batman-adv tree name "linux-merge" with "batadv" to match the
patch prefix convention used in subject lines (e.g. "[PATCH batadv 1/10]").
The previous name "linux-merge" was ambiguous and was not suitable as a
easy-to-recognize prefix. Routing of patches to net-next vs. net remains at
maintainer discretion.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f1d2a924d53dc..741fb4166aa2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4440,7 +4440,7 @@ W:	https://www.open-mesh.org/
 Q:	https://patchwork.open-mesh.org/project/batman/list/
 B:	https://www.open-mesh.org/projects/batman-adv/issues
 C:	ircs://irc.hackint.org/batadv
-T:	git https://git.open-mesh.org/linux-merge.git
+T:	git https://git.open-mesh.org/batadv.git
 F:	Documentation/networking/batman-adv.rst
 F:	include/uapi/linux/batadv_packet.h
 F:	include/uapi/linux/batman_adv.h
-- 
2.47.3

