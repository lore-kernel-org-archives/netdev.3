Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECF43E16AD
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268167; cv=pass; b=iiIHUOIwoIJUDV4kXxjNGwm5qBC2MR1X9pzG6XcmHhV3CrprlYp/iVDxU8sjOuo2cIabYjo1JvWZNU8XWVsOswd7vgjRJWuMZP6VfCE8BaFneHAdPuimHopYcmBGink8zF7tWlBdrWOYkT3gBu3LQXzpKMrBeK4+wxropJ5TSp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268167; c=relaxed/simple;
	bh=HE1ooUHWe+Xn0ncZWj31vGOIve0nXE+zZLVCFfb41Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ask/0+EXNrk9sKEJD73RhTq/onih10538+6iPMPMoRkH1+TRdXLm6QcEHUv/y73McLwdjm0G6zmlfgQLTiBbPBMAi1rDHoaLFoQgexoVr+sLn0Q+KBMC5FtWaZM272MhZQKRBkNdawoEAoDBarmtx6+rXXoA5FRkEEEyV8uUGDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carlosgrillet.me; spf=pass smtp.mailfrom=carlosgrillet.me; dkim=pass (1024-bit key) header.d=carlosgrillet.me header.i=carlos@carlosgrillet.me header.b=TrzLbxZw; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carlosgrillet.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=carlosgrillet.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=carlosgrillet.me header.i=carlos@carlosgrillet.me header.b="TrzLbxZw"
ARC-Seal: i=1; a=rsa-sha256; t=1781268124; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=OyVjBAi9tLYhUOmYRIVr8a27l+CkJqrze0IimYTUbqQ4oUYSv3nKkBCoEzv0FeSyIGjMSVm9cBej8QWD/XAuwFevczt6OgpSCHdlmwJWLv/tYPCBAw5O+c9jHIaPSr2Si0mJ/yEliT2rUTHREXc1SpFS3rxOWFDIHKxutcDlPos=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1781268124; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=THUMQNicl7KW1UmpiAqZG91+lPvNkS3vPufNnPlEQuk=; 
	b=HAiD8pECCBq2LZKCMo3CIHQHiWLBLA/Jod6JRbfhTJ0UPhoxnxzst3ge/Ed/DSY09oPEgmayyjFYFgJbmiL+xvSKEaMOyaBPde3HNiHjMzMpplkRThRUrjAO0f1jwmbL5/vC+QIM7T4Kga2n4IhiF4sPwNUz65KMLyGIKHRwtx4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=carlosgrillet.me;
	spf=pass  smtp.mailfrom=carlos@carlosgrillet.me;
	dmarc=pass header.from=<carlos@carlosgrillet.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781268124;
	s=zmail; d=carlosgrillet.me; i=carlos@carlosgrillet.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=THUMQNicl7KW1UmpiAqZG91+lPvNkS3vPufNnPlEQuk=;
	b=TrzLbxZwqDoHTTQYy5jrbiytDGG/NLNMxM+Bo7MCb5ez+7ZNza9iHob2HQmOKsvf
	1knKddXQJy6eXaY9da2NpbKNY6ItnbFu589oQWZpx9yErWZsYTQCD7vq1JW6vuLoS89
	hAB0rtgeVeKKfh5a5UkaIWn/FbVx9mWW5VUfSfiU=
Received: by mx.zoho.eu with SMTPS id 1781268123497470.0674719117636;
	Fri, 12 Jun 2026 14:42:03 +0200 (CEST)
From: Carlos Grillet <carlos@carlosgrillet.me>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org (open list:NETFILTER),
	coreteam@netfilter.org (open list:NETFILTER),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Cc: Carlos Grillet <carlos@carlosgrillet.me>
Subject: [PATCH nf-next 3/6] netfilter: nf_sockopt: replace u_int8_t with u8
Date: Fri, 12 Jun 2026 14:40:23 +0200
Message-ID: <20260612124027.71673-4-carlos@carlosgrillet.me>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Replace POSIX u_int8_t with preferred kernel type u8

No functional changes.

Signed-off-by: Carlos Grillet <carlos@carlosgrillet.me>
---
 net/netfilter/nf_sockopt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_sockopt.c b/net/netfilter/nf_sockopt.c
index 34afcd03b6f6..19a1d028158c 100644
--- a/net/netfilter/nf_sockopt.c
+++ b/net/netfilter/nf_sockopt.c
@@ -59,8 +59,8 @@ void nf_unregister_sockopt(struct nf_sockopt_ops *reg)
 }
 EXPORT_SYMBOL(nf_unregister_sockopt);
 
-static struct nf_sockopt_ops *nf_sockopt_find(struct sock *sk, u_int8_t pf,
-		int val, int get)
+static struct nf_sockopt_ops *nf_sockopt_find(struct sock *sk, u8 pf,
+					      int val, int get)
 {
 	struct nf_sockopt_ops *ops;
 
@@ -89,7 +89,7 @@ static struct nf_sockopt_ops *nf_sockopt_find(struct sock *sk, u_int8_t pf,
 	return ops;
 }
 
-int nf_setsockopt(struct sock *sk, u_int8_t pf, int val, sockptr_t opt,
+int nf_setsockopt(struct sock *sk, u8 pf, int val, sockptr_t opt,
 		  unsigned int len)
 {
 	struct nf_sockopt_ops *ops;
@@ -104,7 +104,7 @@ int nf_setsockopt(struct sock *sk, u_int8_t pf, int val, sockptr_t opt,
 }
 EXPORT_SYMBOL(nf_setsockopt);
 
-int nf_getsockopt(struct sock *sk, u_int8_t pf, int val, char __user *opt,
+int nf_getsockopt(struct sock *sk, u8 pf, int val, char __user *opt,
 		  int *len)
 {
 	struct nf_sockopt_ops *ops;
-- 
2.54.0

