Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.156.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221455;
	b=YPEFmZ0fC484i9zjw8fkgpROs9hVAB9Btu2nkH9dqepbwbIj56hSjIygtxAObZbF5SyK
	 VXzKH0251WrATVlUH4nJ32bNyG69+zzBaqkJOqXNrW62KLyf+dI6baQJzywbxKPZd2kro
	 9s5p0oYUzIql8SQUfBE74P/J/D6cZi9S75bhzZ56QRONRfSAHa8royb6jmmz/IbFLLl94
	 ZFIt7meO68040a+bMg8mbGXqRTaJ4u09fXCZr2F/abRBMgPQ77aHHjUOmfZhrtlRKHGGZ
	 VQAUfbamPkkWxJoI3NamcihzQLGvdTEqljaYqRqYsNUPp06wCbtnbUSDPAyIcMj+95A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221455;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version;
	bh=dFZKLixWx5KI4GfPbaia5dkgB2QXV/9Y/o90oVOKECw=;
	b=LMdMZEJcmKLArvZVkuggCa8IeFwaZON1dkc08wz5Tju7eb6G9cyaQY95rEeem81c/n0x
	 ugS27c8PEkA2M20BsFYhKbWdOb2E1r8MBqFP5T25uNgiqMK3WzOInkVaVymXvGz8QoNIs
	 rYcT4PaJ0HA17gSO/5SqWEGbuOR/vqVX/IJt8BatYZzgN60DtGK2CTRguqI46Gw2hRfst
	 dYpAn6C6/5RLBJSN+kKyzOA82Cn0ZrL71JnQkAAKn9Bu4WCYZLFT2jOi9DwpI4uoL1Zes
	 bmsdQNnrncuAvjxh8hoI+RQM4XYIrfOudD0jl8/1gPtLjO4r+yu4o5OZ3hM/YdBIVVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=fqEhttIJ;
	arc=none smtp.remote-ip=67.231.156.173
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A0E606A31C;
	Mon,  9 Nov 2026 10:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14A0E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=fqEhttIJ
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A99x5mo4137589;
	Mon, 9 Nov 2026 02:50:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=dFZKLixWx5KI4GfPbaia5dk
	gB2QXV/9Y/o90oVOKECw=; b=fqEhttIJ24eUSiCxSxkPMIjfVnjJyS4k56Cyyrr
	IajLfz9j17600FkAwp5dgd2pOwRX1z4pZ+FHdNsVVF9PW9qiay9QEs+cCIPiXSeM
	WNT5Dsisxkkn0f7jDEtdBKY8VrKESc1dBeod/X6GzmgCbRoNE7QyiZDw3LIyrEyo
	uhCM0knQnxK+VxM17JeTt5U7Zl5fJDh34KMumo7WL86aShm5YzyzWmtg5FNlYCCT
	5eRZgSqvEPJ+AZqDJzdHhbh/Q6uZ9Iob21VFR+qUTHw0GFY3A3pOM9ltq8hgXEnl
	yQJXy2wbs1x46eNVjlracfgcCUhd7I2CN0RGO7rFqm3DC9Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ht4cnnppy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 02:50:48 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Nov 2026 02:50:47 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 9 Nov 2026 02:50:47 -0800
Received: from sjc4ccscust-vm07.sclab.marvell.com (unknown [10.110.24.160])
	by maili.marvell.com (Postfix) with ESMTP id D31923F708A;
	Mon,  9 Nov 2026 02:50:46 -0800 (PST)
From: kmahammadraf <kmahammadraf@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Aditya
 Thapliyal <athapliyal@marvell.com>,
        kmahammadraf <kmahammadraf@marvell.com>
Subject: [PATCH net] octeontx2-af: Fix keep PF_FUNC match for AF TX rules in rep mode
Date: Mon, 9 Nov 2026 10:50:43 +0000
Message-ID: <20261109105043.1986921-1-kmahammadraf@marvell.com>
X-Mailer: git-send-email 2.25.1
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
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=HpDjiETS c=1 sm=1 tr=0 ts=6af1a588 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=L6Q1NjILTR45zA5W52MA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0MiBTYWx0ZWRfX9OO3/dCtkUr5
 jekI0j6sy76RLG9/0jd+Ir3kw98vAR63ZPIoLLTQD4kBOBJWyfhhj6JCZhY6vTXnOkqA5zlVguR
 pjTJ23t/9BZtRu/1ZBrCRzAc1WNc2q8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0MiBTYWx0ZWRfXz/LaBKRilRZ4
 0MyoFX7E9+uK4tWvslPG5Wg2Ehb6ZEXNETnVp8LRWh1wBm/qxqlPccCbgV5hguUJrxumtDyT1HV
 XVCuIPp3uKuk0vQsSWXGllIqSEdrudixgxed6O6ui0gKmerOF/9LwO0LWiz+JKKZC4S3TiYIP2w
 cXth0fh4mslsTy0ABrvKx6cDQ/U8Ydq4nw2yXrfOQESbPjI7RfsPP6FlCIXrgk51Ci8+I+iZy6m
 aRWI7Q6oR0JzRNT8k+Xf8S680Sa6JsrlHCZJg6U5jZWahmHBdFdByFpUN808Ey7w9sLxK8qK91v
 jexC4eDlAq3g/w2prsnWmjqS8yEV0ic24O8hzLNMZUqOxd3H1L9fAf3tn1KPdP0H/4rVzlaC9s3
 oQ7HYGb1cg5EFIb4ri0iX/5gk52DGqpoeThQ35hmoJTEB21c9UBqLWehrKUG7ynRhwyfmu72wr9
 o0XD8yrl44BFHHArF9Q==
X-Proofpoint-GUID: -SM8jb4bUgZ4qaoZfGxYqPVwLMqik_YG
X-Proofpoint-ORIG-GUID: -SM8jb4bUgZ4qaoZfGxYqPVwLMqik_YG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01

From: Aditya Thapliyal <athapliyal@marvell.com>

In representor mode, AF installs TX MCAM rules for representor traffic.
These TX rules must match on PF_FUNC to identify the correct target
function.

Currently, npc_update_tx_entry() clears PF_FUNC mask for AF-requested
rules. In rep_mode, that wildcard can make a TX rule match traffic for
other representors on the same TX interface, which can steer egress
traffic through the wrong rule.

Fix this by not clearing PF_FUNC mask for AF-installed TX rules when
rep_mode is enabled.

Fixes: 683645a2317e ("octeontx2-af: Add packet path between representor and VF")

Signed-off-by: kmahammadraf <kmahammadraf@marvell.com>
Signed-off-by: Aditya Thapliyal <athapliyal@marvell.com>

---
v2: https://lore.kernel.org/netdev/179292714974.3134.12015701378835588497@kernel.org/

    -Drop the channel-handling change from this patch.
    -Keep this patch focused on PF_FUNC mask handling in representor mode.
    -Clarify the representor TX symptom in the commit message.
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index ec004ea5154c..4afd4a10cd64 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1396,7 +1396,7 @@ static int npc_update_tx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 	/* If AF is installing then do not care about
 	 * PF_FUNC in Send Descriptor
 	 */
-	if (is_pffunc_af(req->hdr.pcifunc))
+	if (is_pffunc_af(req->hdr.pcifunc) && !rvu->rep_mode)
 		mask = 0;
 
 	npc_update_entry(rvu, NPC_PF_FUNC, mdata, (__force u16)htons(target),
-- 
2.25.1

