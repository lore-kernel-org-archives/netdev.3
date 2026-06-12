Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C3258CE5;
	Fri, 12 Jun 2026 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781246782; cv=none; b=UoDzqsqk9cpg035mh/xCAW9Zi/CMMNiXJjpIbrxpjPGtxPx4jdriDWcxzTyGGN7cQz5EwqM5NvrFE3d2r2XdI+L5WTj+VLiky1Bh13XP9ySTc5j9n7K6VHcfszCUcXnfG/6gTfZkxmEUVCklE+41R1BE3+jjntwAyhEhfQu7yJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781246782; c=relaxed/simple;
	bh=X4DKIZG03iiumhiyybwAEXqTjVGRSVQ+O8DLg4xqdqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NdWF0pevM03dBjeCrtfviWMGBF/Tz+/yfGzqRq9tA+kbuihz/knsY+Wmk8c3YnR+J87L6xG1eEntWgKj7zk3OlwMbHnUnSBJdPbz38NbcYxicno5F6NoEDaIFYbJIDK+9wszkQ114CT2sRdsoIBcmJubnnqHdbJuCElU4Wf+uSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=WFKJfb8O; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="WFKJfb8O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781246745;
	bh=+Q0dher5nnDXcXh282F9Uz6FflxguZ+A3KktRl5lK3E=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=WFKJfb8O1LZIBdH2T9ZIqLKHVV4Y/7vtDZwxFFCWD28WN+bfekkGY7XO+7Wi3W0fN
	 QPKKQNhgAssFJY3MTm5wlxMtJHE4GAnis6txf2zI8D04aLQ+8dgPgbHi6sRgZGX8Eb
	 tG6C+cXqr3W4uTB86mE87Hclq6g+G3EQ6IbpeKqg=
X-QQ-mid: esmtpsz11t1781246708td6d75c45
X-QQ-Originating-IP: IC1Lb4NGi5w3soKuU+0uiehtWY7fdWqvlqEJsGmDMYo=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Jun 2026 14:45:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17451922691183808142
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: lorenzo@kernel.org
Cc: nbd@nbd.name,
	sujuan.chen@mediatek.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	niecheng1@uniontech.com,
	zhanjun@uniontech.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH net] net: ethernet: mtk_wed: debugfs: correct index in wed_amsdu_show()
Date: Fri, 12 Jun 2026 14:45:01 +0800
Message-Id: <20260612064501.203058-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MIAEUjVJsNMcYtSL0orNRdqcIQBXJqRLuszaLbUGAPXbAYlGkco4rrbn
	qEp1RUI4VvWWpG6wUE2tzvWwFMJz6pKSJBWIM6fuC65WrxWQBa4x3Bp1XhCqWQMFQ+dDHHR
	+wHRUoYkgWplBRK6f0RGX1UBMrdgJG5AzyQr+CDML4oPBg7KvibyD/zZBHvCuOooc0KbypQ
	N1OnzkCR0VFLYifxgBofWaNB/jNbSezDSQyyL9Ui74d2YFn7wZLssNOyEL6cByHa5O5PDMM
	gH4whgYmbFrbIh1/ujLxGJZgdmJq6dyC7FR+fbX4ZRVZZPOFWAqszSoXClt3cr2YM2Qmcg7
	v4YKJkd2ifkKJYP/ognO0FCKNsnD8lOuhfKnyTZ+0ijh2uKlNvMsRtF1E+Psv96SMs+nN+v
	5apTTeH2+VV5s0orNxeugF0BREqlsYPdwspCSKp2/n8p4hUFMMmlUyQWYoqZhhe8F2dyLmg
	Eqhsr11l6wInklMAtMDQHnvlBjo/GhTS+gPwUywFrh7IEAIpK9C2RIfGvV+zWGgkkp42L26
	tD8NZ6eM212jdLBstDUtpWFAzP67gJqgowFpFwDhO3zHBNX56Ut3/5PgIAZt/baAInp5tb0
	oU+iwlyHgUiD7mScs6PymzQg4lvHVWMvGlS88aB3pgTmoMF96i7SW6Lnyf8uYasi3iaiIQY
	FDtNCAMhGBPPD2tl0bCkToLxNtYD+UgIgqcI1AcvgoHxf7gOm4/Jo0WcPxN+38VczCSEHX2
	jtpLugX9rz6LaO5nl4/S6t/OjUDkgV0baewVtTJ9iyqxlIlHt9jpexzijons0dqswHgJ0hX
	vHE8PMcMb3myhArmN6wmH6b4jJn88WyI/fGXGrgXN2s8UnLmQIJTofp4GANu2nWJpdlWryJ
	jVuCS6v2p+Y+5K+WXGCnWLG5kLN83Qw5Ub/VWqKWk71PE+J2juVUa077hTlViPyR3i73e2/
	A8S0n+DCLbE+61BY1rr6peSyQshtTLKFxnCXVxvjpW8TqX2iVKKzN8njD54PQ3sfD6ZgJy/
	MNt7ie693d04Ht1r+bfth3gjlKB3qdLhO0VRICW2o5H+Qvetfuu393m5umXsdQYrgDi+ujF
	PcGLVe0OCgpbf+4ckQNaBmrbVPn2i1PBg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

WED_MON_AMSDU_ENG_CNT point to different entry by 'base+n*offect' mode,
correct the wed amsdu entry number in wed_amsdu_show().

Fixes: 3f3de094e8342 ("net: ethernet: mtk_wed: debugfs: add WED 3.0 debugfs entries")
Assisted-by: Copilot:gpt-5.2
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/net/ethernet/mediatek/mtk_wed_debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c b/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
index 781c691473e14..519c364e87d19 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
@@ -310,9 +310,9 @@ wed_amsdu_show(struct seq_file *s, void *data)
 			      WED_AMSDU_ENG_MAX_QGPP_CNT),
 		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(1),
 			      WED_AMSDU_ENG_CUR_ENTRY),
-		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(2),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(1),
 			      WED_AMSDU_ENG_MAX_BUF_MERGED),
-		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(2),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(1),
 			      WED_AMSDU_ENG_MAX_MSDU_MERGED),
 
 		DUMP_STR("WED AMDSU ENG2 INFO"),
@@ -414,7 +414,7 @@ wed_amsdu_show(struct seq_file *s, void *data)
 			      WED_AMSDU_ENG_CUR_ENTRY),
 		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(7),
 			      WED_AMSDU_ENG_MAX_BUF_MERGED),
-		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(4),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(7),
 			      WED_AMSDU_ENG_MAX_MSDU_MERGED),
 
 		DUMP_STR("WED AMDSU ENG8 INFO"),
-- 
2.30.2

