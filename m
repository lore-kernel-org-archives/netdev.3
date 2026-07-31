Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E55230C148;
	Fri, 31 Jul 2026 02:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464591; cv=none; b=cbm4vW40H0jlox4QTEjiBdOwM6TWYFF2RO4mu83B8gx/UcWCUDZMyP2Nyk8lP1ZUBJSSHFGd3JDFywWls63v8JT2Vuqa3CWk8k+/kdP0iDFLZrdR3+GIE/1VZ5lJO649YSM3uLA6DVmKjKk7vgt1ja+DCEer2NrcoAci591TjOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464591; c=relaxed/simple;
	bh=9OpfSgKDXfFLBBTn+fn+HkUgN0cjG2mJoYHWEoPNQ9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvO1Oka/H2Ds1wK+cgCcvev0y9gr9Ent3vtnqBarKhsP13UR+LfgN4cAdNP86F5lCeL0MwWOZWaiZghrbldLE0Hv1yVkJcHTOH0xklhun1puQ3nGZ6xxmaBpWCPMDDr8VAJ1IHQPhnRHPXKIW517lOvHZFHVi6HBZ55XteFPzbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSUCSv7B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSUCSv7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BC61F000E9;
	Fri, 31 Jul 2026 02:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785464589;
	bh=9OpfSgKDXfFLBBTn+fn+HkUgN0cjG2mJoYHWEoPNQ9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iSUCSv7BRcQ1ba8tPOdHrFfc8vpfc30XDPZjk+3PfP8ucapwFwCMiFjmPtWjxouhY
	 nCyxCQKDoXHLOa8bIEWCJ4MDvKR+rcnEhNq4mkAeaZ9qyOSxTlwlgArWYXTJQa6ooL
	 pRxdJJ91hqAGXsCNH1eBfgGCD5RwiJLTj1KOcZdq4QzA3hC96pStUYrkgQjlcZOGJf
	 RW5OUpHK/Rl8HSjT3bg+h2w2SSHFz8wnru9XRBWZGNh/c3sD6Em+QXWTo8x1LSNVOI
	 wMTOKpsJ8AOEK0PbgPMbT/gsxY4VqXjAdEMJcg6tmNVX8pHOJumUcxdAO19UKC7GBC
	 E8r/QV7FCJPDQ==
Date: Thu, 30 Jul 2026 19:23:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, Pascal Eberhard
 <pascal.eberhard@se.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 08/10] net: dsa: microchip: add KSZ8463 tail
 tag handling
Message-ID: <20260730192308.6ae496ad@kernel.org>
In-Reply-To: <20260727-ksz-new-ptp-v3-8-caba39e680e3@bootlin.com>
References: <20260727-ksz-new-ptp-v3-0-caba39e680e3@bootlin.com>
	<20260727-ksz-new-ptp-v3-8-caba39e680e3@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 12:20:50 +0200 Bastien Curutchet (Schneider
Electric) wrote:
> KSZ8463 uses the KSZ9893 DSA TAG driver. However, the KSZ8463 doesn't
> use the tail tag to convey timestamps to the host as KSZ9893 does. It
> uses the reserved fields in the PTP header instead.

Sigh, some of the marvell switches seem to be doing the same thing.
Is this the _only_ option this switch supports?

Reserved fields in protocols are generally reserved, not free to use.
