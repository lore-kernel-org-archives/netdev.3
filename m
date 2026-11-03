Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749919;
	b=zSqJQfxPxxX34Uz2wkEuY4fGuJWckpNlUj/KWrXu4f050f9lZx36JyEdWMq9gwpFp4yQ
	 YuGO/5lDz1RbQlLDY8Mj4EW3H0ZYoDeDUoq21xoEwlbUVIYsIm+uCvTZPP3LJcjIjhxUV
	 ECw7H4/wJ1pTLLSOBsPi7wiNBRVtmcCnduZX6KW2lEhHYl88rwAya644wZWsxUPL4f/2W
	 16UApqWsuIocHYlmbLombsyLY0pHXG0hzDUyQRPmJ37VIuRXk8EPb6diT+oupPXDoDnrx
	 gSAEFCy14FJrXOsgofdfmMeSvPIkd9W3tS5aHaTRbJ/dRHhJPA+q63pGGfdP0uX6qTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=u2FL5iZJ3JHIjTjapoLLiX3E/WLeHQAJjW9k9AzRwQk=;
	b=pu4/3kqf0qTRe5O/dNCMu2gDnqB8KklUI0Rpp0aSMvemHfCNY2frV1sJZ2fsNuVgowgd
	 kFZJJ5WRpht8PCFDeYLOx2DSegqYBdURRoQSNb6uw62IEr1N7qN1dbmjH3J6LReBxfvUx
	 pRbwIwxmVV7twn4xr0mwYP3WVSM311oi/ZZBfuhnUq73thML2DtrOjpRsAKbCUDui92/m
	 tEZfa4PahR4MDqlHvvxgqy2Zk6GajcR7BoBqjcIoeGAeLnii84yn258+G5ev3u/9NleQO
	 GacfRznCENko6WPi0g4mDKZMXyYgNVBOiYuREyXFqOdk/XCal4mFBvWXuIUFLwsc7TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UPGN4NCT;
	arc=none smtp.remote-ip=74.125.229.138
Received: from mail-dl2-f10.google.com (mail-dl2-f10.google.com [74.125.229.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67176606D81C
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67176606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UPGN4NCT
Received: by mail-dl2-f10.google.com with SMTP id a92af1059eb24-143601f9f98so49968c88.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 15:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749918; x=1794354718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u2FL5iZJ3JHIjTjapoLLiX3E/WLeHQAJjW9k9AzRwQk=;
        b=UPGN4NCT1NhBPIdKHOKGSo0GUnrckC9TyZik21lyvgHH0js5GC9k5TJvR4sCkcW/zf
         1lqBRPSCRMRSY8+khu79223f0n2Ep0gmSa94vrnY8TxyBaizryjW9AhJNcZtA2mf3rpP
         c+7JpL8AACxqCsQvF+N7Q0U9wahzNZPeATpsssFqEZKAqYmSoi13mFrBPWqmLOiY7rAs
         7bc7HjUey4W9j/QrJb+6rhxinIql8PWDfb0Y3Wzu2YMrYCxKlqq1hT1Un32U7SuPjVFM
         RqQ13NeFN5J8S2CANiaczj8DJJSAn87CmCAoq//kL8v1lI8OLCvoVpchWHTM8BtStETw
         HPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749918; x=1794354718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u2FL5iZJ3JHIjTjapoLLiX3E/WLeHQAJjW9k9AzRwQk=;
        b=jLp6ygrk3zDocAaae17yvFW+dpu1QmWdvQ+v9DCX8TKrio1P9mPTnv5m9f6oECe8NO
         jTEjOEWoVn78aCeVesvjH0cqg1b5LNG4Ztjom2/1N+USOJ4xHkU/Dv6KF9HpL0bQctT8
         J6gSp0S8ieQMgFo9OvA1ADokuYQrwkKw4aksiQeYwXS1O3s+10osZSmddxqFdT4qNhUe
         PIA13pXASDTOPdm1RhIoufow7NwG3ojwBhljJzhuael47UBHuvmdWX+eHxhzv7uWnNw4
         OFRY/tNfyJu/gcZnsQlUrIfdg+tAZ5P3aUnHnF4UAjGLl3kmHYqIRhszamJDOIoaZh9D
         1d6w==
X-Gm-Message-State: APuU4Z+w2fQ2aY+/eEqh9G5vhMYh2Wd4QEAg2R/Du1lQIdf4gv4IYhgN
	WChoWMxP/vqGdRHnklPxAk+4BmVhBSVFi+1nviAvZbnrlHKg8OVldL/FusMLAukn
X-Gm-Gg: AYBFou0MIga+9Na65F3MwHh8SicbB4KGdpr7c8d1lKmB+UgrdKUb7QRgm6951Dhs0Gu
	jln+DkgZUF/qNpVVQsQ6pspD0qY40sB5Kfp2FcFitvPDFB1N9qFinV+q2xLzz8SwNJNb9q7JmzX
	InakFhUUh7+S2QhfskM3sk9xyuYauQN2Zcxl3aOjusoLrrTRsYE1AfOdZ8Srsg5QkpePppL9pk7
	PmGR/tv4ifc+VHm4k4tJjRwvwvt27ZWwfRklAn/NumcpnvohXE3h4XbH1+ZFUqvCa0Y90nAux9I
	gfhHtfC/cOoZaNuMOL3W82/gA05vK2Q4ydOPF6Z2jNPhj1L1Qgr9R8S8Km6Dg9JrfxLjHaoVp28
	x5OHgjNAlzuGFJJZNiDG389OZBhN7A5v9ztSQmItlDI9J/FoHSXuWhzPW5bB1CT29SS46NCNjjY
	3rwuKcPVeKMxGynVTl7GHaD79mQHKLFSelCfi+X0c0oilD1xupimjOU8sQ4i2nuP/sMzKPf53YR
	frKCFT5x8kpfttNbD/deDjvcjJt52bYycLF9jd8CzVGgEy+o00DcRZ0f3E57akB0/elR5s1D6qA
	I3Phoh0Nx4xrUUZuZHdKouA=
X-Received: by 2002:a05:701b:230b:b0:1b2:4378:3545 with SMTP id a92af1059eb24-1b2437835a8mr3011803c88.21.1793749918147;
        Tue, 03 Nov 2026 15:51:58 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:70::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c748eesm2167834c88.23.2026.11.03.15.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:51:57 -0800 (PST)
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
	sdf@fomichev.me,
	almasrymina@google.com,
	bobbyeshleman@meta.com,
	asml.silence@gmail.com,
	razor@blackwall.org,
	daniel@iogearbox.net,
	leitao@debian.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 3/7] net: devmem: use niov_shift in net_devmem_get_niov_at()
Date: Tue,  3 Nov 2026 15:51:48 -0800
Message-ID: <20261103235152.1904727-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103235152.1904727-1-sdf@fomichev.me>
References: <20261103235152.1904727-1-sdf@fomichev.me>
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

TX bindings use PAGE_SIZE net_iovs, and the TX lookup hard-codes it.
Derive the index and offset from binding->niov_shift instead, so TX
bindings can use larger net_iovs. No functional change, TX bindings are
still created with PAGE_SHIFT.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/devmem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 32fafbfa1359..6339f221bc82 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -455,13 +455,15 @@ struct net_iov *
 net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding,
 		       size_t virt_addr, size_t *off, size_t *size)
 {
+	size_t niov_size = 1UL << binding->niov_shift;
+
 	if (virt_addr >= binding->dmabuf->size)
 		return NULL;
 
-	*off = virt_addr % PAGE_SIZE;
-	*size = PAGE_SIZE - *off;
+	*off = virt_addr & (niov_size - 1);
+	*size = niov_size - *off;
 
-	return binding->tx_vec[virt_addr / PAGE_SIZE];
+	return binding->tx_vec[virt_addr >> binding->niov_shift];
 }
 
 /*** "Dmabuf devmem memory provider" ***/
-- 
2.53.0-Meta

