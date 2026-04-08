Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509903B3BEB
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775643643; cv=none; b=qTpuERBC1bEsEJLyFMB8yn8XNlCPRJmGh4vbYIYi4Bd0IfRig9WJhY6AjGfKokNLKXX7xRfpkmdgUeUDVFmYjjmkrC6J9ZyjobVdCv+kNVEKP5t/B+gduoFsyYSS3L2O9w/KAN933H5ZndEzoO1m0LVh0BaQuZcdscufTiqSmu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775643643; c=relaxed/simple;
	bh=ABZLM89td49tEIN7UAY05XdHZIYCDOKvcEo6PPPXL4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mRyXP/uq5rNO6tg1ryHX1tRiB956QK26ogIGlvoYOh4oclb/SPIyY31HfnA6VkmX5eJ2VdUCCn18lXzFdOkAlljKHtKn/akgDAZyRovWvfcyh41K4ejDZ/YaHcn1bW07URCvS2FcRCEDBCoZBxb6QJ4I98InNA1g4UzUfO5WIQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UylZGa91; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UylZGa91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E71C19421;
	Wed,  8 Apr 2026 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775643642;
	bh=ABZLM89td49tEIN7UAY05XdHZIYCDOKvcEo6PPPXL4g=;
	h=From:Date:Subject:To:Cc:From;
	b=UylZGa91eIst3xrkGSx8Rv7QKeB4U9GXaeu3sGozFpC1+cKpVH/MXGk6NsfglblLL
	 mJp5oRaoxD7E/OCKVrB7F6GtchmH7J0ad1p1WZa4f0vL+9m9IEPkBFjaJkZvCo9IrZ
	 v/US7MRVyxLnEt8HZ0slSyAX4v7Jf1ckbOe2+kjAx5OtPxk5akENyPL0KoEsQDpa5i
	 xLB3tiR12atgVp+K8PWFGO2q2THEUrKenlmyR2X9KtakFLaq0MRdUvpgtQE20+nXZ9
	 VAjyWK+5Z/UUt8bxu8N1LUkesug4MJ08hq+Trt1fMkmtm7Nu54p7KuFMPdOQaSiR9q
	 Kzi9pV2XAEM3Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 08 Apr 2026 12:20:09 +0200
Subject: [PATCH net] net: airoha: Fix FE_PSE_BUF_SET configuration if PPE2
 is available
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-airoha-reg_fe_pse_buf_set-v1-1-0c4fa8f4d1d9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQ6CMBBG4auQWdOkVhHkKsY0A/yF2RQyg8aEc
 Hcbl9/ivYMMKjDqq4MUHzFZc8GlrmhcOM9wMhVT8OHub75zLLou7BRzTIibIQ7vFA27uz64bTA
 NTRiZSr8pknz/7ydl7PQ6zx+1t6AOcAAAAA==
X-Change-ID: 20260408-airoha-reg_fe_pse_buf_set-39a75edb52ca
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3

airoha_fe_set routine is used to set specified bits to 1 in the selected
register. In the FE_PSE_BUF_SET case this can due to a overestimation of
the required buffers for I/O queues since we can miss to set some bits
of PSE_ALLRSV_MASK subfield to 0. Fix the issue relying on airoha_fe_rmw
routine instead.

Fixes: 8e38e08f2c560 ("net: airoha: fix PSE memory configuration in airoha_fe_pse_ports_init()")
Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 91cb63a32d99..c365d693cf40 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -293,16 +293,18 @@ static void airoha_fe_pse_ports_init(struct airoha_eth *eth)
 		[FE_PSE_PORT_GDM4] = 2,
 		[FE_PSE_PORT_CDM5] = 2,
 	};
-	u32 all_rsv;
 	int q;
 
-	all_rsv = airoha_fe_get_pse_all_rsv(eth);
 	if (airoha_ppe_is_enabled(eth, 1)) {
+		u32 all_rsv;
+
 		/* hw misses PPE2 oq rsv */
+		all_rsv = airoha_fe_get_pse_all_rsv(eth);
 		all_rsv += PSE_RSV_PAGES *
 			   pse_port_num_queues[FE_PSE_PORT_PPE2];
+		airoha_fe_rmw(eth, REG_FE_PSE_BUF_SET, PSE_ALLRSV_MASK,
+			      FIELD_PREP(PSE_ALLRSV_MASK, all_rsv));
 	}
-	airoha_fe_set(eth, REG_FE_PSE_BUF_SET, all_rsv);
 
 	/* CMD1 */
 	for (q = 0; q < pse_port_num_queues[FE_PSE_PORT_CDM1]; q++)

---
base-commit: f821664dde29302e8450aa0597bf1e4c7c5b0a22
change-id: 20260408-airoha-reg_fe_pse_buf_set-39a75edb52ca

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

