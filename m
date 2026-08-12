Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF90449B2B
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541464; cv=none; b=kTtV0MEf/YWTQfQndB1MfZV41mkskQcNHhijHg7NhvG/VgAbc33DPwhQFQTkF7CyRKEhjQMPIzxXg1hEdhTwe55qTQsZwEXKTlaklbKNV2+eUyrLmBIvn0ExBDCW5SapZD0XtyiXe/qG+4v/lYqDZhNl7D5As4jSFXAEUjO4w18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541464; c=relaxed/simple;
	bh=ICMnfMcH2LL3xN8p4YnFuCah6rwJig7AYg2KFmZFBLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcIZ6ikstEfHxX+dswRVvbQhVUkssIn11yJAdxPVFb5uIVxAbnS8TW1+EwWrbdACnIs92vTZW4scapgwQtxuvjlZt2hgRrijMZv67E+tT/oEZkQA8AZXgq+0T1DYfeUThlPIo3UVo5HONnvAKM0Ea5ZKRnNKd/YtL3KI2jfCHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnVqs405; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnVqs405"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84faf87d19dso1108408b3a.3
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786541461; x=1787146261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uz+bfGVw3BN4xTVdoh1TluUgeBOBBwVoF8DrIGsXOfg=;
        b=LnVqs4055hualI/8Vsx7uXP+D6qqabnTYVO7bmcaV/TDMKt/aa4IeZ1uDBhZTtcXT3
         R0OKVYV/X35a6VynsI67hZjg7bLZ6aH8GPmte32Kheffmv1vaTu+cJR5xphZUEw7yv+C
         EDBlLtLtqPEdvday56lhT0oTgtWn85o06yLpP/k8xHnO2tTDPE443Yq9gertDFHUQTCX
         +y5Cb8TF4MB2U7bax7ia9qIwGqBnvE1CdboVdbMubL+obRU6mOEq5nYLSR7yjUjFNfnO
         1z1L/w2xYSFIsA7FUFZH7gcAoWo51Vbp1RXPpfq8VOqlYsL0T1qjCXBLk2jrVnmoe1hm
         qnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786541461; x=1787146261;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uz+bfGVw3BN4xTVdoh1TluUgeBOBBwVoF8DrIGsXOfg=;
        b=gl1M9WRkPgoQV4FPFy6Jymdb8sl2EWGrn011F4biy9Q37w3ZbkYtjuqX5LuO6XNrLV
         Lc8+b0ltaGWz7wi7GrfyKA9L3wQhZUKXRe3X16nYRgVh11lwyurSeZQpeP7PmnTox8Ty
         WCoKQxbeHWLw+aQ/TuQDaJ5/leSjf/BKXBC8rr4QcwgK4dud+79JJhok2Ig4uPdN7uXf
         7Go7SFvVpc/Ej1Ls8Ml6m5mdGO66CNPdrD7dOqWbdQ66yP7blUdATO4HU8ZdEv6Q9sy5
         BJOEK2ruQkInQJK0NWGOmbAewaeIXqh2zO/mSTvWTzmj9kiCzFvijzuky88PuCLwWjcs
         MYzQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTC6Q22lca9FLe+Bu3DyeZzx1aIUgI4V/Ut9r/BSIY473VGLwcxqL0W7zfykq+It1FFis7fTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTe9LGhtfooolkJ9kM4JFiqJUZIPbjBDtZbOVZDf8cRHyebX1g
	lj9IWy4UOYa1IwGgBjIydA0awfX/ambBpgORspm7CNoqGH/+KwmEx5Yr
X-Gm-Gg: AR+sD10TcMCeZjoRGTjA7HxTo+y2lAp6H3N8BXjtf4SNMD7dSHd9FVe43wl0W0S246W
	rGv9TKkcGU84M3FXZV/idokBVM0qz1SCfgJKAXuDZKDO+g5LpitqPAznw2sv1s/zoarFp12ZdDk
	WIBbelEqRr9+EhQJB122AHOfSe+JnysIyOFk6uiD+nbaj+M+BBB26zL1qAUFtuHQE01N26DjbOJ
	tKIdm6beNOGjf0klHVdmbbU0ChW0nkS4jm6ihV47wxbTadJEuD0WItJOH6GQAXz8sfyE+M0QVH2
	5BQfOQ1iTTATbTetDDlveKVmBmdgrLsQVXwYTIuhFqkhrroTRryiy/QwFvXN1NjZR102KFYHA9d
	Usiwwz1yC5kSoYGXC2tJkmWbDgDhwsL/YE877n5dJDY6bCDx3hPa0OGigof99ScdHMIDP+GqpyB
	w710Oa0BMcJyjFqYSY8xnYgGZ01irDDucA+xEA7yh9QERIiW9a/xvbbzQq1zHZaI10Bg==
X-Received: by 2002:a05:6a00:9515:b0:847:99bb:b6d8 with SMTP id d2e1a72fcca58-84fb553c24bmr5293712b3a.26.1786541460521;
        Wed, 12 Aug 2026 06:31:00 -0700 (PDT)
Received: from user ([2405:201:c052:b00b:f326:be2a:1bb0:bade])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1ee8bdcsm1046727b3a.39.2026.08.12.06.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:30:59 -0700 (PDT)
Date: Wed, 12 Aug 2026 19:00:25 +0530
From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: Malathi <malathi.a2000@gmail.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com" <syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v2] e100: fix
 shift-out-of-bounds in e100_eeprom_load()
Message-ID: <anx1cdVq5D1vmjWC@user>
References: <20260811050753.234931-1-malathi.a2000@gmail.com>
 <DS4PPF7551E655294090E40920DD86E03A7E5DC2@DS4PPF7551E6552.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS4PPF7551E655294090E40920DD86E03A7E5DC2@DS4PPF7551E6552.namprd11.prod.outlook.com>

On Wed, Aug 12, 2026 at 09:44:08AM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Malathi
> > Sent: Tuesday, August 11, 2026 7:08 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>
> > Cc: netdev@vger.kernel.org; intel-wired-lan@lists.osuosl.org;
> > kuba@kernel.org; pabeni@redhat.com; edumazet@google.com;
> > andrew+netdev@lunn.ch; davem@davemloft.net; linux-
> > kernel@vger.kernel.org; Malathi <malathi.a2000@gmail.com>;
> > syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> > Subject: [Intel-wired-lan] [PATCH net-next v2] e100: fix shift-out-of-
> > bounds in e100_eeprom_load()
> > 
> > e100_eeprom_load() and e100_eeprom_save() start with an address length
> > of 8 and call e100_eeprom_read() to auto-detect the real EEPROM
> > address length. e100_eeprom_read() adjusts the length with
> > 
> > 	*addr_len -= (i - 16);
> > 
> > based on when the EEPROM drives a dummy zero onto EEDO. A
> > malfunctioning or emulated device that drives EEDO low too early makes
> > (i - 16) exceed the current length, underflowing the u16 addr_len to a
> > large value such as 65529.
> > 
> > That value is then used as a shift count:
> > 
> > 	nic->eeprom_wc = 1 << addr_len;
> > 
> > which is undefined behaviour and additionally overflows the fixed-size
> > nic->eeprom[256] cache.
> > 
> >   UBSAN: shift-out-of-bounds in
> > drivers/net/ethernet/intel/e100.c:768:21
> >   shift exponent 65529 is too large for 32-bit type 'int'
> > 
> > The same corrupted addr_len is also fed back into e100_eeprom_read()
> > for every subsequent word, where it is used as a shift count again:
> > 
> > 	cmd_addr_data = ((op_read << *addr_len) | addr) << 16;
> > 
> > so validating the length only once at the caller is not enough.
> > 
> > Clamp the length in e100_eeprom_read() so the subtraction can never
> > underflow the u16, and reject a zero or out-of-range length in
> > e100_eeprom_load() and e100_eeprom_save() before using it. The EEPROM
> > cache holds at most 256 words, so a valid address length is in [1, 8].
> > 
> > Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
> > Signed-off-by: Malathi <malathi.a2000@gmail.com>
> > ---
> > v2:
> >  - Drop the Fixes: tag and retarget to net-next; the underflow is only
> >    reachable with malfunctioning or emulated hardware, so this is a
> >    hardening change and not stable material.
> >  - Clamp addr_len inside e100_eeprom_read() so the auto-detect
> >    subtraction can never underflow the u16.  The corrupted length was
> >    otherwise reused as a shift count for every subsequent word, so
> >    validating it only once at the callers (as in v1) was not enough.
> >  - Also reject a zero address length in e100_eeprom_load() and
> >    e100_eeprom_save().
> > 
> >  drivers/net/ethernet/intel/e100.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/e100.c
> > b/drivers/net/ethernet/intel/e100.c
> > index 29960762e64a..26a7c0aaa6e2 100644
> > --- a/drivers/net/ethernet/intel/e100.c
> > +++ b/drivers/net/ethernet/intel/e100.c
> > @@ -744,7 +744,12 @@ static __le16 e100_eeprom_read(struct nic *nic,
> > u16 *addr_len, u16 addr)
> >  		 * complete address.  Use this to adjust addr_len. */
> >  		ctrl = ioread8(&nic->csr->eeprom_ctrl_lo);
> >  		if (!(ctrl & eedo) && i > 16) {
> > -			*addr_len -= (i - 16);
> > +			u16 len = i - 16;
> > +
> > +			if (len > *addr_len)
> > +				*addr_len = 0;
> > +			else
> > +				*addr_len -= len;
> >  			i = 17;
> >  		}
> > 
> > @@ -765,6 +770,11 @@ static int e100_eeprom_load(struct nic *nic)
> > 
> >  	/* Try reading with an 8-bit addr len to discover actual addr
> > len */
> >  	e100_eeprom_read(nic, &addr_len, 0);
> > +	if (!addr_len || addr_len > 8) {
> > +		netif_err(nic, probe, nic->netdev,
> > +			  "invalid EEPROM address length %u\n",
> > addr_len);
> > +		return -EINVAL;
> > +	}
> >  	nic->eeprom_wc = 1 << addr_len;
> > 
> >  	for (addr = 0; addr < nic->eeprom_wc; addr++) { @@ -791,6
> > +801,11 @@ static int e100_eeprom_save(struct nic *nic, u16 start, u16
> > count)
> > 
> >  	/* Try reading with an 8-bit addr len to discover actual addr
> > len */
> >  	e100_eeprom_read(nic, &addr_len, 0);
> > +	if (!addr_len || addr_len > 8) {
> > +		netif_err(nic, probe, nic->netdev,
> > +			  "invalid EEPROM address length %u\n",
> > addr_len);
> > +		return -EINVAL;
> > +	}
> >  	nic->eeprom_wc = 1 << addr_len;
> > 
> >  	if (start + count >= nic->eeprom_wc)
> > --
> > 2.43.0
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Hi Aleksandr Loktionov,

could you please clarify something regarding this issue?

I submitted this code as part of the bug report on July 7 v1[1]
and July 10 v2 [2] and we were already discussing it.

Later on July 10, the same code lines were submitted again by her.

I noticed that her submission was reviewed, even though i had already shared
the same code earlier.

Could you please clarify why her submission was reviewed instead of the
original one i submitted?

I also sent you reply on v2 [2]. Could you please review that as well when you
get a chance?

I just want to understand how the submissions are being considered in this
case and make sure the contribution timeline is clear.

[1] https://lore.kernel.org/all/20260807145626.52692-1-pavankumaryalagada@gmail.com/T/
[2] https://lore.kernel.org/all/20260810083355.21631-1-pavankumaryalagada@gmail.com/T/

Thank you,
Pavan
