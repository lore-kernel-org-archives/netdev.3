Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB370440A19
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585965; cv=none; b=e/1RYo0ti0i2e8ZmOvX24QGF4E0bO4H1Zgh7MEMSc951JQEl6P0Mh5+TIPdpSg5M2BE3VOo0mQzuufvBWqg3bc2A5GniShr5npEe/SjUZHv9/I1ux693Yjg2ZM/GGqYRbamANYk7ehJJ5qyf8ons5ktQ+vHziNPqszFybZzZ1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585965; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XOxGWYFy1zlaF+/EkkwwY0DzcN626vhTMLSb+uDLe+OIIYf+RgIeyw/lGOwSUxValGB4Wdvh4XeYIjB0cRYXiH4iOhstOz2ZM5ct3siSZIhJxnHG2F52YYRarDns18RwuemLoNSdkHi3yWSiLrdqK0w8zh/wVoCx6qpY+/bE79Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY4aNrpg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY4aNrpg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359991F000FF;
	Mon, 28 Sep 2026 08:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585963;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KY4aNrpglz+jVAW41++K2TFxEmxTPq//qVvvhcsO5uO2mikFaXxSw0ouCgxRyiPRs
	 1KEzae24Acnd1xZXZ83L6xJipldyPj7fp4Y6rE9yxi/cD/Sr5E0wk34bX25lOhd2rM
	 RLbB8OLpTGz4aZ25OGxdhQsBNFjIKT0Bf2UXN3JhcA/0ojkL80rGENzsSqhsqTaMnV
	 84ic2EloP0sF8y4LjgymrDOX9kFVa9lycnmcDiIvN7eKniwDss2YDgmbZvOgKVoyE8
	 hhFXOwKJBjOB0P5mXSlMYiGsEYV9x673PtbCdmcvqdz91lxQYk5rtOEl6T3JG1I03j
	 qwax+PFJptZaA==
From: netdev-bot+sinfo@kernel.org
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v7] net: wangxun: protect ring accesses with RCU
Date: Mon, 28 Sep 2026 08:59:22 +0000
Message-ID: <179058596274.31693.18129278862372982137@kernel.org>
In-Reply-To: <20260928085443.14595-1-mengyuanlou@net-swift.com>
References: <20260928085443.14595-1-mengyuanlou@net-swift.com>
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
