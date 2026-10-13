Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E914F5592E5;
	Tue, 13 Oct 2026 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924631; cv=none; b=NX7stJSqcezwvEHiyVgOnzMOtE/M/+z/qZgI3KJ4rBdhK5VWASVwkDHdbVpA5usRAV6iX8weSOBCNHtzZWpW+JwjGtPImy553EQBqKy2SI6kEE00JaMQWW+eBKjpXL7h6dkLIw6zFbAs4wXdmhIPS8WdBC3zc/M8OLTpuQDIihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924631; c=relaxed/simple;
	bh=zvpmhm+BAUlfIVJ/6Kp9ShG7pA3G2q65FWBMzuTisWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P+MexuNwAu1plbbbE/PvByp9whgVZwNIozEoctKajaOfzQq+E8bQBUGYNe8fdNq81Om0fY0OjZJJJvjeVbrX6sTU8/OtTyy5EoDd7gkjh8CCzM1ZF4OW+wFMN0J75kz7s0JfgAeehPY3JG/zqk/sDwiFDRFXXeWQLLmDsxnrkPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EirEIYW8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EirEIYW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C634B1F000FF;
	Tue, 13 Oct 2026 20:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791924629;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EirEIYW81KvDRep1elRjc7mcqVabRp8WAKa3QMezKogt9HKZIHQOZjfcVWMKcUTM7
	 VAvyzudiqMTiZu8jXYSYg4akCzrfTXrIQjLCD6Bap6SmR0rYmJpgnAfLn5tBEQjJzL
	 /uBW6rWJnco7p+8VqLSEhmE1mL3oD9hCDZ1r75i/lvXj8PLqhKHx+YXMdp2G9I9isX
	 luDkf77/KO3IAAxdQ/DdZVo2bBsH24Wu+7nCi0YHFkyKe9RJuRcY3AaAGooJdUdFkB
	 FhQD8HSwf86M+XLL8OfAfLachXMvGLPlOjTCDsNqjUipUJftYa4mJX49Uww5ohkgjI
	 hhngfNQ7dJFag==
From: netdev-bot+sinfo@kernel.org
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>,
 Simon Horman <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net v3 RESEND 0/6] net: bcmasp: Collection of fixes
Date: Tue, 13 Oct 2026 20:50:28 +0000
Message-ID: <179192462836.160550.12663009075100618667@kernel.org>
In-Reply-To: <20261013204439.3494046-1-florian.fainelli@broadcom.com>
References: <20261013204439.3494046-1-florian.fainelli@broadcom.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

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
