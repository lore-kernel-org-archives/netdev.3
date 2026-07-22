Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3169384CF2
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711415; cv=none; b=jrZ3wwizovgFsi3I6ZPTxgtnO+9RQmq4W3LFF4voN0GjfVNKuWUtYvYIEWD2DBi3uuk3e/Q+h8AM5OXcAbBVvft64tTXFpGpur4Z4gpGF/WSEhVew/7WZS39CRQKEDWkzEU6LcL/aNeeHcrZaTmjZtRu1JPxCeHtKhbH1/Hyagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711415; c=relaxed/simple;
	bh=VDX1or7d5n+pC0Z7BtJoMWFV5PGuA5s9AxVgdfs44Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d+FafohbpdenZs6paXc9nsQDuzXeU/TAAkFd/cnIc6f/DTZcdX8LnBQFpuYc+4Ge/EW+3WpuQ6sDT4t6Xw98OBN8zRQBN6KKimTIAxEDtKdmwuf+I3IJtLtYATcBsF5DwnHujgIHf5vuvOThHuOO/egD5lbjqG1rNqGrAmEHsvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqISsoW9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqISsoW9"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47df43bfb07so3361732f8f.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 02:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784711412; x=1785316212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lHqggJKzKEILovBIsx+lUUUntRLB1QIN1a5WzfcZZL8=;
        b=bqISsoW9s7VHAvmhr6dcodnd10T3e+kyuVo9AnwbSf3u8MKLWjvr+15ilp1CzdDRlq
         WIyq3yca4qu+Zb5zP1ebust3u79Ebr0oiBUVr2X23+tYXGe6VJCZGM6esrbtvovmE8bS
         8qU9B0Qpw2eu39z01ALX7WQzIXlxalqX/Bdgzg7ocFvBfHIM9zzkMSIW/R9paucorvB2
         zO0hyFUwmSYoOrkaM5kVr4OO/0yw1GxUsR6P/QcgrjYfZ7AK3X7NnhkucpnzSyXe0gRA
         OMJ4zHsLjfkM+lVJal1Fg30eYMBFNcl7tOkzHr13r19gxK5I9bV0xlEm4N5OkYJvyigy
         JS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784711412; x=1785316212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lHqggJKzKEILovBIsx+lUUUntRLB1QIN1a5WzfcZZL8=;
        b=UwL9fammhBanOjFFTXb8YYFSYXH4Wx2Mh/fP1SfVYweVh+SvxCqmx8j6enUo60Rfzw
         DazFkbEDzZIcU49sHgwF3R4n62PC6HMJSuyMNGsFroKz6sw/vMXpCqMSLSW7DVeHfUUR
         RRvhEZl8FC8PyQBY3WSKkWt16X/8qbDB8/wSI8RWbjQSg1uzG9+tKvV6GjrR6MWu64FI
         dWW25A+WRMGhHQSzoOJKj/eFaWOZn6CuzzwWDcuHBds+0Xgh3xNdHL63dSCYUzG4KIzW
         ZC23NOsWbaKGEv83HSTghZAI+ooc5OOC3GVsXxk2M7va7+z4d6m8M2/KbMJXPcVU8Jn0
         ROaA==
X-Gm-Message-State: AOJu0YyEZORfISRLwb547fBe6iwlY81mgApZGXXYhXDoMN96ZGIMr7Az
	s5jGDKSOHmfARBHUL2WICOvA4MzL9YCHsfBDNn2dZCjwc8EBtszNWJY6
X-Gm-Gg: AR+sD10L9B5Y6fsInqEFleBK6rBKSp3UTL4gvOhUNNcdAEyLw+mq4XkYTM5cRVmo/uc
	pDrqWNRx88kpJvcfzG9R6E1YmUHeUWK2R9KN1F860H+0UWYaNn4beNOgz46cGmsjc1F3qUBwxiK
	1pwBHtYyXUvg5ZETJIzvK5RvSQJ1gx4Dc/Z0BmVh4k60zT/cjJhOKcN2SzmRveK+howf0oqYjQW
	G4yMGoBoWp7xlyQyZGVU013CwVZcgUXSR3XYMCAGqTAD6wzkqACoiOmmZt+B4aO6+hQzQExKl0P
	PYtfBdhyVkVsfTiUtHoIMOIp9CZcKbaatHS3OHS/oGoHDW7ReXVreh0LANN8+CzxupOol8JqCzw
	6DkNxTP477Mc/PLz4qHUdWgnJcqJlRKMcJIGyzjVmECdRq2L89VFcoJREg+CrTus1oijy9v93Rn
	dOfjXS0vc92iBJaLgYi/2yWA==
X-Received: by 2002:a5d:64e3:0:b0:47f:70f3:451d with SMTP id ffacd0b85a97d-47f70f3455cmr18765843f8f.8.1784711411445;
        Wed, 22 Jul 2026 02:10:11 -0700 (PDT)
Received: from labdl-itc-sw10.tmt.telital.com ([2a01:7d0:4800:7:bc9c:3808:e25e:32ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb5a46sm4406792f8f.9.2026.07.22.02.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:10:10 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/2] Improve wwan qcdm compatibility with user-space tools
Date: Wed, 22 Jul 2026 11:04:49 +0200
Message-ID: <20260722090931.2637025-1-dnlplm@gmail.com>
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

V2: fixed race condition highlighted by Sashiko at
https://sashiko.dev/#/patchset/20260717081935.2071083-1-dnlplm%40gmail.com

Daniele Palmas (2):
  net: wwan: add minimalistic IOCTls support also to QCDM port
  net: wwan: add exclusive open mode capability to AT and QCDM ports

 drivers/net/wwan/wwan_core.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

-- 
2.43.0

