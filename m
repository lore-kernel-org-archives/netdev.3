Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7863225779
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744068035; cv=none; b=UgT9yRhXURB24LSj316qglhcnG0aRb4k4Zlt/PvV5HRNA/uhsJ4xYHX7orsXvP0e6VY1CIP56/aX9nyhwgI0KcdjDhYFzg6AN5GNp3cvsUOKf6Ujq0bSEKZinN07SvaefeqbzW2bi3zbCWo8SAaxD8V2h7JtxVRb6sU2+3P5wr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744068035; c=relaxed/simple;
	bh=H6EF47jVEqy+cvDreVeuUruvIlMBWpFynwKoMZADgn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UwSRinjVMrMqIo/SFzBu/9nLT3sKxczr+2E7SnYLZJX9doABFnLe2GModCHZjwcIdTgXwt5AbqkJLVIHwzJKfafPnZMaMLfAXW6+c7PyqUsedOcsgrDqLelmWjDqLmSdHrRImqtDbB7jqsONcdOBpbs69aBzLdmkMdLqpKVdaFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTQU+6dK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTQU+6dK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8DFC4CEE8;
	Mon,  7 Apr 2025 23:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744068034;
	bh=H6EF47jVEqy+cvDreVeuUruvIlMBWpFynwKoMZADgn0=;
	h=From:To:Cc:Subject:Date:From;
	b=eTQU+6dKGVzOFylPxvuVYc3h+tDo7i0Y1OFNJPIgsmZ65rFRfyFcNHpMX32jyk5rz
	 fUh9j+flMF4DG+pPSV0smKitvSF7SI5t7HHOZFEp58OQ1Al0Un7PcyimNt67qev7h7
	 oxbfwO+VHPPgihNtLFe2uxjaAF4+DWMdXb0MGBKQPf3Uc/5meihx31aYJ4IzCIQQoF
	 bpOA1pnvC+po3BQYWGsG2SsnCZAR0qIOHHOsEvzSuDTFYnYXArYc9jarO8yLdxLqEi
	 zVSq2k2PF3D1GCNWG8svhlKucR3q7ji2GU1bydd33lMZ6jO8DuEaYCfo6tFPwfJ/dE
	 z8D7jvl8veQrQ==
From: Jesse Brandeburg <jbrandeb@kernel.org>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jesse Brandeburg <jbrandeburg@cloudflare.com>
Subject: [PATCH intel-next v1] ice: be consistent around PTP de-registration
Date: Mon,  7 Apr 2025 16:20:17 -0700
Message-ID: <20250407232017.46180-1-jbrandeb@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Brandeburg <jbrandeburg@cloudflare.com>

The driver was being inconsistent when de-registering its PTP clock. Make
sure to NULL out the pointer once it is freed in all cases. The driver was
mostly already doing so, but a couple spots were missed.

Signed-off-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
---
NOTE: we saw some odd behavior on one or two machines where the ports
completed init, PTP completed init, then port 0 was "hot removed" via
sysfs, and later panics on ptp->index being 1 while being called by
ethtool. This caused me to look over this area and see this inconsistency.
I wasn't able to confirm any for-sure bug.
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 ++++-
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 049edeb60104..8c1b496e84ef 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3968,8 +3968,11 @@ static void ice_deinit_pf(struct ice_pf *pf)
 		pf->avail_rxqs = NULL;
 	}
 
-	if (pf->ptp.clock)
+	if (pf->ptp.clock) {
 		ptp_clock_unregister(pf->ptp.clock);
+		pf->ptp.clock = NULL;
+	}
+	pf->ptp.state = ICE_PTP_UNINIT;
 
 	xa_destroy(&pf->dyn_ports);
 	xa_destroy(&pf->sf_nums);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 1fd1ae03eb90..d7a5c3fb7948 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3407,9 +3407,9 @@ void ice_ptp_init(struct ice_pf *pf)
 
 err_exit:
 	/* If we registered a PTP clock, release it */
-	if (pf->ptp.clock) {
+	if (ptp->clock) {
 		ptp_clock_unregister(ptp->clock);
-		pf->ptp.clock = NULL;
+		ptp->clock = NULL;
 	}
 	ptp->state = ICE_PTP_ERROR;
 	dev_err(ice_pf_to_dev(pf), "PTP failed %d\n", err);
-- 
2.43.0

