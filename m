Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310CE4204E
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 22:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782598544; cv=none; b=Ahh4wCmxWUOAutbeSqCkmUQAHVtiCLojpR3IiDeFLfIMJzXFWFgtM3V4gton13C/8JdrAKn/HK0gnvG56QtHDcD84ArFyxPoYRSc2JIy178F7f7TVNZWWfCCkWKMC2zCVF9n/YvlhQkq+F13H5Z1gMah/m06uLG/vS/btZcQ6OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782598544; c=relaxed/simple;
	bh=W04uXXvhgO82ttrCtlB+3EwPAZquOJrmaDJSu/S0ReM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1yLLf07/+mCVyTuCl23LqaMz/jggovuyNugiORovjqbRytH1/AmU1n5eUG85y8PLOc0DzAbzrV/W4tsyyjBs2qi/eEFnaoyVLp5q77IaaOL1AjChrCuXNu9lekT6FlxAJzrK1Z450rIq0gSY3DPShMHa1fvrGkrqKuEWjr5dkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtVurek5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtVurek5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718521F000E9;
	Sat, 27 Jun 2026 22:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782598542;
	bh=nK+pf9PlmXmJL5a5Vd6SqrSuHAG0CCQGM/NZvgMcl6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CtVurek5TIX7Kop4RcGjdI2qQBZ180UhrL+fHjkhwfvi77wq7S4Bi2SsA42FX+Npi
	 dA2jFaWbwF8AaRlkREsdqv5R9dbIWdYEmYwrqA4TxTlCD9pTlp8QBcg04X63cdyjCr
	 wKUxKt9QQQr8mcKXlcFJZnRSped35E4BaAboZm+ca53WH4CkoQmns+mdRgbG6uaJ9l
	 IZ9POkGBE4ptUnJX8QBYIZ56eTnSu/pcVlXGlmZIWhr5FhcSFjADZvOpX+mJGgwWtj
	 1MOlyscr8Pp7gqVdO17mFJxWhs/mCRT+A6gW47+9uK5pYolgxH2LHSrHv9+6HTbf5b
	 uujBnF+E6OjRQ==
Date: Sat, 27 Jun 2026 15:15:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, petrm@mellanox.com, yuantan098@gmail.com,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, bronzed_45_vested@icloud.com
Subject: Re: [PATCH net v2 1/1] net: sched: ets: avoid deficit wrap and
 bound empty dequeue  rounds
Message-ID: <20260627151541.3b22bdd8@kernel.org>
In-Reply-To: <0e17a0309061300d31036a6a4c139919192f6373.1782379460.git.bronzed_45_vested@icloud.com>
References: <0e17a0309061300d31036a6a4c139919192f6373.1782379460.git.bronzed_45_vested@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 16:32:00 +0800 Ren Wei wrote:
> @@ -499,6 +501,8 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
>  
>  		cl->deficit += READ_ONCE(cl->quantum);
>  		list_move_tail(&cl->alist, &q->active);
> +		if (++loops > max_loops)
> +			goto out;

BTW sashiko says that this will permanently stall the qdisc.
-- 
pw-bot: cr
