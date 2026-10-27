Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084510;
	b=dK0RbAnnzadL5MEy2jPnxFGi4qnZ2AtI90grwdA7yIuT6BmdBfQxHH09EiVYbS4lEY4v
	 Z7oHqO12Z3PXQ46Psu1MziMaOx/1/ZudTVO+X+z8zZusuBxtvw2WyI/8D3Ae8bt6JDO4n
	 dx5uKkEBuyNORhauVhMKJe5SwMadglU742Gp1kCFOlG3xlycSOKRdbN4D/LRK/Emmjyx0
	 Jufh508+Bsy0i4gqA9DSPtYf7CH5UGmBNbO7kf1V+mfykzsbK0w7CG8kHO86uYC4+g/Bs
	 0e6nL33SUSMUUUFk6LFvUqnnEONYdDSI0lN1Mq2TMTB1C/e+X+TaiPej4gvCvyr6MFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084510;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4/uN1Zp2J/k/3SLIBOCDwzRSoBK60Gc0psw5pmXaNiM=;
	b=LxdBYmHyirS3Dr6RWRWlPjYea+pEhaxWCyue4z767uCsDVs1lVl6IIECQrCsp1P+DqgS
	 3umQTYLP2CAOYkZTRktEf6BJtpjPGRQuuMV7d03VK1y5G479oBZLwzE1AuVxi6dfdp9+c
	 wL499ifToVxHm0HmsJUKc6HgIsVCQ7VblwRCd8HaMXZC9ViDlZMuL65nUFWoXySmgQmOM
	 kHjOfXfBZ7IHqW7loN/OYTUpG3+5kR9oG0jO0TlShAOVzz/Xiw6cGOKxhmlcussfdgOuh
	 D950TvLyrKIZD8CdUe5GR/OBgQViKrfTWAt16pUUWpuox8669ejVgApygwEw881bg/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=XSZez1WK;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8931A606A32A;
	Tue, 27 Oct 2026 07:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8931A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=XSZez1WK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=XSZez1WK6xpj/BdbouJwFcPWPQkOxJKlaSkjGZaEpph50eorQGU5+6P6z26yWcVgSZgPldry777ue
	 5hhBvQnz4SFLNwIY/Shcfl9TzHSX1Lze9wIshL2+BBlP71oZZQbcv4YGFAsmFkLppTi3l2fl10BaHh
	 8rVEl9LdJua9J5dc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86ae04c52739-f4d96;
	Tue, 27 Oct 2026 15:01:38 +0800 (CST)
X-RM-TRANSID:2ee86ae04c52739-f4d96
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66ae04c509fb-d0e51;
	Tue, 27 Oct 2026 15:01:38 +0800 (CST)
X-RM-TRANSID:2ee66ae04c509fb-d0e51
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: krzysztof.kozlowski@linaro.org,
	linux-kernel@vger.kernel.org,
	syzbot+1c5368988052dc2d8201@syzkaller.appspotmail.com,
	Zhao Feng <zhaofeng2@cmss.chinamobile.com>
Subject: [PATCH v2 0/2] nfc: pn533: fix hung task on stalled USB send
Date: Tue, 27 Oct 2026 15:01:33 +0800
Message-ID: <20261027070136.1339-1-zhaofeng2@cmss.chinamobile.com>
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

The out URB wait in pn533_usb_send_frame() is unbounded, so a device
that never completes the transfer hangs the task holding the command
lock (syzbot report).  Simply adding a timeout is not enough, because
the error path of pn533_wq_cmd() cannot deal with a send failure: it
drops the queued command without completing it, leaving synchronous
callers asleep forever and the command queue frozen.

Patch 1 fixes that pre-existing error path; patch 2 then adds the
actual send timeout, handling the race where the transfer completes
right between the timeout expiring and the URB being killed.

Issues pointed out by the Sashiko AI review of v1.

Link to v1: https://lore.kernel.org/netdev/20261023025602.1746-1-zhaofeng2@cmss.chinamobile.com/

Zhao Feng (2):
  nfc: pn533: complete failed queued commands and keep queue moving
  nfc: pn533: add timeout to USB frame send completion wait

 drivers/nfc/pn533/pn533.c |  8 +++++++-
 drivers/nfc/pn533/usb.c   | 20 ++++++++++++++++----
 2 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.39.2



