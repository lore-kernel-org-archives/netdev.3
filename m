Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36974CA77A
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448572; cv=none; b=qd/n2yTzb2IeKzUCl57fFcx31QOW6A5Gk2GZ837ZEH5WnnZ46BNT6Xb9Ki0w+pmqR4j1NmBTxBAVmRkUQZV9vX24xNZlpFY348Fcvx8UGkAKtfVn3+sfua/xwFDQ/0akCYeXKOAb7P3/yiUgjPhBuX626p8gwINsiTmuYfTJSGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448572; c=relaxed/simple;
	bh=PzECq9Nkm6b3bxsxN6/LxBcAb33HZbdJHHOmu1wRy7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCuBseEkHVpa1viGT1wfGzzef3iUAVH7nABnjPS8NBJ6w5OHcWo3KZPsxepTfwCDkDjdwUWJMOuCknoewCdFv8AirL/kz+77N3FOIMKMP9Sg59Qp+Sm3nUW0YIKJ4cuoedWUfLKBFknfJFpztAGS8WNnd4ov5YBdGCrCdz5FNUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REK6RZDA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REK6RZDA"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso19315345e9.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 08:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788448569; x=1789053369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PzECq9Nkm6b3bxsxN6/LxBcAb33HZbdJHHOmu1wRy7I=;
        b=REK6RZDAVZkz6HYZjjPpi2FiqQpiwH+t5kb8P3hR3/rRD6i5ElX+jV0haZOe4PQsKU
         F+GuTCJsWlkRF+fAUOHDGMefeTLHE+hmdCHN8XgjH4DjLDU+xWA639wLMma345BHK/hM
         EPgNdPoALVMy9yEm2NafJ+Jj2k4/GevHIYwIXWgTLs6U1q6pJxJdjLk2AcC1I4KUHoGy
         lqWlPDMq2NQlQ3TafWGveizPtRJjCw9RY5dbsL8QFOKNLUhSt1535AsetKvvCVn2pI8i
         /mbngmXHnEd92dLPlV3ZC1Hk6fv91+jlfIQfpGsvBNmAFw4w9l/tnHxqmiU2rVsvgYoh
         HtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448569; x=1789053369;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzECq9Nkm6b3bxsxN6/LxBcAb33HZbdJHHOmu1wRy7I=;
        b=UOKiCarVXIX6doYUjapdlEm1mlYajF/3SyhFF4mcm87qFag1FAUuLqUIlDl9c31N/3
         BKk3A/yEyYkDuiIWVWtL6b4IlnQQ0l8v0MxAJC2VRNh6E79i/Kfb0KPtIGoYNpNqw/yc
         37MLJz0Oy875BWvOWMuF4qEzyR7A7eBlDEuZ3229MqD0zv3nRUAi3De5VPRelspk6e2l
         APla3OVwJEVEV8kyTyvOdaG6w1zUXEjkOvNQsbSybb0ARbT37COdKSiM7GR5FilupqEN
         8PVP8nCqoYPNCae3OSXI8IRtPHhCvm+p2SLAdNOMd5Z2kb/lgXeVbYhGSRJYfGj4ksa9
         aj7w==
X-Forwarded-Encrypted: i=1; AKwUvBzahtwt0PdgxuCp1Ahc9/mfu4CoFGbrnVjfSKkkdtAOhSAi4fJVgp+O1MQYIQrehNU3Rkt20WA=@vger.kernel.org
X-Gm-Message-State: AFuF++mV71SfVQRIjxSvoXRR95RJD63c7nxN/qGzq0606sTyjS7hmDbL
	1JM25wfebu3VYlUkwZNEIp8oQWWIr7GItd6WJ7R1GT4B+fJYJbDQ5tEF/H6HxhN57a4=
X-Gm-Gg: AYBFou3d5oL363Hx/7XUN+tr5PuEZQetXOx1tOa4ezCAik2sUv5S1B8QpnWjkhpDWWX
	mLcExUnlXIs0e/syj6TinVbE/2nyvFHfghMuodiicn+FT+unyxGDOaL2VY771e54Z8nij8r5rAp
	9O2A6UG41kvooEm2Zz5h5wpFfYqxoYofBEG1sOdpsFvZH/183Z7WNRXvfiCeadhER+I/040C2Z9
	+88CeSjiGHLMWU44C/569Wjn6NPPOSB0Q7B4P1AEvzI6FqZG5LW0EPyU42Eh1ZKaFYec4gE/kF2
	vXI1DfzVa9qMxGrJFKplvuHMrqUUXDPvGFbnfqIbkw1UomdjntcO7YL4xTXKv5auK8+0d7SIYQy
	si3RvMWngWQ0hc7eGX4WTINNQIwiAgimj6prEP5KQL9nakV8NeJtrSnP+Ry4fryvyyR14shLCyF
	rshuGfda+kVH9QnC/ZS3Nqz86Wcl33X7A5uUvCE42epN8xTBkNIfslcBNzS0S3xveSWnEE
X-Received: by 2002:a05:600c:6383:b0:49c:dc14:d681 with SMTP id 5b1f17b1804b1-49cf5bb8040mr16748105e9.3.1788448568466;
        Thu, 03 Sep 2026 08:16:08 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm77097075e9.15.2026.09.03.08.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:16:08 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	kvalo@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: cfg80211: avoid holding rtnl_mutex across all cfg80211_leave() calls 
Date: Thu,  3 Sep 2026 18:13:10 +0300
Message-ID: <20260903151542.486376-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903111705.472491-1-omermetekaya0@gmail.com>
References: <20260903111705.472491-1-omermetekaya0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Apologies for the noise — I forgot to mark the previous send as v2.
This is v2 of the patch, extending the fix to cover two additional
hung task reports (tun_chr_close and switchdev_deferred_process_work)
that share the same root cause.

Changes in v2:
- Added Reported-by/Closes for tun_chr_close (b0ae8f1a)
- Added Reported-by/Closes for switchdev_deferred_process_work (d6bbe0f5)
- Added linux-kernel@vger.kernel.org to CC
- Updated "three separate" to "five separate" in commit message

In-Reply-To: <20260903111705.472491-1-omermetekaya0@gmail.com>

