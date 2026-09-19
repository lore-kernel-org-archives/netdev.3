Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F233603E9
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789806319; cv=none; b=rWlY2weHzdBT4bSivezwf52W6BucsI+kbMV0xNRsErfGs83OVQZkC4zHiPT5enuyzsBHy6zskaFAg8grWKrBLySLlCOmfbCV0jR0ldISMi+78if+8vYAQk10bkpSl06IA35t0ASgF91L9V+Htaw+Xw7uGMPsYx4sROmlczZZPJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789806319; c=relaxed/simple;
	bh=ju4x+ltUec78wE1Yltu+0EQFOC8grjb7bI38pDbA9YY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IfDwcxmbI9/EQLcbluiHwJpHW9dW8TOt5TWd/UaCNzjGvoUqHZCY6xFVZlKpETIxJlCwrz7iuXP80iWDSSOhss82EFvOYxcksdo+tXYu/+osm9zE1Oo6yeshHyb5X0OSyBydjtiRzl3TVcZnDWdgjB993poIPzZAgHVXWKz3KHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXDpGaZQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXDpGaZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3412A1F000FF;
	Sat, 19 Sep 2026 08:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789806317;
	bh=7f65Kjoq2Mzp5OZ3sSQzMoRcXyheHfcaYSKBdqbJTS4=;
	h=From:Date:Subject:To:Cc;
	b=XXDpGaZQzOYMgkwqnfM7WSLPqzbR6hdIK18sfj/4EU4f6Z87JvwHgH9u9N1VzUZvH
	 Dnc3lD2rvshQ5wL4KuNFKmrtgxbbs+EmG8kPnahRts1YbqJICrNhjeZGuamiImZkHA
	 2ONQkjudy3GF4d21Acov08SrV/w59TfzDndAfMVVrJQrvBIIrqHRMvoxJ9fltfmkvW
	 Qz1Ft3PFfc71Y/pQmsZ1dOLevV1+Dd0TtcEam8KB2f//g7NVMVYSIjLc6zNYZwSStR
	 51zdKzVhzEHD09POrJf68AK+LaXJV4af4fajNQ4LFcsh19rP8nixgcrs4qKrxuSGN2
	 iavkV7JB3VtSw==
From: Simon Horman <horms@kernel.org>
Date: Sat, 19 Sep 2026 09:24:19 +0100
Subject: [PATCH net-next] MAINTAINERS: chtls: remove entry for removed
 driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-ch-maint-v1-1-76af77aca5a4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBuwIvu5SrQQnWoWTaESgnT3p
 OUHj5chkGcKMFcZPD0c+JKCpq7AHkZ2QnbF0KpWq6mZ0B54GpaIuhsH6o1T1vVQ8tvTxulfLSA
 UUShFWN/3A2Hwt9BkAAAA
X-Change-ID: 20260919-ch-maint-6387e5ad0cd5
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Ayush Sawal <ayush.sawal@chelsio.com>, Sabrina Dubroca <sd@queasysnail.net>
X-Mailer: b4 0.14.3

The chtls driver was removed in the v7.2 development cycle by
commit cdae65fc43f2 ("tls: remove tls_toe and the related driver").

Remove it's entry in MAINTAINERS which was left behind.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1a3ec390096..59ee1cff04ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7091,13 +7091,6 @@ S:	Maintained
 W:	http://www.chelsio.com
 F:	drivers/net/ethernet/chelsio/cxgb4/
 
-CXGB4 INLINE CRYPTO DRIVER
-M:	Ayush Sawal <ayush.sawal@chelsio.com>
-L:	netdev@vger.kernel.org
-S:	Maintained
-W:	http://www.chelsio.com
-F:	drivers/net/ethernet/chelsio/inline_crypto/
-
 CXGB4 ISCSI DRIVER (CXGB4I)
 M:	Varun Prakash <varun@chelsio.com>
 L:	linux-scsi@vger.kernel.org



