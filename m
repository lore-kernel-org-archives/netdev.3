Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D22B345EBE;
	Mon, 12 Oct 2026 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810213; cv=none; b=OP9bwiUimN64gZ0dT+GV+B89ApswBryymBWA9uOIGGyc0eoxRX9wii2YhjzSSHz3wFti/tQd0b8ySQRgHMu0waQg2q9nrJCmmtd+6w37I/BoDYntR6fLDVDC3fh6ZukWPS3gnsDNNumVxqtqvpDHl+0gZ+UFE7bEJLLQJSWgITw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810213; c=relaxed/simple;
	bh=bukPkEHSlabbC+W7n+ExoxWKRtQnOW+x82cAUXMsW+o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wc4FHojFYywClW9MRxNRc58/bpm6kzEhtRnpxAqhPl9Fc/ZLN4IYqhSTtsfrKod5HIXQHKImJ8xUbHjUA0VFKOue7i+bVuP6qwgEG7ZMpUKjG6oC6TNHY7cQMene1ZOlbKWlii3KprQuSjcz5z+HDPIj7VJIiYHX27qiGe1H/tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6SewWFn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6SewWFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3561A1F0089B;
	Mon, 12 Oct 2026 13:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810211;
	bh=gryxofwMSGByi7Rxx889Ef6ulGjr6QsescxHmPgaYlc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V6SewWFn3vLH/Mooa1OSffGAvHJPfCJ/0ZWA3m499Bt12030mwmSYjSBuJIoC7Jk3
	 TCSVfZzoJr+/TSVrlQAz7tK3pZtSNMysKo2MJaNosLVTNN2/cQu67BXD0a6G6J54Nu
	 eOX508mxU5Jk5RG3wRdsZlNWbolhHkbz866BRFh0IbcUeeAuI6/PbJIc69kuEWLUhI
	 eASMFoFSixfjjM2dT92NMSsY0qFOvYM8lMYNouAvTTdAMAz7ldTJTgh4QV8CvQSP7y
	 ewIQjXEH+AAzSq5hS0RuauLgn7uFUU8JMNed9SHDB/+lC1Zxd1SuUDNGKHLgpNwfZ+
	 Gh/VcSM1+E5KQ==
Subject: Re: [PATCH net-next v2 02/11] net: ethernet: qualcomm: ppe: Fix
 multicast queue config table access
From: netdev-bot+sashiko@kernel.org
To: jie.luo@oss.qualcomm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, quic_leiwei@quicinc.com, quic_suruchia@quicinc.com,
 quic_pavir@quicinc.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com
Date: Mon, 12 Oct 2026 13:03:29 +0000
Message-ID: <179181020968.434549.112728167970187942@kernel.org>
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-2-8c7b057e2c43@oss.qualcomm.com>
References: <20261011-qcom_ipq5424_ppe-v2-2-8c7b057e2c43@oss.qualcomm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit "net: ethernet: qualcomm: ppe: Fix multicast queue
  config table access" fixes a real hardware misconfiguration bug in…

--

net: ethernet: qualcomm: ppe: Fix multicast queue config table access

This commit fixes ppe_config_qm() so that the multicast queue
configuration table is indexed relative to the first multicast queue
instead of by the absolute queue ID. It also shrinks
multicast_queue_cfg[] from 5 to 3 words to match the table entry size.

> Fix it by converting the queue ID to the index of the multicast queue
> configuration table and accessing only the 3 words of the entry.
>
> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>

[Severity: Low]
Should this have a Fixes: tag? Commit 806268dc7efd added both the
multicast_queue_cfg[5] declaration and the absolute queue_id indexing:

Fixes: 806268dc7efd ("net: ethernet: qualcomm: Initialize PPE queue management for IPQ9574")

ipq9574_ppe_qm_queue_config[] covers multicast queues 256 to 299. That
means kernels which already have the IPQ9574 PPE QM code take the broken
else branch in ppe_config_qm() on every probe.

Since this fixes code that is already merged, could it be sent on its
own to net with the Fixes: tag, rather than as part of the IPQ5424
series?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43%40oss.qualcomm.com
