Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A9D409605
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539972; cv=none; b=RHtBa6nbtJpShTUn12rpcSYEmbvvutnczlBvNFStVg6HdXJlNjUyY+1bRDDvzPzM770i4yhVTiQucvQasXdOS1nhCnryQKeU+mMSzaeC9gG6rf0C3yHTtp/bcW4en4shx8nNSUaif+qqWAG0mQkms6mRzbQcKsbALxdX1eSc0eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539972; c=relaxed/simple;
	bh=YwZ+kCVyK2xSqpBm8pp4/Zv0vA+BZUfc8cwMrJdw8yw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKLmva+IjpK2SB1lxwFVpc+NVpNYGLpCAg5HSO1IRD/C74mlKDhfX2aOtq8ciMHbGDw3kmNYQw/OQqHS1PGRqKzdpoRF4aXpRqGdNEf12v3kNKxvMR0UQeN1dodWZiE+Qy3/KFDiHH9AcB4fanV0DfZVCqQF8UMgmXftUgM8j50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUvqjTjP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUvqjTjP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F371F00A3A;
	Mon, 15 Jun 2026 16:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781539971;
	bh=h4STy60C+UcS7ZfXKqBKqFZyV+JKFtqK+XBVbAB2TWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QUvqjTjP1bP3e/FYo57hpGVahgCrXsiyhTKY4kBX60Io+lpRQZP+CbuNGWJxziJ7W
	 fev7soXeIfwMesN1WyI7oZ0ztwQNKQ3HlJWt7Rcpa0fru7/stFznTPvrcz5KbU/tHZ
	 Ellwl+wDYfSbzdtnReHwr93XoXv+xxWCblpAcBYZI+CluLLgFndBdAT3NKdP6v1oyV
	 gZbT9YMyyhd1t0rvEadzKv+alm2ABRN0k6P2pJVXs+j3VKkzV1UVy58wM7GekWod2m
	 D4buPvI+6XHWDz3ZsxV+bq7hIiReQnxnQZ+lmeRFRAiIvjGJt4JJulx38d+sCvWO9t
	 991kP35PMsIpQ==
Date: Mon, 15 Jun 2026 09:12:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Simon Horman <horms@kernel.org>, Kees
 Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@kernel.org>, Breno Leitao <leitao@debian.org>, Larysa
 Zaremba <larysa.zaremba@intel.com>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 (The Capable Hub)" <u.kleine-koenig@baylibre.com>, Fabio Baltieri
 <fabio.baltieri@gmail.com>
Subject: Re: [PATCH net-next v7 0/5] net: wangxun: timeout and error
Message-ID: <20260615091250.399ac106@kernel.org>
In-Reply-To: <20260615065016.21672-1-jiawenwu@trustnetic.com>
References: <20260615065016.21672-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 14:50:11 +0800 Jiawen Wu wrote:
> It is about adding the Tx timeout process and pci_error_handlers.
> When a PCIe error occurs, the txgbe device is able to recover on platform
> that support AER interrupt. And for Tx timeout, the txgbe driver can
> recover the device by reset process.
> 
> For ngbe devices, due to the absence of the current function, it cannot
> br fully recovered once there is a PCIe error or Tx timeout. Its
> function will be completed in the future.

net-next is closed, please repost after the merge window
-- 
pw-bot: defer
