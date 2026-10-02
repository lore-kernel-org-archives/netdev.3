Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AF24BD7A8;
	Fri,  2 Oct 2026 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950444; cv=none; b=JP1AgGA8bvftJst5jHqMnK8FNf1Y4p16Lpn9Cr8HdIrT51SaWFRnRpMXga8OKBZL+CllJ/pRbmOPGK79v0ZzwMExFP4Q9Gbud/EgyDtiwd8w4wivmkV5w9Us2/yH9HhMwIuSKzIMOBShB5BO98BowPmBXWSdF2zv902KgBEUtw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950444; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fRui5kaF9lRPjpIeeVZJNxivKcdqm6QN0vTLlH2A/LIkpj6M/bQay9t8hFMEhYQO+FW0YlhJ5+szVNow9dx/gTKas0pfwKFsX6woQ1FKUSl5mHTF1dYMhz+7yuezomSO+Ai6jnhKkZ13o5XaCxruTLF4FPToUK6gLE72NeWhNaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jp1EUAsd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jp1EUAsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B161F000FF;
	Fri,  2 Oct 2026 14:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950441;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jp1EUAsdO8biJ4YG7pYZFD/zXbBzbw/wLRVr4papPGmFtoIxi/pnTXLA+Mqj5uafF
	 1V3TaCr9NWCgeb39eUWgNrhsjKG+5y/FAOXwyu4tTeZQ8I4M1jwzKEvv0UfZKzvCHf
	 FD2NV7xQPvhBkoOKCFvRfUSacuVlacjdvqF3VoZgEp1g4h9jRS8F45TYt0wzd2mCZG
	 ApnUE8iJvyHrNdw1uh6sNIwkivZJI0fEhg91z6t3GZ3zFPfnObxg/fhgCGa0L7gIg3
	 fKjkbhSmMMchwqQ2ObfJDxVnnX6Y4OZ9W2iaZQ+rUxQQl9XMx+sEr+fPA72/VE7Lwg
	 1sle8FV+qvmQQ==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?b?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lgg?=
 =?utf-8?b?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Michael Grzeschik <mgr@kernel.org>, Jijie Shao <shaojijie@huawei.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Denis Benato <benato.denis96@gmail.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig_?=
 =?utf-8?q?=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net v2 0/3] net: fealnx: fix card-index overflow and PCI
 device teardown
Date: Fri, 02 Oct 2026 14:13:59 +0000
Message-ID: <179095043961.1402591.2720135629640976917@kernel.org>
In-Reply-To: <20261002140954.261779-1-r.zhambakiev@prosoftsystems.ru>
References: <20261002140954.261779-1-r.zhambakiev@prosoftsystems.ru>
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
