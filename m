Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793944099;
	b=T1yRSNiLbvZ7KyHr/csDZ62Rjs0tUmQb3D63DLPSOhu4J46QdUSQVrzM6/gmsUqQFAgC
	 /TdlAVXVdzLMxziA53AoP5Q7s3Ryg32mMReOpQy0BrGioiuQ8JRxEzdg+9olVsLg/7U6A
	 NO8rombEdJ1p3zEveTs9/Y8SFJDBPyGETMfaDhaZTgXo70YQutrZfOym0OevKWpvzGhG7
	 CfQkJFtJLaMi/DAfwl7Vm1GswlvrTF1AkJOkfYVk4lADxoFA+FnpqpLEiuzgrYRze1RD0
	 plWnQ4Zz51XkFwKLzYW+v+znP1np3K9dAJ7q0Fc8Nc64/oTUo9SjoWFGnr2wz3nYHAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AAZ9IFW+Zz0SgqoelY4mhTjP7/bdw7XNlc/ioW2tjQU=;
	b=qxtbgis+4W1nV/G8ejrBFAncCuFVUAYjratVxrzoxjM0WgQSHS9H99lcaBbtkdMdrb71
	 StVpgon5fiZL1GwJLhb5jB/jDoK/o5ZxxOYhBCbOTr+NDJRdxa/GR3NTJFQFiHCCUKltQ
	 swtHnzqxWKYBEOM4celywY/7CYX+UD2cRp/1Ci+XM+5T4BipgU0qdb9Rh0MLSnHn811IX
	 zuN8MAXRRe+YIa5m7Dq7m+wkzf/UcA0VHkpRuJC484PWXvJx9DbLEln4MTSvfr+KxA1ci
	 wldiACF6cI9/p4+NV3aQxgM+83aBhOhmNNYF2ANAbwrQ2sMAwtrCNz9+2uvPa+HSJoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ONk0HDpW;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E69606EEB1
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 05:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57E69606EEB1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ONk0HDpW
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5366463571cso2782351cf.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 21:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793944097; x=1794548897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AAZ9IFW+Zz0SgqoelY4mhTjP7/bdw7XNlc/ioW2tjQU=;
        b=ONk0HDpWZTZzaxkSAtxiRZVFKONuE/vUvC83Dl4aQaEr3IsTawTEUDxCFznTrubGsV
         b1kaQMKgT/zzhL+D694dm/LKqMpCD+2SBbRPbNYxqlSGMWALBSD+t/3LHjwfavqiMFGA
         1g1Aobhwb8axvoY4Xt2EiRi1eOGM0DpK09+mQIDQVLhpKrfu7drRcnSO10IONIJTiryG
         3AZYH/v9roEIx1sqY+WysBwr9dP8GBwKlbwYCNt22n8pkoJLhN9lp0zhvAyX8MazcMxu
         gML8jHMex8z+ho+H0ZExqenrBXV9vZp3ItYGt2VgWyrSeNduXmQReWFmgx8M9NZa0ghU
         QUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793944097; x=1794548897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AAZ9IFW+Zz0SgqoelY4mhTjP7/bdw7XNlc/ioW2tjQU=;
        b=y+vg2cBrtPugo0PRpCgx2rSKlxbXCknv/6MSWUeuzcxBWoWySZTkxtnEtCxfuJ270B
         H8jkjCQIlNuBSO07n1cy3yI6Mtbu7a318/GEmMfIn8iQoTr1dE/gSRpCSknrBCk7mwqS
         s0e28tHCIFIUe0befqKVcFm9uKMyChVQPlZam5YC4kPLt0SjS+tn1OIsFMPn3AwRo5RX
         MkDo6giHKp//0sn88g1ZKgXfxcuPFH/m1xabIKqJ2OFtl+P3oJ5vOwWCz5IA/cL7SYrY
         3nJAo416eH2rLjDsdm0XF6xR5fRGPW27mHkWLq2drq96JtFhV+BA5qevdQsUFORvB/4p
         ezzA==
X-Forwarded-Encrypted: i=1; AKwUvBxNZpeb/WfloCy3WCJKEjdNI/Wq/fxAWjt41fvVQJ8wlHqp3Gme+0+9gDGDitnLIb1Rbs/1f/Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z93VeyTubFcruDMm0MQTyTY5x8dcqlyrSIM64NM2ACf0eLLrrQv
	HldJGiuOL8YBVyce+OBRs1JdWum5/kzw07IYcP8ndy/9nuufS8DvrQ/n
X-Gm-Gg: AYBFou0YlJC4X/vQzsjqXID3jc1Z5OvlRoz179Cncnv3VnKo+FFMGHfGz4yWJrFt1Oo
	AzGKWRFSFJIgQBQVEfS+/IDKwBJBs9sNX1HUqjeQ1kznbhh4GctNwWr0nqqg1lkTD/t6nYmWnrI
	HTs1wejHhwSM6Ba85Ip2qxv/6Rr/o9xr2l+e1w7yb3l68ehRV6DWCJfpq5z71q9StXW32QPge4x
	eP2GrJFVNh74Tmzjz/SXe2lL1o4dqsl/dczmuqofDWcs8jHS4cZ7SFIb4ljtQCQGrkMCshZaa4r
	fhj0G6yNQKIinmYp+IcQ772IC7cXpKxcEthZP7gVU/sOjZojH0Fws58gAcHLZBbHGtQQplZNOKL
	yHWh+VAkbqPHptfTe0J7u10xDJvW8tGttoDncD9Z0h4smabG/PqTo7yPG+JGVy0+GQQj4sFzH66
	nFXk+ZsP5dl0yO1MkO5H8dry76ux6+DI4Iaw4+QOOPqZSjAMb6TxzPu3ThLDOmu/620LqHpeoWx
	aEv1Lgcg7qNuoZXDW23wsg14tTee0J45KegURWcBXQQzEPT+kMHKxll8oCmdpEgtsn2hz5BAFRI
	NTsysqOvwuoxDWZdipHjXOHQQTKDZ6sATPhqN09ZeUQEAu9o96lt
X-Received: by 2002:ac8:5c8a:0:b0:535:52c:a2d6 with SMTP id d75a77b69052e-54e100e5abbmr22180261cf.3.1793944097227;
        Thu, 05 Nov 2026 21:48:17 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e26f1bd64sm11903521cf.23.2026.11.05.21.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 21:48:16 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Mike Christie <michael.christie@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] vhost-scsi: do not validate vrings during endpoint teardown
Date: Fri,  6 Nov 2026 00:48:07 -0500
Message-ID: <20261106054811.281798-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

vhost_scsi_clear_endpoint() checks every virtqueue with
vhost_vq_access_ok() before disabling the backends and waiting for
in-flight SCSI commands.  If that check fails, endpoint teardown is
skipped.

vhost_scsi_release() ignores the error and frees the vhost-scsi state.
vhost_dev_stop() drains vhost work, but it does not wait for commands
owned by the target core.  A later command or TMF completion can therefore
dereference its saved virtqueue pointer after the virtqueue has been freed.

Vring access is not a prerequisite for tearing an endpoint down.  Remove
the check so teardown always disables the backends and waits for in-flight
commands before releasing their state.

Fixes: 057cbf49a1f0 ("tcm_vhost: Initial merge for vhost level target fabric driver")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/vhost/scsi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index e44044449cef..f0966f25b09a 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2194,17 +2194,10 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 	struct vhost_scsi_tpg *tpg;
 	struct vhost_virtqueue *vq;
 	bool match = false;
-	int index, ret, i;
+	int ret, i;
 	u8 target;
 
 	mutex_lock(&vs->dev.mutex);
-	/* Verify that ring has been setup correctly. */
-	for (index = 0; index < vs->dev.nvqs; ++index) {
-		if (!vhost_vq_access_ok(&vs->vqs[index].vq)) {
-			ret = -EFAULT;
-			goto err_dev;
-		}
-	}
 
 	if (!vs->vs_tpg) {
 		ret = 0;
-- 
2.43.0

