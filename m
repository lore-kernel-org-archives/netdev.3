Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223429;
	b=UPL6cX6XPq5kVNCZr/61S1O7+O49wc6Ilmg/hRLgZWHhqTBtneb2kSj/e2MI6W8csXvm
	 n16FhI/e3/v0Ataf0cJ+TiyWNTHUdPyVfHZdSrMSJGOrBlqrNtDqOPS2M17BHeEseqfsX
	 4yG+VHUF5yVSOJq4SZu+xMUFEeJr2xj2UtxMZOzRix31u4Af8rUfVeCV0nLEe9Ei3ruAs
	 45UWRNuf+bkcxZ0aSa4mkRbo8RiaksxhkHMT7gdwNEDAbemidhmNavohy/gB3d63AEXXl
	 lIKauXPwMZe4mWczcFTKKL5iJ/fo4xm6g7N/riuEKc2Urihi1LJ1QTIH55EqtYkYR1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=XsKh+IBmqL57fT0Y3zvcZihRqD402sqZl9F7kg3Epl8=;
	b=zl3PuPTPDd4Ll0lmE0WbUyAtR9ik6zISj2oVh1bg5xU40BVoMRBirqGZByUQ6i8P+JEB
	 VIPMmVuVCz+4vaLTO3s7XveS3ILCZLBdfzPmd9GGwZmn/7S+HBNF9Mzj5hQh0chdVXRWW
	 wq7p8aLS/INDtKV/B55fepBFcdD0jKX0HBebl+saIVZAzDLecTvKXr+2ySuS5uKGmH7Dh
	 OTYD5uexNdGDjx4biI8CR7RLXIYO6i3U20h5euVFAhJa/ywW/K0NtEqN/xWnaS/w5Y57x
	 vUwJhc3cRksEXuuxWJJE8nPmvPQCe/OIOgJBp6Gbr9X09gvT2YxqCZKbAwXxV+kssYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ql4Q7IQq;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9DB606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C9DB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ql4Q7IQq
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so790763a91.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793223429; x=1793828229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XsKh+IBmqL57fT0Y3zvcZihRqD402sqZl9F7kg3Epl8=;
        b=ql4Q7IQq6wI2iw0R3CiC1mZcE3qI+hfh2RBQCaXZhj77+aLubBlrQniimXRjw9pn1P
         2Pm0oSjicofll6bX6ZPF+Qnsx5FsfCAWRo4wGQPErKwyEzIkgyemtcb0+3xiIZhDNx7l
         x6mIpB1xarpT/5Go44fIUODECypL3CknwBv3HiMRnLbeyEx4i1aVoqLYW4bb8WsCPPoj
         1j/vHFw4JU74Xh5HA7b6kNndojhk3UhfqxmfVmNdJtfRxxNWet4TnXKe3irEC9W+GQ4G
         WLqWdXynDBAsfMveHQyJRIeSQ1wGrksaDEVyWoEJXoMiviEgWPtgLzO1oQ4ZhtMs/PDa
         j8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223429; x=1793828229;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XsKh+IBmqL57fT0Y3zvcZihRqD402sqZl9F7kg3Epl8=;
        b=Dew5p16f6DHeUdT/1AYlJnP0IukWyI2mOjeEROcvd52uBXKEnzVs4j7aVsmKi9QfYg
         W/xA2s7zfmVICvCl8XENDKHmx/6iwxSfs+BntI8LO8RK0U/8dFMxW1/FfYBqIwtPquGD
         kYDv30qCyiyh4lHHpa1O1QOmMO1qCNtDO+xwVJsMfsZxX5IHgwRVIE14EUQ3a0s+8+W2
         ckcefVyKTGmXhB2nrq4DylHOZ5wfzoHzCint2EoYCCKxJhbsLYXs1vJdeYbOWyXLxusH
         5aqWDNkisXOxvzZl0ukxgytD/aKElaNRMQPjHwOc7WqH92sfoZA2IeShB/UKSs7/drAZ
         5NTg==
X-Gm-Message-State: AFq9FYLJEO/G3WsAIMYEPkIakEdZBN5FadDmCWBxi53ounN5iivCCI1g
	FS4MRGS4FsLsGkslKl+lmHutBsmnOLGj0Q0nbKvKEmVOm1hok2N27rVr
X-Gm-Gg: AYBFou3sfR2n1ZhpuiCPB52SKHhm33dEoS0oms93vN7ohLvMIW8qk9wfpF9HSQgdvVq
	5UqexmSkAhi0lwvvEGGzfCbgI9rDph8HUJFRb8ZcJAuoRFlOw8LT8P2tqENe6oCGFh3z7LVFUUK
	4KPqGA9L1x5HAtjWF1jqOPPCDPQmGecEqM7kb1LH5+Zvl5yHlMIhSOMZCiQEemqnkwGcsaKttWw
	MYtH4H9ht59mgQG3Iq8HZpQ7A1SBYf9qVAkl6XmV/uuYB+V2B4D4DFk1mzMUMLSLGbLNrYxSnTA
	Dir+uBvmiMMscLrAD7JW59ddwKSw8wAhN3jmx7c7QSOAF8BJZ9a2f0vdm8CAhFzVs1f7N96nR+r
	JEfjzCyuZ42BjR4OjY+QR9ZgT3zz9fPZIDPomWiBSXJ2tUMmjJOgeMr+Rl2/ljf88j/Tajf7xXg
	1Juuo0n7rs4vepBDiy93RG9mIfb2QVi8w1v2XIG7YlIIStx1h0X9yuaXXyztH3NuZz6kYUdYDI+
	Zb3kjbL89ncBdaenEBCKDvnhAa4AIV2o8mtCmsVx/SESYu3K/mvBuNntuQbXkbT3rQhe6h6OyoL
	SHg+1J6gsffcz2aBhjzzTfiwDieDh21a+QfHJATAGlB6TFDcGWFbb0DiM19849uYeqC/BFWdDmB
	Lp22x5sv/NCStmx4ZRVNQLCDQC4lp0W38NU+NIs1r14IOPZ6YSDxrJNyf1KyC8XT4DU8=
X-Received: by 2002:a17:90b:5345:b0:3ac:a7ee:6780 with SMTP id 98e67ed59e1d1-3ae58316552mr2782764a91.66.1793223428639;
        Wed, 28 Oct 2026 14:37:08 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e2a703esm1118023a91.0.2026.10.28.14.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:37:07 -0700 (PDT)
Subject: [net PATCH 09/13] fbnic: Drop the unused active_slot field from the
 FW capabilities
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 28 Oct 2026 14:37:06 -0700
Message-ID: 
 <179322342666.40667.1273433939886172442.stgit@ahduyck-xeon-server.home.arpa>
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

The fbnic_fw_parse_cap_resp function stores
FBNIC_FW_CAP_RESP_ACTIVE_FW_SLOT in fw_cap.active_slot, and nothing has
ever read it back. Drop the field and the store as it is just a waste of
space.

Keep the attribute in the capabilities response index. The parser
rejects an attribute it has no index entry for if firmware marks it
cannot_ignore, so removing the entry could make it refuse the whole
response.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c |    2 --
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h |    1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index bcbeb0814b82..7964ce814b8e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -725,8 +725,6 @@ static int fbnic_fw_parse_cap_resp(void *opaque, struct fbnic_tlv_msg **results)
 		    fbd->fw_cap.stored.undi.commit,
 		    FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE);
 
-	fbd->fw_cap.active_slot =
-		fta_get_uint(results, FBNIC_FW_CAP_RESP_ACTIVE_FW_SLOT);
 	fbd->fw_cap.link_speed =
 		fta_get_uint(results, FBNIC_FW_CAP_RESP_FW_LINK_SPEED);
 	fbd->fw_cap.link_fec =
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index f47669129c9d..7790ea0badea 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -67,7 +67,6 @@ struct fbnic_fw_cap {
 	struct {
 		struct fbnic_fw_ver mgmt, bootloader, undi;
 	} stored;
-	u8	active_slot;
 	u8	bmc_mac_addr[4][ETH_ALEN];
 	u8	link_speed;
 	u8	link_fec;


