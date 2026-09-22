Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450A34A8FE4
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106823; cv=none; b=R2tJyDVxW/T7W34oWXnnwnaDHCNlGV8Fd72tz2c1phOfSQsLUIdNnL2ZDnejTtbSClIbluktZvUvZBenF8/hR59x91KhdTpeHwQNU5vDAksrhVPKK3elRN9y/20+zx6pbumww1/+50Dn1ZukVr5a2jo2yQjG4xx4wj/gYhMlzUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106823; c=relaxed/simple;
	bh=rVQcvu2nQ9hhpSlEWzP2hEyq51SDjt+QGpBeBBaBtz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Nf4nLKWOKhgGGfmE3pd7p4SLuT9swDYUs7M+PMgdFO7C5c7kBop93oIJIqJiq99FVWbxSIW1vTEVsosJFnNDVpvi0GTievuYpVq+nrJyyKFj5aLQ1IH/xug8T2kS3Df7/66SA5vFty9gLhKfM4zgmaSHKpjr3MlI4oXrjGrO+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7dIBAnB; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7dIBAnB"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-486e0f56cddso167803fac.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790106820; x=1790711620; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=30kr5BweW/mill+9FpYAClX2qkZFuhc6bMu71N8WrHI=;
        b=A7dIBAnBpdbzaWlZKqZ1VhkmnbdUsGHhZOp2KG7NKtD50ueAoCKaG2HC2YjQr4HEPz
         t7B4kfv5PeX/ec9jZLRrqJ5WAKpjFvuh2s5416BvlatY4ucLgaBJM44NS3Unajox2jeI
         of65jOoBsacQPnS1IEvSJGP9q+Dxl38nf6BsdIe/k3C/p9XX1xRQc5/PeKztKDVGFLPy
         pK31A+A1Wj/UUXOfntxDrvWANVK0vrELOxCnJXymZg8MckOgEEdbQEaUg/RaEMv0s39X
         3pBVPxGhzi+fPfi18lBD/6sY5sp9XLcyWRrCC3TLtCjIInhmri5qjjJbuwe14zVa7Mdm
         pvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106820; x=1790711620;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=30kr5BweW/mill+9FpYAClX2qkZFuhc6bMu71N8WrHI=;
        b=a80YfJnQY/AuQe4D/COTzIxyJlWeudQ3FaurviT0urISDkuEjnaI9CL+EAMNLxomcs
         HlQvr1I6z8SolR5IZpEH259NKK065GZ4xUdTzs1II5lIDmomqUtU/ybXT5yBHEo5hsT7
         fdE2iF7VFgaY9g/Z94ys6NT/PyZ8Pr7MoLcJ2PmBPAzDWrHgv2v0NASKVg4A5di1D2pp
         kSpxTeW8tSXREWXqaCw4yjKaX1GjY7Sag4ng7fXeOQsDk/2nak/s3VTVwAe3eI0jsxRu
         neqAUDOqhCCQj7dB3LFT3mK1RyFNOrph88V8F79vLyYaNtQ6cXK+vx0KswjWbplf5rIK
         0wVA==
X-Gm-Message-State: AFuF++m2QjhGjB9n6wTyw61Jse0cjdMpdSHi/m5W6rPyPAbPgE5gq3fP
	fFqoLmAk9IeZQ4qTmGqRXBoUdAa7jmredvTh39molGz1I1inoUWVwS2v
X-Gm-Gg: AYBFou25gZ6IlPOC2BAElYlyYAV47Ocb3eUZvRLEDnEUZ7fNeeE9qQ4VTTVafmeUQA4
	SPpWnzjaNamwA3CC1yd7pNBTujgX4aXVvIJTyOljeupb9M3b+4MRQPJtlUrEdkkdpJFzbi+gzh3
	+lbqq1vgjTtL9re1r4erj3XPH72iKcSmg0KDfuFhlyLoqRnMVxYxLVQgz55G6UCqFnUWt4cW3OF
	u9VrWbjgNaBNn2C6HhbHyLo2qYnjfRe7e2QWV4sRRbGrXDqAZkQJmhafw60pRO3dH4sjB4Rsw32
	nhRSgd4+IBIBqwtyXHlWx1ATTHepzVawiO2k9Eg6KECzGswrcFOZGrYpNFMnZB6kA8E4VYhY2Ks
	pPNzhSVCt2Fj4ZI0ogbZ21E6M1YHVVwjTO9YWrv1dNviAQY8KiyKQOwyv2Tj5aR+TAMcgjUx3jD
	LpahuAOZkc+fIA8jjdoCSE85Oe+zE5aC9lxhJydrBi2QaNsDPflBOa+eiXvGTWNeTcP7R8
X-Received: by 2002:a05:6820:810c:b0:6b7:46e9:96fb with SMTP id 006d021491bc7-6d2d25210c4mr422952eaf.43.1790106820016;
        Tue, 22 Sep 2026 12:53:40 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d2dacc5db9sm426923eaf.2.2026.09.22.12.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 12:53:39 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 22 Sep 2026 12:53:28 -0700
Subject: [PATCH net-next] eth: fbnic: put back netmem reference
 xdp_buff_add_frag() fails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-fbnic-refcount-fix-v1-1-31e5862c9893@gmail.com>
X-B4-Tracking: v=1; b=H4sIALfcsmoC/x2MywqAIBAAfyX23EIZPX8lOqittZct1EKI/j3pO
 AwzDwTyTAGm4gFPNwc+JENdFmB3LRshr5lBVaqrRqXQGWGLnpw9LonoOKHuB9PontqmM5DDM1t
 O/3QGoYhCKcLyvh95Vav4bgAAAA==
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.13.0

fbnic_add_rx_frag() takes a page_pool reference out of the buffer's
pagecnt_bias before handing the fragment to xdp_buff_add_frag(). If that
call fails it has not taken ownership of the netmem: the fragment is not
recorded in the shared info, and fbnic_put_pkt_buff() will not put the
reference back.

Put the netmem reference back on the failure path.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
This error path was introduced in commit 61f9a066c309 ("eth: fbnic: Use
shinfo to track frags state on Rx"). This is not a fix though, because
the branch is unreachable if the device is behaving correctly.
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 447ec5522499..bbc3c9e89a38 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1045,6 +1045,7 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 		pkt->add_frag_failed = true;
 		netdev_err_once(nv->napi.dev,
 				"Failed to add fragment to xdp_buff\n");
+		page_pool_put_full_netmem(qt->sub1.page_pool, netmem, true);
 	}
 }
 

---
base-commit: 6598456d72e48d779445bfec8f72114747f8b8d7
change-id: 20260922-fbnic-refcount-fix-a78b3a7e536b

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>

