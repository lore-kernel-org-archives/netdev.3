Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468762;
	b=KeiJKfqe4z+dmg0mTG3OOKnSSrsoIcJDII5vBlZStl3NepY+/kGxeWNJdER76I9sgOsT
	 P8qK/aBWg7OAVyeyoU0Ljvt621nKfoGHcK+R+NOUNP1X/4Yq3HTAbyIpPX2zQQ6eMF29s
	 875IoZYFMIN++fk5hA8a11VleCySLZ+fOQCnOsCn8BWc2AaSDUMEsmJmJNyd412ry46AO
	 fXAVVQom7A9FGHSqeHrauqq4BP668R76z83kjPcOmmDOWkjK0Pg+UBRijx84RCL6O0OVd
	 jNfmr2MyrsTCRzxXFWNeQc2AWVU9iYZ+CxIoiCvr6kNr/yjX+KICbx7iXGBVIAFGNCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468762;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aJekqtZd8q/3ArsU+9b6lj5+AIzwCIpS5G7gHNxiD/k=;
	b=YIMk3ZU2zoY8jQxl8jXrrDau7i8TWSXtPJAcjYAq1uM8Kit3MVzHyRMs+BOJ6XeUjUMJ
	 UZdzqvMST34wPv46T8Suaj1s/aCV2VUA0iXOFqbpWk74Fuo8DkpzAXcaYLbR6w3lRSlLN
	 9pEkmoeTwFmgBifKMxP3pGADnHCxauhS+X+V0R965V+hAAXGHV+PHrRW+ggVcJI1aucoq
	 1rrE8WX64DUjPI3j3zuGFinWV6mx/P4CTLgmTAmLpqg6UycvztkyofjQ4o7b3uWB5WCQt
	 fN7xoASAVsEfIzuNB/FqhB4cxyB+1nfmROg/pYKZI79JX43ner+E3xWQ5/ptODbhGJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=WqfoXEgz;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=xcuXSKgX;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8033860A2608
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 17:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8033860A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=WqfoXEgz;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=xcuXSKgX
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VDnC7i632438
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 13:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=aJek
	qtZd8q/3ArsU+9b6lj5+AIzwCIpS5G7gHNxiD/k=; b=WqfoXEgzdHJJs2k8MvcL
	/g26eZf704RKz7uoJY5+9rJDc6ve6LKz6U10MPfAgHvLPvKnmXk0qCaoj8FZA6MX
	bZZgi5GV2eEAGbTBxjT2nltAnNbNlKQdLU6h/m1muqfSEEaBGcdkEnryPVi+8NlD
	ujzT124VPz7gZm5cBAL6kOzSmqzuqsEtIUDdaEnmklCwbroLzcA8l1FLwG2HM1gr
	t1VP7RbxQeDen2IVg9AsOIMMN1tnYeQHmMz4y+o0JtUM5G+M7hXxMkJGcYXtAunP
	93Sl0hc1/Om0ITQ1mNCbnQarY2Pbf04sTH2EqcpBwfGsh7aXypj6Bm75lOCVCChA
	VQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hnd9jacx3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 13:46:00 -0400 (EDT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5eabb3a1bb8so453514e0c.2
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 10:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793468759; x=1794073559; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aJekqtZd8q/3ArsU+9b6lj5+AIzwCIpS5G7gHNxiD/k=;
        b=xcuXSKgX6gTElDK+bujY9YbrHFARyL5smwKml7TSGaZx5cKkVf+o36wIXohcFFdtWm
         6Hd+hs0clol5+UbuQJcHE1jOW/MVkwtvEu0GlFclH9hlA3vXsKKzZS3SDSOxre7IV49p
         wSUxJRKb5ZhlDkPGQaYXRsUwaR8OXwywo9Iet9uSQvMbCJa33lJ7QnMtr45cNEbGZprV
         9M5P9iy0AfpWLOhqrlzdp8FgqcuFUt09HdHXUjaY12cgb4i+B0byL/p9MgZBeA8LVRT4
         pOWi4Hs4atwX2DFICqJTMg/RjX1Q1/m6qkzPompez17RiNyOkLx3IzQ4TFxuL7WWb9np
         5YnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793468759; x=1794073559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aJekqtZd8q/3ArsU+9b6lj5+AIzwCIpS5G7gHNxiD/k=;
        b=lWoXZOeNw2FLgxwEGREVpOIAT9KTIX9wCduHUjRRUYJQeBYtiDnS6szrvwp+rf7szZ
         mOe++qGdOk3zAqaducFX4u2BjwP0We+cuPPck/7kbXcqldhao0c5oVCSRBDDh01h5qN4
         k5g5e4h7QADaoUZkdrHdSO1fBxbPdmw9vbK28TnBBL2DDi6Jx+GOuCdurTjWDi6OBu7V
         Gq1D/ieaYMNoCaAoKHi9zeivDwr06M2RpAlD5APbV12enqxFAne7CyrKKBL+gFnsL6Sj
         Ve3fLa8Rh1uapwjk371DqaUu6SzvFdYU0iN6x0LNsjzZoVFsNbSKGLPAj+tYlAdvzLLI
         HFLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJHHUDvSq086GQDBHPhgYz+ezeGsCgX9maMYRVJEkyjHKeHZ+m0pRPyP2k56K31q1iNZNgpnI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLn8z3bcgHtahFor4QEqr1WFHPkGnjbquwfOt93VjcoDT+0z1j4
	Jtzqsid5knsSEPeqJGB9l/+0zOr75x/ARLqQzJn+NR16Ntg7qlM0tFNtK1RTScozV9pQtZqKszZ
	NJ7T0V2IOC6CXBCp3WlmwySFCvTiqXT7dZ3702SuMGn7TN5GTySHRcg==
X-Gm-Gg: AYBFou0weLQIMU05AWGkHDxj7dkCdrKClHVnMK1cfKqC4D+1YFnZpZw9h/9KFRgjRal
	n/SuZE9n60XgyQKDOyDsgqKrPRgdZpfaeh2l0alWXQVUdFrwMkJgEldPpERntZkmD99LKKAerlO
	FL9F2v/levoozGpryr95eRM5JtR0rWfRPAL4NJ2wLkB9rnJIF0JANcSGuvnWSUIot8ZNCycRddk
	gcupOE5nQgTA5DRFjBjqqIDj0YFL9SxBkxgXsl9aHCzYZXLfnJGrqk2J4Dvdi3PXkxQyyE5o9Xi
	EFz+vMaWIiYB76QZpr4bXxWXc3HL75B8w5FI2LDqlsocbZVF0LO29HfHFjVK7mZAhJTJzjs2NO1
	744aMGyCWyXcacQAN5h/5GdjnIrBnsoAKqCfgP8VtI9vjG3NQKw3kJH/VnA==
X-Received: by 2002:a05:6102:148c:b0:7c3:9464:efaa with SMTP id ada2fe7eead31-7d07223f482mr2959691137.2.1793468759696;
        Sat, 31 Oct 2026 10:45:59 -0700 (PDT)
X-Received: by 2002:a05:6102:148c:b0:7c3:9464:efaa with SMTP id ada2fe7eead31-7d07223f482mr2959682137.2.1793468759156;
        Sat, 31 Oct 2026 10:45:59 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.159.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b79059sm10220667f8f.30.2026.10.31.10.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 10:45:57 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 31 Oct 2026 13:45:35 -0400
Subject: [PATCH 2/2] vhost-vdpa: unpin mappings by range
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-vhost-vdpa-unpin-v1-2-94ffc9683256@columbia.edu>
References: <20261031-vhost-vdpa-unpin-v1-0-94ffc9683256@columbia.edu>
In-Reply-To: <20261031-vhost-vdpa-unpin-v1-0-94ffc9683256@columbia.edu>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793468749; l=2247;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Gl1rZ25wXNyNmee5e2PpkIojdGVNpwtOFO12QJgbtq0=;
 b=Yc35BLvALhKx8rPBAzm50hZFs+VIj2767yCsM7DHjbdqhj8KQJZguVerhRuWtRGIifzqbDrPY
 e4bjGwmJAZ8CIDTEbQW+/UaLJKu9KMENbgB2/aAZ6r4/z+CrdnaxFg2
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfX9Um2z46P15yK
 GJrReeCxgN+rsif3nChb8EkTEXunOm7TqaAJx/qDYYiqXDuBdEZ9SD0/ycm+DlLl6cxu1G4FRSb
 9/mgG3EmPsk7NonvlC6fnxmmNqp9d/BUPjUb6AhBRr68vWaxqLMiRcx2Hxlu0KqhglsHAsfFnpe
 L8ad4TzYbNRb9l1bEjYcMTSbTRkOV4lFe5RsnsXtKH8oay1S0ilz1iW6IlARtwHo4zPtGDmubVa
 ZVU0ekQoM7RHxcpfuCGbHohHBvki1JLvXF5FV++0jKLaBNPv4VIgUsUjmb6W6AtBdi5pBIYIbhe
 ZDf5Rpbls7KVlt0+jDCiFYNmDcYT2pVnHb4JCiaFdCmOMmfsLN88cBfhNv4TywRTFormhr0YSTT
 WmfRCRx0DiDzU4JFu7iw8HwVg1Z8my5ddCZNkrZdd/fFQiQLqUBZroeZ2aRjW6VVj/M3omb0ors
 XWxcsbeRDI7ezU3D4tA==
X-Proofpoint-GUID: hUBrA_w1nSmGwl8ZFtLS1Sx3dbvD7_xi
X-Authority-Analysis: v=2.4 cv=TM/Q2Fla c=1 sm=1 tr=0 ts=6ae62958 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=P+xgYyhW+KadpqoI50EQPQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=RvicXfEJGDZI3HCdRHsA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfX58mvM1FxirRc
 eVHkpwMquef7UYzwtgxrSl7BbWumSqO9scLURuVmRTPeihAlhK8tBSRJcFHmz+b1XRdZTgc/bC6
 WSlqchAX6+DgfuP2mJxNDWe4o4bBq5n1zQhmpsscR0UvH9PY1L5b
X-Proofpoint-ORIG-GUID: hUBrA_w1nSmGwl8ZFtLS1Sx3dbvD7_xi
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11952
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 lowpriorityscore=10 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=10 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310070

vhost_vdpa_pa_unmap() unpins each mapping a page at a time, dirtying
each page first if the mapping is writable. Each mapping is physically
contiguous, so use unpin_user_page_range_dirty_lock() instead, which
marks every folio dirty once and drops its pins in one go. Do the same
for the pages left pinned in the vhost_vdpa_pa_map() error path.

This removes the last use of set_page_dirty_lock() in vhost.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 drivers/vhost/vdpa.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index d9af728942b3..cd5da522fdc0 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -972,18 +972,11 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 {
 	struct vhost_dev *dev = &v->vdev;
 	struct vhost_iotlb_map *map;
-	struct page *page;
-	unsigned long pfn, pinned;
 
 	while ((map = vhost_iotlb_itree_first(iotlb, start, last)) != NULL) {
-		pinned = PFN_DOWN(map->size);
-		for (pfn = PFN_DOWN(map->addr);
-		     pinned > 0; pfn++, pinned--) {
-			page = pfn_to_page(pfn);
-			if (map->perm & VHOST_ACCESS_WO)
-				set_page_dirty_lock(page);
-			unpin_user_page(page);
-		}
+		unpin_user_page_range_dirty_lock(pfn_to_page(PFN_DOWN(map->addr)),
+						 PFN_DOWN(map->size),
+						 map->perm & VHOST_ACCESS_WO);
 		atomic64_sub(PFN_DOWN(map->size), &dev->mm->pinned_vm);
 		vhost_vdpa_general_unmap(v, map, asid);
 		vhost_iotlb_map_free(iotlb, map);
@@ -1246,8 +1239,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 out:
 	if (ret) {
 		if (last_pfn) {
-			unsigned long pfn;
-
 			/*
 			 * Unpin the outstanding pages which are yet to be
 			 * mapped but haven't due to vdpa_map() or
@@ -1257,8 +1248,9 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			 * the corresponding unpinning will be handled by
 			 * vdpa_unmap().
 			 */
-			for (pfn = map_pfn; pfn <= last_pfn; pfn++)
-				unpin_user_page(pfn_to_page(pfn));
+			unpin_user_page_range_dirty_lock(pfn_to_page(map_pfn),
+							 last_pfn - map_pfn + 1,
+							 false);
 		}
 		vhost_vdpa_unmap(v, iotlb, start, size);
 	}

-- 
2.39.5

