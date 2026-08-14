Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2723A7586
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786747788; cv=none; b=L0BncBYoG49UgOCwlIffn1iCOkIic+L/uY+4/S9QohIVqOg6CuJ1/yTjs9aYvomBFe5zCs9jDPyNuACz4QA4s735gZgJTIW9H74JWRG/Tfx2jWHBflpez+/cExFypIyFOKAqu7lCjLUyKjjOx2iyAPLTbIVPnyxy2XcdtNVH2UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786747788; c=relaxed/simple;
	bh=Uj2+R/XlIIBkzBOTJl+GOwS1l87hHD9TviV6bZAx7kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpsqfVhGP0SmfQWCYRa0F/06WOIcfPKrREhFBmBRicQOv+VP/bAUPgFfcQ38OBZpLWhE7nw8t3nsBB4W2uYKtgGxuNjkiZg6gxIqIxRfB8X0u4FYOw+MAGpJhaGvNPD8q2an6sn1Cp6mW+KrR9/bwwR/TiHp34+d9XY4GARbo3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3rN+lFC; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3rN+lFC"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-471eeac43bfso1366335f8f.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 15:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786747785; x=1787352585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AXr1BCwnVUg1iSuJ2/QuEA4a6oezRbOQNZkSmQqG+MI=;
        b=I3rN+lFCImZcC0GU2DKz0KIxeDllzGi6w9FPm6LQibHQWZrpATi0WW9XF2P8CuK5S7
         KHhidyGIve1nCDBtEbYkuXCCD8A9bHKvvBqCMmcLJhdVfEA+YRDF7YNg2vCpn0cTuF+U
         hWIxaFLD9dAglEKkLVZzcxtCaSzNHVtI21uRFPSzi+pJgpBdUQnHzyvTnjrwDzVGUzvT
         1EOkU+bSyMqshXFBPih4n1pxfWmM0s8HNFUxI6malr9ybS4c4gDnMQkcCsXKXDsihvYP
         pTvvXP+WTuyuBh4MdL2xceDhTi7F5+2mvHr1XhOZP/gSVWq7ypcu+ZjKbTr/hS11MOD/
         jhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786747785; x=1787352585;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AXr1BCwnVUg1iSuJ2/QuEA4a6oezRbOQNZkSmQqG+MI=;
        b=A77J7HXYnt3Fu0E6FvsPankk8xWiyV717mE/ieAc05S7sMHhklbsvPY5PHZZzCY3xN
         CnNXL6NVa4ll6yvcp2hJXD1l5M7daVOv81OR3M6Ox2Wf9J9hgUtmIBPQSMilOlG6QFPP
         Bj3QeXaZxpuJIoVEj4tHzCAMN8grVjmvuiNFrHP0Ydq3KGbLN5HpXEIh5T/XWQym0p1f
         HEAZVTnKABEwZ1asVwtMN65SvEp6GZqfqd2vO9lxDkDfomgAFuRUy1Ihu+W5JVmrngDy
         PeiHc2xlbfTf0lWz/xcUkncC0nadeJ/K/KR/1197K2z5Rut+u1/GY1ZG1FL/w/HM6gdr
         z5rA==
X-Forwarded-Encrypted: i=1; AHgh+RrF56yNyK1+SoQUz6fbJ52xfIw/6P4UWjs4Jh5bGPGpTReHSQiQTyfn9K6rzPuX5M/28eStJGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1oCHvkP487xwCyj10BG5kF1KiDBx3RQ5faW7XlVrsrXfK5tDy
	2ZAzwk87x0VZ3WWdEq0ZaYEJAau+YbifCaZl4RUFmysVaTUDNeJHdQok
X-Gm-Gg: AR+sD12XhQOaY/LnKO2PeL7C9cJmRfpod+WIqL1YzzrhUBh1oTSf+RVsfzB1gCcmoac
	ybjWMkKqIDQV0XIhGGQdyNU9w7RcqRvk1O+U5G683ERhvF8gBSbf2bZgB4YypVFHEY2aOzNp6Q9
	IHtWqNOGWgLvNK02deQU1f7puvez5TNOrKRdZSCfF92zbGMLka6GDT/9SH4bxqekUC+TjtY0sFI
	djXI3tSV3Q0RahDTWENce4KqntbxHpcH4X0rx/hsCsGeyy+R2ASkW8Rv3xs/wvFrmzAmlZ1ZeNC
	RomWebQ27Pl6oEDsisQb/1nIARU1jJ+zeD9ABe05eFBXvxbFfXos21jNhl7LUsQHwP52BR7s/yC
	ovSU0GUs6nr6zDALCVL9vKDzlLH3UrMK+DrPFKBMrSXYkh9kllwVCUPw2J9RieYki05Qj87H3xj
	f1VXMcKaagsB3Xu1Obzszd1eKOGM2T55yG5htZB1aFW7H7eZT0bUAcrtnkYvO8fcQ1kHPsuE6bN
	5ZLGSBCBI5C3KGnYVVSNDUthr5aZTVglJTDFFpCFf2F1y3dFXCQpfeIXLn4pA4dzjX3dBREr4sJ
	X5MTF+MNLN4S3tNsG26hMVv87WcJSE10ddjMWV3YH+0VUaCs0N8zVWtiEUnehKsLAQ==
X-Received: by 2002:a05:6000:29da:b0:47f:4fa9:ae42 with SMTP id ffacd0b85a97d-48160759b98mr8911102f8f.11.1786747784612;
        Fri, 14 Aug 2026 15:49:44 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-9d7d-f301-9495-44ec-73e6-1be7.310.pool.telefonica.de. [2a02:3100:9d7d:f301:9495:44ec:73e6:1be7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48294e70f8asm3029024f8f.11.2026.08.14.15.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:49:44 -0700 (PDT)
Date: Sat, 15 Aug 2026 00:49:41 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next] net_shaper: fix net_shaper_ops kernel-doc
Message-ID: <an-ZnZWVWtDemvSv@gmail.com>
References: <20260813192131.21254-1-kmehltretter@gmail.com>
 <20260814101408.13bc8cc2@kernel.org>
 <984e036c-0d90-435f-a56b-ea39a2adf923@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <984e036c-0d90-435f-a56b-ea39a2adf923@infradead.org>

On Fri, Aug 14, 2026 at 12:04:05PM +0100, Randy Dunlap wrote:
> On 8/14/26 10:14 AM, Jakub Kicinski wrote:
> > 
> > Isn't this a problem in kernel-doc extraction / how we embed it for
> > rendering? Heading are quite useful and IMHO far more natural to use.
> > My understanding was that kdoc should be able to use basic ReST
> > formatting.
> > 
> > Ack on the list indent fix
> > 
> 
> I don't know of another reasonable solution for this (although I'm no expert
> on ReST), so
> 

Yes, this is a problem in how Documentation/sphinx/kerneldoc.py embeds
kernel-doc output. It parses generated content into a detached node while
retaining the surrounding title hierarchy.

The key kerneldoc.py change is replacing the parser call:

-            self.state.nested_parse(result, 0, node, match_titles=1)
+            nested_parse_with_titles(self.state, result, node)

This preserves the headings.

I tested the networking documentation with Sphinx 9.1.0 and Docutils
0.21.2 and 0.22.4, and a full htmldocs build with Docutils 0.22.4. The
full build produced only unrelated existing warnings.

I can send this as a two-patch v2, with the list correction first.

Thanks,
Karl
