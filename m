Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22473F4829
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 05:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785823194; cv=none; b=g+LQ1MX2BziSaXYANHSE8DEWopEjQjyV6D7CxG7uVqarhYzp2QeHNXVQwwo38ULuHf9YX/By1xOOHvSiM49ujyH2frBXfPz+BhiYZwg4kMYnubIT8J6lQQ8K5o90s9WUjNxqCyqdC9B8P9EHPr7hVE1n4ehyWChiP7A9RitfBPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785823194; c=relaxed/simple;
	bh=W8JyDBWkDjCNqLnmCkyzKGxOBYAxowX6GpPeWx4YIb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlVaB7veHc6d/UdRmF+nerbQ57G1ODfFa2C4+dgcJaIoE5ZlalxHB7Vwluy3wMAlLy104VAvmavNfAq0BhHzE8o42gokOsv9PtbmAj8crd/bbXmpdZCFsWTrn4eLXuMyXeqDGI/gmZ/N9c3BsNyGDR3UGuKA9vub2g8gHS67kIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Obpa3LDP; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Obpa3LDP"
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D196E3F82A
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 05:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1785823188;
	bh=W8JyDBWkDjCNqLnmCkyzKGxOBYAxowX6GpPeWx4YIb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=Obpa3LDPcf/4q9N/O5KxNmaUiZ5Xp5yU5x93sQktTSEx7toBWnp3I9CfGo8vYj5FC
	 U33jyNpBHpM5WbhwBxiNg+gS3u6CKTvM/D28Dy85BjkVgMTmRB/FlxJ+dacfeyz+8N
	 KwzQK06m/tHB29teg1xnvNOjBgIvgagqq8a9dyV01gJTSh6RXcdtzutfL8D4fgqDXQ
	 NDYaAGMTiXM3ZX0PU0fbI8zYlh0JxC83AXuffwZUhkoY+e04wb1ywXX0C8+SorezDL
	 rnluQn4w/mFgRuubj/nFb74tzcGy7TnV4K5m2bPk0UkaMkqHY5bui5BJcEQfptOOSQ
	 vA3SetW3Ty5cL5MW8pM3w6BKJq0TQSAJQpRTdJNVCU3yT1FrI9kkitXRTkA/Ms2MNK
	 WOqs1t34lD7K//OoBvWyLWHpgldc85ujrrM780N+yNtzckGeZzB1CLuB2E/dgmgKe2
	 PdlrMfViFa2O2JkxSLJVfn9Yhbkp5tP1ht/aOePdvEPBlXWR2+Ard6IbjTnHZConNa
	 +UXP1igxOnB/MS2xNtyN4aBGL6cMwSgCXT3sYPA345z+UwEcOaFSIsi8rdms7Ns5th
	 nz8v5yj2pPJoIYZeJ6Tb9lI+fPUxOMNrC4M6jmWhy5BHXAGv95dc5u1embfcCnlxvg
	 aZ3xodEghcSkEWuBfkf3aDvQ=
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e3d575d6eso8847021b3a.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 22:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785823187; x=1786427987;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W8JyDBWkDjCNqLnmCkyzKGxOBYAxowX6GpPeWx4YIb0=;
        b=C18tM3JRoybhLpHtmc8AEY9MN7Cy4OMDsxob6oHmeUlQ8hpJF8Sc2eXewpgZmgIEsw
         EnktPtaJeBp2NiSpGQqLKzIEO690ST/h5yRSgddkPbfMfh0FD6vH/1IidJ51B6Uv6Ilu
         IMyrjiwiyLs3PQyC5qynOR3qB2MUM80x84HuToY5KWcZCU43ZjP3UQ2Att+2EXvx5OO/
         YxOUA3KcqTZcz+bTUL9P8SzUIUvBYEhZE5iAy4phs6RSUWRgrLN6qdKjIEvmSFSUZdgV
         dnKOmMi4jIy36jl8WmX4ZGoA++sAKutkhParyS2oIUpczUPJrl78bvC/VK1UTYmwy0Vi
         hTkA==
X-Forwarded-Encrypted: i=1; AHgh+RoZ5+g7iJ4vJxtIA9kBHyf7MrFTHUcoqDx0IosLMrK6PXxgRmOo99rErDqVykp3X+5xFsSfEJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjj/fdXK6cT18IQYHt0PlmfwRUL2G0PvbfsjaBvNV9R/aZMM31
	9GqRk4q+ZVdDsd20e5eucABiSbqCbuKTVTkWR8txQq7MqLFrVLmNPT8SYuqelTgSx5lniOlp9hR
	Y71+QfGf7I1DiSIegSFiv+HVkJFad+Y5+kaJ/te8fy+vrS7eYgiliglshrAjlgmBFpCP4Ozf9Jd
	U1RD0cvQ==
X-Gm-Gg: AR+sD10cxVJH+MK+1SXasNOprYmhCL+53ChGQy7HqZ51QlutMDqq/Dw6X30XhmDISnq
	tN2KbiGGhGX5huFyn2jBuE/clvL1WJBeIvTd2QteemXAAumcbC97akdSATBMvj5bEft1hTJh/8v
	NiC8jsMT1w9Kf/4PQaWFCw+Q4udDMj+MoBbbXGkLcxulytzog4yv09k2YqK8qWfBgiJV85Ek7Ba
	R1zqYtE9jp2oT6zQmI21UuU1BrMXLb1PkBVKbKARGLn9Jw2+xdg4pzAJfodXuVayORvrbGLB4Tn
	pMzPfJxM8gva0XPkw+7cSrGXduENT32YQJdpKg+bSz22xK0Y7pfSwxVwVCNsAgo4qSO/ax1XLkE
	2SsrqP7tCg1E6d5bcwWigoYwv/GPBIGXFqmoPEQLJ8t5sNuBZGbK3V4TA
X-Received: by 2002:a05:6a00:f07:b0:84e:2d5d:5e4d with SMTP id d2e1a72fcca58-84ee4998f2emr12535443b3a.68.1785823186948;
        Mon, 03 Aug 2026 22:59:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:f07:b0:84e:2d5d:5e4d with SMTP id d2e1a72fcca58-84ee4998f2emr12535425b3a.68.1785823186626;
        Mon, 03 Aug 2026 22:59:46 -0700 (PDT)
Received: from acelan-Precision-5480 (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84eecf81b08sm3430742b3a.22.2026.08.03.22.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:59:45 -0700 (PDT)
Date: Tue, 4 Aug 2026 13:59:39 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH 1/2] igc: Wait for MAC passthrough
 after reset
Message-ID: <anF_hoO57nh2363f@acelan-Precision-5480>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	"Ruinskiy, Dima" <dima.ruinskiy@intel.com>, "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260618073324.1843310-1-acelan.kao@canonical.com>
 <IA3PR11MB8986B77F49DF672178FEE4BCE5E32@IA3PR11MB8986.namprd11.prod.outlook.com>
 <c3030882-55c8-486f-8ff3-571d001b99a1@intel.com>
 <ajiHH-RaHUjgraMh@acelan-Precision-5480>
 <1d6c3aae-c9b1-42da-b5fa-6f8ee9ebcae1@intel.com>
 <alcd_FnUdrQug5cm@acelan-Precision-5480>
 <0e28b9d1-ab9e-4934-b939-81557f6495b5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e28b9d1-ab9e-4934-b939-81557f6495b5@intel.com>

On Wed, Jul 15, 2026 at 10:57:04AM +0300, Ruinskiy, Dima wrote:
> Hi AceLan,
>
> > > > I wish we can detect if the MAC passthrough is enabled, so that we
> > > > know if we need to poll for the MAC address.
> > > Unfortunately, like you I am not aware of any way for the driver to know
> > > whether MAC passthrough via FW is enabled. Because of this we have been
> > > exploring a simpler way to support this feature via ACPI objects (which are
> > > set by the BIOS when MAC passthrough is enabled and are easy for the driver
> > > to query). I know some vendors have already implemented it, and I am
> > > currently drafting a patch to send.
> > Any good news about this patch?
> The patch is here: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20260706/055944.html
>
> I tested it on my setup with MAC passthrough enabled in the BIOS, with good
> results; no community feedback yet. I encourage you to try it. Lenovo and
> Dell laptops should have the capability.
Yes, the patch works for me.
Verified with both enable and disable of MAC passthrough, and it works
as expected.

Looking forward to see this patch merged.
Thanks.
>
> > > The mechanism I have in mind does not require BIOS support - the I225/I226
> > > FW already supports the required interrupt, AFAIK - it merely needs to be
> > > enabled in the igc driver. With that said, there still remains the question
> > > of how to notify the network stack above us that the MAC address has changed
> > > post-probe - and whether it is even supported.
> Looking at it again, this may not be as big of a deal as I feared. If we can
> call eth_hw_addr_set at any point in time to change the address, then we
> should be able to do this in a response to a FW interrupt. I can try to
> draft a patch for that, in parallel to collecting feedback on the ACPI
> approach. These are two different means to the same end, and some solutions
> may implement one but not the other.
>
> --Dima
