Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575591;
	b=dWwYsblJowJz9O2tNuLzhi5hZ97W62VL8MWMwtDPWhIKQfGKObx5eGjY5Kj64f5Mn4/P
	 n766phaq0whtoWuvDf1vkgh9AwlzsWPywe0m2ms0tyQJiN1WgyVhMC1aMw6Nv5xXpfWmm
	 tqklnnFeidIs8+xnj78WPks1dVo4IKgBoXRjsj7qKr5I4ZrCWy81hlva+GxZkcklxVt8Z
	 0Fwqw20n24M4hqLhqAD3JODdhR+vNyrjrB7Cj3Sd71T0esJDpEkPeoPWJVMkdEaBU4g+w
	 Eooq2qa+8L7y1zwzrEAg+3UNNm63fE3XHSqlx2KmCN4uxijhnc2FyWGsuGOI5HSljDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575591;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=uuS2ykJ1nVPnBloFEj8eEJ0b4QMK9/GH+CKipAns0Cu7oYFo+zgiMRg5LHIjeKatbLhK
	 epJq6JVpbvuQzR4QoNXI2BhYL1CuwqMcY430J6zVebVq/QpDJKiVBp9MmEVGZVQa8Wuwb
	 JIPEYGMAuFEgo4MVxMlRsoDcE+wqxFCj8csB8hm1wrK4/dImvk+/DN5dLjRVD6X4TO/Oz
	 MPO9XuCQXla0wPuk3QZfIuot7rteLlDsaFG8jGxv1BqX1xlp5EsqsbJmiN55/gJ0Pwuui
	 J4/lnlkJmp7lmkiynDj5Cj3ufCsEWALvPDMPQCRxYrdp1ZGj4FpGkcFaGKU7Bzff3lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MJ/MD8v7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB79606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MJ/MD8v7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F3A1F000C9;
	Wed, 21 Oct 2026 09:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792575591;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MJ/MD8v7rF03BcXw+Je5zHGw3rlsGN7b4276eC+mj8eC6celLzxmD2RbBR0VYgUbf
	 wmrjlnichiGIYKSAOXrZfsmkjZPLGsv0kfNX0ppjw8PSf+pieg1uHTnII2mLvaFjW1
	 v9NKlLa5YU8g6hyonUqQSiO9H5oxhF0vblDyhykHBEo7F3ASfdS4tpZL5MaIG3/cLm
	 beGHx/+ZbI6tGsAebPkMIZhOGpfYyr29PmTtf6f1cgSLh1+OjsCOuwAcTkzOEyUbZx
	 +mCeuVfDaQc3f/WROEn8QUNN5EEsDiG9yH9LZNnQxIwf7g6nVy1uJSB2Y2IA1hohV+
	 uRuHVdCSuMmBA==
From: netdev-bot+sinfo@kernel.org
To: omniameasunt@proton.me
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "paul@paul-moore.com" <paul@paul-moore.com>
Subject: Re: [PATCH net] cipso_v4: fail the walk on malformed options
Date: Wed, 21 Oct 2026 09:39:50 +0000
Message-ID: <179257559039.3290.8125763300787291489@kernel.org>
In-Reply-To: =?utf-8?q?=3CCBLsHx48w8Bn1k=5FXg6kJFliLNkxLCqi8SnkifapxYYpVtll4?=
 =?utf-8?q?w-W=5F2JJePtbk9ssIS701IFJvi0Q2n5l-2GFFe8hNHU9Y=5FCgD=5FsdzcAbILVA?=
 =?utf-8?q?=3D=40proton=2Eme=3E?=
References: =?utf-8?q?=3CCBLsHx48w8Bn1k=5FXg6kJFliLNkxLCqi8SnkifapxYYpVtll4w?=
 =?utf-8?q?-W=5F2JJePtbk9ssIS701IFJvi0Q2n5l-2GFFe8hNHU9Y=5FCgD=5FsdzcAbILVA?=
 =?utf-8?q?=3D=40proton=2Eme=3E?=
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
