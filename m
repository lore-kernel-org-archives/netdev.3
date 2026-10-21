Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597492;
	b=ldafFKvjwu1ANH+s1fz2CRbxBFbE3rmLqo1MtaF3YBiFkFK4sFmOOKZe6qBcfx2k0/z/
	 Gxj08GEqo/17Ux+vPj9duHGLqWyKZqsIrjmXfNY8l7KT0hmDUN9QBqWlnJBoB5AutSZmM
	 ZVd9Jhp4JsJJ1SsIfXk/PyhJt4cMx3+7TvGv2io26ZA+tKG4bRIlq1bDiO2rhu36/oKUe
	 ckFQ2oCuIlLvBa5zDPdaO6nuJ3QYpoXgwosPaGpR4FGySgRBDx4Qb5dqID7Qx5ENpP/Cv
	 /aZEZtXD5E/b1Tq4T5RBX8vzgrN18ohrSqy3rfjR8BOvD07mUkLB/5Us7PSebxx4WVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597492;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=oM2yV+a0OOkQNHpQEHPvv3mf4BJVEOuPGr5iox4wNL4=;
	b=NMUunNaucUyBEl8CUjVAFMI8+GviGpkyXbcdm3xdlfYnlMd3rpzdcoaS1f3hOu5a2SYj
	 u0A7ibjdjdvBMyfzVKdN8O0WjlFfL5ZrCNr/fVSshIHZuA6kz091gQzltT5l0tE+2xw4X
	 1oPGim5FfNnPioMfMOJtPJQFIdLDhUf5D6iFIeavyuwEhXtz3A30QBbWtY54IQzvM3/EB
	 TlMEO1IhhZ/yidOKWco2scW+28XJxvM71iAxn32YX4KVNWKVyn/vYCxCHhUDCaUYFNei5
	 aizIX3zHN2hRon51VPw3jlMwDQ4hxXhn33IMnAqSpSCuAZ4ZU9WPzIgbSYx2mfCSnzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=ritkwspo3bacretg3bfle5mol4.protonmail2 header.b="aRA/GnuZ";
	arc=none smtp.remote-ip=109.224.244.30
Received: from mail-24430.protonmail.ch (mail-24430.protonmail.ch [109.224.244.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9600606A32D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9600606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=ritkwspo3bacretg3bfle5mol4.protonmail2 header.b=aRA/GnuZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ritkwspo3bacretg3bfle5mol4.protonmail2; t=1792597489;
	x=1792856689; bh=oM2yV+a0OOkQNHpQEHPvv3mf4BJVEOuPGr5iox4wNL4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aRA/GnuZvP8HzYTxZFp/ItlVnFnDiRVWGKDsaEyweDrN9sOZXvq94CsLN7Q+f2C83
	 8Lx3vl91YEphSZOnIAUwR9kiCdApBVoNA8FOYMyvm/KUOd9lkFNt9EQfW6kgLEpdk2
	 dxyArZr2+KjlJgVOUxce8xdBNGCCObj+vjJr1CBtsrdTb2moJgFhCXtwaxZIVQNNFh
	 ucxh0N6cQ5N7TgIav6YjJiNCdJg934Dyb+kqKkEhEc8WDF91ylGislVgIOP4hfJaH2
	 o9g38AUVVLjUULmLh+WF4l604xR5qtlgb0h8VuODP7kM6uVbkA0oiMxn6H33JeczIp
	 1htY5DpQLN5dg==
Date: Wed, 21 Oct 2026 15:44:47 +0000
To: netdev-bot+sinfo@kernel.org
From: omniameasunt@proton.me
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "paul@paul-moore.com" <paul@paul-moore.com>
Subject: Re: [PATCH net] cipso_v4: fail the walk on malformed options
Message-ID: <BZyJJDcKn9wLfVaZVXbCOG_rf4_C23keHHVXnq2p8wQ6Ntw75EbXhOA1Zp2BB_UfVznQBp5FbWTu_sZSt53Qvdo2QKr7iyfOV9D62hk6pWU=@proton.me>
In-Reply-To: <179257559039.3290.8125763300787291489@kernel.org>
References: <CBLsHx48w8Bn1k_Xg6kJFliLNkxLCqi8SnkifapxYYpVtll4w-W_2JJePtbk9ssIS701IFJvi0Q2n5l-2GFFe8hNHU9Y_CgD_sdzcAbILVA=@proton.me> <179257559039.3290.8125763300787291489@kernel.org>
Feedback-ID: 219316618:user:proton
X-Pm-Message-ID: d2bba39bbc4e80c10dd6320b5262ce71412eead7
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Discovery: found with Clang static analysis using a custom checker, then ve=
rified against the affected code paths.

Triggered: yes. On an unmodified v7.3-rc6 kernel with CIPSO labeling config=
ured.

The information-disclosure impact was demonstrated, and on a build without =
stack protector the overflow was demonstrated to be exploitable.  The full =
analysis and a POC were sent privately to the security team and the maintai=
ner before this patch was posted here at the maintainer's request.



-------- Original Message --------
On Wednesday, 10/21/26 at 11:39 netdev-bot+sinfo@kernel.org wrote:
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

