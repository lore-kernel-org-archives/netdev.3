Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9C0442FAD
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909117; cv=none; b=esKZQoDEYExW/bOlXhOn55Uxkl4mV+2oloLCjMRMxzL0m3CJWskAKlLNGdvYgmt8ARx4BQ0CrN+mQe0yhPa9M78pAmHisrg6uo+VBN88UZEZJrLhdxVSjVbiJZSBRS6AK9IT5LnELE3wSkerELNEfjDKoKFrsuQoyHFTnNpyj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909117; c=relaxed/simple;
	bh=jVoffflUFRUldWYlcsLzrBBiD/YHbIulS/ytT8HmD7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzqPuv3hTiHD7LLT0napfWNZB776/CTHgayF/y8wUk9XwMviBFUmzX/wgowjnZujgVI+vIocJLNyy9fpsWRjCayOqWq+6cFkTNA7+u0ypl0owsF4WWxVySnnyKwSb1j+OR+i7zT+KIcb9ZNonAKBJqOIX56LXNOnZ3xqO6k7lk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfriWwQR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfriWwQR"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b966dd74so4365285e9.3
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 09:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784909110; x=1785513910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B9MZdtvGHwIA2KMndbrXAZPS24BSKTpOQYvv0Eul2T4=;
        b=PfriWwQRDJF2XmEr4Cm56PO78CTpUUwouNm9sryP55XBAsRB1gSQHiF+yI/Klyp8M0
         eZXcjjoDnGBrzwsVO0xGIfT8prbJrevE2QWndDdjBeNB6EgxhXhdSt2gnfhorZmp76z5
         jr/qy0OcJiKU+kA4a03d3NH6vZSmOp2iAN3QYkl11Sldp/EnB9ey5m+JrywZoqP3bT95
         RYzzJxWuw9iMKkeDj1Gl2fdgHyXestm8pln+vynb8OFLaBimXSGwG50GNJgFB9j7euet
         waeEdImEMBYyr+Dgo1Zrps2b+3hs7/BlzdHkqun2DipZlv9+wXKVs+uyXfV9PGNXtGhh
         4E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909110; x=1785513910;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B9MZdtvGHwIA2KMndbrXAZPS24BSKTpOQYvv0Eul2T4=;
        b=qt2p4Xwzjyr4y9KXK60AUWoslZ3I7Ear8/FSOjc2WBfxO/xL0zMbtOB30cIDj2CrCd
         ZchC6VPC8Ca/yi1hw8TTeOkWDpvgepe0sDiKm4UGmLzhKTNWY4h6GuCtOnNPLU0wtlkd
         z6Qt0xI3Dfu2fRRB3+pNpisyjaNtfVLjOPU+0LDqlpKPr3d+3Q3GqkN+VAiKjEbbgRjf
         XR19k1OLJiNrdp8yirDJGWuxUvtJ7SpFniR/XuPhDty3GPAHWQpU3sgmwo/bnpQX4IKa
         ylqNKecjL0AKFdlW5ts+9hoqyAjvxZHN5/Fr9Ts4l6CDi0uTesMk8OXwUgDgNoDGD0eY
         Q+uQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr3DnMKTX+SIBr70MCL9nm4Wx2ada4ek5bUZP6h7oEilhHB+vHoQI7RVSB2FQMLkNODxnxX8cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx//3REOZxQut44zvR7qqHXruoVkGn6H1DR2AisnxHCPc3MfCE5
	bN0gI0TdWgOc/nbdfN0fRbpRGRH0aMXK2Wtj2kmvos5SX/3w3t1dJ1Fp
X-Gm-Gg: AR+sD12eUeAOPdnWVoW9vogPY9mVUlrljeVRgX0EV4eNNQg+0RVKspYaaesnAuEONwh
	b31QcLajmx6ZXKksVXLBYj5c+pu9mH//chmi5tJ3PdP7k2erAwyTJQPeZzZ+fP6qWKylSSWC4K2
	neraA0tIpRjVd4ryT66nsSv3iIaSHRGafzINas2/eT7lXzrAhaG297FXtDsoYj9DUPasbB4CJVz
	2Y+otTc47QQFszKhQKrV7CZM9aaGko0eiQKmPs+xUv5cgg5FeQAHHKw5iopMseSVzjbldohARTc
	+m5IzisyqBHjvymMKN+7b4i61n+Js8mVWZJvWRpvGkGRX9Jj9xOJN/KhJORQo95YUe2yuLCzHqa
	2SRvqJC68cSERBIkcofw8vbxKDB4NR1UUi7qdo++mHsydDmtAjGgMcrNYzSZYwwCi1CyJZ6lElV
	Py6Uz4rMu4erq5j80gjWSuCSI/CnJXCYo+Jx4h1c0=
X-Received: by 2002:a05:600c:4687:b0:495:5dcc:52ae with SMTP id 5b1f17b1804b1-49573cc2eb8mr99184655e9.3.1784909110269;
        Fri, 24 Jul 2026 09:05:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9b8b67sm45331585e9.4.2026.07.24.09.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:05:09 -0700 (PDT)
Date: Fri, 24 Jul 2026 17:05:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ax88796: initialize all fields of
 eeprom_93cx6 struct
Message-ID: <20260724170507.492ffb61@pumpkin>
In-Reply-To: <20260724150403.GA56515@wp.pl>
References: <20260724083411.8562-1-stf_xl@wp.pl>
	<5df6efd5-ebc2-4049-9501-e013bf68c51a@lunn.ch>
	<20260724150403.GA56515@wp.pl>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 17:04:03 +0200
Stanislaw Gruszka <stf_xl@wp.pl> wrote:

> On Fri, Jul 24, 2026 at 02:57:33PM +0200, Andrew Lunn wrote:
> > On Fri, Jul 24, 2026 at 10:34:11AM +0200, stf_xl@wp.pl wrote:  
> > > From: Stanislaw Gruszka <stf_xl@wp.pl>
> > > 
> > > Commit 7738a7ab9d12 ("misc: eeprom: eeprom_93cx6: Add quirk for extra
> > > read clock cycle") added extra 'quirk' field to struct eeprom_93cx6,
> > > which change how the data is read.
> > > 
> > > Some existing users of eeprom_93cx6, including ax88796 driver, allocate
> > > the structure on the stack without initialization of all the fields.
> > > As a result, the added quirk field has undefined value, what can
> > > randomly cause reading wrong data from the EEPROM.
> > > 
> > > Fix by using designated initialization.  
> > 
> > The problem with this solution is that the next time another member is
> > added, it breaks again.  
> 
> I did not initialized 'quirks' explicitly in the patch.
> 
> > struct eeprom_93cx6 eeprom = {0};
> > 
> > Will initialise all fields to 0, and then you can use the existing
> > code to set those fields as needed.  
> 
> This form:
> 		struct eeprom_93cx6 eeprom = {
> 			.data = ei_local,
> 			.register_read = ax_eeprom_register_read,
> 			.register_write = ax_eeprom_register_write,
> 			.width = PCI_EEPROM_WIDTH_93C56,
> 		};
> 
> will also initialize _all_ remaining fields to zero.
> 
> I believe it is guaranteed by C standard.

Unless there are unions or padding...

	David

> 
> Regards
> Stanislaw
> 

