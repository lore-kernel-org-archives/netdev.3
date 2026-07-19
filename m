Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED9821FF2E
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784465772; cv=none; b=ZPt+2TkQDszlL3pAhnwcwScO/xFnc6huCBIqzkfuV4aKU2SufRlaWe/mK+zvRzS9IJz02rZGdhRx7/lJFwH6fBS89YbEz4DdO+Fzxb+jmQFw4HXUJ/tE7PNvT3WUQiCrDCLb/zQlnXU1ThL34BLNK0HrJHfSDSsGeBX1dU8B8VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784465772; c=relaxed/simple;
	bh=tbFY6fp4UldEdOFPWG5qshyGEZr0Xdq96AYMiaJs3fE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pDYp8wWpnhZ4mW2ROtCRRhIpMvf7xGdeSsSMqp8cwmZukYyVDkLzQWG7mwMIw2q0DL47fIbWe+9DYn6MbqWGW1K90C4JeUHsRerQjDa/b8waAIw+7RrjezlEVXBfywcJEdt/agYRzIdwg2kf14IhL9tMDz9YIbL4TNaExWecAX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtHDaHI7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtHDaHI7"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so83658555ad.1
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 05:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784465771; x=1785070571; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qmjtXqSGZiTIHq+gVdls9f/1oloIjlpItQ0r6NzmJqw=;
        b=WtHDaHI7id7Ol8OBwU8ZDSPcf3M2AOR6kkM1dVJlOSe7KXqLSOr++pRK3MhhjHwzU2
         wSTi7tdDmjtHMq4KkCXt073MDesghm+mFL2YkGFjYkK8F/z2OzV2/oqxWKkb4CInHQRB
         BlLIzRm0E54a7Q2K3WTiFg8Y/moaeVFNtG5z9WX2MMOzTSgEjUCd6KFICAOAYB9shFho
         mZw8RPnKcwPzliTQbwNnTAaSlvG2Wl1Darwh1NrKs56/a2y4DnSSJJGnCUSHFSnvMN3W
         3onfcyscIemqC9QqcO/CIVzBT7ZuDQGNwoRo3CehcXqEXPLPfPgN1UmMexwITuqicT34
         vkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784465771; x=1785070571;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qmjtXqSGZiTIHq+gVdls9f/1oloIjlpItQ0r6NzmJqw=;
        b=TShhsgs28v75BFpu3jvXDFVgD0jmEYZC482M+MfjIUNQ2G5xXj21wUaP6u219CJuIL
         lZPFpw63E5n23CnyHOjGd5NIjRU6meV52AhWCEPT/aHJYDLUnuhgm7TW6lBGj4udN+f2
         IVEKKfMKgDGtuAkqFEyX9OBeJDTMpjHklbH/rjlQoEtJadlBaymuwu2CH0GTV9d+8K95
         matnLQYiiSw9G9Fmnq3ixQW5qVblzllF6MhKxGVi1Ae1+tLR4wov10s2K+CFnjukx+Hm
         AMetkGo0yt2NowS5lNemMX98VyWkioUP20B2rZNYejI3xvlz+x7bAev796iro3wMbT+b
         +Trg==
X-Forwarded-Encrypted: i=1; AHgh+Roxis2fSaxdW198kPpA6CBSYCA26Ta+FTyTO14KLBIO4HiemR8IA56DqWU8tLSXqmw8c4FKNJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcQnD/Tt0MmqLhF9kWJP7PePYilSMLHTbjE1R4qV4uh0Gt4E2f
	SpATtuqEm92FXqC/wrYvDZmrO9ToET5WlkDdyg4/gCvGRyI3mw47/lR5
X-Gm-Gg: AfdE7cneafHswqLFZ1ezSaHqsEeFRct+Dq7gybEHPBo8d/xI1cLZ4WsCMRtl67wGtdE
	ZK22Zd1a0dbO6hQUWaK8HCXGJ9BzRfLi1ngZNHY1RO9tgn/CMUvAGGk6wJyw+hNTdO4NSSQDIDa
	M+VNcKZPols4tlPsPNRzp0RLYmWIwCpv7UQ+JaSh7HiT0occUYrFUuidf6LAk+VWBFYSOFGS8Al
	u6+/SgKhVbR6bVDc+6qEFcyZsh+mFi5T+wzgK8tXcQrHGzHTPNL6l5iBZam9PpbGw7UL3OHxcnD
	SKiu3c+qDai9s43hfsV5b5tZtv8xOPjPa/gIzmhqZjz+t2rM1d2W0r8Olq1rLVE1OGomVSdK7np
	1waMEGpwc7OOyfZ970IcODqsQQWGPj85507r6qJKyrs7F/bInQbY1l+556fioyuvoZmIUp9wXbf
	Md5ek=
X-Received: by 2002:a17:902:da81:b0:2cc:7e4a:bcc5 with SMTP id d9443c01a7336-2cf34a48064mr112928635ad.32.1784465771134;
        Sun, 19 Jul 2026 05:56:11 -0700 (PDT)
Received: from [127.0.1.1] ([2404:f801:8028:1:edd:423c:25d9:f95a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb6e8sm20990052c88.9.2026.07.19.05.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 05:56:10 -0700 (PDT)
From: Subasri S <subasris1210@gmail.com>
Subject: [PATCH 0/3] usb: Use %pe to print error pointers
Date: Sun, 19 Jul 2026 18:25:45 +0530
Message-Id: <20260719-usb-ptr_err_patchset-v1-0-85f7f2e4fefb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFHJXGoC/x3MQQqEMBAF0atIrw0YGY14FRGJ8c/YGw3dUQTx7
 hNcvkXVTQphKPXFTYKTlfctw5YFhdVvPxhesqmu6rZytjOHziYmmSAyRZ/CqkjGhWaxzcfNgKO
 cRsGXr3c7jM/zB/dGg0dmAAAA
To: Peter Chen <peter.chen@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Duncan Sands <duncan.sands@free.fr>, 
 Chas Williams <3chas3@gmail.com>, Minas Harutyunyan <hminas@synopsys.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Badhri Jagan Sridharan <badhri@google.com>
Cc: linux-usb@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
 Subasri S <subasris1210@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784465765; l=1535;
 i=subasris1210@gmail.com; s=20260709; h=from:subject:message-id;
 bh=tbFY6fp4UldEdOFPWG5qshyGEZr0Xdq96AYMiaJs3fE=;
 b=AKmLrPfrqg8Co2eNp1+tUZNc8ZaIcc3Pvtn1ics7ne1WDLCCZGIYXPUI1ATsLWt53k64N9Qzg
 WbSIB/hP1e3CcRt9EbIhunGN2mAKRvXXd16B7GHliBKtoD87uKcy6tp
X-Developer-Key: i=subasris1210@gmail.com; a=ed25519;
 pk=6C4wavGFy/OsR8yQQKNWuDXoYPHp2L3sfgNfyzTruTk=

This patchset replaces PTR_ERR() in format strings with 
%pe format specifier across the USB subsystem. %pe prints 
symbolic error names (e.g., -ENOMEM) instead of 
raw numbers (e.g., -12), making error logs more readable. 
These patches fix coccinelle reported warning: "Consider 
using %pe to print PTR_ERR()" in usb subsystem.

The patches are grouped by subsystem:
  1/3 - chipidea
  2/3 - miscellaneous USB drivers
  3/3 - typec

All patches are compile-tested on x86_64. Please let me know if 
any more testing is needed for any patch. 

Signed-off-by: Subasri S <subasris1210@gmail.com>
---
Subasri S (3):
      usb: chipidea: Use %pe to print error pointers
      usb: misc: Use %pe to print error pointers
      usb: typec: Use %pe to print error pointers

 drivers/usb/atm/usbatm.c               |  4 ++--
 drivers/usb/chipidea/ci_hdrc_imx.c     | 12 ++++++------
 drivers/usb/chipidea/core.c            |  4 ++--
 drivers/usb/core/hub.c                 |  4 ++--
 drivers/usb/dwc2/pci.c                 |  4 ++--
 drivers/usb/gadget/function/u_serial.c |  4 ++--
 drivers/usb/misc/usb3503.c             |  4 ++--
 drivers/usb/typec/mux/pi3usb30532.c    |  8 ++++----
 drivers/usb/typec/tcpm/tcpm.c          |  2 +-
 drivers/usb/typec/wusb3801.c           |  4 ++--
 10 files changed, 25 insertions(+), 25 deletions(-)
---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260718-usb-ptr_err_patchset-7c5d1547bee7

Best regards,
-- 
Subasri S <subasris1210@gmail.com>

