Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752074756D3;
	Fri, 16 Oct 2026 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792148958; cv=none; b=blrzicqDz5NhgLYWNC37qKNCL//mk8WSn6WHgQ1GkMGAvF/c08W3tIHsyqBgU+WBqkxXgIp9wIvKZ/iMDaVcHnRdayq5n/Ao66MmKXAg053Nm5lPtrNfT5aBkwOPGw6sOEn5MJCBahLpTy4G+lD9UNfRnwpmpC5FzURB66uYaDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792148958; c=relaxed/simple;
	bh=f6EkHzolGy8GYPjeII04sc8oTncaFwHLWXs9LkHKYfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GRzxMxtXJQvhZJBYai/bSOHZrmGhwrSXRwkLvE5n4kI0pnbbgC2fjksWsxOsXObZ/6HWd2VqKjOzucQo/pAZPITvooRx0DlhD4Iy3Y+L1WSW23DAzDoC2Qqm6Q2R18HCYZmSRiSu6Ei3Jg9Xt8VHiQzF0ffqLWIZoGlixVl7f3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmhfJJ5S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmhfJJ5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EE31F000C4;
	Fri, 16 Oct 2026 11:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792148956;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NmhfJJ5S+SC/TSlV0fbrD0e3peeBD3Y8Pa2zLOSqXFv8a9jjxkpjxXUIewX43bMFc
	 gSwFJTCyLzIIjzCJm0mzUJEkTq0Q8OcfuWKoy7N9w6ywb2I3HHNr0RxkNAkggK4vQy
	 5dQXQRfMc1YR5VjJG813U1Gki4Ux7gKsAmfnZ8PAeYlep63lCT3aifdCEEW/1cfkRM
	 hu3E4LMFYrjtUC7/S58UaP6r9rRhOUpodPh9yUW3cvxF/gA8YDyAUs1vW6Wa4RpJN0
	 6WAgVH0F9eB+z1TDvxLASUTfkl+a4X2qI2gl/GLhwHdWTB7sTsqpBGvGGxBFkKSiJ8
	 Nj56taxLz/hsg==
From: netdev-bot+sinfo@kernel.org
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
 liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com,
 ningwei15@huawei.com, shiyongbang@huawei.com, fengzheng6@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: hibmcge: set netdev_ops before hbg_init() to fix
 NULL pointer dereference
Date: Fri, 16 Oct 2026 11:09:14 +0000
Message-ID: <179214895481.408196.13202102373888090421@kernel.org>
In-Reply-To: <20261016110421.2288670-1-shaojijie@huawei.com>
References: <20261016110421.2288670-1-shaojijie@huawei.com>
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

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

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
