Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271129;
	b=FUvNvKH3PaN8C3rn156dHZorGMzdAKbv3JqDmRIDbRQWg8TCcjre1zJfZIXZiC/D7TR6
	 rI2RLsO51UahU5T2UOyrFu3UALkyzXdTUWu3BzMR7yP60Uh+CjE3lrXItpGgmqcj1z7a3
	 Dk38J+H89aqdax3+cuzX/o9OannK1VDmbCznPMc+72GGI5MbNfS/TT6G1nksof+pZKMEp
	 2umB/lo9fx1usYgexjDQOCLua0aJ4TnXucNYCyY7t9c/CZ3XolM63Hzz577VkM9SLZeAU
	 gaeoIbdXNNpQkdg2YHJVJ/KTnp3M15BbVa4WNLXXadPUz2gBxrzDQbt76+q+o+SJUnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271129;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:Date:
	 From:To:Cc:Subject:Message-Id:In-Reply-To:References:X-Mailer:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=L7XouM7EVXaoZdZC7OVtr6c7wMxTLOEjkY0PkptczXk=;
	b=CY6xzryvk4A4EIp8oBhRL8aaPJ84j8IJQ5JWfpabSOqzwZXQNW9Qnj7v//ZTY7VS1bNp
	 uSRdigRdpk9hICqIA3phnn/3Tr3CTm+7WFIp+4X0Lz3o8ZCO1Wc8DVw3YGwalsYYX1idT
	 s+IT4aMM2jq0E9eIlvDspFMFjFgvocJlPRUcOuEA0WfC9Cqg1AHobJ3j1dwDx0o3UlVj/
	 cNOZmZ3uPcD7QVMy3Gsnnb1kZOA772Jg8XXDcQ0J8nEgfVO86f8nXlXG9qVDyphXHlDHg
	 TJr2evThJv5pSTwlw8BMI6BEyXlTxzCzs5k5Elq/r/979XW4y6w4xpIZaETz0/95Ccg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=bWNrIjHH;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=LLiBWgJX;
	arc=none smtp.remote-ip=160.80.4.33
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.33])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FCB606A338;
	Tue, 10 Nov 2026 00:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16FCB606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=bWNrIjHH;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=LLiBWgJX
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6AA0brej020849;
	Tue, 10 Nov 2026 01:37:58 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 3367D122868;
	Tue, 10 Nov 2026 01:37:49 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1794271069; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7XouM7EVXaoZdZC7OVtr6c7wMxTLOEjkY0PkptczXk=;
	b=bWNrIjHHBlCQ+KuNOs8ozU9lOJXNuK2Lx1JjVJbpOSLRBvakp6WFlD6fQlpKPz0yFd6G1n
	vWqa47+MT/5PQTCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1794271069; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7XouM7EVXaoZdZC7OVtr6c7wMxTLOEjkY0PkptczXk=;
	b=LLiBWgJXpj7jAKeCjG2puASJxSokuN962CN8kLyIDUM6d1ZhiXYPxfwVtr2b9TzYIkULss
	0fOknra0Cw7ApgUSxbqs+zikfpe+Ghzj9BvDCAO/hIXbOSP5aOXoyb6QVarOOCYTXh+m5i
	E5FRpexPYQe64xt4l/ZrT4BeGoApU1r11CcROf4Sh9Rvi08goILjNVywW6PeSugPIhXrkB
	99rgMN2g3Bt/AWioKqu/t3IUvuVGIBb5faTmNxPlhP34MuxoSudMs4nat7S1b4ECvg89yb
	mcY4W11uxDKqLa8xsRvc3XO8CrI4f8JY7SdQFtq37zCfn826xp8bqH3dsoLbCw==
Date: Tue, 10 Nov 2026 01:37:43 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Boyan Liu <yymhvert@gmail.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+98d7de09cd94fec5@bugs.sh, co+cdeaa2edb6897680@bugs.sh,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Hangbin Liu <hangbin.liu@linux.dev>,
        Andrea Mayer <andrea@common-net.org>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v3] seg6: Fix unset mac header in SRv6 End.DT VRF
 decapsulation
Message-Id: <20261110013743.101dc3309db53ade8d6bb24e@uniroma2.it>
In-Reply-To: <20261106065607.3372-1-yymhvert@gmail.com>
References: <20261021024738.17266-1-yymhvert@gmail.com>
 <20261024015811.a995b7cab417cac2f41689de@uniroma2.it>
 <20261106065607.3372-1-yymhvert@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Fri,  6 Nov 2026 14:56:07 +0800
Boyan Liu <yymhvert@gmail.com> wrote:

> Hi Andrea,
>
> It has been about two weeks since you mentioned that you were
> looking into the NFQUEUE case.

Hi Boyan,

I followed up on the NFQUEUE case on 26 Oct, in this reply to the v3:

https://lore.kernel.org/netdev/20261026003415.f7c46fa5a495144c29c03a07@uniroma2.it/

> My understanding is that NFQUEUE is the remaining open question
> for v3. Did you get a chance to check it? Should I prepare a v4
> to address that case, or is the current approach acceptable?

As I wrote there, setting the mac header at the network header with
mac_len 0 looks fine, and the reported crash is gone with v3 in my
tests. The NFQUEUE case in the Sashiko review also exists without this
patch, so it is not introduced by v3. On the SRv6 side, I think the
current approach is acceptable, and the NFQUEUE case can be handled
separately.

Ciao,
Andrea
