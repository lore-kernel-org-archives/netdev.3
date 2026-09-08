Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FA4545DBD
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872655; cv=none; b=tWOewKJxrXIzLDcOmwHJRGzBJfXd48NhzSOXbBDuZqLv7TADvUDInkqA03piugIU/Oi0XvkVJnMcKiqKgj1ACNi+qLkeyakeaiwS8m9/DpOrn9/GATC8o7Qr+2IxKD8RK8JtjRCqUQrG8tlM/uBKeBQXFFRtalcSVaijOzbFY+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872655; c=relaxed/simple;
	bh=2es4HxF/abUxtlRl5dW+lcYpAaZ0CFbVJ7S/IMs1s6I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rjyMSxi+MLtrTqr5SZZFvm2s1wwbSjPfW4c+sIXdLN7S/6zSyNQ+Yds+DRITdxb0N13PavHRk/0ZWSax9HJbmfVZgz2AejZquGcirCD650dgE9no2TArfcOoYOYofnCgDA7qNYzqjcg9lQghgOuq3zafmtFTrSk1hbZ9Ua+i6hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGgGu9rG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGgGu9rG"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8556ec44e9aso3884921b3a.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 06:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788872646; x=1789477446; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aode32HLzZqgIxPJF5MYdaNUCyCQFBptY8B/uClxA8Q=;
        b=EGgGu9rGpVOFFNFLCeAhnuGZpoLkiWUb4i9TlVNQEV/pR+PhlHaCGu/auXtMlF7Q9i
         VvQovNvWQ6R4Q0egzJsDSEAOTao/V3VzwuwHJhGDQNjp3cnk755MPzNxPUwLq+1LxAVe
         5oEVZgk1IGdRidFY/CSn1RM+pnSKdt8mWHvybggi5RVR25IgNZ4PB0JJxTyyb1X14FUK
         C6SdhaZ3vPDRCz90KEwo31xOR58pdSQGn99a9T+nvql2eOti4z6diK99oJc8OV6dFHYY
         rv7h3v+bAxrF3NYHFKbiP9c43HPs+tErAzoMauoYQ+akZkiJdFUrTYfbW/Htvo2ncaqj
         dkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788872646; x=1789477446;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aode32HLzZqgIxPJF5MYdaNUCyCQFBptY8B/uClxA8Q=;
        b=XAFqMUSlbVxi9DXD66sSGJ50ex2Z0tcQRXFBCsoo+gyFa8T5iwro+GJ2W96uxSOy5/
         uADYeZ+sUEvsWyEl3TIG7k+Qe1288IYfl+jyIukeduf/hTMt3B2WKoCl8hNTGib3gp1t
         6KuaojGD4H99ydEWzV9cpfGcLAcUGsuSheLZlhxDo0xuYH2+0LNgE8rSxqbdPu1ahsdA
         uXyBhrgDRv3UcvBchr2AjgCCnQ7tnksGkrUuBgQQ7UxczjXjDCqNyimsaTQcfPc/jRlu
         jBOnfItHYRwXafMzdd6xDMVoxzpPF4lb/84nhVUksyWpkLsH04QwLLOgwbwcCG9VTTkN
         GcJg==
X-Forwarded-Encrypted: i=1; AKwUvBzD8MdMrqXmK8gwm1HbZqmHjwawNzySE/RreS78AxHs6UJUvl2Ne5wbzJTGmAvyvO/m2b6crmE=@vger.kernel.org
X-Gm-Message-State: AFuF++nlC56xNBy09gph/zioBu5HqLSdh42OnxsijQKTT5fzuvrI8G5Z
	wLFNRrHOHGsLtnRBJq30QpYO2T8j/Qdz/QjMFg71pdaQBuaptOaDjfjU
X-Gm-Gg: AYBFou2SLuRJeFn3zxH/KAwtJY2MJLM6vuKoNRWPhBbT8JFxh93h44+EzuInTh2A8Ck
	FaYg3c5hh9MW9xRo2vjbTgvSzhDYXXMBV8VQrykD/0VNhSXBtLUYJPiQ1zEh5rCbIHG1/ZtRAjR
	jb88L1PeqPnC+oAe0JtNwAIhNKbOI56P6xn9vC/v33iAJkZ1u9SySvx3TddHDlFbYLzcD9L/G62
	xJFXYFjCAzhyayEGtr5dOwmm1SsF7dXKsuVaBPEZ2jjebfekuu7cJXelmn0koB7T2eIn0otJm/T
	e/KqeNxT9o7FXJaqaZydu18fONEcuCyaOgvBZSQ93y9gzeYllLH/FehbHXNuixcW1ijnaPADDQa
	2ztHbVtusxpEd7oBT66H198p/Gy/auC17eUJ0MP/t44glycH2f71tHdofJXZnJoPccZsrhRBliT
	bRbtCOjMzESdpp1CRvwtgXAQGCf9Qlu3xftG0Q+q4NVQ0+/Jsx5aY2EfOaJRZUdjmHFa2UQmxA7
	KH1rM71oNejYVvc4sN4A1KEghTArg==
X-Received: by 2002:a05:6a00:4c10:b0:857:72ba:ff0a with SMTP id d2e1a72fcca58-8616ae51d10mr46313242b3a.18.1788872644514;
        Tue, 08 Sep 2026 06:04:04 -0700 (PDT)
Received: from [10.10.15.228] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8614f874e9csm5652398b3a.8.2026.09.08.06.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:04:03 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v2 0/2] net: add USB CDC Ethernet NCSI support and fix
 unregister UAF
Date: Tue, 08 Sep 2026 21:01:30 +0800
Message-Id: <20260908-ncsi-over-usb-v2-0-92dd78272fbd@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACoHoGoC/3WNQQ6CMBBFr0Jm7Zi2kgKuvIdhAWWAMUJNBxoN4
 e4Crl2+5P33FxAKTALXZIFAkYX9uIE5JeD6auwIudkYjDJWFSrD0QmjjxRwlhovlOW2TW1uXQ7
 b5hWo5ffRu5c/lrl+kJv2yG70LJMPn+Mw6t37144aFdo6SxvTal1Yd+uGip9n5wco13X9AmOfs
 uy8AAAA
X-Change-ID: 20260907-ncsi-over-usb-3e786f4686c8
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Oliver Neukum <oliver@neukum.org>, 
 Samuel Mendoza-Jonas <sam@mendozajonas.com>, 
 Paul Fertser <fercerpav@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Potin Lai <potin.lai.pt@gmail.com>, linux-usb@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Mik Lin <Mik.Lin@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Adrian Ambrozewicz <aambrozewicz@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788872639; l=2709;
 i=potin.lai.pt@gmail.com; s=20260522; h=from:subject:message-id;
 bh=2es4HxF/abUxtlRl5dW+lcYpAaZ0CFbVJ7S/IMs1s6I=;
 b=E30+KtS1NVrrIl/Y4ZwvQTMyeUvW4cY37JQ2VbG6WbNTWTgWGrCu55Nmewj5a7rskRmpof2Px
 8f+/y5kn6HaBJHESOWnZUAdo0RylMv44FfrSjzliEI1xqC0bXD+xBU2
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=j3/nMxzz1ZPpp1revghyZ8IqOnwi6RWfuxXN2XrNMRE=

This series introduces NCSI (Network Controller Sideband Interface)
passthrough support for USB CDC Ethernet devices and fixes a
use-after-free race condition in the NCSI core unregistration path.

In DPU (Data Processing Unit) platforms such as the NVIDIA BlueField
series, the Baseboard Management Controller (BMC) communicates with the
host or DPU via a dedicated USB CDC Ethernet connection for out-of-band
management traffic.

Unlike traditional platform Ethernet devices where NCSI is initialized
statically at probe time, USB devices require dynamic lifecycle
management within ndo_open() and ndo_stop():

1. NCSI control packets share the USB data path, requiring the link
   carrier to remain enabled while the interface is up.
2. In USB drivers, usbnet_disconnect() invokes unregister_netdev()
   before unbind(). Performing NCSI registration in ndo_open() and
   cleanup in ndo_stop() ensures NCSI packet handlers are removed before
   netdevice teardown occurs.
3. Dynamic unregistration of NCSI devices revealed a race in the NCSI
   core: ncsi_unregister_dev() freed the ncsi_dev_priv structure while
   asynchronous request timers and workqueue items were still active.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v2:
- Rearrange cdc_ncsi_open() and cdc_ncsi_stop() to avoid forward
  declarations. 
- Use timer_delete_sync() instead of del_timer_sync() to fix build
  errors on newer kernels.
- Link to v1: https://patch.msgid.link/20260907-ncsi-over-usb-v1-0-6b74d2f1196c@gmail.com

To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Oliver Neukum <oliver@neukum.org>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>
To: Paul Fertser <fercerpav@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Cosmo Chou <cosmo.chou@quantatw.com>
Cc: Mike Hsieh <Mike_Hsieh@quantatw.com>
Cc: Mik Lin <Mik.Lin@quantatw.com>
Cc: Potin Lai <potin.lai@quantatw.com>

---
Adrian Ambrozewicz (2):
      net: usb: cdc_ether: add NCSI passthrough support
      net/ncsi: fix use-after-free in ncsi_unregister_dev()

 drivers/net/usb/Kconfig     |  20 +++++
 drivers/net/usb/cdc_ether.c | 187 +++++++++++++++++++++++++++++++++++++++++++-
 net/ncsi/ncsi-manage.c      |  19 +++++
 3 files changed, 225 insertions(+), 1 deletion(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260907-ncsi-over-usb-3e786f4686c8

Best regards,
--  
Potin Lai <potin.lai.pt@gmail.com>

