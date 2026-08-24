Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2983AC0C6
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561447; cv=none; b=jAeMMF4atcfkihdqHwemqKGU3xpKD18LwtdU++dSKAszYK3/a/sgIiNmkdhg8xP2vTxZktJtC/kmJ/UrxfcPxo7xn/RHnEra7EOF6lujU/TMGWtaE8yi7EVyhEv8ZwIvLwCRaQDV01GYQlS0M5ooEcZL9OicTdXQjbuKajeIQQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561447; c=relaxed/simple;
	bh=YXSKEL1kXywwTN098AI6Xt1RZ0wPlVpHVa13+yck0YM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FquqzKh/Q880UXefg/lTXfWQMXfFZIRkr9WE6RX1aIptxGb5vfgMKjauXpTbK1XXUtCeBFF/zn8Uzpw5Wby8MJNIVth7n3XM+XkjjpMJ+uwKboanDpR9wQC9q2dLC6+unxe+Xr+UOkOiPL6wBqRtaN9dlKrs38lgL0dFqKL0MbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gDswR6OY; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gDswR6OY"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so2071899a91.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 01:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787561445; x=1788166245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wgyMWZFuE86t8ws4amEGR1MZfLTy9aFBDUCS+pAKKuw=;
        b=YIqLLD3D2W0NJs17QeIml/cRfXtCaSdb1z+/i9JLjVRp/8AzOB+LlOapFXUy42Uytx
         GFRRGlrNw7ZzSG1JoOLtkmlUlIMo5kCCNCQZ/NIYf/CvlSQdDn1Nn5LTFeFjm+qzWqIz
         HyXyy8iDbFKG/ISY/fctZvLqTC6lhKER4PIwyMXgJ94QdNpQ5D/tD8YXDyZCl/3Wbni5
         qdrT4eE1Y7CUyJo1rxwHnBRU1/xrz/+ub5djRpM79ckNni2xFNwZKQDTm1jfw7kqWql9
         X0dvPEsu45lH9M3ECPFolXlLvhA2oc/mMhnfEqDGc+0hRZbKbN6ZTvK+9LMG2Ni3okzX
         Gk7w==
X-Gm-Message-State: AFuF++l+6JoTkLeFZ6AOQx2U5VnDzDGt6dLxp47XmKx1iCS2nhtY34IN
	BogNKf5/OFUxOBwT2OuaiyHSVCRAydHfszT+xKleJsVHyMSynbwy90e1PCXAcd4oSBQHlWh+WJV
	nA4QswKKUKLuCB9nRo0sL17wJGH5yBiHJjtb0dH0bbhQlE7X0xEna6s5A87/+MDvkVthfV2gA9X
	xspvYHs2KziJhk0+dmSziU4Tha1Xf4F+OMakih95nZaK1hSRC/QuaTwPp8DTv8g7qflZ3M0NdcR
	wZa75O4jw==
X-Gm-Gg: AR+sD105edXz45/7i055TC3mVfSgSphhWFTcvSy0rQ+4VHZPbQGNXyO9MciziJDsWjE
	wdn3EpoLawsZAA2M4I8GfuZzn7dCehshGv+52/4CIjF0+PmGUEFJt67DmWMdILAlir2I1fh4t9d
	Gl2GXygkWOVjyK0mY9Pj+/Ltb6K5KHiog57Y9tYpu+1hI2LDFpVQFBqQqlNROh89Yn7lk+RrlLC
	56+gozoN94/a3EgcyJBUUQMDj4T7Mvwq+TvU9wCcWy6GVyzDtTfqoe7/sNl9OCDnS8rUorBZEGh
	eAimqFYo9sruasScp6OJtdY6A4/2bTvHCpz1bhIFIRK6JNdL6YouQPNTWIGbtswd+NGbvn3gHl1
	I1Pg4HY39LioOHIddVraecVBM+w0L0d75NmBcFm+kl1xCBZJywGcSEhlbeCSPxUgDSik28mWmQc
	cldqrq9UevxYJwwmhTb0hQhUCi8u4c5biq1g==
X-Received: by 2002:a17:90b:3902:b0:38f:240d:b857 with SMTP id 98e67ed59e1d1-395c3377f59mr38093914a91.2.1787561445187;
        Mon, 24 Aug 2026 01:50:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-395c9003efbsm1007615a91.1.2026.08.24.01.50.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2026 01:50:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbef1d25500so4091434a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 01:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787561443; x=1788166243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wgyMWZFuE86t8ws4amEGR1MZfLTy9aFBDUCS+pAKKuw=;
        b=gDswR6OYm0xpn/71vfEEYVW4XNWY0WLbek7ZU2Dz0M52Id7mviFTD/9S8PPmi52Cto
         00W9nWIKKH5sHCPt99rlUkbLAdhZtAw3Dlc11bIMpDrWm+P+J2EpgWCVqGflRxZ4Ejc8
         AHVt9tqdtQOzazYdPdk0JtrX70pTmOxTyz9Qo=
X-Received: by 2002:a05:6a20:d74c:b0:3c3:b57b:645e with SMTP id adf61e73a8af0-3cd2fe23ae8mr50355204637.5.1787561442952;
        Mon, 24 Aug 2026 01:50:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:d74c:b0:3c3:b57b:645e with SMTP id adf61e73a8af0-3cd2fe23ae8mr50355131637.5.1787561442561;
        Mon, 24 Aug 2026 01:50:42 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860fe08csm35865782c88.8.2026.08.24.01.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:50:42 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net] bnge: add missing ndo_set_features
Date: Mon, 24 Aug 2026 14:20:28 +0530
Message-ID: <20260824085028.1174150-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The driver advertises togglable RX aggregation offloads (LRO and
GRO_HW) in netdev->hw_features but is missing the ndo_set_features
callback, so it is never notified of a feature change.

For example:

  ethtool -K ethX rx-gro-hw off

is accepted - netdev_update_features() clears the bit in dev->features
but the driver never reprograms the hardware, so the TPA engine keeps
aggregating and dev->features no longer reflects the actual hardware
state.

Add ndo_set_features to reprogram TPA (LRO/GRO_HW) and the RX ring
parameters when these features change.

Fixes: c2effd12c96d ("bng_en: Add support for TPA events")
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index a4288f0258f8..0973cc25a3ec 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -3267,6 +3267,33 @@ static const struct netdev_stat_ops bnge_stat_ops = {
 	.get_base_stats		= bnge_get_base_stats,
 };
 
+static int bnge_set_features(struct net_device *dev, netdev_features_t features)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+	u32 flags = bn->priv_flags;
+
+	flags &= ~BNGE_NET_EN_TPA;
+	if (features & NETIF_F_GRO_HW)
+		flags |= BNGE_NET_EN_GRO;
+	else if (features & NETIF_F_LRO)
+		flags |= BNGE_NET_EN_LRO;
+
+	if (flags == bn->priv_flags)
+		return 0;
+
+	bn->priv_flags = flags;
+
+	if (!netif_running(dev)) {
+		bnge_set_ring_params(bd);
+		return 0;
+	}
+
+	bnge_close_core(bn);
+	bnge_set_ring_params(bd);
+	return bnge_open_core(bn);
+}
+
 static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
@@ -3274,6 +3301,7 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_get_stats64	= bnge_get_stats64,
 	.ndo_set_rx_mode_async	= bnge_set_rx_mode,
 	.ndo_features_check	= bnge_features_check,
+	.ndo_set_features	= bnge_set_features,
 };
 
 static void bnge_init_mac_addr(struct bnge_dev *bd)
-- 
2.47.1

