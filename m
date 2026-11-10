Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284948;
	b=sYP3RKElx6WxPquwAvD89dIZWVukWFJuaqYm7KiLZzbIfRUGQwJnavJguQ6cNgXUx/C6
	 q26HNKR9SNHLTASdG/rYP8OksxD1pzakJcaVpH/jL5sTWMl9RlOhbUj3Eak+gQRO3hyG7
	 PhkRD800ZbBe2eL6ssSc98P4tnRz2fxmEAoOMmYiWTy25fawldgouAp3n9x3/glo4X1hf
	 EGlAk6Bv20gsIqP2hMoYSCQhMpXGYYbZGDRP6M1HJX1ZaNkrXkwHXVy0sZqMTNZ93A0nP
	 EchXYwVC56/Q4Y3QA82zMEc1Z9ag+M0VQLN5IQ6mcnod+s5AjgBwxo+nDI0kO2W3HnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PqMa10GWujoLZY5ARFf5ggCfIRSXU59hjyLHYjCoHzs=;
	b=lCG+3kGGfoUb8WeLh2vWDgQHPwezrHx6YgKr6pouBo3u9tVuMMHxnEl1t7vxywhwS1LN
	 9TjVjKWmPaQF6gRf/cVGCtefmtBY/zSA21cPgT6nVTgJk84Fj7fgjCwojfjo3D+kgT9zI
	 7wIGxb+laXk4JVTyoDhbPtFWvEYFeeW6dV7P8B8HtP2UqxVIBr+wIlRTdUs+pZ9jOoZdg
	 EAYsOMFwVIvzhnkWaheLJWHXOYtcHNbZJyDK1HhdTKT33o+1KjSMAdomsT3o0orywiSIF
	 0YKzXqvo7vplruqyj3d7K4lbyAEMUgGnXS72N0cVXG7rh2JGkQeZUw4WxzNpf0qpSmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QrvFQpiq;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BD7606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3BD7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QrvFQpiq
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-54f873cbe2aso16259081cf.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 20:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284946; x=1794889746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PqMa10GWujoLZY5ARFf5ggCfIRSXU59hjyLHYjCoHzs=;
        b=QrvFQpiqQvmj+9/Nm3VJyN6X5xyfcId/jmKNHZdY0e0FU3aMxBm4BL/M9o01QeWsCQ
         koc7cCHYMlf73nRQkFxDKO32QoPULOSIjtBB4M78esWbcpLnr3LYactRLbs/vBHsjqk1
         zxHFmadM7TwhntDZbAVIpKoCUG3cCwgZ5ckFAoBx44dr5+YBPk50jfpAOuJ6q7iy40Kx
         E94s2zR/xHuxQhZDhhi4hZfZBrjmM1RMo/TYc+tabXSmCT1mzxyz4cqxWaTAek2KjrbF
         TIZkJeTXuWBhUAWv0DcIT2AKqT3JTYbAWmoFrUl2K8ERZ2Iy8mr31MUhxCQFMpB9ZRwR
         xeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284946; x=1794889746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PqMa10GWujoLZY5ARFf5ggCfIRSXU59hjyLHYjCoHzs=;
        b=OXR7x13BreTAFCqOoCq8XEYmDlH3jQU1sRKDsxobP+osPo7WBnRI5tFfV84OKrbxZv
         Z+s4XMEbH0SuZB1lBBEpfSzP/nYhIG7PHUMADRvIeLbJvqbB3Zj+cyeaL3cEbBUkflhd
         KtgihI4CxxPBRXBaJcoifjDdeIZXctK8i2VvQv4d+HRSf89a1wG9WOrrSkfMAbWM5ueV
         8hvJt4I/RQxVn6OGZ3+PhEDzkrvUKoRF40+qGrj7SI3X6w7/aV+hpEypnQNeX42IaacD
         alF03r1zo1F9rePbq4WuQk3zHRntIhW99BuBF8zNKuQmSqhnMJlHacHY18aeaXyTUkSS
         rVwg==
X-Gm-Message-State: APuU4Z8442zVOAvno82ot7214jglnfc2X3RQEHXGYKt0IwgCsIRhc8zb
	zy/6K3sRxqLGyp+lhsy95+SSdMUY5qnDWa/U2v6z35x75HtR9URgLjM=
X-Gm-Gg: AYBFou1Gh9rk0pKL/60SWTV+ihiQFl23y9VLzY6pWnU3tXDvKsV45tsaTm1S/fjH5F+
	bby1hEA2k8A/RBuJBCFo0ZwmwC/58YiNEk03k0las10wnOep8S0lZ0F354I+lFFQ3iTYQ24exAr
	N4cki2aGTRnqOf1sMUPLERAM5MoBqnweHHXviBcCdzCVjCU1fZDSYiH5J/nHkNh1AHKRXDtWEhu
	wloVzgWxAA+crg6C+IZfsoV6+cejU860GT4cMozH1RiKYmcQQwzN0vfoWjjLHFDW+zUigP4uy4q
	Y4ftFiyxRXMiFa9V7YXoqT3aQPoomxB6nj1o38U2fUKv44ZUCIDfZlVb/4+TenMiVZsxooVCqVF
	Z+Y+WAcHPrbxwRaiGYNQsscF/gFYE1zB98mkXj4NQOYPr8hzK1/UU1bWmp5pdNzDJdZD884I+ga
	QM6GpqUxcVzOuS23P+fFCn9etWAAp9q+Qq9CYqefC6m2CV4fG9isujNVfqDh9XH2FLq4aPasYL5
	CGOXFcBhJ79LrGhlHQ8EGna+8V3pIaCtguVqpBoTtFmv2Q6x7z0pBUdEPJyzRrGoEzEnH4lBz56
	ICuAZW4KHHWD2z0UALXpaoLL4wjlEpd8zDJLIzwFyRyapPigvD+V1RrIYx1PXFvJAl/x+L0JNoL
	13d0QIJpv/UEZzKsyXyzWKb0SHewLVJncjaXs+V0G0LkwBvgkLsUPXwbYkTvmswmO
X-Received: by 2002:a05:622a:1787:b0:537:dea7:adb1 with SMTP id d75a77b69052e-55524e01138mr24744181cf.4.1794284945612;
        Mon, 09 Nov 2026 20:29:05 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b93ee00sm14190091cf.16.2026.11.09.20.29.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:29:04 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: 8139too: cancel the thread work after unregister_netdev()
Date: Mon,  9 Nov 2026 23:29:03 -0500
Message-ID: <20261110042903.55991-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

rtl8139_remove_one() cancels tp->thread before unregister_netdev().
rtl8139_open() or the TX watchdog can queue it again before the device
is closed, leaving work pending when __rtl8139_cleanup_dev() frees
the netdev and its embedded work.

Move the cancel after unregister_netdev(), which closes the device
and stops the watchdog. The work then sees the device is down and
does not re-arm itself. Synchronous cancellation in rtl8139_close()
could deadlock because it runs under RTNL, which the work also acquires.
Disabling the work before unregister_netdev() would not suffice because
rtl8139_tx_timeout() reinitializes it.

Found by a static analysis tool under development.

Fixes: 83cbb4d25771 ("8139too: RTNL and flush_scheduled_work deadlock")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---

 drivers/net/ethernet/realtek/8139too.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139too.c b/drivers/net/ethernet/realtek/8139too.c
index 8241bcf76664..efcf46fd9842 100644
--- a/drivers/net/ethernet/realtek/8139too.c
+++ b/drivers/net/ethernet/realtek/8139too.c
@@ -1103,10 +1103,10 @@ static void rtl8139_remove_one(struct pci_dev *pdev)
 
 	assert (dev != NULL);
 
-	cancel_delayed_work_sync(&tp->thread);
-
 	unregister_netdev (dev);
 
+	cancel_delayed_work_sync(&tp->thread);
+
 	__rtl8139_cleanup_dev (dev);
 	pci_disable_device (pdev);
 }

base-commit: 0edbc945eb9edd0086f25b151a79cfe4adc0dfa8
-- 
2.43.0

