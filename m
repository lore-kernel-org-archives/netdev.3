Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9D41DEC4
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786485109; cv=none; b=T2ZvHgBZQ9NLNR5LZVNK1ptp2UZD8Dc+/PpAa3LvpwGAMsPCOvA6EWKbBiXgoGVpX7BcFrcPiTspCf9qRQol9tMIyEA2EumSqtPIbYDY/zqeHUseu1HCKnZjg9QiMkfr0lE2VbzThywH+pxaEt9jWvruDzgYAL4PM+gNBxC5Pok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786485109; c=relaxed/simple;
	bh=Azo2sCiZllD4H75gWaBzm5I3JqLlnW6xlX7nRXQnSss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RXW7uax1u/Yymr8HWwwOpf4ucs/Dg9hbMPgSN8+a2+HxBpp3eNHXpS7EDRjK74oPQ2oW7INnvDj2Kw2pyrNikvw9BsEejCFCn3qiDimK3OzhqD7mVBhN8J6KU4SCz7wigU1X6vQVLrGf1KuinBY/UhhU74DFIu1mr2eWjhHeP54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARAlwyWV; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARAlwyWV"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so303016a91.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786485108; x=1787089908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DKboDhjvAevX2LxnuClRbMjZPu76/sbW2vcejkifeck=;
        b=ARAlwyWVjZdIFHSvnn/x+IxioldlQu+BtSBh2YfKlzS0y/UnVgGgJ0qk2JK1UOIU9H
         H09haNFx2h+xVQivMsq/tA4iMdru9CfA8AHaqZgCvIFundwiezTam+o1+e9ipYMvEcht
         IT7VSYujcvPENfuuARPSUaE/T9Vv2p18MO4hOBgymn9Fg8uTPq9VZHiqPS9L4UQGTu/t
         NvZ3qaBkJ6RewDtejfk3ZWI2PwTeGwYev3x107go8HYT15pDz076+bXXzeRbsKlonlIH
         Bsps89syqT2YD7myxEwrvHa4IHoCg6dMnE5P6vo6MK9hPv6YnBOkRAbJZlbOT8zc6UJ7
         zMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786485108; x=1787089908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DKboDhjvAevX2LxnuClRbMjZPu76/sbW2vcejkifeck=;
        b=IWXx1eh9oZjbEI9T1b6hYt4mdVy/YhNjFrE4CC3Jn+Vko9i1XoN2oST2MxZxk4WOfU
         Q86QiDJ0rj7d3rkpQbLQ4W/SDE53N43uWJqh142FA/DAnjoIeCPlgz40tQucTe0sSSoy
         4TPLBnekn54Jwvjo6dBrXuI+D49rKJb7KF74VCLBs1IcBFH/8M/3RFiROHXi0rD0GL3c
         lLoCl+JUtVeVsP/lsEnOOwB0lkE8YXElV2MNI0X83nhpKvV1TFAZ8FtyCsMFyK6eysal
         0fa3R1xivajiGn+BMKYQPTux4l8Kl4Zl2g7BCBKvrCKDMUhRARhMPqdQ2vP1MVt7Qcno
         6GsA==
X-Gm-Message-State: AOJu0YzBdtPLJGGwL9vDJtivYcnECZqB1Wod1bK/Dy44K8sJaVjh5zLx
	WjyqTriYJTMOpYR2DiQloyPNXKwQQHVc6hPADpxaH7+hBDPkRGBvjdckGucAZjBOuAJZ5g==
X-Gm-Gg: AR+sD104UJB6D+tor6gAhdGNDYdNAYwUtw82lOZBP7rgulfgW12G6FXO0L3u28W+KQg
	n5d8R2b53gqOL3PTNMRFL2DqdzbYyizr6NCbePLbjEmCmELUDI4WwkK9sKK4k2CUfjfET8hgnY4
	HsSgW+31npquxHURLVs72bjOU9CJfYuUQ025YqesQQ598JgjJ54Y1cmBAqBtfjNNC0nllYjlxka
	RqBWQ+47i/1VmkRItjxn37zVvqS5gpIeUkgBFAUjjTcCfm/85ZLm4M3fpgs1MEKUiX1f5spfztp
	wybQ+f+Beg3O3H+LThINKJOs/AdJO4jF9GpxCroGVUA6rmd0RBMfRFB2E9HWWuNF8b7azoAlxZO
	GEMqEpzFR6cOzSlypBW7E2KP8jkaJjnAEQO0ex/9AKC1ShV0OrxQui4/KOJTI+NHtxsBc7+wyK2
	FbuwnvpdqVYHykILaBT49m6f91zu3gNAm0LZumHmxvY9Tg4XKUSFAwVRH+avSZ1nLnqdvypgP+n
	DalehsFfOP5mD+xvcVhgDbczoIyVpbILx/7SE2qaAzx9u0=
X-Received: by 2002:a17:90b:3810:b0:380:ce69:2669 with SMTP id 98e67ed59e1d1-392f3f7b5e3mr1932237a91.9.1786485107720;
        Tue, 11 Aug 2026 14:51:47 -0700 (PDT)
Received: from LAPTOP-N5EO9J2L.localdomain ([106.202.115.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141245a9f70sm3672334c88.15.2026.08.11.14.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:51:47 -0700 (PDT)
From: Harshit Varu <harshitvaru666@gmail.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	security@kernel.org,
	Harshit Varu <harshitvaru666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp] mptcp: fix uninitialized local_id in syncookie MP_JOIN reconstruction
Date: Wed, 12 Aug 2026 03:21:35 +0530
Message-ID: <20260811215135.87756-1-harshitvaru666@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_token_join_cookie_init_state() restores remote_nonce, local_nonce,
backup, join_id, token and msk from the saved cookie entry when rebuilding
the request socket for a MP_JOIN 4th-ACK handled under SYN cookies, but it
does not restore local_id, even though the SYN path saved it.
subflow_ulp_clone() then reads that uninitialized field and stores it as
the joined subflow's address-ID. Because the request-sock slab is
SLAB_TYPESAFE_BY_RCU and not zeroed on allocation, the value is the stale
byte of a previously freed request socket, which an off-path peer can
influence by sending concurrent MP_JOIN SYNs. This corrupts the path
manager's id-based subflow bookkeeping for the connection.

Restore subflow_req->local_id from the cookie entry, as done for the other
fields.

Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in use")
Cc: stable@vger.kernel.org
Assisted-by: opencode:deepseek-v4-flash
Signed-off-by: Harshit Varu <harshitvaru666@gmail.com>
---
 net/mptcp/syncookies.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
index 7f2252634..b5cac5701 100644
--- a/net/mptcp/syncookies.c
+++ b/net/mptcp/syncookies.c
@@ -118,6 +118,7 @@ bool mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subfl
 	subflow_req->local_nonce = e->local_nonce;
 	subflow_req->backup = e->backup;
 	subflow_req->remote_id = e->join_id;
+	subflow_req->local_id = e->local_id;
 	subflow_req->token = e->token;
 	subflow_req->msk = msk;
 	spin_unlock_bh(&join_entry_locks[i]);
-- 
2.53.0

