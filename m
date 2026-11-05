Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884319;
	b=vKpVhy7jxQ6WdAAlq7rV/5jYl+zJ39OPMfKIE5hX8nADta1qzWbFvPgqkPSn8WHUf4E9
	 R2M3Q65R28cqcGJaEVfmW2JuWJlapq1x1cCr00WLYVqX+1EeyH+I39ua127P8EsbLltDl
	 r9lzStHGNEvyCxlPrhQH7/FCS6o7g/fMu8f+v2jjC50c8kbputlkI7CI5zYki1rqKBE8w
	 LU105wCeyCyVlj9BAP++KZSB9xVMX+syYnJdKOvzSHeB6KgSuLT/mpuRTrffB/3hS1w0w
	 EsTWFeJq4w3bsH33aL4bhzoB30+HBNvWWe6mozDcqtqngQm60J1O8mHAI3HaMDxoVSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884319;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=lbxTrL6lDBphgT8CaA+APHWFBvsQxapEffwn41oJXas=;
	b=xyck4OfXAlYbtsf/iZo8cSoJvhCrxLc/uipe2RdSs9sxmTQ14htYKyKA5NE7JkUX4OIJ
	 Yma9cgchCwqXDOHedLoJb6IKkhTUvprTczmVPwVMDI/lIC6sKLfjesYjn0U2ofKxkUFlv
	 Vs66IOgX04IWRq04jeRugVEYI0SoxAycO6tzekLLO3o08ubhr36dOX6KmePxBExPg/Bd3
	 J/HwQy+DMCUpNKLz619zSjrRzIgiKQcQzE6gUENVr+MOn/JxZet/RfydqkBnaZm/w+1N3
	 hd9zQC87wd5Bg8yZ0zODqh38aN0GYapon6Hni8nEyq4kCFd7/D1EEtH7yoHe78hlewQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YniNUlTO;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4FD606EEAA
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 13:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C4FD606EEAA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YniNUlTO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793884318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbxTrL6lDBphgT8CaA+APHWFBvsQxapEffwn41oJXas=;
	b=YniNUlTO+bbIbaXegKMR26hJHCyBzuuck2gKMyUVUNy9bZMojWjVXlPk7M03cPbmd1YBlh
	TJNgZa0uBWo1ETyolDAe2TE83giczlEq0ihOUL4l8tyKtnY1YKIZOfFSlpTyY+JAaknt7y
	4jdyo+wgZVmyax2sQR0wU88v917EyKM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-v41bgYcNOAan_TBZiidl7A-1; Thu,
 05 Nov 2026 08:11:54 -0500
X-MC-Unique: v41bgYcNOAan_TBZiidl7A-1
X-Mimecast-MFC-AGG-ID: v41bgYcNOAan_TBZiidl7A_1793884313
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5BAE1956069;
	Thu,  5 Nov 2026 13:11:52 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D9EE73001DA5;
	Thu,  5 Nov 2026 13:11:49 +0000 (UTC)
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
Subject: [PATCH net 1/2] dpll: notify about a reference sync pair only if it was added
Date: Thu,  5 Nov 2026 14:11:44 +0100
Message-ID: <20261105131145.1010406-2-ivecera@redhat.com>
In-Reply-To: <20261105131145.1010406-1-ivecera@redhat.com>
References: <20261105131145.1010406-1-ivecera@redhat.com>
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

dpll_pin_ref_sync_pair_add() sends a pin change notification even when
xa_insert() fails and nothing has changed. zl3073x gets -EBUSY when
another channel has already added the same pair and ignores it, so user
space is notified about a change that did not happen.

Send the notification only after a successful insert.

Found by code review. Reproduced on a ZL30732A board with kprobes on
dpll_pin_ref_sync_pair_add() and __dpll_pin_change_ntf(): loading the
driver adds one pair twice and the add failing with -EBUSY sends a
notification. With this patch it does not, and the successful add still
does. A test module adding one pair twice shows the same on the monitor
group.

Fixes: 58256a26bfb3 ("dpll: add reference sync get/set")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 8389983f425695..277692d12d3d1e 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -1081,7 +1081,8 @@ int dpll_pin_ref_sync_pair_add(struct dpll_pin *pin,
 	mutex_lock(&dpll_lock);
 	ret = xa_insert(&pin->ref_sync_pins, ref_sync_pin->id,
 			ref_sync_pin, GFP_KERNEL);
-	__dpll_pin_change_ntf(pin);
+	if (!ret)
+		__dpll_pin_change_ntf(pin);
 	mutex_unlock(&dpll_lock);
 
 	return ret;
-- 
2.56.0

