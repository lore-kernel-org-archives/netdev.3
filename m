Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A1F25782D;
	Wed, 20 May 2026 00:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238587; cv=none; b=XLolSGENN8QqvDgH3Ho+D4RwbiiJRsSp6ZIU/CKcC95PKw9lCQFbE9E+P5QVJSR+Kttl3057XZHnAzTbZ7YRK1XDG4TnDX3Y/DEFAZp9cTYw0wj8I+op7bc0LWyoyBMrht3msr32UcY3R9f/WZ/fiJjB3EpGPBrueuEeMnLFpjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238587; c=relaxed/simple;
	bh=vWnLVk2vwJ+HceCdYdIxfmMkR0kgW863pb2oLzCk6os=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndFvSuh/Xouv+hHY7WFJMIqcPNjKva46W1A5vXPonmANRo5KXbN/+gBpgjyousVnMBjpNnhBgn+sFkc8xsc7hCLnLc6NoC1J5DnXLk+Wj8RyUW1yH6oL5KOatgaAh3mslGQGIa6cwuTQbTLPK+a/5/+Z73pVnugKJIbG+q/XL/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b29mxQ3e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b29mxQ3e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350DE1F000E9;
	Wed, 20 May 2026 00:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779238586;
	bh=KWDXI5dBxAz0foN9ScNbQibTy5AU7KrOGuGeIXuYEXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b29mxQ3e3nI7wLespkp+GYorfiq6C5mPrsDb7B3u3cxcq6xvtdPqISloEyH7jhnFG
	 /1ErNUSuQNwju0Aku3lo4AMgiCkGMlrjI8BC2svDgZsTY5X1KqYVOQ3OP3orYF/V0b
	 G7FYQP52+GW0rT7cw+2cHKk1kxe7gZaStYyuGbp9y244OEdt0Kei3R1gFRXALWD8Qt
	 cyucJ5DJEzrcdzzNejrmuhY74zwS09jEaCGCOLtFhVtvCv3qTQQbJDZpZ26xK9Sx1a
	 sJtt6VZthh1ShshN8tbt1VF2eJqjrtWBZPWkAUSNfwCf5dUSgMYN3nREGwS0DRP4/k
	 l4ZOY0kRj7Jew==
Date: Tue, 19 May 2026 17:56:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [Patch net-next v4 0/7] r8169: add RSS support for RTL8127
Message-ID: <20260519175625.22dd55c3@kernel.org>
In-Reply-To: <20260518111912.1603-1-javen_xu@realsil.com.cn>
References: <20260518111912.1603-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 19:19:04 +0800 javen wrote:
> This patch series adds RSS (Receive Side Scaling) support for the r8169
> ethernet driver, specifically for RTL8127 (RTL_GIGA_MAC_VER_80).
> 
> RSS enables packet distribution across multiple receive queues, which can
> significantly improve network throughput on multi-core systems by allowing
> parallel processing of incoming packets.

Does not apply.
