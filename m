Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AB226ED3D
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131097; cv=none; b=P+yAcGJNDFeirdSyuu0/jNuF6aI4UG2SBkofw4JL/wYWxe5Kt/NdJMYj9yh7XQ0MZ/0ts+Abw81gmF1J/VbNkJ4Qpwh7cdUSNoRmlMX5vv977+eF5GNjJhNp3BM/fPHtTxoxtIZzjwu+QDjjadTE1PcSo5XZwo+PdhJwspexAXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131097; c=relaxed/simple;
	bh=6J1j99RkGgHd7qnYJJuahkEuuMeFF8fLW/57SAMBioY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqQ4XxJ7M2xYXtLAGlSnwyqHKpzZYzMQplSgkx4SOJCSdYpNFTKViiD4IQedAwOUj3hqBhfbtBxX59x6XROq1v0N8PTb+cc1VvYhAfQZxxRvxphMrsXhPsek2nZl3Kh+0EvXgs4f3oCoE/zuwKQFup/+I75CXfajWFbXiA3Jfyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxK1gOx3; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxK1gOx3"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3282db206d3so1719485eec.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131096; x=1792735896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qWf8bZZYyS9ZR2mGM/elWEcGt1jLdPTo6uVsODf8oOg=;
        b=jxK1gOx3cqnle8IoFxB2w69TaBKR0aYow0y6D/miyy95ZiVmylgNTd30yJyObAIjy2
         lO6QAfVB/cHGRI1ABXReGFrfD3kE4prnrb0R7n50vxiR8y9s3AKzI9TcpUgt1oXqf1+w
         4expdPGqy94uLtBPuosLgTq6BVe0nSly1L6PRRbSvi0vMo3DWFC8esvlh2jpgboDZNGZ
         3TmFCqXngfUZ9RigvbgiHf5eZQ4FynMaFaE+6oFHY0FUnoHFkJEtoguaaAPacrYt8d0T
         59sbH+dJXOIrzaEKwAigEtvs4Jt6VjAo26FwRQo1SY9K/SlasFOZRjghf/ZW9OOyLurN
         vwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131096; x=1792735896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qWf8bZZYyS9ZR2mGM/elWEcGt1jLdPTo6uVsODf8oOg=;
        b=2rrPP5jY+tQ8v8mqNXttexABzr3KtEr1Xn2S0uI9E9YKyJv5kL6yDZa7rd1GmUErqh
         iCt5cjeKnOVNDbs4NVtMbLZg0K2UlpTCQhWyANtMZhNp3UPP0P4c91s963yTN7cwnz2K
         t4pzfNwbhQtrjSvf1WqyCU2DJ/1JiyCPPAqM7A05Sdz/TV5yk5zx0vAkdr9dHbeQIBfQ
         u0ESGqFGv1w7bcvGk6fKEbMAvXxBPOc8DMM1i+5WrcJ8t8BSUv5YPFKg2PoVfocmBRS4
         FRJA6qJdIfJyXe125mRbd8WitAyULtf6XT4Iks2jVdmW5WbQrz9WpcXMyryip6/RCmu7
         UJqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjfsGgc8lXlRZgr91K7h3hiYd8qpo3OkNMUJ/FFZA+9vqhGyzGGddMGP7ANGLZnge7+FNXFI0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpw4fQIXeOz8nruVMiGJsce7M0pUtvH9O4bM2nWoX1G7lCSX/B
	KYFKLJnHOU39YOa5WQoCGt2/2GZHahK6HbCDhlqHzkwkkYjqquNJmwdeRqINGqtv
X-Gm-Gg: AYBFou2IqtGw5NGu0y8np8p941Wf9KxgpkJN/NQWrLwXfUczpZUqbGPPCYC46QjM8em
	ajGXNSCdi/bWvbR0wEUDENFCWpWQLK7MWYB3cjoOZLSVJDRazc6pAm3Fy3RaRAZmofF+q4mbdW1
	jR5W7o9HYEeNUgIT+/VKFjBMk/2EvmiOKGYnTT18WYz6fywTWiZa1FYXDOZ/GVBXavs8Q3mU9FF
	CgQos769bWeLYvQpF2hfnQHA1IVhY6Bq/Ns1//K4vbsLAOt+1Qnd0T6lHdnpqo8LGx+sYZX93jv
	qL+Wxg/gn1IkRVGAGmko7wzpOFru00ZQXP3063HO1x5193GrRn7TOhW0uzvLnDx2Cy+RelefBlm
	tobvbUUfSjnJBw6hwd5VP4v44SCBelDXeLt5xmZFI2J+sVLH2j7f/PFPKPRZYFNmUTfnNeLoV1M
	wo/UeG0tqD/Pvz+kSe9BeHV1AAcNCR76wFRtP/XaKPkIDovdWm9m+3Nw6MyozhuvnfNpbjMFuS7
	Jt5IGeNE/H64fnmRhungmGsOePIIQzQ+uLnt1wImz3RL0yP
X-Received: by 2002:a05:693c:810e:b0:359:861:7cbd with SMTP id 5a478bee46e88-35908617e44mr23583050eec.10.1792131095475;
        Thu, 15 Oct 2026 23:11:35 -0700 (PDT)
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0d391sm3725600eec.4.2026.10.15.23.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:11:34 -0700 (PDT)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Max Staudt <max@enpas.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] can: slcan: publish tty->disc_data only after register_candev()
Date: Fri, 16 Oct 2026 14:11:19 +0800
Message-ID: <afc724d533dc3e7d6d423a641ecb6ca5b40451f7.1792118038.git.chaosheng.qu.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792118038.git.chaosheng.qu.linux@gmail.com>
References: <cover.1792118038.git.chaosheng.qu.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

slcan_open() publishes the private structure to the tty layer before
registering the net_device:

	tty->disc_data = sl;

	err = register_candev(dev);
	if (err) {
		free_candev(dev);
		pr_err("can't register candev\n");
		return err;
	}

register_candev() fails with -ENOMEM from register_netdevice() when the
device name node or the kobject cannot be allocated. The error path then
frees the net_device and the slcan structure in its private area, while
tty->disc_data still points at the freed memory.

This is a regression from the 2022 rewrite. From the driver's addition in
2010 until then the error path cleared the pointer:

	err_free_chan:
		sl->tty = NULL;
		tty->disc_data = NULL;
		clear_bit(SLF_INUSE, &sl->flags);

Commit cfcb4465e992 ("can: slcan: remove legacy infrastructure") folded
that label away and dropped the tty->disc_data = NULL with it.

Publish the pointer only after the device is registered, so the error
path has nothing to unwind. ppp_async and nci_uart assign it the same
way; nci_uart was changed to that in commit fc27ab48904c ("NFC: nci:
uart: Set tty->disc_data only in success path").

The stale pointer is not observable today: tty_set_termios_ldisc() clears
tty->disc_data before .open() runs and again when a failed ldisc change
falls back, and the ldisc entry points are serialised against .open() by
tty_ldisc_ref() (async) and tty_ldisc_ref_wait() (syscall). The change
removes a trap for the next modification of these functions.

The success path was tested by attaching N_SLCAN to a pty under QEMU: the
ldisc opens, creates the net_device and SIOCGIFNAME returns its name. The
register_candev() failure path cannot be forced from userspace and is
only compile tested.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 drivers/net/can/slcan/slcan-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index c9414faafe66..fc6ecf110aab 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -849,7 +849,6 @@ static int slcan_open(struct tty_struct *tty)
 
 	/* Mark ldisc channel as alive */
 	sl->tty = tty;
-	tty->disc_data = sl;
 
 	err = register_candev(dev);
 	if (err) {
@@ -858,6 +857,8 @@ static int slcan_open(struct tty_struct *tty)
 		return err;
 	}
 
+	tty->disc_data = sl;
+
 	netdev_info(dev, "slcan on %s.\n", tty->name);
 	/* TTY layer expects 0 on success */
 	return 0;
-- 
2.43.0

