Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEF73D75DF;
	Tue, 28 Apr 2026 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364849; cv=none; b=T2HqVKvnZCmVOq+xHC7y/PoGAjtK4sR6GE5afMGz2NZAPcL+ijEtx3JU1LgU2fvm21+jQWakytgjLWbhW7mMt4KRYHMANXYhWJow4DFJOkmfN94/bLy0xRcZTFY78dst+IH97/W5RfsjS4ex5+WQIJbC/HOIwKD1To9gWaUAZEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364849; c=relaxed/simple;
	bh=BMAgwXQrkx/VBAHYwKEPrZ5iHHknFulXIvTL1397V/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjtTtIxjRTozUIIhmk/dF5so6mBe00Uo4RD1ESPohcIR8i50ZPRrCkENnbCjEhTiyew3jnfTKOPIvmNLDRacIHmED+Ahkz9409H9cvuYJ+i9Rc0lG5izeaYYiujkhLjMlZZwIqT/ufJZcpQOoNIlRQdZ4Lx0v+APFE9V3J06zzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHnwzyMx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHnwzyMx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777364847; x=1808900847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BMAgwXQrkx/VBAHYwKEPrZ5iHHknFulXIvTL1397V/w=;
  b=LHnwzyMxs0/8LSRpYQy3VXRFWzt/IVmdGc1ofHxpaQCP5jB/vFNM97VJ
   W8HXuI5sNLkRrHEVJ4rEdWhCaXohw2Cyo2VeteneVHjP0DN6bb2uqr+F7
   EuQcx2GZO++nI9FSotsLIMTYHq9zW5BitYZeFUuWcoffUR6TZqXWTH+Y5
   ke++Optd5C9WibYTZOjNYnVoYbg6P/IbumfJTDhBqIzRtQQMxpRbMgNid
   aZj4e7Q1D3kbs1rNffFvSYSY7pVKRHS26xbjrBAWsFAe+/ZkMrT1jod5R
   XXrwv/mCblyJ5JzvU4I2STRMNQOAKQHtAo3nwv1YuZH0M51LdKP3rtCDa
   A==;
X-CSE-ConnectionGUID: 7mC3RdafQIa1Cx5Wb4Gt6A==
X-CSE-MsgGUID: 7buRES3eQ0GKSw0eDG8rXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78376956"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78376956"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:27:20 -0700
X-CSE-ConnectionGUID: RF4MzHqjS/a7a2l6EWMAUA==
X-CSE-MsgGUID: L+y2WcZjSWuinPu0obyytA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="232881579"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 28 Apr 2026 01:27:15 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D3F5B27BA8;
	Tue, 28 Apr 2026 09:27:13 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	jayaprakash.shanmugam@intel.com,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH iwl-next v7 10/14] idpf: print a debug message and bail in case of non-event ctlq message
Date: Tue, 28 Apr 2026 10:26:44 +0200
Message-ID: <20260428082654.44364-11-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260428082654.44364-1-larysa.zaremba@intel.com>
References: <20260428082654.44364-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike previous internal idpf ctlq implementation, idpf calls the default
message handler for all received messages that do not have a matching xn
transaction, not only for VIRTCHNL2_OP_EVENT. This leads to many error
messages printing garbage, because the parsing expected a valid event
message, but got e.g. a delayed response for a timed-out transaction.

The information about timed-out transactions and otherwise unhandleable
messages can still be valuable for developers, so print the information
with dynamic debug and exit the function, so the following functions can
parse valid events in peace.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 8936c2a67ce0..7c3dd89b61d6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -84,6 +84,13 @@ void idpf_recv_event_msg(struct libie_ctlq_ctx *ctx,
 	u32 event;
 
 	adapter = container_of(ctx, struct idpf_adapter, ctlq_ctx);
+	if (ctlq_msg->chnl_opcode != VIRTCHNL2_OP_EVENT) {
+		dev_dbg(&adapter->pdev->dev,
+			"Unhandled message with opcode %u from CP\n",
+			ctlq_msg->chnl_opcode);
+		goto free_rx_buf;
+	}
+
 	if (payload_size < sizeof(*v2e)) {
 		dev_err_ratelimited(&adapter->pdev->dev, "Failed to receive valid payload for event msg (op %d len %d)\n",
 				    ctlq_msg->chnl_opcode,
-- 
2.47.0

