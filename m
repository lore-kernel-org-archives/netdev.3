Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB663016F2
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 23:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778024885; cv=none; b=MXHI3RfSkGXTAToDRVKtKPgjmAVSGGgGFXdSak1SnKkiEgeoaw/b0cvHic9ev66zhv6zQuF+kO0BpMvBcKi3btsu1D8Vnndja+PsUrTt4qbHBLjtR/PqCYbulBj6NnqKsB8QRI929dDXHVT4D0JsA09Pfw8EuhXviRVJ42BvNUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778024885; c=relaxed/simple;
	bh=EDj42oTlUCfFy2Xun7dP6BWVobiofKeIRahiASYQY5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KoEsjFkkGVRyAomWPnqYgBhuyjbjrB+P6DiVL4bhvX6Y7FPHbWIgIVErhVGnSFn64pqNHQFtNC8fI+LbH0f7XiyRtwT0bIKyV2oETZBta0sY//5GPKTgW48L4tzizm3Y5gZz5MBeu7JAKGF8anfyMLZOp7n1CVOoF40OKfXZY64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZP2p/goD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZP2p/goD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6483AC2BCB4;
	Tue,  5 May 2026 23:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778024884;
	bh=EDj42oTlUCfFy2Xun7dP6BWVobiofKeIRahiASYQY5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZP2p/goDYD7ewtp1fQsxU/6bBhXZIXlRkgJg0+3u6S0ohZDY5G79CX+0QkPxjFpO5
	 CPtqxZqxfwwBdjbOIdcIx+k77O7HFBuOgjcMBj1Z7QnxWVvkvoBtYtZKmeg2n+22+n
	 QyDx8vSS9o7dMbEEXbV8MBzACKY95N57kzXbdKc+5FWE/B3rD+qHNzxBpX5CGTsygz
	 W9hIjMnfP2o2BUDecNhBU2c/qGK0m7UnyRCQsr1qC8bMC3we5PhnbhEd6/PnNJY2tK
	 EmX6I0fin+7YpoWDC89RzptkDq1OI3Vswy/BTBblZdWMUNCFlifSQ7yesCn0W+0tOA
	 yzkCUYJvE7QSw==
Date: Tue, 5 May 2026 16:48:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "qiang.zhao@nxp.com"
 <qiang.zhao@nxp.com>, "horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH net] net: wan: fsl_ucc_hdlc: fix indentation error
Message-ID: <20260505164803.73d87809@kernel.org>
In-Reply-To: <AM0PR06MB103966A8283FD757F6C9459A0F73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20260504160734.2217382-1-holger.brunck@hitachienergy.com>
	<e3abfd12-6537-42b1-b35e-c79a06f87172@kernel.org>
	<AM0PR06MB103966A8283FD757F6C9459A0F73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 08:16:01 +0000 Holger Brunck wrote:
> no not mandatory needed. I just saw that and thought that also such minor issues
> should be fixed. Can be abandoned.

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
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
