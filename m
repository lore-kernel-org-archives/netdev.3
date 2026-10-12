Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CF13AAF5F
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791801627; cv=none; b=OwU0KSVWki5YMu75Nm511JyDK/SdC5QGiDv9C7GJtiAxvU5pcHStd80TutlNpNONdHJKjGfUoKMnr9oLgRxHCBjiwQeeLxedpA+2V2WWq4NmPv7nFLqHIVjCflhwv3ytbn1q0wDOGPhRv2cDpBw7ETy/hwrZo+RRFU7nhpDwbTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791801627; c=relaxed/simple;
	bh=vFkCRtgxGCnpOhlZA7FYzY49jEv/8nkM8zfXlvjQOfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=faYLlsXM377KMsNh9vMig81jPXG+fX0fsSJuCGUWObUqDdU0yd48qXTP5yVfOBRj+zhiCkdz13h0OyDauqVNpFZH49FT6gJ8xpW80FEhCZYb8LhDuf6eCpK+Wlcqt+v3ciF864onj6eJLOs9+IoPRMtKTy1aqeFTLecb39WMIkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hufXMIw0; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hufXMIw0"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33e6279a1d7so459987eec.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 03:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791801626; x=1792406426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3l61iXys9UAgeiq6Qoow/JEP0G8Esaw8ppQEGcd0fNQ=;
        b=hufXMIw0EVpInfTHhpYb/QUt24+17FSeX5h06Wfnpgb8Jkqyyg8piXuqxx0i625Ai/
         d1vDYYMkZ+rRr30gF8oMr/6BYgyg9nnWRXXjq7qrdsMkFBencCoYq0KKVxe4dFuKqDdA
         duwdxgMF+BUMMevDDeIs/s9YhAgGSLzDgmafK5TY7GcB1laaUuybDctQojzxBOeaoBdN
         V7kDovVSMCCZs+TYIVIFuBUB7ZLi5fnvzeA/FT0HhRFFbgD6IbZS/j77mtX+TwzxYbJ4
         RPfwXqe2M2dA8zSmwVeABniRXbFeYUNUG1Pqnk2e2EU+NrxUOc5FgDbkatK5yVGjHi09
         80mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791801626; x=1792406426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3l61iXys9UAgeiq6Qoow/JEP0G8Esaw8ppQEGcd0fNQ=;
        b=p3I7d+P92do1eWD1TkDpRnb3QAvoSKazlgJqecUMOOOoZC/v9KSFgROyfslCFLOaaI
         7GxOO0Z8aDaIQNe4epxcO8j0gcSXvOGi6c/Umvw1KhA4/NiISxP1J+hsxgxPEal4DRht
         m2fZgNRC6MDqtF0MlUvNP7PHRPjgpDx//0fqAK9nkArYL2SHFLOKb6UNntded6Db+jVW
         BPe98wqG+02cPkQ1sT0lLDZGk8RpljgOKsn3mhwubVuGtJfdg3KMUf6VeBvhf0sQjgGX
         WLk3CtXiSSk+kjjVaWKW0pQ3Y7fOvrxYx9pmaUq4kClLnz47EtFdp5YDptXCU7l9iqRL
         bI6w==
X-Forwarded-Encrypted: i=1; AKwUvBxY91VI57d2/fr5McCxKw1vW5IEbC1g34JWaJHoB2IN+LrfOeRD25t56OGW/9al4bx4GhT1hAY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNmjTlnxJPd5q3mBQKwnzsbho6hbV1RDj0ijc1/H5OWFCLdDKd
	CXUjnMXVbpZXPI9sUmJkvU1Alc4VrNNmvQGvFifVbtLFxSncgXZqyZUL
X-Gm-Gg: AYBFou3/DCZFb90aCn92ZO4YU/YfNEn8WmPmavpaNpaYv8I3eRrFG5UUlZUhGTeis0k
	6iQasRpQ66E5UmHY6tYMvnKSFbYcTI6FmTHD5xjTtbJKJumEK45kDXSAFfPdAC4vn6vOvPIGIK4
	cYBZZG8+3qMbMr5rky3G/Oipi9QMCLnAn2cFQXrMuRvrWFfYxU7L/UGL75RQQSbeC4F91k7ja/K
	8L2OoESN2TSbtl0KugrANkEskQw6F6f6qasGsTmIOnTHLiqldK+3pheg+N1XqJhRhtcDP8diNEj
	KqU3U1svTlwELvlBfLHfAxytifK7fcOWDerPLI3V9xQxz3DVEpBED2SfDZr8ldtkFUDsYGV95Fa
	m9+7yTvV4/asfxAJzR+vxb4vYw58RFlG6k/gu5E7YU4Uk/SH+7HtrjQNbnKBvZBsX1g2iZR6XLR
	sypcVcKBuzbdM5kbz4l3sMBBT63qZHC+yfod+YlfEAnF4nr2F0Kb9k5IpycLidGaKvOYX4QQ==
X-Received: by 2002:a05:701b:2058:20b0:15c:20b8:7964 with SMTP id a92af1059eb24-16a63386d86mr13548313c88.27.1791801625139;
        Mon, 12 Oct 2026 03:40:25 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm31434866eec.28.2026.10.12.03.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 03:40:24 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH v3] vhost-scsi: do not count PI bytes in the data length
Date: Mon, 12 Oct 2026 18:39:54 +0800
Message-Id: <20261012103954.136698-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_scsi_handle_vq() moves pi_bytesout or pi_bytesin into the
protection sgl and subtracts those bytes from exp_data_len.  The length
passed to TCM is still exp_data_len + prot_bytes.

prot_bytes comes from virtio_scsi_cmd_req_pi.  With
VIRTIO_SCSI_F_T10_PI negotiated, vhost reads that header and does not
check that the CDB is a READ or WRITE.  sbc_check_prot() replaces
data_length from the CDB only when the protect field is non-zero.
target_cmd_size_check() leaves a write's data_length unchanged when the
CDB size is smaller, so a command that does not get that replacement
keeps a data_length larger than the data sgl.

The KASAN report is a MODE SELECT whose header had pi_bytesout set.
The data sgl held only the parameter list.  spc_emulate_modeselect()
walked data_length and read the next physical page.

Pass the data sgl length.  Protected READ and WRITE still take their
length from the CDB in sbc_check_prot().

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
v3:
  - Rewrite the inline comment to distinguish the data and protection
    SGLs and explain why TCM receives only the data SGL length.
  - Note the related target-core patches for PI tuple accesses at
    protection-SGL boundaries:
    https://lore.kernel.org/all/20261006093338.27342-5-physicalmtea@gmail.com/
    https://lore.kernel.org/all/20261006093338.27342-6-physicalmtea@gmail.com/
    https://lore.kernel.org/all/20261006093338.27342-7-physicalmtea@gmail.com/

v2:
  - Drop the claim that target used to subtract prot_length.
    9f977ef7b671 cites 14ef9200, which is not in the tree
  - prot_bytes comes from virtio_scsi_cmd_req_pi

 drivers/vhost/scsi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 4f8c0260bc9e..4bd29c2ceed9 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1534,9 +1534,17 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 		 * vhost_scsi_queue_data_in() and vhost_scsi_queue_status()
 		 */
 		cmd->tvc_vq_desc = vc.head;
+		/*
+		 * vhost_scsi_mapal() maps the PI bytes into cmd->prot_table.
+		 * It maps the remaining exp_data_len bytes into cmd->table,
+		 * which is the data SGL passed to the target core.  Its
+		 * expected length must therefore exclude prot_bytes.
+		 *
+		 * sbc_check_prot() derives the data length for protected READ
+		 * and WRITE commands from the CDB.
+		 */
 		vhost_scsi_target_queue_cmd(nexus, cmd, cdb, lun, task_attr,
-					    data_direction,
-					    exp_data_len + prot_bytes);
+					    data_direction, exp_data_len);
 		ret = 0;
 err:
 		/*
-- 
2.53.0
