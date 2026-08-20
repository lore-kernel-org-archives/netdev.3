Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A65464C
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217359; cv=none; b=OdEJNnv1aJQLtNxkkSv1wWCTAmwC2dOa2rF4V6NbLL9IqYck6npda1MUpNRVvS/olgRf/+Z6GjFCu49wYDSSr8edsPjdjhIXEMgFr3OKTipX4+G6lnBuYo/Fpw73n+0LZpxgnsGU61FnbcQRx4jPr+kpTGqPh7ImHjpkzGqSe/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217359; c=relaxed/simple;
	bh=FHDKnkYUmpZMOxUt/GEzXnLy+GKJ/6GsrQPyIJzezww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kekqgj6fj+raY3UxqMzBc1itZUogy/FhSuT8DFhM+SXa19fkqA/XPzXDD7+YxJhgsYnjg59iwl3FzoSIb+VdMPpFKxxuxO63T78aH1REcN1OmFhy6CfGbrp5IAU6NlTUveyrpLEWf7D1G5thJpmnohGJktyfyM9dIN7BzrgW4uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCbtVelL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rDW5EDC3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCbtVelL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rDW5EDC3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787217354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iC7wVVOoPB0KsrQ2GFN6bmuB3PRP9hffHh7uoNdFSMs=;
	b=fCbtVelL9oTPCuVantbAE7YS8eHef/ga3v1Ni0DbUxhQnXN8qaBMxCiWSBzI3NxTvzjzYg
	JDm+1Izk8+fRXu65oc3TC6O8KQHWzHwDBP5WE58mqrExxplsPLMfTmiTCaHAUo4aHM2CWP
	fgA5LbzTCP0W/n2CAHoQpoQliq9nwSU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-ngI4cb07MR6ZzTAtZg1owg-1; Thu, 20 Aug 2026 05:15:42 -0400
X-MC-Unique: ngI4cb07MR6ZzTAtZg1owg-1
X-Mimecast-MFC-AGG-ID: ngI4cb07MR6ZzTAtZg1owg_1787217341
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4954dcd6131so22021485e9.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787217341; x=1787822141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iC7wVVOoPB0KsrQ2GFN6bmuB3PRP9hffHh7uoNdFSMs=;
        b=rDW5EDC3T0Y4VM2U7W01BpXWasynvPBSdyn0lYDGmkesPi4a9WP3TVKmauZaloV/yk
         XSu8302ocY1/GUzBFBT1VTKW0fpJrG/3Kok8EfODcQEh8ClxlmoST7QZ7DY1r+u/uJzf
         dXYmzo1pXudnERo2oH4KUFKot7zhLA7S/Fya3FEcpWVAAhDvTXpBDP3SdU+6q7fPMb4K
         vJeLCjhNe9v4VO3+mleJNDNbY2gFV4xjahDmVV392UPL1893PgSSmKegUfR5/Y6oFA9w
         RhQLg9z/EMaPyDRjr2RfwssQA3ofSS23bwyXwXvIvcFwQR69StL0TwHi8ngSknZKBj82
         Jr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787217341; x=1787822141;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iC7wVVOoPB0KsrQ2GFN6bmuB3PRP9hffHh7uoNdFSMs=;
        b=F5eQfaEqjpOMqjkoeAn+Hpu9VUgQ5EyYwVbvwRM4cJwysplOt1fdhrXlThj+VmUNXk
         e4hnUtqc7xDCz2ZdjaBTSrwp6uVaLAo/WKb9Ea/2mIYZZCQvZIAjrU758/H7TEKTjsbz
         7qnwm0sRh9bwY+qGPJucWvcOHGyfS3U5HcBxDF9DPS9fDXwMU22Bi4LOaATxcoZdUMki
         iHkTPrSI/uYyvhbsylinZm1WUzhE2nl9TeZ3ATzFS3poI5n4P6DFJXPKnw20JIpEAJF9
         N/9baG6Sk8vdTkM/5qxQQJP4wKI90l6DrTzMdJLd9pj+eq3ZTvBSdnZCs7rQx9Y+lp9k
         8Sqw==
X-Gm-Message-State: AOJu0YxNSYNXlkZuoJySQZV8X7e5WAgdVles0p4YLUGBTeQN0dV4VAxV
	jHxga2nQuSOkJNiX3Fzr1PPgHMoTWBfd0gchfntJuHTOBcSSL5TqTmoBO7GdySW2a/NvElkLfCE
	JIlRn6z7Ncw/ZK2FEIBbntm+c4F/y5xJEHlxyjC8Z4RHQ3/Q+9YvFd0HceQ==
X-Gm-Gg: AR+sD12/4PTj5EdW4QQ3Sf532LNnIQUicXvZ46968F+wEL4NjuB20OEMPka1GKktubS
	bJVBWePrpC0RsCgytvXny+1P7OpSXVFrPgoTLKzMfR0Elr+fEd6uxHkjFJPq5oeLI04Soqef5vq
	XmD1zh2RPyKkTMDlGFTVIfktQOykTRctLAHhGqDRUgw0R2+s7AtTm/gYwMTFwxh0Vg65oQ8t3MG
	8riZhJbS/+55mivcd+EPK3A7StFlCSkd3lJHzNIa4ppC+ImqM8nrLVA3tiBEgRka7JLxllkEWPp
	00jE2nGMvj12qHalFZNNWCI53ja/nYrGJpfUigc4JfBmgdHQ7f914FZRRzeouaJNuwnxfkA7HXV
	Xd+Jm8xsPuEM0myms9+o5vQiefUmZpU9e+rCRflKJ9/tReqDDK9yv/aXTrXCAhOZLF8TUZtQDAk
	g=
X-Received: by 2002:a05:600c:4f54:b0:499:84fe:ca8c with SMTP id 5b1f17b1804b1-499aa16e9a9mr162665355e9.5.1787217340880;
        Thu, 20 Aug 2026 02:15:40 -0700 (PDT)
X-Received: by 2002:a05:600c:4f54:b0:499:84fe:ca8c with SMTP id 5b1f17b1804b1-499aa16e9a9mr162664795e9.5.1787217340449;
        Thu, 20 Aug 2026 02:15:40 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b2b96537sm27877615e9.1.2026.08.20.02.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 02:15:39 -0700 (PDT)
Message-ID: <f5dad83e-e940-4526-9299-596239ee3d39@redhat.com>
Date: Thu, 20 Aug 2026 11:15:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: stmmac: platform: use scoped child loops
 in stmmac_mtl_setup()
To: Linkai Gong <gonglinkai@kylinos.cn>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
References: <20260819073258.467604-1-gonglinkai@kylinos.cn>
 <20260820012339.3231289-1-gonglinkai@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260820012339.3231289-1-gonglinkai@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/26 3:23 AM, Linkai Gong wrote:
> for_each_child_of_node() takes a reference on the current child. Breaking
> out of the RX loop leaks that node because the TX loop then overwrites
> q_node. The TX loop has the same break, and only happens to be safe
> because of_node_put(q_node) at the out label drops the last TX child.
> 
> Use for_each_child_of_node_scoped() for both loops so the child is put
> on every exit, including break, and drop the out-label put of q_node.
> 
> Fixes: d976a525c371 ("net: stmmac: multiple queues dt configuration")
> Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.3,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

