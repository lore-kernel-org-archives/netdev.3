Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794624989;
	b=ChqSOmQQI3Hcffbtxokj3Rqbwxz2VCyY4lPO/uuI4poNjxp8eSLCPCbZTdrLEK0P48nl
	 sqY8Kw4qRAaNqgyPUDIXsOwkebFw89lLQRKVbAU4DIs1LBRXK7uHIMAYKDlNF2Br4ynjn
	 GeXiRRv6Nu5INM3NoBhQbsUZ9ju8u9EO5A1wIXpYZOvJHEH2Eid9SN8H+AP4Jh5NQQm65
	 w5lJg0Fgvm1fONzXHp2iWz0XVlDaE/lS4drxGL3KUt9qHSXPKq1y+TrrhQ7ZmrZjIOl4V
	 xsKPU4/69DrRBUhtowYwuEaOyZYplj1ATibFr2kPoA5VyhVTMcrTFZWQM+QFB2/UOQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794624989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=DXaSN0Fr6JcTZ0oBKaOBneCo8B26Hy879oIpVgJVCjY=;
	b=S4zQ1AHwPiZSZAoBkS+9xMcbKwWkFqhOFwy2qrXRrZjC+zha0hhlBVjta8gxiXYN08B1
	 J2mgOsy7MyKqaArneOwxerbsW4P49OiZq7eQkxWOagZ7uFAV4eAbl0Db4lJcFaYCmGrOi
	 jc/y+MKcVwsCXAAhUg1UTDeiajJYFKr2jpcOoz0Qu8gfeonKMHosuqWNOL1D9oVH7ND/C
	 VXVQvdpCQ0APz0o5nrvNPD1yGKeZQoGszDhLkHaEZnXZU7KqVd5DhRVvJLAuZycVxsEVI
	 NH/R7CzM4ZLz3BOnwyJIHLkUmDv+2+9EvDL7cA7rOmJeIa2DfiIhIkdH0Ozi7QQPT/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F271ZPsA;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B097606A327
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 02:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B097606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F271ZPsA
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ed2b4348fcso5822165ad.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794624988; x=1795229788; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DXaSN0Fr6JcTZ0oBKaOBneCo8B26Hy879oIpVgJVCjY=;
        b=F271ZPsASE2nn0cBwU2z3nrOqmEB7IsBi7VUB1XP8xsVs1T36Rk8uScTq9dzju/j/E
         YXOtKWlbcHaZNdCd0BfMqsL/3tjLyk4lBaT2dw88DFSDjqCLFo1dk12pvlC/rjzGJUxG
         YplTHJLUdUz2B+IRhFYAQG/ZFMPd4Zn50chZwuC1XSdivJus957D1HaVsTA9VnCHGa+a
         g1T4FbYIxG6Pd3ZXDO6162e95icEmczP6ScbJInpHqDxrBg3L9Npabsy6YF2r47EzQpi
         q/vhw2hSaAojeqc4ikfTVrF/WnvMFHXgrxB/f3rlSbbiJGyX1N1VChVS8GeqMMwwbvR9
         +csQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794624988; x=1795229788;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DXaSN0Fr6JcTZ0oBKaOBneCo8B26Hy879oIpVgJVCjY=;
        b=FoL3To3uS+BscjnGyUmlxnNDJlaDYYrRa9TJBglyLNYda9zAL6snWpLdMXJ3bYzXbt
         mkwDjf9OhjrqDAzi06ZslXpOysJ4MlRfeABOEcQD73GsrtXQ/B5bM3TofsN/W02DCgxv
         08iCVmOtd/xMqUl4d009EnypIionwonnm0g2qkakBCie9BuTuZjtU+aYpsd8UcC+NKOi
         T96B8dJTRwWwTxypOF9sYdPhSwruuOYEJ7ziVXDKLTZrhjcHTxEuFYi+fpQew6Z4qv/K
         YLGOGGr01jfK//mVSEvNhXxPgE12CrqRxF1afz3VlHDDGW1vtrBk4d4xxW6FdcqgA4QZ
         /RIQ==
X-Forwarded-Encrypted: i=1; AL+hErGzn08tm1qYvvLT/Ri+WxB4yPpM4v5TI/BHKC7WDZvVSnO3jolXohQlBR0cMDFcMgHQSHRshhk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ytOlKCmM7TXNQVjUM+xkpsbMOWzsmgTimUBE6U+DEpSXgRGt/
	O19w2XURgJ/ArCQ4MAFfDOgWPmz6UYg22ebJ2Qo06sK4QLkBVd80bz/q
X-Gm-Gg: AYBFou2ewSN9L0GrkwRxreM8APQ6z6JL/IAGdSthXoj61HChcn7L7xbXcicFpSjLHj5
	HqudSjOFk3rUDM8CGlAGJdCoTb85L2HXhWyGszp4I+IhToI0CSo9kTdcO4xYyH8M8Okhcu3Ki7Y
	xDo0QyeO0vHDxYtXPFPhBY5noDgA6ExjEv8Drvl3AXYB+2DZyCeXH30nPfdVcP5R5Wvm2fEPUdJ
	raqRQUyEJUGGCXh7VPuo2fTvfQZeeOVqt2n2/qTb1rn2RfmlShkm0z+Mv6tOtEfA1iuueqYlltE
	9Jl0QBN8qyhYnKiuRPlJF3scu1NLXTdZ+q0AqUNylLxiKmWkGKQJ4FFQv37UevHbbpk7OCgP5aG
	j/18SSRJIw/VPJ+hnDE5QeHUSzMvq/DsX8ElF3GpJ+0T35gUxGu9BtP+/KiPEKz5I6f++7tCUIx
	kyCz5k3WB75iw2nJb4W3Vd52BO3UERiYwXqE5UuuzKsZKexmqZgtsefrWUktJP1gB50SAHpN4Uk
	Uyz5c6qbHp73dmOwdKaq4m2OhVKwecOl7+/k44A93P4JtHsu134HKlcd6R2LJYA7i3xmv4EzM/F
	gJ/5YIMA9uL1Q+Y3nrtbiO0zHpOI+tIY1TpzvlTRO5Zi2yz1p1NG6yQZVvSjW77zC0j260wuRzZ
	7R4Tb+UNABEfin9urU47iRhJv6Z9RZDvwuGXCBj9a68MGp9wXQV1PkqA=
X-Received: by 2002:a17:90a:c784:b0:3ac:8af9:4a77 with SMTP id 98e67ed59e1d1-3b1b0a0e859mr3188105a91.10.1794624988299;
        Fri, 13 Nov 2026 18:56:28 -0800 (PST)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b25ebf34sm2758293a91.1.2026.11.13.18.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 18:56:27 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 02:56:26 +0000
Message-Id: <DMULGPH2RSTQ.19OTSZVNUXME4@gmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: mask speculative out-of-bounds skb helper
 loads
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Daniel Trujillo" <datrujillo@nvidia.com>,
 =?utf-8?q?Dani=C3=ABl_Trujillo_via_B4_Relay?=
 <devnull+datrujillo.nvidia.com@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>
In-Reply-To: <PH7PR12MB879437C51235E3A3094EBCB9B27E2@PH7PR12MB8794.namprd12.prod.outlook.com>
References: <20261113-cbpf-ind-nospec-v1-bpf-v1-1-764ac4c14573@nvidia.com> <DMUHIJ5FC8EA.2XFM7TJ6AH0YB@gmail.com> <PH7PR12MB879437C51235E3A3094EBCB9B27E2@PH7PR12MB8794.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 13, 2026 at 06:50 PM Daniel Trujillo <datrujillo@nvidia.com> wrote:
> With the instrumentation described in the commit message, the
> reproducer recovered the target bytes on the unpatched kernel. The same
> reproducer did not recover them on the patched kernel.

That instrumentation is a CLFLUSH added to the kernel in front of
the branch. Nobody runs such a kernel.
So it is theoretical.

Sorry, still wont-fix.
