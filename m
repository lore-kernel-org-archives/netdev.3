Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884315;
	b=PyXr5IvEpoTO4ffeIcxktrmxFnvQ1F3c16EaLOKGbW/3zXcwx5MOVTNp3Tlhwo/nwoTJ
	 rh2tIw5b0Gm252/20JYTllzPREE5iuAIYt0GhDaAbzEL0VN/el2ZTX0orjjf7jJC2utSK
	 lqRUvGMRZFBqGJyZC4pBy4EbPL5jPm+cdWm8pkBdrnKGBuLsEmVvrDIR9T3i2xYop6Orw
	 qVaR1CPUML2vK0tyCK7jSPVDAMPfE56Q+nYHNwLMzyfM+VMxtYDAYeD1lCTlawji38+a2
	 mf328udNKgO0aDW1/pzZrUghPonRa37WUmlCeQG01K1Hu3LS6Owpzh5wHcDvkyvYBsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884315;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=KUYsZhGyE5SdfciTMq7iOAS9xFl5J1m3SL9fvIb7dyE=;
	b=HRKk0w+kEdaruFbfuh0Smx0Xh7QDDURRGGwXePfewhNu9IDceEaNJU//BbJuyt8YXTIi
	 01SgIhkLl7HpuGxgHGnyw6jH9rjyDOlPHQBNWQo5LUlEOrVfN0+G/ztvJC9HzBRY/BLCw
	 acwXKlq8qE6YzjR5Blc/z8h9YAWm6GqP62ZAYnASEg39AHCLK98MQbPruYMsnP0HRxYJT
	 nSbUZUKs4ZerqlQTbcZeDsX/02+20YYwkcEy7WBsljOm4Ib2uT7vNyxin4gbuliS0ehvM
	 5pn191qsfqZK17ZSvo77mloCBUuXtQpT2p3ANKs2Q9mInkmw7mgr62vliOwjaYcJsyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XkJw8IJf;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571DC606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 13:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 571DC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XkJw8IJf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793884313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KUYsZhGyE5SdfciTMq7iOAS9xFl5J1m3SL9fvIb7dyE=;
	b=XkJw8IJfuZHW2wwBXqcpxQqMS0xgmvcHLPm/6hGgQZB44nCikScMbuz8yOQJAOYtpU9sDR
	o0/riw3LNJzfr1NuLsKcwuzITFxynqxD5AyR6Ibu7nD00fxEDF561SA5TkS5STiLYACFlp
	uKKYVYhVTnyJf54bxoSNDrKjB0y1vj0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-9BGVyJFtMP-52fwvodH0LQ-1; Thu,
 05 Nov 2026 08:11:51 -0500
X-MC-Unique: 9BGVyJFtMP-52fwvodH0LQ-1
X-Mimecast-MFC-AGG-ID: 9BGVyJFtMP-52fwvodH0LQ_1793884310
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D5931955F3C;
	Thu,  5 Nov 2026 13:11:49 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7164D3001DA3;
	Thu,  5 Nov 2026 13:11:46 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Milena Olech <milena.olech@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Michal Michalik <michal.michalik@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] dpll: fix a false notification and report interrupted dumps
Date: Thu,  5 Nov 2026 14:11:43 +0100
Message-ID: <20261105131145.1010406-1-ivecera@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Two small fixes for the DPLL core, both found by code review:

- Patch 1 stops sending a pin change notification when adding a reference
  sync pair fails. Reproduced on a ZL30732A board.
- Patch 2 sets NLM_F_DUMP_INTR on pin and device dumps that a registration
  or unregistration interrupted. Such dumps can silently miss an object.
  Reproduced with a test module.

Ivan Vecera (2):
  dpll: notify about a reference sync pair only if it was added
  dpll: report dumps interrupted by topology changes

 drivers/dpll/dpll_core.c    | 22 +++++++++++++++++++++-
 drivers/dpll/dpll_core.h    |  1 +
 drivers/dpll/dpll_netlink.c |  4 ++++
 3 files changed, 26 insertions(+), 1 deletion(-)


base-commit: 6baae996ecf6a3f57b08ea6f6786e29af9260f51
-- 
2.56.0

