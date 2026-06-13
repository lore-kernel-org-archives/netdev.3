Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB02DB791
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781381444; cv=none; b=gvQiiZex2sq0MDyjwS34OILSAUrgClMaqbWSospnNPYLWwMtNPOYrn+/+fRYcQDaI99YuU0cRR0evY82oHT5j7KJtMOPocXPfBcm47Tbj51gHN6kRgJlaXA+DQx531yZZPF4lUgQ0ajC57h/AErLt8eB/2AcLhG9kh2TTXWOaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781381444; c=relaxed/simple;
	bh=8YSR6CFEUKgEVbak/RzJf66YHaU4HqZ018p3ZNUz3NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHE/g2kY6xWe2tqyncYKUAgiK1k3dMxqSsavavl1BzXkpCd9Q91ugWdRXel7zTHdTWe22iA94lyWDaZv01/DK7XskltHUsUOB51ln0ysYXI50CH6OeI8p4aIEcHroEMzK5R5KKG/ssmSl9deWb57NvJRLgsasnMVBAGpZ4I5Wg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KI5PQtIf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KI5PQtIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6418E1F00A3D;
	Sat, 13 Jun 2026 20:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781381442;
	bh=O0u0Y5M06QrMQh3ALmuEJ2zJI1febqpd9gcTIM54ds4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KI5PQtIfkpZqzp9TR+xmm0tIAP/KBs8Ce1xbeNfTd18MViIScsvCCVNFU4XURtNUA
	 /qp5YqCXgEoCrpVYJrOXZculzR3v3QW+SbDiAXDqpZ9Hvw6MmVZH/qzHX8qeAyJ6cF
	 CaXp+/M+hwn5nQ1mOe1kw8F6ikJ6eYFv40JJL0dhw8IAoCT9G1PJJQvUvWPYYQYm3r
	 m8jliGbbHg771DoeqquBlXr/EvHijnN0tV3qniENrn6a6/MZkqt0HjALSl2/lkZ8zK
	 G3vdgFsRzNAP/6PMnKJaYpKF9gN6lbIJ26LzyK0e49nbu449ru1LO60LJiLqYpg+Bb
	 x5aIUcEjFS6pg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	3chas3@gmail.com,
	mitch@sfgoth.com,
	linux-atm-general@lists.sourceforge.net,
	dwmw2@infradead.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/9] atm: remove AAL3/4 transport support
Date: Sat, 13 Jun 2026 13:10:24 -0700
Message-ID: <20260613201032.77274-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613201032.77274-1-kuba@kernel.org>
References: <20260613201032.77274-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AAL3/4 is an obsolete connection-oriented ATM adaptation layer that has
seen no real use since the SMDS-era hardware it was designed for (90s?).
We are only maintaining ATM support in-tree to keep PPPoATM running,
and PPPoATM runs over AAL5.

Drop the "raw" AAL3/4 transport (atm_init_aal34()) and the ATM_AAL34
cases in the connect and traffic-parameter paths. A vcc_connect() with
qos.aal == ATM_AAL34 now fails with -EPROTOTYPE.

uAPI cleanup is performed later, separately.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/atm/protocols.h |  1 -
 net/atm/common.c    |  7 -------
 net/atm/raw.c       | 12 ------------
 3 files changed, 20 deletions(-)

diff --git a/net/atm/protocols.h b/net/atm/protocols.h
index 18d4d008bac3..30158efb5e1a 100644
--- a/net/atm/protocols.h
+++ b/net/atm/protocols.h
@@ -8,7 +8,6 @@
 #define NET_ATM_PROTOCOLS_H
 
 int atm_init_aal0(struct atm_vcc *vcc);	/* "raw" AAL0 */
-int atm_init_aal34(struct atm_vcc *vcc);/* "raw" AAL3/4 transport */
 int atm_init_aal5(struct atm_vcc *vcc);	/* "raw" AAL5 transport */
 
 #endif
diff --git a/net/atm/common.c b/net/atm/common.c
index 60132de4eebe..913f7e32ce41 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -293,9 +293,6 @@ static int adjust_tp(struct atm_trafprm *tp, unsigned char aal)
 	case ATM_AAL0:
 		max_sdu = ATM_CELL_SIZE-1;
 		break;
-	case ATM_AAL34:
-		max_sdu = ATM_MAX_AAL34_PDU;
-		break;
 	default:
 		pr_warn("AAL problems ... (%d)\n", aal);
 		fallthrough;
@@ -411,10 +408,6 @@ static int __vcc_connect(struct atm_vcc *vcc, struct atm_dev *dev, short vpi,
 		error = atm_init_aal0(vcc);
 		vcc->stats = &dev->stats.aal0;
 		break;
-	case ATM_AAL34:
-		error = atm_init_aal34(vcc);
-		vcc->stats = &dev->stats.aal34;
-		break;
 	case ATM_NO_AAL:
 		/* ATM_AAL5 is also used in the "0 for default" case */
 		vcc->qos.aal = ATM_AAL5;
diff --git a/net/atm/raw.c b/net/atm/raw.c
index 1e6511ec842c..0d36aeb3671b 100644
--- a/net/atm/raw.c
+++ b/net/atm/raw.c
@@ -68,18 +68,6 @@ int atm_init_aal0(struct atm_vcc *vcc)
 	return 0;
 }
 
-int atm_init_aal34(struct atm_vcc *vcc)
-{
-	vcc->push = atm_push_raw;
-	vcc->pop = atm_pop_raw;
-	vcc->push_oam = NULL;
-	if (vcc->dev->ops->send_bh)
-		vcc->send = vcc->dev->ops->send_bh;
-	else
-		vcc->send = vcc->dev->ops->send;
-	return 0;
-}
-
 int atm_init_aal5(struct atm_vcc *vcc)
 {
 	vcc->push = atm_push_raw;
-- 
2.54.0

