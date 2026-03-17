Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBF7219303
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708845; cv=none; b=n4KHDZ2p5d6Cq8EdjJso3HbM/C/9D0xuZootcSPYK8QSzE84+3uHFBWxdLw/GCz2ONDVckfnSXjsbVVxFeFDSyx9Kn4eF4HO54GwqkhNBzTPAOoqjVlbt8i5yKWDn12lY0f2H5COoI6ORBqNF9Gtp95TuAfJ3iII1wg4+eRTMAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708845; c=relaxed/simple;
	bh=44Ze4dVL3mYu8Oe0LqTPrkMi5eSbIRuQ2466tAfe7dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/IT98UjuMDmsiSbecAXnbiI5vrEbaUvn9q4cpkhtTtyXhiFkWddOkX43MfZC5wgR1wdsbqgyQaJQPAbzofwX2FHFQTxH4zAModsyuqdbxUv5kWPttpaQomtSswfyJO/VVt/tmj2HnwYLGmyD+iMQVQKkRbzcj4OcqBaOGjDito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=mqB4mNZL; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="mqB4mNZL"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1279eced0b9so7024756c88.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1773708843; x=1774313643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2qAlWaHlE21gWiX1Z5q7/JbWIU/cmVtBAhix3e1Z4fA=;
        b=mqB4mNZLhEPCwXtsEAWdyQP+L4g9HdzQheGeDt+UyQ8RwxjybK03/iIzhIZ/Si42zu
         Pktp8YM7lA4KBvx56rvqtdIETMugWR3vNa4CqEwTalxKRItQLtf142WknYoJs2m9EUMp
         MQr9X/ik4QnJief/nj4FKQF+p9MvUGFZKTlQMqwuvC7sh7lTrntW8STRUuj2XZ9Oy2qr
         iZ+Jd64g9sXl8txEco8BEPQC64bbfgZ+lTV9fZmkYjMzG55hFrnZL2mUqV0fRVVUZvsR
         dCGbZK3sI8Y1yhVSo0PWJteEAzfeeQwMgjSh6vz/x9w1Wr4eHn/tS/oUwef2IQZky0ON
         d15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773708843; x=1774313643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qAlWaHlE21gWiX1Z5q7/JbWIU/cmVtBAhix3e1Z4fA=;
        b=rkX/+QV6gEhDbX89Cs5jufOBUC2/JUgNMp5WJbZxTo7ic+Nl7auA5oWHwkLPAlERGC
         NcCndfDfmiY1QZk9eIwMag3t9MjA8J98HiMfA1IwI1Hb1BRGfY2e1JaRKDcP+H0kZjcn
         MEf3hVgPwe5MCeYIJZQhuEy3AoNKLufHoyxOAzkU9os1kcIMG9mdxvs5Wbq/rb04Jm4B
         k32BnxXiFrkGsWAT8CJoYaBxr+krhJitHtbTwyCp2cYX+L7SaC1EpmES9+nYlncjSzsG
         u33DMjoi461lHCxqDL6Z4WoCWGDWC2CKw4JvslwKXnfrs9AvCtGAL4Z3/8/ME6JAmHnc
         Svhw==
X-Gm-Message-State: AOJu0YxZsgDnuFibghqwofzYJ1cRSxqhGLlExaWsqZE4cfrmXNOlQ4a5
	UCWCS4SXnXo00MQC/NWiFcuaCjMOQDNvs+invrHc/evEmaGgmA/FSwThMAFH9MYElQ==
X-Gm-Gg: ATEYQzzzBpvvjKO2TwxS+Lx9FQ8t4x9tLjVurWRtk39GUFc/1QU2/sQRGtOK7xBN2AF
	N2xo/XclsUSerLl1+C6IBi6bLLriOVvh0nG4LipM+n940/UEGdVoqfs19IX03v8wTJFovAfBTem
	6xgEsyJIB8ldvyWeptXyevYgsHazpfGUzosEhNdlr1R/MRAbNxS2UnEDhcNaKKuNP0XXSVjGKzu
	bThklGGJ5rBwdPC6eXkWZkq0UvRejHdxdrRqtHDoUb6LVVnt0WOCs6aejQ3+Qc+9DatOxqme5VE
	qJub3z8RF2Jg/vtvOZyN8SLxmfYLqH/rc4HvPIH9giMpnaDuZIuMpRbW158vcJkg//ZWUEIjBXb
	j0sa3oTfqr2iDfvP0UJ5fM7+WGu6WgAobPPXVWDkOAWhW10MxMyIU4Xq48QHD9dyn3YKrGtjcQj
	hiUZZDU5RlznYqq3eNobqYAPuo15zfZA==
X-Received: by 2002:a05:7022:4587:b0:11b:99a2:9082 with SMTP id a92af1059eb24-128f3dacfc2mr6583839c88.15.1773708843370;
        Mon, 16 Mar 2026 17:54:03 -0700 (PDT)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f63baa3dsm17060108c88.15.2026.03.16.17.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:54:03 -0700 (PDT)
Date: Mon, 16 Mar 2026 17:54:01 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, bestswngs@gmail.com
Subject: Re: [PATCH net] net: bonding: fix NULL deref in
 bond_debug_rlb_hash_show
Message-ID: <oiy5pxnxote673yybww4ztzduvlr5etgit64bkxamsdvg4gnpe@ohbmrzgniyko>
References: <20260315194404.579122-1-xmei5@asu.edu>
 <20260316170822.3e35122e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316170822.3e35122e@kernel.org>

On Mon, Mar 16, 2026 at 05:08:22PM -0700, Jakub Kicinski wrote:
> On Sun, 15 Mar 2026 12:44:04 -0700 Xiang Mei wrote:
> > rlb_clear_slave intentionally keeps RLB hash-table entries on
> > the rx_hashtbl_used_head list with slave set to NULL when no
> > replacement slave is available. However, bond_debug_rlb_hash_show
> > visites client_info->slave without checking if it's NULL.
> > 
> > Other used-list iterators in bond_alb.c already handle this NULL-slave
> > state safely:
> > 
> > - rlb_update_client returns early on !client_info->slave
> > - rlb_req_update_slave_clients, rlb_clear_slave, and rlb_rebalance
> > compare slave values before visiting
> > - lb_req_update_subnet_clients continues if slave is NULL
> > 
> > The following NULL deref crash can be trigger in
> > bond_debug_rlb_hash_show:
> > 
> > [    1.289791] BUG: kernel NULL pointer dereference, address: 0000000000000000
> > [    1.290262] #PF: supervisor read access in kernel mode
> > [    1.290494] #PF: error_code(0x0000) - not-present page
> > [    1.290724] PGD 102a98067 P4D 102a98067 PUD 102831067 PMD 0
> > [    1.291013] Oops: Oops: 0000 [#1] SMP NOPTI
> > [    1.291202] CPU: 1 UID: 0 PID: 145 Comm: exploit Not tainted 7.0.0-rc3-virtme #1 PREEMPTLAZY
> > [    1.291555] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.or4
> > [    1.292058] RIP: 0010:bond_debug_rlb_hash_show (drivers/net/bonding/bond_debugfs.c:41)
> > [    1.292286] Code: 83 fb ff 74 3c 48 c1 e3 06 49 03 9c 24 f0 00 00 00 48 c7 c6 d5 aa 9d 83 48 89 ef 48 8b 43 30 48 85
> 
> Please apply some critical thinking to the commit message.
> Do you really think we need the code disasm for the second stack frame!?
> 
> Please trim the crash dump to what is relevant.
> Around 20 lines of crucial stack trace and crash info.
> 
> Spend some time each day looking at submissions of expert developers.

Thanks so much for the advice and tips. The v2 was sent.

> -- 
> pw-bot: cr
