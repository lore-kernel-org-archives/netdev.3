Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294490;
	b=Jiu9B2Pbq5c2FEfOpILY04vqYCtyD+fNEouZS1A8V8d336CfV2ghrVDaeCMeoZL2rbE1
	 LdNpvEMbzL0Htb896eCw0vNEnJ0KkV1eu9k2W2TQqfC+E1iqH5Rm65AIEvuJCqtTGbio6
	 04P0w9Yqp9MNei90G4nCOtqJ1FVzKBYnGepE7jBIENAPDhdJlIaV2coH1ppnmLVMM2ATK
	 AY0fhfDGD/FyQELD+Aic650oHM0uQGsML7Bnhf5fwPY4wODCpfDTqtHTKzA7cRR/zDRYj
	 JWGsuiyHaLFnmIyy8QSUbCipNYzOcm/FjG6Zg8x9KBh6xPuokuVSNiaWKGj8Wih1rNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294490;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FnUITX5l0rY4dD1guY4U8vouradcFBCyDlI8pSLx4qA=;
	b=cObPgjnsr+T2BcNoJ5Wwc5jjKg0ktLEL02tlNfLKkwc7nJ0FP13SQxS9mrywxNl015il
	 tYWgIx2id8kuA2XQt4eBP0AbtyKtXpK9HcX5ZvaAHKqRac/tiSnY5wD7pJYZzO762qk1w
	 f4Xg2GKdwQ9uuxmB12bWoFdtor00IazCa07U3RTonwnt7syouzZFxn4GDzgTSll/NpoKO
	 x73ZPeGtJvrd/Lhfp9tUQKEsTPsjNr2RRi9NrIKthM0xvVPUoPjzFOJsnaeY5/GATDv0B
	 +kg+nuHdYsF/BCPol03dm3KgMk2Yv2hZlTKHtBIdG+JBGKMsOIKLFRD7t15pRvlyseg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="hB/AKAmC";
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC224606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC224606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=hB/AKAmC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=hB/AKAmCgJs7B3DDEy0Xbs2GVhGPu8UdOkasORU5pazMojtjlJwxYEF55kIY2vn9whzYsl0VGuRB1
	 5oQHA99JMNQijU2vzjZgeyexa4JXbZU/9a10LhOC5yd+RMT2GrIKMfDYGb8/6/LQF9TLDcbX/PNNr6
	 MJ8ZSgEpkEs9fvc8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af2c2d48d2-9807e;
	Tue, 10 Nov 2026 15:08:07 +0800 (CST)
X-RM-TRANSID:2ee36af2c2d48d2-9807e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af2c2d35b4-ab420;
	Tue, 10 Nov 2026 15:08:07 +0800 (CST)
X-RM-TRANSID:2ee16af2c2d35b4-ab420
From: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linusw@kernel.org>,
	Imre Kaloz <kaloz@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 0/2] net: ixp4xx: fix OF node leaks
Date: Tue, 10 Nov 2026 15:08:00 +0800
Message-ID: <20261110070803.1099-1-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

ixp4xx_eth and ixp4xx_hss resolve their NPE and queue phandles with
of_parse_phandle_with_fixed_args(), which takes a reference on the
resolved device node.  Neither driver ever drops that reference, so
the NPE and queue manager device nodes are leaked on every probe
(and on every -EPROBE_DEFER retry in the ixp4xx_eth case, as the MDIO
check happens after the DT parsing).

This addresses part of the "bunch of pre-existing bugs in the area"
noted when a related probe deferral patch was set aside earlier [1].

[1] https://lore.kernel.org/netdev/20260831170858.7e23643e@kernel.org/


