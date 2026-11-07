Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794039094;
	b=trDxAf5Z4a5JlrAUCd3fJNlyx1i479QUVAwp8ao0mSPCcf1vP/Aut1UItHofKd6OQXC4
	 dCGDZpL9uvy0QCJEbKdg8vBDVx+8nkN0d6rFnZuDKvxCRYi/2LYJ2Nlu1qY2d70HxYKaF
	 Co+FwikpEBQo7ZKb8Cqycwvv8B5t1AI2R9lQU0hfPL//7gLl214JOAgwBqId3VxxpL0Ew
	 S5D4R5d+Vk8mS4yNslyK3eLszzM49cnrnAUzzw7FbPFTKavfaWKjz9USMMpoz/WVeBkVU
	 XEtsxaxiDksIMNLUG2RQdbnOSGuzUF3IGvd/jLSOlIPXJEZSuF5fnSwO1Pu68VLMdtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794039094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Mhkve0AREgIHZlQo7Mk2vGGc3A9EkMtvF/OVPHAgmwA=;
	b=omIJrZW3FOQnBMxkdLgt7UiJFyruUJshTYrwkW8OJ2UhjaZToLy1YjWeds3SF3qNQG7I
	 yaOix8FhleM5SLae5RukNjDlsf6KKf0aTPCK7xDtMgVkkV+UKR+swyWYQXW1CrodJezEk
	 qCXIV+HyAVwjiAj9T4diKLYYVD2GgYkXcd7xd89uimSkYD0GmnlPXgLWdl2pAoeVfHqzl
	 S2uqP+r5r/ND0UF2rSrrhrT691aUcLHlAtmJCqWHOu+wbsvwSk/Ozo+0eq0azA6zEM2JD
	 Aqq1BlkJEa1XMN0p8Ex8r/MFm3YUnK3zL/wHWTo9IEPOg6laOoIVWGTlyvyXWexCZRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=luxonis.com;
	spf=pass smtp.mailfrom=luxonis.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B29606A32C
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 08:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1B29606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luxonis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luxonis.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b570ff3dfdso1322318a12.3
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 00:11:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794039087; cv=none;
        d=google.com; s=arc-20260327;
        b=PGJ2Jj/zyP25xfdiISpIj1XrridFD9cEm4UrooI3cSHHxWfVUZbffh4/CWKyAWdgR7
         36F54EJD5IKv6RPAeBacpzchUKJcEWRFHFHKzfp+lKUTCbwv6CS11T5wlnlIMyEm33a6
         wj8eisPkNnQ1lkOc0gIwBFpT1cVEPQ2y29LYjwY1n3AuT00N1BD07ptVMd3x/wf9l34S
         Tf50bW4J2ANbu/8L1TywZlfSMnGpVAjiHg+Br1slRaGBchjaAfpuEjS5cA0vMuLUPaqB
         /o0/K9SzQnXe0QdqbPH0D5RhoaMeyBbQGOUkOKnwctTrwdJghvslQnZ2Ygy4J0KI9SES
         4nPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Mhkve0AREgIHZlQo7Mk2vGGc3A9EkMtvF/OVPHAgmwA=;
        fh=iY97GPgCHkFmcIZOlkyqpzLtg6k2KcxXX2sJb1fYuJE=;
        b=giojpPXCWxMROZtTHVlDiq5L6I3PcFIsFub8gQJiTb+y577Kp/7JZjhnau1CEUnM0X
         2JSKvInJC8t9D2jnzP2C3RKak7l0tXz/lKRWjNmH8mpTMgAXI5KEqkA3cwDdzqjClRfS
         sKXnBId2j13Xm0cdEQmsdodJwzYITqR3OPJw5V9CAy959AWpP2Y1H0bEIsEPVvis4MoH
         ub30Y4aOllcRBrEeuIMbAwAw2Q6syMincjuh+5aECZaMqdIFe2CMTzBI9nqqeUUhvrTt
         sTFu3zEMYdJwhrukkvDKLKfQoR1s1/J7pSWYX7mdBDTgMCflMyWfztObh/trjSvTy+TA
         vl5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=luxonis.com; s=google; t=1794039087; x=1794643887; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mhkve0AREgIHZlQo7Mk2vGGc3A9EkMtvF/OVPHAgmwA=;
        b=i+BZEnQeLfpuxDV52EIGZHIqys/+bL20VEt/gQlf8jFl3tVdIjfxBnbW4Yz98IZC3X
         khkTl5z0XoW0v25+ivaKgtTIWS9Wj6EcHJJKE8Znm71tI7Ba9JXgz6b3rhJ4PJ0mCAkw
         +DT1GZzhLOpu9xarDzNFWNKHO1eRmQ1LX3aXdIbUIaqqpXB7dVsTDjnidjzHhw1aO+qp
         uJbV3LAbEmVTIAku1aquJe2IpjOF7js7fvbO4PzkBJLiz1D84rTkUfRSIaTjV0hBu+ck
         d2bPfhhnPDcegpKZVE32oynF4bAJyd04a4GxDxaQjrW67/urIOiozVNyfrPntZFfMw+9
         De/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794039087; x=1794643887;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mhkve0AREgIHZlQo7Mk2vGGc3A9EkMtvF/OVPHAgmwA=;
        b=dV0AaO3kklwoQ3FBuSYmVZMa47Javoa5Y1ZEQXw+LLgpjyar0vKOchmI68nb5QJeba
         cx5IXi35rk1m1/8p/Os+0JpA+sW6KPv4bnBzWnZR3xj5hTZ4KslR7M7q7dpcqbCkcqV9
         SNNb65tSxWP6rc7MxsCIht3fjWbMXJYxkuhN5SdIvNMdtTt416IZI3vfxcgBU7bvfRXF
         h1qb91qXvXmHB3xICTqRRoMZCPqDF/sVScvKvjvWJXvJqlv9tfsObp2iaynRmuQbka/q
         yOqz0CQr6arxy0Pmg3jPEp1W5n8tsklD9oU8cC3cItvgzv462RPBYziKQT+85RTMQ/j/
         F2ug==
X-Forwarded-Encrypted: i=1; AL+hErHKdMLctrwUBovsR4AN4aiOaYXBX4hJNl1ZBLHqnrySoAsiEvuqUueLLMwz4zQqciXrEwz1sIw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nVi+x+IgxGjdR/AmT5X597NB+GfOIRLKles977nDp8MfqZqEZ
	QzY1LnuqAAuXDGwfAlFH5kDhNtn8NiagTOr9V+oLsoHKXBk4UvEm5lGKYDayQrBc9QBDRrftYnF
	y+spDXlFRAR8VMZlat/dt9rP+hplYqCxxstg/QIll8Q==
X-Gm-Gg: AYBFou2josaTgPPTVHLTWpfnmOYV+5/loQH009b4HGNS4ojCOzVcy0TV8D+++SqVYfT
	4MWbwtGZJqHq6wuo1W1TuyD/c8IrfYIfXS/1E/Q4P1acjrBV9ffa1JgarSviMr19b0YLpm9stWc
	j83g9pmm0aVmMUfK55XOEcVBwpY6oxMT6AEnEqZDKMA12TvBKo/+mmE3CxGBSPbgQ66h7LWEt0Y
	Uy7L8wzCmIoV2PPKmXp/UoQLn9dtu/TGfsyUxgGKqt1DIf6+0xEfG0PPM21fjGcILHxe8arIPk2
	BFrkzsxRmnqtGKjHNVaJHTxYA1fyfmic09hIMGDjh7nZA+xvILIc0zhXCPxX/FgRxKPZcM2b92m
	qjkSOfLaQNoa/I8jONHmtc/SsACuINu2IkIg=
X-Received: by 2002:a05:6402:2815:b0:6b3:f891:c2d4 with SMTP id
 4fb4d7f45d1cf-6b597806627mr3457069a12.29.1794039087024; Sat, 07 Nov 2026
 00:11:27 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101102720.702600-1-jure.rebernik@luxonis.com> <20261106131828.2844d23e@kernel.org>
In-Reply-To: <20261106131828.2844d23e@kernel.org>
From: Jure Rebernik <jure.rebernik@luxonis.com>
Date: Sat, 7 Nov 2026 09:11:16 +0100
X-Gm-Features: AclHuK9iN-4C02LmAAJuI1W1GyctSZGv-_z96k80CwTx7Gbtw0_eVmMh2EFhTYM
Message-ID: <CAD9jT+qH_XkV3vJV1OYGHqsQ0ThwK=HC+X1CCMv=kcojCx5zOA@mail.gmail.com>
Subject: Re: [PATCH net] r8169: enable the RxOverflow interrupt again
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
	Sunil Goutham <sgoutham@marvell.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Nov 2026 13:18:28 -0800 Jakub Kicinski wrote:
> Not really following the explanation, TBH.
> In general "ring empty" IRQs are discouraged because the host is likely
> overloaded, so having the NIC force the NAPI is not helpful. But sounds
> like you say there's some sort of a race?

Yes, sorry, the description was not clear. The interrupt is not there to
force NAPI. On the RTL8125B the receiver stays stopped after it runs out
of descriptors until RxOverflow is cleared in IntrStatus, even after
NAPI has emptied the ring. The sequence, as I understand it:

 1. The ring fills. The chip completes the last frames (RxOK), then sets
    RxOverflow and stops receiving.
 2. rtl8169_interrupt() read IntrStatus before RxOverflow was set, so it
    clears only RxOK.
 3. NAPI empties the ring and unmasks the interrupts.
 4. The stopped receiver raises no new RxOK, and RxOverflow is not an
    interrupt source, so nothing clears it. Reception stays stopped
    until a TX completion makes the handler clear all status bits.

What I measured is the stopped state (IntrMask 0x2f, IntrStatus 0x50,
NAPI idle, all descriptors owned by the NIC), and that writing only
RxOverflow to IntrStatus restarts reception with nothing transmitted.
The order of steps 1 and 2 is my inference.

So the fix only needs RxOverflow cleared once the ring is empty. I see
two ways, both tested on an RTL8125B with v7.2.6:

a) v1 with your suggestion, RxOverflow in the unconditional init of
   tp->irq_mask, so the handler clears it.

b) No "ring empty" interrupt. Clear RxOverflow in rtl8169_poll() right
   before unmasking:

        if (work_done < budget && napi_complete_done(napi, work_done)) {
                rtl_ack_events(tp, RxOverflow);
                rtl_irq_enable(tp);
        }

For each, a test build switched between the old and the new behaviour
on the same boot, in blocks of 5 to 10 runs of 30 s with UDP at
800 Mbit/s inbound, about 2.14 million datagrams per run. Totals over
all runs of each kind:

              runs that lost    datagrams     datagrams
              >1000 datagrams   sent, total   lost, total
   (a) old    5 of 76           162865429      411511 (0.25%)
       new    0 of 76           162861980         489 (0.0003%)
   (b) old    9 of 75           160722174     1041366 (0.65%)
       new    0 of 75           160721463         846 (0.0005%)

The small loss left with (a) and (b), 489 and 846 datagrams in total and
at most 61 and 184 in a single run, matches the NIC's rx_missed counter
over the same runs, 492 and 846. So the NIC dropped those frames, while
the RX ring was briefly full. I used the upstream ring size (256
entries) on purpose for these tests. Our tree also raises the ring to
1024 entries (not part of this patch), and with that and the v1 change
the same test lost no datagrams in 20 runs on two boards.

Which one would you prefer? I'll send v2 accordingly.

> LLMs point out that you're adding the same bit on both sides so just
> add it in the unconditional init of tp->irq_mask above

Agreed, v2 of (a) does that.

-- Jure Rebernik
