Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F73F33688A
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574828; cv=none; b=TKPjMnV22J144zhuYuC3hvsoXxIwiI9sUsoC1f0U+ITiCRYr7C3BfRZEvDo3Lp7RIQ1ZhsgkPUraHwcXXNAWGNVNNF/PwotjhG0fZF/jpNDAPZNv2TTQBq2YlukidhA5ueecHLekFZh8W5Gp3ekvG9NBaBnuJXX6VIF0U7QAlBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574828; c=relaxed/simple;
	bh=halFq8lcU72mwJNwh3ms5LmfIfvH/rYGfW2CiKKnM84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tf5Z9znkcvZlMKxnjqNHb9zdmfycxEv3YaOOzsNL0esAIm16n1Y+K98zVsXrl6uK31FU3pVkEzj5IgkdvruiaEyKAdd8eVmhDfa1h0FjmkArYwYnYTIjL+t2cxzRsHW1Uilx7bec4RjcEia11aZTbO6+1pZp1oWCIgSyEAR/aEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpheB+q2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpheB+q2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39C4C2BCAF;
	Tue,  3 Mar 2026 21:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574828;
	bh=halFq8lcU72mwJNwh3ms5LmfIfvH/rYGfW2CiKKnM84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JpheB+q2vMyA7y0rmJF8q4+BmBtr5nByJSfbTbe7bNvmPeDLwbs/WTyv6W/97MI3S
	 ERyRVum3rECYm8mpLJj9Vm2Ao8A4GJ8owSfCfPNOiDG7wacDUWA4WULTOfT+Tt2D1D
	 NlHRB1f1YkUKRLyeN33IuvnvHHF2bzLVFciBBxLSpOP3IHaFgcnDbzyGSG/X5wuSdD
	 bWchAYNNivS2rxXFP4gRLgTbzVkzBgowgXdaojv0Y/xwphWUm+HeLsBWKqdHMmpTk6
	 l1RVPhS0QhIYyr8oZVN6NdfN54bY3u2HR+3W+p3ZI4WDW45jwpdtq9FfLBHOWoNw5F
	 U8hCBoSKzi4oQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	taras.chornyi@plvision.eu,
	enachman@marvell.com
Subject: [PATCH net 09/11] MAINTAINERS: replace Taras Chornyi with Elad Nachman for Marvell Prestera
Date: Tue,  3 Mar 2026 13:53:09 -0800
Message-ID: <20260303215339.2333548-10-kuba@kernel.org>
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

We have not seen emails or tags from Taras in over 5 years,
and there is no recent mailing list activity.
Elad Nachman has been providing reviews in the last couple
of years and is the top reviewer for this subsystem.

Subsystem MARVELL PRESTERA ETHERNET SWITCH DRIVER
  Changes 39 / 157 (24%)
  (No activity)
  Top reviewers:
    [8]: enachman@marvell.com
    [6]: horms@kernel.org
    [4]: idosch@nvidia.com
    [3]: andrew@lunn.ch
    [3]: jacob.e.keller@intel.com
    [3]: jiri@nvidia.com
  INACTIVE MAINTAINER Taras Chornyi <taras.chornyi@plvision.eu>

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Cc: taras.chornyi@plvision.eu
Cc: enachman@marvell.com
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61fd624c673d..8123339e4769 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15485,7 +15485,7 @@ S:	Supported
 F:	drivers/perf/marvell_pem_pmu.c
 
 MARVELL PRESTERA ETHERNET SWITCH DRIVER
-M:	Taras Chornyi <taras.chornyi@plvision.eu>
+M:	Elad Nachman <enachman@marvell.com>
 S:	Supported
 W:	https://github.com/Marvell-switching/switchdev-prestera
 F:	drivers/net/ethernet/marvell/prestera/
-- 
2.53.0

