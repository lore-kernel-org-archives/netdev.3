Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988772;
	b=At+3bPTAdr+Yc3j1APQP5y/YOjDgWfmJXVm1klnlkWNO4dMixrrt2cuRU+EbETEHmBOv
	 H+F+rhYbKpg1liGB5v2bE0X1XGP+wKgtyMBxp0M6TSi3XOCAHJpuZyk9RO0Tcv4n9zm+a
	 8jPUypcGWwzVDZCZR+mIRKwjT7hha6mb3CYqxu6RsuutmE743JTZPU7wnqSYkrvy6HwRM
	 eLOxjVWWuvsFrU7WMfrtDKNXZ7M8Tb0FkYDi32XKT1unGgX/1e958/cW2VnoxTcM5+oW3
	 aJiGoofbTiED7wfd0xV77pvs3A+tf8nzjEvXuSX5u8ctai3E67Qs152qoYHv4PXzfVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988772;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gO0P5VpQuCoxaaenUEBBWz4dwRcwcFr6ChWhT2qPqTc=;
	b=JtlDF3f7bHgiYmevj9K7ZhrHSVlJOlksChNtejNexnFzGjsI9SyRFaxpFsSDYzE4Wavm
	 wIB9qmcUWlrcE+t6G9g7rHs2IsheN3tJzrV5ri1Um0ZT8K14symaQmgjrXAToKTri5W3J
	 ghTrJ6HzS1c9Sqtkzx5PC4iqd/xwW54kO6gkHCHFqNJUmbgWbtLzcecmN7LPWT1SksRC0
	 ZCSR91TPshjSbtAB/lF1sMzgVI8+pQyZY4TmxPrOdDoiAyFZuzoDM0hHEXZ44geq5tUoS
	 EurnRMGYal8ZDrk35CVtUw53qINokyHhQjw112nOugZrcXmRrxXCGF3IHVgGGhh3msA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Nr0EVk/t";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B54606A33B
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 18:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96B54606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nr0EVk/t
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6HtA8w1075691;
	Fri, 6 Nov 2026 18:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=gO0P5VpQuCoxaaenUEBBWz4dwRcwcFr6ChW
	hT2qPqTc=; b=Nr0EVk/tjvtC/yicRRUQB+dSm9E1aLimK27ItlZh2USBaSU6blR
	rsZs5ajNEYZEpUH1zGyOjmRfQxmLE2z07qW3v1b3K8aKd9R1KRnYh4O+i9zn5bw2
	NpFTbS0EJMZ/kJXDz3KR+BTMOyjIcJ12lhatce5nYWvjRcxqpUh+uK8Yiz1EVNZv
	wUMxXSTzrHTQuOTMBTibKZX/hwNo/zjA1sZ9C0YRwp/3IRIkXieDRTAE3LwWsns1
	4lB9O65aChgI+HHDl8NlQCG3ZjhfipcEsisVf4b01baZfUlFgP95S19Yq3FHucC8
	FliYbinvjEFIUctWSw5iEE0aAtKa4hrKLYw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pb42s4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 18:12:36 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6ICZj0752657;
	Fri, 6 Nov 2026 18:12:35 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-zmckevit-lv.qualcomm.com [10.81.84.220])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A6ICYKl752643
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 18:12:35 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4696302)
	id C893F2219E; Fri,  6 Nov 2026 10:12:34 -0800 (PST)
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
        riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
        rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
        airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
        lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
        troy.hanson@oss.qualcomm.com, youssef.abdulrahman@oss.qualcomm.com,
        Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Subject: [PATCH v3 0/3] Extend drm_ras for qaic telemetry
Date: Fri,  6 Nov 2026 10:12:22 -0800
Message-ID: <20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: F4tnFHbNGp3rUx4oFwT--3610XfbG8c8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MiBTYWx0ZWRfX7QlRicRznu9T
 OPJB5QBt92QBUbmScqWgc+c5bb52jgD1p/krKlHNRfRO0rlEAfz+zxgXg8wetBGeFZPFUZkC6NN
 vPnu6soCJjwCoQX7QJu42N6u84n7tu4=
X-Authority-Analysis: v=2.4 cv=LIrz05W9 c=1 sm=1 tr=0 ts=6aee1894 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=UCRyeg6Ua9RyKZwra7UA:9
X-Proofpoint-ORIG-GUID: F4tnFHbNGp3rUx4oFwT--3610XfbG8c8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MiBTYWx0ZWRfXwcX5erxMvlw8
 R7P+iIYxL7LTAWsfATbGl1hQPK1QOr+GIOgOazWTEg1KPOSxLQSC0kmUWh5AbAbFlbpK6IDVkvX
 Q+MTkYccPdfIa5TyvilzzlRNh6ZX/FkgcCNsxnL4ryh/GcJhvnHODzPQsuHVHi0SITIReyzZ0bO
 XIyUZ4ww7FMPfpe91HRPeU9uDNjMSaNxAqo6lRHZ/wjpC2ExZ5Ru4XVcIDiJeQMjP63rJCIpTgn
 +T4YJoTenrMjICbdNzGw0szhaHMAZHW8Lgd1FVstuSkMjJzVRh9a3Mb2Cf00R8toIS4Q4WZQN1g
 jCIqS1RJY1S+xT+X0by69FzFeOt9KIrEbY0ah5l1B15nVvQuC7iov2mxS3Oyu2CcmB6LYkEu3dE
 H1xCSYCet0Ysw7VUxpBeWT5lAtWuADVtsnr/aFA2i7TmuoJTu6QxzB5TWEv2vQsu8BmN/DV+Q2q
 q98PTii3AARHxBMrCxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060072

This patch series extends the drm_ras netlink interface to include a new
node type for telemetry nodes. Telemetry nodes support two operations,
getting and setting, and drivers may specify an optional predoit function
to validate each operation.

Telemetry get operations take the drm_ras node id and telemetry field to
be read and return the field's value and any status reported by the driver.
Telemetry set operations take the node id, telemetry field, and value,
and return only the status reported by the driver.

This extension removes the admin requirement on the list-nodes operation.
This allows drm_ras nodes to be discovered by userspace programs for
drivers that do not necessarily require admin privileges, like qaic.

The new drm_ras telemetry interface is implemented by the qaic driver,
which exposes the telemetry fields to userspace and enforces filesystem-
esque permission checks on telemetry operations in its telemetry_pre
callback.

Changes in v3:
 - Address Sashiko comments:
    - Properly return status when telemetry request is successful but a
      hardware error occurs.
    - Validate telemetry fields against their gettable/settable fields
      lists when invoking the predoit.
    - Update documentation in include/drm/drm_ras.h.
    - Moved calls to qaic_drm_ras_register/unregister to mhi_probe/remove
      instead of pci_probe/remove.
    - Added srcu read locks around calls to telemetry_request() in get
      and set callbacks in qaic_telemetry.c.
    - Added a tele_ch check to telemetry_request().
    - Properly handle a -ERESTARTSYS return from
      wait_for_completion_interrputable in telemetry_request().
    - Ensure field can be truncated to a u8 in qaic's telemetry get and
      set callbacks.
 - Minor code cleanups (typos, header ordering, etc).

Link to v2: https://lore.kernel.org/all/20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com/

Changes in v2:
 - Address Sashiko comments:
    - Initialize certain stack variables in drm_ras.c.
    - Added attribute guards (GENL_REQ_ATTR_CHECK) in telemetry doits.
    - Added a valid node check in drm_ras_nl_pre_telemetry.
    - Fixed improper node callback in telemetry_set.
    - Now registering drm_ras node after MHI initialization.
    - Now removing drm_ras node before freeing MHI controller.
    - Added scoped_with_init_fs guard to qaic_telemetry_pre's inode check.
    - Fixed improper kfree in qaic_drm_ras_register_node.
 - Changed telemetry value attribute to sint and dropped padding attribute.
 - Updated documentation in drm_ras.yaml.
 - Renamed telemetry read/write to get/set.
 - Added dumpit for gettable and settable telemetry values.
 - Made telemetry_set optional and added admin-perm for it.
 - Specified ynl file regeneration in commit message for patch 2.

Link to v1: https://lore.kernel.org/all/20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com/

Zack McKevitt (3):
  drm/drm_ras: Remove admin-perm flag from list-nodes operation
  drm/drm_ras: Extend DRM RAS interface to include telemetry nodes
  accel/qaic: Add callbacks for DRM RAS netlink telemetry

 Documentation/netlink/specs/drm_ras.yaml |  83 +++-
 drivers/accel/qaic/Makefile              |   1 +
 drivers/accel/qaic/qaic.h                |  19 +
 drivers/accel/qaic/qaic_drv.c            |  14 +
 drivers/accel/qaic/qaic_telemetry.c      | 563 +++++++++++++++++++++++
 drivers/accel/qaic/qaic_telemetry.h      |  18 +
 drivers/gpu/drm/drm_ras.c                | 331 ++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c             |  55 ++-
 drivers/gpu/drm/drm_ras_nl.h             |   9 +
 include/drm/drm_ras.h                    |  67 +++
 include/uapi/drm/drm_ras.h               |  19 +-
 include/uapi/drm/qaic_accel.h            |  28 ++
 12 files changed, 1190 insertions(+), 17 deletions(-)
 create mode 100644 drivers/accel/qaic/qaic_telemetry.c
 create mode 100644 drivers/accel/qaic/qaic_telemetry.h

-- 
2.43.0

