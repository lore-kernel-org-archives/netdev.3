Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223391;
	b=oLRr65yJP9NQIAyCNm9hQztmKZ6KHfKtxoMrOAeN+6uiR3Vdx6Ker+H5cv2zhnQGytc9
	 fJi21ZxKFyRY1EI37r1JAdlH+jc8b50m56olLldwVJipKPgu1aPIesFCksal9qpZSoaul
	 Af5QFvTQ+LRumuMIhYH/G3aqCWk7GEVAdAPxhHXEvxDDlotZPkeSPM6wrTB8kMR0qY1zX
	 aSqZd+OmkLbeoj8rXFrLn0dkEjffFDiPWSw1qZD0kFGaCEfcy/gLYMaJ0kdhGAusDXkyn
	 wfI8Cw6Bw+FbFFlBWJu3G/iomn9qWNRdK6EZ3TMSHqghpmmi9XCQtq3UOCbkvgwZ9DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=e/XTEYz7kVYTIlF+0bzcL6qt0pmHhHJHtdLATmxI3Zg=;
	b=w29C+EICFPf1GkEKRQe4hcwm5rSLRC/ug8nSSjrG1sIF8GWj7fTRCGrdEw5yLOvi1FCB
	 woAzkixKOBCack/DK3K10DYxsapWhyK8/11shVlR+GNXOGrosGUXVaX9XV/g2zKjBzvzF
	 nSEgAO6HHG0mFH7+EvPSq5zEdtfyOKjfhOtFhMryXNhTv3rLsN5vpVF4Z317Elxkz1bi3
	 my+0UESW27W8ufeYLrepFg+k/Wd44tIG1LGseCdZOQIPH+IbZDRUHDbprR5dlNN1i410C
	 flbcJh63+NbOr3kjhwdvh+qzdEIyMx21CJ7Ojd3YM9hJFSwnCOdHnCewTD2GR/IeplQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j++Lxnpf;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4B9606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F4B9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j++Lxnpf
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so1260204a91.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793223390; x=1793828190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e/XTEYz7kVYTIlF+0bzcL6qt0pmHhHJHtdLATmxI3Zg=;
        b=j++LxnpfW56uvTVD2YRuPwpxPgQjZiYij4eH41Z4xfdi7MiYR8ucdBq9lTsCbs2RWh
         76iX7TrnjNCnIpzuGnO3sOwpDQanVf5wQyByWXt0CiEsHL+s+pQ+mVN6n2vBFyPHdStR
         M7cBXGVfqpckefSV+aJndLxnTSQLzBvdhPnKIBQnyBT2f23qPfJdu4V8O/UwsRvPXf5N
         QUOlyeXQNM+i6Sog8YHx0yh50nm1iEei0aXLzxCU/Khv9sljSBXLqNaZwXXe/bVdhANx
         hXFre9rodkrgN0ed6CMrZpwgccuOblQa+vX0bkFHeaqHesQnRCJ6LxYoaalRXHXQ6gRs
         z+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223390; x=1793828190;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e/XTEYz7kVYTIlF+0bzcL6qt0pmHhHJHtdLATmxI3Zg=;
        b=C1NFNF/WV4VNOibqyXTdAMHqehdqNTbIB83bjBrrH8RJxryUhHKB4fI1zma6KO34Kz
         XFrwRPEyLFVUXC9MDECxnBoKCShnnSpwnjikN+lQixmbrxP0IewxTjDOVSHsOtruAZ0b
         U4xqJ/Xe6xDWdhwSfiJpPvHmWEyipuGL5d9PyiJ4qHcy24RXbz+tJ4fwRU8C1WmbgRTG
         Sn1+jPwmuYakIueYKZIpT6qi/x3ejYHCY0DQTuDEa6KViyLzsKq1HR80pNbN8os4uacC
         +vXuAtpaq/fQgbs+Qua6OlPRnx2d4d85qogc0ETISwOUl4ZMbFsken1BmztIin5ZjvlF
         waIg==
X-Gm-Message-State: AFq9FYKDgFksTfRlDfNPa1/Rf1sqfvtc2PwpqiB9pS8otEyATnIf62+c
	4GsrX9A8gYA4q+MWMzmHFs6v8SVJoYsdbaZU4SdRpCdYXY1jaNcvweKK
X-Gm-Gg: AYBFou2PDmWd+64aQpZJ40jrV2M0dVd9BrrY/hJ7NDIQbgqlHcmV4zrCWhuFLEmH5rh
	ySm8JCC/UIUkC52Mt6k0ZwEktmnzVKPwsdKdKIjMxFkJJv1SkPFVMEtGXwNm4Cji+xJJAG79EqO
	omgl4rG8oIIVKQDRZB8b6p0FjVU74pX6mYzrOp7G/+vrP0I06xDy8yzqh0q0rJ6fV+pGTUojA3S
	nVh81Jjem02LFo2meL24f9sp9rchkbS8fwSqQ4lnBIdhREorqF8/W2mESmsD7d9Gua0udt8qAia
	MINZYiwhjm7n2UAK1LLsxpNCOiioOI4c+CYsBjzxEN9lYEjHZ1vXjf5M6s9lm43x5iqEe3QiQ6Q
	0MDPvy0VWFpA8KdHRr+c+7m2NrXTU8Vm/CpphOt7hFYj7lBV1AtJfOecMLru5uEWwrTQdAkPDSs
	F8vq9wlynNIdJeHIiBeMagyh+vaUJyUZ7kmSTlZ4zUT2u/bD+mYNT41WVpOZVVseXt89zG2f64w
	7iB2Us7HVCZ4iFqOZxV2wIX3nI9ODTZ6y/N1GcTgdmmT30puKmxI78SXYXqqZ2g4qi/wipXVqXu
	/97m6L85Uei8u3CEPOtcWIih54p1CRlCkxBcjg3rELGfX5NJ/6S3ktLGEG0iAh5n6zPCFfHKTYa
	PC8ufcF/y6NVB4SztD/Gk+PATAmZ3sASsayiwiyLuMcEoBw==
X-Received: by 2002:a17:90b:1343:b0:3ab:2236:6b3d with SMTP id 98e67ed59e1d1-3ae5822fdf8mr2617254a91.27.1793223389939;
        Wed, 28 Oct 2026 14:36:29 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7ac878sm1057973a91.4.2026.10.28.14.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:36:28 -0700 (PDT)
Subject: [net PATCH 04/13] fbnic: Retry the MACDA sync to firmware if it fails
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 28 Oct 2026 14:36:27 -0700
Message-ID: 
 <179322338727.40667.9687403297682768724.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
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

From: Alexander Duyck <alexanderduyck@fb.com>

The fbnic_bmc_rpc_check function clears FBNIC_FW_CAP_F_BMC_MACDA_SYNC
before it sends the MACDA table to firmware and does not set it again
when the send fails. A transient failure, -ENOMEM on the message page,
-EBUSY from a full mailbox, or a DMA mapping error, leaves firmware with
a stale address list and stale receive flags until some unrelated change
happens to raise the flag again.

Set the flag again on failure so the next service task pass retries, and
rate limit the warning now that it can repeat.

Fixes: cee8d21d8091 ("fbnic: Push local unicast MAC addresses to FW to populate TCAMs")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index 0be71e6fd3d4..d69c91066508 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -345,9 +345,14 @@ void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
 	if (test_and_clear_bit(FBNIC_FW_CAP_F_BMC_MACDA_SYNC,
 			       &fbd->fw_cap.state)) {
 		err = fbnic_fw_xmit_rpc_macda_sync(fbd);
-		if (err)
-			dev_warn(fbd->dev,
-				 "Writing MACDA table to FW failed, err: %d\n", err);
+		if (err) {
+			dev_warn_ratelimited(fbd->dev,
+					     "Writing MACDA table to FW failed, err: %d\n",
+					     err);
+			/* Leave FW to be synced on the next pass */
+			set_bit(FBNIC_FW_CAP_F_BMC_MACDA_SYNC,
+				&fbd->fw_cap.state);
+		}
 	}
 
 	netdev_unlock(fbd->netdev);


