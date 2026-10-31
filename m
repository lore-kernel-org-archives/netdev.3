Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468765;
	b=5aHLgxVhv9Z0sEiyVqFcFrM7XP+tspwsYwxoL+NsyKCMUakJV2NvRm9pFhxNaYeSUMau
	 jd9gIzgdF64sbJV646P2tuKlf6X7pCpicSdQtRZ0yMP+uMVvcc9TqGYabCBB2DeiPHPqy
	 F9XLZWxnGyvZXTZVEJIh8NbDG1Kg8C+SEwg7UxXV6wE3yLPDTQ01cUwMyW6JXOBJQnAvl
	 zC+20m2FmlMe1pvoVAkOf9pL3kTcA+KERSLuwIK2PA5IyFYsTpy3l9eQz8f7+tmXbXPvV
	 fIQDR7WoR84x8b3/gAe8LEGYzN9drRbmPyIu+vfx08EfV43oUaIkSrRxwxA+EGveq/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468765;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=uJK31gSrSbi0TRnAn4Tp1KO1O5wMsYESY22JYVALKec=;
	b=jgugoWNcqel5fIvuJqZ0o/5D8Wnj9s9ZNo/9OB9csu2olXMZODl5pGEOCmK6+foyIDOv
	 73pAsMRkJJDPZahokdGsHGOmST0FIqSCQPmJIHUZdG8J6TjLotor1BaaiyjAiwqwNFgjR
	 uwVaDsUQGcKQj7SrKh8n29DuA8qf8Oh01M3hHnqyiLZsC9xU2TkWoOj98xW1x5ZexnNM0
	 dGVrEEuhxbDJJeAGw5ejTjE8yZVajKAFMgXNEIjTraELFPRh3F2hoV3PJaX187JsKo8Oa
	 AlAxq5zmq6UmWRQT/RZ8A1V5JeDw+fbI0cGv9H2QQdw1Aaa0tDZH0jPVzWhqro4avJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=AILMGxYi;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=P1c3b6ir;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97839606A336
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 17:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97839606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=AILMGxYi;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=P1c3b6ir
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VDo7A0633919
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 13:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=uJK3
	1gSrSbi0TRnAn4Tp1KO1O5wMsYESY22JYVALKec=; b=AILMGxYihFp4aa47RKE3
	ZkwqpaFA/qji9U4eUXttEpbkTO8SzOmW54oWCpknvVgzl3mlXPDw7zISGHqOQ5xm
	mUHbR90Kuj8TtuommrbOsRAj9DroiV9GS9MqnHAmF0hvy+n8Imz+EI0PPrrwJuBD
	yLxHW3VlUTIHnuCKnMf8tEub5zv7WtQp+JHjzoN40noj4J8gTkjguypnodlpcu/8
	NgMQDZnao+Vaeb8PuQ9M1WCCPQMUkREXnnKxJlcYGxMJK3INHKXWh0SSY6wJUkVs
	EvXP7WtDhAqEltlCeRJAkzQ4vOoU0PltSMQEjRBYrLSOk2LrhVu1cl6Kwbr+b/Sx
	ag==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hnd9jacwv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 13:45:57 -0400 (EDT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7cc36b97a77so518533137.0
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793468756; x=1794073556; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJK31gSrSbi0TRnAn4Tp1KO1O5wMsYESY22JYVALKec=;
        b=P1c3b6irGHvImyGvnQ0nMweIGYyTVneRgqNnM/lNCHCmlf7FDnymcHsh52eot3bypk
         v7Mj/JDqhwbA2lNtDilMd9Kde/ZUelcsn8pQRQO/nXlx1r0VurnRiTL3QTz6KwDx+6gs
         hTCoC9TWVukHL7ytSKOkLUoBVNbWVtKwa8bwfnO05IalBZpgSSEXAarpw0+PVPY0p782
         W2adDKXTpg0GpxTovxE1Xq1hLY5dcCfgbcftIDyMC8TBZLpWwxN5Dp4fJ07DSt6/gz2J
         FDvyjQXClF8DxpCSTFUJB2sOM79wTwbgGCQNa5x3V3v2VESoBbdnbPMSBHGgbWKtOjsk
         EHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793468756; x=1794073556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJK31gSrSbi0TRnAn4Tp1KO1O5wMsYESY22JYVALKec=;
        b=Y73QSXkdARYOTxibA60if1fFrQUogKbfeZY1UPrkZtk9gfQ7qonMQUaFcwr18MDuMi
         F8+Qw8lGFBnUUORe3/yKvCemWZIFOr4c1ToSpJB3DhtG1KXne7d3hDRe+ua3H1UGAAS/
         EM/e4ARLFpJwoLgI3q3lRfoClPaKBGeltG2W+G9RWw3I5z6ViAa87/wtkIJm64ZbyeJC
         p3MxEtRjBFUIk0EoUTEHGam1jPm46ncls1WfXd0mIamhREvobOO2QuwBNngOeuTlHpYB
         72mhNiDUjcBhIHAVTqDHWx1YjnalB85HdDtQ9yfeWN+XgtbflWyRxvVYu0h3wLAq5uRj
         0mxg==
X-Forwarded-Encrypted: i=1; AKwUvBwZw3zatfWjLfeEAvJ3t9FJ+kjsccDIMGBWtcivvObRdZGRahQTcE/wLlANBcRWxnJ4GOKrbE4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2WQH22O2sSAwDh689z30tgw9tQOSrDhd2MkBZI3fslgAh48qh
	/uqkmPYENvv5RfSV+1XW5Jx9mX+6icqDEb4ofOEUNojsH9COzyEmMSq2ddGRr2Xc2U/apVb35nq
	L1ndd4/6cMwTV9qS/Kz24WtTG1sRsi7PI0igW+O60y2/0Zh50bukZXg==
X-Gm-Gg: AYBFou0u66mq4sMfxrLq1ovqAqizyXzjwUtwtCcpF0vSvDfwqd8TJE+q+Y9K+PL/PQU
	pTK7e2UF0T7N+Xg6qHMqorZ5MNJ61miJ1v9m0hMujQk3nPSZX+fk/Pmwt3wBuMaXtpyZSTd44bB
	MJ4iIZmVZOvCOePSQgQy5qwejdvayL7ra/TgD2/4tWCyTQWBydcClGPX4s42mnVQFxL6+YBLnAU
	pWxka6ndle5A4U9NAd22hNC9I0i5g9LU1iJLQdXjxzbsuCEvpOCQMWxsyc3OkuEXrzZHXH3/uE/
	XLlPAh02nIRRe30SJ2gpdvwrBQZe7LX6naFZ2Ciqxn0c08GHIVxxTbTJwbFVGo20H+niQAFI3Yf
	5PHThL+TDSjPnsVx3UvhQ+UtLqnhrpLubTPPpmMJ1cnpyUFKM0TqRWi1aQg==
X-Received: by 2002:a67:e103:0:b0:7cc:226a:f963 with SMTP id ada2fe7eead31-7d072cc29e5mr2098026137.28.1793468756668;
        Sat, 31 Oct 2026 10:45:56 -0700 (PDT)
X-Received: by 2002:a67:e103:0:b0:7cc:226a:f963 with SMTP id ada2fe7eead31-7d072cc29e5mr2098018137.28.1793468756238;
        Sat, 31 Oct 2026 10:45:56 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.159.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b79059sm10220667f8f.30.2026.10.31.10.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 10:45:54 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 31 Oct 2026 13:45:34 -0400
Subject: [PATCH 1/2] vhost-vdpa: fix pinned page leak in
 vhost_vdpa_pa_map() error path
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
Message-Id: <20261031-vhost-vdpa-unpin-v1-1-94ffc9683256@columbia.edu>
References: <20261031-vhost-vdpa-unpin-v1-0-94ffc9683256@columbia.edu>
In-Reply-To: <20261031-vhost-vdpa-unpin-v1-0-94ffc9683256@columbia.edu>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793468749; l=2574;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=2cfbyA5E1BgeuOs5GH6EveuwRPzjMvx0EL0D8iIR4TI=;
 b=ASB3o36C4fU3EYWb71QWR0b3OloFHUbllnjysWZc/O/WJMEbMyalbSxUjvtUsiJCSd5hwtbVN
 UV1UmC6jYICARYL7Qn5AYWXOvVzIfj1mcr+UxfTHO1a4QhwHfdFBPLf
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfX/aV92jAKblsl
 B0Ncxt+kRcY3FjUi+fwkysRDXGKZGbyyfzsKv8V6gEoCltzKLJp2dPYYo+8A2IaIJGMfTqZCYud
 Gs7G0mS6Pl5yBRtg0bPuy+rRIVKvfQDT6m9IgLENztSgP0ersUvqBaQlNs7L7umyoAProBCvlJ1
 hiXJ+IvN3+7bwXhHkIpO5rN0PmyJMeVQ+n7dPOuM/K0CqIjol6Z3+QzNFmK9Q0asnPYQbzmExnr
 2RhT9wSNriCSchAE0saIsexJpU1y7kLuqCRy2aXE3y+mIrdlxZVpJxK26n098PC3hEHj48GshGg
 mUfrwKgnGr885/rfPUzXQotGGvWECM8Ktzg0EHIgzkYk/vELeco2s6K/QYbru35HQ0iWQUK17Eo
 GgPOSBl0YyYErrVe1RRN0QrtR391LZDKjWy1+nd7K+iDlbJNR6JY3sCugYr7N/A9ly2w0r84NSk
 buJkLuxlCnsPhizA+sg==
X-Proofpoint-GUID: SNqLQCiyn9omuX5gLgsgOD6yN1uZUgfi
X-Authority-Analysis: v=2.4 cv=TM/Q2Fla c=1 sm=1 tr=0 ts=6ae62955 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=P+xgYyhW+KadpqoI50EQPQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=VwQbUJbxAAAA:8 a=Vli3z_CPQh-YiPf8mvEA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfXySr9r5HqyDM+
 iTlMYKvz41fQQoJpfe8efNuDcHAkclA8Rj76MhkJMCDK04w0wKhg25zAwysM5NN0R4ydj47dKLw
 Lkx0ctXypWc880fMAY8DjbNLDntTmJxTuN0CSQzjlNErO42Tuq4F
X-Proofpoint-ORIG-GUID: SNqLQCiyn9omuX5gLgsgOD6yN1uZUgfi
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11952
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 lowpriorityscore=10 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=10 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310070

When pin_user_pages() or vhost_vdpa_map() fails, vhost_vdpa_pa_map()
is supposed to unpin the pages pinned after the last successfully
mapped chunk, i.e. the range [map_pfn, last_pfn]. The unpin is guarded
by nchunks, but nchunks is reset to 0 every time a chunk is mapped from
inside the current page list, so a failure after any such boundary
leaves that pending range pinned forever. With physically scattered
memory nearly every page list contains a boundary, so the leak happens
on practically every failed IOTLB update.

The pending range is non-empty exactly when a page has been pinned,
which last_pfn already tells us, so drop nchunks and test last_pfn.

Fixes: ad89653f79f1 ("vhost-vdpa: fix page pinning leakage in error path (rework)")
Cc: stable@vger.kernel.org
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 drivers/vhost/vdpa.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ff7d90719171..d9af728942b3 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1151,7 +1151,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
 	unsigned int gup_flags = FOLL_LONGTERM;
 	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
-	unsigned long lock_limit, sz2pin, nchunks, i;
+	unsigned long lock_limit, sz2pin, i;
 	unsigned long page_offset;
 	u64 start = iova;
 	long pinned;
@@ -1187,7 +1187,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 
 	cur_base = uaddr & PAGE_MASK;
 	iova &= PAGE_MASK;
-	nchunks = 0;
 
 	while (npages) {
 		sz2pin = min_t(unsigned long, npages, list_size);
@@ -1202,7 +1201,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			}
 			goto out;
 		}
-		nchunks++;
 
 		if (!last_pfn)
 			map_pfn = page_to_pfn(page_list[0]);
@@ -1233,7 +1231,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 
 				map_pfn = this_pfn;
 				iova += csize;
-				nchunks = 0;
 			}
 
 			last_pfn = this_pfn;
@@ -1248,7 +1245,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			     PFN_PHYS(map_pfn), perm, NULL);
 out:
 	if (ret) {
-		if (nchunks) {
+		if (last_pfn) {
 			unsigned long pfn;
 
 			/*
@@ -1260,7 +1257,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			 * the corresponding unpinning will be handled by
 			 * vdpa_unmap().
 			 */
-			WARN_ON(!last_pfn);
 			for (pfn = map_pfn; pfn <= last_pfn; pfn++)
 				unpin_user_page(pfn_to_page(pfn));
 		}

-- 
2.39.5

