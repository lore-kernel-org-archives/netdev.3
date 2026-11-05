Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917269;
	b=aABvNkN7GKbtCZUoq7rAPsCB2De5mKHLu7zO3+7veY/3wetQlFW3fzzO3w41Ej9lrIgD
	 HjOyPSdrq9DgXJgwBguAZ66nqTEL5u9rfiukZmjsGNO+nWKhtyNKgCYkqrM2q6dWTSINO
	 LfMwN7QqSU3THiOQgXn6rtIWFOyw88eGE4jy7XvP+SB+klKZfJ7TJlsx6RiV8TBvlvZPP
	 9IQUeKPJncAtbOmVMV58cPtWgFeZJXROnM21fzi1Krft2obJaOpnkb9iJ5oI0iMqTN8qy
	 pAWm5qsVLKZVX8uQD+xFOHYwTNKlLsKq1kvDerGqhaXC0rXRaY7U32F5xdeerXck9yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4db2AlEwBuJ3NhUvd6DttANYOsA8cpC5/Z0gBUqIqT0=;
	b=mgIowVVkTz/M/bSq4tuaJ5W12noGWnuBMk/FwEUIz20Jx0KiQYbmwoxpdrvN3O86+EJY
	 RwK5uBXlxIn4YQz6v+dfxcoCnNTIrYwqCMmWHFiqwsJVA4XKIlXdhYgQzXAh3r83nR3ZS
	 SjgRpKGKGp4F3MeYxtBhoeSd5TUF/+QKLJ3AtiZwHeA75XlwXBKuXhiEU1U95V8fWRrtf
	 C5vbZcpLUyfaGxDJ9T1Z6l83kjk5xSX2v4uZM910a4ELO0j5IypNX4cVO3YIifMyxiHQM
	 me5b+gzNsV+zpIF69/PPSuuYYSS3ta7Gf1fByFMbIsVXbYbp+h2sOrYIkChxfMCIS0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZrlqBW95;
	arc=none smtp.remote-ip=74.125.229.135
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D4E606EE80
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 22:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9D4E606EE80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZrlqBW95
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-14345ae29c5so51668c88.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 14:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917268; x=1794522068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4db2AlEwBuJ3NhUvd6DttANYOsA8cpC5/Z0gBUqIqT0=;
        b=ZrlqBW957FVRSJmhWtYT2LZ20iLqM9RUGB7Z0X1CqCOXFP0vE1Q7C6Q2nXJgpBFRq4
         Y0uMg2XCt+yCfud4FgOvOKF0JHJPs0lVYLnGJQ4jcxxF70pQppH8nnLD50s6trUzqKW9
         HGpBPaeom520SaQnpAAKksjsd0wAIXkDsU+aD/KgENAMz/PYFf5jq4jUvqCBiJJpoqLG
         v+bH1XZdZ6WrabNwkAW+3z+BeWR94LS0RIHFvavciURbGe8OriTuxF/R+Rx58PPkE5Js
         VeLlpHVqQwrZGLRVasQ9dARnv4xZUCKPjgg+Sgd9mEmFSk4Osvn6arU4uu75Bok6gbqw
         aZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917268; x=1794522068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4db2AlEwBuJ3NhUvd6DttANYOsA8cpC5/Z0gBUqIqT0=;
        b=rPcBgaN0ztM26dM9LjSCRc+llHGIWyDDd2OvBkCg6dzfSiF1CpxukCQ+yBVt4tPImG
         WJog6MCpaYIFkJquuPXVzKulJk7GHV3x5i0fzSdZS5WnHwocuv9WtvZ1LQviCAkZh9IE
         jjIDWJ6QwZeNDjALyLWPvwHm+EZbmQdZRZM1FytaXJwer+zxVZH0E81Pd+2CeP2iMlw3
         PnItziBQhkoDV1z+AXE9Vmxm40K0PfgBkO012yFk2C1/Y+mEntbYHWm80tv607fDXcZM
         XWjNnBEGMz5SGZFvgX0Klz6bcX/YscN7rs8JWvee9vLB1mZ/c1zTtcm32T1kuRtfRpkm
         17Jw==
X-Gm-Message-State: APuU4Z8x0/5rWlCQfU+qs3UetkDepPF8IR7WPwYexsXlbLK8GbPdDfg9
	iHMlW86XpbELQRblhPpQhMjqlE4huknCN1RhJwRSnG/5Q/g6QcMLLK2nepwPurjHEXY=
X-Gm-Gg: AYBFou1wxHa20uBCGToHtxcnhlhH/5DVRNLBxvm7Sp/C79KaAFQDKpAyho9pjLFra41
	UbhryQmLAP8t66VfIALhAwDT26c2fV8S7V+e4s/Ve/CaFtilDHQiapZKv3yRYk5wj288MB9PNYJ
	yNiOFUcUA29qYFgAaXGtr6x1rpB6OVLcq+oWjzjkISKERZF8mZWAnsZ2bK8THuHvWOvMJzR7t6f
	AhyyKRkqUAWXs8SGyad7HU+DJcZ4ysg9mlQ6otNGbg+IBVyGSardQ8u64cHcE0GVMaa2RgmrKyk
	ApE4kXOx0gRmZfG/R0gLK1sPmIpqDbAjYo7CANUnsq3Uh/DnfmwpJquPC5YxiFm32WBhPQay3tc
	RL7aNhzENXte1pT6oiKxFh3ITz/EOzzurqiWfpuF3FV1H5ERA0bU1lA8U1jgvikqpzYGjwPkfIA
	xXo1AbilRE0h1dhKSTPw7qNu23ahQ5dOyvfz0HzQA/UAH6An4ppeLjZiGoE0TrIJ0VCFWoErONy
	Mz3Ai4qvXCRwyeNkFHdjMeSwbPVDbPkmsaSs/upyrd7MflAAeiiIvhD+fdteKG8rMA4O9Qs7hre
	fZ2KxZWdIZGBPw1HWI+lBWs=
X-Received: by 2002:a05:701b:4590:10b0:149:1feb:6d9d with SMTP id a92af1059eb24-1b25d31efafmr453115c88.19.1793917267847;
        Thu, 05 Nov 2026 14:21:07 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6a::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c6f0dcsm26931436c88.21.2026.11.05.14.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:21:07 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	edumazet@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	sdf@fomichev.me,
	dimitri.daskalakis1@gmail.com,
	almasrymina@google.com,
	dtatulea@nvidia.com,
	bobbyeshleman@meta.com,
	asml.silence@gmail.com,
	daniel@iogearbox.net,
	razor@blackwall.org,
	leitao@debian.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v3 6/9] eth: fbnic: set the netmem TX frag size limit to 32KB
Date: Thu,  5 Nov 2026 14:20:55 -0800
Message-ID: <20261105222058.944293-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105222058.944293-1-sdf@fomichev.me>
References: <20261105222058.944293-1-sdf@fomichev.me>
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

The TX descriptor length field (FBNIC_TWD_LEN_MASK) is 16 bits wide.
Set the netmem TX frag size limit to the largest power of 2 which fits,
like bnxt. With 64K pages this also lowers the PAGE_SIZE default, whose
64KB frags don't fit the length field.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 8a6703afca38..0a2b66202aec 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -760,6 +760,7 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->stat_ops = &fbnic_stat_ops;
 	netdev->queue_mgmt_ops = &fbnic_queue_mgmt_ops;
 	netdev->netmem_tx = NETMEM_TX_DMA;
+	netdev->netmem_tx_max_frag_size = SZ_32K;
 
 	fbnic_set_ethtool_ops(netdev);
 
-- 
2.53.0-Meta

