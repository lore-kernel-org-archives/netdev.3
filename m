Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC43C3C14
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903339; cv=none; b=OHecNnLODGDpNyQO/b83atTGWJdSqVOZi5xBVj2kbxvD+mepKUdSPWD2tTbmpEfFQxdR+NVnKcTuT6arGtcXP9RTaqdWLqi9h+rhbGRRD+q0/QVibrCqBeMJ2/HmXKOSao1H0ax0tp6hav/lPc1BCSiRTVsnKIW35yfzgGrBChc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903339; c=relaxed/simple;
	bh=pFCe28kScZorfj+oFbKh0UUlHSKqvNf5Sz89//SKaT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRaaVfjRIlWvif4C+tfMNh6tY0dN9QbyP5C3LKbEmuKrDyg9GgK4c4W3oui1SvrtI1XE5t7T6lhjRS0ibB63VwFyom48EMOviKy5dqsGvFc/vxf+RF44y/60Snxc4biid1xEqLkzGFywZD8bQV/gYzhn6VO2jyLdbWAdJzTq9Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSLkgQ7z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSLkgQ7z"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso6007565e9.0
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 00:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787903336; x=1788508136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g+1PPoYsI2HlKpMkdQ7Xz+bHJWL8kENOA0+Lx9uYTPs=;
        b=YSLkgQ7zGIcimxTaGbE6g+xElSDOD+6ImuQdS3WRna9wWJxosdc4AAtcaKhEnd+teA
         om0tN/49F53G/PItVdQjoy2TfMr1jsYAruyPillCe0vsgoMfy+VymGjyQT+aomb8BQVb
         uWQEHOVGdxOp+ynN6L93GxIGNrYLse/8+HF5lUhDnrCHXihxc2ovlR8XU+9aQK3nwof1
         d0cCSjRAT1UHLsfaaCQlI/FC+2I5OtOlqqkCoFwO0XiGU/S7YvO9yaZnYd75GE9NIkyC
         4+G8Vgxktmmko2kvgcpBsDKEJahqv9hk0zsebJuzkJEIx7TJI4Ozzk+0yNA0hOGd6LXe
         +v4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787903336; x=1788508136;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g+1PPoYsI2HlKpMkdQ7Xz+bHJWL8kENOA0+Lx9uYTPs=;
        b=UUAWbG+j7uswCrWfumpwIb1QQStVJZvcqS4Ku2bgf4R1r+YBRO0I6bT2DCDnYtTj0S
         wKTkPkqhsBXCdIbEM2fiKSRS/2IuHWT7pl38DEsDJTyyAFkAZCHR8WoE74rBVfVOqVY+
         FhjOIw2MC1j4R66Vra0IQygHUZ6UsQgixzBsytZtcT06qoXJ1yRBEvYdPR6OoA4LqEWG
         1S4RvJrQ8ueTG7w42BZ8YQHmqcTkMhYEdS0sk+HDydrVhoaAPcpa3W9TpKLbRlNzffE5
         gLFPtzOWcQatDvGaJqOiwK8u9/ONfdYq6fzS3H5LC2qCHrVz4dfrJde4/TDaPtn2fw7C
         1LEA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7gLdFwVAKY7cBpVi9YHriCYAxDv8seGBIWC66b7H8qfykDmFcQ2dkn0pOrI/v1MlzTzd0n64=@vger.kernel.org
X-Gm-Message-State: AFuF++nBxPhbJPDpdvLcpEnXXByTGTIe/LD6BuLPU1643BMLY1B/vzLi
	fFcxUQMDlO/cNVIpZotIiP9wJwcCHZsD9CUvI4q9O4uSVPbCn44Akrf0
X-Gm-Gg: AR+sD13t3Zobm+/szWCnGODrYsm9pxHqSrBHXumJDQS/GK+pS1ijAMnfbcBGGXEPgdj
	q4SFxjZAPS3bV5QzRDuauVC281p0SPViC3SkmHjyxj5Gey0gXo5qAQBnOctXXQmRkKczdaItUT9
	2iv3pbvPZsoj8NFPCvk+Tp+07wiClKDz+FRfreZxiz/OXOAGwiisjxAFW4CQg6TJE46yCnMEb4C
	faxQ81Aitt1uaJdm24xUprWzJ5jaK/u0sFmvcr6AfXgyKAxF/gO7PjugKxK4OEbT9VlF/vi7H1e
	NkHkffxxlMwziw943Yz1Xi7c07sMjZYe0dJ7crmFfh99w9D8kRxdOMOdvT7D2GsP95hkf2mJXSQ
	wQj0NA1j2PXAxDqN2XySejf60Ypj1PcsiItXUgC9An2Cf5BYr7pQ9OLbsaCvoMmqUvYaIzb2kLX
	tET/WZs86JDHJc+4HkXe6UoR2tixTz9oHDbKAYy2xMenSB1uYhQSk3UGfqRXUGGx2cX33pvrM7G
	me+BERbfoEtMCbO7YrIbKtdhQ==
X-Received: by 2002:a05:600c:1c0a:b0:499:51f0:a9b2 with SMTP id 5b1f17b1804b1-49b91c1dd3fmr71584955e9.1.1787903336368;
        Fri, 28 Aug 2026 00:48:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4e2c1af7sm110839735e9.15.2026.08.28.00.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 00:48:56 -0700 (PDT)
Date: Fri, 28 Aug 2026 08:48:54 +0100
From: David Laight <david.laight.linux@gmail.com>
To: aslan.jnn@gmail.com
Cc: Raju Rangoju <Raju.Rangoju@amd.com>, Prashanth Kumar K R
 <PrashanthKumar.K.R@amd.com>, netdev@vger.kernel.org,
 Thomas.Lendacky@amd.com, Simon Horman <horms@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>
Subject: Re: [PATCH net v2] net: amd-xgbe: support receiving packets with
 bad FCS
Message-ID: <20260828084854.67cb625a@pumpkin>
In-Reply-To: <20260827233527.71620-1-aslan.jnn@gmail.com>
References: <20260821213646.7bbb94d6@pumpkin>
	<20260827233527.71620-1-aslan.jnn@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 09:35:27 +1000
aslan.jnn@gmail.com wrote:

> Hi David,
> 
> I agree with your first statement. I've just submitted the v3 of this patch
> which removes the DCRCC unsetting on xgbe_disable_rx.
> 
> And thanks for your input for setting MAC_RCR non-atomically like that! I
> didn't thought much about it before, to be honest. Will try handling that
> on the next submission.

I'm assuming there is some kind of reset that sets the MAC_RCR register to
all zero?
If so you don't need to change it at all.
If not then you need to absolutely ensure all bits are initialised to valid
values before the receiver is enabled.

David

> 
>   James
> 
> On Fri, Aug 21, 2026 at 9:36:46PM +0100, David Laight <david.laight.linux@gmail.com> wrote:
> > On Wed, 19 Aug 2026 19:16:56 +1000
> > James <aslan.jnn@gmail.com> wrote:
> >
> >
> > You can delete the line in the disable function that turns it off.
> >
> > But, really, you should be setting the required MAC_RCR bits in a single
> > write.
> > Doing RMW sequences on the hardware registers for each bit is really wrong.
> > You also need to start with a known value for all the bits, otherwise
> > 'silly' things can happen is (say) some bios boot code set bits you don't
> > otherwise change.
> >
> > 	David  

