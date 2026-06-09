Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D167B4C954B
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032091; cv=none; b=bhWtkhLZtWAaBWNKozqs33G3Fq3SVPpMFVzWQZLA9gJhJmQq96JXTPoj30crJsEo45TNYQKCBSEQsoThhJOvOSSgU3pg81GQYyubWr546j5fSjvOi0+BeWNaFj30PVqsJe5UUUoNLuaDIP53tlEfmJ5njDkx/5NQOSO52Tk5rOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032091; c=relaxed/simple;
	bh=dm7R6wQ/52SNsqAZc7FFluQpKsmza5NrJmmw4KWjDk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2bq7+g4qoHLD2B0PbCz6TRzf1aYvxhdeGGGzMFhsWlWMH9gncxToLZBHk5Vt+aTFpl7vPOmP5BYYWgaagh5HMnpHePACC13LIc8KgmyVISuBDIXX7MQr7uDcFvGUUqKQgdgMFjB2/DUgDa/ZBvFjb0brU64m5mnk9+Sd0PKXcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kClfBauN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kClfBauN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3488A1F00898;
	Tue,  9 Jun 2026 19:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032090;
	bh=U1XgiC/VMVxxVG5e+DYvOKBgUIybiccNP4XomlqgTDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kClfBauN4gMnFFW9rbbYEDCa5neM2e9z8HYb/uoQxXQIajZ6RZqVDDIgDghTqBm6D
	 m1jj+gnuI3knKw/lPok1HDCJmn356X8IDob716Fv8Goo1NE7BH9cqCse89/YaMQ7IU
	 leL86tI3gRj1XcJ/HeRxFX9eSpOpiPQCzul2+rzwv3gQJj5t1NBAvdGvUXpYUfm2yk
	 lt8cEhIxJtfA3o0gMzGiF8z4RPBWluSaF1pKM8nxNIBs3M6nU/KGLIFJs4y/r1pSar
	 nPV1Dv18jiyKrYxp+v+F7danUI+/xttxMvoh74li5t+bjJpDopGhx4RqPPcInYV7Nn
	 C0Ln8+kdx+Ulw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dw@davidwei.uk,
	daniel@iogearbox.net,
	razor@blackwall.org,
	sdf@fomichev.me,
	dtatulea@nvidia.com,
	bobbyeshleman@meta.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/4] netdev: correct error code in netdev_nl_queue_fill_lease()
Date: Tue,  9 Jun 2026 12:08:02 -0700
Message-ID: <20260609190804.1137085-3-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609190804.1137085-1-kuba@kernel.org>
References: <20260609190804.1137085-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev_nl_queue_fill_lease() returns ENOMEM on nla_put failures.
This is wrong, the error code should be EMSGSIZE. But it doesn't
matter, caller of netdev_nl_queue_fill_lease() just checks if
the retcode is zero or not, and uses EMSGSIZE.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/netdev-genl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index a10d353d5eab..d35af460e886 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -432,7 +432,7 @@ netdev_nl_queue_fill_lease(struct sk_buff *rsp, struct net_device *netdev,
 nla_put_failure_unlock:
 	rcu_read_unlock();
 nla_put_failure:
-	return -ENOMEM;
+	return -EMSGSIZE;
 }
 
 static int
-- 
2.54.0

