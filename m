Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108853;
	b=yBBwA/49BD5gSKsdzQ5aEuOIAVPIoLtqs+P4ToPSJjz1xsxJCSaE8XX/JjTGgLCe1Gqx
	 Fjr4o5Vn92KXRNMTHMyUfDd+r84ECX+ELf+5i9zKCnNuHbTl2P1j+57EX8vvFbA24iIMz
	 WWHK/QOI1sVZHqjPAx09hy9s8QEpWH6bYWNbQipudA2fesG6emrCOzeTPo5IXJBnNEkhx
	 ZwQKJJTimjiqsdHD5nXJ6DSxdVX+D1zBE3WNZkx73wFz6qEK5bC4BeOHjpRzJEN737VkJ
	 NJWGDOkBBDoC51cxRwlZdZpO2SxG7QTu3ViSWBi91oZILkqHfabUyeHxAQ3Ylw5THqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Vi2VyxWb8hUzIvesy3TGk19mK9cZ4B2w+p8Em2DTRI4=;
	b=RLMBxHiEZIzCc4Gpe0uhnrrZoIJGY7yaT6n3E5BuCIYk4i0PIb4UGSkEYk94cxj7DG4v
	 SkedHuGHSZiC+3ycQutXH3WsuFTpivABlrsk8H/hgCIKwVCQoPahST/FgEK7BKR4gA582
	 tQYzhFz19J2gPDnviRRKztE/B6PgnpLT0bO5Hajy2fCrSG1cSN1GkPOSU/L1ZjeErfagB
	 BwhftvttzfDa2wMd/3jGZv5RKl39a85m/tmk0aGZXaf5zQTrqaeTekBODC3dlMJDWfIdk
	 yfED7CUQrtE3GTu/1w6csnaphvS99K9iHKIr+lc2NC7IFrm2M1dv7yFBkYX+qRz439A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A54606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2A54606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b429f71dbeso4283243a12.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793108846; x=1793713646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vi2VyxWb8hUzIvesy3TGk19mK9cZ4B2w+p8Em2DTRI4=;
        b=B52Xihmri68zEQvOwl0tik89nRtTdSvySUKtMLXC2dQa/2PIgZ+TqYVkwSGWfj6CLl
         fmUxnQLmnJTCCasfhumf/8XYsj1jH9CNWubsIqmQo37PVxYt/Lfl0aDxbI+Gvl0wgZTV
         vHjLMOphw3xRMpdsdwPxgavAmAb8/neFssd1A1L8ci+yspEuWJtchXTVqEmlLO8XgcQx
         xoCVYSNUqrJMnbEhrgdfdGpf7Y4xJVvf7RX1KVEBrmtM06CSZud3KU4Cq6mJA/aJFF+O
         H/O2V7URqxLCi73ulwpwCjk3aXhqOib2v/f2/2yB8tuRo8IYv9MCuxgh+SrcAofSghCa
         d/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108846; x=1793713646;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vi2VyxWb8hUzIvesy3TGk19mK9cZ4B2w+p8Em2DTRI4=;
        b=Cgvrybaqqd4KeoEDLfrY1AdGRLkaAHuAEcRoXUL69ReahSOh6AMovGHl4ZH9IbFukL
         bHi3pZANhl1xoRElsDofkTTl83zhUc35+x7p85yqFd23NfYSPd/cjSO8XybrzNR+p5xO
         PBWVVK/n4VFgh5firofNbGi+eYkWF61HTu/svA3Vb9xbiRdiB6oEjsc+akO7stTtBqi4
         2JyaVtJE89H1UVU1YDB/aau17M0S45iPJeTIk80Zjg9kREGG44OIP3tOrTlsRjtdBXxZ
         Z+/UPKr4VH/Ut1nRSP4aejOezdYUMYO3B59NoX3D+HLpZ4vHq9tHNM1lPkuJVkKhC/uC
         8ViA==
X-Forwarded-Encrypted: i=1; AKwUvByWcFa6WBMhEB3p7FHQB6aUHTDkDEiEYlCvQEJnkyt5nw1CLY7N74RnJGi1hVhQ0TaMamtITFE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvt+IGH3QRB4BZuJ4ifZ978fMj0hpNWqawLoz7efKULCWwxRbr
	cOlM7mjCCORHuC0mfi7NPZ1EQFpjyVVE4IPQ28hbRvnI39RDxF67Wluk6/0UzjJcFrc=
X-Gm-Gg: AYBFou0rSq+WNVjIxacUaujExI6BG12QyemcoWedeP0iD/rCa3pYcld60qlyGnCHtkh
	wJcqOIYRCAEeCxHPk3aasQQj3xgtzzsb88BvLshc3g57Ov2AeLqthl5K1nj1WWg0DUOpBwhuvwU
	S+Ae60SCPjL6mWnFhz6iNfo58/LFv+A/3T3ZQ3HlScaKk4xxB4n5YdEjLQ+rPhw1u4TEl3Wr2UO
	fJzuSZEzcXLAe78aEF3op9qeDB6egb3b0R/ig6NtlMMl1S2ivLU2+l12OIdCVIVStT48exGuRqz
	jMMIUVBmjei/L/BWq5EZFzocv+YNIfunIYfiyJEEL1A5sII03VGyRZBFSF0qTIku2NPpouhQ/UB
	uClFi+3YyJMTAUwnJCrURqqYnED6zOuUKnedHRHR97Xrp+wCvxukNiMKNgdxA6yeroC/JlUxFwY
	rdwoUGxRLJvY6V0NiKnVjM0Z6WAOQpXyAg9Ktij/AS6R7fE+Y+E2g3XY/nnaaeiUithnj1jMjBy
	pMa0tkvamzmvOexG1EZ4yWNG0NeT6yH3NLBNE4cvM7rEyZDiQb8+S+LKL/5kdynVgqYsPnHsxgl
	h4BE9K7i8aJrqSc6nwVgqFIA6zJrDKQxvH/typY26vOI6YQdBIgs
X-Received: by 2002:a17:907:d649:b0:c36:7579:fe6d with SMTP id a640c23a62f3a-c46bddce8edmr1009655366b.11.1793108845951;
        Tue, 27 Oct 2026 06:47:25 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd5206dasm460325266b.33.2026.10.27.06.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:47:25 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:47:22 +0100
From: Petr Mladek <pmladek@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: John Ogness <john.ogness@linutronix.de>, chris@chrisdown.name,
	Sam Crossley <samuelcrossley@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] netconsole: allow replaying the printk buffer on
 demand
Message-ID: <auCraiuMZApQHiNA@pathway.suse.cz>
References: <20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com>
 <87fqxskdpl.fsf@jogness.linutronix.de>
 <at84qygscue8crQi@gmail.com>
 <87a4o0k3qa.fsf@jogness.linutronix.de>
 <at9qgBucVm-QHnye@pathway.suse.cz>
 <87zew0ifpp.fsf@jogness.linutronix.de>
 <at-Ppa86sBw7mO8W@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <at-Ppa86sBw7mO8W@gmail.com>

On Mon 2026-10-26 10:49:32, Breno Leitao wrote:
> A bit of context on the use case from our side.
> 
> In an ideal world netconsole is enabled from early boot through the
> kernel command line, but in some case this is impossible
> (linux as bootloaders - ipxe/sd-stubs/etc).
> 
> The other way to setup netconsole is to create a new target at runtime
> through configfs. Netconsole then only sends messages from the time the
> target is enabled.
> 
> For this second case, I would like to replay the whole kernel log on
> netconsole, such as previous messages. Something might have happened
> before the target was enabled, and we want visibility into that.

Just to be sure that I understand it correctly. 

Is the netconsole registered before it gets functional, please?

Is it possible to detect that the netconsole is not yet functional
and when it could start working?

I ask because there is the flag CON_PRINTBUFFER which should cause
re-playing all messages on the console during registration.

A solution might be to delay the console registration until
the netwok target is really working.

Another solution might be to temporary block/disable the console
until it gets operational. We already have console_suspend()/resume()
API. But we might need something new to distinguish it from
the system suspend/resume handling.

> That said, the "per-console counter" might work as well, since it would
> start as 0, thus, we know that netconsole target would be behind, and
> try to replay? (not sure how yet)

This is what the console_try_replay_all() does. The only difference
is that it resets the counter to the oldest available message,
see __console_rewind_all(). It is just a small optimization
when the ring buffer is already full and the oldest messages
are gone.

> That said, one way or another might work for our purposes ?!

Best Regards,
Petr
