Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213062;
	b=f1FBmCZGg1coOIuffrdr7imvKiAAof+zvFS8tIvVhqpT2KncmGCfAbHvEmYEkVqUn3BD
	 rLYsPIZcJFalUKVVDdtEzCIDQkz/2uD1ESkFTlnqTSnwISyN8OWqv8ayY8cS+W2A6llVa
	 UyJ8cXNevO8JUHvDSa0EQ3ma3r1EUSZqKj9FDjnw4FEvjuN7miEvjnCNcdPqxTXE+7Ne3
	 nAuIKLI48RqAgVhv5bQAtAZ5lCv+e4OuEnUkZbIQXeAJ+lvHs91vBXgq9H2ajVw+H6oPJ
	 q/Ri9iqjoclyLc+eL9Vxdr07TMEObOQr7tAlFpmhug73FqAwHcOjDFOtHVRZyqKaTbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vfC+pb0AJgv0GKU95tThougH9ZxYjEepJvXJA7a1FV8=;
	b=KDxM7f5nG1KPNei/jyqFKq3oFdfktliNutK/Kdfk2k0ANiHYwwnKx5iCCmxm+QG5z58q
	 WnD4cRYJgPy0ztzyK9YdcZVboGkjpvAH0pG5W3cYtXNJeRxvHSgMpYbmyOk8KhHkV7N5m
	 FvG15F6w/6i+7KeFobSdsrqJ3DUqjMTQuSJJR/12n22cO5TYTZNio2Ye7hzuippgnpiQn
	 +FI5NP5gNnV0IH8FKsx7cf1tDQ2QEs6rP4Ck25Ay0kKEjfUSifMau59ez5iFnRVbxjXey
	 PMS4jLPD6Yx1AFU3wOCWmENkg185yrPGCWHKAzlj/G+/SdV7GPw1kjz7oDiL6oNP/Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jU89jaK5;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0767A606A322
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 08:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0767A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jU89jaK5
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-37000e7234bso80780eec.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 00:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794213061; x=1794817861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vfC+pb0AJgv0GKU95tThougH9ZxYjEepJvXJA7a1FV8=;
        b=jU89jaK5dnAFqhr6/U60Wm+KBdemIPUAoWBa9y10Mk9AEUfHm1Pa0iMz/lxQ0n5Ux4
         pky21JLLJrd7tLJ5GFtAHPV8h7ntqQ0ebFN57Mqh9J8Te8+Ci8tDEsqhM+pUmaS2BgHu
         mmUR0X9uzi9jE6ezViLjRCO2xdnpkXw0Afm8sdF4ZZJp+i081byH6OhPjYvEYUN4t3Lf
         kbUmVJXdx+bzkVRkGBJmz839qzNhXzSs0nUVeveROtfFCWtmktSQQCLTPwDcoEB9a79y
         vPwQN/OgLAXAFSUr22w17OWIIFVRE6X9nBuzYJQkok3mltOVDZdLWBr6IEcCPFIqTV7E
         PPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794213061; x=1794817861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vfC+pb0AJgv0GKU95tThougH9ZxYjEepJvXJA7a1FV8=;
        b=bhmMU+T84eyy8NpLid4PjNH38M+Y6rw95Hezda0q6NpjUlOpssECsgjBKJ6RVL0mmj
         DA7k/XmrhgALuXyx6Fe5l1uvMmTHPiCN1Jh7XM2VhPQZu0vi1CYhRBdUvDk0jWloiuhc
         mGKrSpzo4PLLCoqO9E34cNHjZAbm/6dDdbVMl98TocCN4pQ90+d9+vs2mZycftdgMIcT
         W9GsCORfN/5tJKrZLjT99UQU1ubGT5bpHazaS+frWTQupQbktWl76JsyGmJ0paZ6/tPA
         9uPis+6bsNgdyTuyQLGgtqjzhpM9pDuY04HP2YHRU6DgcEHrHkgymbLU5eEeQDL/oJsT
         8CZQ==
X-Forwarded-Encrypted: i=1; AL+hErGzBXgzgxgdAoiblUYPYWikxYFoWTYhnZK62oMDYCXzN/iBUxcpsGSKxv8BZHEzpJ7ixPP9atM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7949T3OLfmC2T+8otx6FKqC17sTZf9GxcKSCnsJ5F7lEJKVhJ
	PHKynV5pT2HiiqKDo9+iscTVROGhVQ7v98iBIbdIjwBZCA5HNXvcK7Qy
X-Gm-Gg: AYBFou1VafkEL+W54o4eO+p6Y7JX+kESUpWRkKyQQwx5xb8hzCduiL/rzyJFWD1SkCN
	MNJWJtJsRgs9f13+VfaUEzTi5P1+xJFakYSHBXKYKQUkdy4iRvFyX0dywsvEfJ9Wt/UTLVDQEOy
	PfnHHVKFTG/PmLis9xvJ7vII2gDX9DvfTcEDRHo3TnIVYR/T9C0lBDBeFnNzR03yXDV4fDucvoF
	/UsMdvDldvt94HVDW1YPxTzGTswqQ+mjKxcXxfe335ANoRqTxIFMUSyvYs8eLpjgIIQWhHtsEVi
	kl4ZUjaF+AG+3GwVezBOcAUmhxtIihq+k1gKOvac6nbdv15/iQmnBtGVPodBOeRRvFfjD4HcnxZ
	SLwJojl1KCSELE37XXE7fWjPQ94Kg7gvHF/Ku8U6C/wTKK983PfFEBLrgUQfpv8x6KdwvjDDlLU
	BMBA73Fith1ycmSSzO4IvvzuOlNUXhpWJKv6m6zY+JiJyffh54fdjc1Jqfm5GKk858GPHay1Tan
	R/FbXu2QRyLxJgixJEaMsrz4h3CpgH3R8dFX6ypbjlBtdor32jERVCfTCmQeym57U2G6D8jblnu
	XwZvCZ7NpD08bNGdiBRBW+deAGVO411LewxCnzQ=
X-Received: by 2002:a05:693c:65c6:b0:36e:53bc:4681 with SMTP id 5a478bee46e88-372569fae2emr6648368eec.37.1794213061041;
        Mon, 09 Nov 2026 00:31:01 -0800 (PST)
Received: from xploitoverload ([2409:40c1:400f:1382:e6ca:3a31:da44:4020])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372667d60absm12131756eec.26.2026.11.09.00.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:31:00 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: andrew+netdev@lunn.ch,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com,
	Kalpesh Solanki <skalpesh942@gmail.com>
Subject: [PATCH net v4] tun: disallow setting IEEE 802.15.4 and 6LoWPAN link types via TUNSETLINK
Date: Mon,  9 Nov 2026 14:00:37 +0530
Message-ID: <20261109083037.22337-1-skalpesh942@gmail.com>
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

A userspace application can set the link type of a TUN/TAP interface
to ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR, or ARPHRD_6LOWPAN
via ioctl(fd, TUNSETLINK, arg) because tun_get_addr_len() explicitly
recognized these types.

However, TUN devices cannot function as genuine IEEE 802.15.4 or 6LoWPAN
interfaces:

1. They lack wpan_phy, channels, PAN IDs, and MLME operations, and tun
   never initializes dev->ieee802154_ptr or dev->ml_priv. When an
   unprivileged user creates a TUN interface in a user+net namespace,
   changes its link type to ARPHRD_IEEE802154, and issues a netlink dump
   request (such as IEEE802154_LLSEC_LIST_KEY),
   ieee802154_llsec_dump_table() unconditionally dereferences
   dev->ieee802154_ptr / ieee802154_mlme_ops(dev), triggering a supervisor
   null-pointer dereference / general protection fault. Similar
   dereferences occur across net/ieee802154/nl-phy.c (ieee802154_del_iface)
   and net/ieee802154/socket.c.

2. Similarly, the 6LoWPAN subsystem assumes via lowpan_dev(dev) that
   netdev_priv(dev) is struct lowpan_dev. On a TUN device, netdev_priv(dev)
   is struct tun_struct. On netdev events (such as NETDEV_DOWN in
   net/6lowpan/core.c:lowpan_device_event), it clears bits in
   lowpan_dev(dev)->ctx.table flags, which corrupts private memory inside
   tun_struct.

Rather than scattering checks across subsystems, fix the issue at the
source: disallow setting ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR, and
ARPHRD_6LOWPAN via TUNSETLINK by returning -EINVAL. Cast arg to unsigned
short in the comparison to prevent upper-bit truncation bypasses (e.g.
arg = ARPHRD_IEEE802154 | 0x10000).

Fixes: ff4cc3ac93e1 ("[TUNTAP]: Allow setting the linktype of the tap device from userspace")
Reported-by: syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9ea34da5ca6100593c90
Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
---
 drivers/net/tun.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index dcec7311e60..b50a7245be9 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3362,6 +3362,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			netif_info(tun, drv, tun->dev,
 				   "Linktype set failed because interface is up\n");
 			ret = -EBUSY;
+		} else if ((unsigned short)arg == ARPHRD_IEEE802154 ||
+			   (unsigned short)arg == ARPHRD_IEEE802154_MONITOR ||
+			   (unsigned short)arg == ARPHRD_6LOWPAN) {
+			ret = -EINVAL;
 		} else {
 			ret = call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE,
 						       tun->dev);
-- 
2.53.0

