Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488643C584F
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786428839; cv=none; b=AZN9nX1mndP7Dev1yUDNScY93h3TnbLwhmcAWT/U6xtINtfMEXW7cVLAEeUqi0kwVQcEYnRwlZAYTowrnak6D+COjWgsh13TUFVzr35/FvEM6XIjBaTlf8dJVTjJwXoWQbduFqOnhXPTf0roKNeh37/NtKvTDYE9nXABH8YKrEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786428839; c=relaxed/simple;
	bh=c3foOE5U7gQCrp1G7m9qgM3TBIAWQ5eDwz4P2Dih/g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6SpLiYZRQIPC0MaMwlwR0LTnp3Ic4LQHyAzqMsq+Xa3K3K4rvl+Bu8umlQmmCL5jyZ++sU3XO4PyWoOdHfx2nv3I4+J/qbgfV0848gYgbNrKo+38xuZoP50ilwbwyem18G8/tY7lddR3AKHebnjFHVDunoqtZitJ0Fm2GvQafQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iP8o+Yop; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP8o+Yop"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-39266382df6so2889822a91.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 23:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786428837; x=1787033637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c3foOE5U7gQCrp1G7m9qgM3TBIAWQ5eDwz4P2Dih/g4=;
        b=iP8o+Yop818uzsPS27/RhRyxSOv0X1dnwj6ByB9hucfM5iDM3z/fzk1e7slDicowvk
         LpDQ7o6bMrrfDa1X7Q5IrKCne/pIbYBDm1dThSsLwzkyiNcK/gSZfggDwg0gbRxoj0zS
         N5wAy6PiW4ldCzEFIfQkNMwg2k+RfuiRbPaDq29n+mwVe60nPp5JBh/YxlZgAiiIC5o9
         oxBeXPsrFkVwIkZiaz5qipaLoC3J1g/l1jS1xP5HPzs3vWUhA3zvKX3OitdQolj82lYH
         RHIGyDmazy96nETFd+8Us0YAB5bNNTxynKdXi2zc94YstUD2qgwDhCg0NrtZRf96XB0+
         KleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786428837; x=1787033637;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c3foOE5U7gQCrp1G7m9qgM3TBIAWQ5eDwz4P2Dih/g4=;
        b=MDiiAztE3HC2zSozV24lMzLRBemM2UaFIY/XNYpsgQeCACERUozWbYdqf2IzGz8Tp0
         kC/9gcAMKl9kU8E1C1r7vY9dL4ps3QH1xcIMtOeEUC8I4SN6lmhtpcOuUcnN6wBPxoJa
         v1mOOnEOO+0XFEGAliGGtlP8A2bOP2wdud/gNgGh0Bj3kzq9en/BXq4l9VKSD1Y+h9Fp
         JIH7I93FEBBvMBLWBoPWxuJTL++ohpm/XMbXo5XZmqnFFffTbFf2p5T5W3ACsQMYZ+GP
         h9gAALRoTdnbcrdWzqKjvGZzIC8izXBd3MTUzsPyTAlrdWjcmUREKXFg6XPAzFoUaCI9
         weAQ==
X-Forwarded-Encrypted: i=1; AHgh+RoW9mC8opSg7YNL+Di2fYmljVBtcxwt9g0C2L7xEoLt2cUGJuvM56crQJf/cPW0yYbHEoPAE2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YydwiMygmy9RV7mils2Mi3pYtgT0pDlg6qBIrCIVHmAoWeHYTIB
	ZPw92EVNyVQa66STKkgWBbO0bYU2Tjkhah92Ig+NMDMtCQvIZWQEfdoA
X-Gm-Gg: AR+sD13g/6O8F8KzlkHp5jFncZ4XGkPJPEfq6oAcJGAIMJRm2GuNZcLM5ARja5EXCbp
	GEYdjtMBi/RsloXWwnnTs8zBsQ/E/PysaQdvtjR7EFGvYdWibS0VUz+6InAWrp8S5cl9LlfezCj
	qn7wG5S99HX9svMEVLUHMvRB5uVOXbAxJntd2PsLJUQqwlcV1MooNpRlAB6LVQShaaVFZGtCTuU
	S6DoozeZ4C6lxbyS5vHDVHjC0wJeLYMA3JFItWPsMXuoBu74A4LglEZPPUWwSv3hDPJnGj63qrH
	SLDQibkxGYz5/POKm/ZEFuU+CBG3xSG1FAL6ZyXe6X442q3IaOQClwEOtJjo/gZyecLNPLaSBsX
	tqYqKu/qYX5hwUEGZGLFijH+8IEsXUlNoXeyvoWKGMzS/8adJbm+OotLwDPOGGsw/o/yXonuinY
	Fp9Gf74U+of8p2QSBQeO8HJyYg62gKCAdSbiL7SKWiTYv1CQgEXZKLUhxWaaz3NuBbtn0hlhVvB
	Y/N
X-Received: by 2002:a17:90b:3fc4:b0:37c:18e0:90dc with SMTP id 98e67ed59e1d1-392ec61ead5mr982380a91.16.1786428837401;
        Mon, 10 Aug 2026 23:13:57 -0700 (PDT)
Received: from user ([2405:201:c052:b00b:3ed5:c937:4281:eba4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31c64a275a7sm1316558eec.26.2026.08.10.23.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 23:13:56 -0700 (PDT)
Date: Tue, 11 Aug 2026 11:43:16 +0530
From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
To: andrew+netdev@lunn.ch
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] e100: prevent shift-out-of-bounds in
 e100_eeprom_load()
Message-ID: <anq9fNT_kTlx6ZX-@user>
References: <20260810083355.21631-1-pavankumaryalagada@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810083355.21631-1-pavankumaryalagada@gmail.com>

Hi Andrew,

I just wanted to bring this to your attention.

bug: [https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb]

I originally sent this patch on July 7, sent v2 yesterday based on the review feedback.

I noticed that another patch with the same change was posted yesterday, and v2 of that
patch has now been sent to net-next today.

Since my original patch predates that patch, could you please let me know which version
you would prefer to proceed with?

I'm happy to continue with my patch and address any further review comments if needed.

Thanks,
Pavan

