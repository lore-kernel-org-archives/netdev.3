Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143F539DBDB;
	Fri, 21 Aug 2026 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787300983; cv=none; b=h3wXgdLhaHZA0XSAnnGJC9i6V9u2Yt2X0VCIV2QTb6ZPvzfKOYrI7lkYHCrYD1NVy34zULAYzsWIfPTh+Oq8zAA0z/77C+szJk+PUEKErzrapFMi26bT98FP0g1WQu2dZjekBuDsi1ZXz6Sku23ynNkWCynal8clfyFqDvv9jmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787300983; c=relaxed/simple;
	bh=pO6xYMFJKTe2ShsD7yUi6/oCNnhbhZG9kHUEP8r2PBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NTg+D9jhUHAMITcT7NkPoMH3Iv1V85hSgDxFkSNgf/oFLh0mat4I6/cyrkfIxEftP7VB2CFFMO2hgoVpglMU0JWcflQ8W7eNZXpNM1NvrQd59bCa3QMSlY2Gh+v5hAcJ6Dm9rRzfmO2ysM/o0aUzb1Esc7DBrof4ZnfiXK3YnIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=rr+8XmF6; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="rr+8XmF6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=5T29lbsacAkEP7xO4Tkdq4ITYB3YlBN0FJhlVC1mJIQ=; b=rr+8XmF62HspNhs0tMBGizxabg
	1Hty7xbRRm22X1ARjTbetAy5rka7wSaQGSGWyRY3M92L2OEKblRuVYZd/2rhsFN50+cYNAUvUkknX
	gpnAGpfKMWzhyJZGDsmt6T0gmvYOtjKl6Bg4dw2EIQLs/L9U8FGwe054pkfmkYL2WLFVtfbTeBpTt
	+wTDTj3F+jhXC7E+TNE+vybV/O7Yj2mFg3WiThG1p/tEvLSdf+9f4EpgyYrz5GrNfiwuUYunYf2FH
	IMsjSIjDmqN/s2v7kjm8P4Hmq662V+q95coz3T2Z+9kVsUEm5lyczG1Lvn5zp/sn4/x5BnD86A203
	2zvckEEw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wxKd4-00BD4M-2y;
	Fri, 21 Aug 2026 08:29:36 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Aug 2026 01:28:32 -0700
Subject: [PATCH net v2] net/socket: remove unused
 do_sock_{set,get}sockopt() exports
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-hch_not_export-v2-1-c62b62ec459f@debian.org>
X-B4-Tracking: v=1; b=H4sIAC8MiGoC/3XNQQqDMBRF0a2ENzYlsaVVR91HEYnJ1/xJIkkQi
 2TvBecdXzj3RKbElDGIE4l2zhwDBtE2AtabsJJkh0GgVe1TdbqX3vopxDLRscVUZK86Zy2ZWek
 FjcCWaOHjAj8IVDA2Ap5ziel7TXZ9pX/erqWWZnnMytFLkb6/Hc1swi2mFWOt9QfbIjHrsgAAA
 A==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=leitao@debian.org;
 h=from:subject:message-id; bh=pO6xYMFJKTe2ShsD7yUi6/oCNnhbhZG9kHUEP8r2PBs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqiAxpIV8zfBLUI7tU2R5RlOyLCRB0h2Y4UmENl
 LQ0+5FbQFKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaogMaQAKCRA1o5Of/Hh3
 bYsiEACSJZvzs2w9xMiuov9iLlyjzSLvsj4KfQZc2ZDOXGSxPTVaX/hoCr98Nd5xr3aysu9f/Os
 IKMrvWcBSY6Cuw6264PwLyoSEfnkEiYuwLdjyPIDOOSXr94N3L7MyqV0NX2rGbj2xaCmRBLSrRc
 zbNCXKmlmNfU9Rhp1m2xAkMimI5TTAK8nBvPf7nAU/+Z7KdoM0inPB2YeiSKD+R2ok3msW34zcD
 QJx9cUtNB9lYyIb/se0vf6BwPSX2pvHKGvkYCyL3Xl5qQbL+xlKer90vXx0b3RPxuvvWl/mnFVx
 AN1zrV/V8GVUdiboniQwVHNNXp7zC98gGlhO+frR4Qw+J5UU4yhT0T17DXfajQPV/ZB9RB7Zu89
 XuLLAnobt73+brbu5dtY1635/avphuVeWhzWb+LS7JIXjDrWPO40DTiOjunJNUJHLbXHBtZ8RkP
 mVUR1WU7jqg/SAQUfoidpWZ1+KWFuzu7lynuT4b3IWJ2OYJ9HlHndJsbeB3m2HcrdeQFtj1Vvu0
 E54nKJphM3KwB8Jla+fC3hr27PAsssfMdb+x8z/jITramcM7bwvVKGxIMfoHbYCjPjCq/tWGuyl
 5K1BKQcHT5zB14vqFAket9i+fnmFr3SgIKTEyOW36w0kicIphxdniHYDzcXOV7vXLAOCjazS1Ha
 Q6EEGUJYOguDlCw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

do_sock_setsockopt() and do_sock_getsockopt() have been exported since
they were split out of the syscall handlers for io_uring to reuse.

io_uring is the only caller outside net/socket.c, and it is never
modular: cmd_net.o is built under obj-$(CONFIG_NET), and both CONFIG_NET
and CONFIG_IO_URING are bool. The declarations in <net/sock.h> are all
it needs, so no module has ever been able to use these exports.

Drop the symbol exports.

Fixes: 1406245c2945 ("net/socket: Break down __sys_setsockopt")
Fixes: 0b05b0cd78c9 ("net/socket: Break down __sys_getsockopt")
Suggested-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/all/20260819090439.GB9267@lst.de/
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- s/export/exports/ in the commit message (hch)
- Link to v1: https://patch.msgid.link/20260819-hch_not_export-v1-1-af4b0de70e13@debian.org
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

