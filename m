Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734DF3AA1BB
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274921; cv=none; b=KbxmH1gc7gK6Z/2awnke/wZM/05dq/jRqWgvJOgRl85Tv7yTwa6I7APkzzzPh3vqaPl/BdIFooUxhPWpDzHu/GbrjVx14jO7j+oGe9zEK7vS5vjeYW/45o6DoviUX+KpKV94x0M4SL49iSvyC5b+Z3kOKaC3D+n/wL02kC3hAMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274921; c=relaxed/simple;
	bh=8obgukGNW7ky7Kk/hIb7Tx1nD/UtTtHjcp92oif6oK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fe5/AFzsJuYcPWR+u0ZSIykdfUS+lAxpAAeNqK5jFXWuhmwrI459sArIPIdpGcg+z6ZeiJc7BODgqdiDtlT5s+LqL79dKX1vuf1mRrEW7itXw5aidbuM4Nb3tw4qy+7eoUIPlMpJUOrV+MyTTpLtbzVpAvFFzwj/u2WJENB7RRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0Xdv1+G; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0Xdv1+G"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so318135a91.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 01:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791274920; x=1791879720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b8u3Yoco6qaMZId6V3SXGgwbYt0UtNsiNUBPhWK2nhU=;
        b=m0Xdv1+Gml3S8Z5KJmDNN58lyZP1sgf6qPHbzMbWGTtrSX4ppMxjDzQjjkFitF3Tli
         Ns0uq3bcJKCyUwIAFFc0o023gVefmmPDOF0KuLA/fY0S2Y9CUK3OupAS2UEkOrCugBkA
         lIPJp0QmDKg7m+pOgAxbMfo4F+H+L+bo/VtFbNnNfilTYdC1jDKUcjwdR3iiOCyCcwlc
         rOR3wLipqV1DVQ9P2gy9m2RsBS80kYcYjlghYjLFh0fkmO1635q+wj8Jehkkd1qRsV4w
         T+pluCfp/ENkK4Nrpvac91SdcY1QYOiI9HQDJIMfxgG107jcGlv5MpMi96M/QRsRgYWS
         hHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791274920; x=1791879720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b8u3Yoco6qaMZId6V3SXGgwbYt0UtNsiNUBPhWK2nhU=;
        b=szc/87IJ6e6uYcVazkDBEayhOKTmyW3Xqa/ixey2tFO0sUDeQ0OMQmyjQno4uCM17k
         tmh2hE+dS7mO47KpV8IslDxnFBxOQ0iSfYGEXj2YV2c9166+LtrEOGmZyVryKLP2fU6c
         m3gEP35BR+x9b+TrU8qn/WNi+f6BhHsvKSY0Pzt16/jarC+2V772c7g4oWdlFhuzks13
         U8Z/eHuLAg24JNI//yIxLh4XUjcmjh6qTgROT5b4aHlzCiaj+r8IpW8Z/0G6JPnBmdnj
         B5udTUFlvnJzEa4NdimFm4ytymJ61o1k7TaTLElBWf2Mfz6pZS8V/19InN2NUVAojNuu
         ubhA==
X-Forwarded-Encrypted: i=1; AKwUvBy1Gg9biTPxlc3eaiTkgk5UppWrTmVaX2A/v8rnLI8tUvX4M91tMa7ipbcTjcDVhPOP0U3Nwv4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjxQ8Pggn6CBNgIhtjGTDkOS6d2AqUv0ysA2qYB2Lsdk+tm8DA
	b0PCSeIQlfHwHXR0UhK4RvpvvtrkrYey2cKBUizbizOA8+XTZoSCDl7n
X-Gm-Gg: AYBFou3zKnQL53kd5uvTcqNpTQMNy+1rG+o5qY0bastodlhutOVTivXU0AUojP08Gct
	tMdQ4CHj4PasNfu+8eorNK8jjvfRsb9YSNrFWYIYp3dmRQ3A3QmBYuDVudiSLYg19YloR720+W1
	km8HgCn8i9EA/lK2jXfWRHupDFT878wh4Blt7yOqp+IPJTxIIVwBI3ooUaTZiPibDAOYvv0Nxac
	ruy7TLdcdhxboFaWOTWAYYWaiUFFuobaqyCyMXnIW/193HWhXyVfuC+u2w9peCRjcMNrgTrRqkw
	8dLOZdbRhumDbMFHI9aWeUIav0RFcIHANsdMN/hKc3d3vqKDytP4zymyufBPtbhKKxaUoi0OeJC
	qstIqj0VFLM8PmicYqKYreQrQ+RA0Vf4IYmN6SUTKJkBPukemRK2MtJeFkYTmend8CA0X9RXJXK
	3ig9CnDe7IWoGt5b0LmoD6x5Nz+lt0lGVPR6y1f0/utPMiGHLwars+Jh+9k07G/vXL0Rj851w=
X-Received: by 2002:a17:90b:288c:b0:3a2:b036:ed62 with SMTP id 98e67ed59e1d1-3a8733c829cmr301292a91.37.1791274919752;
        Tue, 06 Oct 2026 01:21:59 -0700 (PDT)
Received: from gmail.com ([188.253.12.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cea0f1sm3628152a91.15.2026.10.06.01.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 01:21:59 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH] vhost-scsi: do not count PI bytes in the data length
Date: Tue,  6 Oct 2026 16:21:02 +0800
Message-Id: <20261006082102.27085-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_scsi_handle_vq() moves pi_bytesout and pi_bytesin into the
protection sgl and subtracts them from exp_data_len.  The length passed
to TCM is still exp_data_len + prot_bytes.

That sum matched an older target path which subtracted prot_length
again.  sbc_check_prot() now replaces data_length from the CDB only
when the protect field is non-zero, and only for READ and WRITE.
target_cmd_size_check() leaves a write's data_length unchanged when the
CDB size is smaller.

MODE SELECT, SET TARGET PORT GROUPS and UNMAP then use data_length as
the size of t_data_sg.  The PI bytes are not in that sgl.  A parameter
list that ends on a page is followed by a read of the next physical
page.

Pass the data sgl length.  Protected READ and WRITE still take their
length from the CDB.

KASAN reports:

  BUG: KASAN: use-after-free in spc_emulate_modeselect+0x145/0x380 [target_core_mod]
  Read of size 1

  spc_emulate_modeselect
  __target_execute_cmd
  target_execute_cmd
  vhost_scsi_write_pending
  transport_generic_new_cmd
  __target_submit
  target_queued_submit_work
  process_one_work
  worker_thread
  kthread
  ret_from_fork
  ret_from_fork_asm

Fixes: 9f977ef7b671 ("vhost-scsi: Include prot_bytes into expected data transfer length")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 4f8c0260bc9e..4bd29c2ceed9 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1534,9 +1534,13 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 		 * vhost_scsi_queue_data_in() and vhost_scsi_queue_status()
 		 */
 		cmd->tvc_vq_desc = vc.head;
+		/*
+		 * exp_data_len is the data sgl. prot_bytes already sit in
+		 * the protection sgl. Protected READ and WRITE replace
+		 * data_length from the CDB in sbc_check_prot().
+		 */
 		vhost_scsi_target_queue_cmd(nexus, cmd, cdb, lun, task_attr,
-					    data_direction,
-					    exp_data_len + prot_bytes);
+					    data_direction, exp_data_len);
 		ret = 0;
 err:
 		/*
