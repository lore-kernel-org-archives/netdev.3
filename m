Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C513242AD
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771580506; cv=none; b=DJhROgdk1iFxYGOcjcpHOpoFqZVnwc68afDLFkddsMob21OFSqNnzUZ9UtCcJcjiCjpzOMpLqJI8k+uYHshiEQHH82NXCV8BHUDWxa/fcC6KRnmJhBJ63Jnb6UfTGFIkY3DP1pKoPAPibpONQ+FI89DzvxvV1MAm7WpVFPL6pH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771580506; c=relaxed/simple;
	bh=IHDByayVdft/U+O6qZO9l4VpDd0hMzUSLoQwkqc4R0A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RamDkj5ZyvL97C/APwPKo70QLWVTMvuCOTrS5DvtvIbialt9b7FQav5/pMUfzDVoh/X8TIdty2FCDjYlAFFC6zqgl2BpLnIFLRsxWQA/MpnLnkBZ50obEseSVs2urIp5tkCg/ysanZw8EhUfZyo8i3IFUO3MIyf/i37Me/MVG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=o1sUkoCQ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="o1sUkoCQ"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 652BF207D1;
	Fri, 20 Feb 2026 10:41:42 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 75wlv_sl4OeT; Fri, 20 Feb 2026 10:41:41 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D4FD8207BE;
	Fri, 20 Feb 2026 10:41:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D4FD8207BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1771580501;
	bh=Aqkc913BnLpccGDHFiFb982eyK/Bw0ULAzt3enQHvEI=;
	h=From:To:CC:Subject:Date:From;
	b=o1sUkoCQGBNYGJnv7bsoYjLjvgZrpYoMglwzNAA9Uwofy9MvUdMQvwNnlC1/qrDN2
	 yg8oAfYq2OteD49jHqMcgQzpgA/VrWz7idzOogJ0g+QIzHP//F7OpZ2kNCZQXOFwxb
	 Y2ygYYTWNlY4xwXXgkaBCm4WgNOZuyM5Fmgq4dQvhMskBHi75wEml4KhUFpKaV9cG0
	 tziNrkGvq2f7DtERJz/wMZq6vu9Py2o8Tu3gnYobkMPDFRD/9dwpjs5mpzLNrEHZXT
	 KBLPlNif5cRoqvxBuXARHvBs65rNZbA5FtbttEkqem3cwCSoeHlTxIigfvHa9F+lDX
	 SpJNVEe1ZTlgA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 10:41:41 +0100
Received: (nullmailer pid 16441 invoked by uid 1000);
	Fri, 20 Feb 2026 09:41:40 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/3] pull request (net): ipsec 2026-02-20
Date: Fri, 20 Feb 2026 10:41:14 +0100
Message-ID: <20260220094133.14219-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

1) Check the value of ipv6_dev_get_saddr() to fix an
   uninitialized saddr in xfrm6_get_saddr().
   From Jiayuan Chen.

2) Skip the templates check for packet offload in tunnel
   mode. Is was already done by the hardware and causes
   an unexpected XfrmInTmplMismatch increase.
   From Leon Romanovsky.

3) Fix a unregister_netdevice stall due to not dropped
   refcounts by always flushing xfrm state and policy
   on a NETDEV_UNREGISTER event.
   From Tetsuo Handa.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit fdf3f6800be36377e045e2448087f12132b88d2f:

  net: don't touch dev->stats in BPF redirect paths (2026-01-31 12:35:27 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2026-02-20

for you to fetch changes up to 4efa91a28576054aae0e6dad9cba8fed8293aef8:

  xfrm: always flush state and policy upon NETDEV_UNREGISTER event (2026-02-09 10:28:05 +0100)

----------------------------------------------------------------
ipsec-2026-02-20

----------------------------------------------------------------
Jiayuan Chen (1):
      xfrm6: fix uninitialized saddr in xfrm6_get_saddr()

Leon Romanovsky (1):
      xfrm: skip templates check for packet offload tunnel mode

Tetsuo Handa (1):
      xfrm: always flush state and policy upon NETDEV_UNREGISTER event

 net/ipv6/xfrm6_policy.c |  7 +++++--
 net/xfrm/xfrm_device.c  | 12 +++++++++++-
 net/xfrm/xfrm_policy.c  | 11 +++++++++--
 3 files changed, 25 insertions(+), 5 deletions(-)
