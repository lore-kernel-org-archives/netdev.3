Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CAB4E06D3
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407196; cv=none; b=kmaSQI20gtA4kCjcyNesvSYk5Q1+8YD3LJmd9T2jRgyT8JbSQNekYRKnj8V8vg7KBCME/IsxUAlHV7BvjGfB56xH8uhwka0UJPwJgnFdv2DeIcXvusfjIV4Cz0rlby1GjN4plePEDhPC5JQ38XZDkqy4SFrJ8JRM3tTgyM79nLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407196; c=relaxed/simple;
	bh=fhUwoTKLYGKGuq8P3S7f5SHePS+ZUOdqU5pfS0O0ebc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyrNmvJN5COYVY61W4Gx2MKBSy6+jNTflnClDDtm/s/sR9vSOoSs0Xp71tarbsfcSYteRZL8mCuCN7dDRzY6TGgbpbAc+KZ25UoNU3/EktqvBp/Pr7eioNoA/P9+LAt6w1lNdo/Zmy/Lt7pMZsUaDkNRPld2bCQUxRu5RpEGu3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=kop7owX/; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="kop7owX/"
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BD42D3F2BB
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792407187;
	bh=q8A8Zrm0+PIOnWjaNbzg+cn4gn/yB12bYA1j7GbTog8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=kop7owX/Yg9/btmEfWncmrLDU7kPjQx1Lwnlb1ikEuqEmbyVh7gv4qD/F8HC05bEP
	 Vl0hILNXET1j/kw44HdcxiZY5uR9XY456UgVYVyv0XVK2Oyyv6DK6ja+HpbhJC43GR
	 I85JECFQG21j6F7Zb43x7TOO9eGnHLT3t2uhQt8erMSzhB/ZKCOxK+E1nds8WMn4Pb
	 /JifCAa6cW9M/iHgoXqstnjRN+Qt4YDDR/CK41fiC4tEnUtcBKlNGzZUwqdulzOJSi
	 6xFI2CqMc4TNMb4HNlHHHrCYTGDVqc0W3/SWtjUqSMzn3lf/y1YfoWc0MHqiKXPxCe
	 i75EW0eNGCC+7o/08QIJ5ZOutJToxD7FS4ogizOBTrUs97+DBFD6yP9bK9xbgVwUBh
	 EEtMZqFhHbhHNOUBIVlK8PIgjG1IptqCdc6qvGttc8OoOq+K65NW4H+fUVICKap4ZE
	 Y+qevzrRYMvzgA6nph/8ljHLlEFJpbUOrselseicLh3iD+X8MqStNccmbDV7OQG1M7
	 S4tsvtHnrJBKwK2F5Q9rlu4auFQ9DPPUmFNI0nP42DCyNL5AjLBFPJuga/4wvmt0CE
	 dGmclO+x57SoyIiwId/f1sY34wDdM+RM/SNQlOh53LrScwp6ko0l1z05yTRGD8r4Cz
	 EEM5ED1pvHLN8St+IDjszi2U=
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48afcecb035so615597f8f.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792407187; x=1793011987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q8A8Zrm0+PIOnWjaNbzg+cn4gn/yB12bYA1j7GbTog8=;
        b=QVPM79EaL/6wYQ/FdkTczFXmSOs9YQrd/0zaMTrE3fSBtMZR+Hbs7cHhiqPBmHLM7V
         DsBIzwlWEOwzwl7iEcyXuc7ABrm/0Z+bSanJL1eglRsGOwozC1Qe2flBqMH7ZAPwdZTE
         YH3Kc5no4osM3VMxgSgUfVXwkZv7LbCsOGbwOy+Op7QNRNblutZxU7TBkHcRuumJLLvh
         FRAqgjJz2rBP0EOhGdKK0SrEBCm1X9zabfLzwTfl2yUKIOTK/HsZE5aM9J3GwLKsk+8u
         Le09684Jk53JWjCx4JzZWPtqk4zFg5fllTkUHJqbMIba8IMPEIQhKFoDrcVhdmKZxsxi
         dicQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/DsI0GOHc/UKbf/bYv0zjBDBIpZ4S583puNhd57cDIOQL7udHy/4LxDJT76wkXRYLDeYI18M=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/5AVFnCP72S04KBG/9IPLM/VjqqJHOA1pFn/nr9WlZIX877fE
	svhttduWxPKCKljT+2piVxwI+0LfsH4U4Nehhr7EFCp3kN/E7f5rANXzVuO/Z6R2NCJJKUh59KK
	NCFvYN7LtVrTXf/V8Zja4oWaHDsPilwhq2Dp9yw+VMc1WEpvHvavGKvoxjTCOeggMmPyNjtBCag
	==
X-Gm-Gg: AYBFou3XiT8hRO1DkI1nceV1d//9vcJdnoKyQIRVjUUFvzd0QdVwSEafuGsfd5+qZtz
	v5aHDc0OHfXkPZAdHlLmYxfwZC+KuzPrL3B9DRKuQbOh3A5SHhiCG4/+uNU02TXaLy1KTCXWD2V
	6cxfJFZBWjoSFVB6fsMhrJd58zW1LySsP3DSJQnNgAElpweeKOPz/WuGy7abA5B31cYPQFOrC6r
	mlA3peNZGxjW4cv50ImhldpGvE1HV3dIWeZRamkZx05Dw6ww0ybO2kkOiVSfoCCYQCFGLUDQ9po
	MUXDILWqzNZbSIQAYyPlNVBimJOyiaPZGFcq4T2sc5LS9qQuT2EVY+gKPXf4t9hjlKXCyhZfVso
	5OI0RYxZlrxcf7uUBdjQavATdqvmF2Qd4rqc2RWreUZoD9GUMw+GTIX6m8HqRrkU29t34XHMHfb
	/VZ5PfTk8GAB+HyLCKd9r3FSo0jkqyOoRwanx1XlkKaefl5h4rCyEd8/t18pEeQEqPPdcs6Zv8Q
	0OQ9iLcgzu7ElJUSQvyEg69UMcVbJTJCnz5zarL
X-Received: by 2002:a05:6000:298d:20b0:48d:f9dd:e3e0 with SMTP id ffacd0b85a97d-48e07bab931mr10390564f8f.4.1792407186236;
        Mon, 19 Oct 2026 03:53:06 -0700 (PDT)
X-Received: by 2002:a05:6000:298d:20b0:48d:f9dd:e3e0 with SMTP id ffacd0b85a97d-48e07bab931mr10390471f8f.4.1792407185140;
        Mon, 19 Oct 2026 03:53:05 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd510201sm23238930f8f.55.2026.10.19.03.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:53:04 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dan Nowlin <dan.nowlin@intel.com>,
	Brett Creeley <brett.creeley@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS)
Subject: [PATCH 4/5] ice: clear DVM boost table before scanning package hints
Date: Mon, 19 Oct 2026 18:51:54 +0800
Message-ID: <20261019105155.3793063-5-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019105155.3793063-1-aaron.ma@canonical.com>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_init_pkg_hints() clears hw->tnl before enumerating package labels,
but leaves hw->dvm_upd untouched. Every subsequent call to
ice_init_pkg() during reset recovery appends duplicate DVM and SVM boost
entries to hw->dvm_upd.tbl[] until hw->dvm_upd.count saturates at
ICE_DVM_MAX_ENTRIES (48).

During package download, ice_set_dvm_boost_entries() then issues a
redundant Update Package Admin Queue command for every accumulated
duplicate while holding the firmware Global Configuration Lock.

Zero hw->dvm_upd alongside hw->tnl before enumerating package hints.

Fixes: a1ffafb0b4a4 ("ice: Support configuring the device to Double VLAN Mode")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index b71f3fb791db7..a86ef097826d5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -2101,6 +2101,7 @@ static void ice_init_pkg_hints(struct ice_hw *hw, struct ice_seg *ice_seg)
 	int i;
 
 	memset(&hw->tnl, 0, sizeof(hw->tnl));
+	memset(&hw->dvm_upd, 0, sizeof(hw->dvm_upd));
 	memset(&state, 0, sizeof(state));
 
 	if (!ice_seg)
-- 
2.53.0

