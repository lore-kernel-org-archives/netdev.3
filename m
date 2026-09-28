Received: from mail-oo1-f100.google.com (mail-oo1-f100.google.com [209.85.161.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2524232B118
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790569196; cv=none; b=QLstt4X3GBKwlO5Y2Klo8/Xs40Fd+9XtOBDXAHfukvOCHbLs8lfxM3lPnNDgf3rO8/NsPmvAkGklEH3ZfkUowsaLG8XJ8u+wYa58dFIKCc0Tqrx0oV60i2suhmziQUlacNBwjDPR2YpDy7kyfoiMOgaAQ5mOYUEUkRdCwS+IiX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790569196; c=relaxed/simple;
	bh=CjFKyMGR3xvPRkxJEJ+bsNn+FR5uQxr1wfyjA6X7+Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gusq4eGxfCvgolBx5c45ItYXZ0Q7k3sZH7Oy2LW5BNpBSXRxa+CFC1M6ifaIpLcCpKvNegxo2+VVyBxUJ0dzXXCyoPlCAbOnfXC5lZDIxAe89b5ARyKQ7321KzdS5nvO+2OELEEPt+ieWveke9df/5117xWEjyXBV91Hc/4jgVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gIOEzp0X; arc=none smtp.client-ip=209.85.161.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gIOEzp0X"
Received: by mail-oo1-f100.google.com with SMTP id 006d021491bc7-6d92238ce78so208605eaf.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790569194; x=1791173994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wUF7iarEcPvJ/w+c9X4J2tdSDbvUNek0CcbbKycBY8g=;
        b=IHAKyY9Ih2DSgFr1c+TbRBZ8pGp1CJpdybMYGorXIo3vMasi4Gp/OItgS8CC4NkPKG
         Em8cLAlHTdVrCi9Xre9P/yzohA+T6tolem2p4zJBu07n3UEL7qkXhl2hiJ9f1VmWmL29
         fqI39G+uEdZZkZW8Vfpmtyg5GhA2YLDrBgMZ2KQFKmAa1lwA9EEV9Mig2NSYhSfnxJk/
         bUR3pRhl9Qml82+FrdhsyIs+h/r2lFFQxaLDjPksl2RYGrLhc6nuQd+GfpSsYNWSR4tf
         A6SyK0YfScl43gCSIXaopK2wJ1vggDGBYKxW6MocSIQPRn5ZTK3Sgijk3Q3WsY+aK+yX
         WVww==
X-Gm-Message-State: AFuF++mO3fyje72mMz8o81TF+0ffL89SiNewJQ1cYGxfKDWMkJLYlIPj
	Z2vs5VqyamZNkie/pv9BZY+lLaSOmqVgD3SoxwVa9GtC75lCYYuffl+jd/MtyGSCijOh+FQa+j5
	IIV+tOKQU9xFMEb2ZRRpsfXDSapMicKjaZP6dXjQ0JQDZi0E67eVRqKhMQoEFrcSA/F7YogYwPz
	bK1wpSKiqMofNqu3wx3902arYDuy+dM/2DnwHiysrRyN6ZLMpXmM7l35PYBxcA2adA0tghAq4Xu
	ESWLZhAmaU=
X-Gm-Gg: AYBFou2USD96GSg48QC6aiHK5KZWhmqbi0yEfxufGCt5fRI8Rm+cjEUa5zljMjPe1kN
	N8Zrt/icA2qf2zR1lDZ4RWfVpYG2skwqsmHYsOxVoo2kM0s8AeLqqub/p3M3LOdKYuDrPNAnM6U
	X0/Y4ARFWgyo2Hh5+lx1l2VVHIrpqq4IdBQGXRZexmkPZn8xi0DyyOs0RObdmvphs8O0Bm/8KDf
	ATTonT1DN4QnjGyCLcc4ShzkYfYhtGdCHEhaZUw51f5rKH77HpwMDFLT/IYjp4ZNlNZX5T9xtvU
	l+bRTnLHhieiIMNUpq2R5bNbtKRDgKpPjSC+szLgNczGGi8eXtq3JOsXBFVclquw4c9hj39h8Qt
	QkkY/J3LksQihuPpfF6rP45PAJUXwjFckhmzee/1IksznK0IsBn9Zn3npWjOJDE5paS79jzTZrj
	zwiqdzIKb+CrOaaKFLf50eN13Bq8N432h2idcuEw==
X-Received: by 2002:a05:6820:d0e:b0:6b7:8415:d780 with SMTP id 006d021491bc7-6d4410d94cemr11874531eaf.43.1790569193948;
        Sun, 27 Sep 2026 21:19:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-81d55dbfa28sm188741a34.1.2026.09.27.21.19.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2026 21:19:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1438719cc1eso2891291c88.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790569192; x=1791173992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wUF7iarEcPvJ/w+c9X4J2tdSDbvUNek0CcbbKycBY8g=;
        b=gIOEzp0XmrvTNFof6OTbcIb/5rdilRa6qbno2IZOCM35XidQpeibKPCyD2T6OOrwS7
         1fjoS3ZUwxTrgHdpv5dzyZDkruJOdlTxBT9XALuG8lRG8WxV7jzwZQwUbo97y6mKrqJu
         DP+566QJ/wG155K9KBmoJHIWfO5jZGs7i293o=
X-Received: by 2002:a05:7022:b04b:10b0:143:298b:ba79 with SMTP id a92af1059eb24-146d03a100bmr7686215c88.40.1790569192285;
        Sun, 27 Sep 2026 21:19:52 -0700 (PDT)
X-Received: by 2002:a05:7022:b04b:10b0:143:298b:ba79 with SMTP id a92af1059eb24-146d03a100bmr7686185c88.40.1790569191548;
        Sun, 27 Sep 2026 21:19:51 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-146bb6551d9sm14393222c88.9.2026.09.27.21.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:19:50 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	joe@dama.to
Subject: [PATCH net v2 2/9] bnxt_en: Fix bnxt_reinit_features() when irq_re_init is true
Date: Sun, 27 Sep 2026 21:17:05 -0700
Message-ID: <20260928041712.3467803-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928041712.3467803-1-michael.chan@broadcom.com>
References: <20260928041712.3467803-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

bnxt_set_features() takes a snapshot of bp->flags, closes the device,
and then blindly restores the entire bp->flags.  bp->flags contains
statistics flags that may be cleared and the memory freed when
irq_re_init is true.  Do not restore these statistics flags until
bnxt_open_nic() reallocates the memory.  bnxt_open_nic() can
potentially fail to allocate the stats memory and the restored flags
can potentially cause NULL dereference of the stats memory.

Fixes: 93e90104bd12 ("bnxt_en: Create and setup the additional VNIC for adding ntuple filters")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 51557ee6c9ad..c34360f1e004 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14091,7 +14091,8 @@ static int bnxt_reinit_features(struct bnxt *bp, bool irq_re_init,
 				bool link_re_init, u32 flags, bool update_tpa)
 {
 	bnxt_close_nic(bp, irq_re_init, link_re_init);
-	bp->flags = flags;
+	bp->flags = (bp->flags & ~BNXT_FLAG_ALL_CONFIG_FEATS) |
+		    (flags & BNXT_FLAG_ALL_CONFIG_FEATS);
 	if (update_tpa)
 		bnxt_set_ring_params(bp);
 	return bnxt_open_nic(bp, irq_re_init, link_re_init);
-- 
2.51.0

