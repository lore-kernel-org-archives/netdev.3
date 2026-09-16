Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D803647D46B;
	Wed, 16 Sep 2026 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593581; cv=none; b=GF5oh+hOPFLrQjCyL+FsVcGENyD1BrMi3o6MPxnkv/2Mh2rx5VNw43oQZLVYSOUXs3WX88T++TDHanlUh8+q7FdALUcjJeM9B8mRUTkIf22RSRNnpafPc1XxCt56fR6D+o9+kVO3KTYnk83Tc3K2+BOENUCA6mQ6pQYJVYWc4Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593581; c=relaxed/simple;
	bh=oXPSSG6jM0QEkoHGeNbNDp8yq8q30yKzPWNwKzDC9oE=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=pmp07IOCwYRzs58PtjbOk1Pdhyjo8K8nM5Hy8Wzm4rDKxUqYTPk3TP+n7fiHlXlT4wNivoGHhE/9INg98AAp/uLcRppTYUEMbNu3RemTFom0v05prVxCA1vaCJordFi5KbtaJIrnPYDB3Hbk8+olvg4oLd1nk/UoiN/ord2DsW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=O/lQBdu+; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="O/lQBdu+"
Received: from webmail.inf.ufrgs.br (webmail.inf.ufrgs.br [143.54.11.45])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 855981202B5;
	Wed, 16 Sep 2026 18:19:23 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1789593563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WqemNJYepaocPDCt4NbuQLTocIN9u/03Mvdgkikuz3o=;
	b=O/lQBdu+H2sY69hkQjxYucPv0synYEywj1ZODDwYjUfFjOzuiJl83miu8/ZZ/lUYkOP9CA
	6gvNH98viZ3NsDgHp6FjfQavJpZNKW7bQmA0MwqsRY6gxfyZNZ1YhS6jAjg1/aTEbQzL5F
	ro7JigqW0sjk41CP5CQs5BNvTBGNXgvaDk9RSZKg5rX265XDe0+UQ0BfGlbYYQvclu+zRd
	qRp4jhsI9rOD4ZaXW6IZ7bJu0gNsDNBzNNsLnCsLPiohgIPrCy8BfGsCZ14RfyhQjHK742
	PSLHiFM3qhAG4wl+/VnlQhLQGzOock3fm9OGPjdWuxYwgIREITMqDYG4+jS8Zg==
Received: from 186-210-028-117.xd-dynamic.algarnetsuper.com.br
 ([186.210.28.117])
 by webmail.inf.ufrgs.br
 with HTTP (HTTP/1.1 POST); Wed, 16 Sep 2026 18:19:23 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Wed, 16 Sep 2026 18:19:23 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] r8169: propagate errors from PHY write
 operations
In-Reply-To: <4a9c817f-e8b5-455b-8e78-a57cb6bcdaec@lunn.ch>
References: <20260916152444.167196-1-matheus.aalmeida@inf.ufrgs.br>
 <20260916152444.167196-2-matheus.aalmeida@inf.ufrgs.br>
 <f4e563a9-5c25-4026-853f-5d5d30f5a0d9@lunn.ch>
 <02943cee3bbe56fafe76a98eeb78c682@inf.ufrgs.br>
 <4a9c817f-e8b5-455b-8e78-a57cb6bcdaec@lunn.ch>
Message-ID: <dff20f927e5f51d7c79016a597476a8b@inf.ufrgs.br>
X-Sender: matheus.aalmeida@inf.ufrgs.br
User-Agent: Roundcube Webmail/0.9.5

On 2026-09-16 18:14, Andrew Lunn Wrote:
> On Wed, Sep 16, 2026 at 06:10:00PM -0300, Matheus Alves de Almeida wrote:
>> > Maybe rewrite rtl_loop_wait_low(), _high() and rtl_loop_wait() to use
>> > iopoll.h?
>> 
>> While I don’t think this fits the scope of this series, I’d be willing
>> to look into it as a follow-up.
> 
> You trimmed too much context.
> 
> The nice thing about iopoll.h is that they all return -ETIMEDOUT, or
> some other error code on error. So your current patch looking at the
> Boolean return value becomes redundant, you just follow the normal
> pattern:
> 
>        ret = rtl_loop_wait_low();
>        if (ret)
>        	  return ret;
> 
> So i think this is in scope, otherwise you are going to rewrite 90% of
> this patch when you do introduce it.
> 
>      Andrew

Sorry about trimming too much context. That makes sense. I was thinking
of the iopoll.h conversion primarily as cleanup. I’ll rework this for v2.
