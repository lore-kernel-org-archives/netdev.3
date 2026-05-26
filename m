Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44F235BDA8
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835872; cv=none; b=k64MhH0RLKM4poXr8KJHxASNF41KsW1hcTE6uKHRy8a+LvGsIigwLQh6iaZSx6ewD8W292c35NrrjCBJfZgsPDtJV8bwVzDviHP41OvTezHlafF4Zxhr5mBVh4xDnLgKoO1hfUEMufHBxk9nvBe0FmOe510Iq5qoYXGxJb9dJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835872; c=relaxed/simple;
	bh=kTckrI5AIVuupE4T+0EPADz7AJShSEDoR5a3xuhNcCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqCaE0K/f9AibIls561T2CyZZygUuAFheivGvNkCXA46vJDa/XBwKgNo4ZLhcR6gj9+Q2P9vI8XtC3uqkOIchE23sPWYRXvd71vjMB+wtX+T1+DcWew+chZ3AU+v8MM5g9NffYHjCOFF9Sp5k3Ue0HQmenEVb38/sU33vb30BQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2mfXveC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2mfXveC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E10A1F000E9;
	Tue, 26 May 2026 22:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779835871;
	bh=kTckrI5AIVuupE4T+0EPADz7AJShSEDoR5a3xuhNcCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Z2mfXveCUGrkw35sQrM8HbRBsvnTWR5banqqOAwkRFK5zCn1P8weaMe/bho85yQKH
	 XshDJES8ihHTr1D9u8CqnEmyDbSuwvbK5RNTnbWDnzps3dkgBE6HtUzX6VG0NWucRz
	 NjBnBNsYxsvxMCKSwAn9Xf8igjzPMsBN0/dhm60ZmW8pFF3+jIi9L9sGTLLBDkoc22
	 YdZz6XZNWwctcifiYki4zlIyMJ7B60b/ODqlo8PEvf7apV7QDOHFethCEpttEEpobR
	 B+B4u97ilqGwkiWPtuiOs7+B5urOzm4ZqfnSUUPiI3LUD3WzlHZReA9Fe/GEABhWlR
	 bbL04Kq/KzxcA==
Date: Tue, 26 May 2026 15:51:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 o.rempel@pengutronix.de, kory.maincent@bootlin.com, haiyangz@microsoft.com,
 andrew@lunn.ch, kees@kernel.org
Subject: Re: [PATCH net 06/10] ethtool: tsinfo: fix uninitialized stats on
 the by-PHC path
Message-ID: <20260526155110.77b86e0f@kernel.org>
In-Reply-To: <1716074a-e103-4d25-9f7c-167f755e002c@bootlin.com>
References: <20260526153533.2779187-1-kuba@kernel.org>
	<20260526153533.2779187-7-kuba@kernel.org>
	<1716074a-e103-4d25-9f7c-167f755e002c@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 19:23:22 +0200 Maxime Chevallier wrote:
> We may have per-provider stats one day, but for now I agree
> with this patch.

The fact we don't have stats in dumps (even without providers)
is even sadder :( But the fix would be too large & risky for
net. AFAICT this "never worked".
