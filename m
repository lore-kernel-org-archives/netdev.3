Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001693655E9
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 03:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405983; cv=none; b=KqJk/NnNjxGOF6BKAAPjc98TSqLU/j9tBJR+hTXUR8CdQbnjpWhTUYgg7yjjMN5I85veHnNrkP/BSOXHR69kMh1IGjeRWQC+e9HY1YkMbosirXs5m47x6soxYvnIu2E+g/2Sus3pbpexql+MO4xsQeF6t1HNXsL2NgX3AY38MWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405983; c=relaxed/simple;
	bh=imE3azFTqr6IytikjQ8sAifmA7nD/iksLOw0tTbdeCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=felG0/+3gX2tJjxDPedHRPODwlmm0PqcUbC6rveWs9lwj26Ngsgm62rzIh5J2Ak83FBOXehWaCI7NESv+H0FQYTbaFNARP3403uRh30KAPWn4A6vvns5ghe5hbt+HbMI9L9VmrxXgNgRth5wIwjMIV7gKPk8kkxfd5V1FEYYDdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYUTMMlc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYUTMMlc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DDF1F00A3A;
	Thu,  3 Sep 2026 03:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788405981;
	bh=C3TWUAoKeQuJi8jRSdvfgXRyvTf28CWQiO04BbqrUos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UYUTMMlcRVFIVrtKXQGnuXCe6IXq4/KYy1zggMmzDjr153gTHVnwJxpxr0RxdVRFm
	 tie0C/bzaBwodt25D5wAIBit/FFgxYkovqKGGhSq3I6TKqPMaDTD9moUmHMn1jTXBA
	 bvfHIRruRg2RzGclawZgstPQ8OvQrAhw4cnZdG4K02zWlIbXWW02ERvVtRicVFhIG5
	 NCVVpHNEblmh1Iby61yIGxTGcr6REESMFCQOhtp+0p284j0mw83uDqoKDJEGZmP+JA
	 d/Jf4Wqco/Tekc+AgDFQmw65Qu4z0XDL2V9F762+cdU8ewMlXoaWzfcVToTSNUaVFO
	 aXkpOSfs1YMWQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 5/5] ethtool: document that GRXCLSRLALL rule_cnt is a caller-provided limit
Date: Wed,  2 Sep 2026 20:26:11 -0700
Message-ID: <20260903032611.3000029-6-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903032611.3000029-1-kuba@kernel.org>
References: <20260903032611.3000029-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three drivers have shipped a get_rxnfc() which dumps its entire rule
table into rule_locs, reading rule_cnt as "how many rules do I have"
rather than "how many entries did the caller allocate".  Nothing in the
callback's documentation contradicted that reading.  The distinction only
matters because the ioctl lets an unprivileged caller pick rule_cnt
directly, so getting it wrong is a heap overflow rather than a truncated
dump.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
---
 include/linux/ethtool.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 12683b5d125e..253600c0eccd 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1057,6 +1057,12 @@ struct kernel_ethtool_ts_info {
  * @get_sset_count: Get number of strings that @get_strings will write.
  * @get_rxnfc: Get RX flow classification rules.  Returns a negative
  *	error code or zero.
+ *	Note that for %ETHTOOL_GRXCLSRLALL rule_cnt and size of the arrays
+ *	is user-provided, and not guaranteed to match what driver would
+ *	have reported via %ETHTOOL_GRXCLSRLCNT. Drivers must return -%EMSGSIZE
+ *	when rule_cnt is too small. rule_locs is %NULL when rule_cnt is zero.
+ *	On success drivers must set rule_cnt to the number of locations they
+ *	filled in, the core copies out exactly that many.
  * @set_rxnfc: Set RX flow classification rules.  Returns a negative
  *	error code or zero.
  * @flash_device: Write a firmware image to device's flash memory.
-- 
2.55.0

