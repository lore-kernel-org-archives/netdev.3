Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715522;
	b=wCBN71YaSIHTLDnfCi6u6F8sHELa0U1yEhQiDVFIiSxWfEN3Ak5nyaEGCQST6aacSNvj
	 JhGUyfvKVdAuvBP6sxntUioP9F0Cr4g8i3ElhbcfqzpSchH6K+x29xEYrxKz+jVsS14uE
	 KFLFkmpmpNb9lfocTryIe36L067s6ETQHm0F70WDJQv9uRrBL2J4C/oK4ntLqmC0YEFGe
	 GZ/xO57WuA7QMWOl3HTSkq3f/6yknbYvVVZto62kluc8xVT+4Q0yTAedOd5uzwYX1L0Wd
	 dKMv/dOVF0CPo/6yLZjecbpBosioinBqNpNSTptcDG2yRWkRo4R/Utp33ab7s3k9d3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715522;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=87L8NH0chbxJMXxlwkxaucZepbhcei/lYwpnUvY2jS4=;
	b=KJfdI0IGPruP2DxuoeBvPL/zjs51jZ8pdagd2D3zAYWvgmMINF2QybgGCDgUFn9jDE3y
	 8i0EP9PYruLhrhCGcHAFs84txDcBz+llE8CdVgE8yIXtx/fp98+4i7Kk60akOKUn+PH1K
	 KStHiWBf1JA7kgm5ypbgkKpfm+4JObNspfQjGDGtwtT7WdEC+D3rVX4WRD/yTter+u5Hp
	 2vx5HQaPFLkUdY8JQPq7jJeAjplXsOEyfGR1zhwTuWbOEDteb8W628bpFH4JcAuerJszN
	 GR6VabZ0ck4aVetRijVciieW+/0N0B/KqzSgvwYO4c7C87hx6xeBApX4lOwc2zOhg2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IRHMtWVE;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UgDLLBfc;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA2606A32D
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52BA2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IRHMtWVE;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UgDLLBfc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793715521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87L8NH0chbxJMXxlwkxaucZepbhcei/lYwpnUvY2jS4=;
	b=IRHMtWVEaCXcKVrnszruv3kFHaSJccvoW+KGOCSMNJTSrjFKUSTRy1XIQfgHD2WZI2lAw+
	pluaZQCPEXoLi1/0FzdHeHUCnPkWGpCoXYkpsjlD8r742KI0NKYHI0/i/iKL6Tbpjg+Wne
	pWKvcNibOarbCy40Trkg8fJrEthcDF4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-kJzPsAsQMCq8GeN-6sQCwg-1; Tue, 03 Nov 2026 09:18:40 -0500
X-MC-Unique: kJzPsAsQMCq8GeN-6sQCwg-1
X-Mimecast-MFC-AGG-ID: kJzPsAsQMCq8GeN-6sQCwg_1793715519
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a35db2d6b3so30810535e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793715519; x=1794320319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87L8NH0chbxJMXxlwkxaucZepbhcei/lYwpnUvY2jS4=;
        b=UgDLLBfc/bXJiOyeTY9h3E/2b9NcVvDXC2LHhKd1RL9yvya9KWHlPTuzXFDRw/ZYkI
         SyMPuW8h+ac1OXG31eFAmG8xUx4mrLWdqwU8VefOMWepj8xXAmYr50zgPseM24oVZBGf
         pVQwm2sgTBDxEbvuBBhORrgapJVaQMcBDxU8ILnrhmQNpHDzS9eiJOk4sX4J2gkAAuRD
         4ChNUmaElJnviB+3xvHvIp/S9vPdcGqNS19YHNj28eFbYlShAQ5dLnkz+44TX2vn1ovf
         nUPmyUsZjhbGga0wb0SxvRgRLABPX0orDHe1hm+r1Wbx9w+eU97m0oY43FVB85m4IP9Z
         17gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793715519; x=1794320319;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=87L8NH0chbxJMXxlwkxaucZepbhcei/lYwpnUvY2jS4=;
        b=fXfzEwOrCsHiIM0a2f9GjPCvOI+Wuv8Y+ssXdlmzELcPi97sdBEYw5u+NUFlnGt7Aa
         dIF4l26C1vZ8ICudU5xbfrcsyWIjZGqNYS4nvPI7pKMrHnJ+odnVGhR4Tci6KASkmyJ9
         zKi9PkLn5hiYly91o7fouvBl7Gt6quod8Q5Z2a481YhLctSEgcPvKqfoo9neU76wHCE9
         gBo8JNEd8fgy6R27Miare4VhKZpbOrCtrU27eM/3gp2pD90nZvlNpaeeJ3avW1zIJWOw
         aQG0Sb9P/7QuGD06Uk9YotgTKrK/0oTB3e3/3qbTRSZ232+BugHroAt1arZFUYrIw5e3
         GdLg==
X-Forwarded-Encrypted: i=1; AKwUvBzu+vBCPo8YL/ve3O9UzFOjcXGB/obWoldCOeDRd9Z5rqltpjtJJ3t/vFcBE1AUIyaPRKI9rJs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pJcM1mZB4VxVwYoynfAxYswPUPNmFZJv28jgssEkOklFgxQL+
	SbJjaLu8DX2HHxIoqoDl44BwNdIaEneb1MqrD2bMCI4PpQs0YW3fl5//Gk6PhoZO73M+bCxCC5J
	RLVDMJkux1aOG+AH3GENPWEH13E/Mdp/gnG0K/lVdTP/BrL9vuamtb2pDd3W3P7XCEA==
X-Gm-Gg: AYBFou39NNROA3YV+ROI2jSMlgDZ4mgI83Mc1t1194tRekwe5/ziJ+3frBOm6yHgxIG
	q1DpevSA1RR7nHeCDrJlBAifKyzkvv/j33SNEZpavnVLwKxeNbF524weWgspaskD1OlNhE0+PYh
	gNnJU4EBskSHRi7pMrar7SDfA4HgW/xrt7vrwLvnowCb0M3CPQV7XaaKZRqVsADiro8IyluQ+U4
	9G2P+dx86cK32AFs5NhBlWFIMbClM9NmsMxajtj4/uJ1gh9febnfUiFqmIeRi6wIDu/tWMpaBxe
	hG3u3TldfJtk2zWyLp23etdVsg9XlO3KSS0Tc6RVjJV7R2w5hqv9zf3Tqa8CutScXVS0HEAeHJp
	j/ZDQawO+lHwvLtVqZxEt77KcBlWbwvU1VcN13vvs28XNE1v+fCZvFpkMK7/6RIoZflY7YG57U2
	dPuXTqj03TCOzY7D+lO7xVRQO212FmC4KH52doMRJcRG8=
X-Received: by 2002:a05:600d:c:b0:4af:83ad:8f70 with SMTP id 5b1f17b1804b1-4af83ad8fa7mr160826755e9.35.1793715518745;
        Tue, 03 Nov 2026 06:18:38 -0800 (PST)
X-Received: by 2002:a05:600d:c:b0:4af:83ad:8f70 with SMTP id 5b1f17b1804b1-4af83ad8fa7mr160826195e9.35.1793715518348;
        Tue, 03 Nov 2026 06:18:38 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab3ea6a9sm91268795e9.15.2026.11.03.06.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 06:18:37 -0800 (PST)
Message-ID: <4d97a782-8d88-4dd0-b819-fb704582f2ec@redhat.com>
Date: Tue, 3 Nov 2026 15:18:36 +0100
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
Subject: Re: [PATCH net v2] net/smc: don't spin in smc_rx_recvmsg() while a
 pipe holds spliced data
To: Bryam Vargas <hexlabsecurity@proton.me>,
 Dust Li <dust.li@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>
Cc: linux-s390@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>,
 linux-rdma@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, netdev@vger.kernel.org,
 Stefan Raspl <raspl@linux.ibm.com>, Hidayath Khan <hidayath@linux.ibm.com>,
 Simon Horman <horms@kernel.org>, Ursula Braun <ubraun@linux.ibm.com>,
 linux-kernel@vger.kernel.org
References: <20261029-b4-disp-da7f8e6a-v2-1-9052904adf72@proton.me>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261029-b4-disp-da7f8e6a-v2-1-9052904adf72@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 09:03, Bryam Vargas wrote:
> While bytes spliced off the RMB are still in a pipe, recvmsg() waits
> for the pipe to release them before it copies the data behind them.
> The path to that wait skips the timeout and signal checks, and
> smc_rx_wait() returns at once on RCV_SHUTDOWN. With a signal pending,
> after SHUT_RD, or once the peer closes or shuts down writing,
> recvmsg() spins on a CPU until the pipe is drained, and SIGKILL cannot
> stop it. MSG_DONTWAIT and an expired SO_RCVTIMEO wait there too
> instead of returning -EAGAIN.
> 
> Check the timeout and signals before that wait, and end it when the
> pipe releases the data or the connection is killed, not on RCV_SHUTDOWN.
> A zero-length read returns 0 without waiting for the pipe; a
> non-blocking one returns -EAGAIN while poll() still reports the socket
> readable (splice() can still take those bytes).

@SMC experts, please review. IMHO the above trade-off sounds like a better
solution is needed.

/P

