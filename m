Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D18459AEB;
	Fri,  9 Oct 2026 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574185; cv=none; b=tEjvtDOLpFuXBw4jLvRYSN/L+GM7RILGDK8dhV5v2/MT7TBBlaId2ZaKDKCcja3BN5dlF6m6E61OHAG4ZX3un1x4Pd41h/HQNx5wH3jOPcvrVAgDNd0seXfaK0pcw6x3WhFgLqIgRzq1EujFD9P1AJChTLeN+6PJRKJ8BCUPxRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574185; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uZ5ORj+GvcgUb/sv3JM2qVjWoy6/z0Tww9RGk7nZQeq3vAqsmWKzFWS5D3Cds+g5S3aQ0uBAw4xgI3dDxt2DH/uWrLFCvK42crnyQ/QK4IMUxdpMXOzeOoiPp9cPorg2v0RCz0UISm79HKnh+lw3UY+gdW9leMg1zTsJ9RTY5js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfm3QR7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfm3QR7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A030F1F00893;
	Fri,  9 Oct 2026 19:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791574181;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hfm3QR7nr/kyutavbC0RvqoybYkrayQMpOi8K2j+oNRIPG4f97WQDdk0hnAg8k/XX
	 ZaYJmOBi1ZcmX5QkxqOkmTGNT8l1r/BMQI37jhYGl7uhf4py6PlE5UlOzZUSMn4iK0
	 IP7xa0+d4nRGlP2BtbdSLGpA8TNSO/EZSwFEm9fpepgC0m9lvDsH3UKikUZKP6sKrC
	 6EC7heZdL39XQwTcFifL6WmnC2filAWISU4GXDtbYxkySVWgFeqK6Twc3u/emnJAj+
	 lB5nNqe8L/BdRqgoXkJlUF1vbXHaT0ZqAhV7H+IYFXOBaJ2xCLuQpSSEaX7vcA1/Mz
	 aMON2lQhkitHQ==
From: netdev-bot+sinfo@kernel.org
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Min Li <min.li@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 0/5] dpll: zl3073x: fix output pin frequency, esync
 and sibling notifications
Date: Fri, 09 Oct 2026 19:29:40 +0000
Message-ID: <179157418006.2527009.17611047003604538652@kernel.org>
In-Reply-To: <20261009192556.272263-1-ivecera@redhat.com>
References: <20261009192556.272263-1-ivecera@redhat.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
