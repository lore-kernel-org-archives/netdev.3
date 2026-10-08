Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B68A361DD5;
	Thu,  8 Oct 2026 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481166; cv=none; b=rqI913uYK3HozVzKymVDaYwDbe8xnq/NBnGa/tDXGBlLKBrbQwT2Cw/wXecIWbPalXr/4Yw2nbfrfCrvAEEF+4ACs2lx2QYojyxAxYxLloHmCGcnIRTLE/W1j6MD34O/fMyPMom2xKqTLKTMNjrdczOfY5hN/jV4kohBwbnx/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481166; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EOMg4+d8k809k6ON3Iq79/9ZTuXhBs684OMtpCx6Oz8y4BXgUzPdgkLazrj6xdRQTVjjvmK5euo86vKh4TS7/A/00Fb0WIBZxR8t3wFHN55QmNb+JsBSj7x5pg+wdHV7x+cwGDN9ODb0v1o42Q21uHnHbjg8XhNrONwuBW6kFxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5iLpbw6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5iLpbw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136D81F000FF;
	Thu,  8 Oct 2026 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791481165;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X5iLpbw6ZvPsVQcm1i9uR0IUH4lHs47JRJ+ZzUoEowb+hsrwsUKYAm5at+xwt0PWh
	 HsA8ibxrjSglGQRjC4UwaQLl675aRl50XrFx371LXCsBE2X7ppx1TNvfAt6iG5h75p
	 nalcZ2u835mwk7/muFfEaGpuCKbKnzptU9J10/Xf5qn+H7Hv/vbcqlQABjxKL822K8
	 kZNeiRziAltZGDBIxCbmdfbZqSATLBllsJGbIc5rKkAOyGWrcCcCfAH9mwkzZ86kPE
	 Z28ZgS71Lw86I2EDlnvi+QyaD3AVtj28M2t8nsPRVm3pa/DgSUbr2Q3KcHKJ6AKQVG
	 j4uR4MmFu0qqA==
From: netdev-bot+sinfo@kernel.org
To: Brian Vazquez <brianvv@google.com>
Cc: Brian Vazquez <brianvv.kernel@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>,
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>,
 Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>, linux-kernel@vger.kernel.org,
 David Decotigny <decot@google.com>, Li Li <boolli@google.com>,
 Emil Tantilov <emil.s.tantilov@intel.com>
Subject: Re: [iwl-net PATCH] idpf: wait for the reset completed state in
 idpf_check_reset_complete()
Date: Thu, 08 Oct 2026 17:39:23 +0000
Message-ID: <179148116354.2527009.2591065698849960120@kernel.org>
In-Reply-To: <20261008173334.2881475-1-brianvv@google.com>
References: <20261008173334.2881475-1-brianvv@google.com>
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
