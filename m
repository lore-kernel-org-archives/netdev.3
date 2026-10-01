Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32BA350A05
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 05:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790830874; cv=none; b=uimXc3tkJWPSEpQEWJueWsbLrsius+Yr5rK86zdNczSz2TE6RiL8ZARgwfK9CYwmCvp6sYuThs9H91KzifHiIzE5TeK0O61hNQT27uC8hAqq0k9ucKrrhbwiy101v94eGUQFc+Qr+s9V6sVKR000Ga5JqQvB6vaC/Fp+7pCuUOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790830874; c=relaxed/simple;
	bh=s+oMzrUKFgXpDixV7YFkJvkS1XqGJl7Qp7fnv5b4nUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vDdTBP6XzifjtdI2uliNAYrDpZmZj88Vpb3V60sgbhPe2OGxhdWY1bMhYolIpvuHpKq2lqIr0Uw3kUBorMg7HnI8bO8Spu7NioTJnxqzJYx+y4DRbkr/Mr0RIG5pbymzrxXSjR/d+kIM7psq5N4lz323UGRrzLlC934C9sA66Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oAuypULY; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAuypULY"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed9866so43659675ad.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790830872; x=1791435672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lJGKX+MspRpF69/x1f73Jj1LeEntaRoySY/fuMe6cXY=;
        b=oAuypULYvncq2/IX8le2DEbEkPfP1dUpUW+8BTyckhiQ1oolsVV6L/NSHLnCauIvNf
         EQX9GW7j9fB4UpfK6TSoOQh6/oCm4+K4bdzZwh61VEdBbrDaglaCTUXDDYPBrS5DwTrF
         V1KA2nB4NQVeeuZ0fhbgdpWN/8Kv7tpKmNrxr2dCfz5pYVgaVA2OtXisxiWN6aRLfyhP
         IZiPP0bGuIu4itDAlfGBX+etyQtPBKrPRco5JnhfpiG/bVGoEr70z0PiLpbbhF0QaDJQ
         jHN2FfGuhjk+QcAKsB4IxN295Mkz7rWZQXzUbdLDiUYjT3cbaGgrnDhRA3w6K5xL7T/0
         9Z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790830872; x=1791435672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lJGKX+MspRpF69/x1f73Jj1LeEntaRoySY/fuMe6cXY=;
        b=fWEYo1lA5TtVcfILQV+m3F8QBreNX+H08YCtL4BjZMDn8inO4wFXE+dkQAnT1xMYmk
         IgCOkZjOo8hGdXrDL593X4Fzyz42DKlv4xi8jhyiTrEVTVrysu3Nay8BBX9/3MTuwcG4
         67Stn3pLjlv2jTz7qAKJkqAK1Us9BterQSS+Fd4ASKv3d3hseVNoDbdf3yDsRF31yaST
         ETMxmtMK2hMgsHAbSbR/MPpaawtLGrf5qSXgSIGqnQijJ1HesUXN+pLclih++bW3Uhs1
         9+S/y9gBB/zoaSMNw8TwP2PTWui7ed1LarHbdYRhOkjikPtu+O1f9UTfzRRi6SgziNFg
         h/GQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4kSK/PaUf20PfxQBkdZLPm62AAVvBegbw+0jK6BwqMbvSO3UoQdXLLQaSyfmxUQvyVGVIY8k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzUT/W9mns63ZpKU+WFxZvq0JHuUTuwdl32TZ/5u4wrULdqqdc
	nOYqfT58sTXY7V6z6eQbVACDzPtr4yMwB10iltaoVRzKepAdpdLYu6Ng
X-Gm-Gg: AYBFou2727tITIooa0eqssUjxVQU82tz2U6iq9zQ57sunTTJcgUSNq8ZzI/LIYhFYAQ
	NE8kTLk+A9tDoK0E8uu6n7mUMmej4Ru2oduQBIPv5ux+2x7AeFO6oqGLjFx3loUbKGFRa3JORXD
	saO/LaiqWi8a/LztJ4hGDOvyfANvTe9TcYAMXXAsKeaH5JvdqbvzM4M6FKFjVQ1GfQfAG6CG8z7
	/ly1itYVy4zV98AXQM9lsHMb4mxq9cNJ1xaXtEowrQqnmfWfNTC1e3rSFzkrno9SyCWbh6TH2es
	F+gWfyL3zRU5MmhR10msZcRx25b+PacbBvvLMwjXL/BydGkRwBVEugp1FtlfgcKVb7LdzFWKr/g
	m/aDF1LHfHCAxmoinsYbyPu9gN8I/rXWC+lwfAshD/9vRAcAj9jO6dwVGYwFl2WSOWRu6+VGVpo
	XLxEfARjuvyW8KNxXzb/Wys32FyfwHmFqXTPKbTxE9QYLZWuvF6dXASQoLxidpSbScqrptUgREN
	GyC0vxBl4Y=
X-Received: by 2002:a17:903:4587:b0:2df:aed3:2ac0 with SMTP id d9443c01a7336-2e2e4a138abmr30429175ad.10.1790830871805;
        Wed, 30 Sep 2026 22:01:11 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300b21912sm5112085ad.54.2026.09.30.22.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 22:01:11 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH v2 0/2] wifi: iwlwifi: Fix GP2 to nanoseconds overflow on 32-bit
Date: Thu,  1 Oct 2026 13:01:01 +0800
Message-ID: <20261001050103.860584-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GP2 timestamps are u32 microsecond values and NSEC_PER_USEC is 1000L, so
on 32-bit five conversions are computed in 32-bit arithmetic and truncated
before being assigned to u64.  A GP2 value above U32_MAX / 1000, i.e.
4.295 s, wraps; GP2 wraps every 2^32 us, so almost its whole range is
affected.

The same files already cast four other conversions, so this is just the
remaining ones:

	gp2_ns = iwl_mvm_ptp_get_adj_time(mvm, (u64)gp2 * NSEC_PER_USEC);

Changes since v1:

 - Added the generated-code evidence below instead of "Found by code
   inspection"
 - Rebased on iwlwifi-next; no code change
 - v1 was sent with the wrong From: address

On i386, iwl_mld_ptp_get_adj_time() changes from a 32-bit product to a
32x32->64 one:

	before: imul   $0x3e8,0x17d8(%eax),%ecx
	after:  mull   0x17d8(%ebx)

0x3e8 is NSEC_PER_USEC.  A standalone _Static_assert() replica confirms the
arithmetic: with gp2 = 4294968 us, the current form gives 704 ns on 32-bit
instead of 4294968000.

mvm/ptp.c:219 already uses a u64 gp2 and is left alone.  The
wrap_counter * IWL_PTP_GP2_WRAP * NSEC_PER_USEC products are fine because
IWL_PTP_GP2_WRAP is 0x100000000ULL.

Built for x86-64 and i386 with IWLMVM=m and IWLMLD=m; checkpatch --strict
is clean on both patches.

v1: https://patch.msgid.link/20260805082515.4136842-1-zhanxusheng@xiaomi.com

Zhan Xusheng (2):
  wifi: iwlwifi: mvm: Fix GP2 to nanoseconds overflow on 32-bit
  wifi: iwlwifi: mld: Fix GP2 to nanoseconds overflow on 32-bit

 drivers/net/wireless/intel/iwlwifi/mld/ptp.c  | 5 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c  | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 4 +++-
 3 files changed, 8 insertions(+), 5 deletions(-)


base-commit: 90e281bd4ea3d19dd6b5af1923551648e477bd26
-- 
2.43.0

