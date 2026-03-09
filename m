Received: from outbound.qs.icloud.com (qs-2006k-snip4-2.eps.apple.com [57.103.85.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D962FFDF7
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.85.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773088520; cv=none; b=GkHS8vI8Z8VY0x1fl+kB0O/WD6W8LE1/dMZrlvt6VhSLNAUZkANxxj7BrW6Au0a673+o2V9oG81oUYwCBPvd/W81gvgBSOmGyXzjrLw7ZYmLGiMApaoXTYu+ocJlzDt+3sKAWdKQCF2aJhk6PZPax+uO61/UjWBUnWk2HdxoT2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773088520; c=relaxed/simple;
	bh=twUbMcIJiHRP+nwCmMLKF3/g64e+n13bmLVgefMH268=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wc42XSGTXcQRvlyJG75zGuhiQgVCfytNIRhFtollKtY5CSnCbdStbsCT1cMax3NAWBdCnHCXydFgaIhK0OBAA6spTF4FHtQNNYY4iDH9ARNDuj6nkhsDt/CjZCfv5+CwdWiibbVpLwAFs7H1t/cYM/G41B9rp29lG8dWxp3m7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=HhB4TGVF; arc=none smtp.client-ip=57.103.85.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="HhB4TGVF"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPS id 2F3281800325;
	Mon,  9 Mar 2026 20:35:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1773088519; x=1775680519; bh=2W5LqWOkaCS2NKmk5X5VGweX3qq0HJK1mxZ/CqPuuYM=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=HhB4TGVFC8CSBbzIp9Db9Y+hOTAKsvsgly1tPBEtQGKVZWr9FjYq0/ifcPjSeGiCF7H48JtuJvLXwKaKho83lddOaMzgg99g3HIhWnEiXVl24bnpX3QRBvoebb0ZMiyASBR4mnK2c717jTDtq6e/gQUwqEvDgK1pMJJ5ULB5+7GPYPEeK9JTYsFyOxLKd6bV64j5c6PHPYgwBBfUxhKNKaE6yX2tCtJ+fOB6LVSRwmqJs8fZZDgwk9BO9QICETnIpS5vL8/n18H9VgUrJrvoYqnqcVvpMntImsyU+8L5iVePTjVkP4Wf5cceUvKIDmHZoGHEUV1pXFaTaAA4siK5iw==
Received: from bimmer.. (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPSA id CB4641800381;
	Mon,  9 Mar 2026 20:35:14 +0000 (UTC)
From: tobgaertner <tob.gaertner@me.com>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org,
	oneukum@suse.com,
	bjorn@mork.no,
	tobgaertner <tob.gaertner@me.com>
Subject: [PATCH v2 1/2] net: usb: cdc_ncm: add ndpoffset to NDP16 nframes bounds check
Date: Mon,  9 Mar 2026 13:34:48 -0700
Message-ID: <20260309203449.2594858-2-tob.gaertner@me.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309203449.2594858-1-tob.gaertner@me.com>
References: <20260309203449.2594858-1-tob.gaertner@me.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=GsNPO01C c=1 sm=1 tr=0 ts=69af2f04
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=x7bEGLp0ZPQA:10
 a=C3-SEi6G3EkA:10 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8
 a=HzMi5OPLhTFtyP-mVG4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE4MiBTYWx0ZWRfX68uPHqAY9PqX
 lKswUqJNDjqGZfn6faHs5L1jeIPIy1HzmoSMI2E7gHw/YoUcKLnnOoc5eTsdUn+gYjKuyCFBTkv
 gTIcYEWUAaPraHh5CFbCrnjOZhlryxrjlBi6qDRhT8G5cEJBCq32q7sORuNau5BasGypFajlySi
 9A4lbemyinYjQ2GamH5wqRo8Bm3YbacdB/2RByWmySwUhGgKCXJ7j+ioodwqdY2JsnBHsw+gRb9
 q9KNTcsvdYsX7qy2BBaiEVvWGZctIbkpEkj5B044JPjZDFPA3X/rom4W8kkkVC0EonGmi30SVMw
 JbnbjYo3iqMbQxc1k40359HJXrJBonukPbpkYQIenq5G/wu6U6OXBhhjK06QuU=
X-Proofpoint-ORIG-GUID: 6BuglngLb1iWG4znQtzeFhqNMFOi0L7_
X-Proofpoint-GUID: 6BuglngLb1iWG4znQtzeFhqNMFOi0L7_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=771 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603090182
X-JNJ: AAAAAAABXRoo07/0zhgqe/auQLDZ9+l0Wabg2x3fo3Qz6g7yzusxfs+B04TCrQfgEqy9RUkabC0wRJF20KGsj0HKWqrg1hWRGtge5ngf9o5sp02GXJ5H4NsQysYY7lGtQuNeeX3wjvcQngJruNzGIFnuWK4RiQBVuM6ziRTR2c7TLN2ZLP2ChopzUICx2cLMQbWwFrfAAw/PKOOoN664KDYiBhAMekNHvthaYp7ulKSz7G378ug1RXs5oylZir/8DH41HPjBi1KAyYHpkNSryWiyB24gj7Ys4GGSStultepCPBrW7asrMQ4fQ6bevkNV0ZKnIbg0yAbACUAwY4btUQg2n0DhYExVjZoFhA1ckh/ff+aR28xIDbOMQ8Ohefpm76cvqZ/DQ1ZPhaGhFw0UQFKppS7+ZEfs3lTeyAMejPC/Zxg6KVcLWWtEXWcUB6WV19sNza4XYrxjsTAAtUlEL09FeIIc7JkyIrwhWv162QtjI89/cHhu7+q53narPhk5TMZYXcnruXTnFYv5zP92nG1vd9zj0T2uHgiNHPavxwD8a4gll1ygu1bEJBmVhe6Bu5cXaBeqjtsXAA50FvFfM8CG4JpZ7tqmj5+ECunLuQEJeBM0L06+Rcko6WIo4mTfsm3g61x5lWl5KNy6rQa9vDwoUbiHJw/0OAjwZeVzaGHiz42KcJu47YlQcVKW4TwFOmDczRXOpABgF1E1Eft1AMCd
X-Apple-Category-Label: Mjg5MDYwMTc4OiRjYXRlZ29yeSRfUGVyc29uYWws

cdc_ncm_rx_verify_ndp16() validates that the NDP header and its DPE
entries fit within the skb. The first check correctly accounts for
ndpoffset:

  if ((ndpoffset + sizeof(struct usb_cdc_ncm_ndp16)) > skb_in->len)

but the second check omits it:

  if ((sizeof(struct usb_cdc_ncm_ndp16) +
       ret * (sizeof(struct usb_cdc_ncm_dpe16))) > skb_in->len)

This validates the DPE array size against the total skb length as if
the NDP were at offset 0, rather than at ndpoffset. When the NDP is
placed near the end of the NTB (large wNdpIndex), the DPE entries can
extend past the skb data buffer even though the check passes.
cdc_ncm_rx_fixup() then reads out-of-bounds memory when iterating
the DPE array.

Add ndpoffset to the nframes bounds check and use struct_size_t() to
express the NDP-plus-DPE-array size more clearly.

Found by coverage-guided fuzzing with QEMU system-mode emulation.

Fixes: ff06ab13a4cc ("net: cdc_ncm: splitting rx_fixup for code reuse")
Signed-off-by: Tobi Gaertner <tob.gaertner@me.com>
---
 drivers/net/usb/cdc_ncm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 5d123df0a..846f8b997 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1675,8 +1675,8 @@ int cdc_ncm_rx_verify_ndp16(struct sk_buff *skb_in, int ndpoffset)
 					sizeof(struct usb_cdc_ncm_dpe16));
 	ret--; /* we process NDP entries except for the last one */
 
-	if ((sizeof(struct usb_cdc_ncm_ndp16) +
-	     ret * (sizeof(struct usb_cdc_ncm_dpe16))) > skb_in->len) {
+	if (ndpoffset + struct_size_t(struct usb_cdc_ncm_ndp16,
+				     dpe16, ret) > skb_in->len) {
 		netif_dbg(dev, rx_err, dev->net, "Invalid nframes = %d\n", ret);
 		ret = -EINVAL;
 	}
-- 
2.43.0

