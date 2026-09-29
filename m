Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9484483B4
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710154; cv=none; b=Gg51YTKsTya9hDjtD9jRiaH6I5zQ+s9xlfUmMiFvZMNzoY6772z8MF/1zftW7O3eaW+wWW+C+f9ZTBxAb2fCamW77SIHBRyhLzzRE3vRKciI3zT37B7c75vEMPCRxjWErohD0kGDeUoFQgp3qKJ2i/ci4CGidamdLSWTPdOofd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710154; c=relaxed/simple;
	bh=f6EkHzolGy8GYPjeII04sc8oTncaFwHLWXs9LkHKYfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kyxdTiPwsm4sxeVGoNZi2HfiIMD/zNAIwjFk76LWf44KQG7UuLsSSI/JKfDb9N6LWhjKRJsFDxAH81cj5eN5bOnHSFMtRCQ9c/9IwilJv5wGqkVJmFhaIvxmdYo17hb7yZfOqt9zs9oIw1amfxsMufn/mVZUbYtZ2qtn1DF8GqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0/3+kK+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0/3+kK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7896F1F000FF;
	Tue, 29 Sep 2026 19:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710153;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R0/3+kK+/M+Oe4JiE0W5piMdXNrAvqZ5NWEkS07FXRX1p9hrPSeB/5mNZZ/Mw0O83
	 Bq4oIFTxsjaafWjToMFIhxRCOsKT/VedHRTXyx//X3UkNYPS5vG+/QNQFnievqyrsf
	 X8yoPEV3x6oBdazGJxgb+L+zbIWv08rix5uoTpuhK3l3eJEtX/BEQmr8cKhE6DsxY0
	 VUrHNB0mvP+F6U6GWuR3PzUeOKPGYN9MwTACRHtO2fxtzWxEpoVWIr10jcurPCvKIy
	 QtwYN1j08hpV/6NU1NAXXLpLlwbR9FoKZavJWMzFDlNVCT9+jj6OakStVv60RdfW/R
	 qt943SXttqaHQ==
From: netdev-bot+sinfo@kernel.org
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, nb@tipi-net.de,
 florian.fainelli@broadcom.com, opendmb@gmail.com
Subject: Re: [PATCH net] net: bcmgenet: if UMAC was suspended in SW_RESET,
 restore it to SW_RESET
Date: Tue, 29 Sep 2026 19:29:12 +0000
Message-ID: <179071015201.31693.5594548931548792678@kernel.org>
In-Reply-To: <20260929192216.1490017-1-justin.chen@broadcom.com>
References: <20260929192216.1490017-1-justin.chen@broadcom.com>
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
