Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100119;
	b=koX0gx9PnnYfaSnQ0JXQaUXQcy1qror9Qxlj5pA7B72gNOfAB49EBcKy/hFLK1cgaWk0
	 hY1FOpZ4DethLaqT9e7bjWNa4KqjIx+T9q9LAeaSDtuHkfSCHzOmDM/UlMzt2feczW0K8
	 bn4fRii7XC0mdbzWbk2QDrLPinD4e8R1YIlwSAAlU/bU3nd6BycxGUAPgN9+i9R0H9LKz
	 Gfoj8RHD3EbyDxmyEM1uDGABiINPzlI+q1/G55LUFSCC8N1dx9D+R37Zs4zPhKrsKTOP/
	 7Wy4Gt1AicMtNmhNWVIo2HTewujMzk1NlC3qrbyrl3/uj5/aMeWSRwZdEV2fWKGqYaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100119;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=k6n++7vxihuX97m/TrwWxL8ii4IqqnlyiXstDksruYhJ4dWcLAZ1I/NJs8gsjnnKjvuZ
	 4YfMLGjNOqFUi7c0c3LtfG9fBm+r6z5UmwG9Jdt2EtQZgpK4lhsG48RrpMMB0j7vtNCch
	 DWAdt5htjhNoQAnE+YYgt79JRifbXRpYN0o4OILljqahuWuXHZHzNpOhL8eryF2D1WHb+
	 cB9qO/cKY5l3PwAPL7zYZht+CBhoO0OYsj7x8vVM92Nm72V3FRFOIC8VTGJyaBiW5XOvj
	 DfvRimtMOdqx01hqek/aL2W7PUI3mTWrEN689WL6zORc4yVniEFwoTHbm8OQQ/XdQMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMvFy3AF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE601606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMvFy3AF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F5E1F01825;
	Tue, 27 Oct 2026 11:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793100118;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dMvFy3AFzvBY61kZR+AbAX/8d5oAh66Y31HWfNglSoQeLS0GlDlghCjxZnS5470rf
	 kbJcqSNErwIfXQnqGJX7cGpTUm5QV/tvh3y4TdUUuEwBB+kFyBW6ZOL23lkdhCWwbr
	 qF9ryyp2S/umcmOfsVskqcZI4TEs1UgZhFbRdALni6jFfDP3QWG32V9+tPklCHdabJ
	 WCaZVMV1/wbHDcm2iXlTMEtBUm1iRFb4CHeRK9QM9/rV70u49pcfiMUVjqdKNm2IEM
	 95Z5znsqQ5060asysNcR6p4MQLwUQwQ/aZkF+ea1eUosbsS152ibAiZ8UjtUiVZ1yD
	 B2040VEAn4v6A==
From: netdev-bot+sinfo@kernel.org
To: omniameasunt@proton.me
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH net v2] cipso_v4: fail the walk on malformed options
Date: Tue, 27 Oct 2026 11:21:57 +0000
Message-ID: <179310011789.3327.203052664637708827@kernel.org>
In-Reply-To: =?utf-8?q?=3CuOcTaW7-g5e97ng6BG=5FDcH5mlMnpw7KzU25SZjL69pkAVINT?=
 =?utf-8?q?MiL26FryLAuYPSNowDo8qwfb9hm=5FI4dQ1BwpiRe62E-I2TyUkJZ=5FeBeuLoo?=
 =?utf-8?q?=3D=40proton=2Eme=3E?=
References: =?utf-8?q?=3CuOcTaW7-g5e97ng6BG=5FDcH5mlMnpw7KzU25SZjL69pkAVINTM?=
 =?utf-8?q?iL26FryLAuYPSNowDo8qwfb9hm=5FI4dQ1BwpiRe62E-I2TyUkJZ=5FeBeuLoo=3D?=
 =?utf-8?q?=40proton=2Eme=3E?=
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
