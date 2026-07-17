Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0412FD69A
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276431; cv=none; b=NdrhY2cKYwkNmGocV7KKP5uoElUcSx6ea0JRH3c6Yy+nH2rjaryXvWNfV8y539+gmthnfUsRpb+tebjI6nDH3SPyZGWHT88V9HSoVRy6AH2GPCKop/OZ2WqNPOtDEV5ie1rzg+GpBWixXhNJW8ao2Wnnsq7798Tz+xjwF9h5Nes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276431; c=relaxed/simple;
	bh=VOKepwXUzpBs43yk+TP5zjmC2msaPZst9gKQ29gKTec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lqhx0eLSbAAXPW+WGw13JphqdWDhPbJGwUqYt+ThRU5rQhUMSVpP8uwhmIJByRz8DunnPJD13jr00oLxy2dCQSySkjQsDkjG7CekCdo+0EIvfjo793ymbzvK3FmK0Q4PAnlYVUcPVMZb6gmo11GlA1oNm/DAG2pdklrzXk1bXzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sytoo1Rx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sytoo1Rx"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so27432155e9.1
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 01:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784276428; x=1784881228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zh9dMs7FPMZu3bLxCKCV0O4+OVPJ7k1J6hpVCb5UyoM=;
        b=sytoo1RxZ+/N5UcQ1ME/rhx3gigmsz7nUtgwlbi5T7dwIONDC2/UIs59+yueS8b5zm
         thVVea5c3NvfgBGdH8MAqcSuuO1tIGJk+TQ2iSBx+nuVdefQhreLlPdPbNbliCWV2cIM
         JuGrvGifAq3q951sC/XpWmVma03/a5zqOhG7rzLqISX544W+EtphKG15nYZWHaImE/dC
         iXPecjpge46cGuR8gsbPlagxsAzksM6xO3/AjJz0y4/skPHG1vGTmbWL16i9KpcDRZYJ
         VrYSgedSAJCMa+yicP14tHyMLaFFY5t856ky9HFM/VxOoyDHp7t8Ae7eO2RFQp9UAHzR
         kemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784276428; x=1784881228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zh9dMs7FPMZu3bLxCKCV0O4+OVPJ7k1J6hpVCb5UyoM=;
        b=r6brJ+ShvfymXuj0Rr9ov702gMABQI8k90Swmd2AUpMzGP3ucCyxi1QSv0zP/XI3EQ
         /4pq2bjPxmpJ3BzQrW6d7LHC+d3sW1iHKpGGEkM3QGyCOdS6t+IASKkqkOf9ndrHdv7l
         lvVVNkvJDkVBI2f5jT8NfN1AotXvhfeloWrlWE4QTZwwiNz25tenFtNZFXttV90VoaBK
         WsnHPaEfsmiqmWKp+FvbGNx1ZUq0cSYaHkB9QpTssswfzyU6om1JaTI/L/7t3BScTEau
         S7VdOyu3giFLXsNTtoM13SAfHhJxnGIyEr6AHk0rwzS4tbAOmgCuGed5dwq3DIm5tLkZ
         OYeA==
X-Gm-Message-State: AOJu0YxrxVChVXtRiNsPnonI0UTt/GrpCz5OoiV/MABYGTLORqd33XEa
	0ypa4FPhdW5cRavE2Qm1+pkcqdsDdHCFPvvAmpbfaTUtC338I/SnCpEZ
X-Gm-Gg: AfdE7ckwD1E8Y7caMKomiD1RaKyRJSZC/MOcmLO76O4udj4X3DShRWuHBRre1hwclGJ
	dInOPf90I8Yt5Gp1+lmwKjmx6KMUSuyiYDi2PbTlFeM1Qr6tBahL6CatPAQ+cXIMYWTQjkLWdza
	RaCY/FUwS2JXlJqEW9NCJtbW6g6qCceLGKVXj0nu6020Pq4VB6eAJlF6WWK1R0PnU7ZVysp/ksf
	uaKhr7F57OweevTXlfR5Yt4FELLH+KGrch6LOYoi4dHkpDBWFSYMzlDTVX8mf4R+rYZaLAn9xmA
	8o4MN12I/JslSBIDKuu4RtqbnOr458gwllB8QlDMMbnTgxYPfE5+uqDhRmISPR4NkY+SI+dw3LD
	f3UCrwsnHAXE5RMBYteaQ/nkoe4yXeZqk7PIGGXw9cM82tw6lyJfC1elTSrY6QJqd6ulmvCI4+7
	G1WgSJXbiF0lEl94NstsLQbw==
X-Received: by 2002:a05:600c:154e:b0:495:49eb:1ccc with SMTP id 5b1f17b1804b1-4954a3eff56mr18315945e9.13.1784276427420;
        Fri, 17 Jul 2026 01:20:27 -0700 (PDT)
Received: from labdl-itc-sw10.tmt.telital.com ([2a01:7d0:4800:7:c817:c1b7:3e78:551a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e499c2sm1671314f8f.4.2026.07.17.01.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 01:20:26 -0700 (PDT)
From: Daniele Palmas <dnlplm@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH net-next 0/2] Improve wwan qcdm compatibility with user-space tools
Date: Fri, 17 Jul 2026 10:19:33 +0200
Message-ID: <20260717081935.2071083-1-dnlplm@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Historically, Qualcomm diagnostic port was a serial device, so user-space
tools were developed using tty specific features. One of the most common
tool is, for example, ModemManager libqcdm, available at
https://gitlab.freedesktop.org/mobile-broadband/ModemManager
which requires tcgetattr/tcsetattr and the possibility to get exclusive
device access to properly work.

The wwan qcdm is not really a tty device, but, besides the lack of tty
functions, it behaves as a standard serial Qualcomm diagnostic port, so,
as c230035c2f2f ("net: wwan: core: implement terminal ioctls for AT port"),
this series add support for terminal ioctls also for qcdm ports and
implement the exclusive open mode feature to improve compatibility with
user-space tools.

This is an incremental change which should not affect the existing tools
using wwan which do not rely on the implemented features.

Daniele Palmas (2):
  net: wwan: add minimalistic IOCTls support also to QCDM port
  net: wwan: add exclusive open mode capability to AT and QCDM ports

 drivers/net/wwan/wwan_core.c | 40 ++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

-- 
2.43.0

