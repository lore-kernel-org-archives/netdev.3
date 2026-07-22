Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04B3404BFF
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758605; cv=none; b=cF6G6trnWf67ECz5AaSa8TkDu2gLUTZNbO8R42ZyxUsPLHHDauI+sm+/xv5N2qDD9gSQidEXfe4ReZLf3+eAGqhuSN2N5wYv1JR4jJKQuR93zyKQJ/65ah4xHpmQtgNyaxDtmxQ1WCZ/Xp44xXvVmO/SDzimL30OzvyH1COOB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758605; c=relaxed/simple;
	bh=pmLr6Q0wrxaoiG0HC4cecGXvH0Y1btBIoJOHP4vTW9c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pS2L0HbtpHp9QboHxOFmxrw/vhbHHmVwOxfy4pMn2Rn4em8kss/OqS0s+rcGxkxS3Yu4HGAw13EhdrqNZc2KX42r9DAcIGZzUOWwTKNnNFD4CJr9fnPEa7MVIDzstT5v06V5O1qLJg59zFxcZy7JvzuUv24d4pppXAyE6GW8TAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZd9F1ko; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZd9F1ko"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a3514f912so18423989b3a.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 15:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784758604; x=1785363404; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nKju/xiraPUjvnNIoptLAwkfAEYgVko7uXam/THvrCc=;
        b=PZd9F1koYhqdsVZtSzYENZf+OqmR/jW7O+s12PSSvdxJBmILnRcZG5vmeSc08BXzhw
         a+CvaCM9s1LpFNv2p6IAxI6Wh8dQz2Aw3X9L9i2kEjg+t9SondbIeyU3hi/Gbx/XpctX
         FCLUnYsS02tjfcnV+h5v3izCVliUUYaPv/5LWxYD4ecsAyN+swcVezxcoLsmBREIoaJB
         SX/agzTKDIgvDR5X1wrEJIXpMwbJ3LQ8P5G8bHLowniD57esvj1AdmqI5AQtiuEtHdRf
         3Hq56dIVq+I4F4LNnXG3p9ipGrHWsPfeDtfwfuZzCGL9EwABvEUTGd62ByiHza/ahZnz
         Gj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784758604; x=1785363404;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nKju/xiraPUjvnNIoptLAwkfAEYgVko7uXam/THvrCc=;
        b=RzD+OWa5/jLaOD0+16RYjYqfxkr7RV9+j0AGZXAkXQsLef6u+RhPDNSxM+Quy4MSdX
         /LbQl3GVhNVCBa7HxNQfsKk6xe1gEbtd+ShxOT+3/2iFsR9+XQQPK1qrOAnlxmi8iVKM
         y5fQWucYd801l3Xw1XcWXixcGLFnXW4ImV2nZabboMJiVPtTlPAGkHh/rRIquqQk1C97
         eJ/8PhE7XKoGaYdyhNMQMdA4+EjD70EGTzHpAnVO0CAsCD/93++ZubZGp5l8GfFrLWjG
         BraRPMPKduTc/CeQII6uHJ4zjWYb8WrdqFe/rFRiIPlBW3G4vnuapF7hawG2Or0w1Yoh
         n+Mg==
X-Gm-Message-State: AOJu0YzsGlsoNpr2IaBye8qYBZZBCJ3538h9XZIrYUm571KTcuKlOBBt
	vvRC/pPO2jWLRcncRnFkO8+G9Eb7D/f8zwPapGGx+c/uFsq5M4tJlEGURHNdMJPweRZfYJsaPWM
	2Euj9/vewJ+GYQg07HAmYbs5D3RiYfCqDeo46Y/V6zfk5jojra+y9v8b4cA/ariua4evBP0/7d7
	Zqa+mXotku3eTxHCnbUWLEdKh/4n5In6HAouRhfIZtPuKbvSA=
X-Received: from pfbde7.prod.google.com ([2002:a05:6a00:4687:b0:848:401c:994])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:cc9:b0:847:99b4:d011 with SMTP id d2e1a72fcca58-84e2c19f3e3mr648344b3a.39.1784758603545;
 Wed, 22 Jul 2026 15:16:43 -0700 (PDT)
Date: Wed, 22 Jul 2026 15:16:34 -0700
In-Reply-To: <20260722221634.186886-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722221634.186886-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722221634.186886-3-joshwash@google.com>
Subject: [PATCH net-next v3 2/2] gve: add XDP metadata support for DQ RDA
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jordan Rhee <jordanrhee@google.com>, 
	Tim Hostetler <thostet@google.com>, Ankit Garg <nktgrg@google.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 1b42e07af1ee ("gve: Add Rx HWTS metadata to AF_XDP ZC mode")
exposes support for the XDP RX timestamping metadata operation in the DQ
RDA mode. While the operation works on its own, the intent was to enable
XDP metadata support for the queue format as a whole along with it.
Currently bpf_xdp_adjust_meta fails because meta_valid is set to false.
This change updates xdp_buff preparation to set meta_valid to true, so
metadata can be fully used by XDP programs.

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
v3:
  - bfp -> bpf
v2:
  - Fix referenced commit in description
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 907a0c15bf30..329a2585489b 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -882,7 +882,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 				 buf_state->page_info.page_address +
 				 buf_state->page_info.page_offset,
 				 buf_state->page_info.pad,
-				 buf_len, false);
+				 buf_len, true);
 		gve_xdp.gve = priv;
 		gve_xdp.compl_desc = compl_desc;
 
-- 
2.55.0.229.g6434b31f56-goog

