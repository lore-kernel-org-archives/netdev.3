Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792945940;
	b=znt7q2SEIMqZzeVzbMOQN/bJU2VaM3DrbEELib6zCfHehJw7Zp0/+f4ehMZpx4rQ9E9a
	 e/iR5OImnBj92fDJupv6DgFVo01uH0f2+sN+myM6sTZd9wR6AmIgbuWMwAkXSkQBcsCYn
	 +u9S2nVIWnnw/PGvUCa884LT3QzlECSOaMwLPyvGfp6WFWAsyaFkwgfTdbiR2A2UTI9wa
	 klzM7QtbhxBYhahWkh9H1pR0kb0IQu/o9WRNGUVoHGRNvrxEdurYOxdvDdMDelcC7/fb5
	 UcWrkO1yOPVeL2dAdzBeN1CjI2++Rja5k6TKsELWWXhJA7ucJHke5T2eSqPTCea7K1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792945940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8okjaHqjL4OJDz9RgzhtvzITY5sy3ytCZSHI9pXfkb8=;
	b=A3RoMeHyX6DNAmsz7EIs6ITjn8H3e7krOAfjiBPcnpb1v18tOb6fnUTbg6nyBo3YLM2M
	 /u6gZlhIRzePNL4THlbvCUJYejKHbEP6PBmEcgjIcmnhUDnClYx4wvHl1mkunoJ5DQ580
	 aTB4ayrZwTqUA68DxXLxD0/WuxW+kdhamF/icYMI/JXJCKL+MB2XDG7WWf1qQQwFkxNFM
	 uQj8y10ciFpE4NLEPIankZ8BZLQN04oq3P9ADBnpQ0uiQzhDGNXr7UfIhvWKcPAP7/Oon
	 qN/w6ccGjVQidXWXvAvfTCvNo7uOK1dPAC9OXDnKP/PB1Mju5Tuexy+XisSw6hJRJjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qFZnebnx;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C673606A31B
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 16:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C673606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qFZnebnx
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15dd124bbe7so1283683c88.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792945939; x=1793550739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8okjaHqjL4OJDz9RgzhtvzITY5sy3ytCZSHI9pXfkb8=;
        b=qFZnebnxj5Vvx6U0fvVEUOfRvN1himjhFXtGu5AX5OCfmExMSshqb9FXwntjZV7ys+
         fcCHEN5ZlCO424XaWgf924/upjgtY78bqJtP9X1c3zhTu4HjAdm7gPMnD8Ef3QVBm2ey
         RXixkmHVVp+ruBQr1s7NdhTOhKGV/4NqqGhTq5v3vFDgTxdcgNP3T234mYz0ChKSgyGd
         cZhpuwtf6yiHBG59MNE4tVkGMEMSF26y3eDENo/8p+5mIDxrVzbUPHM9PbUSdkJqeZXx
         Wiz0oVF34Sj+k/JTutL5kLTll53rD8331uuwZfcDJMLpeuY/N84+AC671UZ1VCh9GuaQ
         x7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792945939; x=1793550739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8okjaHqjL4OJDz9RgzhtvzITY5sy3ytCZSHI9pXfkb8=;
        b=smVNcHZxQweM7YoltVpPnvucnaLLvZd7I5Kd3AHl8v/f8WmAOK+bQyI8mB4r+hEcux
         nPMVjASvKTG/TNwmS0d9sIvB2FUE37R+9AyqfzjViBTfePtjU7DBHOCVwt37IjJCcDNZ
         j38gnTVFBs+Pj3I0rUHEoaAuU7deyR0rd8m89iRExCWCmtOeA4UmO71pl17VkFIcb4Kt
         U+vFSh6mLs31S1W34qoC0NdoaFMAyqw8KetXGohx9YjeyKxj2Mbw2tw1xlm3aogUsTYw
         q/WtfqZ56qLiisvhrBcn5xG/3TXcTYllB6ri0w8X5yUvXFxj/Ln5Ign2QT/QVcNXdIMh
         y+rA==
X-Forwarded-Encrypted: i=1; AKwUvBzxKGXmLlspqQfRWqZPkM13XXpvZHpL4sCcJPZqgTG2ccKmZ0Qwf/bUuV46hFkDEP21MlKxTFI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1XjShzwaI+Xv+0JnUpX+A2WcnyYvuduUr/Ua73US2Hi6u7tAY
	9On/j3vJ6Dru5WdQX/GGrH19wUP1WdDoc9bjKGBFQYFy/HsU2RGeePkC/zVxDC2k7Jg=
X-Gm-Gg: AYBFou1tVu8oMj6/tqzDXWWuXXIHVotXAB0UjTR2OhqiPUsLd4Vj6Tiv12n5HpG3wgj
	QdyIlaqf67KV4nzzKOxHg7gdIK39Wx+V3HCEvKvJ+mFLm7SMdFn14I5jauM0Q5JbUE57rqcuaua
	npAiSp6xwbjNjChVLP6qj9IrA8pm0nRBvlwHIeIf/15QznrsU5p4gvVoUNoB9CAmUCrVOQx7vev
	MY7rLzSiTI2JENZFhVEZMDnx5orejYCPa9W0FLKIdMEVQ+r9le5343Hvm4rfuhg4q1TjvpHcGpQ
	0Op2SQ3j2R8HwZHScm5q6MIyrrBismtj8qDBdfAs9IXYxLVwkmZqtXpyrK+aNijCoIIb+bVegfl
	1l0LVu0Ofe9/ErU2R0r9M7akqNKepWFiR9Q7bIANYlotKZ3B6rcSssgnE+C3w4qVMYT2fby9oTs
	1ZiN3yqSIL/c54n42hM5Tb7hqE57rrpXrDBEtEYd5L1Sk0d2pwEMroG0+TS48RLC8TZH5azRhju
	fKPAczS5S9Xp6ORvfoCcEqyk/9Ksx4FZZzV2cZk4O9+kBaemc+5dzsK+aDekDt7WnBFU1jC
X-Received: by 2002:a05:7022:b051:10b0:151:d6e5:596b with SMTP id a92af1059eb24-1993571a0abmr7277044c88.9.1792945939038;
        Sun, 25 Oct 2026 09:32:19 -0700 (PDT)
Received: from asahi.tail4da9e3.ts.net ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0f83cedsm22025164c88.13.2026.10.25.09.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 09:32:18 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Subject: [PATCH net] bridge: cfm: keep RX work disabled while CC is disabled
Date: Mon, 26 Oct 2026 01:32:15 +0900
Message-ID: <20261025163215.62509-1-pocj8ur4in@gmail.com>
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

Found by reviewing the peer deletion workqueue fix. After CC is
turned off, a valid CCM can still reach br_cfm_frame_rx(), clear the
peer defect and restart its RX timer. cancel_delayed_work_sync()
only cancels existing work, so a later receive can queue it again.
The peer may then report a new loss defect with CC still disabled.

With a bridge/veth setup under ARM64 QEMU/KVM, disabling CC after a
loss defect and injecting a valid CCM reproduced the restart. The
original kernel reported another loss defect; the fixed kernel did
not. A test-only gate paused an in-flight receive until after the
disable ACK and reproduced the same difference. The gate is absent
from this patch. The reproducer passed with the fix; bridge selftests
were not run.

Initialize each peer's RX work disabled, enable it only when CC is
explicitly enabled, and disable it synchronously when CC is turned
off. This also prevents an in-flight receive from queuing work after
the disable completes.

Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
Tested under ARM64 QEMU/KVM using bridge/veth, netlink CC settings,
and valid CCM frames received through AF_PACKET. After a disable ACK,
the baseline queued RX work and reported another loss defect; the
patched kernel rejected the queue attempt and reported no new defect.
The same difference was observed when an in-flight receive resumed
after the ACK. Explicit re-enable and peer deletion were also checked.
No physical NIC was tested.

 net/bridge/br_cfm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index 9dcc97d63a6f..8576f387d037 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -150,12 +150,13 @@ static void cc_peer_enable(struct br_cfm_peer_mep *peer_mep)
 	memset(&peer_mep->cc_status, 0, sizeof(peer_mep->cc_status));
 	peer_mep->ccm_rx_count_miss = 0;
 
+	enable_delayed_work(&peer_mep->ccm_rx_dwork);
 	ccm_rx_timer_start(peer_mep);
 }
 
 static void cc_peer_disable(struct br_cfm_peer_mep *peer_mep)
 {
-	cancel_delayed_work_sync(&peer_mep->ccm_rx_dwork);
+	disable_delayed_work_sync(&peer_mep->ccm_rx_dwork);
 }
 
 static struct sk_buff *ccm_frame_build(struct br_cfm_mep *mep,
@@ -695,6 +696,8 @@ int br_cfm_cc_peer_mep_add(struct net_bridge *br, const u32 instance,
 	peer_mep->mepid = mepid;
 	peer_mep->mep = mep;
 	INIT_DELAYED_WORK(&peer_mep->ccm_rx_dwork, ccm_rx_work_expired);
+	/* Keep RX work disabled until CC is enabled. */
+	disable_delayed_work(&peer_mep->ccm_rx_dwork);
 
 	if (mep->cc_config.enable)
 		cc_peer_enable(peer_mep);
