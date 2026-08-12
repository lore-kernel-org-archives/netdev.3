Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBBD372EDD
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567854; cv=none; b=lJqXd0y0IINQqi2X91LZ7EcRFW5WtHfa0+Ttc8Spe84rrvp/7xnX+VbjNHnraLigpWWHjAPRbiXN1xX3qb24lYwYSsKEfnsUdLn2zkBCBmhk+pugD3MxG/NkPKqCIllkpRGJI/E30zxT3zz0w7jeloPx/0aqhg4zrelJg4DlxUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567854; c=relaxed/simple;
	bh=+M/xEkAlBPQ/Dv4teFjbH8U9YOb3eHfDkarb54xmW3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUQWsMWwOTrfeQKBlRIf/FRtsFpG1P3GpW5jl023Av78jNp88IqoxypbJQsDYr7NjkSWs8RyJ6fnghkDNItb8Wc+9g0mV1WFfxI2x8o23MRlRrqukZozXF6DOkCM0i2A59N1x1o0hlZdXBnw9/lsDdq15o69329tWdAhCvDd0dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/KQBIv+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/KQBIv+"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4706f016316so72127f8f.3
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786567851; x=1787172651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KGopkqV/DZXXVPCNEpwVFmRfIz4+rospFjEcMQiIhw4=;
        b=S/KQBIv+FPssV4Ug9pRbr3Kd+6E+P006B4l8V6oJeL8yIC44VS/Tl0GiiBiHor+hQ+
         tM++938WGXlpVheg+HAO8K3so4Euij0zB2vok1GEE8KJKl+7g365QtgqoY55s+NdF5Fe
         IEgfi6cFwKAQKH6NK30CsTA00UTA/7akYIUDl260NuV02DKNaAXcXMFzFqXLyv4GUOt7
         MhiryjV/B2w4YJ2dNiDYFflw1dneHAtPkqVYMWckmuyYQNfDW8MvHiCKsr7/xSzw7hig
         k5TJ3kjg2GXi0kOaQpUxcWr+gf3Raj9U2KaUblpu6YIr+Tt1RM62DlhwGBCt7nHEH7Ne
         Enyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786567851; x=1787172651;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KGopkqV/DZXXVPCNEpwVFmRfIz4+rospFjEcMQiIhw4=;
        b=kFRcSNmdqY4HvVh20GZ+ehQMdr4BBf0XPki5Rf2ZC2rP7SDBJon1Tzs06Zn87OsBQ1
         BUYA/7Pg9+dkhMinpneVq/UWHwdu7ZniN0PwxJUSMeBI9yRSLWtioJkaYwUh6wcQgOjG
         Iq17dpmnFMXKiUCXbP82ltDZ0NM45uKsQU/9Mxw8VD6otVbKeoTSn1htT5WfGScGP8pv
         ZxY6ojvCE3wPo7JqCfKrl1zB9xH1Q8hgC7bSeHouvsuU7F1XdKDhGZqIiRHFrEUDVIVu
         Q9/J2j9T8+Id2tDjetzqxFW9UQDeW56C1V7JT96JJs7gL+2AUnBodx/zMthOY+syQ/TG
         jOnQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr3X0M1tgbN10ZIEbLUnb6XcpL2C3hxJ/U8mC8V2zkMzbY0KpTtLGDapTbIcY5va62SNyNTewY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+rI0Pj3hluuERbnx52nTKSjPK5kQbevXoqiJntGk9iSD7hNxy
	qLR74fejw9VxmLteAnL0TAuxEf7ZCyxhLVSzVZ9cGD6uojFEF+3OMf5p
X-Gm-Gg: AR+sD10MRkEtvrQbuhjTnNx5M2slRlBwtkqV9+ADa+cLYqsQX1tW/VFsk5vFRhZqV+w
	/9geCGSoyw/c3+p66u2bESwjF37RjVXccmwq//QZwZoqOcNwBgwQZ5NZOgK9bUaBg76s8p6Kkhz
	4l+mEyX6JWdQ/ryqVU/X+OyWw1Ua8o5X4wkrOS7iPvHqK72K4mps7TXy2C4Dd7wARNENatk495n
	O023zl26Hx3Nr4trA6BevkLnYeRhlnbwSir0AwSt0YJx+Ca6RpvtdHw10UGQZ0HFi4MNom6y9vC
	7mkptGXzkJ+FCUalmAoU5sFpqGlCRSEzGtGwadPEamR0XhimGoeNMAms0SUsEWbVl/G9AF0JSQf
	wtDbhQg2Xq1UGq9oqeAwCalehe5YlXgywpWgWGb2ddg7hDYWTw+I4mMZ8XQD0Krikvq3uKtlzbr
	+QxtTMannesOpvYuWal7avp0H0rab6qhlkQ4O/PRu6MS9VRD5C
X-Received: by 2002:a05:600c:1908:b0:493:bea7:6b67 with SMTP id 5b1f17b1804b1-49982653643mr210845e9.3.1786567851214;
        Wed, 12 Aug 2026 13:50:51 -0700 (PDT)
Received: from skbuf ([86.127.220.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981e2dc44sm18113245e9.2.2026.08.12.13.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:50:50 -0700 (PDT)
Date: Wed, 12 Aug 2026 23:50:47 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Semih Baskan <strst.gs@gmail.com>, florian.fainelli@broadcom.com,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: b53: be VLAN unaware when not filtering
Message-ID: <20260812205047.ojq2yyjtmoe5gjot@skbuf>
References: <20260805072641.402-1-strst.gs@gmail.com>
 <CAOiHx==-d_nzO+TQO+4UD4GfoLSOBUyfLuO+hfj8rQ1if4sZ4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx==-d_nzO+TQO+4UD4GfoLSOBUyfLuO+hfj8rQ1if4sZ4A@mail.gmail.com>

On Wed, Aug 05, 2026 at 09:44:51AM +0200, Jonas Gorski wrote:
> Unfortunately what this does is break modifying ARL entries with VID
> != 0, which is why I haven't added this.
> 
> While SVL is active, any ARL add/remove operations ignore the VID
> field/register and force it to 0, making existing static ARL entries
> with VID != 0 inaccessible, and any (static) ARL entries added will
> have their VID set to 0, regardless what the software entry said.
> 
> This causes the ARL hardware table to go out of sync with the bridge
> fdb/mdb software tables, and will lead to potentially hard to debug
> network issues.
> 
> The options to remedy this are:
> 
> 1. keep track of all static fdb (and mdb) entries added to the
> hardware table, so we "sync" it on switching vlan filtering on/off (or
> find a way to do so without having a copy), or
> 2. while vlan filtering is off, have static vlan table entries for all
> possible VIDs, or
> 3. use direct memory access registers to directly modify the ARL table
> memory instead of going through default registers while SVL is
> enabled.
> 
> Neither one is a quick and easy fix.
> 
> 1/2 make switching vlan filtering likely a costly operation (I test
> implemented 2, and it takes several seconds for SPI connected switches
> - not sure if this is acceptable). 3 requires knowing the in-memory
> formats for each switch chip, which aren't publicly documented.
> 
> Best regards,
> Jonas

I think the only reliable way to fix VLAN unaware mode in a way that's
portable across all b53 variants is a variant of this patch: allow
802.1Q mode to be disabled. Then we need to deal with the fallout caused
by it upon the ARL.

1. This looks implementable with some complexity isolated within the b53
   driver:
   - on any .port_fdb_add(), .port_fdb_del(), .port_mdb_add(), .port_mdb_del(),
     compare the VID of the entry with the dev->vlan_enabled state.
     - if VID != 0 and dev->vlan_enabled, or if VID == 0 and !dev->vlan_enabled,
       commit the operation directly to the ARL, as is currently done
     - if VID == 0 and !dev->vlan_enabled, or if VID != 0 and dev->vlan_enabled,
       operate on a software list, allocating, deleting or modifying a
       local representation of the ARL entry
   - on vlan_filtering toggles from 0 to 1 or from 1 to 0, acquire
     dev->arl_mutex and flush out all static and dynamic ARL entries
     across the entire switch, commit the static ones from the software
     list and clear the software list
   - dev->vlan_enabled will probably need to be merged with
     dev->vlan_filtering, since the vlan_enabled=1 vlan_filtering=0 case
     is broken

2. I see bcm_sf2 has support for B53_JOIN_ALL_VLAN_EN; IIUC this
   proposal is a soft emulation of that. Would it work though? 2 concerns:
   - in b53_switch_chips[] I see not all switches have a full 4K VLAN table
   - unless b53 has a feature equivalent to MV88E6XXX_G1_VTU_DATA_MEMBER_TAG_UNMODIFIED
     rather than the port-wide vl->untag, the emulation would either push a
     VLAN tag in originally untagged frames, or strip a VLAN tag from
     previously VLAN tagged frames. Neither option fits the bill for
     what vlan_filtering=0 semantics expect (ignore the tag).

3. From a distance it doesn't sound bad, but I cannot comment on the
   feasibility of this and the scalability across the 4 b53_arl_ops;
   maybe Florian can.

The big advantage of option #1 is that it shouldn't depend on any HW
functionality which is only present on some silicon variants. I don't
see any downside except for the higher SW complexity in the control path.

We could also discuss falling back to software bridging for the
vlan_filtering=0 case, but that penalizes the data path, so it would
probably not be the option of choice.
