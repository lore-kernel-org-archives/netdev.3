Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F691362138;
	Wed, 19 Aug 2026 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145438; cv=none; b=qqw2aH/k+m/qmRn2mmVjUlD2WHmiBX8thUNCgwEzzBFY5PcOQhZEH7aHjlUql5c5SVe3lIA2I6n0OimdjAyKsdw1T1gYUWC60waYoWvBrUCWORvO9z8Q/r7SNwuk7+5/BYWoAiL2MOmG1/KAC/zFSzyiQL3CjyI19Ar8SrPEy28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145438; c=relaxed/simple;
	bh=QXxvXyT7Y1GApZez45uP3uNtgTnakYU5a1nNd9IKu6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cH7ytXWv6R4neJHPbdPvBGrtewMuNJCcHE6X8KOfew+Q9XjMjzaXA0E73PHDvIid7kNn6mAMirQKGyCgH3NL/eVur/AHgCAC6iVgKi0frN5BaPlNioNBgZudjGIEw5TAvqhjaWjq6KWpGJdlExnhCE6r4QFUVK472jcnJc4YRDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=rLF29KhA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="rLF29KhA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=ezo+OhM6xujuk9erbY7jIcwO8hB+zX5plJdWPgrndlA=; b=rLF29KhAny8tpbjhnZeGkAnL+X
	eQGP5gh6LPep1wb0K0cqc0o0+9qzAf/O9g4OnxHPE6x0WCXPK8cvUG1cjYs1fJbwCNSkGpD38GmIF
	JmZlDWeVSjxYeDrUL7Ww0IrlPe4WGCjKDYnFC8F1jRyZzfwMuzEU1ZODomF+zBGR+EEXe9+IVcM3W
	7/WWoEztZkVM2Yd66I11SAaOaTcewQctLTjPfpsKxJauAZIc/RKMAYtAgwUAhIXmG3Onba2B5WxG5
	gKgjqLQ604DMPqoEcRVj+eDUbpk/JINYJo51/if/Ab2MG660Ei7/RvN+DTdIKhdC6QpXMEgwHPPwc
	wOUqaw+A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wwgA9-009on6-21;
	Wed, 19 Aug 2026 13:17:01 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 19 Aug 2026 06:15:35 -0700
Subject: [PATCH net] net/socket: remove unused do_sock_{set,get}sockopt()
 exports
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-hch_not_export-v1-1-af4b0de70e13@debian.org>
X-B4-Tracking: v=1; b=H4sIAHashWoC/x3MQQqAIBAF0KsMf52gLSK9SkSUjTkbDZUIorsHv
 QO8B5WLcIWjB4UvqZITHJmO4OOaDlaywxF63Q96NFZFH5eU28L3mUtTVo+797xu2gR0hLNwkPs
 PJyRumN/3Ayia5shlAAAA
X-Change-ID: 20260819-hch_not_export-908dcceab01f
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Martin KaFai Lau <martin.lau@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Christoph Hellwig <hch@lst.de>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1631; i=leitao@debian.org;
 h=from:subject:message-id; bh=QXxvXyT7Y1GApZez45uP3uNtgTnakYU5a1nNd9IKu6k=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqhazIzwLV777d9/Kfec6EKfbjVIXp9Yd0sG6Vw
 T+52CCgd+iJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaoWsyAAKCRA1o5Of/Hh3
 beafD/wPAvjMhqXkDX7G+3RUIXBf/G3Bf3LigJTEtQjq/rz9+IUly/y2BGzbn8pa7anutoLIB7G
 hBqkKCKjp5PPrXdU6gG9Dc+2+V0dmFF1uiZOHLCl6nQPR/vIiC3cEud90kK45rWVHPY/0NusCub
 4oGHkgAq/I5b66vKekes89vut4ZWDwwT/RquAY+vBLyNCetBRQNUBVMoZf8FAEN1k6SDpiH9lJ4
 LeHmzpjgHYdqH2Vi62EdXAyhC/3uco9dPAiCbgzO2gOmygpM82cbdqBGLvOITW8rz8v6G/BwOQU
 d5HGTcw2fD8Z6XbvpOLldvHd1ZEmywy3I7VuxaW0LjVuPBO5nZolSSlHQvInSpTsjbDmBO/jxbX
 H0fSqZD0prM1ueIDQF2NJKfE9lTKCF/ZIcIx2kIBnpsU+eqIz7QUQTqjynu3MMFfL8BEIwqYaB7
 Xmw+3/WIR4bjEXxUgfKhQFaf4sICn7H4L8Fyy9MI5h8+sLjl3Cq3UKQ5kPEEPmiXC3Cny7D46RO
 5FJKFQfzNgwEI4HgMkm4M6WeBSQAkp2y9ziSMMnn9vGc9x0LPuR3QyFBGDuBKbXTdoYGv+VSDfs
 KZjwN2xnoTO45sfdJF+AOH1Oee0poObj7Z5MdXXJIrOA/K7qVKM6Peg3tL1gxMWyD9bD3wNIbQ7
 WiG2oDfVC9kJZGw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

do_sock_setsockopt() and do_sock_getsockopt() have been exported since
they were split out of the syscall handlers for io_uring to reuse.

io_uring is the only caller outside net/socket.c, and it is never
modular: cmd_net.o is built under obj-$(CONFIG_NET), and both CONFIG_NET
and CONFIG_IO_URING are bool. The declarations in <net/sock.h> are all
it needs, so no module has ever been able to use these exports.

Drop the symbol export.

Fixes: 1406245c2945 ("net/socket: Break down __sys_setsockopt")
Fixes: 0b05b0cd78c9 ("net/socket: Break down __sys_getsockopt")
Suggested-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/all/20260819090439.GB9267@lst.de/
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/socket.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 63c69a0fa74e1..ba3eca4324e7b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2371,7 +2371,6 @@ int do_sock_setsockopt(struct socket *sock, bool compat, int level,
 out_put:
 	return err;
 }
-EXPORT_SYMBOL(do_sock_setsockopt);
 
 /* Set a socket option. Because we don't know the option lengths we have
  * to pass the user mode parameter for the protocols to sort out.
@@ -2484,7 +2483,6 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 
 	return err;
 }
-EXPORT_SYMBOL(do_sock_getsockopt);
 
 /*
  *	Get a socket option. Because we don't know the option lengths we have

---
base-commit: 564973a259ec76f2dad0853420e7034cc43994c4
change-id: 20260819-hch_not_export-908dcceab01f

Best regards,
--  
Breno Leitao <leitao@debian.org>

