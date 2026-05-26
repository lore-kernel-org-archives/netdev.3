Received: from mta.al2klimov.de (mta.al2klimov.de [162.55.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16A53C0A1B;
	Tue, 26 May 2026 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.223.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820903; cv=none; b=bTAF3fwB8YMiqzQnc2kJOSloGN0MA4dBPbfdETKzjFwJ9wWR88rUyL5czAVFzfgSiJs1AQZn2OB7inaOawIBiUoqq4XMjYlexeGgy5VtMl5G2CLMqvn+BGcqSObIZ1CpEU8pbMyY7cXOdWAswAfTJqbmhAXs+buObmhyqYC9clI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820903; c=relaxed/simple;
	bh=Yxu6cLp2nC8sIKWrf8BHCgxZkIkwHCYaYzNUnh2jBvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7JEupen3aPckZ23fmSkLjtzfLimXd1kirUjGeSSFAX9nPs0L/dgKCswgAY8Wt7S4FzrjkUIHiX/A2Mma7hPCMjTEaGTrVq9Oh8lXlTReelJ6S6O251Ycy1OvKp/lnrZJmfiMeAbaxYWyVMAq3GdDdH7d6PfxTL0yTjrcxqdCEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de; spf=pass smtp.mailfrom=al2klimov.de; dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b=KgcXZvh7; arc=none smtp.client-ip=162.55.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b="KgcXZvh7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=Yxu6cLp2nC8s
	IKWrf8BHCgxZkIkwHCYaYzNUnh2jBvA=; h=references:in-reply-to:date:
	subject:cc:to:from; d=al2klimov.de; b=KgcXZvh75ghDzewMNDjJvGdGkzAqan48
	aMXSqceQrChAJOeehngZDsB+LZDSdEpCVt4lOi6sfZSuAEyHYFip6AJEGaDn3UpRUV9gjk
	t+uGViIA8euFxUpxq2003kXWJjKXtuER8C6cCjbBPEcjbAbvcP0cXiafSTUgeL0SHF8Dvb
	ddxuc7oektBV6A/91Kb3xaVyLvxanCi4BC29WS5tjY3bYuSHrM3aQ/NRgOA5gitwwZ1v8w
	ZTv33AB8jTDWqX+mu9q7vt9PY6d0efUR1jw7CuT1E1I8NtKHND1EIBbfKe4sOhvkQURfm3
	rtKZqcC2m/SWN02857nIcWah9VKfKw==
Received: from cachy-ak (88.215.123.80.dyn.pyur.net [88.215.123.80])
	by mta.al2klimov.de (OpenSMTPD) with ESMTPSA id cfc4909e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 26 May 2026 18:41:33 +0000 (UTC)
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
To: Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
	Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>,
	netdev@vger.kernel.org (open list:IBM Power SRIOV Virtual NIC Device Driver),
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list)
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] ibmvnic: fix krealloc() memory leak
Date: Tue, 26 May 2026 20:41:01 +0200
Message-ID: <20260526184105.18962-6-grandmaster@al2klimov.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526184105.18962-1-grandmaster@al2klimov.de>
References: <20260526184105.18962-1-grandmaster@al2klimov.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't just overwrite the original pointer passed to krealloc()
with its return value without checking latter:

    MEM = krealloc(MEM, SZ, GFP);

If krealloc() returns NULL, that erases the pointer
to the still allocated memory, hence leaks this memory.
Instead, use a temporary variable, check it's not NULL
and only then assign it to the original pointer:

    TMP = krealloc(MEM, SZ, GFP);
    if (!TMP) return;
    MEM = TMP;

Fixes: 4e6759be28e4 ("ibmvnic: Feature implementation of Vital Product Data (VPD) for the ibmvnic driver")
Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5a510eed335e..25d1d844ad19 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1761,8 +1761,9 @@ static int ibmvnic_get_vpd(struct ibmvnic_adapter *adapter)
 	union ibmvnic_crq crq;
 	int len = 0;
 	int rc;
+	unsigned char *buff = adapter->vpd->buff;
 
-	if (adapter->vpd->buff)
+	if (buff)
 		len = adapter->vpd->len;
 
 	mutex_lock(&adapter->fw_lock);
@@ -1788,17 +1789,17 @@ static int ibmvnic_get_vpd(struct ibmvnic_adapter *adapter)
 	if (!adapter->vpd->len)
 		return -ENODATA;
 
-	if (!adapter->vpd->buff)
-		adapter->vpd->buff = kzalloc(adapter->vpd->len, GFP_KERNEL);
+	if (!buff)
+		buff = kzalloc(adapter->vpd->len, GFP_KERNEL);
 	else if (adapter->vpd->len != len)
-		adapter->vpd->buff =
-			krealloc(adapter->vpd->buff,
-				 adapter->vpd->len, GFP_KERNEL);
+		buff = krealloc(buff,
+				adapter->vpd->len, GFP_KERNEL);
 
-	if (!adapter->vpd->buff) {
+	if (!buff) {
 		dev_err(dev, "Could allocate VPD buffer\n");
 		return -ENOMEM;
 	}
+	adapter->vpd->buff = buff;
 
 	adapter->vpd->dma_addr =
 		dma_map_single(dev, adapter->vpd->buff, adapter->vpd->len,
-- 
2.54.0

