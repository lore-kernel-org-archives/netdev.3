Received: from ris.borea.si (ris.borea.si [193.77.156.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B05A36B912
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.77.156.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762377; cv=none; b=F/HfLh4a8MWXMzkaQLFQx0P4iuFQdMezgk6CvjP3vHPIgGuqrpSVG+mNxUQiJizFd1dIQahgoSVTW+wZxBmMYyY6I8Hq3XV/NFIhr9oIS6dled5CClEpcCMf3Ny9iC9DyudzRS9jfXV4az4k+RPwUanAJfmJ0aYR1h8xpNLKqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762377; c=relaxed/simple;
	bh=s9oFPKpGNvLL85L04bkjZ9O1VN4Jtu593NIAASYiry8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=rj/qo+CzRvXrcEWDsxX9Gg3FQr8S4rjWXU4EoPH0zmffhvaQNxL9K3C9hrcoY6XXH0YrPONeLtbR/gBjW/MBS3Sfk/P1y8e2jnI/F5Xr/uhSmpZftto/l1C0IpGtwFDVsXJE06qLZ/cp+LPGMTFaN1XjaTvYgsNcc/lsMIzEndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=borea.si; spf=pass smtp.mailfrom=BOREA.SI; dkim=pass (1024-bit key) header.d=borea.si header.i=@borea.si header.b=BK2KYh/q; arc=none smtp.client-ip=193.77.156.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=borea.si
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=BOREA.SI
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=borea.si header.i=@borea.si header.b="BK2KYh/q"
Received: from ris.borea.si (ris.borea.si [127.0.0.1])
	by ris.borea.si (Postfix) with ESMTP id 4hDGtz73TBz1px
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:58:19 +0200 (CEST)
Authentication-Results: ris.borea.si (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=borea.si
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=borea.si; h=
	x-mailer:to:date:date:message-id:subject:subject:mime-version
	:content-transfer-encoding:content-type:content-type:from:from;
	 s=dkim; t=1785761898; x=1788353899; bh=XbIwinSBPQ6jV79oyF4QUyL/
	zUZBXLXiBQ7h6a9Yn1E=; b=BK2KYh/qtvPMsdgp52p2xb7fuaRcnYAI2WZPu2hU
	2o/kyepIL35RgFAE1HOAQOofyQnUErSbt+Bfd+Mk0Onv8p0sNGjQA19HN17EvbBI
	dbTQ6X8QnxO0qtjXSJt2u6KuNkY79p3tVTxD9gotn9kN4lh4I8tUlYp5AbvXJHu8
	3pE=
X-Virus-Scanned: Debian amavisd-new at ris.borea.si
Received: from ris.borea.si ([127.0.0.1])
	by ris.borea.si (ris.borea.si [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id W6Vf9HnsfZhp for <netdev@vger.kernel.org>;
	Mon,  3 Aug 2026 14:58:18 +0200 (CEST)
Received: from smtpclient.apple (unknown [IPv6:2a00:ee2:a80:0:880f:f393:d837:b93f])
	by ris.borea.si (Postfix) with ESMTPSA id 4hDGtx2LdczDq;
	Mon,  3 Aug 2026 14:58:17 +0200 (CEST)
From: Matevz Langus <matevz.langus@borea.si>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: [PATCH] net: wan: fsl_ucc_hdlc: allocate enough MURAM for HDLC PRAM
Message-Id: <C736AAC7-5345-4B3B-BA33-299ED9566F65@borea.si>
Date: Mon, 3 Aug 2026 14:58:06 +0200
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
To: Zhao Qiang <qiang.zhao@nxp.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

More MURAM needs to be allocated than just sizeof(struct =
ucc_hdlc_param).
We have noticed MURAM corruption outside of struct ucc_hdlc_param. It =
was
caused by QE UCC HDLC microcode. NXP QEIWRM.pdf Rev.9 05/2018 chapter
14.2.2.1 HDLC Parameter RAM says 0x6c-0x100 Reserved.
Even looking into QE UCC HDLC microcode source code reveals it actually
stores data beyond 0x6c.

Tested on LS1043A, T1040 and MPC8569 boards running UCC in HDLC mode on =
kernel 6.12.

Signed-off-by: Matevz Langus <matevz.langus@borea.si>
---
 drivers/net/wan/fsl_ucc_hdlc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.h =
b/drivers/net/wan/fsl_ucc_hdlc.h
index 71d5ad0a7b98..e170d3ac9116 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.h
+++ b/drivers/net/wan/fsl_ucc_hdlc.h
@@ -60,6 +60,7 @@ struct ucc_hdlc_param {
  __be16 haddr4;
  __be16 ts_tmp;
  __be16 tmp_mb;
+ __u8 reserved[148];
 };
   struct ucc_hdlc_private {
--  2.34.1

