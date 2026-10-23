Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788301;
	b=RT+Vbproq+0rTNEtNOY3kH9/cXFx9cQYsIjhJ4abRmnsRfUOy1OWQ9v63E3oCKjC7cND
	 WDpzlf6DsOJJoTOma1YeuCvJjHvPUNT0maDvpkstUKehQeVo0F0sP1imT4+/DRLJjAdKG
	 Z7SHj7680DXOX071BtAzJq56wQTQT2WzAICcRFS+XQoDghFiOxXtpbxZpXYEzsr2mOD1+
	 42lSP5wYTvbJFt2Ss9z05vBgksBHz6ZffUzWhwQCxAU83b0DkVbVJu+EVN1+X+HxRBIZE
	 gDEqbdUztsViE3E+0xaLCpCPAvFWj+yvdncpsIjYY10UpsW4Ysb0k4+tLsASn++IDwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788301;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=pBgUYyfyHagwR3lFCt4EA2b/VFxEf+mmUVQ3yBrw0dYKCVUU7lVdiZs6VJ+YJGRcsEXi
	 0L4t4OnmLmkzZ9FzP6ZflmwDq0kr+P9BUVclreW3/SiqzV47L+g/+rQmRvOknqfAWvz6u
	 ybp8sJa0h7XUqINXStwBpXzIpPg1b93LHm4hloZbZcmNaxIdI4+fivyy32f9g5QxX3PiR
	 G9BIByDX+pgANPwv6ugqeQthlgVmVO7Uh4DOauWqE5QCdDguUvQOmG6bFprkZS4jVB+De
	 awu+S+1Up1yB+0fkTOKRD9zOuOnq7uROlV1k87pGaFlAxQ0WXAQYHZkRBJJJS12OFdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RjXEV0lj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B17606A322
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RjXEV0lj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAA91F031E4;
	Fri, 23 Oct 2026 20:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792788300;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RjXEV0ljWE4HVW3geglnBboEQXvr7D038HYyQNZTaTL4lDaZEP+fRZF+6KQOewOh/
	 LqiTKdal6nCnzgH7DhmXWLPoNpTNCqHPLNJGqJIV8bmqKzTPP8OyQOUyuQHgQfYF4T
	 iYFwy6hxTPgJyfDceNIfNBykL8L/qY2ATNxfYYCos4engxq0n9pjJityfTvKjLioHq
	 Bi87NGNv7WUrK889LH1VNtyjEIwTkvWdwfa2O924v4ffM3hfJ4w1cutCuZ2HDLpLAp
	 /FreXazasFkSswlYEulmZdPlE/sQ/300eEhQDB3s+tgfH8AEivn0axpiInktJOYA6u
	 Xk3QsYuVyHrmg==
From: netdev-bot+sinfo@kernel.org
To: memoriaru@foxmail.com
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, andrew@lunn.ch,
 olteanv@gmail.com, johan@kernel.org, kuba@kernel.org
Subject: Re: [PATCH net v2 0/2] net: dsa: mxl862xx: bound FDB dump walk and
 validate BRIDGE_ALLOC ids
Date: Fri, 23 Oct 2026 20:44:59 +0000
Message-ID: <179278829990.3327.14694215720214654641@kernel.org>
In-Reply-To: <tencent_6030CC520C02054D1B2925AEEF6FA92DC30A@qq.com>
References: <tencent_6030CC520C02054D1B2925AEEF6FA92DC30A@qq.com>
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
