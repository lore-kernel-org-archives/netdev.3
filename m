Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A01252CCE8
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767859; cv=none; b=BRYP/zSN+xbtXfaB66bnLrxvSI7ukpcy4hb+3FvflIJ5uj4N+6tfZQuU6LvLgP9LKZ1YDxMkA2FMpVdve7/cX2S0flPilmmY2NAJile2O6dQILTgeS+TtaKBA1fRvKy2XTvwvBgvFVMFYlMToMVlNvOqWV+dVwfymKis2LXUtoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767859; c=relaxed/simple;
	bh=xEBPhEeq9oIyw92up1JHuQVi5VVLp5xRLDKN4m/aAgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9M1lR1ImA9rRKGcdpLepbZ7Gk7RWG5t83KogbrV9nWkWfVu5jnlyv4OLzH4F3m/a3n+qQY/XZVvJlDNhlCuRWnmLVJtHHPNJ8cycL5nn6zsFbvzlDA6k7EdRcicYK4Yx0eZ01xxRz52/inPEq1A7pTRJTD+yCkb/C185YGcNYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tv5VxX0L; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv5VxX0L"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a990so1069080a91.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789767857; x=1790372657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UNkshWsS0F5Oz3aZceFRS+hvRFwv7fBDO+z9tG8T+Z8=;
        b=Tv5VxX0LwT50l0Z+Vdt1K2Ku72opxyzKCVPszVKkrYgU8LmmpoGWcXc/JKfhT07cGh
         +0i8kS4p9E+7392QScRngjButO1HwxnSimrxXn4eP28o6OCGYuFW4a1tb3QSVcXUgaYB
         NZMxot2HqM5wCduZFjjDSxtd55dYhTH9Zn2ZyPn+U06nYvgwAmsro7TlnL+mFaO4Qbl7
         6q8NDj+dnuYg8Sj7qzZnP7DJ/xZ3dJ7ozsF4OrLLHNQfYar85TyPwZmUKR1ManSNMoGP
         gl9wBOKfz0m8JaZUcDiy3VRRZelUXxIN65knOKP7mtAkkpqkMIpvkm61ZfmXVGGMogH6
         JsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789767857; x=1790372657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UNkshWsS0F5Oz3aZceFRS+hvRFwv7fBDO+z9tG8T+Z8=;
        b=oMW1hPdxjhG81EHc0hdnp4KMs8E5OiCewLmRZYGsqxa7ZSTLMX8KtEAR5iIeSYkcVM
         0ThwVNav/w+2HqdrdRU0ReAxGLmbvJt1VPUYNXgNh39ZXqT8Gd98yV4RwapTm1RPOI19
         3dqfLf4nHpVqRITlwNKgBLS/OhiDacqWkesRWn6wBxjnYdf0vCHlM4vLh5vXCkJLY8Qp
         ey8SbYw8hDArSZKvajp/1AV8Gxp4Wq8dZbAAvpw0poQNli4qs4GbbAQDvP95E97MrQNg
         dQwikg/fF0uvmcVZdDw4JYy70t/qluMUUvqpXZN+dS+LaYaCewVXWNwY3lt1pJLcasP5
         vZwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzm9/At00jV3K65CG9m9y77mrz0geOqrY+i98x3Nn0Ws4ZEhxu0Vv87tCZ8bLFYIwOdSVJGjdY=@vger.kernel.org
X-Gm-Message-State: AFuF++n90iyWz0vuY77M0csl4agD8uj8KB6LwPIBglujFkXlp4ArwrcB
	ma/RhqjfG7PbvGpEdWNGEJb/f03UztdXPMKfVklNk5TCVtvOYAHPD2eAKbTBrS42
X-Gm-Gg: AYBFou3b4mlbVMCZE0HOSHYn/nh3LrzeMou2yOX7Xl47bPFPDTGjGTveWLNwN08Ph0a
	EBTqZKMgWSCmjin54/d0tXW80R22MWc0KFJYNK4Ma89OnofO0OS2db/D0gzuzM7aMvy3gK/17Ui
	9adGu02uxaGqohONYgtu76JTG74WHWW+iMe0rBqnwdxv44aAUtR+NZFUz+EIYbWKhWfc5i3NPky
	65wrIt2YzpocriRIV604E2IoXHBbvpjgAH95CRdqYTKwGLjTgmMrlagnEHe1RmH0O5rO9H81GTX
	8mPzKi7T7EBo+Pv6T8c8bLIygfcCDOjZ6felY6exEwILjCQ6Pa/2O0KXj1duMlwBVuyVprJdcvs
	85i0WHOBfalwIAPNSs+ln3NTlldCRzOJviKdGZSIwaeMke5Z/Nap9MEgP0LHd2bJ3gSp4aOlWIs
	hl21Pa1/J4MK6bY5Qnj+ZEmTwnPV0E/Ch+pOBs6VqBbYygZXUo+ZhAI0NoOWVB9Jqk
X-Received: by 2002:a17:90b:390e:b0:39e:2e7c:d43c with SMTP id 98e67ed59e1d1-39e54b66b6cmr7243882a91.7.1789767857212;
        Fri, 18 Sep 2026 14:44:17 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c61e2a7sm1201398a91.16.2026.09.18.14.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 14:44:16 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: stephen@networkplumber.org
Cc: dsahern@kernel.org,
	netdev@vger.kernel.org,
	andrea.mayer@uniroma2.it,
	andrea@common-net.org
Subject: Re: [PATCH RFC iproute2-next v3 2/2] seg6: add support for the End.MAP behavior under seg6mobile encap
Date: Sat, 19 Sep 2026 06:44:04 +0900
Message-ID: <20260918214405.2881597-1-yuya.kusakabe@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917170154.2c8f50cf@phoenix.local>
References: <20260917-seg6-mobile-end-map-v3-0-7fd02b8b0577@gmail.com> <20260917-seg6-mobile-end-map-v3-2-7fd02b8b0577@gmail.com> <20260917170154.2c8f50cf@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Sep 2026 17:01:54 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Please make the three agree. Since End.MAP is meaningless without a
> mapped SID, I would keep the usage string as-is and follow seg6local's
> convention in the man page, which spells the parameter as part of the
> action description rather than as an optional token.
Will do in v4: the synopsis drops the "[ SEG6_MOBILE_PARAM ]" token,
which leaves the action list as the only place that names it.

> 	if (action == SEG6_MOBILE_ACTION_END_MAP && !mapped_sid_ok) {
> 		fprintf(stderr, "Missing mapped_sid for End.MAP\n");
> 		exit(-1);
> 	}
Will add it as written.

> iproute2-next takes uapi header syncs from accepted kernel commits, so
> this cannot be applied until the kernel patches land in net-next.
> Please cite the upstream commit id in 1/2's changelog when you repost.
Understood.  This stays an RFC until the kernel side is in net-next,
and the non-RFC repost will carry the commit id.

Thanks for the review.

Yuya
