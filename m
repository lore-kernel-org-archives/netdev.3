Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717096;
	b=UZPNaMGluc1xSrruzYY7W8zXjmgi86GzuQkjjHcsoGUjI8+spQ4rPqpG4UhP933VJzNc
	 wWJV/5B6pW9Tqaiul830ohMC5/yYSjng4fTaa0GnUtPfi4q6bft2IEVMzGCIco4k7zbE5
	 /5fkSgikK/+7/7cXB3Ko5lEkuh74YgGfC4xQ+iB0RX2m35tu9GFBZa0G8tEw1v/IUVG1o
	 /X0y/RiQgnn07UZuxeM1Pnnhd72dZC6C0Bxtyb2BspkxlgmdvD/Sae5jjrp2No2jr1BmZ
	 SzySGRR5+ZiO1zkpxXUPpmkEy2NOBiUzHua+kN5D8a3o/x0s9pS6VSeLWp32bWchpyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Fk9maKmdigSs5TiKi8B9LmmVhFBWcWLU75j5fSDUu4U=;
	b=tv1Is6mAfQEk60lPbFeSGtKQMxaGZ5vxrjM+dSSh+oQCbKqZGe/y7rpzwceCwy9s1m2L
	 y+UKd3/dQQ8wlEQBsj/9raWWrXyj37JxuT9i36Pj5mSL1ZvIHV0JLWp11qt10rzkGXkBz
	 XourhJZIiR+yYIoSueacOejDAsoPFz/ycyLlSMxNLxNnfhRoJ65wBQjAXInBMytMQNftd
	 AfVNYn5S/np/F3RhuBUZaIidfLl5IJTIxKw/4MoiSsoSQR9+ju4u12ZnDfmBfACUNbR7x
	 2B5Wt9PtDmWCKYPikwOH+yphkkqpNWQF8mDGUefVIjiLEIFvubOdePEPOK8vFJKyeJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5SJhljY;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC52C606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC52C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5SJhljY
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so3210859e0c.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793717095; x=1794321895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Fk9maKmdigSs5TiKi8B9LmmVhFBWcWLU75j5fSDUu4U=;
        b=w5SJhljYINi9IL5EUUCQvEXxaLTFHdERPx3dAUFhHTAVjTrP2uYnI2B7thilGQWhkz
         v9GmtxE34L+qF4/GHZCRwBK1BDc/Ef/yuxYRAGnv91L9QtDAEo/w+vk/d8Cw4FvOT/0g
         xG+u+zL0A1dezzhM9BBliPUEz1dw4BnBnoOEWV0tPF+/WzisSstj9rOLR4O6zDQu4JPj
         KbwxOWeDaBzM4t2Do1fLqL3JSR2fGxZ3ORVSC5c/8P387g01BYjtcq7sKXPv6wqYSPUW
         bmNklFRfJlyguNggyadZUVSSDijdiamygbiWaVfDr3RjUmBCmYCKRrf3aRfGgYorIj0F
         r+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793717095; x=1794321895;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fk9maKmdigSs5TiKi8B9LmmVhFBWcWLU75j5fSDUu4U=;
        b=yzHDTJ0OGg+3v0qNNETl9Ga5FB3JBDC5jLQhHzPrwSq5LnrLZDajj97WZhHSfZamM8
         GJKfmliOfQ0ST0EzOutr/89UFtEFpIDq5ZM3dArbYcdUvk5tryZd4MOmsXICsnEgCiCJ
         rrtAIuw5516opPQkwFt1sB8UQGjYnNCGimRlluJUgGODL97Fi+2E8i8shUP3VxZX0n1Y
         hYkgsNcf7UP5YPhoSSCqhDP6T/o1OLOoubuHfGja2qz/EkuaTOKANPWGfW4izOnd+X4a
         Hd1gvHmEb/W1Gw+PL2oXDV6/kjRy40Y2D4eohKq8Mz1+/6EwZOl/Zc6xiGYmmcGrk5AI
         0hfQ==
X-Gm-Message-State: APuU4Z+tN0XD5gZxvoEWl32t1eF4CQSe9AlBZtrwLJxYaeoLZ/3g9gi/
	n35Lp8uDc6XPi8i/8oMlgx44be044p6okCAo+DAGKsjv0gQvspoD33sN
X-Gm-Gg: AYBFou1xndJgdxxw8G4IDxJrYPsZcAA+il03Yf9DlQ+zM8oyCyVcGkfvVwY29CSCySG
	hXmIOEKngh2UgYb0BRFgdKhHeqzNkaZyxhOVSZPwg+6E7IlXOGE8/doGzLL8n7bbJY4ZvaUJkSw
	o2i26KDsVTDPLWAWv9CdAMnYAJhenSy0WfuOe3wSb47slw28vJu3I6f1BTurD5MXqRIORzdxsWh
	l2nzgIktwBWK89lqTgeiurvUEVAc6RVUBc1Xehote30KAtGxi963DjcfBxoKCy4dzqczDLbk78l
	xFIvbwAI+M7L1xbMyfnT3MPwdE9QebLinzOWYszqFLFIdUdMGcVgVpQN+KRvb0nK6znPIkbi1EI
	bGX+V/iYRKi0YHXsd/iUv6u3ZUnKbY/0tqPnRiyM+M9SrtPMWWUHHC2R65vMmUamM4gcrmCNJb9
	MCaLZBqxNFAXe3dgM6tC4135ptpytbD/9lstq7ZWUDOZ7BvhNdb1wkoXYFvoomRE5UjWAFCf+Uy
	f2sdPxsN0SjGJPOi1iNW8u2ZJKZmk5/sl59ShDP6OdpNf34lWLK5+0DNj4vH9yWsOk77lFatOT+
	ZpzG80cXZ7vVy/qdBcfBguPVpPOY35W2SO0JXT+hGQkN+nEuyLFIZM4yuu+rHQS0/RnPtGMeakS
	DZTJ5T0Rt55It0CHIytdDWepNcrKeIeShEC8cORdHdFjNvE+hBdvBaCEVxs9CKiONCHK1W/+fE8
	yHcA8NfZ8r5aHWYY8y
X-Received: by 2002:a05:6122:469b:b0:5ea:b972:1403 with SMTP id 71dfb90a1353d-5ec68539420mr5451827e0c.3.1793717094974;
        Tue, 03 Nov 2026 06:44:54 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c4cbabsm12828137e0c.11.2026.11.03.06.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:44:53 -0800 (PST)
Date: Tue, 03 Nov 2026 09:44:53 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 bpf@vger.kernel.org, 
 dsahern@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.a20ae72714a7@gmail.com>
In-Reply-To: <20261103092226.2e8ab229@stephen-xps.local>
References: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
 <20261103092226.2e8ab229@stephen-xps.local>
Subject: Re: [PATCH net-next] docs: netdev: fix iproute2 process documentation
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stephen Hemminger wrote:
> On Mon,  2 Nov 2026 22:35:56 -0500
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> > +
> > +Patches are tracked in patchwork under the netdevbpf project and delegated
> > +to 'shemminger' for further processing:
> > +
> 
> Minor nit. David Ahern (dsa) handles the iproute-next patches.
> I stick to only iproute. 

I know, but there is no separate delegation in patchwork to David.

I assumed all iproute2 patches would get delegated to your patchwork
component. Is this not correct?
