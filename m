Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492345;
	b=rpGLdWNhA6pbsA8cjU4hPBhDhwuWYy4MZbc3vDNcws21GSGMAIBPZUbJHy+3KaNe3/yy
	 /0Ixj1cUmsMdagyWrqwgB3fqAWkmOcgShKMahIHSz3lJNMAmHh4N5JZS+S/tNuL6wgrUK
	 1fNpqMRn9BtiDYDSQPmB5XgdqIQmGMCnuUu/atchZ7/bqQKzg1u3HRHal8n7NpBWB19Sm
	 1UStIjp9DcFvqCPY8xR7fLxV6hH/vN6/dHwQqnA5Lddb9PRl7zPpaU9GVCsDlVPl4dFT6
	 rBc+UviP3MW837LknweWCaNScZ0t4x1k2vVPDLJGTWBvwgB9JzdarZRlwaSiRrqb0XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492345;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=ccZWgR7dmlMI77SvdnZJfxt5XPzWoiMS7ZxdcshawL8=;
	b=AmVLRBvrMLc0SjVSpi/wLWjZQK29h8kwi2qcm9mQyq/HwifYBckZeu9EkjoZEW1Juq8y
	 z2u7Rjy/jv8R+XeIW3LtDTEC4TH6/v/MJjWRKgyP0CiT+3ieY5pXPfoO4x6V+KCXn6sFa
	 rSzubI/NG+LEwJztxX0dkjnvPmm9+Ewd4YjUofaCiJoxU5FTLkwUV3BNmmEx9GL7R9yd/
	 0UBwDHcsKNk/nBOkpBKcZwCFEn+LlCD272fUN30f3b0KUtAQlOCbmxLl85n7n2kavpudE
	 xfbs+xDqtVzbQbwQVclwHuNVN48OJM2P+G86KhQszXxS0gYV+U2vDHL66UmxVkfD+fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b="i/UfKCOm";
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDC3606A321;
	Thu, 12 Nov 2026 14:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DDC3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=i/UfKCOm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=ccZWgR7dmlMI77SvdnZJfxt5XPzWoiMS7ZxdcshawL8=; b=i/UfKCOmWEcqm5tB7RRNDaNgt5
	AQic0RfgmdLRngj53swzQuj3/xti5yzRH5UggFv/KKhxSB6cJyARDM5k0+ZOiLYhl9QExy3cQNivF
	IEwl72Bsy/j4xS8InlClIlrTQIdw1a3uQ/xcN0at0IIpJWxHG3ihQ+fXmzBdL+2sV4sYNHUu/OsfX
	QFmDp5gxFGA79clNRcD6o2pMx+ifDoxsAjLJB4V+Bx0E+Dk8g8C8jH0sgdYeBcKRz4dg9hAQM1UoV
	LMgxlKn8h9FWx8P1JlGB+/T41vYjSI1XVgxonDAllFpeNM8PYM4VnVxN+78jI2MEjH+pDhp0zU3j/
	B7Yskgbw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRVQi-00E1WS-1F;
	Thu, 12 Nov 2026 14:05:32 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 12 Nov 2026 06:04:58 -0800
Subject: [PATCH net] netconsole: harden the enablement through configfs.
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-netcons_double_cleanup-v1-1-d5ff8167e05a@debian.org>
X-B4-Tracking: v=1; b=H4sIAI/H9WoC/x3MYQrCMAwG0KuE7/cKTRXRXkVkbFnUwEhHu4kwd
 nfBd4C3o2k1bci0o+rHmhVHJu4I8h78pcEmZEKK6cLMKbiuUrz1U9nGWXuZdfBtCefTGCPzVVh
 u6AhL1ad9//Edrisex/EDx5ipVW0AAAA=
X-Change-ID: 20261112-netcons_double_cleanup-43b00118c1c9
To: Gustavo Luiz Duarte <gustavold@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2721; i=leitao@debian.org;
 h=from:subject:message-id; bh=5wcjJzy/USJaZfmSnamW/hrROjyCXQQqW4AJILq8p8E=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9ceo+r3xwF/1X732ecFof2CxLKj5fdcvjqjm9
 oxf2PvljRyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavXHqAAKCRA1o5Of/Hh3
 bYhcEACMsDSTjiVuOzE0ZgnKG1DSmfbqw/2Cdj/5Qoj4Y4iRax8wQtC0XvGtXmtCVMZ72P/1Rwa
 oo120CAnU4NyWLVLW4RgPTkgjfCVALCE30b/SlsG3gHp6ML3I32HwYiw5PbkKbLSfwSuo9Yd+cd
 r9kiu/UppQ+Qy3AF09HOdxIbCjAgLPV4t2pwb7PMdqguhsQcpy+s9fnM4i1tt3NMkW52cCcdypP
 0Pj8hbP4/shZsXd4Hb9LdVUByNACuece+9ayyKhi6u9dv5m2pVDNc37T+cfOWHFSgZLEJT0ZD0+
 XlavgpurVQ9tO4e0JoNu6gnl5Kwzy+AYQxHSBDwj2fQirBpssuKRJaXZFxrAZrBF957e8dhbWpL
 OFgpuEnnFxF83R3hA8uRsD5+ZTftXII6CXsbTbBNrMUN4tHaK4bKoZn/UxXyU1LQvkXi7vV5KhB
 VoQirriKEr+knWeZGSWXgAhdGog5dFauipGHSYoOCTZQzS43lHPMHg1eRg2WRK71TSNlNBQrmHk
 SgknsLu/LjPlgOf/ZD+2CVIFOHgxJ0xj603nRqID7sPpkyOOJwsFv+qHJi3H4bHCia7w4A92Ei7
 qwOsFbuZ6pz7nT/6a60IXS5GWQdieF1xiloJiirTyYkotGJcAGzQeHcN6BtMZqTZLAQdvPR/LnI
 yNtVPdDtCp2sCog==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

There is a possible race when enabling/disabling the target through
configfs with netdev events that can call a null pointer dereference.

My robot was able to come up with a reproducer by adding a bunch of
msleeps() around.

The race is basically this one:

  CPU 0 (enabled_store)             CPU 1 (netconsole_netdev_event)
  current_enabled = true
                                    nt->state = STATE_DEACTIVATED
                                    do_netpoll_cleanup()
                                      np->dev = NULL
  nt->state = STATE_DISABLED
  list_move(&nt->list, &target_cleanup_list)
  do_netpoll_cleanup()
    __netpoll_cleanup(): np->dev->npinfo

And kasan reports:

  KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
  RIP: 0010:__netpoll_cleanup
  Call Trace:
   do_netpoll_cleanup
   netconsole_process_cleanups_core
   enabled_store
   configfs_write_iter

The disable path used to call netpoll_cleanup(), which skips a netpoll
without a device, until it started deferring the release to
target_cleanup_list.

Re-check the state under target_list_lock, which the notifier holds when
it stops a target, and queue the target only if it is still enabled.
Mark it disabled either way, as before.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 97714695ef90 ("net: netconsole: Defer netpoll cleanup to avoid lock release during list traversal")
---
Given this is not super critical or hardly faced in production, I am
sending this to net-next, even with a 'Fixes:' tag.
---
 drivers/net/netconsole.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index a9f9477da1ec77..4b546194f7179c 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1143,11 +1143,10 @@ static ssize_t enabled_store(struct config_item *item,
 		 */
 		mutex_lock(&target_cleanup_list_lock);
 		spin_lock_irqsave(&target_list_lock, flags);
+		/* An interface event may have stopped and released it */
+		if (nt->state == STATE_ENABLED)
+			list_move(&nt->list, &target_cleanup_list);
 		nt->state = STATE_DISABLED;
-		/* Remove the target from the list, while holding
-		 * target_list_lock
-		 */
-		list_move(&nt->list, &target_cleanup_list);
 		spin_unlock_irqrestore(&target_list_lock, flags);
 		mutex_unlock(&target_cleanup_list_lock);
 		netconsole_unregister_console(nt);

---
base-commit: c88fd6989aea9237a60a4859139a265bfb7ddc0b
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
change-id: 20261112-netcons_double_cleanup-43b00118c1c9

Best regards,
--  
Breno Leitao <leitao@debian.org>

