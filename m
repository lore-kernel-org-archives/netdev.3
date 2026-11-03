Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793727103;
	b=hMyOq7J3c2eeQE0l9QvWTXMff8oKn+VjKvGr0/SC/Tel9H1a4NPhVkHAZzxOuYVFAKzO
	 I4gwdA7lOagQGuAuXe9ApvuO5R/J8xsgWWJXW7NSdaJPfPSJjrW9eVtxc8bVJJvvqXBuK
	 R3gF8rzB6G3IDta4iUGywebDFNRxPn4UFI49hlh9wzKshw6F7nqf6+AO9UggkL3OOHgvj
	 NsL9br5S5eJMc9kcsD3VsMhXW8WgzAVAIVjL8m2RHYvIpoYIVSRRyRMR00P18AE3y2Aay
	 WAfB6swM1XGVent1rKv1Bne1n4RYqRVfuQZ0hrw6n6QGuIlZ1liKN43/cLXfsiHP/zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eegksxV28ioEtuerGVBp7CC0Yc83uWN1TXj01mx1N9o=;
	b=4z/TRmKPHbauEf9CEPHMytkiFT4jUtGN6DAYIDWatyHwcGNAJyj/L4gQI+ueUumlrzZS
	 Cdd2BtVvFM7VZCw7iSRZnfPX7YWuUwWzBtk0AmfuYhdG4ck9wDhobJhqcVDJT6xR4HJYW
	 X5MPV3gJql0w69jGka9yxg6tJR9hwv7NlC6nDIuL906iUbcQbnmBgeBkqnR5ncE6TAiCt
	 DIESP8jxT68N98f3WhizpEd6+dBvA5mK9kEc5AcXpjCuiP01whjIgAPdWY18fqSA88lGG
	 zQG0fur/ustZPRtNsnmvvZ5naBlWE+ytqFdeSIqER9NU6UFuAJlYhRALNIy3Og2ucFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=lTDiRPW3;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636A9606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 636A9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=lTDiRPW3
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91c7a0c1617so71371166d6.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 09:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793727102; x=1794331902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eegksxV28ioEtuerGVBp7CC0Yc83uWN1TXj01mx1N9o=;
        b=lTDiRPW3Y6ch5A1zX6a3zNTWj4TgyztTahi0Cys6d5bDTqxZS9lmykFSclwgJLJ7ux
         4UhYk5JnU5t38+QCU1lvCarhWKktauquR/uw9dycOM31XB6mAFYzecttZ3TEvpduI3HZ
         j9Jf6zIZjBtpRFrebwPqmi5cYCW6N0sRkqiyasN/GIOahtO4A4xYw/lHaDP/SIcw6TgB
         8+FdGv8i+y6dUPs5EgrPzT1ZhHfBQJXqTrjcxXwIetMGE0E9CC4oZCWf5GPPMf25tPY/
         eI86R5ACmaAmezOi+6InPZ+J793nkHECn+Fcp0fPKGHibpK84qc/1ZF/5RsbOm45G3Qk
         LeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793727102; x=1794331902;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eegksxV28ioEtuerGVBp7CC0Yc83uWN1TXj01mx1N9o=;
        b=iK0PlGM9ZJFxnV9QsIuIZL+O9wb2D9GoYd+3CUmVDAydXEwK0JP5y4Wr22q6W/m28m
         Mez4fdwutdBcGrz8TdWL7iqNMBmH/nB/z5hidQNxh8osT/sRcRikMxw9syMsoIElxm0M
         VRNkqeDUWBb1lv/skCmm0tnW03aK+m2hzJjMJTFB4f3XncZPoeHwNs/blKJb9SFQSllH
         mawGhSkDyzRGKrulk4Kag2P2UMshOocdxqAJI9zPBEyBfoYaWz0kPXLF2T511NqME0NY
         Tq9qgkUTivGbIG6td/36AAFuGBPBl0YcqdIUR4XfTlLKtzF4Oqs9jEWU6cRFYmugW7ip
         TX+g==
X-Forwarded-Encrypted: i=1; AKwUvBx10RCo/5TVtHexw1jSDB41oqF7EY/ur9s2u+AmIHW3Y9BnGSeAY0dizASR7jaqLESFzl6+oGk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9enxzHC04+Ei5xdXIzEIb5uluuDsQsVD0gBLrZeganSeSWbp1C
	n3IH6wpBZWdSIjOiLosWKWLvgCMeeifTfoXLgVOlODg7AxJ4FFSJcwkEB/AdQfkxA9I=
X-Gm-Gg: AYBFou2FjAgmbpbpNVrBF1gY3zY524t0cW5MoIg+NVZW0uK3oRqI6QOlZWrG0Alf6eq
	ADFRMIaXeCO3zHecklXX9dVaFg6X3BXTg1IWeYVDeZ6A1VIiPVYlEXCN0FoWjajYkQ6T2TBVGN1
	VabiZvty8envh4P1gZjt9Yb6lO7+TdH/B6SGvN0zd/A4G5HwBfeAEvrmPmVWa2hzDYf8G0XYcSl
	AkVy7GzJA7pDo/oyB2luz6163MevgL/dKcNW7GCc7jaTtcvO24u/slytKzoGcP7Paq6HTDFwYeN
	nEegBMyxP/cDbgq1xt6SDRVCJvBwCKtByg7IXJ3szhP/RUtIAqYTSxgZ1hnTUsSG221tZPfGWZZ
	FMch+6xeGBEv1HjdZ2TvQdBVlwG1gQq0CQRFraJ/Oo/ClvCJ6nZRXaPr2NZToVa9/kkkIMVAvPJ
	yARo6r9uCgMG7/HN4C4vmfHVguR268uTxZYipLFjoP46Hq2j3MU6Fw3YC9P4IUJUaP0Omol9rUZ
	Wz0sGI5EsiyacQeis3mU6+svE0H7B50mcaYKP+H3n4RUBj0UDGMQ6xnNi/rR2JHWN7BOw99EhPk
	x+wo6XdWVOaVGjiSGeEyEXLtRVMZBPY5q5b0IyceEk+L1RJnbE25UzSyOZUEZflv9+g=
X-Received: by 2002:a05:6214:f09:b0:912:517b:40f6 with SMTP id 6a1803df08f44-91ca4b4d439mr219929456d6.40.1793727102334;
        Tue, 03 Nov 2026 09:31:42 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f254a1sm120862756d6.7.2026.11.03.09.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 09:31:41 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: Mina Almasry <almasrymina@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH net-next v3 02/15] net: skbuff: add skb_checksum_full() that reports failure
Date: Tue, 03 Nov 2026 17:28:00 -0000
Message-ID: <179372688053858.2.9209483466693222021@toxicpanda.com>
In-Reply-To: <CAHS8izMK8nrYny_jc-aTbjwP8tsDkY0a1ed7F=GfwzfXWm8o=A@mail.gmail.com>
References: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
 <20261103-b4-skbuff-bug-on-followups-v3-2-54ad0ab57614@toxicpanda.com>
 <CAHS8izMK8nrYny_jc-aTbjwP8tsDkY0a1ed7F=GfwzfXWm8o=A@mail.gmail.com>
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
Content-Transfer-Encoding: 7bit

On Mon, Nov 02, 2026 at 06:44:46PM -0800, Mina Almasry wrote:
> Hmm, but do we really want this intermediate state where skb_checksum
> and skb_checksum_full exist? Why not fix it in one go rather than
> little by little?

I don't want to keep it, the wrappers go away once the last caller is
converted.  I just can't get there in one go.

After this series skb_checksum() still has 44 call sites in 28 files:
11 in netfilter and ipvs, 13 in ipv4 and ipv6, 13 in six drivers, 2 each
in mptcp, bpf and pktgen, and 1 in xfrm.  Changing the prototype means
converting all of them in the same patch, and that one patch would go
through netfilter, ipsec, mptcp, bpf and the drivers at once.

It isn't a mechanical change either.  Each caller has to do something
with the error, and 17 of the 44 are in functions that return void, for
example udp4_hwcsum(), ip_cmsg_recv_checksum(),
mptcp_update_data_checksum() and nft_payload_set_eval().  Those need
their own callers looked at first.

skb_crc32c() looks smaller with three callers left, but one of them is
sctp_compute_cksum(), which has 11 callers of its own in sctp,
netfilter, openvswitch and act_csum.  The other two are siw and
batman-adv.

So this series converts the core users, because patch 3 closes a hole
where a packet that couldn't be checksummed passes validation and I
didn't want that to wait for the rest.  After that it's one small series
per subsystem, and the last one removes the wrapper.

This is my plan for everything, in response to your cover letter. I've
got a 15 patch limit and a one series per net/net-next. I'm trying to
make this as easy as possible so that they can be spot checked and
merged quickly. I started with core and I'm slowly working my way out.
I'm purposely avoiding "change all the callers" style patches because
that's harder to review. This is slower but easier for everybody, at
least I think it's easier.

Thanks,
Josef
