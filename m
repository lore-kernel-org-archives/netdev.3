Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7CD2D7D47
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386405; cv=none; b=tP5dRfJb3m/3KESpRoTVDVlsrRdZlOlaCzp/lq0vh7Dtsq3NFbcojNL78jcbOb9csqrz9JJhzl9fNcLYFu7/azSRPok6+SoCBcK2IErmve6DvJGust1t9c9zNla2mDnTSeF7Ej5/C/XciiA42st4RgxYo4ZyA5mzBtq3bLPoDKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386405; c=relaxed/simple;
	bh=POMXdWhfI8qBwKUl1nNS6A3c2JppL3Vs6FUZFJgcmC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sVT5MPrEPxUtIn3p5YeyJM/kfTdy3PIJ/7EZE3IWahSAeJHB03H8fUz/7lXOt6R1dYpdGVFErgAnfQS1Jwn5nsnHs9Z/LEVAKTePb8E31JjTXgGV2zmW7dopKyFL6JRx9KcBBF3A56WfXCMZOi0bOzVdztwO7WWE3JgO/hfnuEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrAB3_zW7Dj1q+GQ+AA--.53363S2;
	Thu, 25 Jun 2026 19:19:23 +0800 (CST)
Received: from uu22.. (unknown [38.79.119.137])
	by gateway (Coremail) with SMTP id _____wAH4RGxDj1q5h1bAA--.1028S2;
	Thu, 25 Jun 2026 19:19:22 +0800 (CST)
From: Yinhao Hu <dddddd@hust.edu.cn>
To: netdev@vger.kernel.org
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dzm91@hust.edu.cn,
	hust-os-kernel-patches@googlegroups.com,
	Yinhao Hu <dddddd@hust.edu.cn>
Subject: [PATCH net] nfc: clear active_target when the target list is replaced
Date: Thu, 25 Jun 2026 04:18:35 -0700
Message-ID: <20260625111835.2411251-1-dddddd@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAB3_zW7Dj1q+GQ+AA--.53363S2
Authentication-Results: app2; spf=neutral smtp.mail=dddddd@hust.edu.cn
	;
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWruFykXrWUCFykXr1rXrb_yoW8WrWxpa
	93JFn3tFWUXrWxA3yfAF1UXr1ru3WkGFyUCryIk34rC3Z8G34xJ3WfGryfXFyjyFZ8CFW3
	AF1jyr4rGrZ8uF7anT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm2b7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVW8Jr0_Cr1UMcIj6x8ErcxFaV
	Av8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04
	k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
	wI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
	xhVjvjDU0xZFpf9x07j-Z2-UUUUU=
X-CM-SenderInfo: bgsqjkiyqyjko6kx23oohg3hdfq/

nfc_activate_target() and nfc_dep_link_up() cache dev->active_target as a
raw pointer into the dev->targets array. When a later poll reports new
targets, nfc_targets_found() frees and replaces dev->targets but does not
clear dev->active_target, so the cached pointer is left dangling into
freed memory. Any subsequent NFC core path that dereferences
dev->active_target->idx then reads the freed memory, e.g.
nfc_deactivate_target(), nfc_data_exchange().

When nfc_targets_found() is about to free the current target array, clear
dev->active_target if it points into that array, and tear down the
associated active state (stop the presence-check timer, drop the DEP link
and reset the RF mode) as nfc_deactivate_target() does.

Fixes: 900994332675 ("NFC: Cache the core NFC active target pointer instead of its index")
Signed-off-by: Yinhao Hu <dddddd@hust.edu.cn>
---
 net/nfc/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/nfc/core.c b/net/nfc/core.c
index a92a6566e6a0..950807906645 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -786,6 +786,21 @@ int nfc_targets_found(struct nfc_dev *dev,
 
 	dev->targets_generation++;
 
+	if (dev->active_target && dev->targets) {
+		for (i = 0; i < dev->n_targets; i++) {
+			if (dev->active_target != &dev->targets[i])
+				continue;
+
+			if (dev->ops->check_presence)
+				timer_delete_sync(&dev->check_pres_timer);
+
+			dev->active_target = NULL;
+			dev->dep_link_up = false;
+			dev->rf_mode = NFC_RF_NONE;
+			break;
+		}
+	}
+
 	kfree(dev->targets);
 	dev->targets = NULL;
 
-- 
2.43.0

