Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D193F0A85
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563142; cv=none; b=Gl9Mg+DkMvMPeN6uI0OLFcROKmmpzEcza/lNd2FRZ+3MluPPk75+2LpMMWQ662s20ifZ0b9pcktIShHQyeVF6VSOwn8hhXTeywuTKYP/2KuGIMb+Em8ctD+BqqPNQf2IIGlXuKHASeQZVhFUOfaWnnpaQWVt6hK986cJGlEwqf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563142; c=relaxed/simple;
	bh=4yPRMcPsx71HPb/WSobG7rjnIFEp+DLv4lz78CpE0J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpylkgvbJvMcxRGUeqi/NqEsLstlukSd6/KdiZXmxNR0hAUfjaRJQIqlrtwkl4oRfhd3oaF7AEvkWwhh+fmGCdCZIo3JCkYq/VDBPfy8N1pU8D12+8+JEK8o5TnLUeS0gwhhddvIcSm9I5+AJZWgrrsRQ58LSYTN+lBF4m3VG9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luNddjSF; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luNddjSF"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc11a905ba5so2226380a12.2
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 02:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787563132; x=1788167932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4yPRMcPsx71HPb/WSobG7rjnIFEp+DLv4lz78CpE0J8=;
        b=luNddjSFo1sRkfJy94/T3E/UnkTqmreA1JnrMakDBaG130NiHbLA0Rkv44j5Pe5IlB
         Mz6uY+r51RUaRGF2xgqcWTUseVivoiiFLaqwRMpk1ox5JSoJ13v6LaKhh+tqOgjbVacc
         t8hhQc1n5rvL7gnd/rc974LiMERluJs8MfugLDtrSzCqBIviruquCHv9KI57ryA7LZ2Q
         pjjojSjenhPdrWKza3BJ/v0N0AL1uPBL4YG5Bn8rWoKwIw8vHzDtCrAyskjPcCx+jhU8
         kuH9r26KCLRSXRajrGWE5Wp+64MwyEx8MotHkglp+JlHwTM2+WsVOYr3DMTb+OdGS2sx
         6FUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563132; x=1788167932;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4yPRMcPsx71HPb/WSobG7rjnIFEp+DLv4lz78CpE0J8=;
        b=KIZNNgfhpZ9TaAsea7W/vdVXLFib1ohkN0ZIee6UgK2m23FX5Kihhsj/R2i4kxIgmx
         dDtgmhyK5pDAXSizyRlqyDg++gW9raJAa6P70IIIBdeeZW2LCeLW3Zwy7xqHfHfBBBf4
         94QJE5ObCGL1Md1A76k4tnrmX+HRRxzvg2ZmrcM6rUlUuwJ5XdO3cUV/XVpEdhqknbZS
         dRwy85aiH9KMn19xuiwCtBZA7zjSF6+9U/0NA00u9Gz+v4CTwO0Ka0N3aZfvghUdH8H4
         YglRl/QnRzwwjrJQm3ci5d8TLoU7aE6saIFBNvy5RIuYaz5xpQXZyTOfN1Plg/Icr1om
         yuxw==
X-Forwarded-Encrypted: i=1; AHgh+RopQdEb8GvczpZJMcHm5NaRZ1eiNgOeP6NlFk3QqPfW3xJR0xOV+wdycRZYuB5aNIKw3w7cY+Y=@vger.kernel.org
X-Gm-Message-State: AFuF++mOCasbKKZKdXvtgFMj/E3XyrD40O56Te/xjQdI7Vy8MERN+Vhs
	v9xg1bTBM70j4XGOy4dzf2H1GthoWveqyHsio7h4NJYIUE+/fjyrevsB
X-Gm-Gg: AR+sD134KyDBmiJfQgoozyZdKN4SjkFWTu3QSNqh++NRA/jVkKULhEyJ1PVmCDsUgtz
	tTv2WYOb3d5jznZGcG2SdCJ5wgxQe6hkRXHDrG2wlkm5A28HCwuH3SUw9mTAh2TLnMQC8QFaTRr
	84qBOmnl58/rpFj7btBw/RqdM4u7NBe2+eJwpRIa47IsKr22ksmX3Z4mVI0i7KkhwELMHvwKJgN
	PDYSeZOJ3O1YO0Iyi9VBxknBDrg0eQv5F4RhYNNaryObRNhiW5WKxqp3qSMU+8QUpR3M/vqSgI2
	xRNx+YPEJQixWT7/KuP7wft38YFLaQ/4Qo+9BWgleXpBuDZ4l/5cv2a9D/TOKOMauvyX0zuuRpg
	HEMLE8791ulrog3NhxIVZdbxRg9+TtqmVhqhf7Aw60bv6jCniiqLCD68OxE/j1ReAecwNNBIsK2
	h/bfg3f+UxRAu/sr2Zj0ymnXnDlNKHJogxGL4/2hxIwYAdwgqllo0jmxFmcn1BMcu7ow==
X-Received: by 2002:a17:90b:268e:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-395c3a4f35fmr47590357a91.14.1787563131588;
        Mon, 24 Aug 2026 02:18:51 -0700 (PDT)
Received: from user ([2405:201:c052:b00b:4590:7268:2737:3d1e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d381csm27040421eec.19.2026.08.24.02.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 02:18:50 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:48:19 +0530
From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com,
	kohei@enjuk.jp, aleksandr.loktionov@intel.com
Subject: Re: [PATCH iwl-next v4] e100: prevent shift-out-of-bounds in EEPROM
 access
Message-ID: <aowMW7qukxDgMhWc@user>
References: <20260820094045.41400-1-pavankumaryalagada@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820094045.41400-1-pavankumaryalagada@gmail.com>

Hi Tony,

I send this patch as single standalone patch with all the changes from the previous
versions and targeted it to iwl-next as requested.

Could you please take a look when you get a chance and let me know if any further
changes are needed?

Thanks,
Pavan
