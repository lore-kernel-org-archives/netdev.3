Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585F4EFFCA
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014040; cv=none; b=GMKCb2ebWJXZgkrPXjJEOodL7rwry5aBuS1jW/lY8l1SJpDiACeJ5Yl1b0SpHjc0QSVzQGZpFKqn19w18GJBVsAlaIA0FBky5ENFAvzKVYph065DDHc91GjJKgF2Rt45RylrJ66xgoibCfQ3ErsOfED6We+BPUlWPEQQaEubDfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014040; c=relaxed/simple;
	bh=yiycDcwfaOz+Sm8EcRRGpVBZcLyKYbYNoo50o6ZJm/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqJLaU6EJ/+/wX2u4RHbxS3b0OJBA42bxdQAu2glAuQ/zN4VifzMyqNNY+u4d/OHp3eTLiw64YiWb5LJWk++9hjJqnbcLdEesmT5NpUu2Xik5OSW2xuIPWSH//ixQJvaH94i9kAmUNth92U/Pnt7B9XxIOtaxmbqQl4K+IcztVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWVVVbZ+; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWVVVbZ+"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e2254dso514587b3a.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790014039; x=1790618839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fKOA7M18KxmW8QJhQbzb6dE0EVeTHlKNT1MSmHoPFuQ=;
        b=nWVVVbZ+x5kHxYt5dDgNQe1k0uzXYsyUsxQD5oinW4IeEOGUK89ze1IeKPm5hOJYAW
         i6HDGWGISqasBBliOHV/R27MiGes4g668mG4ZpIO4IvrQ96J+/ToHXSbjgHvKcCCOQAU
         88R0tkGbDVKqUa+l9smC78KfbVCrFBLbkd47A9+zVBaK1TYLsgILE+8KIIOM6Ox5AajZ
         D6RCGiBY6WACbriUNY4C8POnDh3qA29hGpl2zZPRHfqib972GPGxPz/VVc5TPQOiiBbK
         wFq+2nN++ZAZv5Y/T32hJPlpgg6KgLsf6AQXbNSHxNufoRiQre3RwXpflA6+M/3cROCZ
         35pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790014039; x=1790618839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fKOA7M18KxmW8QJhQbzb6dE0EVeTHlKNT1MSmHoPFuQ=;
        b=cKZypMIoQrsX0ApllVTdlzm+gYaLBUSNclRHZ2ZorZVeGPYQGxhUNfoU+s8fAlO0rb
         ZDLfHb8RQhC41EDUVSB1JEnegdZ07k99n1nMOcYniKONTabgtv3tKo9yfxsOm0WVZ8ZF
         bsAAnouVT+qkvO4VCEdmbkPQkcNoFf+GkiMM3sap+XVf9nfJwC4Rm0n8hMsW7Gdo/h+x
         RW9J0HBLfH/xduo7HL3lasx3szYI1EtH1mbAmFSYzq3JtV43b2NcERd7irklFyDXzbGE
         kXDypKCRayCn2ErIkuGWJPS6N0QmJuXpogHLJH0zNuQT/bDfMBnbnFjndNHkvUL+hzM/
         JJwA==
X-Gm-Message-State: AFuF++nmPZt9SIXBNvLZ/z6u5wEkhgyBHf8tH62frupHtsjDxez8dHBU
	+XO7niAm1wgW/KfaA2F4D9+LdquGM+QTCwqepbSdVKUUFkvW4Wj0dP+v
X-Gm-Gg: AYBFou1pEfb81HYzQa5jtu0aXEcIeuksjijVhtRfxIQ5KZzSG5loKXDyJXrsA3iGFvN
	MRMiWk8ND/pFG852NZfG7rGz908Z66EUpsaGd3hdjoKLtnZCbqk9osSr4K+g9zLmcK3eDIBX014
	KfLlzB3NFZbxmjYzddyxHHbtBLyvbxah7TgVdoIEdnvazCeTvxHz4sBhHsSkFYyAhdwu9A/rnyP
	cQlOYwNT5Ev1DO5CKcFkhF+Spvu7AOgF87Ld1A46R+M+Z3dmaCYsDb6x8qZQFdubkRGWUjfEwZV
	n5D2reGV9nfy1diCAOhal5ybZc2vu48vKECnaUCiBih06z9OdSzE0jok219nzpIGPQ4ABVZhut7
	qmA6eg3GV8EojHAPztGMuZPJrdPznV24466PIyXYAvDpCNzPlY0bJjfjBS/uuChcgJa01xAXPso
	DCvz2NaH21YCd4jvfBo2jP+0kRpCRyqbu9AE+hD++gl1LhQ20S3U6AyZJRJHmvCLrxcZjAoQ==
X-Received: by 2002:a05:6a00:1798:b0:87a:1251:e58c with SMTP id d2e1a72fcca58-87bbbb7ab45mr311256b3a.0.1790014038758;
        Mon, 21 Sep 2026 11:07:18 -0700 (PDT)
Received: from localhost ([101.126.44.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a8ef591asm3645451b3a.9.2026.09.21.11.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:07:18 -0700 (PDT)
From: Dairui Zhang <zhangdairui@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	David Wei <dw@davidwei.uk>,
	Dairui Zhang <zhangdairui@gmail.com>
Subject: Re: [BUG] net: devmem: NETDEV_CMD_BIND_TX has no permission check and no accounting
Date: Tue, 22 Sep 2026 02:07:15 +0800
Message-ID: <20260921180715.1411780-1-zhangdairui@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920174727.1332115-1-zhangdairui@gmail.com>
References: <20260920174727.1332115-1-zhangdairui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mina Almasry wrote:
> bind-tx is meant to be privileged.
> 
> I hope to add a comment in the code this week. We get this suggestion
> quite often now :D

Thanks for the quick answer. Want me to send the patch adding
GENL_UNS_ADMIN_PERM to NETDEV_CMD_BIND_TX (same level as bind-rx),
or would you rather fold it into your own change?

Separate from the permission bit: even a privileged caller can
exhaust memory right now, since binds aren't accounted (GFP_KERNEL,
devmem.c:207) and the same dmabuf fd can be bound over and over.
Is it worth adding GFP_KERNEL_ACCOUNT plus a per-binding cap or fd
dedup? Happy to send patches for either.

Thanks,
Dairui Zhang
