Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0001837A48D;
	Sat,  3 Oct 2026 03:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790999688; cv=none; b=u8oXEW5MC3KUo/SiTg2vIxY3uWRVbzaPSpcBr03lnZalx7rEM27LiVu1mPFcYbI1cKnAdQxrB19V66nBD0E+lcblwcanIonBoEc7I/YcQJuvOlj6SKbUpceCSrszPBZ7zTh6RsHAl61dCcRM68FAjHcDOVJ2qX/Vqx/WJbyaV6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790999688; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CCPinupG0eamQh9Ln1Tg6itM0fyXPLIIeVznGIrOJf3FaPno9B1xi4IABdg9I8PDqsdRkqX8VKmUqgXBPGaSj/9xv3oxjoSP2ekNayvuZJz8z/3xhaIByDDOOy2SXwDedVr49eD9N3FwSZUdA+39uL2LWCWpjYAEAgBEVwdfsrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfLNSN96; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfLNSN96"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DAD1F000FF;
	Sat,  3 Oct 2026 03:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790999686;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MfLNSN9646JBntfpFbtDbAwW1OqxG5JrLh7+S8Rn3fm5eDjyT6ebDfl7c8lkOX6kO
	 zo9seNvpe2YNLdicSGy+2ZGiewAxBbWnVIDzmV1x9E/VI0HbeQF548ECoHMNIuaHlH
	 QEfH8h/lU3dSTVmZPqfkX6HvIcSSKX4paSjGktS9Rz811fymVGipfxVIEx94QJF+sQ
	 AwdHf3+Lwi/3S19MIQx2b17XHfTCZdEemIbArnpxe2LnGtzU91H4jrnKtMQvh/lYbd
	 fSKGN9KH17KrUIVHz/B91+LX/EW57vQdiQ7f4Rr97Qw/QBhGofFE4bcH4PA4AWOa5e
	 XavlnnCQ4lLDw==
From: netdev-bot+sinfo@kernel.org
To: Yunpeng Tian <shionthanatos@gmail.com>
Cc: tung.quang.nguyen@est.tech, jmaloy@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, gmwgg05@gmail.com, npczmd@qq.com,
 xiao-yu.zhou@connect.polyu.hk, jupmouse@gmail.com
Subject: Re: [PATCH net] tipc: bound the device MTU accepted for L2 bearers
Date: Sat, 03 Oct 2026 03:54:45 +0000
Message-ID: <179099968522.1402591.5978892815188951351@kernel.org>
In-Reply-To: <20261003035018.397-1-shionthanatos@gmail.com>
References: <20261003035018.397-1-shionthanatos@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
