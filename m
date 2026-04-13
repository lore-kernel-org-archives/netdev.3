Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23ED3750A2
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080417; cv=none; b=cFuO1B7dWD7mrvnjoKjutxPxs2msfOtu6k27Eo4cZl6SIRBkGS/OJsmupXgjrxVyev5025ZfyqcEbw1Fo3pP2wcULXqYjpzQb7nLu9nK3eJ4JX7ADmjut1OYTrHwZCLCMcOAyETNeCYTWQCW7VALTuBavSDUncBaMK2+Q8r4xDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080417; c=relaxed/simple;
	bh=b+nxtDG/y0OXkGs/+WS8f0NBwVPlspQe/Trykb9EWJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rD+kGwgV23b32kZkt8Ou0lYiACxZxytB2FtVIIaVw7oDP3SKTP3KuWpE6kNvl5m5WZzuzSr5vpYcrJKCNT1wHgpS2UNXk9KeMBfJIph4NUsoTzpRUnhUTpqlmz0kDDn7X0W5XwXRpsNENobXo0A+Pyy70yO6Zqc2zGyRdAsJFGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=WvuLGGUu; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="WvuLGGUu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=pMaXacByEsrFrRfkVN5b2+gwMh+L7nfDuyk9KCfZZkE=; b=WvuLGGUudzYhzstI3p2gw8I9T+
	eYJe4QgdVkw1muAvn5zJ187R1cdEdiiz1L7Zv7h4lYIW0i/Pc7OCZMkXYv+72hTMu7L3ml8wC3Nes
	sHJ/ggiGKieEqXD6Zc2ViaYABqDaj/M9ptRdEnGcfxQYpI2KHg8XreetHjp2QR3CAgMNa3EsWb09c
	NBoY0uheOL3d43geughlxNkmZB4UjWp0VkUva1sJh8xyhZoLkZ3J0vZMshlD7gcqnsqKTOmHRqjxT
	HOnkie4SUnmo/yrN/dhvLOvOMg9XF3S3AyaJTNmer53m9e5axskoMqqR7UvylnTcezEFxLCKIKbn/
	qeWj3Q1g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wCFeG-000ILm-0t;
	Mon, 13 Apr 2026 13:40:12 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: pabeni@redhat.com,
	dw@davidwei.uk,
	razor@blackwall.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/3] Follow-ups to nk_qlease net selftests
Date: Mon, 13 Apr 2026 13:40:07 +0200
Message-ID: <20260413114011.588162-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27970/Mon Apr 13 08:24:33 2026)

This is a set of follow-ups addressing [0]:

- Split netdevsim tests from HW tests in nk_qlease and move the SW
  tests under selftests/net/
- Remove multiple ksft_run()s to fix the recently enforced hard-fail
- Move all the setup inside the test cases for the ones under
  selftests/net/ (I'll defer the HW ones to David)
- Add more test coverage related to queue leasing behavior and corner
  cases, so now we have 45 tests in nk_qlease.py with netdevsim
  which does not need special HW

  [0] https://lore.kernel.org/netdev/20260409181950.7e099b6c@kernel.org

Daniel Borkmann (3):
  tools/ynl: Make YnlFamily closeable as a context manager
  selftests/net: Split netdevsim tests from HW tests in nk_qlease
  selftests/net: Add additional test coverage in nk_qlease

 tools/net/ynl/pyynl/lib/ynl.py                |   10 +
 .../selftests/drivers/net/hw/nk_qlease.py     | 1142 ---------
 tools/testing/selftests/net/Makefile          |    1 +
 tools/testing/selftests/net/nk_qlease.py      | 2097 +++++++++++++++++
 4 files changed, 2108 insertions(+), 1142 deletions(-)
 create mode 100755 tools/testing/selftests/net/nk_qlease.py

-- 
2.43.0

