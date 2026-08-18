Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035B225A2A2;
	Tue, 18 Aug 2026 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061629; cv=none; b=cL7GPpVsGSgiG404fWlbKhE6IJr6jvXySIzK4ro4fpFx7Vi951hq7ZVu4YUDjxSjbsXxV11gA4/YhD35CXk8uZhofEM+miLkrH2Rj532ls/1vVqiHoLFTdvpbixwej8IlnS497ec/NdT00wxNSEdrJ0r471XRBXCAmBTlimFMEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061629; c=relaxed/simple;
	bh=5Eese8aMawmoJK+Jg+WZU3PtLP1Ptwez+8ZEIInXQQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DYpJA5boBvRUcwzkrtvLmOi7EpoKjFD1xT6AnrsGtYvPKcc2o90hBjXFPUJGoN/cpcGFXqE/2NApNp2yBw8Tq5vLU8wk4Cnwg4oG+xqleLfPQ9Cc9shrFPxpEnOrgz3t9QBhrIG1Il7a+PxOTS7i8zXJD+oUTyNKF2PmayiM5X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=imoTvYU3; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="imoTvYU3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1787061606; x=1787666406; i=wahrenst@gmx.net;
	bh=5Eese8aMawmoJK+Jg+WZU3PtLP1Ptwez+8ZEIInXQQc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=imoTvYU3KGgWEGFgBwF7vTPQnJQ+02E/w46OwQEteUXg2OLYigWGk4Fy14u+PPpr
	 832q2/EXzLIXQt/GhcXPII5WgYRkTRRkhluemBq5kA+sQrmYuokjPVT5GJmk7NPyi
	 c87WFlue8k31DbsuIdErCvxP/hyU0DAIEWGe+CZUEbCyC1kadZmpVRk93OC12qzBE
	 fAavcT/EzllJfbyVCRKI9O1ipF+mL2R9k1GskjYRQJ1DDAvYEfOT4qb1+JnLh4EIO
	 GAzEOlE9e7Wpu65Z7ox7b15lXm7eW0wfyRYIRf69s0bWCr8mFfVH6lSQFeu/dEZSf
	 +JAWk61ZBiwFin0H8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7K3Y-1x1qfq1TuW-0095Yt; Tue, 18
 Aug 2026 16:00:06 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] docs: oa-tc6-framework: Fix link to specification
Date: Tue, 18 Aug 2026 15:59:58 +0200
Message-ID: <20260818135958.17311-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vw97Xg+rYRsRYpasYuyICLUUWwZnAyx2l7LaYHiFJC4k/TAGNDV
 AAZIeaoegpUmBPx0hWXSPw1OsmRCmze2iyOa+/5G2FS00PtgShvls7/xFjR9s2bAV2Qyi7b
 BSCDVR2xBudd6N/QDvGPq7IJGQuM6lCkVyH4pJreFacTOsN0hHkyGEjfxP+qYcdk8NG8Zas
 6V5tQ/jMp8d8F4/KnYAvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uv/OysOQTyw=;3tm78nVokZhNfQRugDC0obnDBIS
 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
 xZEuu3KeJRBFd5DPyaYPobC1UfAc=

Current link for 10BASE-T1x MAC-PHY Serial Interface Specification
doesn't work - it returns 404. Update the link to the working one.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 Documentation/networking/oa-tc6-framework.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation=
/networking/oa-tc6-framework.rst
index 013824078cea..0feda2f9d840 100644
=2D-- a/Documentation/networking/oa-tc6-framework.rst
+++ b/Documentation/networking/oa-tc6-framework.rst
@@ -77,7 +77,7 @@ Reference
=20
 10BASE-T1x MAC-PHY Serial Interface Specification,
=20
-Link: https://opensig.org/download/document/OPEN_Alliance_10BASET1x_MAC-P=
HY_Serial_Interface_V1.1.pdf
+Link: https://opensig.org/wp-content/uploads/2023/12/OPEN_Alliance_10BASE=
T1x_MAC-PHY_Serial_Interface_V1.1.pdf
=20
 Hardware Architecture
 ---------------------
=2D-=20
2.43.0

