Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EF138836C
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791477539; cv=none; b=BHOcH/u2qVtf3U+0hcYJkqhlARnetfp9gYrAeHPBkr4bpIokicTdDAQPUgzDhk/7HTEo98+8rr6n0cegiZVM+GocbBWtPkneANPZvEKr9FU5pOtPYbA/f4evx0V9uaQw0cL549JVQE1WkRq9hHmlIFdak4uhw062iE/0ww4nh9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791477539; c=relaxed/simple;
	bh=B7/RTXGw6xEkN4S3aF0mbacVGPs2NY7fb3eIo7Z50+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RFXYOJuUeAthe6f8mJnzJNcx1iQVFjrywGOCAPovWK6GH2N8MyiSLg3PuXnYXvHkgSN4vM3oepBob5xlBIJB5dk7/xeijyUZmqpPdwykuEocnHq3sciMCuPzyVUoKy48SE/oIhWeZDvicwv8sQAv1Aamd0YPV3xeFvvJpE+xk7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bd12I3zl; arc=none smtp.client-ip=74.125.231.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd12I3zl"
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-6de822d01f0so2183130eaf.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791477536; x=1792082336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wcr1e3DelCZYM4o9phxk5vNklRMQLSyAKhNB5dBEr6o=;
        b=bd12I3zlGqyad1SU1bgON32oKdVg4UULWAImb6h+3sJnng3qlhcbkplvxvAkvuk4wy
         n7fxfP1/TRsOZqH/+7c4BzFXKjP7Yl7k4wliFAro8W/8j4Ze7RHGVoEkYBB+dVGXF17n
         BLwdE4Shb1LzlCR1TKekFl1fF25eYKIUcJFPEhPfUDv/lqxm7tqe0kvYFFRxCB3Vdm0l
         QJtS3AU2q4FwEkuhBWyr8qSG119ifKefVvF7EDPdv+EHNIvbwuPN5hTqBlZdsCX3IlcQ
         U1+KL5Z7GdhuL5BUi6Xnz65klnYNoncYECenOGTtbQSbSnh62anWF8f9bUzli/prkDxi
         dWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791477536; x=1792082336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wcr1e3DelCZYM4o9phxk5vNklRMQLSyAKhNB5dBEr6o=;
        b=zNOXvB6g1OPy1Rt3903ltnbagWh/FPa33NdXMKa7RvhmqGX41anqAtaGCPJhmDvrx5
         CT6GJdFK0mCPu7F+K15j7L5XT2SBIbqGsQ1Sai2p8+/DOivA74/517fkapylmfQTceJX
         5giqyWEYxzHaU65dzvOFaEq2T3LKrg0S9/n2YN7X6QxbePRCptVn32YaAuk4rMEw888u
         HSH2PMRlRD1RdTn5sWqs3Po4Xgac3GedYNziINHH2QCVgy0XSTsJkOLme5lF1uZ2dDnU
         Rf4RQsmSquHSbD59q299dgLL0YWuF4h0JAyHt9xNmhomjEUWTEvnVw2dZjUArpIKV4Kg
         8C/A==
X-Gm-Message-State: AFuF++kT+hn3EwvirVoX/8GJdbof/79N0m9AJxsoMPwx0mopxrGC4X7m
	LfYPD07N1FJYLCb9gBLd+qJ/rnxhGL1HCTz07XDqZBeo6pMylljDWvtP
X-Gm-Gg: AYBFou2yVR9r749LYMRS0tSLTHfu2G0LSvUQPrskDvVXHSmT7kYFuODnfLtnZtjHfZI
	hzvgMVGML8Xcbc96grM0JLXjuAug0i1fZw+pihY7IrzmCTjPtKTXSG4stVFkWYD+svXL44933yf
	7W9OuNZ218L8pn7pX54tANZGahqiNAFGfGCeXvlCpEY2VhjpvYpTLt/z74eqf3EMCUEkmOYLWcD
	A9LJ983ohjHfzoLHcxDGwfQ3yIfZd5UTfnVoqCv4Urs4/3pvCErLeIa/CKruSzKcxm3qbfI1QBv
	3RbQyHXANRA9aD36KsfH0DP53gN2QvJ1g/HOyWGhi8UXVBC0aRijBKFpUzqyixVJfsRQwqzyLm2
	2Cur0fdupvd7pTir4IPx21Li1dAM2qGr0x+ZKHEmU9+QWnuFIMf0+nQyNTR5dHD/JLQch7kuHFR
	fGxVRbBYosQCBXo+pfUTKJIKUc4Zo+7NWI9aF91feq55kbAM8rlso0spA4MmKGH59qObWR+CUtC
	0+Kn/02Alwc3a3qJJNSRskC/fwKKKK6Dla2
X-Received: by 2002:a05:6820:1628:b0:6d7:a13d:fd7d with SMTP id 006d021491bc7-6e7a727cb87mr5941490eaf.53.1791477535895;
        Thu, 08 Oct 2026 09:38:55 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.164])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82fc7cc8ad4sm64328a34.7.2026.10.08.09.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 09:38:55 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] rds: fix out-of-bounds conn_path access via handshake NPATHS
Date: Fri,  9 Oct 2026 00:38:43 +0800
Message-ID: <20261008163843.957325-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Connections on the IB transport (t_mp_capable unset) own exactly one
rds_conn_path slot, but the peer can still claim eight lanes through
the NPATHS extension header of a handshake packet, and every
subsequent fan-out path then treats all eight entries as real: the
mp-start helper iterates conn->c_path[0..7], dereferencing cp->cp_conn,
taking cp->cp_lock and queueing delayed work on cp->cp_wq at 504-byte
strides into whatever comes after the single allocated slot (KASAN:
"Read of size 8 in rds_conn_path_connect_if_down").

The negotiated lane count is now clamped to the same value the
transport was allocated with (trans->t_mp_capable ?
RDS_MPATH_WORKERS : 1), so a peer can never ask us to walk lanes that
do not exist.

This vulnerability was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: ba3d1f480c7a ("net/rds: size a connection's path set by the transport it ends up with")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/rds/recv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -224,7 +224,8 @@
 		/* Process extension header here */
 		switch (type) {
 		case RDS_EXTHDR_NPATHS:
-			new_npaths = min_t(int, RDS_MPATH_WORKERS,
+			new_npaths = min_t(int, conn->c_trans->t_mp_capable ?
+					   RDS_MPATH_WORKERS : 1,
 					   be16_to_cpu(buffer.rds_npaths));
 			break;
 		case RDS_EXTHDR_GEN_NUM:
--
2.43.7
