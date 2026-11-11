Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389452;
	b=RRYV00qhHqfOmLm3pJFYghO8C1dmH5UOmwe73BOJYXy/vFKfWB38pLw4iiPKw+Prc4ER
	 tJ2OcXXbtIYUb415twQjEFMDoycdZHd45MRVKGJZ5hR+dKEmwQJBBPNUa/z7YOk2bjBvf
	 rf3WbHdyIfvXI0b/N/YMGCHheoRw0coKmnqeFMdfgU4KReOl7G9CZl6l6eTXms5J1M21w
	 6ZlzrOjj4cmhvVdwXgTNZnndCEH2G4gOen1UPVYmLdsJIA60gk/oQ/CaNvT1n1Rxb4yCC
	 kqFm5s5aV4Xp1Hlcf14YtjE6DpusDxgvRWxylzztExwrAtdqJ7h8iiKiqZQnlEyxgoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=um2R5SpVc8daNcOs4qf45cuP9GuM58HqVfWdcuuni5U=;
	b=Wj7oo7FxiNunPyFz1abTUkverzQ2ETMubHe9po7oJ4z25V+MG4/cgGOtzJz5dgfuyOf2
	 Zqo1VShgBW+0N3yKLeSTmxMDEpW9LY8oThMvrvVw3hR61u6hes9lhl+C1Qu75eUZbdPFi
	 R7XN0dHf8D3QGyWernGdT4VG5i82ixKUdqjOGvK9zDBioIZGHbAdiM1LD7e5hoeJHC+oR
	 wqI7HV/cLgc6w5rpTnC9oy0wehuQ5nfEuw8pTnC2oMuRoy6DjCod/sHR9DgtNjUNUggon
	 PbFpX2Kn1AGyahXrj0q1kbRxYHdZm1WZq9VV/aywnD+20D6ZCtsNH9qJIPJocQIuF9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E57jlpa6;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF6C606A334
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AF6C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E57jlpa6
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e46e449e8so1968568f8f.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 01:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794389451; x=1794994251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=um2R5SpVc8daNcOs4qf45cuP9GuM58HqVfWdcuuni5U=;
        b=E57jlpa6Vs6e1i3nKvCpjZpzm7ci9u/J/XqtTCOZMfFfoteIFJuP7zC3sPtujEAAmG
         wYTXJn3Rbk+jy+0+vDXyjlfgggPeaJIkcgOiEkiVy0OPc0B2WzyzBMlg/wYB0VMfLDie
         y8+re7NbvCoPWAZaAw0U+pf2QyHfldwnyLBqbnET+OwAlIpHSrs2xgm1BuQIkz/8Oi4v
         44g/A4qGsnjH+Gtsthd8C3Azy8y3N0deRf/ZD5GzIiir8uJPU2ipD7V0PaFLANwGIBs1
         rPU2ZSo4gsMPdAxqk4BQXMo8TGyXU7xkbG7FmFRtgdcV9CbhHKJMIOZZrAUSs1TMj423
         8cZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794389451; x=1794994251;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=um2R5SpVc8daNcOs4qf45cuP9GuM58HqVfWdcuuni5U=;
        b=qlK3aYCIS/yN/4isGZfdfIoPAruINqrWpGSh7x2C1x525k2T2erz1P9iUdDQ2UHxW6
         15C7ByXfK8geRBlj348jJ9Trr3DW8h9CQBu+P7HrVRJ3kU9PYZFs/l5Di39zdA176GXx
         UyaM6e04qOs/m47Dqr83+11Itbz6Ps4qVLy2AJ23cgUUtw/UM4ofkVkrVbClIaeE/AOH
         /phd3ChqyURFYQrSkO5iXlqCicWRsORmeSC93Jm2QGHwA2LVUxK2Ac/7vU4izHiEwcMU
         0i9fP0Bekwv7pDk/ma8gd05Wx8Pl23Rp3iZbAmsrXq2B/vTegHzJ9cHzHQeSli1ImBeu
         hiNw==
X-Forwarded-Encrypted: i=1; AL+hErEjEBd98vaLXyt2aDtmIc/vH8XM0rtQ8FHnajjFzK9hA8WS6k3t9SrqCOz7wJn8z3MkZZTsC2s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VKTaIOo5AAeq0mE5LVnbkaufJ7wnA/NV3ceRVoiYPo1vzSKd1
	UFzHftIXkuaIDcToib+2Znr/9+h/v095le0n73NC4vJUaLmHf2HScOyu
X-Gm-Gg: AYBFou0Ty2oOsfq7W2ajDJ3QZjDIHUt+4BuoOvpIBz4VEeDbxI6NueGZpEQLhry5+fv
	7NtOseCwul8lzE/WbNVAgb91BT6rY14fpsP+Pc/7Lf2r/92nN2Y+pkPladD5ZSWIQGuKX6H2BDA
	X1ReL3F3HQHv84EVqKvksfLkoXN17vmrMtDoj/jeHktM0URhFn9aIpinMjo5NBnK1/6EiAUC28M
	O06tMmyk/Ti6KDYx3754vt+AFE0hUVClo4FKqES8hXpu3kF8/vtIRn8DqHsf/h1DLaMMQSS51xt
	2jP5HNQF/pxKXsjEljgR18dulQLsoEDYh9yj1wA8nZgXh7h3jMPzDUbA8ej92EE74dwgt2eDEY3
	0CvfAlh+0AwcMmhig1+9tQw6ZHcLvkaImts7qemBJpF5Uzf1B6rdHSKKnhwelwsbZBjOfBLNiMz
	TPCZP+qXRwKiYk4msxbHKijaa9qyaceUz/ccn4qgHzq9MuSqp0vMNsPWVxJT+wHp8Yb5G4tgldA
	facc2efP1JX/mLWUZoNk8Pz0mkh0AtV1d6zaHQJXMaBChbFXlTQOOeZNdtgLJblpirkApfKyb98
	GC8oqIh7sc8Lxng7GVqwvQ7G2JElxNIQ+uDPHLvpSzYQp1QFzLW806PLVLg0ZL+BY9bMeQIUEvl
	w0YrTnI1Bz710zrgqY8tglIanNGFKLfB6LmlcfiVasVfd5/CfldG9JJyeAf41DN5s1a9E2j0xmR
	SpZiv4W/hPAy4=
X-Received: by 2002:a05:6000:4917:b0:490:6e0f:a024 with SMTP id ffacd0b85a97d-499c69ca529mr2701747f8f.13.1794389450677;
        Wed, 11 Nov 2026 01:30:50 -0800 (PST)
Received: from AHERLNXVDANI01.lgs-net.com ([193.8.40.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498362eb14asm9175839f8f.34.2026.11.11.01.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 01:30:50 -0800 (PST)
From: =?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	dima.ruinskiy@intel.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
Subject: [PATCH iwl-net v2 1/2] igc: don't disable ASPM L1.2 from __igc_resume()
Date: Wed, 11 Nov 2026 10:30:34 +0100
Message-ID: <20261111093035.513635-2-danividanivi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111093035.513635-1-danividanivi@gmail.com>
References: <20261111093035.513635-1-danividanivi@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 0325143b59c6 ("igc: disable L1.2 PCI-E link substate to avoid
performance issue") disables L1.2 on I226 in probe, in __igc_resume()
and in igc_io_slot_reset(). The resume path uses
pci_disable_link_state(), which takes pci_bus_sem for read.

__igc_resume() is also the runtime resume callback, and it can be
called with pci_bus_sem already held: pcie_do_recovery() runtime-
resumes all affected devices through

  pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL)

i.e. from within pci_walk_bus(), which holds pci_bus_sem for read. If
the igc device is runtime-suspended at that point, the call chain is

  pci_walk_bus()                      down_read(&pci_bus_sem)
    pci_pm_runtime_get_sync()
      igc_runtime_resume()
        __igc_resume()
          pci_disable_link_state()    down_read(&pci_bus_sem)

A recursive down_read() deadlocks if a writer (e.g. a hot-plug event
adding or removing a device) queues on pci_bus_sem between the two
acquisitions. pci_disable_link_state_locked() cannot be used instead,
because on the system suspend/resume and ordinary runtime resume paths
the lock is not held.

The call is not needed on resume in the first place. The disable done
in igc_probe() is recorded in the link's aspm_disable mask, which is
only cleared through the ASPM sysfs interface. The PCI core honours
that mask whenever it reconfigures the link, including when the device
returns to D0 (pcie_aspm_pm_state_change()), and pci_restore_state()
restores the L1 PM Substates control registers saved with L1.2
already disabled. Drop the call from __igc_resume().

The issue was found by the Sashiko AI review of an earlier version of
this series.

Fixes: 0325143b59c6 ("igc: disable L1.2 PCI-E link substate to avoid performance issue")
Signed-off-by: Daniel Viaño <danividanivi@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 62a7c5178..1b5dcc166 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7585,9 +7585,6 @@ static int __igc_resume(struct device *dev, bool rpm)
 	pci_enable_wake(pdev, PCI_D3hot, 0);
 	pci_enable_wake(pdev, PCI_D3cold, 0);
 
-	if (igc_is_device_id_i226(hw))
-		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
-
 	if (igc_init_interrupt_scheme(adapter, true)) {
 		netdev_err(netdev, "Unable to allocate memory for queues\n");
 		return -ENOMEM;
-- 
2.53.0

