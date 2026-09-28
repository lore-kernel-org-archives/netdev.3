Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEA917D6
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790569192; cv=none; b=So4tZivQl/98tlaKN/3Lsr2hxZS3JyIXhg8swmYvJHJUQG7I4Jmh8Xwcz7kmAIpGE4JwmCRxOwbf4r6S90ZKnHCPcSMZziPZxKENDYQFko6+eYjjl6p4lB+MRJzUKtpLKRJAlCFSdEXmr57HNuqsdityHz39yNSPrOv9qxmMmCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790569192; c=relaxed/simple;
	bh=H6jxnY83pU05l9Y7KOvcI/JyPlS2RkNQhIFydXafmQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDYXcVsfECFE2m5AmsXgxQ3XXaHPouBR8ckHrjpwmWsT8/tXQ54FbFlGjX6xAayxRrm+7YwOJXdeULdEeTIy2kGe2Vdhb6QgYLOwI9WPE6G0EJ37+vbunBoEdv46nk8zV/1tm8ONBBd/BIJzJbdo1xT4DFi3AMcFABX+U2+Bi3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hjzalvJ1; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hjzalvJ1"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-86927f9ba4dso1083049b3a.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790569191; x=1791173991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vhZI5F0LVThmbgOR0wsCTrHX7316P9JyUbLN+QZD63w=;
        b=beVE/UVKIhgdeZlX7O0Qj4d92O4qEcyFuedwyGyGKRasIrusr7bvQqwzCtObP4a8o5
         ZsDVyoSd3fC92+kq45Wg1gabAmV+RXzFOzJ1HkqT7vPZJZpjWLA6FSYY8zrrR0W8NRUA
         RPlLubrykJlIOOmW/v/Qz4MR7Oq25FLmI8xo0Y8g75wC9qwOlahUJ39Ng8k9EApe1fYO
         GrXS0SGDApMpO4Q/JWAPWh65DeoFUniTcPBo55lxCxHwDmDUMElq08WlMYZMLCapm7ol
         NGWtI4MlpwgEW/zuT3HzpHZBh2il8Zl4Oq6JOJBCPoLMoY8TILccuJA7mGXixTNPszq+
         01aQ==
X-Gm-Message-State: AFuF++kuF7EbYPe1GAWRwaPAQ/1eV2aLEqbsoglquwUhdnVTEMq5pEY7
	HjDJlIkWPlz3CTJWWa96pTA4It97ok/SUcSEHPp2UKYtpGI7GUmXBx7qZlquQfxPrD4mWYBvoW4
	qu7NzfMbiBuuqcuPLH5AVcwNuj8PIHzyhE9nimT3rnY1iPT1q3IBeZOWtpUsANBA5mh+dARDrmL
	dyMtKBOIPM9eebVrc90/N/FF6Kbn+YIsoMsrIzXeVvfa1mKIgHMsogSJzaRWnyboFd79eT0K7f1
	Qit/lVmwPs=
X-Gm-Gg: AYBFou0kLH4LHXsSxTF+qzMRAog4aDIg7uV5+ksyc3OsqK0oZdnnMvKWlNMMHkw66FW
	UOuBlnVzGMsdjjOvWRzKO2jLSUttFB61V8MU7stytX+IrRNn/OxvK/K9vz2oBt15dez6gY/qGjv
	QwPUYDKPb06tUPGkZlXd/wsFyDnA55+pwNsZPC1aha9GUDe4ImRVifbJOcwJSQfbS6v7oZPnuGw
	bv5Jp9ii72+0lWRcsxrS81nZ4P4enIu20iFzuzc1PIV0vdNBTdsAO7zG7t/m4s1JJnhxjmIs7lO
	LDL5bOw/2bAcVQqMjRCNs4H28mK+NyJcYGBkTtwCm6AWCH3+Cx1j7kDZTGzFxvgNJWmQDZyyrwU
	LaZj9B0E5tOm51a/4jBCrlV/bM9XfWqizBdLy9G570uoiX/LxQva32+/eeupP0KX/2WPdWhxPTF
	Z69h41oegYYsGb9ppDt3Za05NDFRJq2ZOvOzo=
X-Received: by 2002:a05:6a00:3285:b0:874:708d:b627 with SMTP id d2e1a72fcca58-8802bb8c71amr5789089b3a.28.1790569190614;
        Sun, 27 Sep 2026 21:19:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-880d6025c93sm3886992b3a.8.2026.09.27.21.19.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2026 21:19:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1493b09d6bbso317675c88.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790569189; x=1791173989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vhZI5F0LVThmbgOR0wsCTrHX7316P9JyUbLN+QZD63w=;
        b=hjzalvJ1YnRJ+HgSFa7N81PK/Jf/mvnjktj1yJU6M8LruKEf6HXU91D+89D2e3HIae
         HE1jHjhAq+dJ4+ZYsmQyTXk0DR11EoSZnVAx/ymWy9MP7xiJlRF07rAPtMxGNd9N0Zu3
         xEyB0d/wI3hoRykIaAda784e6cfHkHAaJx0ho=
X-Received: by 2002:a05:701b:21c5:b0:145:5c4:6500 with SMTP id a92af1059eb24-146ce1a9f0fmr9116802c88.1.1790569188844;
        Sun, 27 Sep 2026 21:19:48 -0700 (PDT)
X-Received: by 2002:a05:701b:21c5:b0:145:5c4:6500 with SMTP id a92af1059eb24-146ce1a9f0fmr9116772c88.1.1790569188188;
        Sun, 27 Sep 2026 21:19:48 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-146bb6551d9sm14393222c88.9.2026.09.27.21.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:19:47 -0700 (PDT)
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
Subject: [PATCH net v2 0/9] bnxt_en: Bug fixes
Date: Sun, 27 Sep 2026 21:17:03 -0700
Message-ID: <20260928041712.3467803-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patchset includes fixes and some required refactoring.  The
first 5 patches are expanded fixes and refactoring since v1.
These first 5 new patches plus the revised patch #6 make the fix
more complete and address v1 issues reported by Sashiko.

The first 6 patches fix ring accounting logic when FW is unable to
reserve all the rings requested by the driver.  The driver will
scale down the rings when this happens, but there are multiple
issues with the existing code.  The first 6 patches fix all the
issues related to this code path, including resetting the deafult
RSS context if necessary.  Note that additional RSS contexts and
n-tuple filters have similar problems if the RX rings are reduced
and the fixes are deferred to a future patchset.

The 7th patch is unchanged.  It refactors a bnxt_clear_bars() helper
needed by patch 8 and 9.  Patch 8 fixes a possible issue during
driver init. in the kdump kernel by rewriting the BARs after FLR.
Patch 9 is a similar fix int the PCIe AER code path for non-fatal
errors.  Both patch 8 and patch 9 have been revised to address
Sashiko issues on v1.

v1: https://lore.kernel.org/netdev/20260831024342.2161156-1-michael.chan@broadcom.com/

Michael Chan (8):
  bnxt_en: Clear bp->total_irqs in bnxt_init_int_mode() during error
  bnxt_en: Fix bnxt_reinit_features() when irq_re_init is true
  bnxt_en: Refactor RSS table check logic
  bnxt_en: Refactor IRQs required logic
  bnxt_en: Reinit IRQ when configuring LRO/GRO/HDS
  bnxt_en: Fix ring accounting and validation when rings are constrained
  bnxt_en: Add bnxt_clear_bars() helper
  bnxt_en: Fix driver init in kdump kernel

Pavan Chebbi (1):
  bnxt_en: Re-write the BARs following any type of PCIe errors

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 418 ++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  10 +-
 3 files changed, 295 insertions(+), 135 deletions(-)

-- 
2.51.0

