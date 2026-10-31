Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793434710;
	b=WTrKeSqlZjI4+DLQ/1GKut+ePH6YzQ6DN/3TxHBlg9xt5MxH/okfqFMcnxaiZyKum8Iu
	 HBD9VINgFuMuRsyp2AxkPRWHEuHeQaierIjGQBOBHcC75JgeL322yFZgfGVkMmZV/vEku
	 x+Sq/m6WTOC9cB4Q5E93oU+6Q6I7qfPJeWmzOach/Nrzvw5aHJMDE9j/LWgmPxs1pT4mr
	 Tk9tnLagXemfP+oTBFTIX7vKvoiNrk3fysbXkqIvQ0eCkmjIrhMXa4RScAGzbWYxGaDdl
	 uNMRh8swMrtNkdG/mqZPWS1hbQ5Y396RyxZGYtlIGRh45kkLAPOlaWRVhqvVywGh1sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793434710;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sDBeurIWAFQDgxQKm/s2crPlEd0DqwAT0GeJBEFzefQ=;
	b=WzxNFU+6o4wLh7E0FR/2YrH9NzO6DShoOicUJijk0IRiLmqLRdSm92Kt9u7Rg9e/ZllV
	 fr5iSOuYrpxiVeN1LRFT0dg0Sp/gxHw/m135Bc0nk6VZLGXBVfxc2J6dalRqOK+hICwWr
	 6hSJ2wxByxyqO6jlpZ1MEDkwc8KYBZzVTlKDtRQA8IRv1m5OAWGVA8MJ+9SKTyTUUm63V
	 Y+gVJRYeGDVVRQ8NcNEKMVqhhlHqf0lw66OMPRmIi1VNLi9mqjCSsbd3AQVE9THBF5bbk
	 CIkwJBSkR2IlKRzfA4FnMy+xIDQ3ED6CXfuJnJ4FN94t1tMfMbnFP4Qn3ZkmSVQo1uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=NAgEkx3f;
	arc=none smtp.remote-ip=43.163.128.49
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4B0606A320
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 08:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B4B0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=NAgEkx3f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793434700;
	bh=sDBeurIWAFQDgxQKm/s2crPlEd0DqwAT0GeJBEFzefQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NAgEkx3fOEhwtDB28kmNsrNruUdVwdr8C6awAdDvu3NG6fLgCRDmq/DBQfdjZCIFd
	 1R5NhNKeC29WgF/jE8/3LMX5N3CWdEmC5Q8qW1tH+BbEoq9VG4YOjnpu9C69MBrezn
	 Eotsy1XLo17vbRw42fmi3z0ckxl9tgBsReSKMGYQ=
Received: from localhost.localdomain ([240e:3bb:302c:4eb1:751b:856d:f57c:9109])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 48E960B1; Sat, 31 Oct 2026 16:18:14 +0800
X-QQ-mid: xmsmtpt1793434698tz755so0j
Message-ID: <tencent_C8979534D68BB65897E3183028088010A709@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeTbe1cxNw1xg+ZmzH27FApnc+77+iHTCMjCHxo+2QDe1SU5dD+o
	 uIEO4phNu65pdmegfEMOO/aN5CRihxkHQT0yvE7meshz/Voz7IzlTkQgmffAFlZr7dSTH44a8Tty
	 D80336728KQJdpUpShK703uR/Wf3r2yllvmb6If2wD0zvxHx50mv9KE3v7HRTq2xKdKHbtlFEKiO
	 1NryINO70ixL+RNymjMRmAz62ZxGXK91JqGONWEosaqxgSZkQA8qrjJL6Eyk5jncPNKktp1tQwID
	 XtGU0EuZrvy7mHMr+vDIyYTQ2GSOufj87XFb4HRUoxtWs+Ca44NvUf5QNWgIY1mhLp3YjGxxOwUc
	 dmCp0ljTEWRrO1P+rj4kPi6re4r/lpvhnxVPTI/TQZfnkhgC2xuHhx1NmS8KjDjDkL3KgmAou8YE
	 e24tG4BUnFK2+a2DBhdUI+x4ENILFTIQwfLta8OV7gYsqddbnskM7NgvZU1Q/fcVpC20pAPy1g7h
	 FJ/YLuCE3rFC9nv3PKoOWqxNH+lfO1RuOHxuE7iyclQN5NwjbHGNKA6YaaHJAvRkJh/2FVKk0W7x
	 5hgB7CcRnYbdLc1M1XXThE7n8fXNc8LVhVmY109AjRLeLi6weX7k1r4gEghn+o2Ydr7ZxBCgh8Wb
	 p/RQvAYBZHM5KP6h66mJPIYo2ytj3uixIXhmkuifmHqAAE3IDd2zkzZdRAo78HhWAYzb1Um//UFo
	 3crxyz2SPJLzXXerCO4xa0ptqD6Nb8AEbyr3YmVW2vq3TlVB8i7hVpwvo4yoXDNIwbRm9R3XNd4f
	 2naFtUXEMXv7cld/jKedEGIuUO71E0TZXO2ZX5WjWuVnf+RowHftOOmhS++f/ZdIAQU43kXxpS/4
	 DaC6ZoIKnPGoQsMoP2Ys2GRll8AagIvjWlrzTqaIKjhm1AR6/ZzS9dvs5abRX11toXDYa+h0PGn8
	 8PtuOKaoQ4EzvBdDTk31RbzYPPbOuqrwz4d+UfSZim0UQiiZHjpX4AY+Tdz6to7Uh/Tysla5YoVi
	 ShdY05H/BtMFxSJI7GfKU7ys/2tI9+xIqVIbgb/HRumi0LAQ73sWQE34RkeEXhd51D8+J6Qg==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: daniel@makrotopia.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	johan@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v4 3/3] net: dsa: mxl862xx: do not leak firmware result values at ALLOC call sites
Date: Sat, 31 Oct 2026 16:18:13 +0800
X-OQ-MSGID: <20261031081813.64518-4-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261031081813.64518-1-memoriaru@foxmail.com>
References: <20261031081813.64518-1-memoriaru@foxmail.com>
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

From: Zhang Hewei <memoriaru@foxmail.com>

MXL862XX_API_READ() returns the firmware result value (>= 0) on
success. The ALLOC-style call sites (QOS_METERALLOC,
EXTENDEDVLAN_ALLOC, VLANFILTER_ALLOC) test the result with
"if (ret) return ret;", so a non-zero firmware status is returned to
callers that only check ret < 0 and can end up stored as a block or
filter id.

Split transport status from the payload at the three ALLOC call
sites: forward negative errnos, turn a non-zero firmware status into
-EIO, and continue on the ret == 0 path where the payload id is read
from the command structure.

Fixes: 340bdf984613c4a9 ("net: dsa: mxl862xx: implement bridge offloading")
Reported-by: netdev-bot+sashiko@kernel.org
Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
---
 drivers/net/dsa/mxl862xx/mxl862xx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index fe4db9b7f..c599b1c1e 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -352,8 +352,10 @@ static int mxl862xx_setup_drop_meter(struct dsa_switch *ds)
 
 	/* meter_id=0 means auto-alloc */
 	ret = MXL862XX_API_READ(priv, MXL862XX_QOS_METERALLOC, meter);
-	if (ret)
+	if (ret < 0)
 		return ret;
+	if (ret > 0) /* firmware reported a non-zero result code */
+		return -EIO;
 
 	meter.enable = true;
 	meter.cbs = cpu_to_le32(64);
@@ -532,8 +534,10 @@ static int mxl862xx_evlan_block_alloc(struct mxl862xx_priv *priv,
 	param.number_of_entries = cpu_to_le16(blk->block_size);
 
 	ret = MXL862XX_API_READ(priv, MXL862XX_EXTENDEDVLAN_ALLOC, param);
-	if (ret)
+	if (ret < 0)
 		return ret;
+	if (ret > 0) /* firmware reported a non-zero result code */
+		return -EIO;
 
 	blk->block_id = le16_to_cpu(param.extended_vlan_block_id);
 	blk->allocated = true;
@@ -552,8 +556,10 @@ static int mxl862xx_vf_block_alloc(struct mxl862xx_priv *priv,
 	param.discard_unmatched_tagged = 1;
 
 	ret = MXL862XX_API_READ(priv, MXL862XX_VLANFILTER_ALLOC, param);
-	if (ret)
+	if (ret < 0)
 		return ret;
+	if (ret > 0) /* firmware reported a non-zero result code */
+		return -EIO;
 
 	*block_id = le16_to_cpu(param.vlan_filter_block_id);
 	return 0;
-- 
2.39.5 (Apple Git-154)

