Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3AB3E49FD;
	Tue, 21 Jul 2026 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650939; cv=none; b=NBUh54H59giNFltFIqctOkZTjj8Q1BfGSte6J4sZVES0T+ADVXn5HwvHz7ApIHlGCT/c0dvWEVJKjHU/RKkMmSpufOHXwkBlND+34m9rdDHffxSFJa1G7UuMJUKT3Hk7ajJ37BBCNE0PepWPqaI3GkuRLnM0EKclHlo9PrTsE88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650939; c=relaxed/simple;
	bh=tZlM9xoITwo6d/ycvQZPluLxohxsDwHrCRWFsPvB/BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlAquXl8aCmiTVP49qfcnFWV7uHqIBzyVdEQI3Zr5/VLKxw6zhrBo2Ry6UTCQXyhYJS9/bXhu9CFboHOL74FpdQZct7//wHssDB2U9SiNmXMO2TW/6puG3JzcdwslbxS4h86LoYrbS4BpnqXqA7+u1VRvrJX/owiI34sd8kK1eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKEEsCXr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKEEsCXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0F61F000E9;
	Tue, 21 Jul 2026 16:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784650938;
	bh=IUP2vpByc6slvuaYTg1pRPCbwIm5+tKmLmGfPYN9e4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jKEEsCXrO7nJhcHYo7YZuVArCHZY8VjiYLiTYYprZ+J+wzE2dJTAoD6ai9kaLIcSu
	 c9cXRR+ZBPxy1hgrA0jL1p2lac1dsEW6lcwFT64N63z7AZ1H0Ugw6H2+k5BRv5Zo/T
	 0DrMiPOlpuyv7nFjoegG/mg3qE9RGVgEq37go/1GAPuzHkK6c6OnsWNW7HMvIjo8+E
	 bt/hDPVatbHFgkJqOtbInL8B1TZbhV0ZxnTIRvIAZc0xP8giK2DjLMXs0NmF3ufoqq
	 MDSIVZIg1MRNzB/Cc8p5owifz2F+uUZU34bjCEuAIycyX+BgB+lsewn1dt7wHAFkaF
	 8WcOdaGuc9cdQ==
Date: Tue, 21 Jul 2026 09:22:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Andrew Lunn <andrew@lunn.ch>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 manuelebner@mailbox.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 net-next 3/9] net: usb: usbnet: add cdc_state to
 struct usbnet
Message-ID: <20260721092217.117e6ddf@kernel.org>
In-Reply-To: <ee6c537e-32e7-48a3-9037-49ef15ca7603@lunn.ch>
References: <20260714114429.1073434-1-oneukum@suse.com>
	<20260714114429.1073434-3-oneukum@suse.com>
	<ee6c537e-32e7-48a3-9037-49ef15ca7603@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 03:18:00 +0200 Andrew Lunn wrote:
> On Tue, Jul 14, 2026 at 01:44:23PM +0200, Oliver Neukum wrote:
> > This allows centralisation of code using cdc_state in usbnet, reducing
> > code duplication. No functional change intended.
> > 
> > Signed-off-by: Oliver Neukum <oneukum@suse.com>  
> 
> I gave a Reviewed-by to v2 of this patch. You are supposed to attach
> them here on the next version. b4 collect them and add them for you,
> if you use it.

Yes, please repost this with the missing tags and add a cover letter.
The basics :/
