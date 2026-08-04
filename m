Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096B8456E0C;
	Tue,  4 Aug 2026 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887856; cv=none; b=BhUOuEoyUBE1gVwOe1hpWYxmejlVKu+zgVTgxAd0tMM42JsuPPYsj6Eatx66mtq4SONCLmJFU3VTUpJs3rrgBhu8uZiaPINa0IOPgJSU8h7wuzZg7tycR2qXGy2v36NstMrLCPX3B88bhE7BPhq452vVIWSzp4QomdxlV/ZaudQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887856; c=relaxed/simple;
	bh=CKuHYnwpi0ntaWrbGRDQGihLqlFlhpvn5Wv0pJw4KfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=persDN8W+2hLV/l2PNAcpylOjBQue17iK67c4fpnT0gh2cfXrU7GlGxj/J2UqtIylAYDdybVrFtedjU1nuEeYtZWmJATFSMCf647FILQFQwSL0vLM0fszrD03hP/vTa4CSdmQkbcyAO06fMwcR2b5dShdnUOefQilmuvpiTHMps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGchpnIK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGchpnIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1431F00A3D;
	Tue,  4 Aug 2026 23:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785887854;
	bh=DZt+vYWwEPfXxOxcDmA36kVPqcPdkWfGtjEU95wl/D4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MGchpnIKXPEMwDlxwerSIhhIoVsLEVgUb7r13U1y0YwLrQDxLc8eu57Py3+0gjvUu
	 qjD8ZABVxG6ILceaUP2Yujllp9wzrbyxjp+o6/slr6WdP72eVyQNwQg1ssxlMQMioN
	 QazwA7p7iLgruOG/UAgrQ4do3Sr1+SCj46VGiDgLArZO3SSz1tCsUBbCKgyM/2zqDH
	 ft073nuACw2Wv17X8ZxK8cynAnQz1RmhXs2VrGgEMeJp8mxmJre2MMxLAH+4QEQSXJ
	 NZ5nTlMCdh8bLkqcucR3qTM5cNWzZj/7j+zcRYYrO68KuRco153N5i9/J2N8sE5DzP
	 Z+Nu5WKoaSRzQ==
Date: Tue, 4 Aug 2026 16:57:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: oshada imalka <developerimalka@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: eql.c: fix switch case indent
Message-ID: <20260804165733.5423e7c2@kernel.org>
In-Reply-To: <20260731122501.10591-1-developerimalka@gmail.com>
References: <20260731122501.10591-1-developerimalka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 17:55:01 +0530 oshada imalka wrote:
> Fix ERROR: switch and case should be at the same indent

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl``, and other trivial coding style warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
    
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
