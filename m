Received: from mail-lr2-f21.google.com (mail-lr2-f21.google.com [74.125.230.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59A644E038
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594121; cv=pass; b=L6UroVuwgM1FIp6iZ9QAYAZIK5ElEQmE+BEu5Lh6MBqos2Kgi/8G6tK48neR/bY2uZgsQEbzEpUQFdr6qhSFvK/BjXxBPH26R6KXv9g4arNRjm0qUS66GlbW8FXgigxmJP4/xFPZt/Uepykvc4unDRPMGqE26ghsMJCC4n52wfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594121; c=relaxed/simple;
	bh=996CJFGuNyyYmh+etTTKX/Yy7liiXJyv4mmrH7M/AkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRiE6BV0cMJ+xSL8Akjjvwcgr2zV5Dee6XIWx0AC/5KOMMWCm2y8n4JlpdV+etQxS3YITYPF/8R36zRBXfx/Xt7vdg9MblHpd15fEqblxLMU8VFUsMnPHWXYUbP6ptE1Bf3bDOArSqKE49ZzPY23jU5VwAu66IFf3BkcLBWY4lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsr3Y6Rh; arc=pass smtp.client-ip=74.125.230.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsr3Y6Rh"
Received: by mail-lr2-f21.google.com with SMTP id 38308e7fff4ca-3a2ff148dfdso21427441fa.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790594117; cv=none;
        d=google.com; s=arc-20260327;
        b=pQZ2QvHdGhIAJopdygBdiMbHRL2pfDe/W0hylqxa8EAv9KmlOmdz4aG/TAtAngl5Hk
         ycYvcGgOtyeHyuu+wErC5ftqY0FjBJDT2ERqXAwWiuQl9ByhvX7+0Iyaemr/gHCnMEok
         SFGB+48YZB/WjP2KsqiWJjiSyX+my/06J+p4Mie4mIMusLwxeJg7wbACNB7LOMx8UX+f
         nZDEGz3FCQqw9f0sRGggIdRTHmdOUAS5kBeFfEMMK1oCtpmTkBIvO9BNvId9vJX80ylY
         FABDj9lkbfPmXofCr0zSaTHM/2UFweN5e+KrA23LryUFhBmRP4uTtraIjmltTWMj1+h3
         buqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f5LqEIqTiSCGzIitZ1w2oEpzfNZEyI+MHlv8nCt0Pvc=;
        fh=PZ0p/gDljSmdIh5ZZk5C1Bbhx1/fgmpyiTLCVchNMzk=;
        b=MtEQDLe/jp2sYoXE9S4NBl7Y3xROpS1T5wVwHVKpZ5c6aX/VazPDqy82cgn1CUV4IM
         c9K1DgwUtxRI99U1/Z2nPlcsFf32VtNG1mzbZ8fZ791WU5jQzvmiiCs+aENcDmCcZDgP
         bjyBgBhYzCoPEnj5ytJd2YDAr8t7vhBrwwgL9bqBV0N94cBDv3doZhdNOaldlNTnn3+e
         U//RUVXD0iRKVnKtiSqKGYTWi4VLvXDT7GE5cnfMHyF4YWyJ9O6WPAZPOfqUEvH/7ArN
         tYewMeJpSRU1/PpUXfpNrlLAt9QOfyKex9keBrWQKIeAeKO2Huy0YEMp96cp7xOhTH7Y
         nWFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790594117; x=1791198917; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f5LqEIqTiSCGzIitZ1w2oEpzfNZEyI+MHlv8nCt0Pvc=;
        b=dsr3Y6RhGt5ckmJWs18u/WIlDPBUOG+qdLYQlzy/Tuxl5qPDtGrxaFVPme/xMH1Sz3
         /QJgssQakPA+CwyHRgfG+koUgrgGZ30gkzYKnGGSx5FCu30vd4+gsiPZrKCenSEwpht4
         CdBXU9uMXMe5vS4So656J1/Ej5VS1pg+TBujLVgQqcWhjtvKAzKLtgXVblofHzNdO38x
         tOTcNn+9AYCB4KiHUaayJVqNWX5mNK9tKgqzqYbf13wTQjogkaoCRJlppidUHSNge2ub
         w5ybfg7jng3cq3AOhQmeCRvrhy6nDYwlFHadSf1ldsL/uUKU+jPzfWtR39nOH4r8jH5n
         7fig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790594117; x=1791198917;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f5LqEIqTiSCGzIitZ1w2oEpzfNZEyI+MHlv8nCt0Pvc=;
        b=D29c4iXS4L0Ba8Ay1JMicmJNNEKbJ+BJI5bSPYQh6/RsqTiIP7BWv4SiIbkqDhkSaB
         oCdr72CtwHWvZHgFOZP4VUrW8exmX5olhqjxgHgxA1E999n/dvFUrxpvVmvTbCU1hrn4
         xTMGlcoB16ZLmzyPoOUzWtl+oUXO4Z2Sl3anE3lNkyuYViouTDazI30qDIiOHNppeOxb
         U8y9Bt1ZzC0reGYyXz7Yr2cZalI/TvLE3v3gLQL8i2C924nHOaMIWEPNY254bo2ehv73
         N/4OrHzcJV9IesBv5dF53OzeuWUlXklbp/xHNuZm0iM9ddbQIJnlUak3dhlGwCnyLnM4
         drXw==
X-Forwarded-Encrypted: i=1; AKwUvBzzYxBmak70ueKcIO5dQd+VKCqFUYQJxWP05HauLQ942gJTf7/LkzTfUxrvGKbD/dKV+A91lxw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaiM+zYHjKeQGCRMN/Yj+O9QRZfCV7rHlEdEH/ieqh3chQFcf+
	yGbzYD3xRR7xgOAlKy9dg3wgkDNhooZlwvYx6S2baxQoWAhGsAN0g7TtnK6EOPnx53qRWMJp2VD
	OmUx4SZsJyH7NU3nYDuMaru478693s4g=
X-Gm-Gg: AYBFou1K73uCmNzCmRIJ59bdto4Ku3rB+910vHfGV85DQy/hpjZ7Dwumyh/vj0rmea+
	fTWYapWX1ZZokQARQcHEWbW798Fz05gv3s9AuiRgPr138boE8Ty9WrrmjbRpIZ2pZcANxk7vWpF
	AE5+/zVg2+v57nNlw0XnjTPy5s0SZpBIbqyG8w1jEm5Dpt3BAKfcESotlLIrWMQG2UhvK9VkaFW
	tXOu83HbDkj+rrx1dTGkBeGwCTOz2tCt1iWs4gT1GERBbUD2VNW0pez76vMbbvaPFxMjyEE9k3e
	bJt1BAD7Bjw7EO4hGPWOZeHAKJEgXRiSSz24ih9IIGTcXwJLWvFQiYNh8EFHFREpUZk0bnuYWGb
	nYm1maYurlvanyCvq774bOEWwqUbZBhcUPZ25SU90bw==
X-Received: by 2002:a05:6512:acb:b0:5b8:f0c6:1fc9 with SMTP id
 2adb3069b0e04-5b8f0c61fd6mr2364641e87.31.1790594116310; Mon, 28 Sep 2026
 04:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927002427.4519-1-sigefriedhyy@gmail.com> <20260927002427.4519-3-sigefriedhyy@gmail.com>
 <cd00e6e7-aa2d-4f98-8a79-083b64b3376a@6wind.com>
In-Reply-To: <cd00e6e7-aa2d-4f98-8a79-083b64b3376a@6wind.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Mon, 28 Sep 2026 20:15:07 +0900
X-Gm-Features: AclHuK9zsH1UrBsZg6xhnYP09aN47Nn_F68KRxkDz53E_55Atdfu33i4Naok4Ag
Message-ID: <CA+7S2v+kVVANjV4y5+YUBiRPcOfqhTXDxd8czaOY_cYYJYzfAQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 2/5] net: add a generation counter for dev->mc changes
To: nicolas.dichtel@6wind.com
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> If another version is needed, you can rename counter to _counter to highlight
> that the helpers should be used.
> static void __hw_addr_count_add(struct netdev_hw_addr_list *list, int value)
> Renaming  struct netdev_hw_addr_list->count to _count would help to check all
> users and highlight that modifying _count should be done with helpers.

Thanks, those suggestions make sense. I will adjust these in v9 if
another version is needed.
