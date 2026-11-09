Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245950;
	b=RAi7Cfu9MV5N+El212fU5LuD9h76J7BI00FgPVdWLQcwkZqruoh3ZRWYtHeZQIOpg1wn
	 OhtT7AP3OWlUp9C8fHw3h6flbTsPQoniY74r8VpWTJDbNtBTJzKKT41WMsQH+ZSGKetXw
	 KmDChbKupzYFThm2Zx19to8tEmQTI2ca4ofCN9eZq5JpgeWzSANgl3yegD6G84FmGLb0h
	 /m1lKmK7jcd7QopfRVgTcYdaNcCL3TdK/AhzcoQuXaybYyun8fF0YfhfUOf7lsg1agfLq
	 feNrAKXeSwJr7dzMFHBw53zkXhInTXKgDASRDbzhNpUtqiXQadOU3DL6zWg3llpBksQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245950;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vqPwd/hKBn5LBiacZwLyGWy+Rn+Ifo3VZNYBwd+GhWM=;
	b=ZtJS6FohJq0UxLX89BkUWic0cQCuCnoFAo8rzAQa3aAUAobM9BOKIjsAKAHM0l+Vj4CO
	 EJj7v29ovNJOVl7DaHNdMzNWDMv7WPEe32emSeOIsH0NWcABNqUq0mrN3k2sWs3lXIhKK
	 Kk5wHaFOz00AtUKrfQr2w/uLKqYcxWBGgK+vTLm2Ka/G3rkcfjQLcSE2kPtbBsGXw76pt
	 xH/g3zsXVcnAosiBzM/LePBb3gNrdYhA+7TXhzzvIfXROs9Z+ODNvjdfLUyfQY4nuGb35
	 iJ2qFlgb/iUmbqdGiSnkJf7XWIcBjRGl/R1Jp2KgqEpi/6mS05wnK50C0rpdxzVtHXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WH/3lnkW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3287A606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WH/3lnkW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7093F1F008A1;
	Mon,  9 Nov 2026 17:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794245949;
	bh=vqPwd/hKBn5LBiacZwLyGWy+Rn+Ifo3VZNYBwd+GhWM=;
	h=From:To:Cc:Subject:Date;
	b=WH/3lnkWRc7hRcH8Ghes+RYfcTj2R4QcjS7z1A4w3YKhSrfCEm1qpZ4LrOpYtjpLU
	 5J9mIcs+WuOsVaktGTOfRs7y4oVbCsTmWij/QmC/vREy9zXHY/0u45CWeSeER2ByAI
	 9mGRXaD9c94iHKQVKcDs4gm0r3aGm8fKla/FdWTfw+f66pGkHV660h4rzoUxOC4jmZ
	 3kMVWF70ZhQTp3sZUObZiaWUXOmW6FEp2VBQj0ipUr8ZuvXWAm4YvXxJad9ATp2M34
	 xwfotjAmeqQ7dIki/69e0kQBVCFe60t9f60Nf2HUz4ccHOYAc1dEMPF/6YuR6/4tem
	 Fk6YCZ26iUlqA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] net: opt loopback into instance locking
Date: Mon,  9 Nov 2026 09:39:02 -0800
Message-ID: <20261109173902.1225585-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev netlink iterates over devices when dumping queues/NAPIs/qstats
etc. and takes rtnl_lock or instance lock depending on the underlying
device. Currently even if all the "real" devices in the system are ops
locked we still have to take rtnl_lock for lo (only to find out
that it doesn't even have queues or NAPIs to report).
Opt loopback into having control path under the ops lock.

This is a pretty obvious thing to do, I've held back this
patch because we used to only apply ops locking on physical devices.
netkit queue leasing made a precedent for (far more complex)
SW devices enabling ops locking. Now adding it to lo should
not create much new bug surface.

I considered an alternative of adding a "predicate" to the iteration
primitive so that we can skip the devices which obviously don't
support given API (eg qstat) without any locking. But it's more
LoC and real_num_.x_queues is not currently WRITE_ONCE()ed so
it doesn't work too well for queues.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - pre-req commit b6f74dff6d26 ("net: use two lockdep classes for
   the netdev instance lock") was merged
 - no change
v2: https://lore.kernel.org/20260921190452.1467853-1-kuba@kernel.org
 - move setting the request flag from gen_lo_setup() to loopback_setup()
   to avoid splats on the blackhole dev which we don't care about
v1: https://lore.kernel.org/20260918210419.4088201-1-kuba@kernel.org
---
 drivers/net/loopback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 8a6cb34e6b5f..1e6d1b7d71ba 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -207,6 +207,8 @@ static void loopback_setup(struct net_device *dev)
 {
 	gen_lo_setup(dev, (64 * 1024), &loopback_ethtool_ops, &eth_header_ops,
 		     &loopback_ops, loopback_dev_free);
+
+	dev->request_ops_lock	= true;
 }
 
 /* Setup and register the loopback device. */
-- 
2.56.0

