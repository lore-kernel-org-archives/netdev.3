Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA5A38C438;
	Tue, 15 Sep 2026 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473903; cv=none; b=MCsZMFVWjRB910Dcxr87dBcv8iudHRaG1wzsaJDXBSN0zMU9ZIOkGSoZVLbkXwdWDjKrRr9kj+Ya7MyGWRw9z1WDCQXFOJuKX1e2Yr97iqwTjzIqYoLWwmtVDaf1AK0GxNdMwfW2SWW2oTbddo6iqm3FdfbF8lBqmXHBJPma+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473903; c=relaxed/simple;
	bh=f2L8hznEZ/V3dZ3FBe5o1y6clVhB5S2kHARW7L/53wc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qdvi/vxOBBnjnlPbyBPWQ2zXSo7E3Gv4Ck253YSPDILRHpkALp6D65FWtbto0Hid1dXloLmbv/z0WDB5cMU3GxffDlBMKQ5wBBoeXFBuUtbw9UWOf0o5c/eZE6gEhUZ0NLVvCGmDFt39WPfLcwnwhHwtGc+FNHg2D2RfByGe578=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=oGsX1BIo; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="oGsX1BIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9u
	l3bUyHD7wGoCm62vRZXHwUVl+wV8Z92XNjrOcvm0M=; b=oGsX1BIoMzahTkB1ro
	/eq6eq5U1rmBR7jy6/K2rQEzrqCXdrsXXyV+FdlcblxR53zl7h6PhSb3ZcwFlqBu
	iqyx49gBeITYehYRLAUbgWCqlpXH6ohUcQCE9cQyUwN2QnVXd+TE6myFhsnN5SUx
	WPr1dLHCatipvnP4/agMxw6r4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3Ny8rNKlqchRDBQ--.39588S2;
	Tue, 15 Sep 2026 20:03:56 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [Intel-wired-lan] [PATCH net] i40e: limit the DDP profile count returned by the firmware
Date: Tue, 15 Sep 2026 20:03:54 +0800
Message-Id: <20260915120354.610499-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Ny8rNKlqchRDBQ--.39588S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw4UWw1Utw18JF1DCF1ftFb_yoW5WF1Dpa
	y5CryDGr1kJa1jgw45JFW7CF1fu3WxAryagaySg3s8ur98tFs5WFykJFWrKF129rWkurn0
	yF4kCry8AFsrJwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UHq2iUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqAwd82qpNCzcFAAA3Z

From: Linkui Xiao <xiaolinkui@kylinos.cn>

i40e_aq_get_ddp_list() writes into a I40E_PROFILE_LIST_SIZE buffer,
which is sized for I40E_MAX_PROFILE_NUM (16) i40e_profile_info entries
plus the 4 byte p_count header. i40e_ddp_does_profile_exist() and
i40e_ddp_does_profile_overlap() then loop over profile_list->p_count
without bounding it, so a firmware reporting more than 16 profiles makes
both helpers walk past the end of the on-stack buff[] and compare
against whatever happens to follow it on the stack.

Clamp the count to the number of entries the buffer can actually hold
and make the loop counter unsigned to match the field type.

Fixes: cdc594e00370 ("i40e: Implement DDP support in i40e driver")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/i40e/i40e_ddp.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index daa9f2c42f70..1d6d8b3835a3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -55,7 +55,7 @@ static int i40e_ddp_does_profile_exist(struct i40e_hw *hw,
 	struct i40e_ddp_profile_list *profile_list;
 	u8 buff[I40E_PROFILE_LIST_SIZE];
 	int status;
-	int i;
+	u32 i, p_count;
 
 	status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE, 0,
 				      NULL);
@@ -63,7 +63,12 @@ static int i40e_ddp_does_profile_exist(struct i40e_hw *hw,
 		return -1;
 
 	profile_list = (struct i40e_ddp_profile_list *)buff;
-	for (i = 0; i < profile_list->p_count; i++) {
+	/* Never walk past the end of buff[], the profile count reported by
+	 * the firmware is not guaranteed to fit into the buffer we gave it.
+	 */
+	p_count = min_t(u32, profile_list->p_count, I40E_MAX_PROFILE_NUM);
+
+	for (i = 0; i < p_count; i++) {
 		if (i40e_ddp_profiles_eq(pinfo, &profile_list->p_info[i]))
 			return 1;
 	}
@@ -110,7 +115,7 @@ static int i40e_ddp_does_profile_overlap(struct i40e_hw *hw,
 	struct i40e_ddp_profile_list *profile_list;
 	u8 buff[I40E_PROFILE_LIST_SIZE];
 	int status;
-	int i;
+	u32 i, p_count;
 
 	status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE, 0,
 				      NULL);
@@ -118,7 +123,12 @@ static int i40e_ddp_does_profile_overlap(struct i40e_hw *hw,
 		return -EIO;
 
 	profile_list = (struct i40e_ddp_profile_list *)buff;
-	for (i = 0; i < profile_list->p_count; i++) {
+	/* Never walk past the end of buff[], the profile count reported by
+	 * the firmware is not guaranteed to fit into the buffer we gave it.
+	 */
+	p_count = min_t(u32, profile_list->p_count, I40E_MAX_PROFILE_NUM);
+
+	for (i = 0; i < p_count; i++) {
 		if (i40e_ddp_profiles_overlap(pinfo,
 					      &profile_list->p_info[i]))
 			return 1;
-- 
2.25.1

