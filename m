Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785207;
	b=NFqT4faOK27ibjc5T0aBsD5rIplMj8YFBvfplZ49+B3ZBIM+9LN5j/sQf3G9E2GET4FV
	 zNbheYVRMDQjbcMD6o2r7vFB87p52CLX+ad5xur1zwcucgi9xawm1S5Byq8Z5FmLGvr/A
	 wu+FpqGAm7nB03NAeFIgJDEeck0OeOiUaV1QMPCBBhdP+djxdGgioUYX9aTfUTtk5Ncm0
	 OXQxu5pwaH4ZrcgHuSGIIFTpeukImMJmlb93IaREuqbg6YtRQJ1hNqxgAmBBbreWJb1gX
	 487316vfz4APLRzdrhvPnX9aIvXdP/LfqhvMVW+biZ3TL9SmCpcWyPn7XEHOUQEbZOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WhO3eiwpVjlpu/pA/NW1sjxZDrXxSK1K3FnCPXrmtt4=;
	b=32eITNH9ScRdTRbnKlS8oo7qG1+ZkmGqTAmSNo/65+mY4dCc1lXNhje6YBgySzpB3dea
	 mOsAqoA1r98hewqB5XpYX69cWfkLuLymy6pS+mKdg8EgOEXCxcMQQ37Cwrj7DbW5J8vpZ
	 YzVEIEOZTHDsuNBqXRB984r2trvwgQB7kTVRzULEMG+k0u59QVj1i+8qAeIoA5d8l4vSw
	 HugGcvSki7MiDh00/ix+uFFKFo5yI0/o+9C/5vBSwfiuaJdriBaGI8p/dOkKnQQjmWShs
	 dpnt8UpLYxgWS3avy48N9DKlypRNcOR/+xXhvXSTOZodfVQyBSCCoeIv6oqOz2XoTYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LyMNcric;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E946E606A32C
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 19:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E946E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LyMNcric
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so10086375e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792785205; x=1793390005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WhO3eiwpVjlpu/pA/NW1sjxZDrXxSK1K3FnCPXrmtt4=;
        b=LyMNcrichdsAfJMln78ddsIOmImAHXNWLeOIXtCVEUuIF9LazYd+tN/CYghvWTCrm/
         NuBmZQrhQMzU7BIdPm04SXCUUJUMuBc1KMKYJeluLgffxQnPSlqsdhD8RfPpEXvrvzTq
         vYaK58Wkbbuk4h8XQgud5V+0UJa9Qo9pFUhVLu6TAIIGdXvhnoz76lE/K07/2SGOXW+g
         W/kFt4YXAVdWJBHqteKlDFGn1zL4dXjgvDxCAmNScrbCwvTerOHy3AvO0IZQw5+3GZ6n
         xE7YHrpkRdyEMixIi+pDOCWYZ+kGHxSyJ45b/mN2/EySiIjQPsj1IBisP8VOkfa8bU5L
         AJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785205; x=1793390005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WhO3eiwpVjlpu/pA/NW1sjxZDrXxSK1K3FnCPXrmtt4=;
        b=BN0ETmElPUPVLXi6HbcthvLDwBA/TOZZl5Gcy3AGB8/D/nPSVGVbO5+aiUngzcyAY9
         c5Vhb8zA4bgYCxTg/+pe1JetQSnHxZ2mfIfyWewtmVW2rmn+dP6qe5N85qBkROTWXTB2
         3c3GMitWYQdC+lblO6oKk3zlEsSH3GA9eYyvh+h0UTFvR5AOaFDqsu+WWASBSziczJlU
         88buulYtuUTT/yhvvolAlwU1uOfpj5wvUmxJ+ue2Ef7rCfKy/1tbhGnkNu3wdCLQF6oP
         mV8Xzegl7ZyNy3tUcVeKJIZ7vn8hyrz0+6SUVdhQgtI4jYhmuqFW/H/iUSej/C5r29AW
         v6OA==
X-Forwarded-Encrypted: i=1; AKwUvBwP9xuCvkxDLaY3etwGk8j34346/QscF4NPfgQ4PYmLZZTjkTnre2QxfhBgmEPsJg1HW7i4q18=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPmArXuijCvKWzBJKsTxVfU/NoVD4DoaGTL7SgZNzhSAz6Jdml
	bmxxm2ULZHUAV6JugLiqFWL7JVffrouregIAIVjYbg5cQzYzVxa/wdM=
X-Gm-Gg: AYBFou1Rzgd3fdexmXnA2zP65b0Q/2cTDWzAEMlTP1HUxZ915jYHST1HT5jEiQr+Esn
	1SpxUD3BPMKDXrzRcuHkWnqe2EbYAX1jzQc6wIHrAEt9x/4PmELZwITBeVyTYKP/F/J+TOG9vuR
	38fRumX2PXvEx+fBfNcsRafyU5n2O3OzUkr67QbRCDkHqKHWXwAiJ5lCrzC8Ube88HhQDETLBML
	IjqhEpFnOF27XOhWZvGI5JnpH5g/5oykCHizijbRuv3HGpNEc9FqZmMMO4HMIggWH3hBqUKRtC/
	hGDH5JSADildWnxYQ2Fmg2esVE9W1Z2kPzpmYWOgH+PC5v7VV9FUw2jKdhnVrUlm+jMxLZGFksl
	Nt/ASs9N0AYHDyw1ynBqaK4Y0kSJP+Dw3ryrzxC+ecrDFoawiIJwSrgHq/9gLc7rfbwdwUoEJGF
	6zhHhizG5cUIUWuIkgtydjoJzqKPVCh4nxurYCMZIylb0DxK38+5y78jE9H65Uqn0+tz3SoKcUN
	QF0s0IVKAywnXJs+o2/AHwG
X-Received: by 2002:a05:600c:e555:10b0:4a1:d992:9476 with SMTP id 5b1f17b1804b1-4a211ee0060mr36703095e9.23.1792785205270;
        Fri, 23 Oct 2026 12:53:25 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a06da5fsm3299225e9.3.2026.10.23.12.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:53:24 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH ipsec] xfrm: fix output state cache TOCTOU in xfrm_state_find()
Date: Fri, 23 Oct 2026 19:53:23 +0000
Message-ID: <20261023195323.3528192-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

xfrm_state_find() checks x->km.state outside the xfrm_state_lock before
inserting the state into the policy output state cache. Between the check
and the lock acquisition, __xfrm_state_delete() can transition the state
to XFRM_STATE_DEAD. The dead state is then inserted into the cache
because the stale validity result is trusted after the lock is acquired.

A subsequent call traversing the cache can then access a freed state,
since xfrm_state_gc_destroy() does not unlink from state_cache_list.

This is the output state cache counterpart of the input cache race
fixed by commit ddd3d01329203 ("xfrm: Fix xfrm state cache insertion
race"). Apply the same pattern: move the km.state validity check inside
the lock so the check and the insertion are atomic with respect to
__xfrm_state_delete().

Fixes: 0045e3d80613 ("xfrm: Cache used outbound xfrm states at the policy.")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/xfrm/xfrm_state.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index e45aa1ed5b965..03baa50f0df7c 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1632,10 +1632,11 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		*err = acquire_in_progress ? -EAGAIN : error;
 	}
 
-	if (x && x->km.state == XFRM_STATE_VALID && !cached &&
+	if (x && !cached &&
 	    (!(pol->flags & XFRM_POLICY_CPU_ACQUIRE) || x->pcpu_num == pcpu_id)) {
 		spin_lock_bh(&net->xfrm.xfrm_state_lock);
-		if (hlist_unhashed(&x->state_cache))
+		if (x->km.state == XFRM_STATE_VALID &&
+		    hlist_unhashed(&x->state_cache))
 			hlist_add_head_rcu(&x->state_cache, &pol->state_cache_list);
 		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 	}
-- 
2.47.3

