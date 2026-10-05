Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB7047DD4E
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202734; cv=none; b=WPm81wHyy+25dKKOBfc8IHeSH0fMmPU3MpUUL1dp06bbz5U6aWaViqi5D7VHyUB0krabnklE33xt0ogAHKpkmfHY8tdCvN7NdSMd/ewCUshmqmRwMC16BT3NR2JAgdGIGuHsyFxFNR26KkhKcX8evicaXGRdoaPOkGH2BbFqte4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202734; c=relaxed/simple;
	bh=YivNhXHyFNj2qLkN1DUjLdFawMx7+V5jdVVmNV/OF6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSnmN0WE58Y9mvmKJPDXnSctGHU9MScKqTrWf/PKLQez9jYa5JL4i1zGeGFMQHMkew1zE1dYoi6kPASmWUgsQHLjHIiwhik63ztcCjT1yRTc3fx8EH39awKXUZJZLQMaAOF0Y6xgINkuC/1LTjvBH6VJrnF1C3wCQKyfQ0HIn/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Dlp2H5c5; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Dlp2H5c5"
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-66c7e3a2332so954815d50.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 05:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791202732; x=1791807532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8iJV9KU13K8AUXhp7jJwHB/8UbdXVud6Ux/9BnQZ+qo=;
        b=UE/kLn13w9wqs0OXf6H7NEbA9AoK53z2vplvnhzTJ3yEfagfWvZk1u9LI9sk9rX2WN
         OvhN+vqxoe/9h1P9xS/vXT67oj0k5oV1gZGwC7A593a6drEHEclpCXFYZdRaTnpAHRzA
         jTlxQONkYwVo5iS+JLGuBFWN6yfg8mCcv+sthgJKBvdPHT9Q54d+izV7Hr+va6P5Ry9Q
         4uC1rMVsyz1vMvvpizM/6mZLOLorlzQlpna3S+DMq8aE+FkkpDj5tA2nUqNfaSES9Mli
         EHFYk8FSy0RwP+K9occK11iJFNbEpKKdYwPI+Vz3I2Zxz3y4s5ywviT2ntbZBsVmpaiC
         9WRQ==
X-Gm-Message-State: AFq9FYLm6r0+oaVLQZ1su3UnG1yffliLAD3qjGsteB4vX6ofEQ9iPIx/
	4Q7BCe8mbrAO53p6qEbtgGx+7w3taXgCgB3a8GmsdXa/Xdvc5QP2Y4m92qMTE9V4pAYFjw1NUVY
	IZCF27HDqXosXFzyWeyZJXZyj26zg6I/Ea1FzQSigpfulCFiY5TXf6rwx5MMhlnin+PN9t0z/cm
	YssIw452S78y9VY9N9sonj4PoWBWV7RI2+HVx4Ieqi04No+FScclih721rlfC/XJ/EJrjBZkvAr
	mfCF4Pzj6eY1dk8ww==
X-Gm-Gg: AYBFou0eFfxhsB+PHLNyn+UwQ9lO/YTKCwO3Zt4MwoaFjgDGhjXsOT/bfkcYd0U2aoQ
	DNlzmTiGBe0b6p89pg+iT9dLfWbxCAF/Xf5zeuDrvKAcCkcAWFTmJwM7Cbpn+hsChxVBsD2kY+P
	lj5aA1wXYhgQNVOUrhAwEqdTUSzH0SKurvQDIKJtr34wbrtoKrimZiQbAxuLh3iNZWmYgRVYUxL
	cpz/wzaaadtIOuS7Gz9iVr5inhFdTFHQZSXoKX5qWTEWdtSmFNqgpoeZDFkKIe6dSqa0Bs8Ac8X
	3f9nDJ85KqEd0kywqpfMYChtXQ6E+Thn5bWLLd0KYSLsu38ItjvW82FZbPvrGkUqUugfhJKecCD
	p7SO2AOIuTkFxkze0s5T8iabCXrdanal+KGRQD7z+CvNDeusBFBu0aA9v4fYkK5QSDALrwtOVuN
	A1Ggh5RfD/vDNXOCEsLbvPYM42w6/O4hV7+3kBhRS7JgKK
X-Received: by 2002:a05:690e:1486:b0:677:a8c0:38d6 with SMTP id 956f58d0204a3-677bd166499mr2917171d50.2.1791202732288;
        Mon, 05 Oct 2026 05:18:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-677c194623esm1226994d50.3.2026.10.05.05.18.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 05:18:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-34d80ca2184so2260766eec.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 05:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791202731; x=1791807531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8iJV9KU13K8AUXhp7jJwHB/8UbdXVud6Ux/9BnQZ+qo=;
        b=Dlp2H5c5s84MRGp45insb0YGC/3GwnRkCBHIEZ+JC1CiySUFiW8rrpmipd3z2vgrXK
         8WcGYsPca4W6BvDt8FzIeLNbUrC8j3Om/kY0uI03H92mocm/YTlNYFdoH+TlxcgAg/n2
         QjFdBseDsqOVC/+lz+u+zphWEfohcaFKyesmE=
X-Received: by 2002:a05:693c:2181:b0:34b:4b99:24ab with SMTP id 5a478bee46e88-3511147e728mr9583386eec.22.1791202731017;
        Mon, 05 Oct 2026 05:18:51 -0700 (PDT)
X-Received: by 2002:a05:693c:2181:b0:34b:4b99:24ab with SMTP id 5a478bee46e88-3511147e728mr9583357eec.22.1791202730183;
        Mon, 05 Oct 2026 05:18:50 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351272ceb02sm25687542eec.25.2026.10.05.05.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:18:49 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
Subject: [PATCH net 3/4] bnge: do not fail open if IRQ affinity hint fails
Date: Mon,  5 Oct 2026 17:47:03 +0530
Message-ID: <20261005121704.227866-4-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005121704.227866-1-bhargava.marreddy@broadcom.com>
References: <20261005121704.227866-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

IRQ affinity hints are advisory and not fatal to driver operations.
On uniprocessor builds (CONFIG_SMP=n), irq_set_affinity_hint() always
returns -EINVAL, which currently prevents ndo_open() from succeeding.

Log a warning and continue instead of failing open on affinity error.

Fixes: bd06d729722e ("bng_en: Add initial support for CP and NQ rings")
Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Reviewed-by: Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index bf101eded3bf..ca14d13fa3e9 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2666,12 +2666,10 @@ static int bnge_request_irq(struct bnge_net *bn)
 			irq->have_cpumask = 1;
 			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
 					irq->cpu_mask);
-			rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
-			if (rc) {
+			if (irq_set_affinity_hint(irq->vector, irq->cpu_mask)) {
 				netdev_warn(bn->netdev,
 					    "Set affinity failed, IRQ = %d\n",
 					    irq->vector);
-				goto err_free_irq;
 			}
 		}
 	}
-- 
2.47.3

