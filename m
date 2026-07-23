Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951243DAAAB
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784790316; cv=none; b=BAbsTdIGI/X2x+/Z5pxPcDZlQIlKDFLccdarazH3UaIX7ZltQdGYBh8Cj0L2oCU+2rYBbwnQYnN+SBJTAIfTOmFgB7Q3J39TLfHArk0AOxNmBRUk6EgRlIas2N1qQHK5WKnPRsZnfGd+Yb4Cn9rrETOY3hIZ9lkMePCOnJktOrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784790316; c=relaxed/simple;
	bh=XuNq3G+Yv2I3DF3ZG2/dgXZRfnA+YzIoyn5M1LQXQKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cyOzSQZ+0D6LEyus8p+RNuC55N9m1piQlWCq7Mkw8oLr0bRhQ0gxW/Fph5LVblYPxeRFMmtz47S6sTCNGjdVdIKcTUzRliV+9v0t/WnMLHi9YgO3jlEi7++DidZZlWuIBSKa+/om5GHOrqzsXytSenAEm1gNXGAYMu6dz/ubMVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZld4/gD; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZld4/gD"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-37fb1883f59so107947a91.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 00:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784790310; x=1785395110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iRwMS1yYg6x6c1ic3bqTI4TGm9UD5nBCdmyRzQBTNus=;
        b=AZld4/gDud9PaYADiaguufc7UUEe6TdP2IJL0SH7JHjbuPSovDMKgisAXoEqqDo5RL
         N2/ZC2oYo32kXOYhRqKpzSGrmN+Eqy5eL/oMC6ylRXwZYg5/sAVnEfhaLa+nn8PN5xYy
         BSHuoHidkoQBLuRDZ50wps/vvqwDm2PCnQq1F25s4jRXPGvdGZ5AI8kOCLuNviYtBLHE
         j5/wgN1K1ftbw1qIYcCMcU5HQAQeXl25cVmpUjEYl/HgcsGxsTtvW7Udk5isbhmQkePS
         dPObUKBDwj4c4JAFqZcptufr5WhiBUyGLE/xSMhSayyvny8aSNToEDucQdGvRJONxb3y
         WfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784790310; x=1785395110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iRwMS1yYg6x6c1ic3bqTI4TGm9UD5nBCdmyRzQBTNus=;
        b=ETjMihZpGjTTZY1g72GcahS3MKUP8vRTsZQDtpXn75V9OeUwCAfFwFBeaHVZff5OiQ
         MQDRgeCHDKsOWvYJVKzs0shMhBmjJN4NTT8aBAr+ikHDm/rHSQHA2DMdVS0PdUrcGAdQ
         zr/We/3q26KIT//1MfPaSHtaa3sB5jG0yZgfOvaAFR/3JFwr/Gt2cXJAi8l5T0RT3+Ah
         RwL4gKLTjOczbWDi97EgxLVKwErRpqdymD0Svvk/RxBzlgh40ws/dVJTSWGOoVW7pH7M
         P11cdHyCxTNFyD0WOK1m4uqTvBfYlbaKPXHqf+S6AlA3AHfsVK1mf4Fwh4YOWg0R34xz
         ZTZQ==
X-Forwarded-Encrypted: i=1; AHgh+RpUMlIHcFrqX5Wg2r6s9TA1ciecT7qbtg7Cg8Sc//ALByJEvFGDO6TemZf9KhGIwjx5RNVTPoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM34NzDvK1ppZBo3WlcHJDKsw25Kg7vZYdTT33rPuU9CrSbgcd
	aumQH0XScaI+1/OchX7kfBDZ4aSXuilP89qv/fmDC4BtRpxyhdfpAZfu
X-Gm-Gg: AR+sD10UsnImlc/t8/iBtHNg7BVLMTMRXEJIb4n2J7UxJBIpAQrfLlW/Hf1dxOkeEGj
	PEs1TFrCmYj+setsUYZMykkIGwIL7kh5FQQoAd/W6UYza5pjGzuWz0vCaVdqnVzjxGqVRukW0fS
	FLRNrf2xIg6s6d3OnstOH0+RddSl7vWX0Q2e2PbK1kNxMowvL9bVDbMcgwjC2k7sLBgZ2fowJcq
	hCtdQ8YG8TcyorB/5HuKUf5RdPKhq4uGvbTV7XMWeHeyW8fw3R3xeVbXgd1shFw1SvwVelWS9CK
	sxfRIbb0LNzevkajM/QmPKxL+RXpow2nJRE0kYsH4agnfVNaAF7EYSMhGOOEWJ0mMmy0QidXvs2
	aNJhWOpH/Ugfv+/1BtZonOS8siL0Hb9N0m0AibUWPY6Kyqj3vBkVnbW0FKBa1IxrsPIsbCXvBRk
	0kpWIuU6lAc5+rPYP4hZlka5BposovgvFFbA==
X-Received: by 2002:a05:6a20:b786:b0:3bf:6856:d8fb with SMTP id adf61e73a8af0-3c44b052073mr1929910637.29.1784790309632;
        Thu, 23 Jul 2026 00:05:09 -0700 (PDT)
Received: from localhost.localdomain ([76.86.179.124])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3149198adabsm6247910eec.8.2026.07.23.00.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 00:05:09 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] igc: Remove unreachable break after return
Date: Thu, 23 Jul 2026 07:04:51 +0000
Message-ID: <20260723070451.6545-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The break statement immediately following the return statement is
unreachable and can never be executed.

Remove the redundant break statement.

No functional change intended.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2c9e2dfd8499..6252d4b68f88 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2528,7 +2528,6 @@ static int __igc_xdp_run_prog(struct igc_adapter *adapter,
 		if (xdp_do_redirect(adapter->netdev, xdp, prog) < 0)
 			goto out_failure;
 		return IGC_XDP_REDIRECT;
-		break;
 	default:
 		bpf_warn_invalid_xdp_action(adapter->netdev, prog, act);
 		fallthrough;
-- 
2.43.0

