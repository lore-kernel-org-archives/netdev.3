Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6604F93B1
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893569; cv=none; b=eCp1lRTL//gmE1VfdpR3jaLhIGJbh3I1rOwHRuzhnIaUPg9SD47CXRtrxR0f1Bbd/eppzkPoGic2beGVXlsRsN491sDD3cjLvhMJMwgucJoADG8tiuSVtj9wHISO8WaTmhUvg+lB8gbjtKe5UbrPvP4LvdgtSPeC3nHVwa+W8II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893569; c=relaxed/simple;
	bh=6cSamSwYJBnyngLHbA44xCxOFpySlKFl0V/KECezGuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLs25qgwFfybpM0iK8rBsm9yoiuj/fRYGUd7O4H7/oh5QOk4Hp3Q4yCmepjpVQ45dw0wp9OcgHkILqYuUOqUoYIN2Dy1QmXEyb9xNaTTfTd6UA/Euknoy8kCyMfXSqzZKpBb26Eq2FDvWu4mwL1GdK3BrKX7km8mQSPmehwikK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gv8hsDAN; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv8hsDAN"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35834f72d94so5077391eec.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 05:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791893567; x=1792498367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VeXZNjBoqnw5XD9CEHjqXm9+b0DsQCCT5Oh6fOsHRj4=;
        b=gv8hsDANCIjShFVHMdEhcSnB7DB79k/9tX4/gsiEskS8MU8aGBKEZaoMnwte+WOopI
         W+JAnzvz0we17y6zpyANVUX4L9mJMVP1G9Oqmn0aWT7HLngdWYCw8VcPokA0kGK4V88E
         jLq7VxbE0A1lPug7lVylXN88SKidRbqIGeuLRNqjagBaZXnItBsGs1DDDlP5wVNwaX0B
         dGeCNy3vkG+2aX1WR9ymDKf87UCGMnjJEoF44ahZ+mw0mNXMQaUTyDtl56QqXEqPqN2n
         rPoeWVU/LnSrl/t2MU0hUAsSRn4R9O6p+3/DvKZob8S+WN5zzqOow6vGjWOcSUtSaqFH
         JI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791893567; x=1792498367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VeXZNjBoqnw5XD9CEHjqXm9+b0DsQCCT5Oh6fOsHRj4=;
        b=S0Rs68U9t0fna/VVzWZ2B3wKQSHCJBfTxLoTlyPiPkUqHDe6H3flqwQvs8Qv+q2iJB
         bdCdMYLTcFDeHSMDKFjHGyrmwSAOkZExOaSNTAKnnLtJGm0aWFEoZcW6dLO6fZoTSLUJ
         BlWCNjl2HE56v51Ynbxjs8zb93lFpLkMpyHGYilYipx+J8j2YSV9tKlzRKn3cFZMps9k
         0c3eKTeuYks9NHi+34ToFHox6x7MiNlSyX+hXZeR9Z09CloVFLtDnPTYIUuIKd7EQoax
         XkG7X9yUlcCkLDo910e/c44VnV2lWFid8aEtqNBDNuEeyY3xB8zVTAzI1nVTBAKWyHL2
         JeYA==
X-Gm-Message-State: AFq9FYLR0VRlkg38p2n4LFOHNgKg3rDnImSPJrgPwBJtVqclPDkzk0GY
	YfPws+oVDTJjXd++xO0tmJU50Jn8MSZemV76H7eAQQ6ZlP0L8M5jXsxb
X-Gm-Gg: AYBFou2NkaN0rbg1d6bKlPrAnCPTJT6OD1FyyLXtrUnV9o2WEgw3JZcOuoE3GIhW395
	Ad41VLj7pawfLU9+hXDBP82shtI10iFl5BBc83+DrE82cYhvSC6Q2luR149kb1Ph5tyrJ73uC6p
	JXDE24SfqHm5TXyI0hbaZ//nHVtr8xwaQd3XZ74OSoUveVNkHwPcdzGMaKwkzYL7ze69JiS7KJD
	F9I6WKTHrTMulfKR+cJIeFS8sw484qCFx/8howxDJqayxrHiTNX9T9ocXawhnbXLStGzzqmB3Xa
	6rKfC0tPGrkERVicH6w4HZCai32h3/QpVF3EW6XbdI2hLXPv7ph22O1QQs8lnJCADZxOSNrSgvv
	VsENk85ZYBbl18fm7lDLqxzquZbvob/owESLojZFSUg73PNE3LTlJWaUSy4/TVv1KsWAJn/Yvn3
	Jms9jFRzGbktj3UmTSD1kyWOMSZ4WdoE3UNYr0e/YRAURakoV6IwU4dFsagLXBuUuyUNKPwsaYQ
	JGdKoHepWh2icIjxOusFjeiSqgD/Zn9ZljTV/jReVrH4SJEMQeL8odEZkDObVW6b5t6dZBUayVt
	OA==
X-Received: by 2002:a05:7300:de02:b0:35c:cd26:3066 with SMTP id 5a478bee46e88-35ccd357b71mr1293310eec.41.1791893567003;
        Tue, 13 Oct 2026 05:12:47 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net (34.224.142.34.bc.googleusercontent.com. [34.142.224.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca7133asm52304765eec.14.2026.10.13.05.12.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 05:12:46 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	aleksandr.loktionov@intel.com,
	decot@google.com,
	milena.olech@intel.com,
	joshua.a.hay@intel.com,
	alan.brady@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net v5 2/3] idpf: ignore link events once removal has started
Date: Tue, 13 Oct 2026 20:12:23 +0800
Message-ID: <20261013121224.84482-3-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261013121224.84482-1-luckilystar08@gmail.com>
References: <20261013121224.84482-1-luckilystar08@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tian Xun Ng <tianxun.ng@bytedance.com>

mbx_task keeps handling mailbox events while idpf_deinit_task() releases
the vports: it requeues itself, or is queued from the mailbox interrupt,
until idpf_vc_core_deinit() cancels it once the vports are gone. A
VIRTCHNL2_EVENT_LINK_CHANGE event handled in that window looks its vport
up in adapter->vports[] without a lock, and idpf_vport_dealloc()
releases the netdev and frees the vport before it clears that slot, so
idpf_handle_event_link() can follow a NULL netdev pointer or use the
freed vport.

Make idpf_handle_event_link() return once IDPF_REMOVE_IN_PROG is set.
The previous patch waits for a running mbx_task after the bit is set and
before anything is released, so on remove a link event is either handled
before the vports are torn down or ignored. Shutdown has the same window
today; the last patch of this series sets the bit there as well. The
window also remains on a hard reset, which tears the vports down without
setting the bit; that path is not changed here.

Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d0db60647..2cfd216ae 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -40,6 +40,10 @@ static void idpf_handle_event_link(struct idpf_adapter *adapter,
 	struct idpf_netdev_priv *np;
 	struct idpf_vport *vport;
 
+	/* The vports are released on remove and shutdown */
+	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
+		return;
+
 	vport = idpf_vid_to_vport(adapter, le32_to_cpu(v2e->vport_id));
 	if (!vport) {
 		dev_err_ratelimited(&adapter->pdev->dev, "Failed to find vport_id %d for link event\n",
-- 
2.50.1 (Apple Git-155)

