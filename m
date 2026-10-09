Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A83A52844A;
	Fri,  9 Oct 2026 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570905; cv=none; b=ZFmH011q1e3qWOgIR+oSvFF14NatS6yoeoLEEqAl3co2X1U4bMJXh12wGUcH/Y0aeTc+lmuq0DzrPrZswG30Xr+rC4XW7ELnsFG0JmqTUQgrr7hBVgpz2YvF72UalsZCD9CQ3hcVGiC6aGRQDRPUa5KFYeI6VAnNMsmtel63q18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570905; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fNn6+mNiYWFQCWYaUDQM8VKgO9CdIaOkSsUQSi97rhwSvB2ewzDeeD61sCvO+TS8T52m7MTTbx8XsDTnTmRQNMdDeLZuvBbxM9wCy+6TjjdXj3EysioZr/Gy9oTFfj+3QdMFMDd/1qlzRHYVdBht0VcunLMC0aAL0RyJVEtosqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVtF0iaU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVtF0iaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351701F000FF;
	Fri,  9 Oct 2026 18:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791570904;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LVtF0iaUGbJeLL6sa5KmlYFN89cPfafiOQ4M9hDJixTlsERD2G8Qid3DmAS8aAEKK
	 nxx3B5Oq+QhUR1nBYKBO0Z10EFXXkhpWfT6Cka6pMJsxN6erGv2DE600yzE9QPhTX1
	 dZw6sT/qezIyXdYMzgnw7hj31M1ZQ0M/z8LvdndI3S+OKx28N8aoLbw3iJDf5U28jc
	 si5ghP+RWZl4lahWN1BLJll3W1aj5lrtC0GAiv595jqDPqfJF4D1uyDn58gnf3XnKO
	 qQhgfnssSwBXUkXC+sbUhmTJExs6dj4I+lY3m3Igp2CAx8KJhh2lSeUZgyAUVfotzK
	 3wxEI7mxDnX6A==
From: netdev-bot+sinfo@kernel.org
To: Alex Austin <alex.austin@amd.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, bhutchings@solarflare.com,
 davem@davemloft.net, ecree.xilinx@gmail.com, edumazet@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-net-drivers@amd.com,
 pabeni@redhat.com, richardcochran@gmail.com, smhodgson@solarflare.com,
 alucero@amd.com, pieter.jansen-van-vuuren@amd.com
Subject: Re: [PATCH net 0/2] sfc: fix PTP synchronization races
Date: Fri, 09 Oct 2026 18:35:02 +0000
Message-ID: <179157090265.2527009.9318454675537519622@kernel.org>
In-Reply-To: <20261009183240.1898762-1-alex.austin@amd.com>
References: <20261009183240.1898762-1-alex.austin@amd.com>
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
