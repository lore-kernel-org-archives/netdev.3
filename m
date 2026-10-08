Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E12048FF8E
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453346; cv=none; b=QcGkAKRZ0vqNmMF7elVGk+xHt5RDyQC40mObj5dG0NyWvsJyDaKPHeZ4Zq7hltUq+tqAomXYYcIBxJnBLWnlWDE4BeDUOCbh2vc0BXFIi2X5YPcjtmr9h0EXv17SiwITlGQLJ3Y+t6M4+UiLyCwYBetaoDmRhNO3RgjXVuOtYjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453346; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rh2uk62fsYmnKpk606FaG1oIisBWNSt/kKMXiKkoRBuTf5kbfe9EM4RaGbXmyaYU99C/0xwTvZ0nXHgrL0YizR1oIpfDS2wjf3O6uVMaE6rIBDqglS8t0poiiJFBIh0UaO25UZ8BuBmu5Hr4kJz8ZWg0dkmnBSqIBkOp/7pHoR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLJk25pf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLJk25pf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDD41F000FF;
	Thu,  8 Oct 2026 09:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791453344;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cLJk25pfjK0jW/iM6wA3vmuLAWxdTGXQT1dJ2Khqb8OKP5y36Y7LzvndtAiUnILOt
	 OniL/RummSSbUFz0BffvsM3jFbgV4LUCnsf28WQh7V8OD6DYEIS47C5tI1OSIbFmZs
	 qOxP84q77T1qMA6VD8zSCzV6hZYwwr2ZkCPuZXg0MJb8YqK0/EVpNffWRpdDcHDJjL
	 DcAJAE8OWFUiK8W1lD5KyK4vq98qffNDWUNzRjdCYVk9wyRlx3+M6f8vf45EzH7BLe
	 BFLB9z6TqZFytHF3rRetER0/THvTNS8jo01VBbFJMWthm7fLTrjL/AK+lsQUJdeVDP
	 NjEoZV9I3PDgw==
From: netdev-bot+sinfo@kernel.org
To: SAYANTAN NANDY <sayantann11@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 bread.hsu@airoha.com, sayantan.nandy@airoha.com
Subject: 
 Re: [PATCH net] net: airoha: keep PPE offload when NPU refuses flow stats
Date: Thu, 08 Oct 2026 09:55:43 +0000
Message-ID: <179145334384.2527009.4239067700016804590@kernel.org>
In-Reply-To: <20261008094828.15458-1-sayantann11@gmail.com>
References: <20261008094828.15458-1-sayantann11@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
