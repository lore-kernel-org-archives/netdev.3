Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794072440;
	b=vPgs0Gbnh3BWk2XBm7J/D4J8aQJvDNy0L3qini+wsu3zqt1zQck2ecegFsx6Dz02ccGT
	 hVU3YBbgroCSKEtwC0ZG8WkJXj004+O9BUGzfAno9ZIoTxcHJgLZioFM79XZUT061YaBd
	 XW0vcczj1aHDAtUcKFzLkUQIkq3nxbtCNjZEmbnI1L5WXhdnT3gj+cd3ExxArzd/5fzNl
	 YqhKkm+Q4wuzZV3V7AFroJ1qXN67ETCJe8Dr4YxB2rYDZCw+5SpejUfwwcA8hoXGfV4lt
	 1APfWv8sQD/jWhY5I7HGX1dUETcF3xS8sCWniD8H+t85bxXnYoGDfeHJIxp7+1jpTUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794072440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZZwMrztt3of5COKCtSyFNtiXLTIolPtZxVxm9oGuspE=;
	b=vNz7/2xOuwB1hp56eNj5bT5wlxdjdOllC3Eoootg0YGxN/aNm5hJk0SuMfTMlBehfZyF
	 Duma7h6WRxz8kf3eywfWj1q+LdI7BToiXehEeayw5acaBjWY++IS9u8VrITAgE9fagiR5
	 z3ROjy7AXtMRAc5TaxEIFhTcDxyFSrRt5YhY3Mwg48jJB1suBxokCu8NIs1VJOkvCGqZk
	 blUv9liDQWIP1Xqy6JjPSSg917p7a8WGfLBJDJ1bZXKCcEya/wWn0euJww1+2jqc5xUq1
	 gKVTJ3KbtowrGIJwzRx3I9/ClLNdklOzGInw3OA0BzZYEY0Mfq1lsjQreDjvgTM/VNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="kBRtH//X";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F5B606A32E
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 17:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01F5B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kBRtH//X
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36f6295304dso1732474eec.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 09:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794072439; x=1794677239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZZwMrztt3of5COKCtSyFNtiXLTIolPtZxVxm9oGuspE=;
        b=kBRtH//XVichkRikoXz0f3WTHIlITZ1SryQ/0NJaXxcgxJFnQ/kWxd2qN0cvEbrSgL
         vCc28+x19SetD/5AU+3gDnvpS5OHzdWqfuGF9UY7PUv1jH8TI7eChX3qnXl5d9fW16gI
         /0XbrUdOwcKCKgx74Oe+0MSoMHyiNB/WfghnbVXVBNsji+jK4eN85o+MoW6g4r6tNZ9v
         xExwIOsgc7Iw/yN8G4BEZQg3JbyGk5jhCEDiIxkXZgw//mp1v9zKzx/fWSj3iwDNn8jh
         2CKFV3WKhWqCZnbwJINRBuR+TOsiUzP/UeebdcHL1QLw8bAuVb+djeaNLs04FILbPfJ5
         mzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794072439; x=1794677239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZZwMrztt3of5COKCtSyFNtiXLTIolPtZxVxm9oGuspE=;
        b=HqhkgID3cffnJcgArGT/Ff6Ggq8E8oGjoFVotrb5rUQqAOVTPxPwJv8pY6sUBb4S1V
         wGb4YEVqzqFmqsSRhpfTU1JYn+1ZgEyfMKqH9qLvh4XmmsWVIAO/sjnnm9zzgxUKGegI
         txqsbQLS5nKwYOZ0f96KqGALPl0NjCKuwI1n6s5I/UrQHZ1k5uBcbAyRzH/QqYYivtxL
         nfZHjeMwjpL8kNg97Jlb869e0PU4m8GLVGIf/smuxbDQj6eSzwNzwHQZUCioJcYgJVM1
         NzJgiBe80Amq3Cr6j1bcZ98/9M+/4jvwMx9/26NQ0NDMUYeQ+cG1XteD9hwmnsI+fgLb
         W3hA==
X-Forwarded-Encrypted: i=1; AKwUvBwkzg4wB++COEinSSIuezKGVA+TE4VVdfMxXrNfJ6b/F/OrdWqe0gLAq16ectQV1mm5+kdWzBQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nUc2jgMki5ie/8G1NW9jnF/UVfaKUpr7FoeYIP5G76gDQmf+i
	2Hpd/1dIPuHebDKhyrBD8Jg7ckxICWnOfXX7oCeiC8RCa/YAY1nNXSrn
X-Gm-Gg: AYBFou1fXzGazgFbHcT+E7wI1SYjydnVVqQ5pXHsun6BMX3wpq6RKIQZTgOVf3Y+HOe
	E9wu5crJGPkTRquFBh/trGwPzWCg8TnWwZu4cffS9cv/KvkpZJnWYqoxFNAKB8xYv/6MmkRjK52
	B9jr4HWbPq/RxLTCfXufJ2bv1V8jH9S/K8ztTeyKOLyjWOJaAqs09pVr2Sn7W27eiW/PtJRdE5L
	rItQ5n+dWKz88U4IKB1i3O5IjJZlFxO0Nsj11tTt0EMqx9dqzRLBz+jQXIdHWjx17cl0rQ3c6Dc
	7+umO47PnYGkbNQ4yNs2Z7pIBVBX8ABoFNKuVzJscM3BEFmTb4Xsj6wxKipZt8ggoP3y6PEEguC
	ks2hYilC/57PLNP8WO2ldsRs2bQPGqEiLVxRoMstrlL5xQKDXoWemOTB+klegX/Gc9KBbfp96/1
	XtDnrlZuV2wXQjiQMg0ifNJzGt+ucROrTOqP76Wn6KsGkjkaNOWlxOcqHpUd2u5JFbHbe2Me5Qn
	iHDCpjqxxvnT3wtQsMhVyFQcLvweowCXtJ/XsKYkSJChX9kDUn8NOQc+KpPiDZzJxCdUrqaS+2H
	p+MFx0sEqt2E4Skg8M4euVJd2ULUprzkoSadWA==
X-Received: by 2002:a05:693c:2a07:b0:36d:4135:cd7 with SMTP id 5a478bee46e88-36f75a27e38mr8089948eec.18.1794072438631;
        Sat, 07 Nov 2026 09:27:18 -0800 (PST)
Received: from xploitoverload ([2409:40c1:6412:e5b:5516:cd42:6c8f:c918])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa999654sm16328165eec.27.2026.11.07.09.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:27:18 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: willemb@google.com
Cc: Kalpesh Solanki <skalpesh942@gmail.com>,
	willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] tun: disallow setting IEEE 802.15.4 and 6LoWPAN link types via TUNSETLINK
Date: Sat,  7 Nov 2026 22:56:54 +0530
Message-ID: <20261107172654.302210-1-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107162649.282982-1-skalpesh942@gmail.com>
References: 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Should this be
>
> Fixes: ff4cc3ac93e1 ("[TUNTAP]: Allow setting the linktype of the tap device from userspace")

Yes, will update the Fixes tag.

> Cast to unsigned short in these comparisons?

Yes, makes sense. Will cast to unsigned short in v4.

Thanks,
Kalpesh
