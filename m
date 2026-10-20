Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527697;
	b=3e5IoCZfQ9QLVsTbRQ5JgZyYI3W37/HGVUQLlsT6mT9hFgdQV/wYXIOo9cMrNHBXgN8S
	 jZR2vA/1Ix2tvuJE5wI3PesO/7cvadTRy6osU9hOmlpDnK7RQGDj7mT2DjN27ZJh6FQEo
	 WJb2nozjnCrcqZQuW43XGHSxW4q2ZMvwrvsaQjzuER0NfGAau3naFOll/oS1Av078Lc6N
	 xbQH8yoYLx/+wVSbQ/SRafDn7fqTyvjDpoO+lS3+cUt85GyBkwbydFRxNyDbUqyhViTtB
	 XzSjXrGQ1NM2oXdaX1jkWR4WD/mJFcy6p2S+podDTF5sNpniuJe7uqP/ndH3EE2deIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527697;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=aWr+EQV2AqXLdpHg6xfVKso9cQjncAIKwcJkZpbhOMQ=;
	b=wZoeynoCEM7dn810lzvX7UISxgyAbbfpFvlSHru6Dy+lIwDj8z0xg0/+DwcapnEHBQIs
	 LVX08VUbBrOHszcQIy9fyZ3dZ5Xt2CCKwWMLyKNHP8ACNJ/DzqD6qYC1aVzN3VAxqslTX
	 FWhXyGF7FHqJoZsJYkFQdTHwH1+j4S3N+LxGSY8eY9+eL3/u03KWnwhX4WJCxWccGonER
	 8o/L+QReOevUmRSzqud8k4C2oMSwkA1XMsVN/DG4dB1Kw+DT9qrB4MrxF4zRJgwCAlwkF
	 wj5h0xCKlfLFHkybQ2PHoiJTXKsXzt+IstJQdR0PMiIdPljl1Zg6KP5kuu6xslB6MtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=3VV6sUu6;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66E606A319;
	Tue, 20 Oct 2026 20:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B66E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=3VV6sUu6
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j8P2S4jmmz1XM4Tn;
	Tue, 20 Oct 2026 20:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1792527691; x=1795119692; bh=aWr+EQV2AqXLdpHg6xfVKso9
	cQjncAIKwcJkZpbhOMQ=; b=3VV6sUu6XFcb+0fHx+G4gb6Z9HSQ7tBFyCkfJS06
	uNZLdFRv6Vji+9LXIj0CLFlMq1R4qhJapb2v3JWUk06JasAkhhU9472dM+vsXo0p
	w77oZiQ843bFLG37mQdR1vex7UHHLVy7rF3+D/zlGW/gcRxNBpD/gYBDBNWQwGfi
	PKgMaNKgZc+SHkP7nEQYJ0UZ7CR8fBtG7rgEISKBmBo0wCc2EgabPZTB6HHfIe0f
	MJBFH7LSBDMfeNUPk+l2ZDDPRzb4g9YQMVQgkF1MhQKSx7NdLggX36JMiB8qOnE1
	mOHNbMYUhKGEsdJt/jkIBgNpbq9Nfrc6BySJq9dp+BkssQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OSQoDqW9Pjax; Tue, 20 Oct 2026 20:21:31 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j8P2K1b1Sz1XM4Tl;
	Tue, 20 Oct 2026 20:21:29 +0000 (UTC)
Message-ID: <9b33cc28-9e30-4bdb-aa1e-cd8dec149833@acm.org>
Date: Tue, 20 Oct 2026 13:21:28 -0700
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
To: Boqun Feng <boqun@kernel.org>
Cc: Vlad Poenaru <vlad.wing@gmail.com>, netdev@vger.kernel.org,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Davide Caratti <dcaratti@redhat.com>,
 Breno Leitao <leitao@debian.org>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-kernel@vger.kernel.org, Vlad Poenaru <thevlad@meta.com>
References: <20261019170225.729789-1-vlad.wing@gmail.com>
 <atZtYi_Xnz27O8Bp@tardis.local>
 <c3de29a9-8edf-4186-bc26-82d1d68c4c78@acm.org>
 <ateu_3PV81VuFK1i@tardis.local>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ateu_3PV81VuFK1i@tardis.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/26 11:12 AM, Boqun Feng wrote:
> Is there any context that I'm missing that you want to shut up this
> discussion and rush the change in?

I'm not trying to shut up anything or rush in anything. All I did is to
share my opinion.

Bart.
