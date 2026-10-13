Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0523A4F59
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881654; cv=none; b=tfbps120Oume8Kjed4xNTIQNYkLS7ppbDQzcdG6mVvgiC7AojsvUXfGMVGV1KR9b8Jh72+hP2u4dmffA7dfxtJY677CCV16lw1H4DaSMHvMRJc0SGe2vRoXSNE+Yzrx7WJO24hZLKX+yE1GXIycCHwgW9k/0AL1+oXIldql0Wfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881654; c=relaxed/simple;
	bh=9C8E/CwZ6TBFR1igCATRGDOo0vG9c2kE1cJ8ZRNiIs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdmuR6uNSuTe+ygb3kGT4hh3Be2bF9GrhLug/pzhVHkObN1cFnPLl+Eswf0+03YVmUmsiHvQ9OnAeNwxXI3EqRG/S+4LRCj0oxZaeHhZH5BA9No4hP+XIp4KDWIktxV1gxNb39LVgWS7oAypvQ4B/w0GMgbwOUhk1lqRquH3Bhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PA5Qtje7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PA5Qtje7"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so26574745e9.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 01:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791881651; x=1792486451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J4fx6vBB5Eaubq9v9yvh6B2v2niRs6BpEP+mNzzmCOU=;
        b=PA5Qtje7EuX8gF9kJ+pI0kuzEDNAZQgMfCmuYLDh3wh+BrimdYQz7Kd+ueEQwYODXW
         VXtV+eZS36RsZnhjcKSo4inYIWYQaN33MscjQ1n3vB728kNrKQGNMZPsnmeZ8R/dZ9Xj
         UahPTQbW9imBDLzn7BWF++iUyEYAYmU8HDqnZ5qwpWo0ak5JPMAZx1cp/OlT1b1NKcFm
         YSpgfZTHNKeGNtJasNdctxY6tUBmyfmL9knyRpIRmMhA/MGPZGj96B2Admlw4OcReRjw
         gkFfMk0j5RoTlrWvofmso+mKgxhJiuneqEw4a6x6MPugrJKlBl9GqJ3aodd8IS7EqQfY
         FIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881651; x=1792486451;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J4fx6vBB5Eaubq9v9yvh6B2v2niRs6BpEP+mNzzmCOU=;
        b=pS8vJeOklUTOaBIbd92wYLDGaj2Mugz22d6mWLvfUuAmEXTEDMxXWy2JZ9Nb27mBXm
         a4HAdYIIbQ1NArDDCPGDAG4u5tMlQpHZGiryCsnuXiqiauOO+fQ7PIdAVAT845JqPYpe
         iof/esdSA+46o6rosHLAPYf2easxWw7aaOIAiH3pro+JLHGjEDpKYlW+i4EslhJ/Y/OS
         arTN97bPtRisVithyJF5c6B8pE60CNyTEmtQZ/NVXK3mZ1skNe3Uma5fmxCQ1jhNy2U2
         kjZvesWj2FOwxK4WBslws9mc9o0KvX3SAG/gnZSjeCmODQrjprxOnPt4Ta0vvBtjuKSA
         cWsA==
X-Forwarded-Encrypted: i=1; AKwUvByTtFodeJ60CFuI+ZPjhdqcbDUEP8+XiilYxlB+nn++iuejncLxO4y5mmjZQkEy4RKR+G3YhZA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0uIhjp0R+lPb6uoGxj8WRIt0ltxkEHrPubCGT1QIxOA4CGWPE
	lW4N6dDQn2swoSHlrQIAb3owjAdGshvMDvgu1cf1+stwQPSFwaE2zQA5VpC8TrKhxz0=
X-Gm-Gg: AYBFou0qc4alnDtj+x2FlRXPfWZ2gCQhhOv62SVC6i26yrLtXVaJ2QqyJ+SFweYY1Tc
	3FXyyvHnC1rnBR9QWBhNdzB7D00YsrZTPZ2tyfgLs13KC+F1Ql9aECeI05COS6PqbB9vYcoQUV5
	4YUMp2spg4Qu1wtaeZNe680Mhosa7XJRe2fw7rMuTKmjLj4Q7RHhXNLmT2/NnWDb2Hjcm9zVHuz
	TUVhucK9aM9Z5a0X7+eGjkI8vsY/xbfTOIgtEv8+x52p9dxHVGmvyXGbiycDFrwlQP9/E0rstsN
	gNWVxCWbKsLlA1cP9VCq29Fz530LRUy9Yeuj23VmtENNvKZgMYA6sgaZYWXc+kUWvwhadjUmN1+
	UJUtlbjRJnteIyk+UkTOQWn9EAdh1+xbjWVhmQKh5qZvSJUmDZ0P+2T9T8jhrVFbBRq093VJeJd
	0Huea3kUejDtfg2VaQkqhcJo1xypcLZ+cFEIuOm2U75hu/fX2wA31BrLUgi5jpA44POORcmU/2o
	VqKBkFh7Hc6EUDd98oWt3sy448nePed7F0Eq1J3dYtCZ7B+LX4=
X-Received: by 2002:a05:600c:4685:b0:4a0:27eb:49b with SMTP id 5b1f17b1804b1-4a18e4ae6fcmr249070115e9.30.1791881650922;
        Tue, 13 Oct 2026 01:54:10 -0700 (PDT)
Received: from ?IPV6:2001:a61:13f5:2701:b3a3:b9f5:f3dd:ee85? ([2001:a61:13f5:2701:b3a3:b9f5:f3dd:ee85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bead84esm347856035e9.13.2026.10.13.01.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 01:54:10 -0700 (PDT)
Message-ID: <4d3a6c5c-7516-4bab-ac0a-3cf4d7a034a2@suse.com>
Date: Tue, 13 Oct 2026 10:54:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6] usbnet: fix smp_processor_id() use in preemptible
 context
To: Alan Stern <stern@rowland.harvard.edu>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?=C3=96mer_Mete_Kaya?=
 <omermetekaya0@gmail.com>, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 david.laight.linux@gmail.com,
 syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
References: <20261004215937.302247-1-omermetekaya0@gmail.com>
 <20261007200049.079aeb75@kernel.org>
 <7c4a2f1c-f16d-479b-a11f-cef962d5e2c7@rowland.harvard.edu>
 <20261008094338.301a75fa@kernel.org>
 <06a81ea1-b17d-40bd-82d9-922de946b86f@rowland.harvard.edu>
 <2026100910-petition-embattled-94cb@gregkh>
 <20261012194902.aEq58Q6b@linutronix.de>
 <8545800a-a37f-482a-9b06-cbdd70312b7a@rowland.harvard.edu>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <8545800a-a37f-482a-9b06-cbdd70312b7a@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.10.26 22:26, Alan Stern wrote:
  
> Today you fix VHCI, tomorrow some other virtual HCD will cause problems.
> 
> Should we document any requirements that all HCDs will have to follow
> and that all completion handlers can rely on?

Numerous corner cases. For example I strongly suspect that unloading
the driver for the HC will always complete URBs synchronously.
Please do not do this.

	Regards
		Oliver

