Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59B64F648A
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014571; cv=none; b=GPD2wJiQM6QuC3eWe+2cHF0xRJ9THO+HdFz7TLKkQ/InT2AjGeMbkzuyph1xYc/lXeswg0loXUIhoklSAk55A85q4uJUO+ok8k+CMla5i8D/pWs03oy5K+2quZRgZO+TIVOZtw76mTioyTjmn1WZlEypMGCD4bpszy2cA7SpuQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014571; c=relaxed/simple;
	bh=9sO/C+Mw5RPob4eZkpAodclBSGa8oO5zecCGg5bgyHE=;
	h=From:Subject:To:Cc:MIME-Version:Content-Type:Date:Message-ID; b=PudbmcIt/YGNVTqJp2gl0a7PYgtCX7A/gGuxBGT5a7wgQXVEnFIFEXMWsSxQbXSqJibAVLrucFjE9NKvkeAdMpQN+CEF3QFzVh995Ds7iUMnEqWonecNEw5mK4WMhhfmTSBMk+LxFGvfOr+pPonKCL2zonEEKVHPdHXWj/amaVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRcenJyf; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRcenJyf"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c3304784so2873678a12.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790014569; x=1790619369; darn=vger.kernel.org;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :cc:to:subject:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ceJBvn0jVpw0gF/+O6f3OrNX6AQyTIdHbztQy6tYQ0c=;
        b=hRcenJyfl6YL7GXJLB6zn/9mI0QTlyKd4FdA7Wnyibu6RiTDeS1isKWA74u07k8/wg
         +30POYVV2PLOmGWfa2yS1AxNCG9nbHMfZkjA5tlkkTir8oNDHvOG6fjcC/ZfkMcro3Jh
         DcMpbLDOf6gOONDU8pOBSM3yaT9PsU4fhQ+i3dT35QSFORSJfUhjCV4aEhmVXN8goY0e
         hFwNZ7kdOzwT6KrbcGaSnl7GWAr6swFYn0va9luf5BCajvP/8/oy93RswQqAF0DZ+u9J
         LuwWDnsn5KtJeg84WWstLG31RFHCCIfVyvA0rJBwD8U+jKYfznPE+RrTLyQ1nGEyJA83
         VP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790014569; x=1790619369;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :cc:to:subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ceJBvn0jVpw0gF/+O6f3OrNX6AQyTIdHbztQy6tYQ0c=;
        b=CuQZMJVS3tJ1nmnS4w2eoIsNVIFv8QPlLdYtIrbAq2FRbyC9WcDGIvDnJIDRWm0QS6
         7xEFqfnscgpzlFgLCUUpEeF7tGBhV2743gmMlFUm7SBtCXF3ggts+mdQwEVNjLyIy8qM
         F4tqNvxcQNgPJSSOrGdChMohKSgehS5fCUQiyFfSMmfdJGi/+IZvZnFSVvdEDRgt6yS+
         Cz/fSauAqOwdemQqLi0EilfJNTmIoKJfcZAQSiNwL5CLpMy1dklu5BzLlGd5Ezwkvm2G
         S7aXCkNkWrHZ5fyIZJEeSqGfxhEzw+RGmyfIVx0RefN+a3hWpcd11c2IVrzNY/LFQ/9N
         42eg==
X-Gm-Message-State: AFuF++lXc5wdp2oNLUQbwkdO51invG3Qngp+TD4WEYmu1H87MFO7mcAh
	gIWkNrVeW/f4I3OfoV5ZVGFTydurAp8md6rwpcnd/X/2gIXPyVKDn2+VfVNjiah3
X-Gm-Gg: AYBFou2acPZd+kEiD2fxaWEiTpyo7yc4W8fh4L0BRozZLipTc42SbH2n/Juo+Tbf7uH
	fLSK84W6AkFosiOUj+EzCWniY77lVV8hKGP723/DZ1yOrpG2BbYEnDPPYKA8SU/dztBD2qSZtPJ
	uIcYiljOcQGBLO13L61uIxqVp1G3K8qMBDyYfq4V0qplMII7xujFGTDeES8Rg+mKAHkPezfT+RI
	FlB/VqvA3l8kgPCo5GPsnyyvGs9UkDFH2ZiWcgFtPtKLSoYbzVa2P5FvZy4WoWpWmi5SWqbNgs9
	HZ3kYaGy6vWiTXoFf5B0bg9zloI7xjOFsx921YyX7mgl6SiLNvcjBCI9iaZO/LynMYV2Pr7AztG
	rl0NGZg+WreHtqj+Lm7r4oRmOLxRN++cjjuEbxrQNaJqETT1hSN4PyMbNta/LlkZsa2mP1PisVg
	XVGLk/5V4DfulxCENAFr6jCux/nnQjdTxEKYvlv/uXpLnw50eqMyRHU9XyFrYmlwfsCdmIfniYJ
	F8gLJOhyomfAhMuOn/r9Yo=
X-Received: by 2002:a05:6a21:3943:b0:3d0:8abe:9e08 with SMTP id adf61e73a8af0-3dd8c3f2338mr18188576637.3.1790014568927;
        Mon, 21 Sep 2026 11:16:08 -0700 (PDT)
Received: from SANGHOON. ([1.220.132.212])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae8eae3sm3902549a12.14.2026.09.21.11.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:16:08 -0700 (PDT)
From: Sang-Hoon Choi <csh0052@gmail.com>
Subject: [PATCH net] nfp: hold IPsec RX state under the XArray lock
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    David S. Miller <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    oss-drivers@corigine.com, linux-kernel@vger.kernel.org,
    Changyul Lee <lcy8047@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Sep 2026 03:15:59 +0900
Message-ID: <179001455912.44752.17153022439349797877.idr-bug-92@gmail.com>


nfp_net_ipsec_rx() drops the XArray lock before taking a reference to the
xfrm_state it found. The delete path can erase the entry and drop the last
state reference in that interval. RX can then try to increment a zero
refcount after the state has been queued for destruction.

The driver queues firmware invalidation asynchronously; the delete path
does not wait for the command to complete or drain pending RX processing.

The XFRM garbage collector waits for an RCU grace period before freeing
the state. That delays reclamation but does not make acquiring a reference
from zero valid.

Take the xfrm_state reference before releasing the XArray lock so
xa_erase() cannot run between lookup and reference acquisition.

Fixes: 57f273adbcd4 ("nfp: add framework to support ipsec offloading")
Reported-by: Changyul Lee <lcy8047@gmail.com>
Assisted-by: LLM
Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
---
Found during source review at mainline
5dd1818b15d98d4a20806cd00b1b40320b06004f. The affected source is unchanged
at 93f51579e7df248780214094418f205253383cc5.

The modified ipsec.o compiled in an x86 allmodconfig build. I have not
tested this with NFP IPsec offload hardware or reproduced the race with a
sanitizer. In particular, firmware invalidation and pending RX processing
have not been exercised together on hardware.

 drivers/net/ethernet/netronome/nfp/crypto/ipsec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c b/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
index 9e7c285ea..960d7513a 100644
--- a/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
+++ b/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
@@ -625,11 +625,12 @@ int nfp_net_ipsec_rx(struct nfp_meta_parsed *meta, struct sk_buff *skb)
 
 	xa_lock(&nn->xa_ipsec);
 	x = xa_load(&nn->xa_ipsec, saidx);
+	if (x)
+		xfrm_state_hold(x);
 	xa_unlock(&nn->xa_ipsec);
 	if (!x)
 		return -EINVAL;
 
-	xfrm_state_hold(x);
 	sp->xvec[sp->len++] = x;
 	sp->olen++;
 	xo = xfrm_offload(skb);
