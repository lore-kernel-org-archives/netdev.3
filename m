Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6123939A4
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790539854; cv=none; b=F8eC2N/xnuYZEnLRdrbTIETYyVe0/FG1Vp5GEQ3F9J0sENh33I8N2avFSh5j/YY0MyOR75OoBc3NDiPW+AshavGMyZsERisaADyJxj8ZWWkPEo/eluYtXYtmSS20em4gEXTVZlAmYe2cdtusWYCdVRQ6R79Yx40qXOsefUwD3Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790539854; c=relaxed/simple;
	bh=Xp96osNKNV73rMrH2Cx3GnQRPM4ktS3CCX6WmIYhStg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6AWtCE9eeNX7zvSlOtcgtevLARk0vZGt5PHD3bZwCIsPnihCdV2zsqWzdmo02rfCKq0iA5E3MmCldrlxIwapgKgz11/fkdZyzfKkUXUEFwPbeLvyGc3lLgM51Ea8cnj0OMj2FnBF7YVPJLkNJCZtoKR5Yg96XSXRGF/bwyIB7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gii5ibXB; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gii5ibXB"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so1522141a91.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790539852; x=1791144652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xp96osNKNV73rMrH2Cx3GnQRPM4ktS3CCX6WmIYhStg=;
        b=gii5ibXBpyZBJ2bcqly6aeiJ2et/6M7GESKSIvioii8WTM/pHZugMGgsNbsWegbX+o
         N+/Q7WhZbKokZCjUBdVbc7G0PbWnJEtOzz9sf4E3ESfGhUy2ELqebyKZpoBbutcT9Dfn
         a0Z88btcv3I5sU22Dzvvk0PVmfI9rrtPtbO8HF7UqXv0x50mR4TI6izsFebzDdBe2+SX
         9mJrx2iM418l4DOqVTUqbSscyzVDXo87Zi5bxh8ebNCOufQPKND+aWhuwqrpweiEWXka
         xnjAhSa8WraUMZfaakAi1nk5wIii39Rxz+RF3OI79LUxqM+K14Ap1R5xa74kLTqYU5WJ
         zy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790539852; x=1791144652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xp96osNKNV73rMrH2Cx3GnQRPM4ktS3CCX6WmIYhStg=;
        b=bojQSyiT7Q11lzrGip8saim6X1PNBE6LnBdYBt55B0TeIH7ct0F4dUcgAxn2a1uwIC
         WxtFLm5J3tUyOLHCHqc3rehf4/xQdQhVgZupkFInaGX6SmwfYxWFwrNN9yKC1I4gfbnk
         KXRR9MwW4+lj1or1sc0ou1bHWun/fTTqyQg63xSg1VViIfL+LZQ4E+97YynvgKIgpr2E
         rU85i2xfsmi39sFSAAsjI05j7VZy3OcDKPASoqI5Gq+BIslaO1tvamcrnJnDdtcsovsb
         8H5Gy64FoyUsgSSA5gyWpQ5KBshCwCKLopQFbzaHXgOn6Qof4vpz3+2A5n4YgIKA0LnQ
         a45g==
X-Forwarded-Encrypted: i=1; AKwUvBy6swraQxpCjS0Yx94UAIXeG+pqDUi2/sh/Pnbr36LYNc5f80CZFe00f/d5bN8IEXmit7tglbw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPAJkgc4By7kNHiegLtRsp6GM6c/YPXHpCs77VP7fwbslWmIkg
	mjGHUYRiRwCdFxuO3rWFVHKD0Ecx0cTb7494PzN0nlXYvY9vT/uLmIMk
X-Gm-Gg: AYBFou1P1UeSJUzcAE7Yap4xQIS+m9antnMpgy69knGfU3GS0BCQeOBATWjRUn7N1he
	ccpPb85XlIh59FzVMczylK/t5GfHZAwXuPJzktYTomM2Hb/m3owHKyQ2jAF58eTOK377VdFFNOC
	wPzYNSiiZkrFdZHGrWs0OFbCL3C9LmXnS/AwMp+DJenrtdPCzfNZdPoZW9W85K/rcDcHtL9a9YF
	0F9aq7Sq2p20zyK73CGTEpAnnhfWiBZGb4DhuzSmstXQvP7LyhHunOjdYUuNmpRX2Cicj4k/300
	N6WGMsgcGGdoPDWjXQVSUtpXTZeRp/8RMJEQMXSnSruhrt3FEQBGgD+e+OxbWULkfDmAwDvUGJw
	7yjo9zSFxHGMaDC4XK7zyQa8ITV6vGjRUPf1mYljSfhq+nl2kcywmu+nl21WJ4I30q1nKm6HOlj
	UzMJs70lG+qKmeP/az4xtBGFS3XVP+Me27YttkFOLXLutRETLhXzO2aS7SFdW3iQY=
X-Received: by 2002:a17:90a:d883:b0:3a0:2900:f577 with SMTP id 98e67ed59e1d1-3a098dff5b4mr8692462a91.51.1790539852500;
        Sun, 27 Sep 2026 13:10:52 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::a891])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b498fb12sm6710494a91.0.2026.09.27.13.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 13:10:51 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	nicoyip.dev@gmail.com,
	willemb@google.com,
	alice.kernel@fastmail.im,
	rdunlap@infradead.org,
	marsy12010123@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ivy Lopez <skunkolee@gmail.com>
Subject: Re: [PATCH net-next v2] net: pktgen: return bool from __pktgen_NN_threads()
Date: Sun, 27 Sep 2026 14:10:45 -0600
Message-ID: <20260927201045.241108-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260927135406.3969970-1-nicoyip.dev@gmail.com>
References: <20260927135406.3969970-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reviewed-by: Ivy Lopez <skunkolee@gmail.com>

