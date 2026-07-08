Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE0C49690B
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521257; cv=none; b=qX0Y+KtbpZD6E5UB02FZ9e1sVZ+3tAub/I41tfS8npmR1aT3L9UbKO+LeOPzC++p8vXlDnd56+7+ogQsMlW3a5i5CYqR9VdZtC7WEDE70R8XT+8hqNQskXEbl23XHZcEx8ryL1jHl93kup6X3e9Xdxv6DCFU5sOP0zD6lMT2AQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521257; c=relaxed/simple;
	bh=gApFntNphrkEj64OxuZAI52P8keorc1vNbiZU5v7qHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MV0rxmXx6Ue9Jgpi5JU4xikSOLcixX4S1oI+JIaYqVTEr9MqL4TrVZ5uKW+vpHkW7AmeFlw54Hbu//nwESclN81IrHCzvOby7tF07LH6vuMY+1ryNr2YEpPaDNh3mm0Vm3CStZBFNO2Oy00kQj+pVULDsOq0n9h6AhTC9xZG9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpdspI6T; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpdspI6T"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso64981a91.2
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 07:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783521255; x=1784126055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WuNm54zDBYgFWTaaIfLcL4nvGJqvulTHjWX7HmJCqiM=;
        b=CpdspI6TgopuHeaoRSMgBfGEEM5k2eGbGa0ZK2aejq27/6c7mIwXtjZddywW+lMHXS
         R79zRxqljqYEUZ8ABP9Tp0y0lTbYLUcLfsXosQpKxz/JIvz18fCXhFWRSshjqjmEgTyY
         xz+7tmGnuBkWCRWkF4LmQtDWRgqFdm9onNMpszsRab7X2Z2RueWlFttEPXHxRBZhMx+f
         abaS0wvWKTirI7+hWnEYcKk3LciNOwourA7f5enoqPZtqyqz2dkPhpTuym/6pMiHgWWM
         BqAKmlgC1kxunoGCbF68W79GR8iJOOo7LJDeIQkrntM5LRLllExsAr6z/IWeseQhSbEq
         c3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783521255; x=1784126055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WuNm54zDBYgFWTaaIfLcL4nvGJqvulTHjWX7HmJCqiM=;
        b=T67RIBXoLi4moLUzyysChowlFEpbPBKpJPbWOZH9IPBDwiyByFq1Sze4rcaV7T/xCP
         1kuN+mU2KcYdDq/Sg4oJJH+kmFZcalnkQRnlyRRamx5TD8t/3RAE4wj5tzClfGdgHXCj
         GE9/Ha269Bid7AQx48SdrSDD+wjjwa/oQ2IwoFkTJbS35be851bLgKGd8zfYHmMDCUKG
         xxs8M9IIyJ54iJL11FLApHQj3Ch3lmnil2KQrVRAzA3FuNcNrWJnICDIdft30MjRX+ZQ
         wMB1fltxlt+KozxujPN6hxWza6ZK7wNlUlFIXmzRv+BEKMPxi13pOUpAGfnsmiu8OnxQ
         BYaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp/6hYYKWUxdj3wklObi0dBkzx38VDUb6t/iscjYPwbFibLCrPemljLMVFzjqBNbd29ttVyKwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycv89ibUXzozdkFTaI0UylDKnPXlB98y/mHHS4Mw8FEHToCodZ
	Lk+1aFR+e/O/a6+PFH7cQ8GcB78biD7O3cJSJ0RtHsr0eoHVupu+E064
X-Gm-Gg: AfdE7ck5erK5oH0J/3H/SLnDvn3DIcDz6moW92HTfD+rpiU07h1DBIRJS84c1ewNo0S
	o3iW8IhTeHFbyLSWdBcwd4/3dC9cqlnt2eM57mmDca3vbREr2edv+lswMM4lp/ehPTKC76bu6TO
	7Mc10h43o8AF0MrMgyFMxfgIvazcwKybLESI5MJgkFVmOBmC1xh29HVMFW76l+M1nUBG2z54rpI
	Wec5/FBD3ykIL7tladKuNq5D6kowq2GrGnpcvnIsjcLUIXyTTCLyaw5Y0uDQY9OJTyAh1uye2pZ
	W3Dwe8SgkThMiPBrnRgQrDu6ClfyJgoQYgpIwU8aKYobp9bk8WcWnw34DeKJok0lTu5J4fZ4wM/
	0CZKh+jAuNTkNdO8R8X1HzLHhaQ9N1SDe3YyH3CqKur5s18eU0vhPW44qMKXKNx35LYFaP/Rf34
	7w3xTi051oSbHu3uC4wJwoIHx8CJtcce/gb97Vvx2OVBw=
X-Received: by 2002:a17:90b:3bcb:b0:37f:c2a8:ce45 with SMTP id 98e67ed59e1d1-3893fd5ef66mr3086798a91.4.1783521255247;
        Wed, 08 Jul 2026 07:34:15 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:1b95:b995:f60c:5c67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d3d66036sm2837540a91.17.2026.07.08.07.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:34:14 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: kuba@kernel.org,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH net] nfp: Check resource mutex allocation
Date: Wed,  8 Jul 2026 22:34:08 +0800
Message-ID: <20260708143408.3168425-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfp_cpp_resource_find() allocates a CPP mutex handle for the matching
resource-table entry and then reports success.  nfp_resource_try_acquire()
immediately passes that handle to nfp_cpp_mutex_trylock().

However, nfp_cpp_mutex_alloc() returns NULL on failure.  If that happens
for a matching table entry, the resource lookup still returns success and
the following trylock dereferences a NULL mutex pointer while opening the
resource.

nfp_resource_acquire() already treats failure to allocate the table mutex
as -ENOMEM.  Do the same for the resource mutex and fail the lookup before
publishing the rest of the resource handle.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: f01a2161577d ("nfp: add support for resources")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
index 6d5833479d123..237300b82b913 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
@@ -96,6 +96,9 @@ static int nfp_cpp_resource_find(struct nfp_cpp *cpp, struct nfp_resource *res)
 		res->mutex =
 			nfp_cpp_mutex_alloc(cpp,
 					    NFP_RESOURCE_TBL_TARGET, addr, key);
+		if (!res->mutex)
+			return -ENOMEM;
+
 		res->cpp_id = NFP_CPP_ID(entry.region.cpp_target,
 					 entry.region.cpp_action,
 					 entry.region.cpp_token);
-- 
2.51.0

