Received: from relay.smtp-ext.broadcom.com (lpdvsmtp12.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA63F2C0298;
	Sat,  5 Sep 2026 01:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788572085; cv=none; b=WO220SM4Uox3cbFXlEJ/VMYiRmYtkpD/xn2Qw67POKMBv9Fx6PnJVwoOksmEn2o8DSo+tYeK0cjo2q6codJ38FG36fhH0ofp+ZHdhvNZSC5ZqEYl+I1++w+zPD0EqrsuqT4aOQtUeTEzgAf17ntJnIgrYiMflLKB8vfWLpb8dOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788572085; c=relaxed/simple;
	bh=u6VVhAhlj3OULcbiNGFXTh2I1gvcsZC+g7Ec00v8w3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aVqP1wQOnZgLeAWILTbfQ/XSuKN5vjudDFq+7sdCL/gm2zFWZjIzmi3x5lBwtipmiG8egDbcGxATs7CnCvLE2xGRDseb6ePxULOHYB+PSE/ES3DOcpQ4ula9h2HR/AUMnozpUl2J1Nsx+vVBaSuj76oFONv/yFgim0Av1zmQLMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=mrGsH/JP; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="mrGsH/JP"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 69B13C0003D7;
	Fri,  4 Sep 2026 18:34:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 69B13C0003D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1788572082;
	bh=u6VVhAhlj3OULcbiNGFXTh2I1gvcsZC+g7Ec00v8w3k=;
	h=From:To:Cc:Subject:Date:From;
	b=mrGsH/JPqe3t3qmf+0NFRbvwxEVLZFqPoLPi0Pr/gkienlAgS0r8Ju6+JzaeHMHGb
	 nGW3a5lmYmOLn/JXomhJ4zAvArQmC7ubczuh6xrPTkg7kx+s4Ko0BlqAuSXhFoS9oA
	 b03Ps3deSVgMUcvsR156y0KQq+Yvga8I6ORo4rOQ=
Received: from bse-build-07.ric.broadcom.net (unknown [10.136.28.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 96D04A9A;
	Fri,  4 Sep 2026 18:34:41 -0700 (PDT)
From: Danesh Petigara <danesh.petigara@broadcom.com>
To: florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Chen <justin.chen@broadcom.com>,
	Danesh Petigara <danesh.petigara@broadcom.com>
Subject: [PATCH net] net: dsa: bcm_sf2_cfp: fix NULL deref when port_num is out of bounds
Date: Fri,  4 Sep 2026 18:34:04 -0700
Message-ID: <20260905013404.2712866-1-danesh.petigara@broadcom.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Justin Chen <justin.chen@broadcom.com>

bcm_sf2_cfp_rule_insert() validates port_num against
priv->hw_params.num_ports, but the bounds check was placed after the
calls to dsa_is_user_port() and dsa_is_cpu_port():

    if (ring_cookie == RX_CLS_FLOW_DISC ||
        !(dsa_is_user_port(ds, port_num) ||
          dsa_is_cpu_port(ds, port_num)) ||
        port_num >= priv->hw_params.num_ports)

Both helpers call dsa_to_port(), which iterates the port list and
returns NULL if no entry matches.  With a user-supplied ring_cookie
large enough to produce an out-of-bounds port_num, dsa_to_port()
returns NULL and the immediate ->type dereference faults.

Move the bounds check first so dsa_is_user_port()/dsa_is_cpu_port()
are never reached with an invalid port_num.

Fixes: 4a5b85ffe2a0 ("net: dsa: use dsa_is_user_port everywhere")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Assisted-by: Claude:claude-sonnet-4-6 vscode
Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>
---
 drivers/net/dsa/bcm_sf2_cfp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2_cfp.c b/drivers/net/dsa/bcm_sf2_cfp.c
index 84a086c3e99b..6ac5cf154f31 100644
--- a/drivers/net/dsa/bcm_sf2_cfp.c
+++ b/drivers/net/dsa/bcm_sf2_cfp.c
@@ -867,9 +867,9 @@ static int bcm_sf2_cfp_rule_insert(struct dsa_switch *ds, int port,
 	port_num = ring_cookie / SF2_NUM_EGRESS_QUEUES;
 
 	if (ring_cookie == RX_CLS_FLOW_DISC ||
+	    port_num >= priv->hw_params.num_ports ||
 	    !(dsa_is_user_port(ds, port_num) ||
-	      dsa_is_cpu_port(ds, port_num)) ||
-	    port_num >= priv->hw_params.num_ports)
+	      dsa_is_cpu_port(ds, port_num)))
 		return -EINVAL;
 
 	/* If the rule is matching a particular VLAN, make sure that we honor
-- 
2.54.0

