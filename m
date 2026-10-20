Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792463236;
	b=ZwjJtsQJs+LNYJI0Ss8wl4nU6C4nzR7jxQhw+2Mm89QA08WHTd/Z1xvjCqAk0ZTVu6yK
	 yDBSWO9wIaHsAhwXM0vzQEXKyV1wF64ljdGWfpyu4bLmsMGth9kjMZJbpKWojwmP/6F23
	 kB9EIDYjo+pak3EYXbhox6FMf7ysefCUApv6BLsmyJbFG+CI45ADWAdG1u9v3aLMYIEYp
	 MJtewBQS6dJhv0pOP6fRFRWd9rRFPFzlxosXpSz/ifYYCvG4BM+7BGJwvJwp+VBmg8ZA7
	 C5gBaCC1EeW1hURRmPk/HjHNh/3jhFxlUGYSP/XpiOJbwY9myjjGBqH9hTa6kTcmDJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792463236;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=dy3ucRc1XCEeofmHBSnscKm5xMHhfbbrvHz358CCx1g=;
	b=IV1+5EC6I7rw2q7HIuZFtmOXMSwOpNl9SLXcbLQ2b1hVERo89ve6R7QmTjfhfZoVMNhD
	 c51d1OnySmUEp0Tv8ZL7n4Utmx4d8a5A3KD3gD+iTs94ZL2kHke5nCQbTF+YDcnwlRrWr
	 VRRZOCSAoFv1SJNWLsvrqLWt1p7vb1VLyPEo4Fhtx494IcXiIjA4F1FNGeAo3QcGV7wMG
	 uoHHQgBLAbjJOt/xmXpWP3KHrXbLgfgKeL1zA0fp4GHID29H1g6XylQAzpDPFjgk6i6QH
	 Z99OwSgUyXg5J8oQ8Unw7dEO/2pSfVZ6gwQcXSWLVmQvqIGcqEQugQvdngNw5aYOWBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=YZAly+Wb;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB48606A31A;
	Tue, 20 Oct 2026 02:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FB48606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=YZAly+Wb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=dy
	3ucRc1XCEeofmHBSnscKm5xMHhfbbrvHz358CCx1g=; b=YZAly+WbRPbtTKx65w
	YkpZCvRmxS9GbeBLFW9zGc6w7drekd9lf3sjd5Drh4+0HPbN/k9W9K2VYArx7ttu
	2DA/JZOwECx3kUi3SpzVtrWHRijOJYAi7Rb4OfYSvi3fmLb7sT96ee7KDZYO1hN4
	/OaxERnjGt4X+n3G/QA4Sjz5o=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3N8ZY0dZqKUFdBA--.5766S2;
	Tue, 20 Oct 2026 10:26:34 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: sukhdeeps@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH v1] net: atlantic: Unregister before clearing RXNFC rules
Date: Tue, 20 Oct 2026 10:26:30 +0800
Message-ID: <20261020022630.515209-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3N8ZY0dZqKUFdBA--.5766S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryUZF43tr13Xr1fZw45trb_yoW8trW5pa
	15Wry7C340qw10qw1kXF18ZFyYkwn7tF95K34UGwsY9rs8AFWxtF4rKrWq9F10vFZ5uF1j
	vrWYv3ySkFZ8A3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUDG5UUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC4BravmrW0VqIwgAA3j

aq_pci_remove() clears the driver's RXNFC rule list before unregistering
the netdevice.  Until unregister_netdev() returns, ethtool operations can
still call aq_get_rxnfc_rule(), aq_get_rxnfc_all_rules(),
aq_add_rxnfc_rule(), or aq_del_rxnfc_rule().  Those paths traverse the
same unlocked hlist that aq_clear_rxnfc_all_rules() is mutating and
freeing.

The race is reachable by issuing RXNFC ethtool commands concurrently with
PCI device removal or driver unbind.  A reader can dereference a node that
has just been freed, and two writers can corrupt the list or free the same
rule more than once, causing KASAN reports, list corruption, or a kernel
panic.

Reverse the removal order: unregister the netdevice first, then clear the
RXNFC rules.  After unregister_netdev() returns, ethtool can no longer
enter the driver, while the PCI device is still available for the
rule-clearing routine to issue hardware commands.

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
not observed at runtime; it is identified by code inspection only.

Fixes: 8d0bcb012f57 ("net: aquantia: add infrastructure for ntuple rules")
Assisted-by: GLM-5.3 coccinelle
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index 005d6ef4fc36..881727c3aa0a 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -344,9 +344,9 @@ static void aq_pci_remove(struct pci_dev *pdev)
 	struct aq_nic_s *self = pci_get_drvdata(pdev);
 
 	if (self->ndev) {
-		aq_clear_rxnfc_all_rules(self);
 		if (self->ndev->reg_state == NETREG_REGISTERED)
 			unregister_netdev(self->ndev);
+		aq_clear_rxnfc_all_rules(self);
 
 #if IS_ENABLED(CONFIG_MACSEC)
 		aq_macsec_free(self);
-- 
2.43.0

