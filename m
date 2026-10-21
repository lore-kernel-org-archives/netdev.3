Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584057;
	b=AuTSUbfZgUvSS5YxFZJBL/sYViXwYHbXN6I7wsnz/5l907VSislT58GCkVXjAWDUDoK5
	 EANSUlJo2HVZGhkp99WKf7pXWYWthxt+nwDO+yBFx/2NN6zBT9Dy7b0X/XnFaf//ZTFqm
	 th1wXQq8NyVfTfuE2VIt6W2L94i1I/+M58unIHuncKltdNIGP/GNfapgD4A19XOBfGPH/
	 7PfUvVlOnUYRoFFSabaJR8ngwcq2edajBzOZnruF4cmqICUTjUt45ScJe9GPqTj/3bXpH
	 FTyHK6HnNXyRDe09Iz3tTNI5Rndtb+MU6H0STWuFpyAWot0HwA4r4VSBpGk1T5ALuNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sFIge3pvKg5tOjs6OafupZRnQ+taR/KXdTgP36TD1t4=;
	b=xslo85UyxHxipMfnVIQ84A/PpnZl/DhFr1bcFIEQB7qcKE5VYcBdHlD3jJe66holS2Ci
	 9QtZXQkXbEAK/cj02+/d2Q+uvKxMNsR5VpOKP8HA/JGWvBQVItniymk/74QMt8Z2R4wY6
	 dKGW4EfjzrGA8Rtktuv+LSvl8isHcuBayUXpC3tPfJLPJSjwwMTn4GxM5/TPnqPYpsJdK
	 2AELWRFgnBESyR+/J2dfzdmQoC0N3mZIQxIPi0w2Zi2TsqqdmlxY05c3ejl/61efVaGqU
	 3ZtqKKyAgay+2H9pUzLW1QaKECtAO6/dOLeuhiViw1LYsswulLBOys6D24o0gm+p8dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F83F606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 12:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F83F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1f31c63ebso2678588a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 05:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792584050; x=1793188850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sFIge3pvKg5tOjs6OafupZRnQ+taR/KXdTgP36TD1t4=;
        b=Ni2/mLP+iAbSaf4FkE0ykYCMgbK4kPCN3VwLapCetbM0FY4KPtNdrXAv0QBhxAjyTv
         eNe6hU27/TyIXRfsw/ss4WFt3dDVOjkRDCtSFdlN+R5afJ3dM3/4xB0X0j3HWgl20ycj
         ItkCVQiA6v3VKJQicOuLEHARAzySVcUqkSwhpb1DarNH6IQvLr1VyfFmGvEAeHitjBlh
         ML8V2LgdeGHe3ijOkOnj0F5q6KXwaNYlr6XYm/x9a5j1xZ7mclaNSGIdL8yucf8nZdzZ
         mwCqbEwvHn8GtuEyksudk4epRCTZVPyofMmw5olW6dYr96qluPMntNljDL7v7bdT5rDb
         kSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792584050; x=1793188850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sFIge3pvKg5tOjs6OafupZRnQ+taR/KXdTgP36TD1t4=;
        b=huGGhAMyHFBFkX+kPkOUOtpnkcJ42O/7y5ya58B0Jxht9vV+poa39yOq2jjmr9jzzS
         AZBbdWWXimUpZvb/DAjSKFCsXpjoceWOABu2LMEtp1dfTbftH1hs69tgjUB2mZNqO3MM
         T4aRbH4e9pen/sIllPJbOE27xlmbajmEYQ4Q6nGMsfgiSKiDc47CX3uoQEtNWeAFEPbF
         KoaUW+Yn90HURepzu/pi+DkGwMnPPbmQAiL2oyqvRqjWnFtu7NbcAI1YcSwLz+kAKkDn
         1IghyvoMmBy0SI5voVx+gaaFk5ZIOTIpIved79hgz2efUz6YvKwwIpf0bd0zYN0URcbz
         APMA==
X-Forwarded-Encrypted: i=1; AKwUvBytIeGu1376VGEYFGPwxHH8HQeOIieO4YK7guGsfZRLnx8+fVJ9pbbjg55xF6QnGM8/ZPBk9HA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJV1GhYDZxDdflATEc/1ScaKqpV08LN62TxHKiZWYKh86TPONv/
	D4ZyHo9dGu5l0vEkK+hJ2KIhhvbrY1SqDOjADMsxonpU7w/1/OlVg9C2
X-Gm-Gg: AYBFou3TmRVMNTet7wDlOQR6g1Up2OB9HxpGp1qyVRDK7z2OjGIASwPCyG3fxATyy5u
	z43kDfqJA6ATu4/84KUOmIdhsjG6aTxBksMiiR4CwEU9jplHfQuoo0yWNOF/SWLF71aY6zFNuFz
	MWW/wUY4R7KwlEeNmtnk7w4XBVkDKONCd1WlmswOqSMy47I++yYQS6G5AlxJY3UPPXnS8dWkvU3
	0TQkqGaFzfkLl5i5MuqNJ+i2927/detrmLGyE/5Yh+EJZIKIq5xMYADM6Lvgr/vu75ceF0xt2G2
	HasP1BLc2ja2Udzfd6Xwj3usW95f8NvFJPftb5ksvtlWVsTu7q9W86/3X3EtJOEBD3wVDLrV1v1
	9udIGGOY2dGI4bREZSuJf8LPh0I+BkB1MyAzpXkllWqL1SZ/LWY2NOgii5uUPvieUFuYJJLsvs6
	eYAfoLtIpCWfpQPvevvOg7UVx02KjK64KQPMJE4OsIdI0xnwAEiONXQbwFAjZvSB38zGtqI8oXu
	WeyEZA/4bQhkyZuB0puZ2Z90KpJRrJ2nxhzYUdGQ1JOvnHdRg==
X-Received: by 2002:a17:907:9490:b0:c42:6632:a369 with SMTP id a640c23a62f3a-c46799b30a6mr165818266b.21.1792584049857;
        Wed, 21 Oct 2026 05:00:49 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:48::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4678fda057sm68875966b.58.2026.10.21.05.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:00:49 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: Boqun Feng <boqun@kernel.org>,
	netdev@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Davide Caratti <dcaratti@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net/sched: don't wait for RCU when destroying qdisc lockdep keys
Date: Wed, 21 Oct 2026 05:00:46 -0700
Message-ID: <20261021120046.3279601-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <atehw5Cn5Ev7Z68i@tardis.local>
References: <atehw5Cn5Ev7Z68i@tardis.local>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Oct 20, 2026 at 10:15:47AM -0700, Boqun Feng wrote:
> Sounds like a solid plan to me. You can make it behind
> CONFIG_LOCKDEP_DEBUG.

Done, under CONFIG_DEBUG_LOCKDEP, as a fallback.

> But this means lockdep needs to do its own allocation for the hash
> nodes? Where does the memory come from, a slab or something? If so, I
> think we should probably avoid that. But I like this idea more since it
> won't introduce another API. So please do explore this idea as well,
> thank you!

No slab. The nodes live in a static array with an in-use bitmap, like
lockdep's classes, list entries and chains, sized by a new
CONFIG_LOCKDEP_DYNAMIC_KEYS_BITS. Unregistering hands the node to the
existing delayed_free machinery, so a slot is only reused after a grace
period, and lockdep_unregister_key() no longer waits at all.
is_dynamic_key() only compares key addresses stored in lockdep's own
memory. I posted it as an RFC against tip/locking/core:

https://lore.kernel.org/all/20261021115621.3194947-1-vlad.wing@gmail.com/

With that, this series is not needed. Given Jakub's note it is on hold
anyway; I will only come back to it if the RFC approach does not work
out.

Thanks,
Vlad
