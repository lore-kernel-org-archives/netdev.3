Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357E54DD6C6
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450936; cv=none; b=UbDMK0dO99R0pJfEE+Q50ITQFM81092uAEqP6JIP5vmubVpufjMQWHMQjS+KYj8p9jiFDBjwzM0e5/NFON3PEVwwicMlfBrIMBZI9ModeUCAJD8eO9Ff/OixNRhCmtluLrt29wm4L1nv2dz8fPbCHeemvpZ2N/BF3fioMYPPxhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450936; c=relaxed/simple;
	bh=FhI4jwB5wVe5kfHJwrIsGsHJidCSbsdWAb/7DthktI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ik/XU/l/f9F6Fn5J+pq/F60j1Go7gebpKgLt3jhzKo0W8A6T/lAQss9kUgRiJMzlQ9wr2b6c9UxJuVCJrsSSNsqS9IYPWuhBzCBv9PBdKUiZmoH5o+pckhjKgaMiyUpdte9bk9QPCHEYXELniZvk/jeH1QFCeaY0otHABTI9Byg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nsAYQ7Uu; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nsAYQ7Uu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 815D51A197E;
	Thu,  3 Sep 2026 15:55:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 548C36054B;
	Thu,  3 Sep 2026 15:55:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F31411C79F4D;
	Thu,  3 Sep 2026 17:55:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788450930; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=C0YhNtOAqu9STBbW5yxOQL427yKmiBfnh4vUyQZuEzc=;
	b=nsAYQ7Uumrq90sszrFI2yB0Wq00Am3fPefV25tA5MkQ+Kn+Ocp3RH7Fn5vlyzRUO1nsXZg
	PFo3Q8QUGB2ffDVCeIn3+jjwjJrxha7+H2Ag8Zds8gjlzkG22dVn3iPp1hTva7PH7y4A8K
	E8B7onJoDj1aL6Tg0lbU+jreXYM/kk8cAKwBRrrW2eJbvgjkj3meIboA5hdGspm0UyAkPL
	k6EfP4FM7kq/aubBh2RBOPQjNh7cCHTZbmDO/0b68skgerRTP1tXicHrhOgm63VpL55Eeq
	E4/QxWbZpAp7qv+XLw/T68bvUmhSxreEz9OMDG87nc81LaIY6qELo3/FEsAUEw==
From: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	matttbe@kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 0/2] selftests: drv-net: Allow cross-compiling the hardware tests
Date: Thu,  3 Sep 2026 17:55:21 +0200
Message-ID: <20260903155524.2241065-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi everyone, here's V2 for cross-compilation improvements for the
drivers/net/hw selftests.

Patch 1 fixes YNL cross compilation, while patch 2 deals with the
iou_zcrx check.

Jakub asked :

  I assume you don't actually have luring for your cross- env? Could we
  keep it simple and just declare luring as unavailable when cross
  compiling? Because the probing compilation rule is probably missing 
  more flags to make cross compilation work.

  Ignore if selftests using luring do actually work for you after this
  patch..

Turns out I did have liburing in the CC env (generated from Buildroot,
which supports liburing), and the cross-compiled liburing check worked
as expected :)

Tested on an aarch64 target, built on x86_64.

Thanks,

Maxime

Changes in V2:
 - Update the topic for patch 1
 - Update the CC construction for patch 2

V1: https://lore.kernel.org/r/20260901164200.1124343-1-maxime.chevallier@bootlin.com

Maxime Chevallier (Netdev Foundation) (2):
  tools: ynl: Allow cross-compiling ynl and associated tools
  selftests: drv-net: Use cross-compilation environment for the io_uring
    check

 tools/net/ynl/Makefile                          | 1 +
 tools/net/ynl/generated/Makefile                | 3 ++-
 tools/net/ynl/lib/Makefile                      | 3 ++-
 tools/net/ynl/tests/Makefile                    | 2 +-
 tools/net/ynl/ynltool/Makefile                  | 4 ++--
 tools/testing/selftests/drivers/net/hw/Makefile | 5 +++++
 6 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.55.0

