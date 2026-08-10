Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9747037DAAD
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364958; cv=none; b=dQNPRia6gnRPaGPxt9sSPhEf5qB6O1oQqKOdjPhVrWuuwHXYNz8gmLJ4gk2GINcZJk2b8HbGBasD2RBl416QNYqQpHzwbOgZg51N+r3d8ah9VyqQPPOFRf9ENmpp9LpP6N+SpwQ2spR95ArvYrZS9mlpFmNPnGldUm6GQXfINSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364958; c=relaxed/simple;
	bh=TR2oT+xF0qwkJmc/tjV/8MJvVBDTL2pZGyFYs7IIDRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMjfbEvod5MYKow4oX3KOXruMtMXnn+W09Fnyu5rxthd2W4vWcN9B1JKM5+80jsWXm9/wU8/USwFSXyGIlKwTP/zS10qE4wi7PVedEiRNTLgh12ihuHEmCX8Xvzy5DOeSoroN3e1eaFyuNo+0pLutszQkZEGoPOHVmErZxtRsY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJ4SQK+/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ4SQK+/"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d01663d816so14841295ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786364956; x=1786969756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=spaqSKC8vbKom/6b2zD3pj99tr3fiU6lqWnDJwVVV74=;
        b=KJ4SQK+/Z7dbKu6OEhEG7MqgypNbXaaN89/E+geTSCURsN+8FD0OxZJxqfD3kt3uT8
         Aw4dHfAm0YJRHLa5/zAJP05cVJPkPInil1mIPspmewcaJyzrk7/I3+qxKrB+X4H56j4j
         CWDBJdz+sTtM5G0W07poYk8P2UpYkCC2s2qed6601KJrnYd0aMtK6ev5uPiyEXLLMrYT
         cIaoEwnF6k505pTWD+/EZkclRUOl9m/RcEdO4Yz1lU2BV/yFg5NkMH332SluYlEiqjrR
         6KG5abOfBok4NFmzFLeGQ89+CnSchhwvJjGBSjpE4eMJa69qWxiOg0Tztjr6IDCF4y9J
         Xdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786364956; x=1786969756;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=spaqSKC8vbKom/6b2zD3pj99tr3fiU6lqWnDJwVVV74=;
        b=BL1v+8XnCannCuV7RAA0bdwsd8B3CtHfR++vsscXYKdLZHg1qu7PRK88ak8rYucXGB
         b0rSz9oHX8LlMuMiMCZ8AtFAKm2t1cBFPFC1gOimEG1EmJgM9JK4zhFnoWZD5Kbk85hk
         21Z4nE2pzLM/KFRohypH2DY6diqxHF1cloi2cnf5LPn8Ob1u/9cO1+yglBv6CUFw06VW
         Q1K2PzLufkm/zMT3NdC1OllxGLz0589+W4hHWnU29l6fdFAxw2kAteczfwEu5Dc0iCYG
         qmQJaswcW35lZXsbq7DOTyZCo6ONhIliwQNsnpqJj3euOn5cN7yk3t3h5pUUBo9VJwIu
         kADw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2YZ97/795gBtW9h4cU7UT9u9qRy/GobbeI7iKWubNyBMYhJavRyNI9G7pPKVrT7jPrYfdDsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10ElM1LNSAoIZ70pWaLj4cZXiPVUgzyI3z2rgX6yIYr3DqAgS
	KYOjhq6vWxEj6osFre3TEqdPwz+EmoDc7YbxIKccZruVUwTd7i54sCSY
X-Gm-Gg: AR+sD10q869y6vRc54CLpIXh2cpAfslcJMYex7JndmdYgYD1AgEXEr87TVnn/eLAAMI
	760gkU3z4oO1nuKbRPe52mEivhnD2qT3Rm9BROSPLUMo3CWWXoqHQwfyGfJKBqykEWc6kylD9HL
	M2mHYSRfWXrl2REjNn/stTswp5d2YuFHDV/XC41jgKsb65G/ozRJ3I/xMNl2nluwmupXIGKd79O
	98PQoRylicst2DMMVbfvDX9ZrqMSMFuIVgXnl/Js4FRcicMAxNrVwYK9GYEDQelIEWZu6/QMWLn
	ao9L3RB3LPG4B30K+TPMRYVbNR2E+mEOfLWpVW0GWcH7yTVapL4wN6R6/lXwqrZTW01UtV4TfIj
	A73SqyRLzOueyEGYaN1iXY5y9ZQKCRzlLZPIX/fN/vetPkbfTxV2hSh8fjhL4ZoPLlVOYoTjBOd
	ZbLaOnkJ9egCPXjHo6K6ZwUSk4AAbQWMvtS/jbBF1c/QwEDLGrpVkZFMimIIV0/R/9LA==
X-Received: by 2002:a17:902:e812:b0:2d2:da8e:9017 with SMTP id d9443c01a7336-2d2da8eb6e0mr119633235ad.8.1786364955548;
        Mon, 10 Aug 2026 05:29:15 -0700 (PDT)
Received: from user ([2405:201:c052:b00b:8ed8:ab8b:ff23:d5e4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14dbeaa7bsm35401635ad.41.2026.08.10.05.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 05:29:14 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:58:42 +0530
From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com" <syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com>,
	Kohei Enju <kohei@enjuk.jp>
Subject: Re: [Intel-wired-lan] [PATCH v2] e100: prevent shift-out-of-bounds
 in e100_eeprom_load()
Message-ID: <annD-sZeweknPnFt@user>
References: <20260810083355.21631-1-pavankumaryalagada@gmail.com>
 <DS4PPF7551E65529B793FF5258AF910943FE5DE2@DS4PPF7551E6552.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS4PPF7551E65529B793FF5258AF910943FE5DE2@DS4PPF7551E6552.namprd11.prod.outlook.com>

On Mon, Aug 10, 2026 at 08:49:42AM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of pavankumaryalagada@gmail.com
> > Sent: Monday, August 10, 2026 10:34 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>
> > Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > skhan@linuxfoundation.org;
> > syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com; Yalagada Pavan
> > Kumar <pavankumaryalagada@gmail.com>
> > Subject: [Intel-wired-lan] [PATCH v2] e100: prevent shift-out-of-
> > bounds in e100_eeprom_load()
> > 
> > From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> > 
> > When reading the EEPROM address length, e100_eeprom_read() can return
> > an invalid length (0 or >= 16). Passing an invalid addr_len to bit-
> > shift operations causes a shift out-of-bounds, triggering a kernel
> > panic or UBSAN warning.
> > 
> > Validate addr_len after reading it from EEPROM in both
> > e100_eeprom_load() and e100_eeprom_save(), and return -EIO if the
> > value is out of bounds.
> > 
> > Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
> > Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> > ---
> > Tested in QEMU using syzbot c reproducer.
> > 
> > v2:
> > - Return -EIO instead of -EINVAL for an invalid EEPROM address length.
> > - Validate addr_len in e100_eeprom_save() as well.
> > - Drop the unnecessary 1U change in the shift.
> > - Update the commit message.
> > 
> > v1:
> > https://lore.kernel.org/all/20260807145626.52692-1-
> > pavankumaryalagada@gmail.com/T/
> > ---
> >  drivers/net/ethernet/intel/e100.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/e100.c
> > b/drivers/net/ethernet/intel/e100.c
> > index 1de5cd41ea0c..464dc2d6cdb5 100644
> > --- a/drivers/net/ethernet/intel/e100.c
> > +++ b/drivers/net/ethernet/intel/e100.c
> > @@ -775,10 +775,10 @@ static int e100_eeprom_load(struct nic *nic)
> >  		netif_err(nic, probe, nic->netdev,
> >  			"Invalid EEPROM address length %u\n",
> >  			addr_len);
> > -		return -EINVAL;
> > +		return -EIO;
> >  	}
> > 
> > -	nic->eeprom_wc = 1U << addr_len;
> > +	nic->eeprom_wc = 1 << addr_len;
> Why do you drop U suffix? For me it looks like you trade one warning for another.

I dropped the `U` suffix in v2 based on previous review. My understanding from that
review was that the `U` suffix is not what prevents the shift-out-of-bounds issue.

The problem is that `addr_len` can underflow as a `u16` and become a large value
such as 65529.

In that case, both `1 << addr_len` and `1U << addr_len` would have an invalid shift count.
Validating addr_len before calculating `eeprom_wc` is what prevents the invalid shift.

The reason i used `1U << addr_len` in v1 was to make the left operand unsigned.

However, after validating `addr_len` to supported range, the maximum shift is 8, so the U
suffix is not needed to prevent signed overflow.

I also tested the reproducer with all three forms:
	1U << addr_len
	1 << addr_len
	(u16)BIT(addr_len)

They all produced the same result with reproducer because the invalid address length is
rejected before the shift is performed.

Regarding the validation range, I initially used
	if (!addr_len || addr_len >= 16)

because the reported value was 65529 and this was sufficient to reject
it before the shift.

However, after reviewing the Intel 8255x Software Developer Manual,
i found that the EEPROM address field is 6 bits for a 64-regsiter EEPROM
and 8 bits for a 256-register EEPROM.

the driver also has:
	__le16 eeprom[256];

and calculates the EEPROM word count from address length.

Therefore, i think if (!addr_len || addr_len > 8) is more
appropriate validation than `>= 16`.
it validates the actual supported EEPROM address length.

> I'm for explicit (u16)BIT(addr_len), what do you think?

for the calculation itself, i agree with using:
	nic->eeprom_wc = (u16)BIT(addr_len);

1 << addr_len means shifting the value 1 by addr_len bits

for example: 
an 8-bit EEPROM address length gives 1 << 8 or 256 EEPROM words.

BIT(addr_len) expresses this bit operation explicitly, and the
(u16) cast makes result type match nic->eeprom_wc.

I will therefore change both e100_eeprom_load() and e100_eeprom_save()
to validate with addr_len > 8 and use (u16)BIT(addr_len).

Please let me know if you agree with using addr_len > 8 based on
the EEPROM address length limitation.

Also, would you prefer (u16)BIT(addr_len) for calculating eeprom_wc
or if you would prefer to keep the original shift expression?

Thank you!
-Pavan
> 
> 
> > 
> >  	for (addr = 0; addr < nic->eeprom_wc; addr++) {
> >  		nic->eeprom[addr] = e100_eeprom_read(nic, &addr_len,
> > addr); @@ -804,6 +804,14 @@ static int e100_eeprom_save(struct nic
> > *nic, u16 start, u16 count)
> > 
> >  	/* Try reading with an 8-bit addr len to discover actual addr
> > len */
> >  	e100_eeprom_read(nic, &addr_len, 0);
> > +
> > +	if (!addr_len || addr_len >= 16) {
> > +		netif_err(nic, probe, nic->netdev,
> > +			"Invalid EEPROM address length %u\n",
> > +			addr_len);
> > +		return -EIO;
> > +	}
> > +
> >  	nic->eeprom_wc = 1 << addr_len;
> I'm for explicit (u16)BIT(addr_len) here too, what do you think?
> 
> > 
> >  	if (start + count >= nic->eeprom_wc)
> > --
> > 2.43.0
> 
