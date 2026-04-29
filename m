Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F154439A06E
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504564; cv=none; b=ijGG+JymZ2wtX2UVa5QCTteludwdlEvYGRtac5+1n4M5LCBop53kI+Niap2byrcc8Hu1ZTPoCtQOxZEehDJ8B/Y5AVPcBwrOg37aFiTXUQmOS5CuKgSgTh8g9rX4WIZlQNYZIJJqhUzaEudY8eLEAIgmr+5hEcAbVE+QIgIe1lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504564; c=relaxed/simple;
	bh=LjR5XzJ8aB8mj5TA3YHso2uuZl4hRC3NlgNQ6/fMaJM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tYCI+GmzwXHi+JvLFmxI+boUUgN8xvB9KLGi8hlr/xJR9+4aik6Kdm1JnPMcAjs1JHiBm2khlQrYvFeaRm1DDY4nTMLZxvYGLFOTs/UbRabo0wmZo5X9qPlt5DUqCVjekuTWqtHapJRd0weo/HYIw2vIbtKnfZvqoDyGTPJe/QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy5mxPK5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy5mxPK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBF7C19425;
	Wed, 29 Apr 2026 23:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777504563;
	bh=LjR5XzJ8aB8mj5TA3YHso2uuZl4hRC3NlgNQ6/fMaJM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Hy5mxPK5/SwV7iJihQ/ZUfpnmh6YVPipjs9JHvqGzWECBkb808E3MxgloiXqRx6M8
	 XUDMHKiCcdMfbW+sDzHvMmkl10xRke39O5wpPuB0BO4R7IJ6p/lyn+JMRKJZdztq5w
	 Kll1vOCq0YnIObkLL7Xvr2aYmZClfMGY6oilzgqKVVpYyFccl9vV6F8nR3yYqeZLPc
	 Ry1GFa79WXtinqqBeSa2pQn9ABX7YflXxSk2DC4nCSncI9ILQgLCiJRyMDgFRGCeZZ
	 HAB0WbIX6kqv8871bM4aUEM+t9OGXh+GLCup7ze9I0wIjbFEyVyyYaYPQytPZGOjsb
	 bsryAn1M/kD4A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4C02BF40078;
	Wed, 29 Apr 2026 19:16:02 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 29 Apr 2026 19:16:02 -0400
X-ME-Sender: <xms:MpHyaWJsOT0IidO6UXhuzYaYAKaYqbKiQ2lMehNNby0kpIAvs6-SCw>
    <xme:MpHyaY8FumrCRM7W35v_OFiYevBQW-gbjrFs6w2cSzEiibl-XL6bE_tgXl-rLow5q
    LPaqEy5sIJEb3SIItJefvW-TmwCxoSU-mXnxjkL3fGbsgPqCI2s5VY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekheejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhohhrmhhssehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhgvrhhnvghlqdhtlhhsqdhhrghnughshhgrkhgvsehlihhsthhsrdhlihhn
    uhigrdguvghvpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtoh
    hmpdhrtghpthhtohepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhrtghpthhtohep
    phgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhrghrvgesshhushgvrd
    guvg
X-ME-Proxy: <xmx:MpHyaXsFvDDM6u93AZUYkWn559BErUKzZU4UCeQ3kr11r0mpte9DMw>
    <xmx:MpHyaUWqQ1scZ1kuWOahM1U9hyN_3_CVUQSLZ3hobFXYzhq73UfGPw>
    <xmx:MpHyaXyYMETahNIPDpc9st44SU4ZKbr2a3fRhMUOSYT8YPz4I3nH6g>
    <xmx:MpHyabG_MYlyaaAlFUJCgil4lr5zu-SWXY8VSgNX-F_OcsdyfrYx6g>
    <xmx:MpHyacvd5BnpeDHoo8wLb3t_sW_mrvx_7EJn3JGAp3_-vvCAw0_greEb>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 28519780075; Wed, 29 Apr 2026 19:16:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6DWjhiQzWgR
Date: Wed, 29 Apr 2026 19:15:41 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "John Fastabend" <john.fastabend@gmail.com>,
 "Sabrina Dubroca" <sd@queasysnail.net>, "Eric Dumazet" <edumazet@google.com>,
 "Simon Horman" <horms@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 "Chuck Lever" <chuck.lever@oracle.com>, "Hannes Reinecke" <hare@suse.de>,
 "Alistair Francis" <alistair.francis@wdc.com>
Message-Id: <5cde3b43-eea4-44e8-8ad5-f8b494534237@app.fastmail.com>
In-Reply-To: <20260429161338.6da2b22d@kernel.org>
References: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
 <20260429161338.6da2b22d@kernel.org>
Subject: Re: [PATCH net-next v9 0/5] TLS read_sock performance scalability
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Apr 29, 2026, at 7:13 PM, Jakub Kicinski wrote:
> On Wed, 29 Apr 2026 17:48:07 -0400 Chuck Lever wrote:
>> Changes since v8:
>> - Address review comments from sashiko
>>   - Patch 2: Requeue partially consumed skb to prevent leak
>>   - Patch 5: Re-check sk_err so RST during flush surfaces as
>>     -ECONNRESET instead of EOF
>> - Address review comments from gpt-5.5
>
> Is someone running gpt-5.5 on the public submissions?
>
>>   - Patch 4: Restore msg_ready early-return in tls_strp_check_rcv()
>>     so the queued strp_work doesn't double-wake the consumer
>>   - Patch 4: Add tls_strparser msg_announced bit so the recvmsg
>>     exit-point handoff doesn't re-fire saved_data_ready() for a
>>     record BH or the worker already announced (rx_list-only drain
>>     path)

I'm using codex to review the patches.

-- 
Chuck Lever
