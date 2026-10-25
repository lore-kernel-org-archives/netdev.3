Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792967137;
	b=TMSQr6GFg0++e1E+N5qCvSKFVseXzA2V+RDG53sYmwKt/xGI7eoEEybcy/w4Y2yvdJBa
	 ia8NAfrDRby1qZUmQXRZJQDoFuh4PIGWunk5qF0D1tVDQ+lyIEI5VBv8dqteFDRBRXMuJ
	 UWngGEJIDpeZGyO2uPeTx8v4eUHunfRQfsg3ZQBVG5LWuDhecDVw0DRehgVLhu2cvk45q
	 MF+Y5YOjUHT2UedqGW91FNBKXpVmI3I63r5oGy6mAS8BI10a1ZLLAVqq4R6TAUT0vktbV
	 +7xkd9ynVU+03FC9gFiHYC6oXLfPCd37pvyidO8bfh15oXj7aqfx95//nT3IPbecqIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792967137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jxWNiiMZU2V+Vwzd05i/7abkd1YHSREMmJ+NAkrs9vw=;
	b=CVTblvsOgSf1r9xQZnpBhppuBC2wpIpEHYCLuvRWEI2ftSYbJReT9mGVlZ+vKRnobzO+
	 /4zzBd7uy23yXb0WrM1J1nNwxM3MKejxnFLhc8yWwgNpMA+RoCeHnNv11oLvuN6ivvfrx
	 r1un+n8KCvm9Glhubdyog7ms8ndS/9r2x5IreRWhHUCwFBTMhoXP0QGVbisuHtFcrKHtJ
	 cwfRLOkp6Luxlf9oqISqXCvimL33HrOFZBf6MYghBvttAB5OOANjOlvL0Wg79HAkHw3hs
	 uMa57f9kOBVI7IvHpcMEafXg+TvLNcGLXJi6sdPlMEIggvoUwuBWzIUpjatv4ThVjrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GMuiN648;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5756B606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 22:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5756B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GMuiN648
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e20edd106so2109298f8f.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 15:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792967136; x=1793571936; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jxWNiiMZU2V+Vwzd05i/7abkd1YHSREMmJ+NAkrs9vw=;
        b=GMuiN648OFl980xtHBvqjE1Y2JmTydPOMaJfxc6rcetGvFwivI34HQflhLukDqw/Xv
         xhmMhR2eWHdAb5I3Htu6JMb7gN5sVRodNkXL7OfieShBOW+dgDGbVO2ds+XlQmzXPbhR
         DW7j/hXd1YMWoD16y8U/yrzSQQuL/18MHp6HT3LdkX/b15nOwmfPLembVRlMMzo9469n
         9y1iyP97AQvt2QApD9YPGZ7bz0vxB8HFnTHDiMOdHaUNmmtWrjhByk45NnsUAfv8NqBg
         sEywqtlAj36W+t3Ba77kTHcY948opf8++LxyTCLlELnPKk11mK7RBHbpK5T+adAPgUS4
         g6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792967136; x=1793571936;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jxWNiiMZU2V+Vwzd05i/7abkd1YHSREMmJ+NAkrs9vw=;
        b=c+8x1yxrve+a+EHfjjVGVsm4xnLEUSl4Z2spzD6jTwZKFbPilKwqSQjk89DRyl6PDO
         KPU576FHfqSaLSj7A48s6VbZTGDr/VfcdQjiUVjOxfKD8ecaueuliEF6B/yHzXBGyukJ
         2IdDwUjR1cau3vulV2ELlslr+GO73yIVhZPQ+5F39gjurvtfikM4SBsDywV2bCCGrFDz
         wo8zxb7pDpE5tw3DkTly2p7kb70sGc8XXQSLq6QJ5p8YHjT0M3wBj06uzv9SU1scFSje
         fkqUbYQLIjz95nXzSYMmZhIJoG+j8CfEVepof3FIPiorF5mZ3/q5C/181LGvBWxTCI57
         vlPQ==
X-Forwarded-Encrypted: i=1; AKwUvByNwuLycM1SsD/IAWtRK3/9LbHCUZWoW96UC8paC0lwbAAhQyFsDVV/IG2G+oGoe3LRPYnjoxs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxxpIKlNpwpvk915OjKHrUbDB7oqwxHjVKscy/PYwehCL06awi
	xaT96+JdIep7/8C0ZCbJYYzKIhFVFtrNr3I9LliPe0Pi8OqPhG/Q1NE=
X-Gm-Gg: AYBFou1poUjUjRP3Fg2XBJSj1YhGU6xNOgK4dXFzYQjTjqQRs5o/v/957WRaZm45dU1
	6DXmdhkOVOE8LKuzehCemUxi+bEMY7105HDyL7vcfTVnoSNxVImDJnzs3LaTYSLCjP7r7KM4nQ9
	sQZT80XWawhdjboSnKeDiWDh61IH4RruNnnLgmKP70n3lOkO8DVpvIp+3NFlKto1ONEqiT0Hl6Z
	8qT2FYEH2YLmCH7Hi/D9D7OF8aUYvLm1I+mkBk7B+UgnnWZCmhF0ATA0X7OoIFedVGoH3nkk31H
	1W+vkN3MTmgHwnCj6rhY/tJOZdLZczrK1M3pW8aijp9Lr5/IFJwrbAtI7O95BB8qkPcrS4K9EW3
	Gle9JTgAXvuVJBAm16EyVsN590ZWOyGRhMa//3S+KeFMoUcFDeeLXM0238/DZvffPdKJshQB70w
	KESaJO5K2fvwmziLnccFC0l3+sG4MyA1qs82fk8+5USqVLb5EYT3irR41OPmX9bUPHNFm7haUhA
	0QBI3udWEoUHfYQFHNaJNiC1BnNnOblfHvthg==
X-Received: by 2002:a05:6000:2504:b0:48e:1421:ed49 with SMTP id ffacd0b85a97d-48e3eb75c9dmr9779933f8f.18.1792967135658;
        Sun, 25 Oct 2026 15:25:35 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e412cc164sm11555816f8f.7.2026.10.25.15.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 15:25:33 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: netdev-bot+sinfo@kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH ipsec] xfrm: fix output state cache TOCTOU in xfrm_state_find()
Date: Sun, 25 Oct 2026 22:25:32 +0000
Message-ID: <20261025222532.1080377-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179278530870.3327.6992676893660130130@kernel.org>
References: <179278530870.3327.6992676893660130130@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Found by manual code inspection while auditing TOCTOU patterns
in the xfrm output path.  The issue is theoretical -- found by
reading the source, not triggered in production.
