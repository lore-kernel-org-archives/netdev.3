Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95625262FD0
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017232; cv=none; b=a+fh251Qzdnv6/MD7Rbysy6lfBwgJGm5EoDApmIdBqRQha7Tts0GXGBwUIvyRjzOa0jhcDnAFhIexc7eB2poyx6ROptkyzi1OByd0CkK6232om3dbIMmJHWHWhD/cbZu9Uj5iE/T+1lmVshwpVAInsQledoqHZ8x90qxy96FFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017232; c=relaxed/simple;
	bh=FLZ48c9+1s7tZ/mmPuqsNgafmCztujOo69MmQMPjPwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R0nflcqnD/aKF9IhED3aeRAmFqnlmQT8RP9iiu76k2EfDL2jy85QDTmF3gFEawdSO7gHzDqm8aNHcsz5gPhrgSpFni7H5d91mnmNG1wTbB9MFBGjifl927QFsPLFfwyb/DrtT79kmQbdzg5RKJp+t/RKl7VnQfEEp065Y9hsvC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuRX2ENE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuRX2ENE"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e7006bbf77so9512895ad.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 15:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792017231; x=1792622031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FLZ48c9+1s7tZ/mmPuqsNgafmCztujOo69MmQMPjPwg=;
        b=EuRX2ENE2AMf/VSodIpXkh2PJ/z89M3bnYMRGaQJ/pe8KIDG7GlhEAsmQWpvNDJbMF
         B116NqZaqFdvmRNl2Ov9nKqRu6axNnKpyi/OZPFOvSvblyf6BFSfBrAYDfxWoWFN/SjZ
         njZU/2MJqzBNOf5Hs2zP5LAhz5ETbhwtc6+sgdtQs2uV/pYPJlwqkJzChr6yEVV+xizn
         7IjWyjmiC5tSTXCMmRlpsCmS23zmXx8t+DNvnwP2Kt5LxFX2//kl8Y6lQdQfEv8cUjCx
         JITTaEt732MuZv+mw2slPgJYSDvCrd4Jn9xlQPqOJ+caFQlQDBsW/mOZH35GFRUe4t1z
         1XtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792017231; x=1792622031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FLZ48c9+1s7tZ/mmPuqsNgafmCztujOo69MmQMPjPwg=;
        b=dSPl/zhwM1jQtO+A8UaOG9wq1D9OtH73TZAJXPlhNVx93E1zfvhjgwoCuC5CKv4+7v
         nhRphtd9slst5Q3d56CjmzfMnxBaLO/cMOiG5mIwC+9R5UmQKmoCYW0LVR+A998ykAMf
         ngrBRcqoDfRYgmbG2BVIu5vkmgHtrpWPKDrgFSGOnbgtsitVphOKoNCcwZD9P/ntB/fo
         vOVWajM1Q8QNhkmyBoEUMF5BFZWsPWP3h4Kidy0xZThA8MrX2o7Re00pks1N46xvc07K
         CvdwqAfeOwS7DzPifv5vmA8QqiUVqSn4ZtKyhDrmEYcRiqlb9HsjKVRKMWiVJztRaU2O
         f0lA==
X-Gm-Message-State: AFq9FYKGu9Oxmn9HYg6Qga9YSsN3oFqyz0zfCh0Kh7I/6V9aKR3fMzoC
	Qwq6jmV7f+MHYB/O4tAjJfIHWQTQLn7hwohrS8gET2yBUAs6h7w5BIOy
X-Gm-Gg: AYBFou2f/CjVmNG41xpcQI6iSxSq5gPZNe23lXtW2eY0ArOR23DAiWlngWe+mqv3LD6
	I5RGI8auqGuc9wf5+4ipYvv3cQWfhaZFWEg+wSzOt98Frol+yEhPFd+UGxBhPcziy7puNnqXSzF
	JB+0rnOhcRT2I1V7TFugQCusbdk7slGTpunLYhj5KVQISoLuED67oJbYNulUIkmr/AjYXGpFtHF
	yLRaqPtaTgMcci5n7fir0Ijm9dXKkkCUr5WsBdJUJxTIAhe2QfyLwEJa4Z27UtHYPRLrCkT/80b
	QCv70okQx/sCF8WKvJD+8ksOJt+38BE1k7A1j/OOUoOPhIH5GwlMRs4+e9Kg5kFQcOKZing2a6U
	VIC/c1G4VTpktb/XTxYLVJbOWM0OnG9H0/tndk5lDBWdhTWVsW9h4qX2yUsIHBqKdTcO1I/7zbo
	cdvx+3g1vg7rDF0qACNkvKfO3JAsTABsmmjnToxT3FK54iajgR3irdJSlF79B3iemM2Or7R4B1r
	rICTg0iJhYqbCpvYluR/97fAHkc/pFNGBO2TklySc2Zq9XWA0tzf9nRnPXDCPZds1E7n52NLtlc
	8vbaVHiHsvSmyV9A9Nh6xfIXAEN483/eC+XsDsRsnRHVA+s=
X-Received: by 2002:a17:902:e892:b0:2e8:21ee:f196 with SMTP id d9443c01a7336-2e842bcd165mr144577625ad.29.1792017230726;
        Wed, 14 Oct 2026 15:33:50 -0700 (PDT)
Received: from u9dbb0cac493f51.ant.amazon.com ([50.35.61.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8c4csm74514005ad.56.2026.10.14.15.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:33:50 -0700 (PDT)
From: Carlos Fangmeier <carlos.fangmeier@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	Kurt Kanzenbach <kurt@linutronix.de>
Subject: Re: [PATCH] net: stmmac: prevent kernel panic during XDP program and XSK pool transitions
Date: Wed, 14 Oct 2026 15:26:28 -0700
Message-Id: <20261014222628.3206770-1-carlos.fangmeier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605-main-v1-1-aed15b1cf1af@gmail.com>
References: <20260605-main-v1-1-aed15b1cf1af@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jun 10 2026, Jakub Kicinski wrote:
> This still looks racy. Please look at other drivers

You were right. The intel drivers (ixgbe/i40e) disable the queue pair
as a unit around the pool swap rather than gating TX piecemeal, which
is the pattern my patch was missing.

Kurt Kanzenbach's series "net: stmmac: Fix XSK crashes on stm32mp2"
[1] takes that approach for the XSK pool enable/disable path and is
further along in review, so I'll drop this patch in favour of it.

[1] https://lore.kernel.org/netdev/20261013-stmmac_xsk_crashes-v3-0-50fca7790af2@linutronix.de/
