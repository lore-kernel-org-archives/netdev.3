Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DBA382F0D
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075909; cv=none; b=WhfCrmFgHvYe1iaa7nix+ppVd3Tn6KL8vLi+ZB83rDWirm/L8FCatAkwreLd5EhQNa9DJ0vSrsiB0drFqsVLRz8WCr3fTzeC5wcwGp73j41kcEbGPWIvOVDXMg8fzRAXhJsbwXWtWdOn6JRBfBtoMEbfQL5lmk5AOH8vMO4BGmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075909; c=relaxed/simple;
	bh=IGch7xvTf1Fu43oh7OINjCTxuCXo8GfCYPUZBXh2/lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DShGtVXSJZlGoAvWQbViPOAUeuEt1ZG3IdrojGbmgEJhlix4jLzqEzIqOX4ZlIZ2B7NAKuaYy/ENTdvd4nkR7ME037aNa640dMr+o3tqQ4aUlERhMvm2vr9FnpYqnk3sXnw9wRoiUbwdnuGR3AVIz06D/PJwtNgGq2w4nS9t6mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Qrx8EOPR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Qrx8EOPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C141F00898;
	Fri, 29 May 2026 17:31:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=Qrx8EOPR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1780075906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=abct2tKoHBbQVRlwyfMiEHcPEr43XHEVMAOKPMLmAjk=;
	b=Qrx8EOPR2emauR8oE6vrRuVM8GS/D0dgL6hwx9N7DQJhNeo0Rb0ROrAUjvtRmWy0ojhvrV
	diQzc1DYxrU9oSBHKWcDNC/94Pf+eDXOt/4EShg3pXvZ2lBlL3mCC35VWGxdyX+I2sk9ei
	4jVEg4ElK3FkpKb+0ZA6KbqlbT743/Y=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 66acb8ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 29 May 2026 17:31:45 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net 0/1] WireGuard fixes for 7.1-rc6
Date: Fri, 29 May 2026 19:31:33 +0200
Message-ID: <20260529173134.3080773-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub,

Please find one small patch, fixing the order of adding padding onto a
packet, to ensure padding bytes get zeroed properly.

Thanks,
Jason

Jason A. Donenfeld (1):
  wireguard: send: append trailer after expanding head

 drivers/net/wireguard/send.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
2.54.0

