Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573081;
	b=WWaB3GMNACGzFKz0a6DoKUrq7hpQ6HiNF8IYv0NNpJW3p1UXMVbt/64frJgPUDXaenim
	 InQ37KX7DSDvhhMXBnbdBxa/u7WyFi4BKcGOAFSps28vtNwRxpV15WYCmpsOsYQR2tE6q
	 wp3C1lSqefChQjZxF2ni7Ibe7jxx/ZfZ4JeyTaDlTZ8Z2XUPglesMISDee7570/+4D8x8
	 rjdhYK6fi2KEWqev4WZU9xEwnViQl/D0izBIV3G3jjWCp5VwtjhmlNSp3OdKCp3voIz20
	 MJNAQOHIiORV0tRxQR0oJr4X8214giSTdYpj8mgBqveeckPNEd3g52SidXAs8GkH0cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oFoTGPVnuzCoGoiTBSGHy1GvjjGVosxUHiJRL1fL/iE=;
	b=b9F5is/b0bKWaZD7iW3e53ISPuerym/Q/xIJJb+WHYvM69vZIN++Ud5rZDfaj64fEQed
	 i6mv+glT55MUnGDOCX3BzV1Rv5l89itA6axaF4+QnWjSHZdDrEpuq8EyDU3bqnGDvJCIS
	 1NoFyG4aF80MnANw0U2Ti+EQZh8Cy3lfo6iHqJWqDPjjxCEqGxkOTCN/L6LI0xYfvB1e8
	 ozdlKKqR0nLNWrS1f8//y8AQ8rjxulQbBYjdKTo4rGvZAs27JYnIZl4isAJF+GpGDyVtH
	 X0G58GlLVDQURB98dFo2I52mduSQGfsNsbGaU/E8Jcwv4gz3RJurzsOpUXdC4jHYJmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iLf2+Bka;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A010D606A31F
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A010D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iLf2+Bka
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so5304515e9.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 01:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792573079; x=1793177879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oFoTGPVnuzCoGoiTBSGHy1GvjjGVosxUHiJRL1fL/iE=;
        b=iLf2+Bkae9d4JsjC4XGf9y7nLgOvamqI1ye7g0xTRocQIQMNUtHHpJ6BMNTjGj+XRL
         njCPO7p8mCf1hLLLXqakFrLRUPVmYjvKnI5q/VaIeR7X0xzTBNMok40Pw6D4dEEcVHU4
         qjLXiNUzpRV1UPfJdgt1cJ56p+8q8oC3PJY/55c3gvS00ENGNEWpewxZGOOJDUWEOhsq
         eI5MUztgceY/mr6ADc8nxMjePpI9Z+w9m8L++Iyorb2xzTP0NRWXRlnJHgqbZ97hZqBM
         GRNX5jDlOcpLVsW3whegvA+X8e0osshGnBAUnzjtwBOGLpoHzvedm2WYoNKnWLUziDkf
         xB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792573079; x=1793177879;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oFoTGPVnuzCoGoiTBSGHy1GvjjGVosxUHiJRL1fL/iE=;
        b=O2Zm51Fee/SD6bsmLynHOXpWB02SRmDesgmC6rdzuDBMTAqTdmSwSmOyEUfbSHtDOx
         1Kw1B13AgIbFm3jcwey4VvXlXt94d36FRvlf0B3j8KoMrsP7T/oikjOsc2cRaHBjv+AE
         CiHmOeoz1/q6MudZWMW+1w69ClQeDlXQlricgrdVRUio2it768aKsrNMd3MkVSKy0Ofu
         fsdJ7j1NrEsp4b7XD0rjr7M+FSKKWa/j9vaRybdR+qicfJ59QUpZGtMORCQTL1LLEhUF
         NGCPR5yJlITt4qWA68pdLO/fgLrf7GBbholLHFYQHm2JqgjikUsiP3T6GTYrSyauyIs6
         8gcQ==
X-Forwarded-Encrypted: i=1; AKwUvBwi0xuracPDn8xQPX0Jx+SDysmcA/Isxh7rphWGB4HC4ZHq9Dwb3W70xuzIw07QkaOKOolcEbk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQabCvnAld8zIZzloqaQuJUuXkJAhPTfZKeVppfzORbh6PHXPH
	VFYeBYRWsN51wHeEKykJ+KeoWnKHWbntSi8eqwyjP79pQUaqDBCrklKV
X-Gm-Gg: AYBFou22BN1UNabWxGvPY8E6hoWS/fwdOnF4WUR28hCOJJ90am2BTKJNwwg7tVmk0fm
	o2sU9cX4LUXWI0lnFVpnCb5r4stfwIPna9uVfCdWz+fC5trO70Zq7ii63Ir5qcMBv2IVkgYqroD
	5vla7VoYZTCYv0NzQ2AHOkLyq2KkVlYH/h/qNwNHt1UqBbEOCLmnT7BjT43ToVnyZxVxTxIPX46
	NfbjcmGRgp/7NYoMPZX2ON7tyxZwMru8UyiVqILdyHdKd0qHdZnfxUe4Ou7kIXm3be+i/LS6jbC
	kovvoyfaYNdB3xXTfcgdLOPT9lAobaJ8p0c5t8RTiHxrsIZ2jprkYDMVOT1A3lrdCZUWL67yx1s
	IAjeSByIuh/35oRL5JBzOGfdKZukYaF2IeqtRnTIKspD4DfX12r0RRJJwEvojK2spjmQ1d5SeQc
	d0eazZbFN7lJWqT4QxiasUgnnJp2s6pBkNsHHefv7MrBXpBizK04LYFDQMsQYsrUkvxpWzCO4a0
	FnrG74wwj6NTWeC+vowoa/oGhfz4RO7Wkm69lgKO2H9h3vVeBOTANl8CDhNAB4r319HbxyzXllD
	rNxZTKlBZY8IddcgtWSFvuWF8lteE/D85iPWIQ==
X-Received: by 2002:a05:600c:4708:b0:4a1:fa21:fd90 with SMTP id 5b1f17b1804b1-4a1fdaef9a6mr26193665e9.9.1792573078797;
        Wed, 21 Oct 2026 01:57:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc1b227dsm49117435e9.6.2026.10.21.01.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:57:58 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:57:56 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andre Brait <andrebrait@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 g.goller@proxmox.com
Subject: Re: [PATCH iwl-net v2] e1000e: work around TSO erratum that
 corrupts data and hangs Tx
Message-ID: <20261021095756.0f5770e6@pumpkin>
In-Reply-To: <20261020230211.75665-1-andrebrait@gmail.com>
References: <20261020230211.75665-1-andrebrait@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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

On Wed, 21 Oct 2026 01:02:11 +0200
Andre Brait <andrebrait@gmail.com> wrote:

> On I219, a TSO packet whose first buffer is long and has a 4 KB
> boundary just after the TCP checksum field makes the NIC send corrupted
> data and then hang the Tx DMA. Forwarded VM traffic (tun/vhost-net)
> produces such packets, so hosts bridging guests onto an I219 hit it
> within minutes:
> 
>   e1000e 0000:00:1f.6 eno1: Detected Hardware Unit Hang
> 
> Right before the hang the receiver gets TCP segments carrying data from
> 128 bytes earlier in the stream, with a valid checksum.
> 
> This is the erratum Intel documents for the 82571/82572 (#76), 82574
> (#17) and 82583V (#7): if the first buffer is larger than
> 3 * (max_read_request - 4) bytes and a 4 KB boundary falls just after
> the headers, a read is repeated, wrong data goes out with a correct
> checksum, and the Tx DMA hangs. e1000e never implemented the documented
> workaround.
> 
> Apply it to all e1000e parts: limit the first data descriptor of a TSO
> packet to 3 * (max_read_request - 4) bytes (372 on the I219, where
> pcie_get_readrq() returns 128). The rest of the linear part goes into
> the next descriptor, which e1000_xmit_frame() already reserves;

Aren't you using an additional descriptor over and above those the code
might already use?
So either it was reserving one too many, or you need to reserve another one.

I'm not actually sure all the logic there is actually needed.
The code calculates the number of descriptors the packet is expected to need
and gets the packet requeued if there aren't enough, but there is also the
'post transmit' check that stops the transmit if there isn't enough room
for a full length packet.
If the latter is valid you don't need the former.
Although a sanity check that the ring isn't being wrapped might not do any
harm. 

David

> the NIC
> still segments the packet.
...
