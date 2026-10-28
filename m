Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199388;
	b=VQIjzu2O0Gm3YPFaBLX4eXloPNpEiHSisKYR6AQC23A1LPHbP7hyQZZ/qS+bWvgiodV9
	 +b7uvo3igrR36ItEA08Ak7hDU4Ub0HwyZAPNm5JPjKuhJHfpQOipig1uGJk7kEKp8xhN+
	 0Q4wqmP1TasFbAr4xII6WPMrPubtGg8UK4rsqsUVl0qADBIk8ErhpvtYmNL8FVPXKI6Na
	 O/NE2SJVajyfkzFIPVpve06JLerthOqynGsFvnny6kK+MdBGHi2IUFB9jsehuNvkZL+xR
	 9jWa9wFHR2ecDqtHnTwgEsHxlU3PdraaAiZcGiKIJtMLLcnj0OxoyAbbxXrg0crfK9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dMqTaIY27cXKarwOSTeFtEgtD+KmZSEaqSxsz/rGNT8=;
	b=j76Es5RgQBL/dt7eJKNAvliQdcytBuLJORUSuhlAzrZnYYvJAK2BfvYdt1yRjcZKsJE5
	 wCu54I5xM0U8pZj2CK3hL2ed0eauMzF3yYAzpEBPI1GTIHtWINF1iQCl5/oyt2iY3KI5U
	 SSugE75Zs+0vDvTcaY5/iSPQCeRmLRZPo8Bdht+NuiV8ffIJqzWtccV/Dstn4LejlWLrf
	 iKslcyuLdnva8TgB+/pG8trfMDNePzaWeWMarOKnpWiWXOBmuPs9ZF/bb3BAsLuGlCrGZ
	 GVgZsa6OqPE611wbesTYH/5MqE0MPrC7hQrFUSAhQdBLHgbKN++Zt9kS4DcRdzSvMhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CNZ+dvze;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63098606A31C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63098606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CNZ+dvze
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c4be28b82so953720f8f.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793199387; x=1793804187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dMqTaIY27cXKarwOSTeFtEgtD+KmZSEaqSxsz/rGNT8=;
        b=CNZ+dvzez8BAbePXIQWx8T/xYyyDCq3mBeNeeCpihiw90SpkFvxZ61/tO+Uyct1Y+h
         WWJuMD2xAhCt76nrRt2KSD++hKe4d5gvvmqyYU0w0AkZXNliRqjoxpvLvS01NwotY+/Q
         2XxioErHRwcwZT/dxzAQQgKtITJMAxYGRp7v6zX9jfbjs3wYdDBtxGc4szd09UIOFk6L
         ZW9KfdnfnfZ7+RoP/wbr4Yaxiyq6/8Iu7APPaiJMkkUrHYdN5ipHoWyipl40S6FE9F+j
         9Jehthrmgm2fc3jRVWffvKKsBqWn1przVNdNqdludUMR7P8yv20GnSm0l5Dlu4GWxzmr
         dT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793199387; x=1793804187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dMqTaIY27cXKarwOSTeFtEgtD+KmZSEaqSxsz/rGNT8=;
        b=RJfPmxEiziP1lKk4zp2bHYx309jCv9H59IEysfhpSr6/ygvWYTS/9pHZhTmpaEh0Fi
         E4IS2+OciOJbumXxgYZFcjX0C1ecD4gH/4PT3b01wc2TT9ZlwBv241NS0frb3o51jzJV
         67KzbwYK08XX5pAuPLytclrzfSd9p8h3k74tQFkscJoOOGJecLl1UtQlCMFbDA29X9dm
         XYSY/VQ8UQwRagGvobkkV0/6WrEG0ax3HvBP+CmR51DuwpedoD7Q4QI3D+1OIEa0j9f5
         1AZVjM1ZFXyL7KB1CWy7zDdAhiN3GDc0Jmh0B7L9MGVMwT3kXXcVnqPwdbmH0i/S9jmu
         5gqg==
X-Forwarded-Encrypted: i=1; AKwUvBwUUm9yxzRquU/DIC15x/8fJRup5FXuKIm/uI76HIxo+oJ7S78awGs74jxfk6t5/9MXz9AGxm8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpWao2u2Sx53WTU3aeJoT24J3mT7NI5QGKmJzcrE6QtZXrJMiy
	MqxRsav1JUfcZyTO7Bec56+ZO0/Cf4gwSDeYPAEr8KAJ/+ItK+TaGWQ9
X-Gm-Gg: AYBFou0Khw3zY+QC6wNq3QAXGgwwIdsJCF3IfGk34B2IgfiHBsP95gaKsly1KwO/sSh
	lrubNSyqBU3KQVoCdK85vRKIlHiHzzjwTzTEXqHr4kmU7tBIJUFTCQV+NIkbBQJsa5SC3r3V0h2
	jr/w+VCIAwGRvyZICqW8qLUS1P5cBygRPsqO5b37Ex3UKqFoEoDCpPa/mEkSeyJGbVAK+5WEz4O
	os7qZ2YxNS+WoZt0PCHZBWdTHygwHbQyOTi2bNjMADAmgRnGFk9BKK0KLyW16zVFaNIUMPATn1C
	B+Serbh+adaC4tMr4hTcvOXh9Uw7h9kxy/YNHThWdqtSfVF3PyoCdrab/51fPvv2yW/TSb5io+q
	t/nC8sGpemVfcxD05GLxVYpvg0JumIOUG2Tczjdu9jxvQmCj5KINHz49/+KEFEf4fSSVFui5Sij
	+d42M9JFZagCxAw+KYWwWXDFrqhkb8DIb+ei/tjzc07uqHYQMORgfQOCRk8idXidXqlROBWf0qJ
	XWzMtrjD7RoYaFp6/OVMPy2ScXudefyBp4m286Cm5DrV8sp54jVAFfixxAO4Kp3ACAIJNCGHr3x
	HgLP1wecF4bsrocc0XWq4dLUAHSTme4gRtHCn4dlzMX87XM5Bg==
X-Received: by 2002:a5d:6e63:0:b0:487:27f9:841 with SMTP id ffacd0b85a97d-48e6422b40emr155868f8f.54.1793199386516;
        Wed, 28 Oct 2026 07:56:26 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:c12:cf67:f624:da42:c66:27b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3555sm28529668f8f.42.2026.10.28.07.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:56:25 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ziyang Huang <hzyitc@outlook.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v7] net: dsa: qca8k: preserve port state across MTU changes
Date: Wed, 28 Oct 2026 15:56:22 +0100
Message-ID: <20261028145622.195730-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027212505.1848-1-yongzhao.derek@gmail.com>
References: <20261022155837.760-1-yongzhao.derek@gmail.com> <179268501671.3290.6623232109527554630@kernel.org> <20261027092718.266370-1-yongzhao.derek@gmail.com> <47e9713f-815e-4caf-8928-a7ec12d0087b@lunn.ch> <20261027212505.1848-1-yongzhao.derek@gmail.com>
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

Hi Yongzhao,

On Tue, Oct 27, 2026 at 10:25:05PM +0100, Yongzhao Chen wrote:
> I will send v8 for net-next once it reopens and [2] is in net-next, and
> say in the commit message how the problem was found, as sinfo asked.

By the same rule my net series [1] belongs in net-next too: all three
were found by the AI review of my MIB statistics series, none in
production. So I will send its v2 to net-next once it reopens, with the
regmap locking patch first and unchanged, and you can base v8 on it. If
yours is ready first, carry that patch in your series instead and I
will drop it from mine.

[1] https://lore.kernel.org/netdev/20261022192933.384898-1-kuncy7@gmail.com/

Stanislaw
