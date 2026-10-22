Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683498;
	b=HpXqhDRhyry7KRRBDebh3UhMP0IU0W+ToSSWVcWP8w8ojCNbbR087WYmwvdYrNtjyNYA
	 03r8OVfUHXtQMueu5ht+zT+UcBTcabOM71UuHkoDPcA35T19ftMNd6+mFNkk1ZN76cv0s
	 Il6nLzyePRHEH+cYtvolcm0+pIdKhiIA9A5S/ISZ8JzYgrwvnUm5gODMedrXBmwB1SxXd
	 5dtggX3fAd9bg52UjHJHhv1T9ZRDAwKky2BmXafc2Siz4z6nrra2MRxTCLo5BwWDC/+Jc
	 1T7M3PRTIL5PvWe3An6Utnzf2uyMEknErUOOcSvRkJtte9GYxX+95NhHqM3JM7EpOpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683498;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=am6bUwTFl5dI3z4kAL5lsdvsU6q8fwpiKH4lHfohTvE=;
	b=4oHiLvIa7H6FozV3hJk3ABoRjIAOqEXgMifOxIjt7P9C6xghUV/VECXUzDubSajee3q4
	 19Oq8eB6U8qGh+qJ2Bk2OXjvWeKhQdJQnKz4gYdZngBLecQl8WtdIhuaGLVrKBz1neDpC
	 r1tC1e6JHAMYLY5/yjua5wvkr8CGaURM2EnbZK37y98zUZyGKeeZcOZZ+SFAT53eLH7Aa
	 8FEU8nK6O6F8lUgTM9NudcLqu1cZ+szqLwQGPJQlS8gBwujETGVk6vIf/yvGV+Nnb51JS
	 AjnBAGck+Ig61MDvHXRpnkn+zKoJB+XWSc+k9aeR5BuCKC69J2GiJuLSE7ZN3rN09EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aJ0fuz49;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C695A606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C695A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aJ0fuz49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792683496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=am6bUwTFl5dI3z4kAL5lsdvsU6q8fwpiKH4lHfohTvE=;
	b=aJ0fuz49tu+vEBHsmCTeNaRGtm1wRZyIzD9WkaT0adP3rGljKC5J/hlApOwKNtEiew1Ylz
	ArM/SpiVEyVytbhGmwsTmE9opzU2FmsPwnxb8T6i3eG1aqvf6ImBdiKKWoYvFE4qxsrk6t
	5AhWam3ZfcH5aFoRqaMe4W/PZwrh/Lk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-0alGndIDPyqanwoj-xusvA-1; Thu,
 22 Oct 2026 11:38:15 -0400
X-MC-Unique: 0alGndIDPyqanwoj-xusvA-1
X-Mimecast-MFC-AGG-ID: 0alGndIDPyqanwoj-xusvA_1792683494
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E517F1955DAC;
	Thu, 22 Oct 2026 15:38:13 +0000 (UTC)
Received: from pabeni-thinkpadp1gen8.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90FAC472;
	Thu, 22 Oct 2026 15:38:12 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next] Bluetooth: btusb: disable by default Qualcomm multi-subsystem
Date: Thu, 22 Oct 2026 17:38:06 +0200
Message-ID: <50f92fe870de717fca6368e750e0a6cbc8f46597.1792683340.git.pabeni@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

New knobs should default to 'n'. The mentioned one depends on
BT_HCIBTUSB, but the latter is enabled on most systems.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
this is a last minute fixlet to avoid breaking expectation for the
upcoming net-next PR. I'll merge it in a matter of minutes unless
someone scream very loudly very soon!
---
 drivers/bluetooth/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index db0189ca3cbe..0dca5e43edc5 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -96,13 +96,12 @@ config BT_HCIBTUSB_QCOM
 	select FW_LOADER
 	select GPIOLIB
 	select WANT_DEV_COREDUMP
-	default y
+	default n
 	help
 	  Enables various required support, such as configuration, firmware
 	  download, and error recovery, for Qualcomm Bluetooth controllers.
 
 	  Say Y here to compile support for Qualcomm protocol.
-	  If unsure, say Y.
 
 config BT_HCIBTSDIO
 	tristate "HCI SDIO driver"
-- 
2.56.0

