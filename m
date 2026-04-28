Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE937BE7C
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777409638; cv=none; b=OLQF1jzQPXJ7fC53gW0n/J+ld54SmrTxRmzt1t0l+OItNEkt16MFEYkfJc/KMR0QVZnA6+/YYRyHejprQhr2yL6IY1Djh8cJiP9MvCEthic5HRdU+f3BmVbRCnqT4/vedwIkWJIzhtcNc0bf+MUFLmC7YnafaVN9VoBlyOBTIeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777409638; c=relaxed/simple;
	bh=kq/0J+Ftl468joYkW8fhfnGSH/A+B110vMVnKoQ0GOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQWnDux7Gffr3Ahsrdm3y7+RPZ7k3pXgVr32ndSE/nE3GNaAIBEdQXiIOkfhz+lh3ueCc6aR707JNdowfPxwNKum3kkF5J561Ed2sMbVvBkam3Vi9JsYygnAleai//KKz5l5NlOOEhABF1LnrXOHAtqZs0+mHLjH+WYepZgKONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8dqEVrX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8dqEVrX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD15DC2BCB8;
	Tue, 28 Apr 2026 20:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777409638;
	bh=kq/0J+Ftl468joYkW8fhfnGSH/A+B110vMVnKoQ0GOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p8dqEVrXc0arQ5yKrG6zb8AUi72R46mhUHFkD1z8G8cVPEL/otV8b7w6et4lYzyzi
	 oj5HDwVN8jOXUgT5k2FEibW6tGBjCeZBL0JR0Wpw6xFIqNC+x3cPE2UdSy+tvy7N2i
	 u+bqDKlpyhdQRcB6VueGE7XT+9FwikSQ88X/xGoicMDAg163+TysE/46WOHT4k0/QI
	 Zxrw14bbMm2MWu5k6UzRJWdHOHgTBmtteMHLp/UpEGXwIqpwZ1HJRCRqb/IHKjuDNL
	 YbO1DOCH/HGq+if3AINogIQru+O7eL8lhPPB3Hp1Cx06KDyX7mfln2+/WN/8gMVY3t
	 Fma03hsq9PZ3g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	daniel.zahka@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] psp: add a comment about a psp_dev add netlink notification
Date: Tue, 28 Apr 2026 13:53:51 -0700
Message-ID: <20260428205352.1247325-3-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428205352.1247325-1-kuba@kernel.org>
References: <20260428205352.1247325-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In psp_dev_create(), the DEV_ADD_NTF netlink notification is sent
before the device is published to the netdev via rcu_assign_pointer().
IIRC this is intentional because a single PSP device is expected
to be shared with multiple netdevs. So we are trying to default to
not having the netdev info. We can change it if someone complains
but for now just add a comment that it's intentional.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/psp/psp_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 652ec8a9c8a4..f069117c867a 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -90,6 +90,10 @@ psp_dev_create(struct net_device *netdev,
 	mutex_lock(&psd->lock);
 	mutex_unlock(&psp_devs_lock);
 
+	/* notify before netdev assignment
+	 * There's no strong reason for it, but thinking is to avoid creating
+	 * implicit expectations about the PSP dev <> netdev relationship.
+	 */
 	psp_nl_notify_dev(psd, PSP_CMD_DEV_ADD_NTF);
 
 	rcu_assign_pointer(netdev->psp_dev, psd);
-- 
2.54.0

