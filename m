Received: from mta0.migadu.com (out-39.mta0.migadu.com [91.218.175.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458A240F74A
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787294688; cv=none; b=gW7w67RABln2cHBPDHXcIftGsJ2lMaFH7hPIm4g36DYzJAciP/ijUp2bNW+qDZyTVk164OLSvwFeHgGkvhrU0NIwp2aor4HrmvFf+vRM4ehu3+eQSHQ618voou1Qfimw3kkzRag37frO/3mmp7oWIk/YrB7jKA/0oyimp9yR+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787294688; c=relaxed/simple;
	bh=JT+uNklOu9PEHTm8enocx68fQlbTao3r1N5vEKUamT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G9HyJVMPBQLxJIPD0FHtXBl5Vw+95wMdJxw0spOAjdxAMk7Jz0n7k97XPEXyz/Dzfskcn+qrVtxqzUgZAVzoE3O34k/Xa6Ob7BepFsq6hdZtKCdeZmFrS3n+pPnzk1YEogz+GIgc2axZKfyjpiUp1R9hW9EeZCPJhZC0ahJwiR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gr2UoUFe; arc=none smtp.client-ip=91.218.175.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gr2UoUFe"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JT+uNklOu9PEHTm8enocx68fQlbTao3r1N5vEKUamT8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787294683; v=1; x=1787899483;
 b=gr2UoUFeZyQlFyhMgdvnAUXkgBCIq8kZSZcy8x2Ed4etrSHk/JvotJ2oSOV8A6EvMVpLJQ2v
 Zlanfpct3Zu683dQvjhe7KK9KkKWL5kqJOpmgdfittqAOzLGzPsZ2fiJeR2awXvzmjqbtMkTqd0
 IgiMeq3hWDGR4Zny1AKSaobU=
X-Envelope-To: netdev@vger.kernel.org
Received: from [198.18.0.1] (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 2ec1a3cf366fdcac;
	Fri, 21 Aug 2026 06:44:43 +0000
X-Mizu-Trace-ID: 2ec1a3cf366fdcac
X-Migadu-Flow: FLOW_OUT
Message-ID: <8e1a383b-7b91-4a42-b085-031cc65c6654@linux.dev>
Date: Fri, 21 Aug 2026 14:44:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 0/5] net: phy: fix cleanup after probe failure
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, chleroy@kernel.org,
 linux-kernel@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
 <305b44bc-0a98-4481-8f92-b0c18a590b7f@lunn.ch>
 <20260820104636.162a6421@kernel.org>
 <d2a16ed7-3858-4e52-854b-279f4c8ecab1@lunn.ch>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <d2a16ed7-3858-4e52-854b-279f4c8ecab1@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/21 02:22, Andrew Lunn 写道:
> On Thu, Aug 20, 2026 at 10:46:36AM -0700, Jakub Kicinski wrote:
>> On Wed, 19 Aug 2026 15:33:28 +0200 Andrew Lunn wrote:
>>> Please submit for net-next, once it reopens.
>> FWIW I'd prefer to take these sort of error path fixes to net
>> during the merge window. No point backlogging borderline stuff.
>> Any particular reason you want this in net-next?
> I don't think it bothers anybody, so does not meet stable rules.
>
> But i've nothing against it being merged now.
>
>      Andrew

Thanks for the discussion.

Based on the feedback, I’ll continue targeting net and post a revised
version in a follow-up.

Thanks,
Xuanqiang

