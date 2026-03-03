Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CB3C6A5C
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574824; cv=none; b=hlMf/yMCyY66fHwqvQbvOzP0KrebwjpGu2xWq1SKlPZ2pNvP9R81SeLJMCufgTWvFQ1aAYsPWueVJ010f1uK59Vapoj4dVlfZWQ7M6swMLZEejYmJwy/E8jjuZ2t22EOx4LkS2YZLyVrDm/8wCJqUJTWJey/5SkBy23QoEm9wbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574824; c=relaxed/simple;
	bh=v9wEHXWRY/i3hTpcQtXV0JCh1rcZgu1fLOoptDzBCys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDZoeyikkAjBol1SfQYiJx6PTLcBDSVFmC59RhlIMqkqmR78EB5x2yYZ44VuR3/ScE4mquZV5LTYTf+O0k665Lrv1QmfGwRiW1X3AK4KCxX0sgbwZ70yh4T7lHtDp0P0qIgKryhno2yfqaTKxFIrUOmU2/yGqQv1NE9LRfbQ2NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYU0K+i0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYU0K+i0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B29C2BC87;
	Tue,  3 Mar 2026 21:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574824;
	bh=v9wEHXWRY/i3hTpcQtXV0JCh1rcZgu1fLOoptDzBCys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYU0K+i0Oaazi6JA8H7x6XMWj65mkaT9gv4RLuAijvfE21la3yG65vMKbsDpPIhfq
	 P2KiJTJ7QXzMHMiJR5M6OZC9trlkpEnlkYiQ+aLDeftJXhCpmpozlGDQzFy0BLLtJO
	 MtYCtVjlDZSaie8i4weImOpuOPOgxfd/hyyxlh5NUW/aHKXZgRNVKXnWEklZGK7tOA
	 11hrmjzLO1HZCrlXnVmCpTuo5UhGV2ekhB+g9Uhp2Pf5YG7Vmv4XiiAVCK2dTgRY5G
	 jaHtZKqNg1DynklfWKDb98nBLtnG6jF/tHI5LpTnuJAWy/3Ld6frqk32CIGZI/Wvyn
	 NJVzSzeT6FCKA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	manishc@marvell.com
Subject: [PATCH net 02/11] MAINTAINERS: remove Manish Chopra from QLogic QL4xxx (now orphan)
Date: Tue,  3 Mar 2026 13:53:02 -0800
Message-ID: <20260303215339.2333548-3-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303215339.2333548-1-kuba@kernel.org>
References: <20260303215339.2333548-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have not seen tags from Manish for the QL4xxx driver in over 5 years,
and there is no mailing list activity since Oct 2023. There has been
no maintainer activity in this subsystem at all.

Since there is no other maintainer for this driver it becomes an Orphan.

Subsystem QLOGIC QL4xxx ETHERNET DRIVER
  Changes 40 / 74 (54%)
  (No activity)
  Top reviewers:
    [30]: horms@kernel.org
    [2]: jiri@nvidia.com
    [2]: shannon.nelson@amd.com
    [1]: saeedm@nvidia.com
    [1]: aleksandr.loktionov@intel.com
    [1]: kory.maincent@bootlin.com
  INACTIVE MAINTAINER Manish Chopra <manishc@marvell.com>

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Cc: manishc@marvell.com
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c9b69df9204..c939a76b9a2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21455,9 +21455,8 @@ S:	Supported
 F:	drivers/scsi/qedi/
 
 QLOGIC QL4xxx ETHERNET DRIVER
-M:	Manish Chopra <manishc@marvell.com>
 L:	netdev@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/net/ethernet/qlogic/qed/
 F:	drivers/net/ethernet/qlogic/qede/
 F:	include/linux/qed/
-- 
2.53.0

