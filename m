Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE463AEB32
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084481; cv=none; b=hkfvxhF4pIG8XYFLg07EfAwl3ZI3nkwggd8bGncb/304RC32wIHgc3WCjBTfkd+TBZ8Pca7/2wSULR90sRAdF1o2zFGfHl/BC2KIog4ketmXJnXTONg6YwEQ95YZSGbkDnj5wQKSKkb7DE05ROXNwRaSdN8WNf2vFmcDas8kuGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084481; c=relaxed/simple;
	bh=zm+IFtkQupAeQomjz92QbxQc3kRIUVTD3HYLMJXnvk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0Yagw3jHY02Z8vHzU9sXj0t3UN/kVgQtc6+8RIgYJB3GD2lofz15u8kqLms80+q0n9PTldtuLtbmuPD0GnblGRlUfdh3Ee3qyf0wxAGT9cYoHR82fR7mOOB1yuFhXQVyhrw5H5/X85TBAiEi7eOWaJ3hj+FuGHV8kCu1GTWUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFO3jTsq; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFO3jTsq"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5300bdf61d9so5072001cf.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 16:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789084478; x=1789689278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aXOUF/0dKfcL9nM72QWKoaIot6Ph6ib6YvMRCU6EYeU=;
        b=eFO3jTsqOROUsoQ30Eqdrcr5CxPaYfHb4kCKtTwkQNXgqyu/bWRP5WlTfGXFWCVibm
         kpnAu4Ya/Az2CmzhQSVOu35wIRPpDzBwqVw6hFCU7KzcDOtaAmeppkiKwJAvUlMJyGTX
         UitLIx6AnzlVMYHUA1ev0qj417V9Zz1NUyuE+n3dpxEQ80ACX3/XgS+MnOTPBrV/S+/2
         Kh+NFSbnaWqADKh9Jkdfkknk0KEsb1me5216Za6awGLSp3VR1XJEHmb0Wu7BszTYRiS/
         XUiv0t0RGwyEDULGh+9VGool2oX5Q/d0ZXEiunPPalKLp+euAbmcq3MxII8dLljyJUx9
         uFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084478; x=1789689278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aXOUF/0dKfcL9nM72QWKoaIot6Ph6ib6YvMRCU6EYeU=;
        b=Vnszn/LHOph/opSFTbvbDCtX+cci6fBZNuqfUowI9qm3WJezmY4yYjLQ3e5TGaq3Kb
         aa1Y4MBbCVvSOMw1m5I3C7mfNp091psq/WXrGK5M12tbIt+hEjTlILBWygvTk9wsOkvX
         Hk5aAuB18mQTtnLcN9Q3DpyT/bTCxsGGMvRpdhLhViQUsYNb+0ITscrjL3WUEgToUzuH
         ObkeMhQJ04id289XT/k4XfOdX9wkc9V4CnlFA1bA4f7+Q8m063Yl2jzjGDpT1E0gN9pK
         1OQtpYDQps+DfiiKMt+97FA5eaD7Qr9dbluJSEb9Bf14sWTVww3r9XHTTToDcV3Jw4iQ
         aulQ==
X-Forwarded-Encrypted: i=1; AKwUvBwD/vhHvAJAAngQRlJPcSt0H87qdDwYcLLraBG1G5ybuusPX+/HLbV428B59dxP4GKyIEJDNXo=@vger.kernel.org
X-Gm-Message-State: AFuF++lO/WZuuAABcESdWTbKM7P9r95/Bbh0o62uGUV0yn0LROiI28HN
	kfAcXK1c5HHaefRj07seO65sEJEbPEfEKqQewn17Jp1eSOYfJrXJ9sY=
X-Gm-Gg: AYBFou0MuGkgpbLvtp5eUh5sMRilXdM95Zt79GBKp/wszujK2eCn0WQFUv2tgu7N5x8
	w4P+SSXuo71StzTB2PK5Nd9MOKUVtXK1NuqcocRZyW8FGY08QbNRY7htrmbyFU0PEnUZ5kiHlCN
	fmWQ42usOZneguh3YYgWwhjcON9hjQbFP+GEWkD+FRqPHOKoDdjnh0fJlzFFJVTOO+lJc5QO4Fn
	An8PqUC7W9tJn249vFNrrr4eX9exAvvK3K7PWEMRM1zfxoSAlDB1ZB6Ts6xG67mpeOVUl6Uzb78
	N4QgoHGWO/Sgi8ATt1F+nPZ/LWP9QMjD/pSBWxrrCa4Q/Jlb4XhOrv1miNLEAcOOGg8BbajNxY7
	6DlGeUxrMJTq5yaPn3pu7GP9FrL0ax5vhDqyRpe7V4mcqsg0B+7jSqojjfF/+bkM3RNZ0JoD9Qb
	dvMF8XEwWv0W8iiWnxgRPdBgQpsANy5ePnqgyuIR6iDbqi/rHb+zNrtZ1FXV5l5xCidx+1HBAip
	bHnRiDNUCdKNpZ3tFJPNSpIlyu5N3th45E6HYpUFF6zeJwzl5qDLscuWG5TA3MvQd/jH7WMj1gr
	JmfroTflQmppF/5g97Bc0BSfGt9AcJYFFp4pcnA9bPCtdA==
X-Received: by 2002:a05:622a:1a96:b0:52f:ab8f:43dd with SMTP id d75a77b69052e-530c871239amr28491771cf.38.1789084478245;
        Thu, 10 Sep 2026 16:54:38 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca48912csm6100771cf.13.2026.09.10.16.54.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 16:54:37 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexandra Diupina <adiupina@astralinux.ru>,
	Christophe Leroy <chleroy@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 3/4] net: wan: hdlc: close active devices before protocol detach
Date: Thu, 10 Sep 2026 19:54:29 -0400
Message-ID: <f5f0519e82a7b8bbf314dc137470f7cf931e320b.1788128904.git.mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1788128904.git.mhun512@gmail.com>
References: <cover.1788128904.git.mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ff3516442768 ("WAN: HDLC: Detach protocol before unregistering
device") moved protocol detach ahead of netdev unregister so detach could
still use its state. However, detach_hdlc_protocol() calls
hdlc_setup_dev(), which clears IFF_UP. unregister_netdevice() then sees an
already-down device and skips ndo_stop, leaving an active HDLC device
running while its driver releases resources.

Close the device under RTNL while its protocol is still attached, then
keep the existing detach-before-unregister order. This runs the hardware
stop callback and the protocol close callback before their state is
released.

Audit all current users: c101, n2, pc300too, pci200syn, wanxl,
ixp4xx_hss, fsl_qmc_hdlc and farsync unregister before releasing the
resources used by their close callbacks. The farsync probe unwind can
disable interrupts and free its RX DMA buffer first, but fst_close() does
not use that buffer or require interrupts; the card is also in FST_RESET,
so fst_closeport() does not access the port hardware.

Fixes: ff3516442768 ("WAN: HDLC: Detach protocol before unregistering device")
Cc: stable@vger.kernel.org
Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20260806020541.2011936-2-kuba@kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/wan/hdlc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/hdlc.c b/drivers/net/wan/hdlc.c
index cbed10b1d862e..a38f90d3006ed 100644
--- a/drivers/net/wan/hdlc.c
+++ b/drivers/net/wan/hdlc.c
@@ -263,6 +263,7 @@ EXPORT_SYMBOL(alloc_hdlcdev);
 void unregister_hdlc_device(struct net_device *dev)
 {
 	rtnl_lock();
+	dev_close(dev);
 	detach_hdlc_protocol(dev);
 	unregister_netdevice(dev);
 	rtnl_unlock();
-- 
2.47.1
