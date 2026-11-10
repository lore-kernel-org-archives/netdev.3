Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327179;
	b=M5A+fw1qz4ptsBgv9EW1YILj5jm64Zh3d1/CKFu0yy/aQvYXjNbeDeupMy/MEcy8BRH3
	 Mjva4A4qyT7wtSJ1u1jmgq0eFuM4TCtLA9nl22rlLCv7fh6VcFkG6NWLY7q5PmTRqgRLG
	 PvfRRNlfg50MV/cdrshWMqOBagBopRBpmsrchq+HcDxzXVrDAjm3lpMJHXSQRX+rJyzW+
	 TNrtdVlIRY5SinuJTqBdI3AjH8yccOq56TkjeAYctCW89OHJ90T3zIIlQ2WQYV7TVWARb
	 s4Xa/Ub+DoAzEk9120xUe1M1+q9EBnLEIW6euHUKU7m24NAKmypErvDZCoKf+O5j1KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327179;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=in2GRGedn8xujhUfMjqdyzbGddtgYvZlV+27x56RYsw=;
	b=xf6RR1un8pkb3k8QZl5gUKJh+AjE4mIElZfCp7+PKzM/+B3CwF/e1A6geUZSlOFiSgd5
	 FFgED9f8ptBF+CadcZT4lgrEF6Bovf0oCGXzm7gQ2sWda6pJAULD1rzaASTe9efu4Io8W
	 VNu86d1dW3rWlRi23oHFxuYEeWkrZDXvTDHaYkPQbEEBgzgLdbSXJieMBgvM8fwW7fBWt
	 sFkrxqATCFDMtlivW382YlhhcTyFwSs8VJ5C6qJB1utnx9MyIxAaaPYrfp1xiqKhfJjib
	 wnrpNzfYHtg6kEJOMEV+ZO3I2N/M6kS+62tr5FBMaWxv+2q69E6z5iG5npwXMBddftg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zx2c4.com;
	spf=pass smtp.mailfrom=zx2c4.com;
	dkim=pass header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=WhZUmgXT;
	arc=none smtp.remote-ip=209.85.216.102
Received: from mail-pj1-f102.google.com (mail-pj1-f102.google.com [209.85.216.102])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7BC606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB7BC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=WhZUmgXT
Received: by mail-pj1-f102.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso1413218a91.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:12:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794327172; x=1794931972;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=in2GRGedn8xujhUfMjqdyzbGddtgYvZlV+27x56RYsw=;
        b=ZeetvWKr1lZ1u7gkDHwqzyIRLUnIfE4QvuReaxZdA5IDkx+5d4UPXl7a48ZJcNdndK
         lpRjC0T//9gOraqEEI/u8WvuDXXMIC/kUYkk+M1pqnjcTnT1sWdh2ANexzThuM1Zqmzy
         HPMdTEtA3NjZt9Odopreyxlaz/HBgkBb2nOYEZYwcJSPL3hnzQ/tu0u8/E8Fe6BGlB4z
         4fRwWYkemTI8k8weV2oXltrTMgwPV5YapB30SBpHR2rfsIvEnAfBPoHX/Vn+oFZhZPik
         sUSm9ZYSGq3D9OZ56r6+fmifapZgCgS7TXkzpGEZqW3kRAnlj9PusnguT4IsIjDHCcmo
         t3RA==
X-Forwarded-Encrypted: i=1; AL+hErEffAH1dBIakGAYf6Lm4MmJRV9YSxW/wKzVpaNhVdhR8E2DgQLvM5+3EF/iPrUfvJr/xeYfk2I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jOiBbKob8Z/pCgiH2DNCFI72TcEJaTxyLESkxkvt1mueCEf/F
	JuK35jD7kBhfat7Sx2swSX3NrDhwgn+Peh5Ai0QUdiuD83MeYlI+mkbWpx3kgWFMj6aU1muItPW
	j1vnVR/z/5xweQpJMmoj12mvi98Ynj/GRtzvu+8S3Q21+GFTWvg==
X-Gm-Gg: AYBFou1JtvhhvDKkeZD0iqeXLCRwT2qXLVU53y/eanC+MEzyHl7QUKEZ0xoRSdiBoZq
	R0VptiZ+f1A3QLVW2tw/oqauW5jvukWhCcKK0zLNdhZZz7kAhu4G4/AjRxitPPUGi/2ublt0reB
	XDPAkqXn+wGB8GLrFR1dAvVHRXzLIPZsJsOHoJGd3t2Fs1jucvzQfIl2tymdm1C01wtg7MBHaN0
	6l0tN3c5HzohCuHrEBi47aaKs5QJpHQrSpeFxcMbreNlHrTKAnbZ9KJ+0n/Y/vsL75EcoLy15lv
	JC6i+scAs+1IQ9OwHhMwxdVgmUsfWS+QDXY0Gzf5a5o6EfDtNv7H1jJDyN2DA23nCGg/77PKc2C
	mHw==
X-Received: by 2002:a17:90b:5625:b0:3ac:36c7:c144 with SMTP id 98e67ed59e1d1-3b1679ba42emr1924377a91.28.1794327172047;
        Tue, 10 Nov 2026 08:12:52 -0800 (PST)
Received: from zx2c4.com (mail.zx2c4.com. [104.131.123.232])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b17e0dccfesm170958a91.4.2026.11.10.08.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:12:52 -0800 (PST)
X-Relaying-Domain: zx2c4.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1794327167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=in2GRGedn8xujhUfMjqdyzbGddtgYvZlV+27x56RYsw=;
	b=WhZUmgXTiHPEQa5m8oXC9xJGHWmDVDhBJOCOKZ68i0JAgrryuJ2OpKISMMArTDvqKX9J3p
	gly0mlrzj/PiWbAWnd57JXbMST0Ayd3lZxBjRTHC45wOgvxvTiqVvYN7mP52oUauJ3QI0S
	qnL9KbBPK/0Od73r2/adXduAhczgmS4=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id b5d66eed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Nov 2026 16:12:46 +0000 (UTC)
Date: Tue, 10 Nov 2026 17:12:37 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S.Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	openvpn-devel@lists.sourceforge.net
Subject: Re: [PATCH] wireguard: socket: fix sticky source address on p2p
Message-ID: <avNCdbpjxM752XSw@zx2c4.com>
References: <116cec552f58748d434d4825c6c74f39266b265f.camel@infradead.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <116cec552f58748d434d4825c6c74f39266b265f.camel@infradead.org>

On Fri, Oct 30, 2026 at 04:38:06PM +0000, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> WireGuard attempts to reply from the address to which the original
> packet was sent, caching it in endpoint->src4 and validating it before
> each use with inet_confirm_addr(..., RT_SCOPE_HOST).
> 
> For Legacy IP that validation always fails for an address on a point-
> to-point interface, because confirm_addr_indev() insists on
> inet_ifa_match(), which compares against ifa_address — the *peer*
> address on a p2p link — under a /32 mask. The local address is never
> within that "subnet", so a perfectly valid source address is discarded
> and send4() falls back to kernel source address selection.
> 
> For peers on the far side of the p2p link, the fallback happens to
> select the same address and nobody notices. But when a peer on a local
> LAN sends to the p2p address (e.g. my OpenWrt box listening on its
> external PPPoE address), the reply is sent from the LAN interface's own
> address instead. A stateful firewall on the peer then drops the reply
> as unrelated to the flow it originated, and the handshake never
> completes.
> 
> inet_confirm_addr() is an ARP helper answering "do I have an address
> on the same subnet as this"; what send4() wants to ask is only "is
> this still a local address". Use __ip_dev_find() for that, matching
> what send6() already does with ipv6_chk_addr(). IPv6 does not have
> this problem.

Hmm... How did you choose __ip_dev_find() over, say,
inet_lookup_ifaddr_rcu(), which is structurally more similar to
ipv6_chk_addr()?
