Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33C2BE033
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505927; cv=none; b=bpvtCZppJgCkWbWn/UxObJqqp00YvJPx9XN7njK5vB0LXSI5tk59bDCAEY3ok5R+HCGKg1tY4Sz+RCaGrJ7pmesVc/pIFbztMN1DjNUol4216oHLspT8pupmMJKPRFD6gOQNEyWBMpOAZXkIJlcdExXJRZdpouCVN2rP/Ozaa8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505927; c=relaxed/simple;
	bh=zdj9k7TJgiCnRnShmH+9w9H4vBvrzOYJWvCK6aaGOCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZalDCnx/MCC5u77DpdIE/oDc/jUt/69s0UNXVrd9BsULMPO799K4ahJjeJPE7C2O/DGTzFQ/Atk+8Yq3N5kIwRI/KWhFU9vnyK0y19r0khOnl2BTRd17G1vzU8W/OgprPE4GwyNXJSFt9hWMZk4/nmPrlFp4j2g2WLlIWnjBFkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=VDCpRNNK; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="VDCpRNNK"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c2149571dso8688661cf.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 06:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785505924; x=1786110724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pq0Vt2tNa97HpfIWCHBxkOn2jM/2Q4uM9td5pkD655g=;
        b=VDCpRNNKSsaEXTvDXXP8Q4vmQG22XewQ2lfO39qebzFrSx3dOLSH3xjBgk0Dp95Kdm
         5qm+vSyQa89QUZdf2qm3/OXkkyjAnTJr7ofXo+DPy1hC2pjE3KRtjTnaS5iB/U6fm5qm
         VpfyTVFk01jsbPjic63IpB23u8bjjcXqbxb4ztlQQy9dunmuy+xqV3DNCdy9eaLgkiY1
         upmrLn6XhukZTH74OJAhJV3NH7X39VfTEDOyt2IjPh48g1xQl10GCicIBrYqg2NHkI6b
         tZ3kXDxAYPRteJSr8YC3z5yvApodoRC/ycjv9B7mWVazV14vxUjyGJZ8oMTrY2tZCOw/
         TKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785505924; x=1786110724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pq0Vt2tNa97HpfIWCHBxkOn2jM/2Q4uM9td5pkD655g=;
        b=nKqBRQlhAPBwuH8PG4WACT6kg3FOV6xgUwurzRRcPWWE5b0OjrQ7OcvDnoyeO1cT8s
         pLCpdrHGTxWQSSsfzdhOKuGGTs1Ul6RjjdnTM+jHptggtbVzpqqP5COAECJ77okqF2VD
         sm/3auPmiOw4w8jWVbsQrIIPHt6Lq9ucztSmck+jqhKREFcmIHT3C07fNQtMiTCxog3l
         AVBeZ3joF66kOHZ1fLZuHso2uOxuz8JMTKzDNlOv/D0vRcEG5A2mfx7RY970g3krmW+q
         XZBLygohlusItmw4AY52Pa4fTC6ieHg1AJ00g19xW/SOxr4XT1RvNUGR7mCj7dxBiaZp
         b0Uw==
X-Forwarded-Encrypted: i=1; AHgh+Rp1ohLkkZ71l3EC5QJ/39FKENgxT28ygNnkU23sLFaXJg0pN3sOlLtg67NdNGyrlKAvenVGhbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1rSz5kWnvcG0X48fMeSbJ4RXahyMbJHn0ogTTKl+RV4mfxJS6
	BkFuBfHKmI3GyC8fXL+vRWUH1tMSfbhubOiKxx+oJBs1RMky+vipfqdaP8PIB82SnVI=
X-Gm-Gg: AR+sD11hpA3LI3H1SYgcKfZD2+owfNRwimUoyFkN5T0E0LJA7TPU/8vR0wd4rIrN2ID
	lvjEQKpEn5WsdaDziThfYGLwME38fs9tUzicyR4VIQRVO6DU+CKMHHvbaUNMRvwDH1JoqpeThgF
	KE1muIUL6fC+RTPNkvChennG45Ef1ayrGSEMLPbSOR/fixSRlXAb41uqdOtj34plmzO63AL0uvr
	cMaWGUt9UNNTQmi0mpWv9gM9mEtVH34EKq1p8N/AMnbe7+jK1VTiOkKRvwxNGwXv0r4Ce6RTH1B
	ayuXIshTRk9mtU4gng69jYBYaYMIDL0a7n2Gb5YUb1waaB4HP8UKY8L+/3rspj/Vrll4899Is6d
	HiVI/ZPtsRYlLhbAUvWwPN14WYomPcRVqalGF2KFqWLs8rkJAtCxWuSbsdq8azYSlSKe9WwNT6W
	9Gv9zR+V2bGFp+faWzPkMvak3Xn4mm7qxmhkRAyszUjcUHPoDQwuezUMcy1wtMqV1bDg==
X-Received: by 2002:a05:622a:c15:b0:517:85e1:388f with SMTP id d75a77b69052e-52b5678f96amr3179611cf.30.1785505924426;
        Fri, 31 Jul 2026 06:52:04 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-52b4eb6a84csm8108171cf.18.2026.07.31.06.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 06:52:04 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6: prevent in6_dev_get() from resurrecting inet6_dev
Date: Fri, 31 Jul 2026 13:52:01 +0000
Message-ID: <20260731135202.566337-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in6_dev_get() reads dev->ip6_ptr under RCU and then unconditionally
increments its refcount. Device teardown can clear the pointer and drop
the last reference between these operations. The increment then
resurrects an object whose RCU free has already been queued, so callers
can use it after it is freed.

Use refcount_inc_not_zero() and return NULL when the object has already
reached zero. RCU keeps the memory accessible through the attempted
reference acquisition, and a successful increment pins the object for
the caller.

Fixes: 8814c4b53381 ("[IPV6] ADDRCONF: Convert addrconf_lock to RCU.")
Bug found and triaged by OpenAI Security Research and 
validated by Trail of Bits.

Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
Trail of Bits has a reproducer for this bug that triggers
a KASAN use-after-free and can share if needed.

 include/net/addrconf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 8ced27a82..e67642459 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -405,8 +405,8 @@ static inline struct inet6_dev *in6_dev_get(const struct net_device *dev)
 
 	rcu_read_lock();
 	idev = rcu_dereference(dev->ip6_ptr);
-	if (idev)
-		refcount_inc(&idev->refcnt);
+	if (idev && !refcount_inc_not_zero(&idev->refcnt))
+		idev = NULL;
 	rcu_read_unlock();
 	return idev;
 }
