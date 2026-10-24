Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792883195;
	b=LXl+cS+CCoVYnrTpCaiid+tk7575rlIMXXP0ZK2nQMDAEC3PSJWRkKrw0kKa2UyGwdY1
	 OrfqydeBicghNSQOIA7IpQUsNH5JY8Rjnpgm7Y/jH2P8mcMwxMg78leQKfzvWIURZ6Rrr
	 ccgJ3+4sceeF+wWDzBzi6rsN95WQVFH7xz+C9aDX3OOdnBDSTdGUZUkKnaDCRAytK4CPt
	 NMDyIh8/ZlSzkMcsh7LUcAJa5VXiVESRVwivRqBUec6Oktzqc2LqEthJhUi4LbSXQAmIK
	 BJhrjw/Tw+kkMOeCJbTQ/IRZvt7+xfAD6OXF+aBofMlIjBLpIf9bSBGhojSGXh4bzDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792883195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=l5X1zhTt/mo79FT/cl05olacIHJU1uD7Qt4zdE13cqI=;
	b=1WUlOsR0oY4HY56UMz+ipq1u3Bb9Ckg/wUlF24HDnXW7PdbHly22AydNi0QF4oNGYxzu
	 4xSP02gAkvU4GgRLHaUSQvkvnLvmY03fVNaAfHEM9D0zh7vfxN3YeREaL5PdgsCknE7Ga
	 S5lM0bLIwaRJsN8QcjcxJzYzpcpSMe1DxeMi3uWszaBzPEbKuQtD10xTQviFOhmP/CnFU
	 NCSBrr036bPeLccAjIl8+entvAC1tvnHUddt59rMqrkBmKiYyESbxIM6I7ppZFHjq9lZA
	 0zDOZTHbj0gLGjnq6x2qBxF+TrM2KcEIASUyB0d15+V1fMVxxbJlNM1sLsc3gtgOv9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="a/qIsEoI";
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C37606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 23:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61C37606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a/qIsEoI
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c423b145922so255480766b.3
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792883194; x=1793487994; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l5X1zhTt/mo79FT/cl05olacIHJU1uD7Qt4zdE13cqI=;
        b=a/qIsEoIJ7JXd7dDRfKIL8boCPjx4/MXqK1bE26QZaFCzqI+Rdxqpp5jXFOSzVoolc
         v1zInRtKr9gTdubOUayPsUa8EJEENGSfm/QJ658WblAxdzVHz6IR5+Y/xMIUovw8LP32
         2N33OQaEcr9CODQSkmjNa0MU4vKwhesNS056Iw/GDxNcsoD06HhJ0ndiqAbchNfbgEzz
         keKwlOTRZaEyIU2PbyOxEsaZu52y+vk1YK1OdzGEc+Vj/NR5KxnLiO95355/5QjEjKWv
         c/9nz4/uF5GK1Ie5KxMEiNnVeo6hqhl+vaFTq94nAKXAjgkol8yoHxfUJpRw9P8y5Isb
         OH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792883194; x=1793487994;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l5X1zhTt/mo79FT/cl05olacIHJU1uD7Qt4zdE13cqI=;
        b=DQLE8Mts1uNYnGQ/Sb6XH1GFJ32n7vlZ0slk3g3iErxiTo5fYtzTdjluri+0M3oJVx
         9Ja4fcc7kRbhs/sASVRYhcRcxbMYX9urGjvpmSFRTGCerx3lw9Pfl1NdueMbRSQS4VLO
         mRtnWbPT9IG27fKb+Z+ehPKz7S9gk9rPWkcShTigv5H1W2n8xuO5mnEeIvr0v77i2Bry
         7n5AZsccajRZtf9LqtmK1bv2JFldh0MnP5PjslE7g33W9JYSGDHVnvhM6hdo3kr0gDX1
         O2I8Diy10f3BF69r4xpCH1Up7q/jHbmJtBsOPk4WVS8j3baoFZ6YO9UqsKJhZxG71oU7
         Vw/g==
X-Forwarded-Encrypted: i=1; AKwUvBxkvODzlEa4pVkPUc1MlLEBA9UHpuThsyXA7jl6jf0GUkZRLsTlxwjrUfGSBvfGzesYyTGJEQ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKG+IJRCR2AsUiWQrpRvcK9nx2GtcUZb88DzqepVF6fkz23dO7k
	HJ9BfIUyoqK5+Dy1ucnwPQ7cQdZZYr1yJI4q1YtKIwwvcbUK2KpzltYb
X-Gm-Gg: AYBFou3E+Wt6sQsizNKjfZvK+wOv6R49kKlslGTBvbIXORTqv0/PSAkd7lURSsdkJ3n
	+Q0DFU2TpwQJ7Da73mBaM4VWm0XXji0Lz2MpiBIhzsiBcLapZ9i0XQf+Q05JIN/Y2q9Y5OipUJe
	QTA/wweubL1BwAlK4wtyT5gVIz720HKkJpiZLyiHefye1/Tytv7/O5G/G2Qb8WlCz/MyjxC82eE
	5y+hE/8aGBMYBe+K43jMzRiCSpgjirXssvb6QxmxL9tSM5Bk6VfWrfv1ismpM3wkTM+S9yvYZLT
	Rx6GS02dZtm2aDRBaf7kCHPNVr3BA39jxvM/ebhRT8PkUC+onyWklYIXNScuRbUgKJx1xtSwVDX
	woKk+2VilxPiVst3ZzLGgtN4teIQd3P3C+riBa0cVnio7zqTTNwzQw9YkMchWTvWknyWTsmGr7g
	f+s1MvPLOip0dlto+Rd2+mhkOBZ2ws7RD2K7YzEJ5bGZPc2roLA+LHvOC2ua5Z6n+mLxCZPj9tV
	tEk7nhcrtqZlNBC1xKmRhY/SsLLFdH+HHRbSf1hAlezyYDujKXvu2Y=
X-Received: by 2002:a17:907:160b:b0:c25:afb6:2d91 with SMTP id a640c23a62f3a-c46bdaa7283mr360392266b.2.1792883193723;
        Sat, 24 Oct 2026 16:06:33 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd650890sm141551566b.51.2026.10.24.16.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 16:06:33 -0700 (PDT)
From: Sam Crossley <samuelcrossley@gmail.com>
Subject: [PATCH RFC 0/2] netconsole: allow replaying the printk buffer on
 demand
Date: Sat, 24 Oct 2026 16:06:02 -0700
Message-Id: <20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANo53WoC/3WNsQqDMBQAfyW82ZRErdZMhUI/oGtxiPGpKZpIE
 qUi/nvRdu16HHcreHQaPQiygsNZe20NCMIjAqqTpkWqaxAEYhZnrIgzajAoazx1OPZyodPog0M
 5UH4pEBWrUpUXEBEYHTb6fZSf8LjfoPxCP1UvVGFv7lqnfbBuOf4zP+TfKv+7mjllFLNzzRKsk
 7Rh13aQuj8pO0C5bdsHENRCZ9UAAAA=
X-Change-ID: 20260926-netcons-replay-upstream-189eec0b4c79
To: Thomas Gleixner <tglx@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Paolo Abeni <pabeni@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Sam Crossley <samuelcrossley@gmail.com>
X-Mailer: b4 0.16-dev

leitao and tglx had discussed this at LPC, sending RFC as suggested
by Breno Leitao.

Netconsole only forwards records while an enabled target and its
transport are available. A target enabled after boot, or one that was
unreachable during a network outage, leaves a gap in the remote log that
cannot currently be recovered.

This adds a write-only "replay" attribute to the netconsole configfs
subsystem that rewinds the netconsole consoles so the retained ring is
re-sent. Patch 1 adds the printk helper; patch 2 is its only caller.

The replay is best effort. console_try_replay() uses console_trylock(),
so unrelated console activity can silently skip the replay.

Testing: verified in a VM and on a physical host (the latter rebased on
a 7.1 kernel) that records emitted before any target was enabled are
re-sent on trigger.

---
Sam Crossley (2):
      printk: add per-console replay helper
      netconsole: add configfs trigger to replay printk buffer

 Documentation/networking/netconsole.rst | 14 ++++++-
 drivers/net/netconsole.c                | 25 ++++++++++++
 include/linux/printk.h                  |  6 +++
 kernel/printk/printk.c                  | 67 ++++++++++++++++++++++++---------
 4 files changed, 94 insertions(+), 18 deletions(-)
---
base-commit: 00513fc3d6c467b1ef3c101a2943cb92de25c49a
change-id: 20260926-netcons-replay-upstream-189eec0b4c79

Best regards,
--  
Sam Crossley <samuelcrossley@gmail.com>

