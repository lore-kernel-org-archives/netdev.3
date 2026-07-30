Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF00399361
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442315; cv=none; b=IXMYysNqlg9yZ8Rc6AXq4WZYMvfPiHeWkhyW/jzbxN6HdPlyvA2vsmMIX+Z2NO7K1fZaT2o64mSM2Y1wGZIfsSuqYNd+DPZBZOLDFiY7qvVWIsrtIG/RjvdZWPF1e9tAa/NDC9lon8fXibkUHhsP0ZVSX6BPHt7tTF2YxwKeHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442315; c=relaxed/simple;
	bh=82dBttW5BbKeJKJs/OF80tfwpM2MddI/t/zJLyO/za8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P4tw35IkKTB19P3oF4QAuRgiogaLO8dPE6FY51SjqTtHRHyf82aX0NBrVqWOQAjFljVtIyuH2Hxa5P6jzFTlwH6irmGwyBM+CieQa/bMH2C7S4qFXj0gyk2IZeRcdxilP1OuUMdaCPBEGo/bg7o4kIdCUeSzfSn5btYw64GFhPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkLoGcDB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkLoGcDB"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8484f229529so279873b3a.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 13:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785442299; x=1786047099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1cRzxCLmJh01GBR+ktuxuJ/o0iMR1lZqgXW5wBf6dg0=;
        b=HkLoGcDB3WBibfwJOqTSPhktaOR12tYrn1Z2YDjlIijtIW0jt/y84TTd58TwPijLB+
         su9HlquHfO6asdTGrNx6RH1XttqGkuWS4CVnYGMh3bnUB05Td0l/0sdQnJXCkaWl1yCc
         SDd9D08//3ifMA2WRmm/p3MOQb+kLLDCQcQe5hwpDor0zCtwL2yd4I84GYPLMpem4kuF
         HKOwvVo2Ig21oxAwDDGOaWOW6f8sFMco0vOERzbo/HhcwK+6RIW/EXwkrGXj4/v7+SON
         ZNb9Iq+WCDHIVknVzZNrQdnTdfmT4y2eSU5YdBjiJjeN+KNtKNmhIK3jmQfF8mYxEXo1
         5sjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785442299; x=1786047099;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1cRzxCLmJh01GBR+ktuxuJ/o0iMR1lZqgXW5wBf6dg0=;
        b=DNzN7wonIBVTAY1jjRbztRfRpcr8LR2f0TzgXACZPrXhp5wn0eTyq1Jdq1a8GzpIgX
         KUO+25Cr23qaFUAxpD4feitGkBV2Pj5cRRtt9maELctbWCxv+GA1RjjTNYyc0vrxJ7tJ
         Z5/iwPp5GWfuCAMTwaA1FdCH5S+iq9ayOW541254omzMd0cLNVcYV4mM7LBiVzIT6DEX
         l5EiVX6FgHeCzUTR7nVcVUy2MvPyml08upMJWW8/2PZZXk5cRjOSxAHqCqBaPbt5Pek/
         BUiMaDir1pIUWX6cc7BJneD8gFNwEbvzIRZYf4UoyOfpPmOvKThFXeEyXt0bLbZJJOzo
         IGnQ==
X-Forwarded-Encrypted: i=1; AHgh+RptydeEDpmwLHvwxDfD4Bc4BCSJL+ELl6/1ek9l7U9GgKKb1MFgr9i8oJN7knP+p9dIZNrxD7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlY/m1TycQ8Dixm6i+ELWvZKtRiJGR41OERlHiQ1oEGq+JmvQy
	/6uOkNwgC8DJ8CyWm8VC4d8YRK9orPgv7xxAQ9d//SfgYcetWyR0nH5g
X-Gm-Gg: AR+sD10kJaObb1oCQhIiubguZ/LpANwG2O0T0VAOP0fkWKUSZ5nQsPNHcTkBCg9lylm
	OF7AGaji7PxYEaSDixd7dZHLTeA9hN+ZdgVnkpkzjyiVCnBTNmMQgCMrlorF36wPz9BPICN8xR3
	8M42FiB5QBpUuEp/n0DfiNew9BC06p0dWSk2KTNSfyTki0EoKM529+qGufaqJPcPf6/HTCwWmhe
	W4W82J3wubQ33OT6iWuzVsz0xoP1RuwwyYaxfNDtRrtZHKig2wSmLrUJLPnE/DiPDFk2nZhYnWv
	nwUAXa/N4U2BS21OD1Kf14WUW1V2l2JI1Vta7VaKppSzSU+BP61ecvmlY1xZlzqvQptbWPwOWK3
	U32wxCCYIBatoqnVqIZT8hiQyNLkUDoHAOwoUfOyA7SZjQF7S/TSKcbIQxmeSNlR5eu0KKRTvWT
	w5TNAeY5mfPMuIczrk8bt0iTsyAl3W9kxlBO2nrk3xkRfoHWsjmUtqi7kJQSxlSB+NWL9eENruH
	miE4Bw9NiCnWvjIh4bibUncM/FrAbtD6EHULvJc+iE=
X-Received: by 2002:aa7:88c7:0:b0:848:760e:eb76 with SMTP id d2e1a72fcca58-84ebc432c34mr3475574b3a.61.1785442298760;
        Thu, 30 Jul 2026 13:11:38 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055325sm3689108b3a.15.2026.07.30.13.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:11:37 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	daniel.lezcano@kernel.org,
	ssengar@linux.microsoft.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	sgarzare@redhat.com,
	horms@kernel.org
Cc: x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [RESEND PATCH net-next 2/6] hv_sock: Remove check for old Hyper-V hosts
Date: Thu, 30 Jul 2026 13:11:19 -0700
Message-Id: <20260730201123.1767-3-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260730201123.1767-1-mhklinux@outlook.com>
References: <20260730201123.1767-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the overall removal of Linux support for running on Hyper-V
hosts earlier than WS2016 and Windows 10, the check for such versions
during hv_sock initialization is no longer necessary. Remove the
check.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 net/vmw_vsock/hyperv_transport.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 5405c2680dec..855b15971c35 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -961,9 +961,6 @@ static int __init hvs_init(void)
 {
 	int ret;
 
-	if (vmbus_proto_version < VERSION_WIN10)
-		return -ENODEV;
-
 	ret = vmbus_driver_register(&hvs_drv);
 	if (ret != 0)
 		return ret;
-- 
2.25.1

