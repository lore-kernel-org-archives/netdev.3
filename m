Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792452835;
	b=SCaNSsehsizG1CE8MKPshiMEHjNu4sANBkqnXvPq7qVEhSDyhMKKDf3WMPBwwwFwtNKp
	 Hqmup7wUDUbpI95qgmXL2aMAOBPoIXupa2j1KqhnskOJldHnIh64SdB0/idxUTBhafjpk
	 nPuaCdM0drqyErYC6I7GYv7s2qIWOiFilz+9JbkBKU15i0WXJHphnAHM54yXp23LsL9EF
	 DifI+LL0d7M4IPGs6FaBdraDcjefpIMPE9INglk2hEImVPvL7gi66PmBYjG7qe9/AOBg6
	 wyPL6h3TGI/FwnxW+9DHfxEUgikNVI/DWjOlsRhmmWG4lqCmbd0OTN+KPN1we7NGL3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792452835;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=kr1VxcRPSb4v3kmBbYNjaRaV231/cRyAJ0K96Waao7ltcBXhiv+j+mOIpiJQ9mAWjYDB
	 Y+9vNLt8ep4ShT5bPfmyoMbUE7iczeQZ4b2DogYPaavVchRCqH6WRaTGixdHzfLtTETcC
	 hD6LRzcv/qBmmUJrK0kMsAlvCMWp/aYnd8AvIFbPVzXKW/ydb9dopXaDV3Aje79bVuYmw
	 x7d5PZpU3uo1f/QvE/IaviBav+mwfVK9jz82WSyZFOU3rub2+wKNXUNHCwFyV5nKOD2UY
	 uEdph+m5iYM2d+MW0EQt40J/YyrzHfL/Ii0HTycz7oWeBAS99kMykru8xmZevSMpL7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PDJcSZRn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8654606A319
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PDJcSZRn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23ED91F000C4;
	Mon, 19 Oct 2026 23:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792452834;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PDJcSZRn7jEFWnUw36em6lY/GkBfij+VOLXsGijOMegfizRjp4HIfX41RDQmy/Amz
	 bJIMnRbjHJUj3+TRgMQtXIAMhHUFpJ51uc3RD+EWrONz//h1Fszy8qx5+qKk2h3VUQ
	 1AifiyWK/z/tYIgwq4PadJPqQlY9Dd4O6d3A8MdCqPrGUhe4mn532gXxDliz+b5BzH
	 L4AN8AAo6K+FvIEH0l3UulR2CmHEeVCn0uTiQZX1RWOqjG5q9S/waWMWkxqMhUhxL4
	 8ALznWM6kUvQ/QYG3hwvjpHI28CVZOnzbkWM7JAWppVemBTtpGQf334J+ieJhoojCs
	 WaVOWjqnkkCIw==
From: netdev-bot+sinfo@kernel.org
To: Myeonghun Pak <mhun512@gmail.com>
Cc: netdev@vger.kernel.org, Jijie Shao <shaojijie@huawei.com>,
 Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH net v2] net: hns: stop service work before device resource
 teardown
Date: Mon, 19 Oct 2026 23:33:53 +0000
Message-ID: <179245283362.3290.7754308334858165605@kernel.org>
In-Reply-To: <20261019233213.792821-1-mhun512@gmail.com>
References: <20261019233213.792821-1-mhun512@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
