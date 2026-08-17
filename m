Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6163F88B9;
	Mon, 17 Aug 2026 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980401; cv=none; b=ed+lF01Qjc1AtmJ2LtbXA+gqSZ9uKk/IK7EhIKiW6CSAs8+gZVn//8+xF8Z21LATBs6UCoLBVJ0HzPFhLRb7YdXKuJceMs9sXz/O14ttFH8UX1S6N+Xs4OToehsbjFwhXJZlls8vUrl5c+oiObKWqCSdgdaJPIRwoPdrPrND0DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980401; c=relaxed/simple;
	bh=PuBdjDaQtFHmwnAMV12FVO9YvRHGJfmJbq0uO7Ycav8=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=a7D+BZBzlIJkvw8bQDab7xZ55l6SCVR+QxooCzsecFyRi/rJyxCuoElfAbtpEl+hdHl4ZjY5tH/DVkIdIqNU5G6IW6xuS41FqwwPiWWw9MP0AKXFCvRzARzjkoT3LJR4LYFMyiMySh48rBbJybLTD06GEK8fgE+Pyv0tnpVD2JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=Ds16NF3n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eFIhXFDI; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="Ds16NF3n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eFIhXFDI"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DDD28EC01B0;
	Mon, 17 Aug 2026 11:26:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 17 Aug 2026 11:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1786980398; x=1787066798; bh=0cGsMpqaLHnJjEiP45UxS
	j/ScENAWPZc/0EI5jwdR+c=; b=Ds16NF3nBcwM2UIo9x6MYV0SnSSw0i7fQvCE8
	v88HuZP1Mvwos7Kp0ZJWgOXIiHwK4FmmKJdEHCmp9cYq57oLKWa9hNsLhfCNUBdE
	d0x9nFoVic/UkbOvGgJ97VCt0pbKMuJcUXEFie6REbId65LOoIZuXcgKpm+OZ5Ml
	QaojYc0kxK3+iuiRtrF4Fcy/9z0Zo4r7Qawqe6lDJPX15OHQrH3r/Zt02nvyEFnf
	3LCULWRoRNUTYqeujFPCiOYlbM7NSkqlVJMLD/rGu6AU7fTewjMMzAzmgxjj3KWx
	DBLNTPsOj+0e1ymGUMiU5srZJmC/GoaGiuQnltG/C+/ZgbNng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786980398; x=1787066798; bh=0cGsMpqaLHnJjEiP45UxSj/ScENAWPZc/0E
	I5jwdR+c=; b=eFIhXFDI8x0rfAjZofnWzb//EkjOz6mNKjEq7HQgowwCet4mD27
	OD85UVF6h1W9Noc/iyoJNNo12RTEFhQRNnxe/Q8rwS7xCy0SX7nIleR3HfRKYAaK
	7jRTRqK/2kQwLDepRroB7T3n9LiBgzzhM6mRtStU+OS3aDmtlbOd5Ccp+bl7oOiy
	w4dOL4m7ckrwAad1Im41dqbKoA5yheIzdOdwcwmHCLm5NjOUq6ygQIs6xfSuJDT4
	FWtOK9FkS4mjLT6+k1O/c5yR/lF6iSvOKO5X10Up0x1Ttxb7G4YPGPJneWJM5IRN
	s6YyGYQTNXNbI0XxrbP4M67f6IYiSuIoIYw==
X-ME-Sender: <xms:LiiDag1D9zOCNMd8h_BpxSEDPJ3drkcjXzXUxzjrOKaOqt53CoSYPg>
    <xme:LiiDapXA-b7BG90K2QP5l9bjHsbqUdc5aYstF6cyg85QD7gWAm7pN2m33ElAUDq9U
    6zhcGOJKwe2EBL__c8pv_a97H7a1eH5zaHAPPoCKnMiXSyRypkoSdYF>
X-ME-Received: <xmr:LiiDaiMhB2qY_bsB2H_v1QomgMR-AM2nV1rvy_XG4yqOJURM1rIliMzEsqEU6CNNe4ZhMw>
X-ME-Proxy-Cause: dmFkZTFwc9Nhrs7V+AFNVW/mkhuDwOMzy6JSRPmnSsejMpA5Pw/6EWyIeCWq9PrdjKwiPq
    oQp/aNX9VQTh4g1Vtz6CNUjPpfFu29MreIGX8xnWFQJjuHD5vRUtcuP1SxLu73gu2X+wDj
    UlSnBsKDPqDYmG8mFBHYe28NvSwFV1dX6OIlR9VXnag5mH+IbHRHOFuxcQJledRtL+w1rq
    QX/K7BoerIaGsHCZfWUkATV7fEG7qsVROECDB/jHgv25g3YaXM8wEnRzczFUlwiFnaP3/Q
    zyFXASeTnQJmTJMiRqFf6YDH+T1UVR4uwaB//L2tdxnKxmN6iRpbF6VOYAZX/jTJ9yamH2
    wRcakU8g2AJP4PNpPYrZmMtvwU9oNH/LGenNR/Sch8cCUeIsMrmnsmRIi4CS06LPbW5dql
    bl6IKP8H1QlC7fYy7u3bH3f8QLtvJSS2myFdJMaJnoqRqCXlDalV2aLU5Qh57gcIMnTqao
    /ZEtT/x+nfQnn36RYaDXHkW9X6QUI/OIX9hu5BJhTb8dW9r11wL207R5ZZxwEbY8Z4Do1U
    ygBzfvrIU0qEjCKzCc0kXkxiHzQAS1vWVUaNOVsqV8cgh054iiRAg2lYA65el9nAFRSXw5
    V/c8fP4y1HV/L+1t45mPJlKV9b0f2WY1JE2MxxuJqY8L+ec+vZsRpHe//Y6w
X-ME-Proxy: <xmx:LiiDas1g92n7_tMc_rJcYQuiQV4Iu7lVeUiWhfbT2hXfiQJz1shxKw>
    <xmx:LiiDamSAEzL6aeeme11dGvtQHRBV-VbzLQSAAcdwTohFVtZzG74h_Q>
    <xmx:LiiDanntCKmvqh5RLN-gtrRBA57Ypoq5JMzR_CODV1Q1n23wbglwZQ>
    <xmx:LiiDavMLBaDK-e1BGORlvFSha958ge8cwsl2xuwlL8zQprbSXWC9ig>
    <xmx:LiiDaryYl8t1bFsEiUyrraQhcEqoJNYNzoVLJxAXIVci96RNtm_rv1QD>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 11:26:37 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 7226D9FC70; Mon, 17 Aug 2026 08:26:36 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 6DFDC9FC46;
	Mon, 17 Aug 2026 08:26:36 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <hangbin.liu@linux.dev>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
    Hangbin Liu <liuhangbin@gmail.com>,
    Hangbin Liu <liuhangbin@kylinos.cn>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2] bonding: fix u32 overflow in compute_gap()
In-reply-to: <aoKwp6gTtSrnzR2n@fedora>
References: <20260814-bond_overflow-v2-1-d3fe588ad167@kylinos.cn>
 <aoKwp6gTtSrnzR2n@fedora>
Comments: In-reply-to Hangbin Liu <hangbin.liu@linux.dev>
   message dated "Mon, 17 Aug 2026 14:56:39 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4137412.1786980396.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 08:26:36 -0700
Message-ID: <4137413.1786980396@famine>

Hangbin Liu <hangbin.liu@linux.dev> wrote:

>Hi Jay,
>On Fri, Aug 14, 2026 at 01:39:23PM +0800, Hangbin Liu wrote:
[...]
>>  struct alb_bond_info {
>>  	struct tlb_client_info	*tx_hashtbl; /* Dynamically allocated */
>> -	u32			unbalanced_load;
>> +	s64			unbalanced_load;
>>  	atomic_t		tx_rebalance_counter;
>>  	int			lp_counter;
>>  	/* -------- rlb parameters -------- */
>
>Sashiko reported that on a 32-bit system, these s64 numbers' read/write
>operations and division will tear. We need to use div_s64() for divisions
>and may also need to convert the number to atomic64_t for read/write oper=
ations.
>
>Do you know how bonding support works on a 32-bit system? Should we handl=
e it?

	Bonding should function correctly on a 32 bit system for as long
as the base kernel continues to support 32 bit builds.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net
