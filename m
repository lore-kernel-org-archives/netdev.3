Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092463ADB9A
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785483616; cv=none; b=r/gpi2yuQ8Tht230bNWzGwu2dZNJpYoTO7Wa5LMQ3Pkc5E8B8tpzsd6LceKzUk9tpsL7bkx+wEbdxFCOuXW6tCKQtWWDx5W7jkZbht+y/9ukEDDWJyvs2qzQoHg/6er0+Qf311PYzsdMfcrOVCESemNEaj2I7ABt+VhCb821FEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785483616; c=relaxed/simple;
	bh=OnlbFkRdAUOo0eDKFLcka40CVSUP5MlmySRbVyY4hbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkUGc+PKN7OrpVJle4DAkWhfgt6L9fTg332NUq2ZWWWG6ImOjBpVJJakGxyT+Nr3k95ESrnxcoPM5XqQK1m/Uf30bbugqb7Lh6v9pzjSizDdmjBovHXgpiX8e+KptjWqnzym3ajSC0qJZG9IahpvoUVYdUnKtu18KA+uPp/YPNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SHjNJ6u9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SHjNJ6u9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V5HcJk949346;
	Fri, 31 Jul 2026 07:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lo0BQW/8zomkj5t1C
	I4rW+j4xR1OWoWhqjwG7/D3+DA=; b=SHjNJ6u9to6p+aCVDoOU27p49uh4Gk4CV
	h6CyiBBieehOvkRtlljpkiYZgs15c1yx6oPMV8jcT0K2nM1Pd5iigNvOyz5CCVBh
	nP05TEUTeypF4uwXVAL4jRtwQkJHdYRfaOHIpPjOwOtuBwgusCMgC9DYPbl76hF/
	qeSGt4XzB52uT2xJ2uiPByOn6sgvhUlmYgfJV74r9/feJlpqFZbIfbS/63gGIeMi
	iLV9lqOPM3PM/ti1/Da2z9giF7nrQPUqMR439OCNfG5fekXRc1YFAAMHN4Y642/W
	VaYqsz44TINbvqXjtg5Z7fhyvWE/wKZVRRjzsaU6n+t6c97agHePA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0y3xd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 07:39:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V7BKvS022722;
	Fri, 31 Jul 2026 07:39:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgptpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 07:39:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V7dmKb50331970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 07:39:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B97620040;
	Fri, 31 Jul 2026 07:39:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 502CC20043;
	Fri, 31 Jul 2026 07:39:45 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.125.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 07:39:45 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [RESEND PATCH v2 2/4] nvme-tcp: limit I/O queue count based on NIC queue count
Date: Fri, 31 Jul 2026 13:09:06 +0530
Message-ID: <20260731073918.614014-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731073918.614014-1-nilay@linux.ibm.com>
References: <20260731073918.614014-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Xptdp_JEtp1w6ub_O3EMp6LK8rxne38x
X-Proofpoint-ORIG-GUID: YjFbW7_VmtXXYTpT90DwqWKxhuKkAcuH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA1MCBTYWx0ZWRfX3pr2wrNTQ3Rf
 v3KVmMk6VB5/HvNqovJ47xnCac4147+r39wh/EoJ5XxWGFN54aDUpkExG5nGbaV/IgQFiPCMZuG
 wyd1KpNSnUr+PmeeWNFJD3KZrVl917c=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6c5149 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=MwK5uCCrhwR5b2NhIngA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA1MCBTYWx0ZWRfXzxKpY3bvBoPl
 SsAKHVw9c6B255B21bj4T0TXTYjKcU87G1i4AH9lHY10l7gomUhdW6Mh1eyVu7JJNj/7dFrm2xF
 r5B3JmzPTowz8f3p91sGlx1KV8I2Dz0Jr4DfASanxVPWO7ZzLtUID4+4ujvfukNnh8qRqALGsOe
 nPDI7yUK7SZcL5+MYBvoh1QOtw0P1gkJemA2VuNARuql/GoGDrMMD9iUxUrhPc4oJR7hgyGzfu6
 A82OSwVGnQCBTeZel3l6HlKcpc7pfvSAjv5a69XN7aMx+Su9CcLwFP3EIHyERXkjc0tYw4Q9BrW
 Ec/sdSKa95e7feBA786D3eADDWmPR7KqJeLOr3lN6SbkooWb/51bWOoUzsSkbpYcQhysaz/WF01
 RK5UFSq1qHWsivK59T/YQq6xol3+aGOqT9GsYJ/pEXjraC5wZWWOpn7kBk87AkumwfTRfjZvjQr
 Ggm0YwTzAL+2ScuyoPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310050

NVMe-TCP currently provisions I/O queues based primarily on the number
of online CPUs. On systems where the CPU count significantly exceeds the
number of NIC hardware queues, multiple NVMe-TCP I/O queues end up
sharing the same NIC TX/RX queues. This increases lock contention,
cacheline bouncing, and inter-processor interrupts (IPIs), reducing I/O
efficiency.

Limit the number of NVMe-TCP default I/O queues to the smaller of the
number of online CPUs and the number of NIC hardware queues. Aligning
the number of NVMe-TCP I/O queues with the NIC queue topology reduces
queue sharing, improves locality, and can improve throughput while
reducing tail latency.

The number of NVMe-TCP I/O queues is now limited to:

    min(num_online_cpus, num_nic_queues)

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/tcp.c | 61 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..a2110287099e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1774,6 +1774,50 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	return ret;
 }
 
+static struct net_device *nvme_tcp_get_netdev(struct nvme_ctrl *ctrl,
+		netdevice_tracker *tracker, gfp_t gfp)
+{
+	struct net_device *dev = NULL;
+
+	if (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)
+		dev = netdev_get_by_name(&init_net, ctrl->opts->host_iface,
+				tracker, gfp);
+	else {
+		struct nvme_tcp_ctrl *tctrl = to_tcp_ctrl(ctrl);
+		struct sockaddr_storage *src = NULL, *dest = NULL;
+
+		if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR)
+			src = &tctrl->src_addr;
+
+		dest = &tctrl->addr;
+
+		dev = netdev_get_by_addr(&init_net, src, dest, tracker, gfp);
+	}
+	return dev;
+}
+
+/*
+ * Returns number of active NIC queues (min of TX/RX), or 0 if device cannot
+ * be determined.
+ */
+static int nvme_tcp_get_netdev_current_queue_count(struct nvme_ctrl *ctrl)
+{
+	struct net_device *dev;
+	int tx_queues, rx_queues;
+	netdevice_tracker tracker;
+
+	dev = nvme_tcp_get_netdev(ctrl, &tracker, GFP_KERNEL);
+	if (!dev)
+		return 0;
+
+	tx_queues = dev->real_num_tx_queues;
+	rx_queues = dev->real_num_rx_queues;
+
+	netdev_put(dev, &tracker);
+
+	return min(tx_queues, rx_queues);
+}
+
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				key_serial_t pskid)
 {
@@ -2165,6 +2209,23 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 	unsigned int nr_io_queues;
 	int ret;
 
+	if (!(ctrl->opts->mask & NVMF_OPT_NR_IO_QUEUES)) {
+		int nr_hw_queues;
+
+		nr_hw_queues = nvme_tcp_get_netdev_current_queue_count(ctrl);
+		if (nr_hw_queues <= 0)
+			goto init_queue;
+
+		ctrl->opts->nr_io_queues = min(nr_hw_queues, num_online_cpus());
+
+		if (ctrl->opts->nr_io_queues < num_online_cpus())
+			dev_info(ctrl->device,
+				"limiting I/O queues to %u (NIC queues %d, CPUs %u)\n",
+				ctrl->opts->nr_io_queues, nr_hw_queues,
+				num_online_cpus());
+	}
+
+init_queue:
 	nr_io_queues = nvmf_nr_io_queues(ctrl->opts);
 	ret = nvme_set_queue_count(ctrl, &nr_io_queues);
 	if (ret)
-- 
2.53.0

