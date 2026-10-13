Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A393F5172DA;
	Tue, 13 Oct 2026 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897605; cv=none; b=Ne2lN7KZOljBTWKuk6ouK0C+Zy/gpm4wIPbbBg34r5i72zrQcSo6WtB91GUMWNDo7+nHDNI0UfUWLjbtOYtoMwhJ0KY5Qb2LjGCsr2lfyC7uieH5NdGfApFiA1y16VJIongFQYvLD0DJtvRfxudKTgz204YkbwErJVaxIk8g/60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897605; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MkNdVQaGPnAT+LkOn4EV8309qCLENXG8heRShX7hTlCORgfosipSEJq7VM0ZYy/yy5fOx2WVxMG3tJOfzUNoyE11wluPr4Q/9NCFbA7jNoFaZSqvbtHLy5XCm63eZr/ighJISANJBLZ91MxFP+5gb9Lpsa+U1mItxtnr43SOpSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/BKqfjs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/BKqfjs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E48D1F0089A;
	Tue, 13 Oct 2026 13:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897604;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P/BKqfjsiA8a0eXO9BAa2eISYrcTKkBDGD4RRIV9X3t+34V3dmtTa+dZRpE1ICBWT
	 pdDosVVDh5prt2yIi6Luodhgg3e4UwLEplC3qPBjRfxENKrY8HR793E/EXu2rrTewV
	 qWizS5XvM2lO9lLzFhbcm8/ZIQyBup+nWCuOmjti6Wd4QjNrwMPelb4eervqkiy+Dr
	 ZR1GL/Ju95hiUw3mHgTn5eHW0K7t6+M2tE5kWu+7j1NKTgbEr5Z98hVD8667ddtxHN
	 ED0M+9tpnmSFQxrlzCeTkRzXs+3Y6LKVSAEKN/sGYfm9BGDmIhhPkulJhY6yeRgAe6
	 UG9CltShdOF1w==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paolo Valerio <pvalerio@redhat.com>,
 Nicolai Buchwitz <nb@tipi-net.de>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 =?utf-8?q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable+noautosel@kernel.org,
 Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v11 0/9] net: macb: implement context swapping
Date: Tue, 13 Oct 2026 13:20:03 +0000
Message-ID: <179189760303.2527009.1878014132075349485@kernel.org>
In-Reply-To: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
References: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
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
