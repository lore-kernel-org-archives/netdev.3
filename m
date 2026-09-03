Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64AD2DB791
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788471935; cv=none; b=XOUdG57vpSh1m/oTyhsvi4Wjygw0OBraqv/V0vw0cpMmSrZXWgwwUOunvQGPJt4TCYo5b61Yvc9RFeS5FVdrer1rhxrOpx31l/cHXs7QQL45Kb4ptz8eNd+rvMM2UUrt46CnTUqAygBqg8dP29dBsnwxa9RfSU2faU6jIwop5BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788471935; c=relaxed/simple;
	bh=nXUDsFuZ0+f0NpD2kzdMb/CMR/WxBY5kXmLejNzjHdc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W7VYlwNQlzqP2ho7jvszkFIWqFDk4znI5CGg1vjH4jVPiNlx1r57tutBFtBLWGkNiFTuNcSDnUxr0G46n4dwnAl00cv1hgq5iL+GM38NZZ/9i25gBeSQyDrLhjp2FEb2IbhXI4n5Etye/sHqSLsQcqBwoRy1Gad/72Gz0LziRZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDnDbHzX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDnDbHzX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485E71F000E9;
	Thu,  3 Sep 2026 21:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788471934;
	bh=RRq3/KlHERIgSlTXRVtao9IRe4CY8GsUyqXlEGuddVY=;
	h=From:Subject:Date:To:Cc;
	b=EDnDbHzX2AA/iPlPapJ04taVhPUa3L8GtgoQs4Sg99uXF9CHGMvV1NJHGcRoGPvPs
	 U8rOR+Gf/mwxuPGMh23Av3ewGfIDNPoJYn32NYqAmG9AP0Ki5UErFlwK6+Ec9OTV6z
	 wbYnirOCtfOkNpNPYLVp+YnOGgBmgnQZ49OQcGe1SSRlJRxFBkmZO9WfrPXeDPPs2g
	 8zR+JmXD1w/7wyhrzce++pT5LqslRqYdPX0Ew3d4vnK/NShUb09c+Nfh6nrldldDiv
	 lgwvlZ4mnNDUDMM6xDKxOJ3TTvfZYaAwK2G0Cc8jRw38kFdRSzVunK+Ei7hO0gJ4Tn
	 Xt0RY11R8/iOA==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH v2 0/5] net: ethernet: cortina: Fix RX budget accounting
Date: Thu, 03 Sep 2026 23:45:28 +0200
Message-Id: <20260903-gemini-ethernet-fixes-v2-0-2bbbd598ca6e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBREr0L+2m/aGoq48h6GhcAIP2pL2oZoC
 He3cAGXbyZvZqGIIIh0KRYKmCWKdxnMoaBuvLsBLH1mMspYVSvNA97ihJFGBIfED/kgMmxvUHX
 lqdMtZXcK2Ius3prMo8Tkw3e/mfWW/lucNSsGbKtqW5Xnyl6fW/06+jBQs67rDwp3e8u7AAAA
X-Change-ID: 20260901-gemini-ethernet-fixes-e6d2e7c53c1b
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Joe Damato <joe@dama.to>
X-Mailer: b4 0.16.0

Finish RX updates before releasing NAPI ownership, report actual NAPI
work, charge dropped frames to the poll budget, and drive free-queue
refills from consumed RX descriptors.

Track RX drop state across descriptor chains so discarded frames are
counted exactly once.

Tested on the D-Link DIR-685.

Hi Sashiko, yes there are more latent issues I will get to them, but
my LLM thinks those are on the top of the list.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v2:
- Finish RX statistics and free-queue updates before NAPI completion.
- Enable RX interrupts only after successful NAPI completion.
- Drop AI slop renaming of received->work_done.
- Link to v1: https://patch.msgid.link/20260901-gemini-ethernet-fixes-v1-0-ee6b09675876@kernel.org

---
Linus Walleij (5):
      net: ethernet: cortina: Fix budget accounting
      net: ethernet: cortina: Finish RX updates before NAPI completion
      net: ethernet: cortina: Count dropped frames as NAPI work
      net: ethernet: cortina: Count RX drops once per frame
      net: ethernet: cortina: Count RX descriptors for freeq refill

 drivers/net/ethernet/cortina/gemini.c | 77 +++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 30 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260901-gemini-ethernet-fixes-e6d2e7c53c1b

Best regards,
--  
Linus Walleij <linusw@kernel.org>

