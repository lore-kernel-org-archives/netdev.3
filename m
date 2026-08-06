Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577EA3B19B7
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785999146; cv=none; b=qvD/wAiQaVLBAOrnYHSdRLWUvI4L83T336wdPgDRPnk/YzUoiYDCnHXUqgTJZtOkgW0AlqhBmKqtP+ZUL4BffFPMOHM1swIUky4mezuY9F50GkT/Dwv5LXeNkN592DBw5Hjo182IrZCzLuGOOOb7i9CE891cUwZAOZaQ77QwCv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785999146; c=relaxed/simple;
	bh=07xBgVVP2JBjaNjTf6tOGuw5SBbrqT7XyGX1346mHb8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UvZt/ONrerI57S6AxWlc85zJedBVhRU84ZY6U2ytTgcIyAm5rVqw5lSb/NZCDY8fzkpJ37wO6iW+9fkXMsc4REmupuCRkJTVk4WlPSgO7WWydd3yJ6MH0RH084MG+4uIWQoCnHu+Ag4QAVVc+5BnbPOpTJi8hRvIPicARvMrjBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAZW97r6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAZW97r6"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38f620399a0so1666240a91.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 23:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785999145; x=1786603945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Ci77Hl+QZM3Fah7Pj+TstLuIwRPYYUyZFUXDgpE0Gk=;
        b=LAZW97r6RTsVuFpO1FaFIHjxC3qx6LtblYS28Od9Mfn+b7gCdVaQDIyZR8RkK/gshQ
         Abrta9acmNNK2jo3nDwMPPuQPa0OWY2ti+lstMB+GC8xWOck86FAv2BWjClG7wdFUtua
         CeCXp0yQN4Ns/Zizai05fhzdgC7Yr7k2PrbLKnEZRkDifTk8FeUPe7XcZJ+OVIalACr9
         EZXeSSmfvJMbLnh0GRRWjxVifY1KfHfU/CiGDS2S7c8M3kcXQCMNwZLktetpau6PzVOF
         mxlFh/89/AwBhgn/mcbW4MwEpqNUj0L2PGfo1jSdxGaoUoaimq8YQQl4oOSH7xC8EAMD
         nJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785999145; x=1786603945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Ci77Hl+QZM3Fah7Pj+TstLuIwRPYYUyZFUXDgpE0Gk=;
        b=CMSkuhLuxbLI0mlJtK2PrsymCE2iavouVTcIn1x1HTBfpTtEdFnTolT8SHjzhZ/zrf
         RadlWnqumpdyDCVMpnUHyG+e9kXYwUtjb2ytJHI1V+Wr+fgap+nrbISGwF9/LggJNja/
         7dPw8Rn3a8a8VKeKGs3GdIFyjZFXNw6zKlACWAYmO408LIZVWt+8+9hwiDjoXQpw1mEx
         HuGWyxvlcyBRidcGivyloIDl0Yzo2bEhLw9HJWdm8WVud24rZZxYXlNjFkW51lKakme6
         ZAmgGBJndyUOIqSEkM5/+md5nO0xJZyD6nz6BHpvtm/kvrcifWg3ZxJKSzu+zCSFFTdz
         rmcg==
X-Forwarded-Encrypted: i=1; AHgh+Rr9IdlLw8TlACUBu6VB25FwyR4wxPJLviDv/XyKNcqrKyodHSeaw8DZ7poBjR5QcY/HS9yDLk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWQ9jGMlaaT/WFQkmUp3TP3H1A7x860dUjz2tAPu794t2As6i/
	eK91LBXa9SPcd7LpOZYih/lM4xhQPO2xYdSDNPN2NY5TElMF0xVLvgNJ
X-Gm-Gg: AR+sD10VEG3ndZyx4qU2FGRKDdnb/YLr8CUvpZZgpXn/ZA7HftJLVlSY3D/hfD+/Vd7
	35ldcUWAEOCoRbKKSWwehLkDPTHvbx6h5u7jB0cXDuDl1A8TCKvHLTnSJYnvgk+tTW227cwF+Sz
	A/p4ZwS5b5RXG3/EgwFnxUlrjhB3BfbAwAB8K+YC8XFuO1CufYMbvjhu8mOJQ5zIhEfDMWKJNo5
	P+yHhFtAR/z3Y4QS0a6QMUpEP2JQSir6IHeLo7J3YiIR/VjQWsD4KtEXdt8uvtMkUS/fxolVLIy
	rjC+m7r7HSGQWeZhZGBKWwykw4OWuiTfe5bpqZKJ8A0Uom1AaOBDqUUSYU6dgJwCARE6SOTtwDj
	muymOKrYfKvwkeSHBOagRmSkdonbk5/OGDhU496MjRf4yvF28f4yilGKObz7x4jSAo1/Z/glh/8
	C3hn0OeOXji9mvv4ohJmUQ4Gx979Sv5vfOWgLTQAn/3+eregz21/5I1sNi8YXEE9c=
X-Received: by 2002:a17:90a:da83:b0:38e:500:3975 with SMTP id 98e67ed59e1d1-3903c5d82a3mr11893037a91.18.1785999144464;
        Wed, 05 Aug 2026 23:52:24 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca508a48sm19408839c88.1.2026.08.05.23.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:52:24 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	michael.christie@oracle.com
Cc: pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject:
 [PATCH v2] vhost-scsi: serialize completion notification with callfd updates
Date: Thu,  6 Aug 2026 14:51:43 +0800
Message-Id: <20260806065143.55584-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_scsi_complete_cmd_work() drops the virtqueue mutex before calling
vhost_signal(). VHOST_SET_VRING_CALL replaces call_ctx.ctx and releases the
old eventfd_ctx while holding the same mutex. vhost_signal() reads the call
context before and after vhost_notify(), so a concurrent callfd update can
make it signal a freed context or NULL.

KASAN reported the use through:

	eventfd_signal_mask
	vhost_signal
	vhost_scsi_complete_cmd_work

The context was released through:

	eventfd_ctx_put
	vhost_vring_ioctl
	vhost_scsi_ioctl

Keep the mutex held through vhost_signal() so completion notification and
callfd updates are serialized.

Fixes: 057cbf49a1f0 ("tcm_vhost: Initial merge for vhost level target fabric driver")
Link: https://lore.kernel.org/r/20260720085306.1519294-1-physicalmtea@gmail.com
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Changes since RFC:
- Send as a non-RFC v2.
- Add Fixes and Link tags.

 drivers/vhost/scsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a1253b9d8c5..7f46bc0de3c2 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -735,10 +735,9 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 		vhost_scsi_release_cmd_res(se_cmd);
 	}
 
-	mutex_unlock(&svq->vq.mutex);
-
 	if (signal)
 		vhost_signal(&svq->vs->dev, &svq->vq);
+	mutex_unlock(&svq->vq.mutex);
 }
 
 static struct vhost_scsi_cmd *
-- 
2.34.1
