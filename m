Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768936C5B8
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067986; cv=none; b=W9FINDB99PvsJL5IzTXHKN4Sv9m0T8tlfyNOK6NM3G5JFzG+6h+KStq9s5p0DleTG9i6OaiZCqFDcy9QnrtV61SUm58isurTY4wYZkON41dyTxAKhVA7LXL08fGFk1lhfK+K/NH+puMcXQIQbPOUTvpsbJ24A7ozPa4Fheu2GsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067986; c=relaxed/simple;
	bh=Mh6GmTAcC6CCH1HP0aQQaSTCLqmkUkcVsNO8jNHEmLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZmRUG6DHTJuIIuCIWJBrAq3u4QZf2ULw3c5N3Uofo5NMrJZ1qB05gBmmSvQGOpwk9mi+v8fcvwqnm7+RX9+Q2zMd6x4MJgm+lHWfZdYqgudlw4TZjofiGcKTD5sG08/xE5p7Jli4NAyM0ZuQuat3yA9iaUynisdKOf1l8RMEoQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3mL5tce; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r2+qbaSM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3mL5tce";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r2+qbaSM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769067978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t9dKCUHIDcz6wnU/JJwI6d22joS1LJKYpB/XmCytXco=;
	b=P3mL5tce5duRpy9KWfvcdTNXOn6wcXH8pOy2bk8QkHL6BrqNRmX2jwuEsKsgIg70LLLnB5
	APTZErHYsYPMVCid61Eno5adgfj32wyulGW4g3uV/nzPk9PVNTIyuobXiQkp4EgYGQqAf4
	zwAdK0fewmxa7P3zmeA1orhgK9AzUz0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-cd2fFWPIOkOjshIA3yxNow-1; Thu, 22 Jan 2026 02:46:16 -0500
X-MC-Unique: cd2fFWPIOkOjshIA3yxNow-1
X-Mimecast-MFC-AGG-ID: cd2fFWPIOkOjshIA3yxNow_1769067975
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477c49f273fso5927905e9.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 23:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769067975; x=1769672775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t9dKCUHIDcz6wnU/JJwI6d22joS1LJKYpB/XmCytXco=;
        b=r2+qbaSMmTV7KsscSYKPh7Va/vQ7sqyKXu1QlAp+uHtubnGaWhztE7WD30AVBh9Guf
         qDgm85TAh5Aw1oScUHe3O5F/5IqfiA7SRdPu60d03KgssYtpRUzRkciZFjvmRBp05q5G
         Tn/OopfO+zKV4KfQfQnpA1zeKkhkP7R65kILhO5s7twhJw88Qh2DhffsFNbe5SJDReoI
         iO/mPU2K1COPap39MEkiGDO3fRL6VGQaD0Noa3VoWnBq/rMZXV270bG2QNpll/3dIe3O
         AyponrlqKz0+Xf40n2FEbGKlWBqDJin42MQ2w6Xj9HGhTcOfWvpulnAaa854bSQTOhob
         hmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769067975; x=1769672775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9dKCUHIDcz6wnU/JJwI6d22joS1LJKYpB/XmCytXco=;
        b=kTzk+R+flefDHy4sf7/cMkIBQz+KXQmMvB/4C6uqH04aSbaM1gyROq76aoB52Px5jr
         b0TpXv8ZQk0AUAuskXqGY6A4gf1p+GirVrxqm++9OACuHXRvI44KNVrhlBG6+tBDI33Y
         qvGRjpREjO8Vl88dUyfFtnAUVWinEIfrjuNUyvY7vW5KCOhdXffIulW65LrjZ9YQXjE8
         3qxuR9Xhmt8247VPN4+R5kL9cTTgDLCFtyVdt41hV/Ue9SoEQgJ61Bl6SF5nVXPF8+l0
         18A/g1G5tKIR/FvJIhCBUNOY0YMbRk89JUXdoVQ+pYhG7YKUxbCPsYGdQp7JBF08Cwsg
         S3FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDgRwloO5w8r4aV5MusC+oj/MVRIMeS9fGKsBmnLaLzFkBXg8F1LiGC915hnC0zSDMv9GvJ4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBJrLZJEssGKsZ/nmYIO4glwmr190KWZY8lh21Gn26c3CI4Ash
	rsM9KIRe25QV6/rLGjUL0ljBgZ8M8bUnvmPAMPODeTDAY5hZExCa15mPdQqE1Fxqo7KYl2lRC7K
	XrW1ESJfrZxdqKypTup4eFH0fc35oWvm8hRSVNZwBwaglxVi3PsuCGFg4Y/OTrl3U+w==
X-Gm-Gg: AZuq6aLCIc6y8vu8e8gvx6FMPRC+NvR4IpW6X8bzl7re9bRXhDNvT23rsUGQEeAMRb5
	Zg5aGVwwCA3wIckAZr9su6Uv/XiP2mw9IYYhmWQGX3JemUSkojCzaPF1nD10IT3+qNSmgvQsB1W
	h1KzG0rCajEhBN6IFpCKWOA+TMUS7phBZ1c9lanqAzKNx4caEtBm3RNWqW0ghKSod+14w1pB3Ts
	ISXz+BzYx8s5qNduz/h9f5LhyYikO/w97B4mzXnx+8CZTqSWyevdColootRH2khurqdBks0yKmI
	5L+bEwlItEWBcAXJADNadwOZWsMhFLpHAGxBvSlNWaYeBH1F/U63ZYXZ10e80cEi/Iklow50Cy/
	V4oNqjHomVO8Y7wcgd9i45/K6CsWR+BNmN3uEawTomHs3H13DkcCIUPx84SI=
X-Received: by 2002:a05:600c:5291:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-4801e2eef8bmr250977495e9.3.1769067974926;
        Wed, 21 Jan 2026 23:46:14 -0800 (PST)
X-Received: by 2002:a05:600c:5291:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-4801e2eef8bmr250977175e9.3.1769067974509;
        Wed, 21 Jan 2026 23:46:14 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804702876asm50954025e9.1.2026.01.21.23.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 23:46:14 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: remove obsolete file entry in NETWORKING DRIVERS
Date: Thu, 22 Jan 2026 08:46:09 +0100
Message-ID: <20260122074609.151058-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit d8f87aa5fa0a ("net: remove HIPPI support and RoadRunner HIPPI
driver") removes the hippidevice header file, but misses that there is
still a file entry in MAINTAINERS referring to it.

Remove the obsolete file entry in NETWORKING DRIVERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a56f8f00aebb..350e7c64e12a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18275,7 +18275,6 @@ F:	include/linux/etherdevice.h
 F:	include/linux/ethtool_netlink.h
 F:	include/linux/fcdevice.h
 F:	include/linux/fddidevice.h
-F:	include/linux/hippidevice.h
 F:	include/linux/if_*
 F:	include/linux/inetdevice.h
 F:	include/linux/netdev*
-- 
2.52.0

