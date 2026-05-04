Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8889D3DF019
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910375; cv=none; b=AeVlqoJ2rhh5zWudeKJkW+oIF/UrK0MqM77WYN4Hg3cyauQ0BPAZXnyntghvnYAwFxeOH5OTXxmlcIrowxMiBIUC6PhADc+pugVhr0fyLE+cg/oLWvqS5gcQrp8kkrJKAKb6/+JnumqFnoZMjLcHFIHM2ot6skF6c/yqM/SayOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910375; c=relaxed/simple;
	bh=xTd/dv1zHBWY+66Qs0Ea3v57289kHiF5l1lPTZVm1mI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UvmxWbmfPZN3KwUH5Aiv8D5V5W7PFpUbeBszhtG/muNP7Uxb6nxU8ju17uJgSVTiMdNrXKPY1HHnj3A+X/4K9lnUPPVMAFWSMquYv4+H5qcL8qgM51ahMvW99suiIYWx3BNwHpYc0vNNctBnrCovg+AOg5uIrEh3esrutPsy0bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBWaWdaj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBWaWdaj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB79CC2BCF5;
	Mon,  4 May 2026 15:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777910375;
	bh=xTd/dv1zHBWY+66Qs0Ea3v57289kHiF5l1lPTZVm1mI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=OBWaWdajTeiOwbQCy/9FBz3ml5nHfzL+zbmaLo5fw6f76ZBmacsixqNc2yhpM7TQd
	 1LNggXGChiTi0jqGGaxXPi5LvmEw/mghSb97IWwG6RqQfm5KJxtXP8JsmyW50A/rn8
	 zRXEdcNGddSnuq77VkM9xmx/lbWm0LwSO2irNNZwR9jP4xSTyrJ7H+FLdy+pTc6/VM
	 TnMJNPSpT58Gt57qXa5SYmKwi7jfShX4Sn89ZFwm9sp1moJwxxGPOWJKgG/f1/h0Xk
	 OFdVTBIrvfOKSTcFt5SM600S/rlhvCLaD5XYClgbJrfxm/aL2yhb1hm6ys1gqKQLJO
	 FOzfIUD3nYbtQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D4F32F40085;
	Mon,  4 May 2026 11:59:33 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 04 May 2026 11:59:33 -0400
X-ME-Sender: <xms:ZcL4aanZV0puZ_o_ahyYIf8VrzGY51XbZ9vAdXRTL2x7qPeYda0NWA>
    <xme:ZcL4acpWUKZe1nL13raeefQyhPBumHI7kYNBVlLOzNz6AthyyR5izVch664pYKM4d
    r0MZkDeS42cVS4LQ27BxKRQ8mRNropKOdVF8YPG6uv7mF_Ep6lv4Z_X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelledviecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:ZcL4aeBaDX56RUn0swi2CbHqlnf_xuQneFIOQSqWfqCVaIdOqjfrRw>
    <xmx:ZcL4aXsMoIG30dxNpwGxylfdWsSRUQ3D3ga6KTyhxilV6HFYJKTKkg>
    <xmx:ZcL4aUQ98eSqO_o2VX_JKJeZzLnpLWAfGrqBRFtV2okOIZYoqmxoGA>
    <xmx:ZcL4aWJnw3IR6f2biOpR3BO7lH1SPJngCfDDkw77unKf0mHLDnAUJA>
    <xmx:ZcL4aftNG-nPKeoxjkzupnd5mByvlkexJ3NjwFtsv0_vlS1ULGTUaRv8>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ADE90780070; Mon,  4 May 2026 11:59:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6DWjhiQzWgR
Date: Mon, 04 May 2026 17:59:12 +0200
From: "Chuck Lever" <cel@kernel.org>
To: "Sabrina Dubroca" <sd@queasysnail.net>
Cc: "Jakub Kicinski" <kuba@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Eric Dumazet" <edumazet@google.com>, "Simon Horman" <horms@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, "Chuck Lever" <chuck.lever@oracle.com>,
 "Hannes Reinecke" <hare@suse.de>,
 "Alistair Francis" <alistair.francis@wdc.com>
Message-Id: <4f3e1e36-1678-4e5a-b7d4-81eba2e1df11@app.fastmail.com>
In-Reply-To: <afigKenambAyKkhu@krikkit>
References: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
 <20260502180415.0b0bf12b@kernel.org>
 <2d2b5da3-3bfc-4882-8886-8f20b61254e3@kernel.org> <afigKenambAyKkhu@krikkit>
Subject: Re: [PATCH net-next v9 0/5] TLS read_sock performance scalability
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, May 4, 2026, at 3:33 PM, Sabrina Dubroca wrote:
> 2026-05-03, 21:34:01 +0200, Chuck Lever wrote:
>> On 5/3/26 3:04 AM, Jakub Kicinski wrote:
>> > On Wed, 29 Apr 2026 17:48:07 -0400 Chuck Lever wrote:
>> >> I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
>> >> NVMe/TCP) to coalesce on the use of read_sock. When I suggested
>> >> this to Hannes, he reported a few performance scalability issues
>> >> with read_sock. 
>> > 
>> > Meaning, this series achieves.. what right now?
>> > I mean - the headline is "performance scalability" and there's no
>> > performance testing result in any of the messages :S
>> > Patch 5 for instance "seems logical" but how much difference does
>> > it make?
>> 
>> The cover Subject: line has not been changed so all the revisions of
>> this series can be located easily.
>
> (not to bikeshed, links to lore also do that)
>
>> The cover letter makes it clear that the series is now only a clean-up
>> series. Since async_capable is set to false for TLSv1.3, there is no
>> performance benefit to these changes, so I don't intend to post a
>> motivation for it based on performance.
>
> Maybe I misunderstood, but I thought there was a somewhat noticeable
> benefit to the "suppress spurious wakeups" patch (not +20%, but at
> least improved behavior for some users of kTLS), and maybe the "flush
> backlog" one.
>
> Patch 2 may still be beneficial (though it's now mixing 2 separate
> changes), and patch 1 is a very reasonable code cleanup.
>
> Patch 4 does feel like a pretty large amount of churn if it has no
> observable benefit.

There is potential benefit to eliminating spurious wake-ups,
but nothing I've found to be observable at the application
level.


>> We'd really like
>> to get TLS KeyUpdate working for in-kernel TLS consumers, so anything
>> that can move this process forward is welcome.
>
> But net/tls doesn't need any changes for that, right?

>> 1. The in-kernel TLS consumers need to reliably and securely handle TLS
>>   Alerts. That is coming in the next series I plan to post.

This series will make changes to net/tls/. 


-- 
Chuck Lever
