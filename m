Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489077;
	b=CP9Val3ZPWZt/YzRCrKTVBT6jriGtSwsvtelI0foTSfOnJbwu0J8utoRyG6HNpwCvo6n
	 uoUXDkPmNFCURHH6L9XE8q5WNUAqXbm+SjXLwkcvti8yut2dyGXIuctDgOp4YhhKtAAf+
	 MNIA8USUxis20UHTX5Rm3nhErN2n3kMp7qfMWHEjFCHQsqs+CeV6JWbI08vHZssNx4QNO
	 OWbqvm0N0UT51xPtYPKn8hObvImN6zKe+YZca8iKWXJJoysyV/yy35+aa9EEMb5L2N4/D
	 tACH1pIH/BKPNrQ+FaPnQ3Xc7Z5qM3dHxadzdWLDNBKJWz0/rlFAB7ksM/y3Lyt3OVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ExiWe6IYRCzUY8rck7nlU6f6ETQaj99+YuhEArdi1eM=;
	b=spw5i5XXkFg8IMpGb6lY7P8lf4hl9r1xOr3gygI6SL9o85ZQrnTMXzoBits4DMhGzegs
	 h3eAcEpdpKSfX5gtHwSEvITCiTpV0Kqu72OVDG+ibYZnixcFIhHqCPHkpi8htSJtsV31i
	 gDh1AM/fAX6qZKnARDAmFBcFM1u2PX7kNWZpOxaHa5FGGs+JA/oG4Mbkns9BpLiRC5qD3
	 GYycrbWZ82paGhFqUKMXm2q3G2gwPvi8+Hole4klPe/o9Q5QL2VfBHa87yhyYjvLGypQ6
	 BRzKfkJ+pLA/5A+Ms6NC2Na2yYlThz5bsjHJS9PzSmfuXaPfphyT9aWvSzu0UaaxOhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aTTsQeZS;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A9A606A334
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8A9A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aTTsQeZS
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-37071c0f42aso7104873eec.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 05:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794489076; x=1795093876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ExiWe6IYRCzUY8rck7nlU6f6ETQaj99+YuhEArdi1eM=;
        b=aTTsQeZSHDLOerAo12RK4wsz6ThRmPhvgPb/PbQFyIjz5OLR651gaUPDRyA4a1Xb5M
         mS495dLFYqdKbDhN3zdDNnWGlcbX861hGBFetoTbgsCDYC4Za5yTg7c+mGwCAWs1Lsxd
         9uDF9szcQiQfluxHBeR3RQk72/GTu7hLGhnX/SC3QWQdVqTIL4Gs0pDnwBKTSsnq3pHB
         iuajqP8hcHMP8lklRiv1gO1/CfTXxbcvn+/Wo/hN+saRDVM1rFQT0ZlESx3/lK7t0Ctd
         CeybPY9geqBPudJeQl/QDKEPR4bAJ05fKu2gsqmsLGm+9vHI7zgAU5KZ06v2R4Uzb68p
         PcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489076; x=1795093876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ExiWe6IYRCzUY8rck7nlU6f6ETQaj99+YuhEArdi1eM=;
        b=jOnwnn+Vvq6pfn2UM9D7H5eCqzvJLIfuG1930sOPxouYJ8x4GuMu1KEegsL/L2srvJ
         awGkvzEVh1uE9ilR+GxawJP0Vs/1+l3pQfnueA1d5+SSut3kpZXOc0/KlZ5LSFUUn/Gl
         m6fDNDnD0aZMewCbT6Uhz1PbyltnoHXrnNprDZBDoUFdcGMoiUK89R9B1tIFkEo9/aqY
         bw9n4B8g29YhMMzv7p/6G+ILSYClrg+mfR6mMgDSso2sfmwtJW5GmaOiVB0Sx3ljN5HM
         j1K3N2DAyL+E3yMJQ4vMLrv3F6x0zcCGp9xJJ+kL25uVsd82W4rWdCY5ZfpVH4eEvj9Z
         PIWg==
X-Forwarded-Encrypted: i=1; AL+hErFJdre7dNdEbojG42S0DSr2uhFoQHA8asCE2DxXyqVn7i9t0QR3ZJ1rq0bDKIKBqFuohPY2n/Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jlU7wd09zVplRJjYlJws7I38FQyPZc7V63j98jcVWqYaSguJI
	po37KnRgS7BGb6moeKjyh8bWakDPbENWbFyl0pZ6k7jPUPBpY2OjUo7T
X-Gm-Gg: AYBFou2377VKi1/5OHrS58UpFWCHLRh3vy5IxcEI5mgQE1Kar3u61m++6lxbhE972tJ
	qbBma5XMD6OSEJrWwT19YOFQWOPCSoFPLicj6X1sFoXvCexxmdLfd4VqR7V4g0xYtBm4GLIH/jJ
	EegT9PCR1dtUk/iSXNKwjbIjujlRoEWY3KfVMo6hr7v6mdiwMgdWKi43sfCxtULraUa0qVxEn22
	Kivyqo8g3dpdu0Ja/bKFGRdFXLvCdtPE1V/D+YEDQVcd2C8K/mH7cqeZb7Dkmd9X8b9L837GAzn
	RefBVfQUwLa5fFs1/gdKxehrXYILXmCtD1W6Fietwf13gCvX5Z0P+IZhbi2p2Yq73qO02jumta7
	Ud+3QMpZRBONW4rlsiKMCL0lLMlD6jePnJMXvTBKfDWvJ83X/68OOW1Bq5LS93i/O6u878A8Us/
	0txoErKEGC32BwHPo0wVA4yesnfnpFB68+8t5Xa71RzpqOB5Msx+yH9Q6GVNjcLk0rjzxLeghgm
	50GLtTl3waANLgbvAE87x1iHUADTuFnI0EEJhAz1PdPf3kYenefAOuRv5m8CLlIXovUdpLvTp7m
	AL8vKYFzeEqnGliS9w+Pv5nk58iqcBAgA9ZQ0+PzCJo=
X-Received: by 2002:a05:693c:8945:10b0:372:7af9:b914 with SMTP id 5a478bee46e88-3768636eb08mr5533318eec.24.1794489074432;
        Thu, 12 Nov 2026 05:11:14 -0800 (PST)
Received: from xploitoverload ([2a09:bac1:36a0:120::1c5:160])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bfb58dsm49306866eec.18.2026.11.12.05.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:11:13 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Jeremy Kerr <jk@ozlabs.org>,
	Matt Johnston <matt@codeconstruct.com.au>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kalpesh Solanki <skalpesh942@gmail.com>
Subject: [PATCH] tun: disallow setting ARPHRD_MCTP link type via TUNSETLINK
Date: Thu, 12 Nov 2026 18:40:55 +0530
Message-ID: <20261112131056.234801-1-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
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

When an IFF_TUN device is registered as ARPHRD_NONE, mctp_register()
attaches an mctp_dev context to it. For ARPHRD_NONE and ARPHRD_LOOPBACK
devices, incoming packets in mctp_pkttype_receive() invoke __mctp_cb(skb),
which initializes cb->magic = 0x4d435450 and zeros cb->halen.

If a userspace process sets the link type of the TUN device to ARPHRD_MCTP
via ioctl(fd, TUNSETLINK, ARPHRD_MCTP) and transmits a frame carrying
protocol ETH_P_MCTP, mctp_pkttype_receive() evaluates dev->type ==
ARPHRD_MCTP and calls mctp_cb(skb). Because frames allocated in
tun_get_user() have a cleared skb->cb and were not constructed by an MCTP
hardware driver, mctp_cb() trips:

    WARN_ON(cb->magic != 0x4d435450);

On systems configured with panic_on_warn=1, an unprivileged user in a
user+net namespace can trigger a denial-of-service kernel panic.

MCTP communication over TUN interfaces is designed to use ARPHRD_NONE.
Setting ARPHRD_MCTP on TUN is invalid and has never functioned. Disallow
ARPHRD_MCTP in TUNSETLINK by returning -EINVAL.

Fixes: ff4cc3ac93e1 ("[TUNTAP]: Allow setting the linktype of the tap device from userspace")
Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
---
 drivers/net/tun.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index b50a7245be9..eaaec072814 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3364,7 +3364,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			ret = -EBUSY;
 		} else if ((unsigned short)arg == ARPHRD_IEEE802154 ||
 			   (unsigned short)arg == ARPHRD_IEEE802154_MONITOR ||
-			   (unsigned short)arg == ARPHRD_6LOWPAN) {
+			   (unsigned short)arg == ARPHRD_6LOWPAN ||
+			   (unsigned short)arg == ARPHRD_MCTP) {
 			ret = -EINVAL;
 		} else {
 			ret = call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE,
-- 
2.53.0

