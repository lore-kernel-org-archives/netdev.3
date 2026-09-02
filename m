Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38A82F9DA1
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 04:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788321817; cv=none; b=eKI8oGNFUTQlUeBsAErcYFDgRDf1LKNhJgDUDVw8jPbITHLwPZegGWgTsGaNKQosWDAUXMxGeDFoz+USB1l78OmxuiLdRCQMBBkL9s0gvy7cKARQ+ftqiDpLb48A0ZZkVYupkrhWSlWv23lVV3DDVPe1tI/FRbbyl2Xz2azxvDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788321817; c=relaxed/simple;
	bh=H82uNs05rcQXiusDpxHLDjWxrLTVCIzBWcYLtZSsnyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdzYHeICTpSdJ92Y5MhTgezIrRqdd1qXpQ1xjCsUfW5pMjydw1ZgXiusXZ5K7OpPMHRtSHOBy993OXg0I59QdnDYVWygwzkREQvp2pfcDxPUWMAEJlwn9uVGTTz3BKhexb6RtLmH+rTlaKVI7stUcpB2rbJXKkZpuFRVRDN9Xio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHI8dRAN; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHI8dRAN"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2cf49dc298bso4153055ad.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 21:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788321816; x=1788926616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z732JAXycq9WRUoUJDAwDalT5so2OYem8jYiHVfL/3k=;
        b=VHI8dRANLux1r6d9cZzKLYL+/7ZXJjbYVOk/kzEgTYcORdHWp90axJA4GtH9w7QHNk
         F6GrSKXsGfUf6UGTCoQvI0ppuafaLYxCBNKOX3QAw1+U4jKubVcf/XJCoBmJufa9CJXi
         ZWWyZVgzjTvZUpgz/k4OOlf2RuZ3nUmCTBiy/+ueaAfSshC5hRGjfQ/dzWMFSKkuKKpx
         UN+v7ZL/iS5ysFPJYSYfVcz4B1OZPRI/Cn81wEfNBDz1Tss/yc1+5Aou/eVC9PfMJIf4
         I1QnlSkij+sxSw7SIYykg/duiQNWHPKCenG2mDoXSlduAojXyW7F2yooFXkREKZQ1908
         SesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788321816; x=1788926616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z732JAXycq9WRUoUJDAwDalT5so2OYem8jYiHVfL/3k=;
        b=j96BgRiO5FO0YWiyGk7URog4S2bFTZk5V9+sukLPjxBVPgXBGgPvFdJhGG2tVc4GDQ
         BYL3Ip5wqdMzYko/mzuyLNi48n6JiHliABEcZ0s6DlIvOxbfxMzaP2LOkQuUU4oxPubU
         R4I4L8nr5gaD6Us+5MuvxucHAznaVWKsfxbxNCEaBpN76NxoHxzM6DR39V5nDQYK0kpu
         TNbxgMcpvVD1Dp8Jl3lJREmm3gYfWkr/fxTZ1Pebp37eIS2sGjllJl5rEEJOEt71+KOl
         HRaAJSPll//scAiOP+kR3Eh7vEL7Jppq+7XEupEcJ1dO3VBHnSCEXxc4BdRAQod71ACa
         SJsQ==
X-Forwarded-Encrypted: i=1; AKwUvBxufFKnzYlJ8+ravgiSJHoat2/r5tgj7pFFzpSLYBOv0Du3G2m3WyC9hiYprkj27ZUXEZJWHow=@vger.kernel.org
X-Gm-Message-State: AFuF++m5LhWm5s5IbB7/OsOm/yH3gvX4IS32118QibVIQgw88tqT5y5g
	/KLp5KBupPWaF+dISidiKjTkQPnO3rr7iYaIpBQs8Igt3QMf+mVT2jOv
X-Gm-Gg: AYBFou2/E21+UZrQm7RmioKt56hADIC5Dm660fLc0TsCaCUrPLx2eSKGkXxd7/KsxiZ
	YBefnE1iQPhqrPfAjCvHga82BIHVRpAIZoDnMO60NY3EF9mlcquNCwpu1wP+n08b7NXxYiMXB1J
	tRLNUVqapEV+ZvF2rYJau7Qn5Pss9U1PjnbbUEJcmN/DMI2J5BXOcde/kN+o7NCfsWBkouywBze
	iRMPqm6xPapiMFV14Oy06RwPienCsRlT0UBF6Jf0uWaOr6GuPAh7jzLMYky5pwh0o6xJ7oNZAXP
	Ihnv+tbl1zfCL0++d5OAOwuXbLqjv0E9PavJvDLCKS7wH6AIYGZMlQqtIfO4jkQhLUQisV/wE7w
	Z9hPELN1lY5BmWzAZTaYQQ1hG44zQfTkri2fMqr41ZjN9fM0hfiUPDDMCaeTxPpktOYc+Kk2AoU
	tvKpJ2RYTmpYeOYVwHCf074tncZMMg8nz2m+ivfXeUzb/NKTDGNjgfloOtsw==
X-Received: by 2002:a17:902:ce84:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2daec43ee8fmr24850995ad.0.1788321815953;
        Tue, 01 Sep 2026 21:03:35 -0700 (PDT)
Received: from fedora ([59.172.176.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd4d5e8esm5930125ad.81.2026.09.01.21.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 21:03:35 -0700 (PDT)
From: XingWang Xiang <v3rdant.xiang@gmail.com>
To: mitch@sfgoth.com,
	3chas3@gmail.com,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	XingWang Xiang <v3rdant.xiang@gmail.com>
Subject: [PATCH net] atm: pppoatm: reject duplicate backend assignment
Date: Wed,  2 Sep 2026 13:03:20 +0900
Message-ID: <20260902040320.4007552-1-v3rdant.xiang@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pppoatm_assign_vcc() installs a backend without checking whether the VCC
already has one.

Calling ATM_SETBACKEND twice makes the second pppoatm_vcc save
pppoatm_push() as its lower push callback and overwrites the first
pppoatm_vcc in user_back. When the VCC is closed, the outer
pppoatm_push() clears user_back and invokes the saved pppoatm_push(),
which then dereferences the NULL user_back pointer.

Reject the assignment when user_back is already populated.
do_vcc_ioctl() holds ioctl_mutex while invoking backend handlers, so
concurrent backend assignments cannot race past this check.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: XingWang Xiang <v3rdant.xiang@gmail.com>
---
 net/atm/pppoatm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/atm/pppoatm.c b/net/atm/pppoatm.c
index 6da52d12d..93ba22f43 100644
--- a/net/atm/pppoatm.c
+++ b/net/atm/pppoatm.c
@@ -396,6 +396,8 @@ static int pppoatm_assign_vcc(struct atm_vcc *atmvcc, void __user *arg)
 	if (be.encaps != PPPOATM_ENCAPS_AUTODETECT &&
 	    be.encaps != PPPOATM_ENCAPS_VC && be.encaps != PPPOATM_ENCAPS_LLC)
 		return -EINVAL;
+	if (atmvcc->user_back)
+		return -EBUSY;
 	pvcc = kzalloc_obj(*pvcc);
 	if (pvcc == NULL)
 		return -ENOMEM;

base-commit: 70f3995830d3f1e79faa14eb0605914f778feca9
-- 
2.52.0

