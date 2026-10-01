Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3984AA418
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872769; cv=none; b=i4tyTYFdXmB4xlZabkILHW0GGnz+Z6j8OPfWOD2ney1H5eOMYMfomIyecPjwbpKLjHsGCCQ39qzJZeECldvbMaewaOM2IEWjy8+IsWUs5LoASLaxbmJOMYjzZ7sYC3oRU9F88/F19y/ljWWIQbWk3QRc16P2a57Srhoad8lLZQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872769; c=relaxed/simple;
	bh=DlHHkzkT8kP0MbAaZs9pk8YyukMa/EI8gOmgUqmb4+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LizUvcaIK4Kuqte4yuYghsubOemKzuLnpQpq2xpoC3nTOx/ArFbHbxxf4e/ZThkN/F13s7gIfEsxymmSfl1mnxRsXbEzK964H5Y8HSx0pScRvVf/KfykI1rqzvm/kos1x1stG+J2rKSwLteGX4IiZL/ETodneiEY6uimmiu6GNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0aC0MbA; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0aC0MbA"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-81be5042c56so3792787a34.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 09:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790872766; x=1791477566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LpX58fE348BUkcVclLgpHI3tc1Fvn/Hskn9ODkkCRlY=;
        b=N0aC0MbAsXz+igvn3ATmdatq0UYlpF/Tif0FkrbnTAkBCnZwHepGd1/BmxrhARpF73
         FVAwQ3G51EJviH5y5iGc+WwXpQZTyDO9W1ni/LGwpcn4HTHn2BnNKG6kJM+ClUDZaLRB
         3/zeAz8bPuT9jcJEwN09yixDTD4fIPL+ZGNSaSNxFN0Q3347wnzIwfjw+n89iwby6K+r
         7A1EiY7VF1GjRh9n+ANu+BG82iH2QtH6EGc8N805JjTpzK9UPcpkzGxfo85Tt2WRFXif
         S5HEP8vVl1wZ/oJcZXg0Km2OuQ7MDlvQ72nf+vErI5FtCUizwPmUMJnbt6SIIgnJcH4C
         bcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790872766; x=1791477566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LpX58fE348BUkcVclLgpHI3tc1Fvn/Hskn9ODkkCRlY=;
        b=zC8JBjC5oSvEJwLBh5uTa2+JAKRmLPHUHVge0TX693nZa8KuCkTzCeZ9pZHxtanJUD
         f1namELZTCLKB9qPNfyOGx2Wy4A502Kq0MdUdPv+vGA0aT3SuPrE1LtPMphqwkuUplwN
         gGL7cXAhDf64oBjH47/CQvWhAlZBPhsjMI7ePOqmYZ37Qw78WeC1qBKjS2Pdd3jxzSN4
         vlsvOXeUa/9RlsFYhP3bT6jzN00zgQrVfPMUwFyOo7/ZxDc17YlF5DNvjqwO+IPbgNnj
         bonxRlJOktPag/fPPLE5qB5BKtuJeXMhMHAL1eKHv+F7TLY3/fru7/L6bjDiJDXKmYSt
         clBQ==
X-Gm-Message-State: AFuF++kHUzGXIorSwGIRlWFsarRKZVC7h4IiPfchxv4oLYeD4ayCXIHk
	fNGm3ho5wnoZGTsiQQlR42zi85yaFX0YKUDA2bBGuq0HhjaGffLjFzlYhxdFjsCC
X-Gm-Gg: AYBFou3mj0V/bSXQDT/+jyOQcMBqYvajkuTDTIgCyYNT5oeYNDMladBNh5seZKNueVo
	mt26rBwI7Xt/r+MVzqqYJ/0QnDOyr7tAHAZtdbhk8hPOevVupDiGldsEvyjF4r7Q9El1YiKATHu
	Dg9bhsWzEpTqjse08oCDJge7zn5cCl1qdN1AYovVfYZSCCoGVwm0d35OygOzWfVdLhsEwh9cyfO
	DeORjP2fGnPqpqH9AhDlllcx+6RXObUHckTgtRlk9yvgr5BsedIwoqihS7xQz1ftFEH7lDj9rov
	7gn7bp7xd8jUWOoPwAWKMrQNrFqlGv8ZL86EVvEGGomZRn7dPb744VgCf+zbCbGfaQZnLxoSNsW
	Hx6CK44+GoAuDCaBzJ74VU2NxADY93+UktwUW4/IheD952yyp03IM7rV9goosE/5ECueEJjqZH0
	jxii1damDEbD9sDNKGKfVd2ys4Tzgi3bXCVj+7Ud0s3VnVrb8uObf8YW6tVXbysaqE
X-Received: by 2002:a05:6830:81f1:b0:81f:acdd:bd05 with SMTP id 46e09a7af769-82285a5a05bmr191774a34.21.1790872766015;
        Thu, 01 Oct 2026 09:39:26 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82273e27adesm342486a34.0.2026.10.01.09.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 09:39:25 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Thu, 01 Oct 2026 09:39:01 -0700
Subject: [PATCH net-next 4/4] eth: mpnic: add a NAPI depletion check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-linux-mpnic-v1-4-6422ee74233a@gmail.com>
References: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com>
In-Reply-To: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0

The Rx path can wedge if page pool allocations fail in
__mpnic_fill_bdq(). The problematic sequence is: page pool allocations
fail, bdq rings are empty, device receives packet from the network, but
drops it for lack of buffer space and does not raise interrupt,
mpnic_poll() does not run, so page pool allocations are not retried.

To break out of this cycle, we can add a depletion check to our service
task. The depletion check checks if posted buffers are under a low
watermark, and raises a completion queue interrupt, so that mpnic_poll
will run on the corresponding napi vector.

A note about the lock free reads: We don't bother synchronizing the ring
head and tail reads with mpnic_poll(), because a false positive signal
would simply raise a spurious interrupt scheduling mpnic_poll(), and a
false negative signal will result in a retry, where if mpnic_poll() has
truly not been running, should then report accurately whether or not
posted Rx buffers are low.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/ethernet/meta/mpnic/mpnic_pci.c  |  4 ++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c | 31 ++++++++++++++++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h |  1 +
 3 files changed, 36 insertions(+)

diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
index 17eae5a9ba16..125fb26edf93 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
@@ -11,6 +11,7 @@
 
 #include "mpnic.h"
 #include "mpnic_netdev.h"
+#include "mpnic_txrx.h"
 
 #define PCI_DEVICE_ID_META_MPNIC	0x0014
 
@@ -61,6 +62,9 @@ static void mpnic_service_task(struct work_struct *work)
 
 	netdev_lock(netdev);
 
+	if (netif_carrier_ok(netdev))
+		mpnic_napi_depletion_check(netdev_priv(netdev));
+
 	if (netif_running(netdev))
 		schedule_delayed_work(&mpd->service_task, HZ);
 
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
index 49061c7316d5..5495e9a9aa65 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -55,6 +55,12 @@ static unsigned int mpnic_desc_unused(struct mpnic_ring *ring)
 	return (ring->head - ring->tail - 1) & ring->size_mask;
 }
 
+static unsigned int mpnic_desc_used(struct mpnic_ring *ring)
+{
+	return (READ_ONCE(ring->tail) - READ_ONCE(ring->head)) &
+	       ring->size_mask;
+}
+
 static struct netdev_queue *mpnic_txring_txq(const struct net_device *dev,
 					     const struct mpnic_ring *ring)
 {
@@ -1393,3 +1399,28 @@ void mpnic_napi_enable(struct mpnic_net *mpn)
 
 	mpnic_wrfl(mpn->mpd);
 }
+
+void mpnic_napi_depletion_check(struct mpnic_net *mpn)
+{
+	int i, j, t;
+
+	for (i = 0; i < mpn->num_napi; i++) {
+		struct mpnic_napi_vector *nv = mpn->napi[i];
+
+		for (t = nv->txt_count, j = 0; j < nv->rxt_count; j++, t++) {
+			/* Check if BDs posted covers a max sized frame
+			 *  + 1 BD held by RDE as a spare
+			 *  + 1 BD of extra safety margin
+			 */
+			if (mpnic_desc_used(&nv->qt[t].sub0) <
+			    MPNIC_RX_HPQ_DROP_THRS + 2 ||
+			    mpnic_desc_used(&nv->qt[t].sub1) <
+			    MPNIC_RX_PPQ_DROP_THRS + 2) {
+				mpnic_nv_irq_trigger(nv);
+				break;
+			}
+		}
+	}
+
+	mpnic_wrfl(mpn->mpd);
+}
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
index 9397010557eb..767d87a36c35 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
@@ -148,6 +148,7 @@ int mpnic_set_netif_queues(struct mpnic_net *mpn);
 void mpnic_reset_netif_queues(struct mpnic_net *mpn);
 void mpnic_napi_enable(struct mpnic_net *mpn);
 void mpnic_napi_disable(struct mpnic_net *mpn);
+void mpnic_napi_depletion_check(struct mpnic_net *mpn);
 void mpnic_enable(struct mpnic_net *mpn);
 void mpnic_disable(struct mpnic_net *mpn);
 void mpnic_wait_all_queues_idle(struct mpnic_dev *mpd);

-- 
2.52.0

