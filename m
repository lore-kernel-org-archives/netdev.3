Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517201;
	b=KBhKtvdUn5DKklvMgagZivdM86SS6OwoR5xNEahn9CODYqJhC67Tpq6xtg8bBOd6wf+/
	 k0q0ISIoJ+/Uu4iQeFkiL/ZO+ivtV/3AF3ggDJvE/SC3N+cReOwX2lfksaBU30bSXFezL
	 2eGSpuRrf7atQ6mrF+AAtP4MW/wyn3kDZgN4JxAYF2m3hR6A6zZkPT9a1sbDnl7dFXmxM
	 mlCB3JtuwRaQ/HMxbjFzquWCtCUDLf+hiA+DgER9+iFcJwEFjizkrO9cOquinSffZki+B
	 G1czRZAlx3kyAfhvJWyrGeME5qxwuaX52VbVJXWylNYaNbaMjtebsM8368hWRGN0dgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xxtVsz/9fTEkFUUUlca+LBzizht3nG5heSrMXMBvp4k=;
	b=5OHOZlCZGH2Dz0fH0X86P1zFr3X9aze9K7JhAhCpxidpJjXt9DtwrF45ToAZrr39uPX9
	 XcK+EHNCRT4DLWjGz6ABE35s2GLI/gBCwHSbQHErP4Ado+3ieYrKtdEUcxGDzPzvwyw/D
	 TroxzLhtf/uwi2DwvbzoRr/5yfKrrVbMhWusrSulO81aA7vo/MBj7nB+JZE/yv1YzbZ72
	 oJl13MKvy3xX/ExBidRdpB8mIwPubsPhMz1GcYbM8SH0+CiemVm9LBaE8332zGQm3gOXj
	 zAEWCRBNYMTgP23TJOSDZsu7kLXmR+Epx6nJuWMkKQoM/m7KKeSGQOhg5hjg25xvD3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=idHKhe+E;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA25606A31E;
	Tue, 20 Oct 2026 17:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BA25606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=idHKhe+E
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4j8K8c2XBmzlfvpn;
	Tue, 20 Oct 2026 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1792517194; x=1795109195; bh=xxtVsz/9fTEkFUUUlca+LBzi
	zht3nG5heSrMXMBvp4k=; b=idHKhe+EEyI2vuxnGnIiJXMHvWMU7coVh8uS7ZkF
	yA+ArdvIEe4nhbRjHIlqaaXOj77P7cx6darjm2uO6inC11cQcSSHypSboHZFJq7j
	g8mwlILW0OdB5yKzC6ZWh1oIXmILaNpq6B7qoKqGY09ROPppTMP7c7IH7om1OM7+
	K3hac5oDobpzHrt/8mafm0MKnhgFL3+yyPogNhexl678bG4oKqDEHcnyuEQjODUd
	6rxsCQc/yzuuk4F9CNTo4OOOUa/jkYj4EyM/UhtAUZ6Cl6GZ1JFUGFJlUl7fsHD4
	41VFIDbB8Hf8Lg/LMcR97u0EUZrKfeOiA+9e3ibu53x/XQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9z7hwZH2zhOM; Tue, 20 Oct 2026 17:26:34 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4j8K8S3XmWzlfvpK;
	Tue, 20 Oct 2026 17:26:32 +0000 (UTC)
Message-ID: <c3de29a9-8edf-4186-bc26-82d1d68c4c78@acm.org>
Date: Tue, 20 Oct 2026 10:26:31 -0700
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] net/sched: don't wait for RCU when
 destroying qdisc lockdep keys
To: Boqun Feng <boqun@kernel.org>, Vlad Poenaru <vlad.wing@gmail.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Davide Caratti <dcaratti@redhat.com>, Breno Leitao <leitao@debian.org>,
 Nilay Shroff <nilay@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Vlad Poenaru <thevlad@meta.com>
References: <20261019170225.729789-1-vlad.wing@gmail.com>
 <atZtYi_Xnz27O8Bp@tardis.local>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <atZtYi_Xnz27O8Bp@tardis.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/26 12:20 PM, Boqun Feng wrote:
> I think my concern is still valid: for lockdep PoV,
> lockdep_unregister_key_nosync() is an API that users have to use it
> carefully, because it leaves the unregistration process in a stage that
> you need to guarantee that the lockdep key reclamation is delayed by an
> RCU grace period. Or in other words, do you have a way to prevent a user
> from doing lockdep_unregister_key_nosync() but kfree(key), or some sort
> of debugging to find a mis-use?

Kernel developers are assumed to know what they are doing. A clear 
comment above lockdep_unregister_key_nosync() should be sufficient.

Thanks,

Bart.
