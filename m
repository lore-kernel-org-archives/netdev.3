Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BA02DA768
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181193; cv=none; b=CBGi5fK/k7GhvFopgLRBXIsOScQrMX+1IbRD08jJTC3a0CHeI+FlSWayqFVYWE3fSiafFbBE2FAdYDYxOjnJ2J9e9Zf3Dk5kta0zdgB1Q6glDhdwNO7VzJGF1WbOzWkQFBgSrJ3p1KlGuuFWzMMvrjoryHcK6KBKVrVH5mIUeB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181193; c=relaxed/simple;
	bh=rc8YWa+QqaRcpu1Oo0rtsTn3rXkcJx2hfU//4JuPyho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Frdumg80d6a8Kek1NvupVbqw45koNKgCddvBlQ01c/uzNwt8yr0ecj6Z8H0ekOU4OUcfbJb6MGq6LEAK39H+oib5pHJ8GBJIX2vodF5dA0v0OmTQyQQch9xZAg1BL30P+9CLEBUwzL+AW3cDhyRrfDFBm+ZB+NxuFl7QiQt6puU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=RPUITlzw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RPUITlzw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5C2C19425;
	Tue, 14 Apr 2026 15:39:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RPUITlzw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1776181190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=30hCCXzbFg17NxGsEUGIbZXIblWXSwm91E14SGXiyeo=;
	b=RPUITlzwwa7sAy4soSEK//iyrD9qap56ta+IUJO5CJkny73pKvghN9M4ZY9UO1RcE9PW48
	XpIs5qiHbhKJ4XcT8i7yZzK34gVxtIHu3tR2AubqDpx0y2X2xgE29v78LhvhV3RQUeRFk4
	WPi1yh3num+kxwMfnYvjp85K9j2yvHY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 006213c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Apr 2026 15:39:49 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 0/4] WireGuard fixes for 7.1-rc1
Date: Tue, 14 Apr 2026 17:39:40 +0200
Message-ID: <20260414153944.2742252-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jakub,

Please find 4 simple patches attached:

1) Asbjørn's YNL sample, finally merged. Sorry for the wait on this one.

2) A simplification to use kfree_rcu instead of call_rcu, since
   kfree_rcu now works with kmem caches.

3) A trivial formatting derp.

4) Fix for a deadlock by moving to using exit_rtnl instead of pre_exit.

Please apply these!

Thanks,
Jason

Asbjørn Sloth Tønnesen (1):
  tools: ynl: add sample for wireguard

Fushuai Wang (1):
  wireguard: allowedips: Use kfree_rcu() instead of call_rcu()

Jason A. Donenfeld (1):
  wireguard: allowedips: remove redundant space in comment

Shardul Bankar (1):
  wireguard: device: use exit_rtnl callback instead of manual rtnl_lock
    in pre_exit

 drivers/net/wireguard/allowedips.c          |   9 +-
 drivers/net/wireguard/device.c              |   8 +-
 drivers/net/wireguard/selftest/allowedips.c |   2 +-
 tools/net/ynl/tests/.gitignore              |   1 +
 tools/net/ynl/tests/wireguard.c             | 106 ++++++++++++++++++++
 5 files changed, 113 insertions(+), 13 deletions(-)
 create mode 100644 tools/net/ynl/tests/wireguard.c

-- 
2.53.0

