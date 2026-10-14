Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261CF526AB9
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989892; cv=none; b=VsRKTSR/fV603ds1pDRRUgjcB0RqYWXia2uRmyMd448FzZj51iJHKHe1D0rSubRzPj6NbR+ZrqGG4bRlZP0DEe/R90VarwjQmtCCdYPx+ra1/SxSgxFaepc3hUzXmvobYHMdHVNJkJEbxHCBQh44c02XBElJ7cdH+6HCLrj1ChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989892; c=relaxed/simple;
	bh=D7u5Uh09Hugbc4/qGFc9FYmLKZ5dOBypXQjLOpzmVg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jtPhG+aF79PyVuE/7dv5NxOX5JQv5auYE8GY4wrxbOl1ShW0QLmPytAiykXzqJwLKg2FyjUfyooXIUKN/+fySNyCqB/Deos/dzRJzFw5jbFjmjt67P/NfJxYw2+p6Z6BPiM6qHDEC//pLz3GmQrXRkHE0Vk7TWB05wqtpsR5rIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyQGHU9d; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyQGHU9d"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533778ab0bdso47803071cf.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791989888; x=1792594688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EPFRsj6t93vAexyH59CynnFG/MFW0LsJOyq8VSdl2Qs=;
        b=IyQGHU9d/+lbzp5KNj85+guUgfhL9V9hka+dcCb7jKZT5X2V84m3XhPrQ2kAzgOPRT
         uA4jTc7Qy5ux+qqphbKAIfSd+zETkif7G4ynN6+23p5zC+10SegMQQC96zAn2BUatS23
         C7ArUcTkBzWjL9ZGhq/uca00dKTWW2lD4lIOVCy54UXrgNSVV0OQjgQayxdxo4T5I36+
         HOfyjkNCTQejpaTETeweEDom9AjT76L49hKKYq5oENMtteZu/PRAylHbAXSyRbNEP0Bw
         oaQAN2n5KdpPsawVnzZOjh/C0PjOJp2yFORzk/AvH00HYzHamqpDsR6p4LsUNyX+72sJ
         edoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791989888; x=1792594688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EPFRsj6t93vAexyH59CynnFG/MFW0LsJOyq8VSdl2Qs=;
        b=I8JFrNA6ntoXedve9RJhYmRfTLsW9dZvEugPOP0wjoB1vxsXjrkIHGopUxrlxaAN0v
         pU/ubm2zMv6i7fTba+0U8dBXrQlSwT63ZhfERfIb3euUFOvr/5bCuR7eVeRWqd8VbtYg
         JCW+LDao9iTJhMjXOa5jqQsuY4eu2KHo+LeCjXuZnPNK3+0B3LzIShcZYWgGtib4XLb5
         XubMF6cj0A744KDD23qlcgsgCh0S6QfPqHUddRrcUZPw30cwpW8DdOs0Vat38ZuwCkWW
         kO+zqFG+FTV/1jfLjzP20KMKg4ab+48MUHsbqQVw0/3rkCkfTzbluBf93iKPyoyM0JnN
         SmYw==
X-Forwarded-Encrypted: i=1; AKwUvBy9FWk67O2fGrgn33foa1qABfYDadDvwy5zKaGVwwbv7wX5Qv9M6lG036ERpAAt4yUg27FaYiY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIt8+Qv0/74HzSEm6w9vLplXTQ9YArEtaRK99EC44r8qje9YKJs
	qTWU57GXgGLjDGwogR00EzTsG2c5/k9CHKPctT1JNmIJk8zCZgcxIj9Y
X-Gm-Gg: AYBFou2r39H9e4q/tpl4JHqkGhmsE791/VGBpdin0cO0cOST0X+WfwkuzSSRZVmhipY
	D8phDtTDSXJKZDjWaDuTvKHVLlsGi7hAM7U3zjBcQqTsP28bWB+yk15o2Ah5RvC74vO1zXYEdsC
	a1L9NS5niT/xRiTZgWXoAJEGnor6CHAYb+Y4o1I2c2o1inrVuVon0DtPPaOUPZME3FLufn78BIP
	r8YOcp9kVoud0SL0JDG0WTdseZYvz7Nh7pdf7JAOAYEgWOBaAoVvQw3dkhCCuRwTrSA7hMgIdhv
	zuyF9t5lCKX2vIax9SrkILnGAjGmfPSRZ//QAfvxrV+PIE5gXLshDwoRrvhEOOsl4QYsWl2ME9G
	pYA/230Dukmd6bxi1idBwKqfDNksAEXRSNsl7ZE7EOOLqrlanFQBCzG8Cle6NMC6ILiIcjjzugm
	fdaTYZFQ4TmgBDNhB0Yy3/6BPnQpIKIxvBNie1Uz0IqCfZhaxquhMwQIEaB/lHZ5pTvxzDL0MW7
	ORcfWgYWW7N+HmE+rdKyDXPkrtyyVufFvildZO31f2lKJYPcFoUj1pxwBHwbVhnF7q9CzXavQ==
X-Received: by 2002:a05:622a:1b88:b0:535:1f03:32aa with SMTP id d75a77b69052e-5359fb85a7bmr299348751cf.45.1791989887934;
        Wed, 14 Oct 2026 07:58:07 -0700 (PDT)
Received: from DESKTOP-DIIS71I ([178.157.168.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ba220ea1asm38854676d6.48.2026.10.14.07.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:58:07 -0700 (PDT)
From: Rand Deeb <rand.sec96@gmail.com>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	shda@confident.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH net] sfc: fix NULL pointer dereference in efx_tc_flower_replace_foreign()
Date: Wed, 14 Oct 2026 17:58:00 +0300
Message-ID: <20261014145800.726-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

efx_tc_flower_replace_foreign() walks the rule's actions with an 'act'
cursor. After a redirect action it adds the action set to the rule and
sets the cursor to NULL:

	list_add_tail(&act->list, &rule->acts.list);
	act = NULL;
	if (fa->id == FLOW_ACTION_REDIRECT)
		break; /* end of the line */

The break only leaves the switch statement, so flow_action_for_each()
carries on with the next action while act is NULL. A following redirect
or mirred action then does "save = *act", and a following tunnel decap
action passes act to efx_tc_flower_action_order_ok(), which reads
act->decap. Both dereference a NULL pointer.

The loop is missing the check that efx_tc_flower_replace() performs at
the start of every iteration for the same cursor: reject the rule if an
action follows a non-pipe action. The foreign variant was added without
it.

As a result, a TC flower rule on a tunnel netdevice that redirects to an
sfc representor and lists another redirect, mirred or tunnel decap
action after the first redirect causes a kernel NULL pointer
dereference. It happens in the context of the task adding the filter,
with efx->tc->mutex held. Adding such a rule requires CAP_NET_ADMIN.

Add the same check at the top of the action loop in
efx_tc_flower_replace_foreign(), returning -EINVAL with the same extack
message as efx_tc_flower_replace(). The release path already copes with
act being NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 17654d84b47c ("sfc: add offloading of 'foreign' TC (decap) rules")
Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/net/ethernet/sfc/tc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 25341acfb..4a740da04 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -1828,6 +1828,13 @@ static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 	flow_action_for_each(i, fa, &fr->action) {
 		struct efx_tc_action_set save;
 
+		if (!act) {
+			/* more actions after a non-pipe action */
+			NL_SET_ERR_MSG_MOD(extack, "Action follows non-pipe action");
+			rc = -EINVAL;
+			goto release;
+		}
+
 		switch (fa->id) {
 		case FLOW_ACTION_REDIRECT:
 		case FLOW_ACTION_MIRRED:

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.39.5

