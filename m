Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8D41DF742
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 00:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773795204; cv=none; b=i9lTLVILeqy00q16D2Os+tlTk9iOAckiAkVFsBJT2ciMg5iprjHXp68C1lYZ/ilXpAlR2Di5G00/F9jhwSP2pudOo/uet4DUUiZR1+JIyJeO7jLlJd4pTsD8pIKcu4Wihgb/9lBkG/pXQbuSwie1uhp7QmNaReMC4XABtsDFAdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773795204; c=relaxed/simple;
	bh=vKRjWMQNCxTAezrSH8HsoqRVsJfkECYcmwqxW/Aj8Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scctXMlsdBxxDFp4seVrU7isut4vpzFCPcbJL+lhxqCB0ZekUwzssFL6+W0nocO+4GZ1YU/+cg1ZauJnh3fLXrtRYEUY7PQah431Bp12G2qRz8Sk6iQX0HABNky9SlMA+CgkFmFemsUKB7lohNEMMj0+pYfcLMrCwJPnx0fPlIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=jk52mHr/; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="jk52mHr/"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c70bfef17a4so4231751a12.2
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 17:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1773795203; x=1774400003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WW7jK2GQPckG+qnwmykLsFF8MdG5oTYuXZfi/B2lx0Q=;
        b=jk52mHr/YZIhAcGTgJxwe3VZw3PbCrB6PJSgGWsdE8xNoDuTq1hVdssbgpyvJlSLa5
         ttUrJUZdgpUg+eFn1+JSL4GqEnC07allOaVHSKLTlYVSK3SPYR9Be4oB13HsVqr+syF/
         fMBFrfgCuc3IG8OrhjQIv72sxn9MkfJmmfQ0+Yaky8k3ng1i8hrZXUX3fQ8YGfgY6TXk
         TVZjiqe9aN3dvz1yjyFZXkxDP0QNoN/uGbL1tjApeRXqZOMHklqigpUgwDg0WBmccdl1
         LU08CMDHt9Vkf7HTy0rUPNhA5P9WbA0bup5Z4GjKmqsIl/10A+8SCrgf2hwlvWJ1gJg8
         AGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773795203; x=1774400003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WW7jK2GQPckG+qnwmykLsFF8MdG5oTYuXZfi/B2lx0Q=;
        b=DZuOy8LF72Ix7SWtQBZybh1KJmXt3tefz9bwxt/d/Q5FjfkD5VxzfAwXDyTky6/i3I
         aATeXS8R6gFQ3udy2Fp8VKYvV2pT8QTpc2LTVOoZ0TS0JLmEJIos7DqPQXqhjkkAUM21
         GIDuKIS2aNl2rXW02Id+oyUkU9p4JRZH97B4Cc/LtxlO0epCxpY4/+1tX1XBOKiw5YQr
         v5UfiRazwvAW5RSi14Bxi3zcYeWZTvH0WvBJ9vsakqMEDahbI9W3/Zfnaoz/PgHKtb/T
         2YOKNzG1iM07//sOM7DRo6xaEPhJ+HWqUKMqd69t7pSznsFns+Dhn/4orUUwCERbfmhz
         QyUg==
X-Forwarded-Encrypted: i=1; AJvYcCXrH5P+s02apAOfdm9XHySPKOf2gTRfTjY6tnwRUCxqxTF1o2p9HZlpdVbnlvhkZA1NqWJwFvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr9XsQxlqEfqIOY+AL9bOGVYJLV6psOv3ViSf3QSTnwy81sPTs
	/x2fepIMZGo7e7D54X/tS3/uEeUwwCppMdwJ0xIl/1KxRKJ7ItABEvrz4KaEvb18mks=
X-Gm-Gg: ATEYQzzjBceYWBAOgx17IPz5kzDEV2DeNWUfv4NIn9foV5diC4OqmtevpWRydw3zuKj
	P2CYUwcMDYRnfNbVzCw2XQ6vErCoUN8DiW1W0soFGwBWVW6owk0UOD0E7xyNYiQeQQ3FuN01h3Z
	je9bjpn6dRHE4b6bwRt8UrWNaxO1wD5D8A63Pe2KT6ORaNCvGiE4ZFLq02Bx2JEH+29lo1tln0I
	xS5uus8R0VjAtIiCusSj76zH/ULyzPRJ6b+R3bBO7wThwcmDjebCxo95tj52nGFYmub8wDYLvgM
	M0CyoS+/2TBtfyfAbRaVxV0QixciZYtuOfXUNJEdvcfJvaoztRLU0ubDba20jM9CROaNL1yWhEW
	NkzDaZobUin9PwyMe611N7kwQy76n7TYl6ieoKX3N0JEdbgyOAsyB1SMMeXoRi2dem0XN3A0CE7
	YtJ03z5hhwcAU27YGEOiXUvz3Flx6DdTQBCtU7msUsMgymenblpftG4ZTjpWmxA4IE4X5Z2ShXc
	ZPXT/oGufFe+iZiPyTcaQ==
X-Received: by 2002:a05:6a21:6111:b0:398:c351:aa0f with SMTP id adf61e73a8af0-39b99d92725mr1107520637.22.1773795202945;
        Tue, 17 Mar 2026 17:53:22 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e5694acsm730394a12.24.2026.03.17.17.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 17:53:22 -0700 (PDT)
Date: Wed, 18 Mar 2026 11:53:19 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: syzbot <syzbot+d9f5fabbbcf4b377d01f@syzkaller.appspotmail.com>
Cc: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] WARNING in cfg80211_chandef_create
Message-ID: <tffrshs5h76cfj3k6lelrx6lmm7qtc7hww7r554xtnhfnsw2ip@dqktqrq2k47q>
References: <69b992c2.050a0220.248e02.0132.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b992c2.050a0220.248e02.0132.GAE@google.com>

> HEAD commit:    b84a0ebe421c Add linux-next specific files for 20260313

I think this didn't have your fix already?

lachlan
