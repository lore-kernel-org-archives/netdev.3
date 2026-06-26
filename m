Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8C92F0661;
	Fri, 26 Jun 2026 02:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782439583; cv=none; b=PzKW0ggLnHHyAyVZ6y4TQRFVASTfZjNhgMdYE1s3rSRNeGtYyv0Yb+78Cbmdv+NWH2HSBSiGOqhTgKqOie12O98k1OX50HShZ9vivTaUEpCJaJzHKy3eCe0V594Mq/NrTGXOqBU4rmZkZj3thN2TPw5kytrBmgMPeGlTeqNoBHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782439583; c=relaxed/simple;
	bh=L28thVxDuPwu4W8UYQ3of1uvi9fpbjeAwjn5Ol+a02Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dR6By1/5VQZ9IIdiy3FvWHofWm3yAtRmHiYMbMQftbVUYU1m6t5diYF97L9CQB9X7xd/b7Of9WnQZeBUZuPxdkdLCdsB7iErLBZEjsgbpKP8NDjYeZEL5l1/Pd1rg3pjWSM4SRuWNpgkYJrA9SGP38CVTLmEi9zqSL4Cfql4ebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pWiiU50Z; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pWiiU50Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=pl
	cB/czLDn3eZAiAw8vFY41ABLwJ61bHMGAvnLvHR+8=; b=pWiiU50ZZSeGcRkGwc
	EgjwxY/UA4NM2I0tPTCd2yQd867oYizX6YmVFk1ylaqGV3wYvBcaLoTF3jkH90jN
	oAwXAIMPz/WVV+/msBnz3LEx3tv9oO7ndwB1Dvh1F0KnXvehJeMvJFVPTfX/ezQi
	qD7WpOSC7r3YOjqlVsAhkp/W4=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBn4SB83j1qWhWLEA--.17305S3;
	Fri, 26 Jun 2026 10:05:53 +0800 (CST)
From: Xiong Weimin <15927021679@163.com>
To: Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH 1/2] vdpa_sim: clear pending_kick on device reset
Date: Fri, 26 Jun 2026 10:05:44 +0800
Message-ID: <20260626020545.607600-2-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626020545.607600-1-15927021679@163.com>
References: <20260626020545.607600-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBn4SB83j1qWhWLEA--.17305S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWUCry3Ar1kZF1xJFy3XFb_yoWkKFb_Kr
	95uws7Ar43Gr40krykKryfAr90ka95WFW3uwn2qr4fJ34Ut3W5Wa1kWry3Ja97AFZ2ya4a
	yrWYy34xCr1rCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8iZ23UUUUU==
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC9AHBSmo93oGYOgAA3U

From: Xiong Weimin <xiongweimin@kylinos.cn>

vdpasim_kick_vq() sets pending_kick when a virtqueue is kicked while
the device is suspended (!running but DRIVER_OK).  vdpasim_resume()
later replays kicks for all virtqueues when pending_kick is set.

vdpasim_do_reset() clears running and status but leaves pending_kick
unchanged.  If a kick is deferred during suspend and the device is
reset before resume, a later resume can spuriously kick every
virtqueue even though no new work was queued after reset.

Clear pending_kick in vdpasim_do_reset() together with the other
device state that must not survive a reset.

Tested-on: openEuler VM (6.16.8, /usr/src/linux-6.16.8)
Tested-by: Xiong Weimin <xiongweimin@kylinos.cn>

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -161,6 +161,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim, u32 flags)
 	}
 
 	vdpasim->running = false;
+	vdpasim->pending_kick = false;
 	spin_unlock(&vdpasim->iommu_lock);
 
 	vdpasim->features = 0;
-- 
2.43.0

