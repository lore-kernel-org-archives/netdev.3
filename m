Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9837E35B650
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 02:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006673; cv=none; b=QMXX62y0cPNFeun0dL2xu9oo1MEJUhPx6CIyxlW0JZesRiGwf4g3hxNLU1394ne0PG03KaC3jvPPdInT9j41X9x7qd1lnyQ+TnDviS2wp5CJwxDSv9HSXiXlD6ZgBpz0aA0+BNwaehjgi6iSnHMuH7ZEl0jYro7P47YeL2oAfzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006673; c=relaxed/simple;
	bh=FSPTeF6YpwGka/VfndWqWLPb7iw8vlbLg7lsLVERqjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZBmA6cwSbw+n8GvvYdgUwwkhuH1oJKynhIQ8SFMvskOuO35IYHSIyaZ8xNxNhtuDZ2CZ2Lhhp+FoY/3Ik1AcUBqD/eMa59t6Q/LRp/YpubVvZnQ/FLcUDrwp6G4pd2VJWiM3KkhJmPIjsGCSEwMIOiWc3jt3EWnF3WqYmVKtFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VszQ0OJQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VszQ0OJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2B31F000FF;
	Thu, 10 Sep 2026 02:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789006672;
	bh=KeW3yJNq62x3FjM9bcHvzuRWz/IqKmAEj2btBdyQqy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VszQ0OJQScsqZNX8AI1p/YUEP8xqowBLsIrY5wl5gi6C4fz6/Scg4z8PAJq+5FT1m
	 UGr2CsmgK3TxzMmMHQjqRXyLNYpSw8Eu/Xsb2jjLPj23wQy8auw+wMbkxyAcJ3MC4i
	 G428Xjv4fBewLFo+q3K3imoTDVZqEOBmLtI6CpHFfF07lZ6pBOorCipxgTUGTELBZw
	 z760Cv37h24w0Ddr1a4pw6A0/jVnjtOGpP9CeD23TDHMUGzis0mheBUPywBeatin26
	 prZCsJ1Bu5t6PVj386RL2bFrbi62F6NImi5i9aHOAIre/M/x0mnGex+V4WNRvPPbUp
	 OJhGu3rDF4alw==
Date: Wed, 9 Sep 2026 19:17:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Delalande <colona@arista.com>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org, Paul SAGE
 <paul.sage@42.fr>, Vincent MORVAN <vinc@42.fr>, Atharva Tiwari
 <atharvatiwarilinuxdev@gmail.com>
Subject: Re: [PATCH net] tg3: check NVRAM and control register if SRAM has
 the placeholder MAC address
Message-ID: <20260909191751.651aa5c4@kernel.org>
In-Reply-To: <20260903233255.GA4109366@visor>
References: <20260903233255.GA4109366@visor>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Sep 2026 16:32:55 -0700 Ivan Delalande wrote:
> Some of the tg3 NICs we use (BCM57762) reset the SRAM MAC address to the
> placeholder address on link flaps, tg3_chip_reset, etc. We've typically
> fixed it from userspace, but since e4c00ba7274b ("tg3: replace
> placeholder MAC address with device property") was merged, tg3 just
> fails probe as we don't have a way to get it through the generic
> device_get_mac_address infrastructure on our systems.
> 
> Since that commit effectively made the placeholder address invalid,
> include this check in the earlier `addr_ok` expression, so we proceed
> with the NVRAM and control register fallback to find a valid MAC.

If there are so many cases with known-broken MAC addresses with tg3
shouldnt we do something like:

--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17914,12 +17914,13 @@ static int tg3_init_one(struct pci_dev *pdev,
        }
 
        err = tg3_get_device_address(tp, addr);
-       if (err) {
-               dev_err(&pdev->dev,
-                       "Could not obtain valid ethernet address, aborting\n");
-               goto err_out_apeunmap;
+       if (!err) {
+               eth_hw_addr_set(dev, addr);
+       } else {
+               dev_warn(&pdev->dev,
+                        "Could not obtain valid ethernet address, using a random address\n");
+               eth_hw_addr_random(dev);
        }
-       eth_hw_addr_set(dev, addr);
 
        intmbx = MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW;
        rcvmbx = MAILBOX_RCVRET_CON_IDX_0 + TG3_64BIT_REG_LOW;

?
