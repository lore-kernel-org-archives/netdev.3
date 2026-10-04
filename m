Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154DA48095D
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791137407; cv=none; b=dQfGF+GSsT7+qB6NBdjiJLv4wrvghaYILN4q1sW+Gwi2iSD4U0FDygE3KoOGK35VSsb1vKIpl7vfWX6U4uqqiXBK6B1R1KeZAyU+7saqJ2jvN9qnJgYfWPfOIgCdcQExQ8h76bVLdnuBTReEETLPMFpf+hfVooqqAlDqJghZO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791137407; c=relaxed/simple;
	bh=oJdXiqd2wc6WPYn9cOVUlqBNnR5Q2SQg7rjq/NYDxsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5eVl4Z9I8IZia6LfFn/gSfdkFOoG5X55u46K4f0uPSD+WSKsnmOcuvKKAspzrxvn2vmZb2DYBCpbKYoR1Kk2xWU2xDa0frDu3/Cdd/4TvYTOXHwBdScAr1nwFnLTcJox+pTdtwVed7hBT18MbPbQQ8y2E2m5Durm4AzQI93zYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBKK/rUn; arc=none smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBKK/rUn"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-91951457245so11969706d6.2
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 11:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791137402; x=1791742202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XN2y9HoEh/B+DkH2/LgEo5mNVmafbb4PxYEtM4F0P2g=;
        b=BBKK/rUnyef/aM1adxc7n0qzJ17kXDqTSv8X5y32zPxHs2VdAwQ8wcDcs6EX6X0OlL
         xj/SddChxyNDvGVp9NdHUcinL/bmIgF5qieT7sOw5QNnwtBtXFZxfq+NN/97Q8TVpXJd
         v3bZ74TyJyCDtF3gkS17xUUrhU0zzIgnIz8kr6opKoVAcGcxy0hju5GY7hPP7g1xiNZq
         E874Z75WTFViVcOhA+XH97ym59BuIpXyNJnyGIu3xvQ8ESF5CijMdlxKI2enx4lPDYoF
         5qiSiTZlT66NxBLmnAHqFQIpYHRlVb5nZKx3Y0Fq6hr2aqzE8lQOiKCKz7AP7Pl1Wfps
         fE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791137402; x=1791742202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XN2y9HoEh/B+DkH2/LgEo5mNVmafbb4PxYEtM4F0P2g=;
        b=mXKGY31jIslNmhrpyMec1Il9/nWqDA7pC9L+28pdhDSjpcVyM/ozTo/PmVOxBmM8BE
         YuJNrQOxqoqnhPZcBx86xwWQyjwNUnZiln2NPDNwijKuEY6sRjklXulvsotNv5DAa9h6
         vhHKBwE3JvHzj/VkMGingJbdrgW6WUOPX2rV0NdtEPTUrxLJkOUsiZ6xfSe30LFRuvU1
         KpoAQuPoqq9zgZH3KB9t0BgP0bpceJLZuCLKHrMgx/lSzWtyhQAgxIkhxhx7WRioZwoh
         WKhzyuJIyv+WqPo2WP6L3RvbCpSp5wBMdfiD7uaw94HcVdA3YTQzA3zQY2/hAXjDr2M7
         DyoA==
X-Forwarded-Encrypted: i=1; AKwUvBwZkcP/yHGTFNYCeGgbwXzHCsrY0iJh2QvfMeOAWpjZp9OQsx0gp8y6QxtnAAJV5hXTHMB9KTg=@vger.kernel.org
X-Gm-Message-State: AFuF++nr5I9YNWLEUnPqRsEMvN6vbjoKeEQeMF0Ohm3fO2HpvpnVu5AB
	hhPX6/Emetd082miZSZBvuXJsshf+eMZgEf92sYQ0U91W6QgfxE0NSp4
X-Gm-Gg: AYBFou0YnJVqJ97ljkE+Hkt7rzwH6tdJnjHpdJxMlX2uhENBe/3/hH+9RfYnRxLbPhf
	IOl+xUXmMbPsezEJtHEUFPEgwJEfX4zw/ArKhfbpDjkIPAt2Zrk1olSrFl9MblrlFOTm5LK676g
	6aSP219JuN+6pG8jfHqSg/u2n30/mWLpIsG7e6dWqZwEEf9mBc3FD/lnyCaE0nhvJ+O3t36JbiE
	Xy7gEdXg1/3YTazU/LUP77Nknmi6tiaj9TJHKjE7BF8MOHecmvdd1Ufsw7GSUtG36t18ly4IbqN
	TcChSK+ro79UY76uSxS8v8j8BOafTqwdz8pGa5tcgPm/iiextkwMOW2C+hjRw7nBIm8laAFirdH
	pQnIOS2jCGE4SnWvHxauQF19BF0CpBXEsdzsNuzYxujHhwmQkRJuhdc2zTu+WuxS2e6ECR67SUa
	kAtEHZRWTlw0msssg9d8TV2oGlxESWy3jl0ztOLQvhSJjrdUAUl9D85TWrN+4coIuJc2mNdX+fH
	MOAcOZT0s6tIilWWgLbqZWlIFXueQbz
X-Received: by 2002:a05:6214:8593:10b0:912:517b:40e5 with SMTP id 6a1803df08f44-917c01931a7mr120128746d6.44.1791137402128;
        Sun, 04 Oct 2026 11:10:02 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917d593b181sm70354166d6.6.2026.10.04.11.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 11:10:01 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Alan Brady <alan.brady@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Phani Burra <phani.r.burra@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH net v2] idpf: Fix vport IRQ name leak on request failure
Date: Sun,  4 Oct 2026 14:08:39 -0400
Message-ID: <20261004180954.163789-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

idpf_vport_intr_req_irq() allocates a name for each vector IRQ before
calling request_irq(). On success, the name is released later through
kfree(free_irq()), but when request_irq() fails, the error path only
unwinds the previous vectors and the name for the failed one is leaked.

Free the allocated name on the request_irq() failure path, as done for
the mailbox IRQ in commit 9bff30482c10 ("idpf: Fix mailbox IRQ name leak
on request failure"). While at it, fail with -ENOMEM when the name
cannot be allocated instead of requesting the IRQ without a name.

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Changes in v2:
- Correct the Fixes: tag (Simon Horman)
- Handle kasprintf() failure (Simon Horman)

v1: https://lore.kernel.org/all/20260923234819.702327-1-oss.patchbox@gmail.com/

Compile-tested only (x86_64 defconfig + CONFIG_IDPF=m, W=1).

 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 4311ffa30bb1..af3213eae393 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4067,12 +4067,17 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 
 		name = kasprintf(GFP_KERNEL, "%s-%s-%s-%d", drv_name, if_name,
 				 vec_name, vector);
+		if (!name) {
+			err = -ENOMEM;
+			goto free_q_irqs;
+		}
 
 		err = request_irq(irq_num, idpf_vport_intr_clean_queues, 0,
 				  name, q_vector);
 		if (err) {
 			netdev_err(vport->netdev,
 				   "Request_irq failed, error: %d\n", err);
+			kfree(name);
 			goto free_q_irqs;
 		}
 

base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.43.0

