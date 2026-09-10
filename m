Received: from outbound.ms.icloud.com (ms-2004c-snip4-7.eps.apple.com [57.103.74.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886DF3B47FF
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027382; cv=none; b=J3vbYgo1rlVP0BaeL4oSkaZqHnKJGoPmKhQNWkHXKWHy4Le1POZ91py4ImscnVfDG5akCm5wEfqOQiC6KjjUkPc2qntacRPN9f3lFen6HUNZUtQu2YDeGwBNofZYBhUDguwAnFgLRiE/LuWEo85Ck6IyAxjBRND4zsT6P7+0DW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027382; c=relaxed/simple;
	bh=pcsAVKJB5Sevu4uOS/IY9uv6I/DtkwWPlk6eAiZEBl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KDOCtXIVtt0j/YiyLEvK8smSSy5VfMsA/MYe057TFXwe1xNLMeVqADx9yyXPqWQc4DF34rIAKTBut5+bpf2WBmoeRsrj1B9NbTcX18MLBCHoFh5hvFw2CVHr+pTgHQNxWCVJ2g1uLoVTwaRx3qZX1UEu2oeFclxM4dM+9N8AaZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rezlabs.io; spf=pass smtp.mailfrom=rezlabs.io; dkim=pass (2048-bit key) header.d=rezlabs.io header.i=@rezlabs.io header.b=NbfI1Y0U; arc=none smtp.client-ip=57.103.74.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rezlabs.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rezlabs.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rezlabs.io header.i=@rezlabs.io header.b="NbfI1Y0U"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-4 (Postfix) with ESMTPS id 2E980180019D;
	Thu, 10 Sep 2026 08:02:57 +0000 (UTC)
X-ICL-RepId: 01a08a57-639e-7975-8684-33a9ad12cace
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhJC0MBUhxHD1YBXQ9LVxQEGVcAXgVyAlwCXwxVGBwZVlhVCQoZVwpVGVEeGQJdUEsbDlkXA1ccVkVcGEMJXQVXHB0AREVbE1UXRgkZCF0dGQhHHwowA0IOVgNDB0UALRkcV1BFDkgcWBpAQ14EEh1QHA5RBVsARglBAl0HUwJCDEsdVQVfAUIUSR4MUwZbHnkKVhdbClADFxFcUxcfSwBcRVAYRB9dHWYcXABWAlw=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rezlabs.io; s=sig1; t=1789027379; x=1791619379; bh=sdumdNdZ1i1mgSmucXIDPHPHezApNvhv8u+vxRQ0xqs=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=NbfI1Y0UWzU5/URs2R215Zitgv+E71JM559HOFvYq/XOwev/NbI+2cjGdALSed4Js6Ocafr8oU0nBvyT86NJZqnFNM5X5mAt13peqIa4tG9tmfhmu2xoSExr2/uazvbh1JwGYd9EeQsp+hpYqYqPzns7xF3AOEdxUhclOKeCduB/yQTE3+oA13hvbs5wbfT3i1M9RfOVuxx8dRgVt13DxuXAo8fBfo84hBKI8srRnhmXMqti7hxOTueEL15FpqQ3Dr9uLkR78EyUj4A0RcZP/bojIjDKMQzoTVHXRN/PQxJxlWgb3MWXx/DpTN5peRGadvW50C1fT7M7bxpeCZ8Xtw==
mail-alias-created-date: 1716408491361
Received: from localhost.localdomain (unknown [17.156.208.39])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-4 (Postfix) with ESMTPSA id 3E16418001B1;
	Thu, 10 Sep 2026 08:02:56 +0000 (UTC)
From: =?UTF-8?q?L=C3=A2m=20Tr=E1=BA=A7n?= <admin@rezlabs.io>
To: Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?L=C3=A2m=20Tr=E1=BA=A7n?= <admin@rezlabs.io>
Subject: [PATCH net] bnx2x: skip invalid DCBX priorities in bitmaps and FW config
Date: Thu, 10 Sep 2026 15:02:53 +0700
Message-ID: <20260910080253.82432-1-admin@rezlabs.io>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4OSBTYWx0ZWRfX0uVtCtL02hf2
 qPhtriklhgTBTNgnFJ7iSUM4rRPy1J/fRs/X0eZTgdZAYtCyocfxoI8rRgsk8eVutkToKEyWeZq
 0HSL1Bi4fMZyTmXICAQhGIq8BkuPh2hNb/9koZnfLwSewrOKx2Cs+Sl+Mj0X3pQ11LBf4AHzLdN
 /7kh18GOsRhgMXosL2qH3y38vK2bjrey2nLjL7Hk3QVz9gr3ckRkhCKE5qSz0QO7e8Xu6929Lm2
 izYaknJspWI1J/gYvcvX+Le0QbuxSBJoiN4Wbt8ywycM3irjrkx4NFJqHQ8XdRgR/Y3cpXKC4xP
 dmM0mnbcS6HoXmHvT7WaD2FJFgUNysPZED3ZNkwuLqy2rgTDU4u4DMpZ5XMeYU=
X-Proofpoint-ORIG-GUID: dnTlQdl86KPgvPckVu1o9MrgO0q-R0e7
X-Authority-Info-Out: v=2.4 cv=fqzRpV4f c=1 sm=1 tr=0 ts=6aa26432
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=M51BFTxLslgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=JVmeYToa536YDTb9RGEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dnTlQdl86KPgvPckVu1o9MrgO0q-R0e7
X-JNJ: AAAAAAAB+4T/f6MlbkWVQzH6kj9bPyVOkwlYEldJBbM2lBOeOFVAmfES3R0qznmwnOjRVx9Bbm6Pqc0HFPRfmgLYHYIg96vl4qJ0EJPNL5533rpOFJ0SLjdLBC/uc1ZJUlAXuBuPaEMZZg5mN1HvWnRhgW1LApOu1/lIpk/ltXs3yQxWZg0z3C8XXW32lqV5vzLH7kLNghJQ8XquGE46re1IiMYFPd3IT+iOQfTk+FfDDGnZfU0A3sDUSQF+5dGuhI2WsqguN8nQ6boURo8DTeSsV38MupsqTNSMAmWwaVe9F1Xbci6IZuLonEzxlKaaoCXaL0eck+Kq3bQqkUC7R16nFsIVwaivOSEE1IBJZvV6etnj+o/RUNjuqBXqwspawryWrfx6Bz/N3VMsWjMHgzy5FQtZorxCBfhIAF6NE9xiig0zSxTfwFBteZYkD1Wvh+v+dvEl27S2CJJUTDa6BN9FTjgjxufhonIfI/dS4Kth2bwZ+YQkyglrQIIDVGWGiTd4T3Nw9X24keqlF3SsmhDowOIET7vXQIa2SnHUwCnDlvgjj5R98ndUqZ/SzsaephNfFmeh4V7C73b+Brx69HxoPfJzDOd94hDeAicWouO7vnZiCtN1UVBxxjY55cxZbluetbKb0BaTiSJK1g1qiRxNRFO1D9I72RJu/2tBa+K2l3kP7hWNHR/9RvZ2xm/LNFxLfylpPHNZjYdjaKAGgqjm7Zaod8pxnbUaG1S5WefEEQVI3uhbbiU5WnFQbDmMP5rp0WHzI2SEcVGB2wm7LD7CmCqs4HP+z7fJpC79mUcFmOzKm9wJNgyHEjz2vK5rnsn007myiMRZR1H3OVWgIjztH05EU7GaTTXV99Y1h1HahXRMByEYaHLGIePyu+/ot22SYzYvafIopoWMyNH9zZbgTQBSyKEVJO5QL/RnkPbVYOhv4Ox2T0p/RDvE/+Mf3bdNbDE58Y7OSB40vRSr7WDV/xn5957
 dpbksEJypPlrn0rjZJJ/Xg3UD5NQCUQp5cFrFLEQf3piZDMdy/8vjy/NlDdXVIokubNUCFzJmOvIaowfL3hB5NzUy2oY/696E+28S7IPIiLK+DzKCwgGd92rxDacretpkk432brMD+MUrNx4tEBYeDa0CcBkLqNjAVSwIpI87SzgGuOUrJ1KvnpxYcZOgB9H+X5sECygMl3vBEWcbx2aYRZVvrcgoCXlLTekwUGPp5ctwqmn+sNsBLeJBshbdfnP/H3aIvJJQPCamwU90SlxiuMOF

When the DCBX application feature is disabled, bnx2x stores
INVALID_TRAFFIC_TYPE_PRIORITY (0xffffffff) in
traffic_type_priority[]. bnx2x_dcbx_map_nw() uses that value as a
shift count, which UBSAN reports as:

  shift exponent 4294967295 is too large for 32-bit type 'int'

bnx2x_dcbx_fw_struct() assigns the same sentinel to a u8 before
shifting, so UBSAN reports exponent 255.

Skip priorities outside 0..MAX_PFC_PRIORITIES-1 when building COS
bitmasks and when filling the firmware TX-start structure. Keep the
stored sentinel so disabled-app state remains visible; skipped
firmware entries stay zero from the existing memset.

Valid 802.1p priorities 0..7 keep the previous mapping and firmware
encoding.

A userspace UBSAN extraction of these two functions reproduces the
unpatched shifts and passes after this change. This is not a kernel
or hardware test; the driver was not rebuilt or loaded.

Fixes: 09b775e7ec08 ("bnx2x: dcb - send all unmapped priorities to same COS as L2")
Fixes: e4901dde12d9 ("bnx2x: add DCB support")
Assisted-by: LLM
Signed-off-by: Lâm Trần <admin@rezlabs.io>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c
index 9af8163..e429e64 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c
@@ -350,13 +350,20 @@ static void bnx2x_dcbx_map_nw(struct bnx2x *bp)
 	int i;
 	u32 unmapped = (1 << MAX_PFC_PRIORITIES) - 1; /* all ones */
 	u32 *ttp = bp->dcbx_port_params.app.traffic_type_priority;
-	u32 nw_prio = 1 << ttp[LLFC_TRAFFIC_TYPE_NW];
+	u32 nw_prio;
 	struct bnx2x_dcbx_cos_params *cos_params =
 			bp->dcbx_port_params.ets.cos_params;
 
+	if (ttp[LLFC_TRAFFIC_TYPE_NW] >= MAX_PFC_PRIORITIES)
+		return;
+
+	nw_prio = 1 << ttp[LLFC_TRAFFIC_TYPE_NW];
+
 	/* get unmapped priorities by clearing mapped bits */
-	for (i = 0; i < LLFC_DRIVER_TRAFFIC_TYPE_MAX; i++)
-		unmapped &= ~(1 << ttp[i]);
+	for (i = 0; i < LLFC_DRIVER_TRAFFIC_TYPE_MAX; i++) {
+		if (ttp[i] < MAX_PFC_PRIORITIES)
+			unmapped &= ~(1 << ttp[i]);
+	}
 
 	/* find cos for nw prio and extend it with unmapped */
 	for (i = 0; i < ARRAY_SIZE(bp->dcbx_port_params.ets.cos_params); i++) {
@@ -1871,6 +1878,9 @@ static void bnx2x_dcbx_fw_struct(struct bnx2x *bp,
 
 	/* Fill priority parameters */
 	for (pri = 0; pri < LLFC_DRIVER_TRAFFIC_TYPE_MAX; pri++) {
+		if (ttp[pri] >= MAX_PFC_PRIORITIES)
+			continue;
+
 		tt2cos[pri].priority = ttp[pri];
 		pri_bit = 1 << tt2cos[pri].priority;
 
-- 
2.50.1 (Apple Git-155)

