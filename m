Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A53126B0
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572783; cv=none; b=JYD+n0nwjGLoN7vn+gYGfLAtKywu5gqWdQ+tUU0o/fZEEHd7gT/M8bKz+y/K06j1BGSrhpoTMIjmtot4kF8xzDTMXGayCZFvcwJ6kxkEDdrNC6EhMx1YYkoBwMRBc2kzOMFm1RxHBmlsTLxDZ//FmAz/g0VUZy0MqcDAe6QTkV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572783; c=relaxed/simple;
	bh=sUK+d0HwIPouiw4GF2YvY3hSuqBUYY7UDZVaeoPdCco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvI2dSXdQfMDbNAr7JxqNIU2eFi+wN4el1+magr0Yn69yPMbFmPv7k+3d8mDkad8SUxmwenW5dIVApBLTSm5+I0iMCsqMMTGHImls4ypij5piN+kEvAcnpnLwCDROOpwYi9FZ4r0onDr0Y7lnSGPpOMxO6cqRUsh5NYO/E0EUX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrSF4YYm; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrSF4YYm"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9a2b95b72so1850682a12.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789572772; x=1790177572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RCHve4KAw17DJDENoy3wdVsGPjRR9u4ySMXlBrw/K6U=;
        b=hrSF4YYm8fCXcQzH3M9am8EXav+JsFDfD8g1Id9PWFaI/2Y5h5aNN6zy1e14NTTDD7
         tKx++o4Rfi+r+e0riV/p7V8HJe/O7hy+oOauiuWcTpMR+MuDirgPuEdQ49Mi+9lpERr8
         6Qx5QUjvDO0VqWGMAX3zlvGNfydi3UatZF+Xpdtq0hfVBVhIsS/aFQT5Ra0vPjP3ZGj7
         q6Q47AkxHuy3ylx0IlWQwoxUuNQ6WB6B3j2f5BhSMngNxPzSLiTNVJpg7R2vo6f/pyAK
         3ZmoPpCN4TBWLhQykjISERAM3ZcxoULNZTHL+B4MDcCx/KitUw4GVx6nVHtxKJDO+vfQ
         4W+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789572772; x=1790177572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RCHve4KAw17DJDENoy3wdVsGPjRR9u4ySMXlBrw/K6U=;
        b=tqMQzlTZoSOH8ciu1y1rCWw0CKkYMvFUs6exrEpQN6vMQqoOfBgfzHMIiOvJPEGpnv
         k5rBra3/5wNLwbDwr/QYl5iss/2+efDaxXzIWpM/ZfvpypxTUSXOKz/X4WJcnlEDCHds
         tt3LwEuiE0+izWBlGWjOpMyS3juO40HdJGQyxpsUPkLEjXDWoquQTyhnDOlUOo/Uaj5+
         cXxtbeL4LTsLysaFoGY7Ff87wls7U44R0JCgmBf1Al8hQrfuXMDQ7U6Q5b2o34x1/rv4
         NaDeB3yc003QvAk6GD+xT/e9JodDKdEBWbtqPicJGQQANZen829mIsy64NpEAT8xCp8L
         IJeQ==
X-Forwarded-Encrypted: i=1; AKwUvBxT1kaC0Ugbe/undvWXj3gy0SEYGuVcbIJj9Et0fOyfw1hcWuIdN75/Sj7FTFhCtJHVMXhKqgE=@vger.kernel.org
X-Gm-Message-State: AFuF++nqg+u/MUE8woMMtQ/9Mft9QrdKHdFJQL4LIK6zwtSUVWKBWzl6
	HD7p70k1LOHXK6cYlenWBUjLjQgZfLNnWfZb3m5fg/dIISXm6YkM2AYs
X-Gm-Gg: AYBFou0UHd+TsiOY8jL6Qzn4s5kjJ0MzshBU5wdplBslDK5eAlhDKiL0qFOHYpuYdXF
	WuQb1f4btP5Bmmfhg8la8hOIbWoiZe1LPYW7aZdd5NQfTXBmFlXeK5fiWV6w5DrgqYIU1hJycob
	eTcMsoKh95MCNgsVlNe28QJjD0ZyOV471NH0snfsUMgMMU6sswVCpIZVtcvy/E1EYcU3BBVzStI
	faZQevVUa4kZL5XuSXQweCNGBQ+6BdiljULTrNnalj0sIyZcNWtHLv41QqkyckCKyooUVMP/CS1
	5zTe87CXFCrQlzhAkhR7T1WQUB4EGuBCDhB76v9NvmyB42Os/9EiPFKcG+kkkdr/efmspeOKRcr
	bwBJ1HzPd0iIkUpNU6T1iJqE5JTQUWD1/WeotaTnqV+sViXZBfVtzggnam9H6s+uAZ+buTKqGZ3
	f3sPLD4apelVBjFs6VCNijvnwPhZhTYsG9Fk77pqNBAQJqi6Wo3b7xNOcYv6AJAv8h9PZDRjNLs
	wsVRKxcW3PkVXmhhTFc+VMKVoimrL1LVFlQGzy7p+MJrfah5yiV
X-Received: by 2002:a05:6402:2498:b0:6a9:b87f:8ea3 with SMTP id 4fb4d7f45d1cf-6aa2244cd2amr2521242a12.45.1789572772441;
        Wed, 16 Sep 2026 08:32:52 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1cfe0562sm2067081a12.3.2026.09.16.08.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:32:51 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
X-Google-Original-From: Sagi Maimon <sagi.maimon@adtran.com>
To: Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net-next v15 2/4] ptp: ocp: fix dpll cleanup on probe error
Date: Wed, 16 Sep 2026 18:32:40 +0300
Message-ID: <20260916153242.157171-3-sagi.maimon@adtran.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260916153242.157171-1-sagi.maimon@adtran.com>
References: <20260916153242.157171-1-sagi.maimon@adtran.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sagi Maimon <maimon.sagi@gmail.com>

Two problems on the dpll error paths in ptp_ocp_probe().

dpll_device_register() takes a second reference and stores bp as the
registration private data, and only dpll_device_unregister() drops it.
out_dpll dropped bp->tracker but never unregistered, so a dpll_pin_get()
or dpll_pin_register() failure left the device registered and visible to
userspace with a priv pointer into the storage devlink_free() releases a
few lines later, as well as leaking the registration object.

A failing dpll_device_register() jumped to the same label as the failing
dpll_device_get(), so the reference taken by dpll_device_get() was never
dropped either.  Give that case its own label.

Fixes: 09eeb3aecc6c ("ptp_ocp: implement DPLL ops")
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/ptp/ptp_ocp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 401b04f12d2b..f4299878c27c 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -5124,7 +5124,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	err = dpll_device_register(bp->dpll, DPLL_TYPE_PPS, &dpll_ops, bp);
 	if (err)
-		goto out_devlink;
+		goto out_dpll_put;
 
 	for (i = 0; i < OCP_SMA_NUM; i++) {
 		bp->sma[i].dpll_pin = dpll_pin_get(clkid, i, THIS_MODULE,
@@ -5150,6 +5150,12 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);
 		dpll_pin_put(bp->sma[i].dpll_pin, &bp->sma[i].tracker);
 	}
+	/* dpll_device_register() takes a second reference and stores bp; only
+	 * dpll_device_unregister() drops it.  Without this the device stays
+	 * visible with a priv pointer into storage devlink_free() will release.
+	 */
+	dpll_device_unregister(bp->dpll, &dpll_ops, bp);
+out_dpll_put:
 	dpll_device_put(bp->dpll, &bp->tracker);
 out_devlink:
 	devlink_unregister(devlink);
-- 
2.47.0

