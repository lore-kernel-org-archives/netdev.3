Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445637;
	b=kXoYXBXDlp6cm7sqSLsOrXPCGN3Fw6w+4+S4s/7RI1vmKG6CfH+M7EzxF/4LviXWi1hT
	 NjRH4fLf+iGklvOwsAgE1A0YVDdP//Psa+dHhYB/cX9Fq+2pD59z/7NkYMnfmUoMdt3Q6
	 ALmJoNgWO+Ulbl6jBXfbHbzu5kbB3YVdURndTYcE0v4l6LLLtv2xeojWd9CmtbXfLDJn3
	 nT52J7tC3o0BMOT10oIFCUmvNJ2PYAq5ricf5wXZWW/2oskEV6pbmS37lTmY1++siAwFm
	 p2TkVwzYx//6NS3MwGCkuwqG9E4mwhJ9+YE5dBOLLa0FYRFfniJhCfKzQzD0geuHscQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2RReNFzwszTC+E0RspOXYqfO8c+r26PYFZscPQMQXPo=;
	b=rovn2e5wX1gDHzqfVlynJlaCAsofOz72/t2oPirfGdUWCW3wy1rZ2hYbJROPcUmsOwaZ
	 lNyP1d6zVXLcDRrQ0HybQhQ2zJmUJEXTCz+cIC685hme60W0m5CTeKzyg0OqKXrfpjcl7
	 EwZM/Nh7VzLgX6SkyzXB/BA1LKht+C2CxKE8id1avaPdDBX459gEcQuNUxawZxKYHm5fc
	 fQe5zA0eQRO4CK7M4T4Z2nlNMILHR0H7KMS277F5zRXybDts8Ny5hZlrN05ljasuMzqsu
	 rwtk3jC2gVt9gVKife2at3tP55uX8cbQ3qDWgZCJcP98sc+gakzpAT683upLwHGw8rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jIa+R2cZ;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7645E606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7645E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jIa+R2cZ
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b2f59de176so2778231b3a.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 17:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794445637; x=1795050437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2RReNFzwszTC+E0RspOXYqfO8c+r26PYFZscPQMQXPo=;
        b=jIa+R2cZA8GeTGWY4OkBYSP1QFCIyWWlph2FPtReagpNxNoDxmiZOVCH1eJ2M7WU3o
         D4mO5chbkhqnEgeKPmW7Ko50qbGyEuJKZJtZ/qZ3aONwoR2/havVtaEvOZvYpISSZP1M
         z1nMBWNO5DteMV/pf4HKoB8hNglyNPsjJBduYVSouut9lLlrngwNf68xTsyvP6M6bC/+
         5PuXzhcDe+fGSJ6iD0VvBVLEshrBsbM3DEpJMKYL8fj9gaYpN2U19vcsEOkqLj36NZUH
         M1BR8IXXGRswP1pZb2d2u1Cc4GoeSekQHwqZQ23AF8jyRXJ1nN8MAvgYHWKOlXHV1num
         lE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794445637; x=1795050437;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2RReNFzwszTC+E0RspOXYqfO8c+r26PYFZscPQMQXPo=;
        b=EMTJqyoPbEcptWJIXhd88SrTgQqBnBrGTKCh93OfhFe9yG/nz4zhfmQbandP/zr8R0
         pkP0ODD3xZTXQBhMKZCqyxbPGmX4wuSV7NiuuTrzKXVCa+TklWPYMDZMozTFCx9AjqsD
         kfzU0ZpJyvRQ1kzadNKs+7H9xGtP9N83784SxR6Zb2iLEBxXOYbKrVM+ZeREdGqQBJNT
         LVL4CjMRSnrisH4NKYoGq55idIaTPnBVbiMkViuY9+U8+sKsIZi/oXBh2029K0Fdg/N0
         s9Qt2astoALAzTtwm7xevvjmd9dnKz8LNyR9xtXGVWjQsMUsj37CUww+rl0Hv5+w56mQ
         3atw==
X-Gm-Message-State: APuU4Z9fJJUPzUhm4FyOIR75cWgwT91KYnUh3pxSn/o7gJFQYtbGlTWc
	znRv7+f1Rx0qpBLrzsH3MVagXRz/I7WwCEzS0E7j2D57Z5wyE6IXM0eV3BKz/0D5qng=
X-Gm-Gg: AYBFou0n3I/kXTs6wT6azGGqQtrGtBW+Nb4sPFTAsu9Nu1+8W06M7qQeSr8d7E90X2E
	y4Ipxptrr6qcrodsYpo6PMSmHkt1grjLSOyNWUYUQ/0+SGJy8DHzX8TA9/E811S66w0x2D/WA6T
	Vsc/0SQXkrwHUxJIkJwyPRjM6YtBCQL9srsOwg1qJv6ABPdIDCtGp8PQUG9OpGCmV3ivhsbdcys
	oVhvPlmQQJA1v/2MY3vb2lKJh3xhfVVFZy1+uTTAESDyw8IEfLNVQYV3P6Kow6x4Jt0vemeFc5P
	sHJq0CnSbRdcpiP3mW2metq+2deYhPGRpyvN4dIQPGz8DoSmjIhmIYFlLeDHSlKmNGgEsVULWNZ
	wljt8QuB0c8V0zEpXniDMGjKpk16PuRutO22Ix4QyGXMmB8C8FXfJa72bz86L2Pk70D7+ldrpYu
	u3BINvbdbUXL0jX1Pf6uxVGIIUHCUwx8lc6br83i0b7aOD73Li3RERz1LX3vGyp8ZMc5b+om4ys
	JG4iU1662cAdQa7GKthmjkhn+4IX+Ll1NHxHjrA4Q3KTA7U5wBWFou2ZQdKk1HDWg5UFHiy1vpn
	MuXrYQ+YBS54aIyx1pjC1NiG9VPU0ICr1hmi+CRfIQ/JmGnDvoGBvZJogKmjphh2irOEbMVQvmf
	praqIEh8VJr+eLi/BsGo=
X-Received: by 2002:a05:6a00:6c8d:b0:89a:5f8d:2e35 with SMTP id d2e1a72fcca58-8bc1dbfb4abmr3789694b3a.49.1794445636851;
        Wed, 11 Nov 2026 17:07:16 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa86dd0fsm2559942b3a.22.2026.11.11.17.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 17:07:16 -0800 (PST)
Date: Wed, 11 Nov 2026 17:05:24 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Todd Freed <toddfreed@meta.com>
Cc: <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Zahka
 <daniel.zahka@gmail.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH iproute2-next 2/3] tc: add the psp action
Message-ID: <20261111170524.2b0a6af9@phoenix.local>
In-Reply-To: <20261112001512.3598626-3-toddfreed@meta.com>
References: <20261112001512.3598626-1-toddfreed@meta.com>
	<20261112001512.3598626-3-toddfreed@meta.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 16:15:11 -0800
Todd Freed <toddfreed@meta.com> wrote:

> The psp action applies PSP (PSP Security Protocol) encap and encryption
> to packets, separately from psp socket offload:
> 
>   psp encap assoc ASSOC_ID   attach a PSP Tx association, created with
>                              assoc-add over the PSP netlink family; the
>                              association's device encrypts the packet
>                              on transmit
>   psp decap                  remove the PSP Rx state of a packet the
>                              PSP device decrypted
> 
> decap takes no association. To take only those packets which belong to a
> single rx-spi-alloc call, a rule applies the corresponding flower psp_spi,
> psp_ver and psp_dev matches.
> 
> In JSON, the verb is psp_action. The action is documented in tc-psp(8).
> 
> Signed-off-by: Todd Freed <toddfreed@meta.com>
> ---

I saw several things that need fixing here, but AI review saw more:

New code must use strcmp(), not matches().  Six sites: "psp", "encap",
"decap", "assoc", "help", and the "index" test.  matches() does prefix
matching, so "e", "d", "a", "h", "i" all become valid keywords and are
de-facto ABI once released -- any keyword added later that shares a
prefix either changes the meaning of an existing one or can't be added.
Your own 3/3 uses strcmp(), so this is just making 2/3 match.

"psp decap assoc 3" is accepted silently and sends both
TCA_PSP_ACT_DECAP and TCA_PSP_ASSOC_ID.  Your changelog, the man page,
and your uapi comment ("u32, encap only") all say this is meaningless.
You already reject encap without assoc; please reject this too.  The
check has to go outside the "if (!p.index)" guard, since the attribute
is added unconditionally.  A repeated "assoc" is also silently
last-one-wins -- duparg() is the usual way to flag that.

print_psp() emits "psp_action" as a JSON string for encap/decap and as
a number in the default case.  Which type a script sees depends on the
kernel it's talking to.  Keep the key one type.  The default case also
fires when TCA_PSP_ACTION is absent entirely, printing "action 0".

explain() and the man page both omit "jump" from the CONTROL list,
though parse_action_control_dflt() accepts it.
