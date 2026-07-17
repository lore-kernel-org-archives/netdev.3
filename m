Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C612E1F0E
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 02:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784256760; cv=none; b=UWl0fZ7tIm5Jkd8+xoM70LQxqWiO+oKRl3lGbIaIpNcwsBJWy7of7+my+448cjmku/usc0p0OjuCXPaoqUDB3LiQngKIYyY8dHq4N1y3us820ZDHEA1AAKX48p2B3me+RzUoy5boMg1IyeLuqKKGj43K5Z1RewS3oNHdfqS7lKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784256760; c=relaxed/simple;
	bh=dLdFutuNBIn93obnZQhcBIj2PVvj0W3nO3cDawqW3q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZnJ6SvEM3pbF/1Zqe1ecZsI7fFOY508K7HXkhwIDZXNYEhNQZqTeDzlo+/tVRnIR4g2HmysP1s2TiQR4i6j3J21ikgTaliukNPRZBQ/Z8ADAkiuiZwnqLcVMVKHYAScMockAikhzEyhWnOj2ceCJgLjEQ+5O/yTVGRVE81T1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=LLg+kGpn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b="LLg+kGpn"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca913a601fbso5065610a12.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 19:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1784256758; x=1784861558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=imgrbCa7kVSrxtr+H1EX7S0xO3/9JxSteVkZZkYrlEg=;
        b=LLg+kGpnHb1Jx0VOGOTzPVde4ptkQVjQIUaFTOJQjQebNWmY+FnjeIbrkNM03+1ZPW
         MO2fa/kGV9tKobYchkkTjtA533hah/KmI5DAFCMKDH0Eo3LtDwrlFOKJG/UMYTDezWcT
         4UpElVXRY2s4azB7ISBilx2+YjHG0Zx3MNjNQJL1I2EJ2nSQeYUNDIuhTb2jLd9VQUZ8
         g86yRqGThsOjclfwuUmXfxCzr28a76VBFPXlJDiYiYYfIcEkzW6JGdq3oClyYCckat3s
         qOviV9J/M5CYHxTpBsLOSkueNf4fMjlDF0we3jDiwx335QkU5pgpmZI8tre5BZWLqaNd
         Nszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784256758; x=1784861558;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=imgrbCa7kVSrxtr+H1EX7S0xO3/9JxSteVkZZkYrlEg=;
        b=lAzDlZ1t8YPKh6j4HH7aw/N5VxP+esP73X+289FuV7N4a1SFkyK0f9FY9BUsC33fi2
         dHgYkEjms2Fw2Ds8Ns9WAdEVI8VNeZB/Yl2wF9tQA6Ei5ULpoijZsKJAc1veD7MxOCMS
         2/TmX8KCSIBRZLPNCc51Eje3MBZzEsEIJgfYassnIRatlC8J2rgggf/Ua5zKjFaE2D08
         edSWzu1pmcLR6tc2x2MUQ0bZ4UZzwHUk2/B+2+D/aRc0Wr0PYXEL0EJNMV7SKGFRJwzN
         FF6A2UF/+MISY75KQbEfjLeRB6dVtkA9ospKfOdeQRk6+C2usc0mWrdhLJuKa9h8RyML
         86yg==
X-Gm-Message-State: AOJu0YzcPPkrFqwk9iU8zC+6BOmEvke11ITGBzvAh5auZFRrWFvw0CbN
	clhSKGFK1fMSoq9hNaSGSkBngDFlaSvN1JGOxCvCKxzDu5xK5F2RbhbGJpse8k+bC1iX//fxXw+
	G4GN2
X-Gm-Gg: AfdE7cl2ByQ8lvSTLEvLUtWPJSOHr1sOdBuYLuybvSjwBes6v9PmZuqXhReRw4R2qej
	hiXj7KlUybAfPoFi1+rK+FYU7Ak5n1VJ4DqGhpYmC9HvKI7CWaDLSpaa1zbqQ2r+4Qupzvq2hLu
	r0L/FKsLKlnM+TA2undRn5Zuq3BcmtzomrUaIv4R6xdWY7gXjNfHkDCenjxCtHWANDPh15KRVef
	S6Ri5aYv/ZD/T4HY7FWpsUNbTlYIdWSg/X3AcBJCbJ5HfGQl7I7VgInDe6B14C5LbvyH+XG5G8b
	3qnM7BtgsgTUIbb/XawMo+WwYS/LkoiUFMeK1emNrEB0MDDq/5tNnXdttrlKs+MKiF3W9Kfb7yx
	GIzplELpjohVEciwWiKgI1cRHkA58yDsaMO+wrDg7Y2el1lD57OxyK0vePyTdN1C88yC59ZQBPU
	Uog9j0ToD7+61YZ+KjroBAELnvuXTmy/AR1ok=
X-Received: by 2002:a05:6a20:160a:b0:3c3:9df8:2eed with SMTP id adf61e73a8af0-3c3ad7928d3mr697498637.31.1784256758424;
        Thu, 16 Jul 2026 19:52:38 -0700 (PDT)
Received: from localhost ([2601:647:6802:dbc0:a27f:7ab8:2b11:2ad8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2a129f3sm387183c88.7.2026.07.16.19.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 19:52:37 -0700 (PDT)
Date: Thu, 16 Jul 2026 19:52:36 -0700
From: Cong Wang <cwang@multikernel.io>
To: Jon Maser <jonmaser8@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Proposal: module for optional /net directory for network data
Message-ID: <almY9NvR4nJtpW_o@pop-os.localdomain>
References: <CAF=mWJMErgOuTML7hFy6gEH5zqACOdZU62Xh=bR55=VbB4fJ2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF=mWJMErgOuTML7hFy6gEH5zqACOdZU62Xh=bR55=VbB4fJ2g@mail.gmail.com>

On Tue, Jun 16, 2026 at 06:13:51PM -0700, Jon Maser wrote:
> A little under the weather but hopefully this comes across well lol
> 
> This may not be for the sensitive. and yeah I do have a mental
> disorder as well, and I'm not an expert

Any idea is welcome!

> 
> But it would be nice for network operations to be aided by a /net
> directory, where devices can have full access to network data,
> including hardcore bit by bit access, complete control of data coming
> in,and out, shell access to network data, you can easily cache network
> operations for forensics, you can enhance firewall technology, even
> with hardware firewalls by giving vendors time to adapt to a high
> level access of network data
> 
> It needs to be a module to be a true unix imho
> 
> It can be as easy as cat sendack.ns > /net/0/in && cat /dev/eth0
> 
> Its also easy to write a firewall in shell script

Linux networking subsystem is ruled by netlink, devices are less
preferred interfaces, because netlink is binary-rich and flexible.

Of course, you can always write out-of-tree modules without
arguing with the upstream community. :)

Regards,
Cong
