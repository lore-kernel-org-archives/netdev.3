Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEB83CB565
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546048; cv=none; b=jgPN/8u/P2GmL0iH5ZHsN1No4nFM0sg2ngfTfnQwCvFGJcf/8dICHufOXw71jdbp/pcs6xhWX6Xp41aV3rhw7/oMGQQ4S1pQkCbep0htDoLYoQ0iZoVK2mgpPRBNDrqIVaZoTyq9qPxqaVFRTvvt9PNoyljkbq/PzttvS2ujO+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546048; c=relaxed/simple;
	bh=s1Qf6zVi8UhwTlovQ06Go/fkv9HRKtX4+5qnTRUsQ7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJn+SllLEXwuCeEOJwox9XXetTtjSTWA8NoWS9anJQ21rtE5kIT9L+s5aND1jEL2qczJkGKB4E27xY1GhLkF9fyyRVGKAMWwndnzSmY8GwaH3DNj/CZn86jBwsVa/ZKPd0ib2yDb+ogN7tgIizYpHOB68LyWJzDobB6sZkvZBbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZB9v5GH6; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZB9v5GH6"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso26432385e9.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 14:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546043; x=1791150843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p8iktBbgnmQg52LPBJr5bT0zIG6cybwQ3bD7gV4BQmY=;
        b=ZB9v5GH6DwoWGP+y4sCieDvJkpLxpvB1sSxndPFJUu5rac2FHkgrEEpnGM5y5zZ8G/
         7uuj2e6/pEFvN7Mj544BeEDTM1BrBbWWjtTFrrO3olhsPAx71V60bY2tDCU5Lhbrwxgj
         +WAv01bZw8dL4/QxdY4Cpcyd3e+TwURekPRNuyeIo7NA8U7fYi+4xOUWVZV7O2aUJ36p
         IOloQYtF/NZzsoFg5kJ+X+BePxMqd2DO3JAspN05CnZKZpsOH2N0pN+yOc9trF75xbzD
         OooaDzv1L4UlozOC/4xqitfB8wUa2+15/J/duIAIcghBhMqWX05KBxTcMFnEzxymlMW0
         h+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546043; x=1791150843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p8iktBbgnmQg52LPBJr5bT0zIG6cybwQ3bD7gV4BQmY=;
        b=EmMpblty9xKCcdHcQK91AHvQ/BWmlQEhIoDwotrRZWFEFdf0zl5lkvqqWDslsBaKc9
         EOcDUJoE18t5reO7WuARsUOGEOL3raJPq6EXZUxz+BIZQoz3wSrVXssf0Pcu0eMT3pyw
         74GE5bBq+sPyhhK3BR8+PDjT8FhB9Bx2o6nYhFmRV8D7Op/dPLQIdMa0OZgl/pmyyJdp
         qBqN23omcPdmFg1RG5q3Qd0vBOYH4NGDDphxhBB0Y9dJnVLetvkOjYJTOkzXkUaoBEkk
         KTK2gbdMoQD8/gb3/rwRxtLZUa458wbv/2Knv9aAeStItKLvMFN/i+huTo57REtu/gLC
         cMXg==
X-Gm-Message-State: AFuF++kHgCNVLLNNAvlONmw7P/UZTyJYq4NEUtF7K6hRrfXhiDJTzo+r
	OBeBqNGJY7zqASfrMDkndNqqzW9Kr7ZSCZKjl3o+WG9cxEn9IDMLhHJX4Ngyt6lgW9k=
X-Gm-Gg: AYBFou3F65aHUK4026qMKvLXuK4V5raDOGvPLDrSfI9/85Ydzx7ozbRiUNVHuVC66mE
	KLYmRFsRXDMhtvi4hz5YMNEMCfMEQaTh+pRq2pwEH3ZclKjl79mtT20CAq0LcmBsqSCbzOMnvMu
	HE2It0F2rIAwsn6XfVT9ZATn8+aD7iKRHbXowkgi3LzqdEXZ0DITIoDAMScofv0BSguXnPpScL1
	pT575D1n1IkPQZDEDzoeMhHEjGPEVHXwU8UPm7AlbnlfWFwZ1k09SdqVzLXlFdsxt4DQU63t9sY
	xFIMjT0GJRGF0hJeFLXUHm3/9ndGO/q8lxVl3CSGRZDwTwM6ZRVTl23PLHeWn8S3AJqM1+ODdpi
	2ips83wJQAwBE0aqlnvCmNz+V3xv+ybVwMT1kg4SmqGht+lNirmf5upapCVrM/yWTyIRmusNEKs
	mDmF252bQ+uAwntmeRsrGMnYOjbrLqEZLXQgs38tdYz9RiMMWBgx4zF3zuZHdY8ZhOrpUEJ046F
	g==
X-Received: by 2002:a05:600c:8b2f:b0:49f:ff09:3b26 with SMTP id 5b1f17b1804b1-49fff093cfdmr58137705e9.6.1790546043380;
        Sun, 27 Sep 2026 14:54:03 -0700 (PDT)
Received: from kali ([169.224.126.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001922102sm89556865e9.15.2026.09.27.14.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 14:54:02 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	razor@blackwall.org,
	roopa@nvidia.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ali Firas <alishmery18@gmail.com>
Subject: [PATCH net-next v3 4/6] vxlan: vnifilter: clamp the dumped VNI range to the request limit
Date: Mon, 28 Sep 2026 00:52:07 +0300
Message-ID: <20260927215209.2581830-5-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927215209.2581830-1-alishmery18@gmail.com>
References: <20260927215209.2581830-1-alishmery18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxlan_vnifilter_dump_dev() coalesces a contiguous run of VNIs sharing a
remote into one VXLAN_VNIFILTER_ENTRY with no upper bound on the span. A
device may hold the whole 24-bit space, populated by several requests,
and dump it as a single entry START..END. Now that a single request is
bounded to VXLAN_VNI_FILTER_MSG_MAX VNIs, replaying such an entry in one
RTM_NEWTUNNEL is rejected: the kernel emits an entry it will not read
back, so a dump/replay of a device's VNI configuration fails.

Clamp a merged run to VXLAN_VNI_FILTER_MSG_MAX VNIs so every entry the
dump produces is one the input path accepts. The run is broken in the
merge condition, by ending it once it reaches the limit even when the
next VNI is contiguous and shares the remote; the two representations
then agree on the same bound.

Resume across netlink message boundaries is unchanged. cb->args[1]
counts the VNI nodes already dumped and is advanced only when a
completed entry is written; a run is still a gapless block, so its node
count equals vnirange() + 1 as before, and the clamp only moves where a
run ends. A device with more contiguous VNIs than fit in one skb still
resumes correctly, now split into limit-sized entries rather than one.

Assisted-by: LLM
Signed-off-by: Ali Firas <alishmery18@gmail.com>
---

Notes:
    v3: new patch. Clamp the dumped run to the request limit so its output replays.

 drivers/net/vxlan/vxlan_vnifilter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 13f4e115701a..92ea1fc94f45 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -382,6 +382,7 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
 			continue;
 		}
 		if (!dump_stats && vnirange(vend, v) == 1 &&
+		    vnirange(vbegin, v) < VXLAN_VNI_FILTER_MSG_MAX &&
 		    vxlan_addr_equal(&v->remote_ip, &vend->remote_ip)) {
 			goto update_end;
 		} else {
-- 
2.53.0

