Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F416523E334;
	Sun, 20 Sep 2026 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789886054; cv=none; b=vGvG9FxM0ReJyMeeSGiduMy3LbgznKIWGEIe5QKcstowU/tYE1p5XBgIaQCkLhxiCggJ2T0f5i57xMZYwBzGelN/33KDyqPzbQeE5/hTjFN/Ea8Q0lU1x6tJihWPOY9U4rsp90iKcXfZKwSdsiGvpY8LJbAc5R2UwZEo0Yz8KmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789886054; c=relaxed/simple;
	bh=YP4pYfD1D1BvOT8NtjzW1Tq1l+5qw+7Z1JJ+aXbZr3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q7iZVGTZZtBpEDLXhNvBkj6/Po2MtsZoXxjw7sJtpqThLAgX3prikwtCK4Bvzv//ZeqTWwe+M/BvPaIQe/YYB6SOZv8/+Z5bU0pW4/RZmQAed2dYA7PcURpgUYG77g/v71g7pD6BQ0ehfaUT661Weg9yzx+tMNUvt2OPjAUmZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=KSRL9z7d; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="KSRL9z7d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=XR
	rulCnqLsf892bb7iyH1RkNTddmsqrQPwO48USUCJ0=; b=KSRL9z7dIwkqL8jO7k
	0uejCw19nGn2/4w0RFxjlQiypeR2CajanCJYENENoCTR3raTIPboRk5gFeA3DNlP
	zweitSXk1mxJXRA7te7mITJzCDqbWO2GtA41ftBYOAky1F8Zdw6lzwhBP1/rw9O2
	XDmv3hVjbg3WhGIWM1rlTAcBA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3v8MPfq9qoXScAA--.56095S2;
	Sun, 20 Sep 2026 14:32:49 +0800 (CST)
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
	Linkui Xiao <xiaolinkui@kylinos.cn>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [Intel-wired-lan] [PATCH net v2] i40e: limit the DDP profile count returned by the firmware
Date: Sun, 20 Sep 2026 14:32:44 +0800
Message-Id: <20260920063244.1927792-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgD3v8MPfq9qoXScAA--.56095S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw4UWw1Utw18JF1DKry3urg_yoW5Cw4xpa
	y5GryDGrykJ3Wqgws8Jay7CF4rua4xZFyYga9Fg3s8urn8tFs5WF95JFWrKF129rWkCrn0
	yF4kCry8AFsrJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULVysUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqBEqAWqvfhFmGwAA3F

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
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2:
  - Reordered variable declarations per Reverse Christmas Tree convention.
  - Added Reviewed-by tag from Aleksandr Loktionov.

v1: https://lore.kernel.org/all/20260915120354.610499-1-xiaolinkui@126.com/

 drivers/net/ethernet/intel/i40e/i40e_ddp.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index daa9f2c42f70..26dccd4236c1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -54,8 +54,8 @@ static int i40e_ddp_does_profile_exist(struct i40e_hw *hw,
 {
 	struct i40e_ddp_profile_list *profile_list;
 	u8 buff[I40E_PROFILE_LIST_SIZE];
+	u32 i, p_count;
 	int status;
-	int i;
 
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
@@ -109,8 +114,8 @@ static int i40e_ddp_does_profile_overlap(struct i40e_hw *hw,
 {
 	struct i40e_ddp_profile_list *profile_list;
 	u8 buff[I40E_PROFILE_LIST_SIZE];
+	u32 i, p_count;
 	int status;
-	int i;
 
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

