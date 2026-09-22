Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AA54A8438
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106527; cv=none; b=UyDaFUXtmxXZjLbjdjV62eYdTnnx8pvK21FIqRm8to08VZcaYart3FuJkle5SyHu5Rw069xRs7zzlIK3XNNKYP0ynx0ha5j3DDZKYwurvE8dW6UmF1oOZD5LvSMQmPBcvDT9PhPco1vMlsSOfOzf/ngDA1R3lmcfQ+bcPVjH19o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106527; c=relaxed/simple;
	bh=pEijDvSbnzNOm0euzfZ8M0Xgpum18qudVoKWgWc48zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xl7K55Sc6l58bgL3XDFSvTf8Vvxpv2uE2G7KHAHccmFLKYQ+tduPXrxROCiNhAHPipTdw31CHl/8hJKxczKmbJttlfFAGyyQYiFgKKmJvePWdIJ/PJmx0TOuXplYh5xD2f62SX4Y/oyEaMV4VRQrhy8xVzpS7gH40tNW0Ftscp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=hxi5T9Ql; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="hxi5T9Ql"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f47a9b57so231775c88.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790106525; x=1790711325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U0hyw392EUOq/7oRWDEQtoJ6bKtIqDyqp12q5Vya77U=;
        b=hxi5T9Qlv14xsRHgwQk2IISd3iMKupqOazU77Df6H0M6zFwsL/h70+C7c+RfInofnn
         Mafy/RsWQf1arY/btZVMEtgcWhqciWnajXXYFeAv6mqa2SAyX6fqct3vZtwUIC1kcKZL
         /AdcB9M9KCsCREhh5sUpnWDDb/+9vFRDZiEoIPnvPhyP09D+6N8Eeb5JhWTSqDXw3/sU
         Q2QioWwP3tepRogWLsw4MYv7vpvbgxjaMrslRqIocEJ53+3S4jmEVve0tT0ixzYG20Qg
         W3ittuP1+5ICdHfGcGHEYqCvIrCD/3v/wh/JGMavgH8pieIWSugcaAOKv10MkGIdSCBD
         XmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106525; x=1790711325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U0hyw392EUOq/7oRWDEQtoJ6bKtIqDyqp12q5Vya77U=;
        b=XaFBZRpkDDnmudy9dYmGNbpXk7YGxYKALk6EFiirOMIBNwSTCO2mnX/52jEARiMnY4
         hqqLNr5vGmHHWSOarIWYDa89mCxkfhNq2W0MTedxbKbAFsW3t1WMFTnuxXW7cMt0UC74
         IA0ATdAG2QsduvVUGR/zqVT+P1X1d3byY2Qzyes78BMpMVOC7q6TulTUED5TUDCFBT5J
         4du8kIcsqVBTNbpK4UhdWX8A+OblPrh0REuHJz+qBhfO4J1rNWnybcj2YHUQEGAL3PQ1
         HK1jcGu/laqx3xqQEDSSg4xPBxIOhWePH1LE7CVm2D1s4Zy2t3Duyg20MBHxea25cufw
         boWg==
X-Forwarded-Encrypted: i=1; AKwUvBwINMUi8l2UghSvcRZ+k40a5wquLXNCPVJnG92GIAPA3y+KdWCo5Ey6bo2Tf8hVZKfNK5LBWk8=@vger.kernel.org
X-Gm-Message-State: AFuF++n+2OOij6BRFXerlG1k/951dxthaTO4mDcxH7SqC5feSHQ/mBaI
	KTAICB4V6UCGDSD9se5Vegscu0zBqPV0QSgKdbJiyV4SzOYcmJ44BACvLI9F3nbxpWc=
X-Gm-Gg: AYBFou3TCrQMinwo5R1b6vZ957cBrUgE/nQB5FxCrgGOSk7hFycG2nlHniAW6iNFYGI
	X/6aqd/ZAhDnrWeYW2h1wvaBEoG/A8O4tJsWO8GMuPWXu04mprepqp2lFcOj7RMlMTjzljskuCF
	fVY2zvaPCKrxUXKRtzh407QxJ4VmyqNISuOkskDdPmbrP2/whTgiFRd+xl3N2KTSwArU9GkvAj7
	2LF36DU8cSwBzTUljwAMx4hmcipgMJrT1/UA+wyF47/blRudBJi/dh3fc2MyWs7ttH3H7h/kQ+V
	3u+xZrMgg8XMKHXYunKei/5ChcoKMHZ5iE2l3SI3sx49RMPY58Vy3o9065qFugSBSNQ1+o+wMEp
	G1V7sdz7MBW0CyfG8pQUfcdx0W1q1Ollzrq6UzhB4MtVpFUWecpE7dn5Ob4G0zVUDWcPtLMB8ms
	GBA2Kcn2ua6sJ015kuAGg9umc4x5TvuCr8TBSalcjO4GbQqeFVwZswHlZviCKcNeSo2XjEnio+A
	8zsm8w8D8f2HWFQkJ0gj2ULg+G6F3dZ5n2V7Sn6ez5hUM3p9jzACv57IR/w7GSziwGDqLmBNBlC
	nbNfAA==
X-Received: by 2002:a05:7022:3a08:b0:143:26ed:2dd5 with SMTP id a92af1059eb24-144f917a486mr532983c88.31.1790106524848;
        Tue, 22 Sep 2026 12:48:44 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:c016:77a6:d382:7611])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f98a288esm708550c88.13.2026.09.22.12.48.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 12:48:44 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 6.1.y 2/2] Bluetooth: hci_sync: always check if connection is alive before deleting
Date: Tue, 22 Sep 2026 15:48:34 -0400
Message-ID: <20260922194838.26223-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922194838.26223-1-artem@trailofbits.com>
References: <20260922194838.26223-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pauli Virtanen <pav@iki.fi>

[ Upstream commit a239110ee8e0b0aafa265f0d54f7a16744855e70 ]

In hci_abort_conn_sync it is possible that conn is deleted concurrently
by something else, also e.g. when waiting for hdev->lock.  This causes
double deletion of the conn, so UAF or conn_hash.list corruption.

Fix by having all code paths check that the connection is still in
conn_hash before deleting it, while holding hdev->lock which prevents
any races.

Log (when powering off while BAP streaming, occurs rarely):
=======================================================================
kernel BUG at lib/list_debug.c:56!
...
 ? __list_del_entry_valid (lib/list_debug.c:56)
 hci_conn_del (net/bluetooth/hci_conn.c:154) bluetooth
 hci_abort_conn_sync (net/bluetooth/hci_sync.c:5415) bluetooth
 ? __pfx_hci_abort_conn_sync+0x10/0x10 [bluetooth]
 ? lock_release+0x1d5/0x3c0
 ? hci_disconnect_all_sync.constprop.0+0xb2/0x230 [bluetooth]
 ? __pfx_lock_release+0x10/0x10
 ? __kmem_cache_free+0x14d/0x2e0
 hci_disconnect_all_sync.constprop.0+0xda/0x230 [bluetooth]
 ? __pfx_hci_disconnect_all_sync.constprop.0+0x10/0x10 [bluetooth]
 ? hci_clear_adv_sync+0x14f/0x170 [bluetooth]
 ? __pfx_set_powered_sync+0x10/0x10 [bluetooth]
 hci_set_powered_sync+0x293/0x450 [bluetooth]
=======================================================================

Fixes: 94d9ba9f9888 ("Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Backport to 6.1.y follow-up to 94d9ba9f9888: this tree lacks the later
  BT_OPEN and BT_BOUND special cases, so retain its existing state
  switch and add the common liveness check. ]
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Stable submission note: patch 2/2 in the CVE-2023-53762 series for Linux
6.1.y.

CVE: CVE-2023-53762

Build: This patch was included in an x86_64 allmodconfig and
CONFIG_WERROR=y build.
It produced vmlinux and modules with no new warnings or errors.

 net/bluetooth/hci_sync.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index da9e6e55bc1d00..08e90dab73459b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5587,6 +5587,7 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 {
 	int err = 0;
 	u16 handle = conn->handle;
+	bool disconnect = false;
 	struct hci_conn *c;
 
 	switch (conn->state) {
@@ -5601,19 +5602,13 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		err = hci_reject_conn_sync(hdev, conn, reason);
 		break;
 	default:
-		hci_dev_lock(hdev);
-		conn->state = BT_CLOSED;
-		hci_disconn_cfm(conn, reason);
-		hci_conn_del(conn);
-		hci_dev_unlock(hdev);
-		return 0;
+		disconnect = true;
+		break;
 	}
 
 	hci_dev_lock(hdev);
 
-	/* Check if the connection hasn't been cleanup while waiting
-	 * commands to complete.
-	 */
+	/* Check if the connection has been cleaned up concurrently */
 	c = hci_conn_hash_lookup_handle(hdev, handle);
 	if (!c || c != conn) {
 		err = 0;
@@ -5625,7 +5620,13 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 	 * or in case of LE it was still scanning so it can be cleanup
 	 * safely.
 	 */
-	hci_conn_failed(conn, reason);
+	if (disconnect) {
+		conn->state = BT_CLOSED;
+		hci_disconn_cfm(conn, reason);
+		hci_conn_del(conn);
+	} else {
+		hci_conn_failed(conn, reason);
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.39.5

