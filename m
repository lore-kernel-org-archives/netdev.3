Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55F723C503
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 00:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483228; cv=none; b=Z1IgYavq0cKI3TV2x8G1cMO4yzgOBZly1QunyE9UiJUSV7K0vorhS03QuL8UXjo5J+gAu/+Yi7AnzwyMK60UP+09cuyhp4gnHO5rWJ2lHqbSxqadfl1rj1X6koM/9WHkh/XbsOGAEWaihWHBidLyts5UAfOu9q3L+iPnWQL1CpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483228; c=relaxed/simple;
	bh=0ZpfWwRDAHgu1mRcWZVQMtXirmVz5qsYIzeHiB+CHr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RikJkuJGTtbWpEfADw50mBF9Ow2Zr4oCKF+4viuErMHfwXbPw3820V3AJR8rf61+bePd24cwZx2LUQZnWKfSHzTYL51ugk9QZwE0sl+gnceRmjbUES3F58Xr1+lYuE4OLHTOiAOo+/bUIV0Zv+FRhoXYzdZyhD6kVD/rJmq2sLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAl2MJFB; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAl2MJFB"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca80d708489so343217a12.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 17:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788483226; x=1789088026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2el8XyfB2FMbOrmCud+3jZOtrXhR6MDItbmJqyOOTqQ=;
        b=cAl2MJFBgyOCpkwE97bNjJlzvr6OWg5YVgTAaMHpgiNDVPihn2QTCWTzWB9KXdwYSj
         7w0jUYeELjdjxtVpaVFQ4DfKao31tvdjtuHbnGlNCfXOu61ZkNexOfs9pySSMJrz9x+0
         o8DRD3ESp1IoXt+c6c9x+tHXSsBiBc+grHM7Iz0PK63UzsfTN6h3UGLGAXnrAQV2qBMT
         IZVQj/YgnIFyYpQvQkyMvzzsPQ/JGZoyo77aST7VgrL06gRJeWwxdw7H53qR06cgeMOt
         qmtgORdvz0TAene4buv/bNet4Etdfy7y3o1rr3UKNOuHIQblEkbIY3r8q6UevwQd8wo/
         EWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788483226; x=1789088026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2el8XyfB2FMbOrmCud+3jZOtrXhR6MDItbmJqyOOTqQ=;
        b=LkXpnCR1X2V9V1I+EEUowKHb9VZFTFxNtE+Xo8uuuQIkHiWBD4Ru6XucawPRSy1RNE
         k6uYtuZulfF/lyxN69/4VIQ63bqNCHB0NOex+aDR6kLhRym8FmGtsxBNsWJOO27whDfp
         YUfEnTUJNFNAhZl/zQpWVZ4xxLCmnU3Xhgd7A4WFLSMi28Wb4qJwKDPrNHFJF+9jRtWO
         DtVdVNV1W0sbwH30QoJFhQasJICXtXtkNCAO2/6zvSJygdEvdCKBIgxYibB3npX8IKA3
         owMdzzBrcvxjpob3DQniWCzKARIXJ5sRvAOL1xFzZzzkxnTqq/tjO0uUpbTJqHhV6dEP
         r1Ew==
X-Forwarded-Encrypted: i=1; AKwUvBxeNlUreRbBSR3wWmtnxcHkjxLXiNgu1B1vtFtJccgFlduVGwBsB+ZVv1mCXamK45iAqFMj3c4=@vger.kernel.org
X-Gm-Message-State: AFuF++m2fJGGS9VAkwA5aPv44iNFKpDZzVVWwYdAO8AKYOU0+M3+V9IO
	36li1IzdW7jFMhXRpMIiMW5MFkHyL52eZPER2whrf/z95zI7wXVYshbF
X-Gm-Gg: AYBFou0hdF99Db/B9FhTiq1aVsRkJgeVebLhfbPjKZHwKjuk9jO8E4JyTYaN70rDn8L
	gK+QPyy8ehcyHcYMyYELo6HWsJ3lqEfd8i0MWgOAo6iDZ17Yy/8v2km4KWG41cOyDZFNOPHHamx
	Pglvl8p0X8ISv/3BYk+3ASHvrbxcqksGoWvwqLAtK5lhFA2TIBtfqX/jm5oWY/BSWxzlSXGqueN
	EzAOSrLeBD2H+TJ47gi2rHuvrUYanAn8SNGe97DMNdt3sxA1KtnPYwfn/dVgape0o377ieb2jwI
	BvBj6bvvX8s0ycvD4npYhI+t6hG+3z4cf5P0Aac6RULtkqD9+p26OzBj46l48ExM4FXz6EaBKdk
	NOyL7ejrBTZY9iZuCxS878UQtK/p0H9O67p/iYHhFQFVBXCi1uG/9yATGtdbOZloSl+DkTROo13
	tMsdozCGBsfxXp4BKcNLLiO4TpAb0/G6JP+PmsH2g/2LWNyy7latpPCx8neAga
X-Received: by 2002:a17:90b:4490:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-39b279ad968mr1194020a91.0.1788483225951;
        Thu, 03 Sep 2026 17:53:45 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc081sm7701712a91.6.2026.09.03.17.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 17:53:45 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jaswangio@gmail.com>,
	Mike Christie <michael.christie@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Asias He <asias@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost-scsi: fix event queue iov out-of-bounds
Date: Fri,  4 Sep 2026 08:52:40 +0800
Message-Id: <20260904005240.502787-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_scsi_do_evt_work() uses vq->iov[out] after vhost_get_vq_desc()
without checking that the descriptor chain contains an input segment.
vq->iov has UIO_MAXIOV entries (1024).  A chain of 1024 output-only
descriptors yields out == 1024 and in == 0, so the length check reads
one past the end of the array.

With a host-side harness that sets VHOST_SCSI_SET_EVENTS_MISSED and
kicks an event queue filled with 1024 OUT descriptors, UBSAN reports:

  UBSAN: array-index-out-of-bounds in drivers/vhost/scsi.c:611:14
  index 1024 is out of range for type 'iovec [1024]'

  Call Trace:
   <TASK>
   dump_stack_lvl+0x5f/0x90
   dump_stack+0x10/0x18
   ubsan_epilogue+0x9/0x39
   __ubsan_handle_out_of_bounds.cold+0x50/0x55
   vhost_scsi_complete_events+0x55f/0x5a0 [vhost_scsi]
   vhost_scsi_evt_work+0x17/0x30 [vhost_scsi]
   vhost_run_work_list+0x8e/0xd0 [vhost]
   vhost_task_fn+0xe1/0x210
   ret_from_fork+0x348/0x540
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Require at least one input descriptor before indexing iov[out], and
treat a pure-output chain as a missed event like other invalid event
buffers.

Fixes: a6c9af87363c ("tcm_vhost: Add hotplug/hotunplug support")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/scsi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a1253b9d8c5..9b5f07f52b0c 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -608,9 +608,10 @@
 		return;
 	}
 
-	if ((vq->iov[out].iov_len != sizeof(struct virtio_scsi_event))) {
+	if (!in ||
+	    vq->iov[out].iov_len != sizeof(struct virtio_scsi_event)) {
 		vq_err(vq, "Expecting virtio_scsi_event, got %zu bytes\n",
-				vq->iov[out].iov_len);
+		       in ? vq->iov[out].iov_len : 0);
 		vs->vs_events_missed = true;
 		return;
 	}
-- 
2.43.0
