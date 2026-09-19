Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D92547048;
	Sat, 19 Sep 2026 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789860185; cv=none; b=XrCLAhROsfSlJ3MjFK4auZvRc/aK97y4wWHjQx2h8mo2OttZUSCnTgkqTTmd+9P4VONoHGSOFPfJiIaY0uLbPyLI70kX2lXx0WfEM4iRSEk3FWqu0mhjfDiacqg+5Q5SRqMgrPsjmDWNR7em94mLQ2ircw5CgM4CJY2qii/77VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789860185; c=relaxed/simple;
	bh=kTpjt+oZf7kkSvGB9GmG+y1XN315W4DQoZc9HtXaEIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eu3xBKMdR/0WDW0nuykRrowP9urW+gzeE31lemjZatVlL0vO0Ef5T04CS+GB9hhiYwacX3mrSiWaKSr8msEkvue3HPatzbGi8VHcYPxQFzjIsM49EXrTnyXEPz2y1vPlsv/SDKuyL13JLGb6++nrX4CqEg8qtDby2hWp4knYj1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=X9XJ7fk4; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=EGJU8pTK; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="X9XJ7fk4";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="EGJU8pTK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789860176;
	bh=kTpjt+oZf7kkSvGB9GmG+y1XN315W4DQoZc9HtXaEIQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X9XJ7fk4c9Fab3IABKdQGTL5jGZFsaVPCMSif6NYh68C2IG20UFnE29r1OazW2a0j
	 HN+lZFkRV50IghBDsVNzs33jRbL61+EPxUH/haySAIZZteGWSKCJCQaSMvwLZB1c9J
	 YXuCV5ck4UfwacLVIKuwK2ZM0+QjB1jMAxaljHV7hRznTl5stUUF6qitcVLbzzid66
	 l9KBIzKIvnsNcsG2JDwb8Jrpxcdcxm7qLSzoB6tgNrIIt+Upx7Z33xL+TDtPDZbg3B
	 cVzsZeLaQVas+mDesQktgM5gVQ/FwRCGQtIUOSDG+BZpZiGfybyy4HVBVn8V1UmnrC
	 a8MdlNbYhOFNg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 107733FDAF; Sat, 19 Sep 2026 23:22:56 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789860175;
	bh=kTpjt+oZf7kkSvGB9GmG+y1XN315W4DQoZc9HtXaEIQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EGJU8pTKRjQ6meDIYcqtT0m+bsywkRorvqX5K6+rmW7nScTDxIna/HXeFgY3NWXgq
	 kHh7PywrOmZl8O8OZTPFn33F3Wz8mi7LTthbf6KnlxEpDUIOGLi4ypmXbGW1Y7rrHq
	 NfENDqW2Wo4XjNQc6Y2BZ1IOQimA2wbwmcbb/rXxkQ2Iq3FJb4Vkkl/71tjrakDZEO
	 LkMDrFSaXNZ8DsRwgfG7peeZin1y4BjkhmlE58ryGUgs89Jb9LJfAyfMkMcQFAHgSt
	 X7qqVlqomyoC05hiOc5vAh0vqIaE+Q2P/p5VaGv3IhrEInsoYCLJR9pYuZtREpBfHI
	 suCVL9oTJ4rKg==
Received: from [192.168.100.219] (unknown [183.222.73.25])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 438213FD93;
	Sat, 19 Sep 2026 23:22:50 +0000 (UTC)
Message-ID: <7039c9b9-a365-4481-be36-f7bdfff040ef@birger-koblitz.de>
Date: Sun, 20 Sep 2026 01:22:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-6-60c04c9924a2@birger-koblitz.de>
 <178968029668.22033.6092490845837885048@kernel.org>
 <20260919151524.6a65c24b@kernel.org>
Content-Language: en-US
From: Birger Koblitz <mail@birger-koblitz.de>
In-Reply-To: <20260919151524.6a65c24b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jakub,

On 9/20/26 00:15, Jakub Kicinski wrote:
> On Thu, 17 Sep 2026 21:24:56 +0000 netdev-bot+sashiko@kernel.org wrote:
>> Critical: 0 · High: 4 · Medium: 19 · Low: 4
> 
> Per subsystem documentation we ask that submitters review
> the AI feedback and confirm / refute it. If you think that
> none of it is correct one email is enough. But I really doubt
> that AI was wrong 13 times (counting just High and Critical issues).

I was traveling the whole week and have only managed to go through about 
half of the AI comments so far. There are several that do not make 
sense, some which fall under "better safe than sorry" and others where
it is definitely "oops, should have seen that". I will reply to the AI 
findings in detail and definitely send a new round of patches in about 
2-3 days.

Birger
