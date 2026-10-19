Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90824D9915
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407181; cv=none; b=LRrqWJWDSHm+StGG66Ye6x3hkS7XsgjPkW++RUC2OtCkV25nvlkpgQgPSh8K2JMHyfreRqoENgw8ofTRnd//3g0xTvNG6AnIAp2WP30szj5wOt5RgQjJnWaIb+FmKdDmnMCo+JbVajxnbIp/lWa9BpTvkIyZEhg6A8SolUafplE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407181; c=relaxed/simple;
	bh=ty/ThgYQR+8E9umk7wcNM3Hc/S/Eq8NHm/I1pGnl+Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OceTd1Ocew4AiEbtHeDLhoxKHymYYfj0cjUKL3ixFX8J2Osdoq3jVk426sPQN2WqCu9pnNGf3oeI5VPWYiTxKEPxd94lLSiJR/WhvLQxg19ov16Dg48MhcYtfick6AZ8H5+jpND0RykGc35StaeGfS5JZxvIHy6f5S2wmwW9UpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=fZ8m06GV; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="fZ8m06GV"
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 757DF3F342
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792407170;
	bh=dmQ8DG056mR1G4V+Df41oNaFy9WQpehuB2fwvz+jBwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=fZ8m06GV1ZuiW7JMEa3DweI+p1KXneKFN6IQfbtmuMn+RbA5evOd7jxR9SMnPO9mG
	 3sqRWn6tUFwIpmH3eqcZXU1G1Fp/t3xCwefvGoTv+u8Bm5oPrykSgX6Zi7hZ5hg1uS
	 Tp2UnQPTcp61/RZymmrpQTtbw59zfbb/rxGN4j+bhMl6vK3D5xgGKyf6EBB3rJE5cu
	 GjdyoR4sdM6Y1fEpw0Zx55q0uh1E1LT28KM0mNMBV7x2Ksi7FCh7XzfmdiTuWlCAej
	 abgCHMQ4PzvWFDUdP3Agwt68SeCPOHGuBgGQcrT3qkFNRdeMoPQi1Ml8QJbexIjtxw
	 4WCz47U3++WgtX6FEO2xnCxWvl29AfdQCbivpJC28D17JfcvoQvqwS1PchpshJWcJ2
	 8Lxtad8aySkna9OrLpfIbvWWc2rGH2KwFQJTY24sgjUs8XWzdkyHHuu/jt+VWlE0qy
	 w3bSFdn4BbtleNOkNnrGvBIAslLF/pC4J0maDO+FOKEAQq8njMTk+bs2w3c+o2qMeh
	 6pZF5EX3Qmq52EqZ/x6GTbFlSr32z+6eyuEexB1qLICbmtdiOHWMYrbZi/MLbfpQN1
	 59R2OWwNUOtzX3fbn+3MxGrHe+BMwoZZ1JtBtSjG5ALBzsPcE34FKAo+RSCuhPXfax
	 mExhmxu7zXsO045AvhbZdb0U=
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c430f0f01so1665700f8f.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792407170; x=1793011970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dmQ8DG056mR1G4V+Df41oNaFy9WQpehuB2fwvz+jBwo=;
        b=ZNYv9qFp52TPyC1eB1vcvqcves8U8D8gIP/fLA83+p5MaX0iFF7/J9hvhjFWiysc50
         pf+mCfExyvUZvNO+05amZzo7cNHvorAOI6/5+/3vGdaa1Fqxp0aqf8MaAWwepqcUOsO4
         QYy9Wvsv1ZXnU2Tfzkz+rz0g04Mue2Ygy/0Gvgw+4+XKEBBxJitrV0+8CWXrwUWKthlm
         ZwSVCnc0uyaPKuFCBZ07tCPy+AZANeqTnL9JoFgBQolCV7eeLwh56OVFRi1J2iazgdvA
         RdbATvREl0ozH+EU5U065MeA2rI/E0AIm0P2uLNeag8trGIfvXpVJg4HkKpDNepxzNBL
         v8PA==
X-Forwarded-Encrypted: i=1; AKwUvBzv04XyYZTv9IU/W/obYurTnI6mFc/hIMufjyeILdmG7OkXZSjCyNEuKan+lFTFj+ikSeYg/+E=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8LvcBqcQTtBpBpBAQP8SR92IE1z8weuEW729g72Eq5ZuiZmD/
	w2a2Xh0/91M0assBFXwpREWS18e8jwrs5HBYiEJeSzkwAEb262Ipu+UNozA085hqn+WYzRmbr1e
	cHhizeMJ+t+VhV2FxM3nOXkz/FiQtcPMXNApmt8ibndzAoeQvyi4hVOl3XOV5Cz7ImAkKZ/1dbQ
	==
X-Gm-Gg: AYBFou3iKsgm0W4Ps55028HDUiz6T7zaT1pagmaOf9mHOM26nUPZvvxVbKlOSBZX1Wm
	AVKS0vaZ52R6LW2VS9chcuZIHJsRpMiE95sDprQepdYE3Y4bLxSUo6rLjL5XdhP3XOc8G0qP3Xi
	uBJyYgABTJymzdbY7i243e6m3ZYHLimJBh70D6csxtsptsaAksp0yfs0TXMGf2O5zVf50AziJFW
	YH4CWY63LkSADmpwP2fr/Z46nOuyrNgNZmzfALS/vHgewg8/zJVUUDQzX9iC8TzBpNGSZbQRFcx
	gRmLXI5z8fg1qbV5eZyGZgYqs+nklC9HMULKrDRHJzR3HuTXSdiPhJmrrECMeHxD+cA4yUtzVTv
	MeDaatUAhD1dHsZTqeiseay7o6P+VWBoWiLj2Aidw9fRxZDP7rliF+A3Ed8b0xeMin/Dk86c91W
	sgairycf2k7KpbyynPO+kGaJteA8hYvtSWH7k4TUbHdntGfAwZnh/2Njv54VCJnZTRVRXlAQHoa
	9aqbSZd777Qz9eW8H0W1BzjYXVUgeS2YpVHmhzl
X-Received: by 2002:a05:6000:20c3:b0:48a:eeb7:5e5c with SMTP id ffacd0b85a97d-48e07f99f3fmr9466574f8f.32.1792407170064;
        Mon, 19 Oct 2026 03:52:50 -0700 (PDT)
X-Received: by 2002:a05:6000:20c3:b0:48a:eeb7:5e5c with SMTP id ffacd0b85a97d-48e07f99f3fmr9466543f8f.32.1792407169681;
        Mon, 19 Oct 2026 03:52:49 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd510201sm23238930f8f.55.2026.10.19.03.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:52:48 -0700 (PDT)
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
Subject: [PATCH 2/5] ice: retain the adapter throughout hardware initialization and teardown
Date: Mon, 19 Oct 2026 18:51:52 +0800
Message-ID: <20261019105155.3793063-3-aaron.ma@canonical.com>
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

Adapter-scoped synchronization must be available to Admin Queue users
from initial queue creation through the last teardown command. Probe
currently obtains its adapter reference only after hardware and package
initialization, and error cleanup and removal drop it before hardware
teardown.

Acquire the reference before either normal hardware initialization or
firmware recovery-mode initialization. Release it after hardware and
device cleanup, balancing recovery-mode probe failures and removal too.

This establishes the lifetime prerequisite for moving package ownership
exclusion from a module-global mutex to the shared adapter.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 31 +++++++++++++----------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 164428ba116a0..ddebb28b2454f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5242,27 +5242,29 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		hw->debug_mask = debug;
 #endif
 
-	if (ice_is_recovery_mode(hw))
-		return ice_probe_recovery_mode(pf);
+	adapter = ice_adapter_get(pdev);
+	if (IS_ERR(adapter))
+		return PTR_ERR(adapter);
+	pf->adapter = adapter;
+
+	if (ice_is_recovery_mode(hw)) {
+		err = ice_probe_recovery_mode(pf);
+		if (err)
+			ice_adapter_put(pdev);
+		return err;
+	}
 
 	err = ice_init_hw(hw);
 	if (err) {
 		dev_err(dev, "ice_init_hw failed: %d\n", err);
-		return err;
+		goto unroll_adapter;
 	}
 
 	ice_init_dev_hw(pf);
 
-	adapter = ice_adapter_get(pdev);
-	if (IS_ERR(adapter)) {
-		err = PTR_ERR(adapter);
-		goto unroll_hw_init;
-	}
-	pf->adapter = adapter;
-
 	err = ice_init_dev(pf);
 	if (err)
-		goto unroll_adapter;
+		goto unroll_hw_init;
 
 	err = ice_init(pf);
 	if (err)
@@ -5287,12 +5289,12 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	ice_deinit(pf);
 unroll_dev_init:
 	need_dev_deinit = true;
-unroll_adapter:
-	ice_adapter_put(pdev);
 unroll_hw_init:
 	ice_deinit_hw(hw);
 	if (need_dev_deinit)
 		ice_deinit_dev(pf);
+unroll_adapter:
+	ice_adapter_put(pdev);
 	return err;
 }
 
@@ -5377,6 +5379,7 @@ static void ice_remove(struct pci_dev *pdev)
 		scoped_guard(devl, priv_to_devlink(pf)) {
 			ice_deinit_devlink(pf);
 		}
+		ice_adapter_put(pdev);
 		return;
 	}
 
@@ -5403,11 +5406,11 @@ static void ice_remove(struct pci_dev *pdev)
 	ice_setup_mc_magic_wake(pf);
 	ice_set_wake(pf);
 
-	ice_adapter_put(pdev);
 	ice_deinit_hw(&pf->hw);
 
 	ice_deinit_dev(pf);
 	ice_aq_cancel_waiting_tasks(pf);
+	ice_adapter_put(pdev);
 	set_bit(ICE_DOWN, pf->state);
 }
 
-- 
2.53.0

