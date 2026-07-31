Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568CA429CDA;
	Fri, 31 Jul 2026 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785508048; cv=none; b=BwzuqSGNIvDCJ8ieFOZnnbptk6ipz108psopdk70nJESg7yVm9kSZVivS4+FC2ainGvb+pjRbmzOhV1no2gjY9O8GkizBrfpx88T72kJ04MT806sIAQyXEwvOUHBWiu/uksKQU+iV8v/Z9CFn+FMo1/lj7c1rRRic98IrF+/HVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785508048; c=relaxed/simple;
	bh=krxbigRlp4wJR2BB49xpHjU3rIArYaSGwEPZyL7zezc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hy36X6pXiBCjYXq1Zr7Fu9QKMjQH8V1zjUWXa5r2jEgS51bPaMjRWpOa3fNz5hVc4WAoeoWDkQHxRIuT2qRFa6m+Di5IPO80hNCfm93AjuJD9IlJjAyoV0RHXgjdkUS4TiJIZbiOSI+s6HZGlohYBHYDvU3TIQZV3PCImZX6qQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Bd7ge3vM; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Bd7ge3vM"
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VE3uZx2107706;
	Fri, 31 Jul 2026 14:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pps0720; bh=YwfqH99xZmjePsPJeOQ6gfg6bWNKh7ZOCaBf41F+ihg=; b=Bd7g
	e3vMcLvniAudYTfhSKhJbPw5vRFtRR6b8vG2CK4B64olfP2d17cEurrmRnr057NN
	vl5qAi8qxmilyayHKMGl2M/QxMNyIYGxdw13VmSL6xIQLPrBdJtB9zyzvZ1mrhJW
	UvFfT86VPapsfq5P4IlJAB7uxn3fMZEa02It6n3OCcRxGT4EC9pdgNymNTeo+ZVS
	Dq9vF/gl8ImXSyYHGm/T9He90tp85TRCsc62E/GdmmXqq4TRhA/nBx+8xc7PHzaD
	evVfukhyxIL1Nm+jAWPSxWtiEkvuS6gtJ5qcpNvdwp5mgpPVniWyPiU7kBCGHehW
	lRqV63OjjblAI3Nbfw==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4frsgvv8mm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 14:26:51 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 77AFB1307A;
	Fri, 31 Jul 2026 14:26:51 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 2EE4080A3EA;
	Fri, 31 Jul 2026 14:26:49 +0000 (UTC)
Date: Fri, 31 Jul 2026 09:26:47 -0500
From: Dimitri Sivanich <sivanich@hpe.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Steve Wahl <steve.wahl@hpe.com>, "Anderson, Russ" <russ.anderson@hpe.com>,
        Robin Holt <robinmholt@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <kees@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David Hildenbrand (Arm)" <david@kernel.org>,
        "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@arm.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dimitri Sivanich <sivanich@hpe.com>
Subject: [PATCH 0/2] Remove the sgi-gru and sgi-xp drivers
Message-ID: <amywpyZgGWyhzBjZ@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExMCBTYWx0ZWRfX2811tTWXULVd
 tgHrI5lgfg1DojxrnPY4no2Du70sRAks+teodt0pIYtU/h5zeRZ1620JRyFfsH5ekEcSWnRmk8j
 mS83yxqGF4MoYh2jZpl4iv3d86dPtaQ=
X-Proofpoint-ORIG-GUID: pUbeJcjI4fIqjulI7DYD4CYqaPFEmhPO
X-Authority-Analysis: v=2.4 cv=UfphjqSN c=1 sm=1 tr=0 ts=6a6cb0ac cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=6_mrDcixewTG61oOsKN3:22 a=6F_QYv8xcMlYYqOjOdMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExMCBTYWx0ZWRfXxu5twjM0lg/M
 gROFcip25hvTIHKdS0UetklTHzLwc0BPORlKgbKRFY1PM+R1bXeQ2qKMXh3Khq+aKsfMo49wlQx
 MbbHceopi7CIPOVdzwWeTFoGMEylbENT6j8Pi4LkFFKSxUXfjJP4NwUAZn5SDAP7kLiRxfiUZUV
 hl1g4tNBg5wSQ59wHBSOIuOoTmCR841d143Z0XhjpDBQB6XGKDQwiM24YZQ2bc1+0ASDwtDthMl
 PBVD/mPc/lISeBFnTJbhCmhNax90T98VNtmoWBCaW3PWyptvCPvy2cCuTk2EnmRw9pdumamQxWJ
 07vWi8pI2tF+INrGrGyGeHwmiKFUzvYz+mjKeT0GidIhKCdENaRT85CVCv3udT/qKN5eFl/dY6Y
 N11Zvg3WnauWU1rdS8+utE/mUHHN9HoaigIEYjWJARzoXyzsQFbnlTrgZrxwMB+UkWFbVq55SKv
 yWk0XUqThoL6o+te7GQ==
X-Proofpoint-GUID: pUbeJcjI4fIqjulI7DYD4CYqaPFEmhPO
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310110

Due to security concerns, remove the SGI GRU driver, which cannot be used on
anything newer than the long time unsupported UV2 platform.  Since working
sgi-xp drivers require the GRU driver, remove sgi-xp as well.

Dimitri Sivanich (2):
  misc: sgi-xp: Remove SGI XP drivers
  misc: sgi-gru: Remove SGI GRU driver

 MAINTAINERS                             |   11 -
 drivers/misc/Kconfig                    |   34 -
 drivers/misc/Makefile                   |    2 -
 drivers/misc/sgi-gru/Makefile           |    6 -
 drivers/misc/sgi-gru/gru.h              |   76 -
 drivers/misc/sgi-gru/gru_instructions.h |  726 ----------
 drivers/misc/sgi-gru/grufault.c         |  903 ------------
 drivers/misc/sgi-gru/grufile.c          |  540 -------
 drivers/misc/sgi-gru/gruhandles.c       |  192 ---
 drivers/misc/sgi-gru/gruhandles.h       |  517 -------
 drivers/misc/sgi-gru/grukdump.c         |  223 ---
 drivers/misc/sgi-gru/grukservices.c     | 1157 ---------------
 drivers/misc/sgi-gru/grukservices.h     |  201 ---
 drivers/misc/sgi-gru/grulib.h           |  153 --
 drivers/misc/sgi-gru/grumain.c          |  969 -------------
 drivers/misc/sgi-gru/gruprocfs.c        |  308 ----
 drivers/misc/sgi-gru/grutables.h        |  659 ---------
 drivers/misc/sgi-gru/grutlbpurge.c      |  316 -----
 drivers/misc/sgi-xp/Makefile            |   13 -
 drivers/misc/sgi-xp/xp.h                |  341 -----
 drivers/misc/sgi-xp/xp_main.c           |  261 ----
 drivers/misc/sgi-xp/xp_uv.c             |  151 --
 drivers/misc/sgi-xp/xpc.h               |  732 ----------
 drivers/misc/sgi-xp/xpc_channel.c       | 1011 -------------
 drivers/misc/sgi-xp/xpc_main.c          | 1309 -----------------
 drivers/misc/sgi-xp/xpc_partition.c     |  545 -------
 drivers/misc/sgi-xp/xpc_uv.c            | 1728 -----------------------
 drivers/misc/sgi-xp/xpnet.c             |  599 --------
 28 files changed, 13683 deletions(-)
 delete mode 100644 drivers/misc/sgi-gru/Makefile
 delete mode 100644 drivers/misc/sgi-gru/gru.h
 delete mode 100644 drivers/misc/sgi-gru/gru_instructions.h
 delete mode 100644 drivers/misc/sgi-gru/grufault.c
 delete mode 100644 drivers/misc/sgi-gru/grufile.c
 delete mode 100644 drivers/misc/sgi-gru/gruhandles.c
 delete mode 100644 drivers/misc/sgi-gru/gruhandles.h
 delete mode 100644 drivers/misc/sgi-gru/grukdump.c
 delete mode 100644 drivers/misc/sgi-gru/grukservices.c
 delete mode 100644 drivers/misc/sgi-gru/grukservices.h
 delete mode 100644 drivers/misc/sgi-gru/grulib.h
 delete mode 100644 drivers/misc/sgi-gru/grumain.c
 delete mode 100644 drivers/misc/sgi-gru/gruprocfs.c
 delete mode 100644 drivers/misc/sgi-gru/grutables.h
 delete mode 100644 drivers/misc/sgi-gru/grutlbpurge.c
 delete mode 100644 drivers/misc/sgi-xp/Makefile
 delete mode 100644 drivers/misc/sgi-xp/xp.h
 delete mode 100644 drivers/misc/sgi-xp/xp_main.c
 delete mode 100644 drivers/misc/sgi-xp/xp_uv.c
 delete mode 100644 drivers/misc/sgi-xp/xpc.h
 delete mode 100644 drivers/misc/sgi-xp/xpc_channel.c
 delete mode 100644 drivers/misc/sgi-xp/xpc_main.c
 delete mode 100644 drivers/misc/sgi-xp/xpc_partition.c
 delete mode 100644 drivers/misc/sgi-xp/xpc_uv.c
 delete mode 100644 drivers/misc/sgi-xp/xpnet.c

-- 
2.43.0

