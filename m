Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1B28851C
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166025; cv=none; b=o84DAPRVnlLVpIUTZ/7OgqIqHkBsy1Rlu2cNPKctjEJyz1nZvu8zYSSdl/JMtL8i72aUB/a/f05uRZzNBpTvoJdwTwSwsZMabzXfYu6dzsF5lYO4OKkI5xsqTepsJJr68Yehk+2RoM8yuYQbKwKX/ypVQCdDERyCmw7AEGEID+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166025; c=relaxed/simple;
	bh=8kJr+FLUV10V/ZJ7Sq9VI87yNDfUugnvRTVCSzisqkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZD2Nlw3KH6tZhupo1WdY6ZK3jBWW5IovQ4pUOjnYYy74PQTr104VRWj8Xn2QGNxlgVpJ0ivUn0A0tvBP3db/pgK3SroxCWgSOHboxrvQHeg6FRLTBYkDGn4cBkri7Yj1J7c9obQ21PIES2nqbqQC9tbXMYa2ZuDv5kShuTP0Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/u0wRZG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/u0wRZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773166022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LItefOf1eUgJWKhqj5BHa+BCco0b78Xw6Y1ZEm2DpzA=;
	b=Z/u0wRZG92v6QoyKBpUBPXZFfsC0TP84pZK2g7UKj8z8V/iUuBBNXtaKi+FNqGTMRLHnD1
	uCSAKx60VKMziVqe3relR2XJD+O1DtxT/aItCJvLsUcgZVgZKZsMrN6DY8/BAOCEZ/ahem
	U7P/tTS7D9QsFs6+b8l/oPF9LESsUwQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-axppcGhkOAa7pMfMIA6aGg-1; Tue,
 10 Mar 2026 14:06:59 -0400
X-MC-Unique: axppcGhkOAa7pMfMIA6aGg-1
X-Mimecast-MFC-AGG-ID: axppcGhkOAa7pMfMIA6aGg_1773166018
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CC861956050;
	Tue, 10 Mar 2026 18:06:57 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.44.33.226])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 61EDB1956095;
	Tue, 10 Mar 2026 18:06:54 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next 0/4] netdevsim: support ETS offload
Date: Tue, 10 Mar 2026 19:06:27 +0100
Message-ID: <cover.1773165520.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

 - patch 1 and 2 generalize taprio offload code so that we can re-use it
   to offload most of the existing qdiscs on netdevsim
 - patch 3 enables ETS offload on netdevsim
 - patch 4 is a tdc test for ets offload on netdevsim

Davide Caratti (4):
  netdevsim: move TC offload code to a dedicated file
  netdevsim: generalize taprio offload
  netdevsim: support ETS qdisc offload
  tc-testing: add a test case for ETS offload

 drivers/net/netdevsim/Makefile                |  2 +-
 drivers/net/netdevsim/netdev.c                | 51 --------------
 drivers/net/netdevsim/netdevsim.h             |  3 +
 drivers/net/netdevsim/tc.c                    | 70 +++++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/ets.json       | 23 ++++++
 5 files changed, 97 insertions(+), 52 deletions(-)
 create mode 100644 drivers/net/netdevsim/tc.c

-- 
2.52.0

