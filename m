Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648F63CEBB9
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150689; cv=none; b=lmLYd1IQ5U+92mSsgUHbFpYmwOU8U8enE2EMY8zRLVlb3cw1hglxk1im2HuyODvdwhAfdAC5w9/7n1ZILCd/127I/vxmxZmJDrV2T/ip2HAtWG2KGjxrAtQNxXxrz7rk3pTjrF+K2lu1C94h+bF05tChF1ruzhykUXJ39ZcvOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150689; c=relaxed/simple;
	bh=+tAmSHDxIwxbKvQ8HZao/GaONUaz5keVLiNMuB7KKDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpVBJmsuJ/MVaGPAYBDT89FWnq9VNlR5DImy+edZsNDe0dlowFIs9d71Y+f8Zsd8+y91koxnNVvSgOap72fcG3izf5tJMvtuAeqpU/0GXGbLpQXbw5SP0X+/YLSlskOPpd6tKX2TLCzym+XE7CCojxOBw/AX895A8hgaeVXgmp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnQodNdQ; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnQodNdQ"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so422414a12.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790150688; x=1790755488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+tAmSHDxIwxbKvQ8HZao/GaONUaz5keVLiNMuB7KKDg=;
        b=QnQodNdQ94HsHcQOsJpsWD1fUob8UctRNaFYFrws8xbDXohtxyZxEgQq9nbeAhP/Sv
         4I0FH2LZkVxVukgByvT4K9E/t2Gh+6GzVvC9xsBKJex9M6tlzQ+81Eg2Wj8gB0veDvdF
         SXF1RqHoGpleCt50Ek3gm8SISImu9Aa1TfKIRIK2t7kmJ/r5q8tZpdX+FJPXS3esJF/z
         ZivIU534NiNuPXwhAUM/m1uGvjY+MVyUPPR1QDGjtqCwAqHuStvyHea7SsJPOrndxST3
         XzTJX6UShmxtqO1jGNuDQXYjVEnsYBVurSnytzaqp85msnjmQrcMzs509ZbqyI2tWGRj
         XSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790150688; x=1790755488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+tAmSHDxIwxbKvQ8HZao/GaONUaz5keVLiNMuB7KKDg=;
        b=dxCDXCzOcoa0aublENRx3hci7vlJZWxaG22jvDKXHpBVtaqCyrHPeHpcM1wpEE1MM6
         vj9WtE7yFZvtqtwgT14SitfjQ9WPpOUZ/LTlVkDS3X5T80kymHoL+1XpCfLeYp3YX3za
         OU61JeTHzvpdye5K0uEgceIzNktWklYDKGlTOAhGJOmC+sAP79Pv8ThtU3N7vT5oCPcX
         HORK5A941NOv5N3h2S97k2jnthkEVEa2UCwLJuyOhOiiBK2bV0L8fjwDTU0sUEAWsdqq
         QWEOKq7UMegdLtduiZCnDOhSAURbM/OQ9wcM32rmgJbUEFzYWeMpkoeiE/kIDvRiUJbn
         pHJg==
X-Forwarded-Encrypted: i=1; AKwUvBxC6gh+kKaC9+BdFMzxEdonptOK18+VIRIie+oNWe7o6o+FRQGJxeNHh3MzlfIOqkiXhSIAZ84=@vger.kernel.org
X-Gm-Message-State: AFuF++n1ZhUKj2R8mIHIGT+bK4D6f+b2xRt7sDN3upeSNJ2ScLFTWdgQ
	CY0yjDsGEqlGn4H7m/dP8Eoo9MFN4fDawsX4R5e02L37xU6ieeszDLuh
X-Gm-Gg: AYBFou18/spfnH0MZukLRpu3ghC8G23mBYGiErm5MDvbPzMlyS/hwUc1YZmVjjqZv3W
	Hk1aMo90kFxnc0YAPOLvyxR6y8RxZRFlmjcRHwBg6ODpyVzETDaTFf3MrVBaKtNabSZ3pyybzp6
	Yw8sQaBXKLIuP9ZfGJcuaqDPrSLnu4PHMBYSrLjxvouFI8XOsM13PnrbKmsxcCHYNxEcs/f6Wo6
	+yHgLZYin6b/pfGE0EIbcNpzEwV0M5czCBqtMtD1nxDRovvD3zDrfXDkdyY1logN3OWFXKw2wxr
	oRR36mCxFW8cZYXQWL+VDdpbQUqhsOhEjYceGGIHONvIDyCbcudIsXclS+vA6klrLMCoEpHdPxO
	Q7kprTtOxJv9qocGTsikuk90W82etfg1mRmfXOJULLbj/r+w9Muu8FkpFNI6h9Gqmdhmn2BRTy2
	7i/jXM6Dsb226T9EMm3dmgPDFOjyo2jI6TYYRe2LrjXiEOH3HqXmlUlwEck6qaVnOdNA75ksdQh
	cExx1IGW+q6iSkzEIkgv7MZ0p/0KJ7KSFos20hswiEDXZ8=
X-Received: by 2002:a17:90a:f947:b0:39e:6a80:dd9b with SMTP id 98e67ed59e1d1-3a07e6141e9mr1464275a91.34.1790150687493;
        Wed, 23 Sep 2026 01:04:47 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a085b5694dsm1984730a91.6.2026.09.23.01.04.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 01:04:47 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: David Lee <david.lee@trailofbits.com>
Cc: Jun Yang <juny24602@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Kyle Zeng <kylebot@openai.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Dominik Czarnota <dominik.czarnota@trailofbits.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] sctp: hold shkey across socket migration
Date: Wed, 23 Sep 2026 16:04:38 +0800
Message-ID: <20260923080440.83800-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731120558.558957-1-david.lee@trailofbits.com>
References: <20260731120558.558957-1-david.lee@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David and Xin,

My control-chunk migration fix [1] depends on this patch. Xin asked me
to wait for it to land so the dependent patch would apply.

Xin, would it be acceptable to send a v3 series carrying this patch as
1/2, without code changes, and my fix as 2/2? I would preserve David's
authorship, fix the tag placement noted in your review, and add my
sign-off.

David, could you provide the missing Signed-off-by requested in the
earlier review?

Thanks,
Jun

[1] https://lore.kernel.org/netdev/20260804113705.45754-1-juny24602@gmail.com/
