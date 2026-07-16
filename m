Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C573C141F
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 10:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197494; cv=none; b=QDIeTWNU7jE7gfPhgtY9o5scAnzEV9i7Ifk4O3wav5QdE7seWrO4BgDBmOuaXcI9JgIiDJwgjA0UHPq8LqJWFM/AmPZ/d6ba1m45f46YQRtG0GC0PRw0DZfMQXBJeGLePF2RSCzCXCJuW3xa1DhSlgw13WuNtr4e7B46+PmPHLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197494; c=relaxed/simple;
	bh=YQ2tL8/3Hf5qXAULGtO+Ag9ODHc16ddEpEO7Jjp5ZnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8CbfteV7BN0crqxACXdqRoj9ac+8H5QismcxM1T8/BdCEBhzWKrGZtcKCOnapO7Q54jzFbiBv8sHgQ4oxhh4VKGBMYL3pTqIDnvN+l4Iuzwpos689aG+O6F+lHbCRW9n26lEJsjmOe2PcbXk1Tfgs6eW/xqk7XhcOClBG0pvLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0SL0jeL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0SL0jeL"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba3e6so2539407a12.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 03:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784197492; x=1784802292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bJ+4p9deZ+LD4EAdCpLpzHGmysHFbTARhOqZpB3AIhw=;
        b=K0SL0jeLgVjcGWXcoK77/0ks5aHvU5ZH1acedaIsyF8WGG8sq602Or+RFkeP8JwULw
         CbSHMJUUINHj0d7Q+snequWFuNTqNGgqAqvVZWhr+VwuUYImsGrL8k9+jBGGoZToNDO1
         40Q0BjTO8GXZRlUQukdRMd+YT3VQ86U46/zGTgI7P0Wa6wigfwslg+qaJtn4qcLfQJ5m
         7I1hqFNfl3BhEiJx4h9nM4LR3N97uKvtvRw0/47FPpA3rzkiCn1+3VjgMokFRUlSIjsg
         rIlwJnM9VU/NYZ0vot0BlFrPZ9wMNArHWrP0SD0092F/TMPNBrkXLGoRtqG6bcLtkW8S
         USRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784197492; x=1784802292;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bJ+4p9deZ+LD4EAdCpLpzHGmysHFbTARhOqZpB3AIhw=;
        b=ikxB1K6kfK6s/qhy6JAjPBebP88K+GowGZPoW5R0evriIGI/K9tdQcrEffPapE4Sqt
         zjJngaIuOhpUdI1jr9F+veedz+4YUbhxpL/CgTUyuzobKcvrXjQqM60oPShAwoe2187Q
         Pt/li9qh2rrCXlqycB660ovEDH7WvNf8f2tPP8kOtEJ/lLrqskYHaRcNXpgZ+GJ/3D2s
         830lH47oG0k8d9QPjcHHMRv34ItvfliL/6riLK459Nh8cJwttP3FGZXE5wsNsoU6enA8
         mrb1NVrEsZqUmbwFt0Rj2/OpY8xDnDeK6DSq3yyBjz+ewmXjgVZuvIMqy82eHle6af2z
         k5Dg==
X-Forwarded-Encrypted: i=1; AHgh+Rr42PT64FYRwuB3xxxXv3gNans/x/Bo1qK7luHe2EKzqxqP5OBzMGJzxd62Y7OygGiqTxawZ84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ3X7r9PyChbgLUH6Z0/SMlhmGf41iP2MD4/qz3aBISUcLP9Ze
	8M6D2ffx/qmXJ23tdR5Ti10gDt9h8arsDWWh2B2NcquE8De6wy1z7fEZ
X-Gm-Gg: AfdE7clyA2Fbdm9CZ2Wd5c0Jk+cv6NmMNhMOMCBCvMsTrx5pm2vHMptTaL5zGmMbuak
	udohCUdWaspMp+/ni4BNTWVt684tFs9CARojTh0fi4Qj+Qy/4+sqskcbnNMv0Rgs1BRai0pIHSl
	qr3eXEe3+Y4MAqTSIYcqluvBTlrMZfgpas8XMYDnl3TNTZ9N5I3VL9+sbJJpLEabYJqUXoxDN50
	7jbPhJhGBM4QhG0riUA9VUmIpjqVlyykFQbVNoAFOXRHG36jYjr/2fWPYcLfgahg/ajSwXsEELi
	xnkwhNJYH5SFCbGISm5VWdRDt8zXFeTEeDrAgxp2KrPJnVO3LCGb/LX8oDjiCfhI0fai/P64D3v
	3jGIkcyjZ3qTCxhrDE7DFJ1QDxo/yhnhGioxn4TvrQ9CHNOTTcTBqmP0xVoQN2fCXtSAdxo39A2
	zoNyyfU8dAHTnoID6k5hlIbyIHtnqL7v+wKN+GPdDZVAMbvR2CaUBkby3d5tzqsRSzSw==
X-Received: by 2002:a05:6402:510e:b0:698:4992:77e7 with SMTP id 4fb4d7f45d1cf-69e198a6b52mr3660369a12.7.1784197491403;
        Thu, 16 Jul 2026 03:24:51 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd289ee36sm4359432a12.11.2026.07.16.03.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:24:50 -0700 (PDT)
Date: Thu, 16 Jul 2026 11:24:48 +0100
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v4 0/2] bpf, sockmap: handle spurious tcp_msg_wait_data()
 wakeup
Message-ID: <aliwTlOayzvvlN10@localhost.localdomain>
References: <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
 <20260715213538.37229-1-nnamdio@gmail.com>
 <95e690bf-2eed-469f-93ef-6ae3fb2a7162@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95e690bf-2eed-469f-93ef-6ae3fb2a7162@linux.dev>

On Thu, Jul 16, 2026 at 09:30:30AM +0800, Jiayuan Chen wrote:
> 
> Please do not send a patch by replying to an old thread.
> 
> ...
> 
> Please use a commit subject like "selftests/bpf: add selftest xxx" for the
> selftest patch.
> 

Sorry, I'll resubmit with these changes.
 
> 
> Please use existing test frameworks such as sockmap_basic.c or
> sockmap_strp.c.
> 

Just to clarify, do you mean I should add the new tests to one of these
existing files? Or that I should add a new file, but write the test in the
same way as sockmap_basic.c implements them?

Thanks! 
