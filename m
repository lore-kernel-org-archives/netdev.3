Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F7952E07F;
	Tue, 22 Sep 2026 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068341; cv=none; b=Pu1/kv3Hli7QKXl4/jCGrOI/IFnDbWcwfUhZJ/egbKlkjy6YKuJ8VpUi9+pHoeQ49+zeQ2oKWFYmHHiB2wgrgdCkn0RxmGzBpJY2apdyDw8mMGTj8Hj8ggjemGTlSJD8BlAj6I/DHw/joVOZYggKpFHtBWSq2zVJdrNSyMioqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068341; c=relaxed/simple;
	bh=egUmLikhuwhkzquqLxqxqCXwr1NaX2em5TiZk+sZ1Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Eut1c9YIpF8tPYYeytoQwJkMKmSc4fNxTkwDEh9Oy9HnT9nX2rZtp3rhD2q4oNFHt/viak8EpAgqVeeGD3Xu/zYsW6mIu6ux2HOmxj1y/aqXtNHM4huRLTrcM7wrctGP5ySD/cKyKwfEyNsVjdABcpmnjX+FmnGpZaUVuBNp6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=eT14op8Z; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="eT14op8Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=JZ
	B0Slkp1cTB3zAnWSwmos8fcy3POuFLh4py+bqB5yk=; b=eT14op8ZJEjCwld797
	9NeAezOI4tg/JlPsp4eTU74QEi8ZGnglumaAZ9qg4QvlMEXKBCcn5qhzDn+08rwE
	lrnz6dJFjcphyWHnfF8YK7bysyiIofF4sAArEWhHqoriZS+D8pMySqT0Ij9IKrJ7
	9ERRHZEgTrofJv37soEks7LkI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3HzY9RrJq0uQVAA--.17646S2;
	Tue, 22 Sep 2026 17:11:25 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
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
Subject: [PATCH net v3] i40e: limit the DDP profile count returned by the firmware
Date: Tue, 22 Sep 2026 17:11:23 +0800
Message-Id: <20260922091123.506598-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3HzY9RrJq0uQVAA--.17646S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw4UWw1Utw18JF1DKw4xtFb_yoWrXr4fpF
	W5JFWDGryDJa1j93yUGFW7uFyfu3WfAryYga4a93s8urn8tF4kWa48tFWFkFy7ZrWvkr90
	qFs5Cry8CF4DJwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ul-ewUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlB3nvmqyRj0E1QAA3i

From: Linkui Xiao <xiaolinkui@kylinos.cn>

i40e_aq_get_ddp_list() writes into a I40E_PROFILE_LIST_SIZE buffer, which
is sized for I40E_MAX_PROFILE_NUM (16) i40e_profile_info entries plus the
4 byte p_count header. i40e_ddp_does_profile_exist() and
i40e_ddp_does_profile_overlap() then loop over profile_list->p_count
without bounding it, so a firmware reporting more than 16 profiles makes
both helpers walk past the end of the on-stack buff[] and compare against
whatever happens to follow it on the stack.

The same buffer is handed to the firmware as an indirect admin queue
buffer, and the admin queue code copies all of it into the DMA bounce
buffer before submitting the command, so its uninitialized contents were
visible to the device as well.

Zero initialize buff[] and reject the list when the firmware reports more
profiles than the buffer can hold, instead of answering from a list that
was only partially read. Both helpers already report errors to
i40e_ddp_load(), which aborts the operation.

Fixes: cdc594e00370 ("i40e: Implement DDP support in i40e driver")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
Changes in v3:
- Zero initialize buff[] in both helpers: the whole buffer is copied into
  the admin queue DMA bounce buffer and copied back afterwards, so its
  contents were exposed to the device, and entries the firmware never
  wrote were compared against. (Sashiko AI review)
- Reject the list when the firmware reports more profiles than buff[] can
  hold, instead of silently clamping the scan and then answering from a
  list that was only partially read. (Sashiko AI review)
- Dropped the Reviewed-by tag, as the code changed after the review.

 drivers/net/ethernet/intel/i40e/i40e_ddp.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index daa9f2c42f70..49a98c0e001a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -53,9 +53,9 @@ static int i40e_ddp_does_profile_exist(struct i40e_hw *hw,
 				       struct i40e_profile_info *pinfo)
 {
 	struct i40e_ddp_profile_list *profile_list;
-	u8 buff[I40E_PROFILE_LIST_SIZE];
+	u8 buff[I40E_PROFILE_LIST_SIZE] = {};
 	int status;
-	int i;
+	u32 i;
 
 	status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE, 0,
 				      NULL);
@@ -63,6 +63,13 @@ static int i40e_ddp_does_profile_exist(struct i40e_hw *hw,
 		return -1;
 
 	profile_list = (struct i40e_ddp_profile_list *)buff;
+	/* The firmware is not required to report a profile count that fits
+	 * into the buffer we gave it; refuse to read such a list instead of
+	 * walking past the end of buff[].
+	 */
+	if (profile_list->p_count > I40E_MAX_PROFILE_NUM)
+		return -EIO;
+
 	for (i = 0; i < profile_list->p_count; i++) {
 		if (i40e_ddp_profiles_eq(pinfo, &profile_list->p_info[i]))
 			return 1;
@@ -108,9 +115,9 @@ static int i40e_ddp_does_profile_overlap(struct i40e_hw *hw,
 					 struct i40e_profile_info *pinfo)
 {
 	struct i40e_ddp_profile_list *profile_list;
-	u8 buff[I40E_PROFILE_LIST_SIZE];
+	u8 buff[I40E_PROFILE_LIST_SIZE] = {};
 	int status;
-	int i;
+	u32 i;
 
 	status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE, 0,
 				      NULL);
@@ -118,6 +125,13 @@ static int i40e_ddp_does_profile_overlap(struct i40e_hw *hw,
 		return -EIO;
 
 	profile_list = (struct i40e_ddp_profile_list *)buff;
+	/* The firmware is not required to report a profile count that fits
+	 * into the buffer we gave it; refuse to read such a list instead of
+	 * walking past the end of buff[].
+	 */
+	if (profile_list->p_count > I40E_MAX_PROFILE_NUM)
+		return -EIO;
+
 	for (i = 0; i < profile_list->p_count; i++) {
 		if (i40e_ddp_profiles_overlap(pinfo,
 					      &profile_list->p_info[i]))
-- 
2.25.1

