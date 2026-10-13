Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E583B05A4;
	Tue, 13 Oct 2026 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883326; cv=none; b=krYe/arQlpInHLCke3iPx7KEzWceq0NavB8ZUBN4uFe/xRSwGP1Lo14oND2zY0Cs9uAdpLwNLBvTU3kNTjNF6cFLEdynGuA/s7e8Zi5OhnGalviSOJ8CcUm8TatmQzFRhou/3dgxFwoV22mO+6OYvpnFvnaWglndyrJJWcy9QBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883326; c=relaxed/simple;
	bh=gJQ4W3XO+FKgHfctfatKwXqNocrUMqpoSrgQ90BUH70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjvAfD8jD62L05B9Y4lLwJ1Sy61WEVHcTK4vOEVTgbfsu+bScTk9yWnaT4bM6auEV23PFusS5e77mIY+bcJq9qfRU+R+mkD51czYfxzWLKvg9OZPMyfdfUYDcLQyQvXuzRSMSAq0oQIIDuRuux8qHqxC8h4vqwPmS5/b8WYhXiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=leygvzJJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L9gQppIw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="leygvzJJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L9gQppIw"
Date: Tue, 13 Oct 2026 11:22:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791883322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pqAkoMaI4AjFtI9TGG3CFcrPRpq/ajzZUbsDq9VoD80=;
	b=leygvzJJIkIkORcqRXlrapRp+Mj+zbl4NCQsFmyIQZILQ7Y2F/G8HdQ/nIhlLvvGtk7bXd
	1TE+dkw1b+c0J1l+hdf/snmsJNpee0md+9gmwkEWbZ3tP8msys6yX40Vts5WsOV7VUmVj2
	sNkreKPpHCWG/CkaZ2mP2CJI4kmn5/Q954xHLeMFMsmUXRzYMItug9lpY+cAU0EmfWjU7N
	akUaJ1Tw16KkjVmv75IqRFwGCY52cfm2d9p5B7OiKUSy/VWD5jr8ef4WW96tcRL+dqLMZt
	s5712iRFsj/GmMYiQdeDIIPpCbHH3/G3I7tDXUIeGkvuzygbJ7lgPRKndztNew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791883322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pqAkoMaI4AjFtI9TGG3CFcrPRpq/ajzZUbsDq9VoD80=;
	b=L9gQppIwp9cOPMDHdo9VEuyn1BPBb7T8TrTm68g33buuakQKA97XvMwoPXLprFxjyVvIx6
	KyYVj8IO8FwLhHDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	=?utf-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>,
	oneukum@suse.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, david.laight.linux@gmail.com,
	syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Subject: Re: [PATCH net v6] usbnet: fix smp_processor_id() use in preemptible
 context
Message-ID: <20261013092200.3ABzkH9f@linutronix.de>
References: <20261007200049.079aeb75@kernel.org>
 <7c4a2f1c-f16d-479b-a11f-cef962d5e2c7@rowland.harvard.edu>
 <20261008094338.301a75fa@kernel.org>
 <06a81ea1-b17d-40bd-82d9-922de946b86f@rowland.harvard.edu>
 <2026100910-petition-embattled-94cb@gregkh>
 <20261012194902.aEq58Q6b@linutronix.de>
 <8545800a-a37f-482a-9b06-cbdd70312b7a@rowland.harvard.edu>
 <20261012212527.5sFqlGYu@linutronix.de>
 <41af30de-4725-4913-9ad8-54d1dea2d4b8@rowland.harvard.edu>
 <b1fae6df-5e69-4e53-9f35-9bfc47c9a500@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1fae6df-5e69-4e53-9f35-9bfc47c9a500@redhat.com>

On 2026-10-13 11:11:04 [+0200], Paolo Abeni wrote:
> > If this is okay with you, I can write a documentation patch.
> Please help me wrapping this up. I read the above as a more generic
> patch is under discussion, am I correct?

We are discussing if we fix the identified driver(s) or fix the
offending HCD and document the expected behaviour.

> Thanks,
> 
> Paolo

Sebastian
