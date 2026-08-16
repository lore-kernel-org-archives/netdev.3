Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6E83D9DD2
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786864232; cv=none; b=KlewkpRXvQ8HwWbCZahdG7V5PUruGsnNNpzMsM8C6bIvjlyCx8xyY71epZlEpWw9POKo24novwPG5e86yJ72+7sAhWRLNJEA7c8+QuVnyD56KCKs+qSYmyPIqMvMC9a5SVqnbsHYIzoXDHgO0QaLc5TwYpKqamdOVktwN/sp7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786864232; c=relaxed/simple;
	bh=tXzsqjWYbT/DrBupcdNgjXO+pQcKgGFXWkOHwQDnMK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPKAukcUqAHnmz+bAIxQdoDR9FS4OMCCXH8vfZjAneahO9DcMRej1IjIxvjknTYaFob/IG0y+fA/TnktovvphSI3xgrv23hvbwOdS8Nc3w3YJhoFrayHdAzDONO1EyWnBsdUPdZ3tzBJjJN8YoRyav5QVVvd012dhZUmh/qS6uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OK1JgmWy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OK1JgmWy"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2caf228a910so18847245ad.2
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 00:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786864229; x=1787469029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U6xHaLkd1n/4+mC0EZEdafPnkO5n+dbx/Yy5btF/NQE=;
        b=OK1JgmWy82mUyCqhQyNXwFjBINrN+cPJsDbSoufab5b39aBV0CHpdjnwiGp5KLlyde
         4Sz3oQGGVN/9WR5BaGlfbW/blnTlJfFPxlwfCNPipVFWFpawcNPbMeWS9nYbojEFQcqg
         ZZrYKupwXeSxYJRQOw+yAp9bOakRdPa7V0g5bTSwb8z35AmsMlwu2TzR4MwmYUdn3DDA
         5/VffKDP/iis9c0zLvXSNWgp5rBttv7RFr3D61iniDpMll5P7DrDsyA2r+JHE4TVFS3C
         nVLqkNMAzg/2tY3hbiJXnuQVIX1b/GJ5z1rEpv5/eW8DDgfG4xJHqZCvUysHS9L+ExLf
         gVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786864229; x=1787469029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U6xHaLkd1n/4+mC0EZEdafPnkO5n+dbx/Yy5btF/NQE=;
        b=af1ZOonB/rOqybYzxXdW0yHHXF/jR9W0xoVRlI9OhP81egeQ+ElzOccoYKJLYmg3M4
         ZwamltR0VTwSskfSLgXMw2G/42Pv6b2iZtQa07lWb2Z4pgmK4FSRy7gK2wHYe1o2XI2s
         VjfMMjHIPizxOS5wxVeqOD9to9KQAZgJWivzGoQN8fd4mi5nlrtaExQTvt04FlJVGq2u
         kjqXYQLnJuUNwdHthwg5DDqGnDO4Pe8FRzmx0CCTdNAMtl996xNvCB76BldmfAawfzFT
         j9SNQ1ZkHhbAj1/G5j7eP9F+KpYjFMuuxJLmqevhOwP+Z3py5WhdyBvvqPpr1ZCfDm1v
         CkEw==
X-Forwarded-Encrypted: i=1; AHgh+RpW5MAJ0FfAkMac4AzG/s3P07qMvMykW9+GE9aNkMljlikncjgW063egJ5ZI5Iy5PCyX7tQihw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEjv5TLCFzXXZL/J+q9FfXGJ33egSgFnwK1v+kihtqNPEkWPPg
	8Wd4FS4fnl6PG6UfYIm7Dz0Mw7KAZmNO2Evq9gttz0bgG4z2EZr4K6Ma
X-Gm-Gg: AR+sD102xrVDpu3P4la2pzi2/IgTuXtQX6ZP8NresNUCJmmPPuyxd3O/g6ahPD7FU/f
	MEzdd3/w3AbZTMebiPHcFE1kB48yLkD8sqa0++Ad6CeuhGoXA97l2v4hZXl6+4LTsOrxaCQTW4V
	KihaCbwH2KjrP2MQadaK/VE6KhcuB39MdFaRh2oSWKwS4B+dGxjeT8j79o/BQvK+UBbvapwz7lK
	wWolaggh5qOAKf/Pu41psRqSrhXzFtutt9pYDgZtSWKGHCXHVUZBmS8i6hnuTykfhWoplH1CXpC
	8DIkAQpm9TFWd4Cm3jZZ1c3pRCiH0T4a3VWsgi9zL54ObQ+dsc9sFhWIHk0FVFdDUzaQ6b4R8rP
	uyKIhiWl3NiZgrKUKgL4AbOcDD/JSSkAkVH2ZmX4h5Fty4ojcYWiBR/9oDT1x0wxQ/MXr3MSEa9
	VeMtlNmZhAu8uVNPUR3G35ElL8hbfCfl5t9GQrBFz7BadW1qf04jwU0JlIxm+x5NM6yR8z/bbyY
	vASatrG2LWRBqBxth1G4+Gurrpa1Q+NZCxZPp5R54YRqrlYUMVR
X-Received: by 2002:a17:903:3244:b0:2c9:e69f:8b0f with SMTP id d9443c01a7336-2d3b0cad616mr189049975ad.17.1786864228597;
        Sun, 16 Aug 2026 00:10:28 -0700 (PDT)
Received: from Inspiron5409 ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aebf1ba7sm23643315ad.78.2026.08.16.00.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 00:10:26 -0700 (PDT)
From: Jianhui Xu <neuromoments@gmail.com>
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	neuromoments@gmail.com,
	pabeni@redhat.com
Subject: Re: [PATCH v7 0/14] ax88179_178a: Add support for AX88179A-based chips
Date: Sun, 16 Aug 2026 15:09:54 +0800
Message-ID: <20260816070954.3440027-1-neuromoments@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
References: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Birger, 

I tested v7 on the same ASIX AX88179B adapter. The 14 patches applied
cleanly to net-next commit df13c1df8147675470213ffff29dd5762fa321f5 and
built as 7.2.0-rc3-ax88179b-v7. Full and focused W=1 builds for phylink.o,
ax88179.o, and ax88796b.o completed without warnings or errors.

The main functional tests passed: cold DHCP at 1000baseT/Full, the
1000/100/10/1000 Mbit/s matrix, EEE and pause disable/restore, EEPROM read,
module reload, and QEMU USB detach/reattach. I also ran 30 additional
100baseT/Full -> 1000baseT/Full cycles; all points passed carrier,
negotiated speed, bound traffic, and RX-growth checks. Including the normal
matrix, all 31 tested 100baseT/Full points passed, so I did not reproduce
the v6 intermittent 100-Mbit carrier-without-RX issue.

However, suspend/resume with magic-packet wake failed reproducibly.
A deep-S3 cycle with `wol d` passed, but two independent fresh cycles with
`wol g` both resumed with the AX88179B interface stuck NO-CARRIER. Bound
traffic failed, neighbors remained unresolved, and RX did not increase
during immediate, 10-second, or 20-second checks.

In both failures, dmesg showed the USB reset followed by `Link is Down` and
`Link is Up - 1Gbps/Full` only about 11-13 ms apart, both before `PM:
suspend exit`. No later link event arrived after resume. By comparison, all
six retained v6 `wol g` trials passed, with Link Up occurring about 2.4-2.8
seconds after `PM: suspend exit`, when the link was actually usable.

I then tested a small ordering change in ax88179a_resume(): 

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 6b57111a0..dc101902b 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -215,14 +215,14 @@ static int ax88179a_resume(struct usb_interface *intf)
 	ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
 	msleep(250);
 
+	ax88179a_reset(dev);
+
 	if (netif_running(dev->net)) {
 		rtnl_lock();
 		phylink_resume(ax179_data->phylink);
 		rtnl_unlock();
 	}
 
-	ax88179a_reset(dev);
-
 	ax88179_set_pm_mode(dev, false);
 
 	return usbnet_resume(intf);

The modified v7 passed all the aforementioned tests, plus 13 additional
`wol g` deep-S3 cycles. Every cycle resumed at 1000baseT/Full and passed
immediate, 10-second, and 20-second traffic/RX checks. All 13 `wol g`
traces contained a usable Link Up 2.017-4.020 seconds after `PM: suspend
exit`.

I'm not an expert in the Linux networking subsystem, so I'd appreciate it
if you could take another look at whether this ordering is appropriate.

Thanks,
Jianhui
