Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E5841835A
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045815; cv=none; b=rl4H5V0C/m8NWCG6nDvLzrQ77B1t8EwERcmUnMeF7DBCqjZAlnKeX7y+3zUZCISs44mbKAusbJYf+TSrJ0w891qO0DD6f/erCjrgVuGYojeSS59ZW08vt6ATJovPbI0/F0Dk0LUF2Y7uJ1TS93BiCm+ELwajP259D9bqbdiyGTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045815; c=relaxed/simple;
	bh=PizaCOC+hmCri5Wwv9aBGGDYN4IjkNPrlXI09EcOmSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l74KYQlfUGrz3MC4/Aj8LALOVTrGctbjkQzClrPHUZbbJLSbQZ8t9kUbilwAmEvVbmAbvS/JcwXURowd5wNfqwP2rt+0MOSbeYbfROmosdRQTl0NwJ4OQ5wtnr7JqVEfOaO10jfUuy4TPIMdH9Tdvzvbe1pHyg8fxMGmSNTc3ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1lsQRgT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1lsQRgT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04AA6C2BCF5;
	Thu,  6 Aug 2026 19:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786045814;
	bh=PizaCOC+hmCri5Wwv9aBGGDYN4IjkNPrlXI09EcOmSY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=q1lsQRgTdLwFOj2gJ2Aw2Qm9D4lt73/XNJXZOUV8xshTF0Hkf0c0pRmN9niIjIL/X
	 z3YLnbWB4hzKqPSU8RGEhihc5FY2ZaqVCBn4lup7WISWk/iomLkmRNcxaq4ySy97rW
	 3uIoxnFmu2zp/mxu1YSUr5ftWotuzefUHsN4LM4F/3nxqqrkTAMMeqZp8aDY6XT0BI
	 h3sVpk6zWUh+r4Bezi2uOdWrfphO3/rqLRX4VzrHGfSffpoTmUMQlzq9cQg5eB6AC4
	 h6FqlkUYjm6mcP8bD4hVM8blpKlQWo3OXaVfd9ztDyV2FEObWCcXWyEURJVUnywUcs
	 N7d+wqkvLpKHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD724C56208;
	Thu,  6 Aug 2026 19:50:13 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Thu, 06 Aug 2026 12:49:22 -0700
Subject: [PATCH net-next] mailmap: add entries for Christoph Paasch
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-mailman-v1-1-b4d7bc0ffd1c@openai.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCMBBEf6Xs2cUYbC3+ivSQxKldsaskUQql/
 26ix5l581ZKiIJE52aliI8keWoJh11DYXJ6A8u1ZLLGdqY3Hfsjz04es1M2FqPpEVqcWiqHV8Q
 oy092IUVmxZJp+C/p7e8Iuboq610C++g0TLUqdIX3Ra20bV9nBzDDlwAAAA==
X-Change-ID: 20260806-b4-mailman-02ef08ec5e75
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786045813; l=1364;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=RwSB4S74uMgM7hwtS7mI8TFWqu8YItSh26B7RAY+3a0=;
 b=szBPnHJNE9QAFnLulcPxuz7mRbQwnDzI9WaiODvduPZs4PEE/+SdUpVdVBmIt8PZzLhaV2CgR
 oScyKm8VsLcB88gSNDz3dgicd//HuHZiUmFs6kaUiAf6Tu5WOnDNaz4
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

From: Christoph Paasch <cpaasch@openai.com>

Map the email addresses used for previous kernel contributions to the
current OpenAI address. This prevents get_maintainer.pl from listing
historical addresses as patch recipients.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
 .mailmap | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.mailmap b/.mailmap
index fd5e272bca9a..85e022641168 100644
--- a/.mailmap
+++ b/.mailmap
@@ -210,6 +210,10 @@ Christophe Ricard <christophe.ricard@gmail.com>
 Christopher Obbard <christopher.obbard@linaro.org> <chris.obbard@collabora.com>
 Christoph Hellwig <hch@lst.de>
 Christoph Manszewski <c.manszewski@gmail.com> <christoph.manszewski@intel.com>
+Christoph Paasch <cpaasch@openai.com> <christoph.paasch@gmail.com>
+Christoph Paasch <cpaasch@openai.com> <christoph.paasch@student.uclouvain.be>
+Christoph Paasch <cpaasch@openai.com> <christoph.paasch@uclouvain.be>
+Christoph Paasch <cpaasch@openai.com> <cpaasch@apple.com>
 Chuck Lever <cel@kernel.org> <chuck.lever@oracle.com>
 Chuck Lever <cel@kernel.org> <cel@netapp.com>
 Chuck Lever <cel@kernel.org> <cel@citi.umich.edu>

---
base-commit: c206fc0705d1050d9bce22ac4eb94bb062443cd6
change-id: 20260806-b4-mailman-02ef08ec5e75

Best regards,
--  
Christoph Paasch <cpaasch@openai.com>


