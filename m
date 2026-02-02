Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04E385EE0
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770052631; cv=none; b=BVOETBL209tZu8ef58QTfcc48utORH0lca8RO6J3N4nUCbkHQohUHSCwPL4PqpLXLK1fJekyOfhuVIJaTPWSHHmSatSgmlsVUS8MbfJ+4fwfXhuAI2Ut/+ni6ScuuVsFMQVc/m/bvj+1Sj0Tp56PpEursVU6aJNUGDL6KpfO0TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770052631; c=relaxed/simple;
	bh=P29ozWDvU0n0V6XeRYb6BkKR+4vP4gjB/XY+9W6jGdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQT5GkZ1V378pI+56Ba04eVWiDPCnz3K9Ie7VvPLxg2o6oP3/cYUrkmQwTldzXUwxjWAb1O7Ke3uydWbBWgU44VCGNpO4nR+2E2M7TIjNeEX7929ZBhr9J0C7ccnrSUZxVh83M3XY0Dk37uF2tITQHXVrVhR+KH9ag1nvEF8aXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KLQzZeBP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLQzZeBP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770052628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KS4/gkGq27/8plMJdM75D50Du3giTwG6upf6vajwDBo=;
	b=KLQzZeBP6faTJS7nnaYI4quW60yLbiMspGT5HM/pe8GyB3v5fmfRbBsnS2ZBUPpLANL+oP
	+7qU28f+dgNqfcUa/xVSJws0blxfRO25wktqWUj/Cqqy/5zmY7VR9GDca+e6p2zu2K+ihl
	QCwOUYZYZOAK/xhVZCaaxBpKUEvmfKc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-2Azq84XyOXKEJhfGtlnfEg-1; Mon,
 02 Feb 2026 12:17:03 -0500
X-MC-Unique: 2Azq84XyOXKEJhfGtlnfEg-1
X-Mimecast-MFC-AGG-ID: 2Azq84XyOXKEJhfGtlnfEg_1770052620
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72E62180034A;
	Mon,  2 Feb 2026 17:17:00 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6289319560B2;
	Mon,  2 Feb 2026 17:16:53 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v4 2/9] dpll: zl3073x: Associate pin with fwnode handle
Date: Mon,  2 Feb 2026 18:16:31 +0100
Message-ID: <20260202171638.17427-3-ivecera@redhat.com>
In-Reply-To: <20260202171638.17427-1-ivecera@redhat.com>
References: <20260202171638.17427-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Associate the registered DPLL pin with its firmware node by calling
dpll_pin_fwnode_set().

This links the created pin object to its corresponding DT/ACPI node
in the DPLL core. Consequently, this enables consumer drivers (such as
network drivers) to locate and request this specific pin using the
fwnode_dpll_pin_find() helper.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 7d8ed948b9706..9eed21088adac 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -1485,6 +1485,7 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 		rc = PTR_ERR(pin->dpll_pin);
 		goto err_pin_get;
 	}
+	dpll_pin_fwnode_set(pin->dpll_pin, props->fwnode);
 
 	if (zl3073x_dpll_is_input_pin(pin))
 		ops = &zl3073x_dpll_input_pin_ops;
-- 
2.52.0

